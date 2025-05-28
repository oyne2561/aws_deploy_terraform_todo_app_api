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


## リソースの削除手順

```
tf destory
```