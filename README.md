## 環境構築

`~/.zshrc`ファイルに`alias tf='terraform'`を記載する。

`~/.aws/credentials`ファイルを編集。以下は例。
```
[default]
aws_access_key_id = your-access-key
aws_secret_access_key = your-secret-key

[production]
aws_access_key_id = prod-access-key
aws_secret_access_key = prod-secret-key
```

`~/.aws/config`も同様。
```
[default]
region = ap-northeast-1

[profile production]
region = ap-northeast-1
```
terraform用の設定ファイルは特になし。

### コマンド
```
tf init
```

検索で`TODO`を入力し、確認後、対応する。

```
tf plan
```

以下の警告が表示される。
```
Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly these actions if you run "terraform apply" now.
```

推奨される使い方
```
# 1. プランを作成して保存
terraform plan -out=tfplan

# 2. 内容を確認
terraform show tfplan

# 3. 保存されたプランを適用
terraform apply tfplan
```

以下のようなログになったら Control + C でキャンセルする。ACMのステータスが保留中から切り替わるのを待つ。(時間がかかる)
```
aws_acm_certificate_validation.main: Still creating... [7m10s elapsed]
aws_acm_certificate_validation.main: Still creating... [7m20s elapsed]
aws_acm_certificate_validation.main: Still creating... [7m30s elapsed]
aws_acm_certificate_validation.main: Still creating... [7m40s elapsed]
```
ここでムームードメインのコンソールに行き、Route53のホストゾーンのNSレコードの4つをネームサーバに登録する。これをしないとおそらく証明書が有効にならない。


再度、Applyする
```
terraform plan -out=tfplan

terraform apply tfplan
```

ECRにDockerImageをPushする。
```
aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin 0649363938393316.dkr.ecr.ap-northeast-1.amazonaws.com

docker build -f Dockerfile.prod -t todo-app-api .

docker tag todo-app-api-api:latest 0649363938393316.dkr.ecr.ap-northeast-1.amazonaws.com/todo-app-api-api:latest
docker push 0649363938393316.dkr.ecr.ap-northeast-1.amazonaws.com/todo-app-api:latest
```

ecs.tfの以下の行のコメントを外す。
```
# # TODO ECRにDocker imageをpushしないとタスクが落ち続けるので、2回目のApply時にコメントを解除する。
# # ECS サービス
# resource "aws_ecs_service" "main" {
#   name            = "${var.app_name}-service"
#   cluster         = aws_ecs_cluster.main.id
#   task_definition = aws_ecs_task_definition.main.arn
#   desired_count   = 2
#   launch_type     = "FARGATE"

#   network_configuration {
#     security_groups  = [aws_security_group.ecs_tasks.id]
#     subnets          = aws_subnet.public[*].id
#     assign_public_ip = true
#   }

#   load_balancer {
#     target_group_arn = aws_lb_target_group.main.arn
#     container_name   = "${var.app_name}-api"
#     container_port   = 3000
#   }

#   depends_on = [
#     aws_lb_listener.https,
#     aws_iam_role_policy_attachment.ecs_task_execution_role_policy
#   ]

#   tags = {
#     Name = "${var.app_name}-service"
#   }
# }
```

パラメータストアに行き、`RAILS_MASTER_KEY`と`SECRET_KEY_BASE`を正しい値に置き換える

再度、Applyする
```
terraform plan -out=tfplan

terraform apply tfplan
```


## リソースの削除手順

```
tf destroy
```

## その他コマンド
format整形
```
tf fmt
```