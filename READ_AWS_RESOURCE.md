# AWS Terraformリソース一覧

## 🌐 ネットワーキング

### VPC関連
* **aws_vpc.main**: メインVPC（CIDR: 10.0.0.0/16）
* **aws_internet_gateway.main**: インターネットゲートウェイ
* **aws_subnet.public[0]**: パブリックサブネット1（10.0.1.0/24）
* **aws_subnet.public[1]**: パブリックサブネット2（10.0.2.0/24）
* **aws_subnet.private[0]**: プライベートサブネット1（10.0.10.0/24）
* **aws_subnet.private[1]**: プライベートサブネット2（10.0.11.0/24）

### NAT・ルーティング
* **aws_eip.nat**: NAT Gateway用Elastic IP
* **aws_nat_gateway.main**: NAT Gateway（パブリックサブネット1）
* **aws_route_table.public**: パブリック用ルートテーブル
* **aws_route_table.private[0]**: プライベート用ルートテーブル1
* **aws_route_table.private[1]**: プライベート用ルートテーブル2
* **aws_route_table_association.public[0]**: パブリックサブネット1のアソシエーション
* **aws_route_table_association.public[1]**: パブリックサブネット2のアソシエーション
* **aws_route_table_association.private[0]**: プライベートサブネット1のアソシエーション
* **aws_route_table_association.private[1]**: プライベートサブネット2のアソシエーション

## 🔒 セキュリティ

### セキュリティグループ
* **aws_security_group.alb**: ALB用セキュリティグループ（HTTP/HTTPS許可）
* **aws_security_group.ecs_tasks**: ECS Fargate用セキュリティグループ（ポート3000許可）
* **aws_security_group.rds**: RDS用セキュリティグループ（PostgreSQL許可）

## 🗄️ データベース

### RDS関連
* **aws_db_subnet_group.main**: RDS用サブネットグループ
* **aws_db_parameter_group.main**: PostgreSQL用パラメータグループ
* **aws_db_instance.main**: PostgreSQL RDSインスタンス（db.t3.micro）

## 📦 パラメータストア

### 環境変数管理
* **aws_ssm_parameter.db_host**: データベースホスト
* **aws_ssm_parameter.db_port**: データベースポート
* **aws_ssm_parameter.db_name**: データベース名
* **aws_ssm_parameter.db_username**: データベースユーザー名（暗号化）
* **aws_ssm_parameter.db_password**: データベースパスワード（暗号化）
* **aws_ssm_parameter.rails_env**: Rails環境設定
* **aws_ssm_parameter.rails_master_key**: Railsマスターキー（暗号化）
* **aws_ssm_parameter.secret_key_base**: Rails秘密鍵ベース（暗号化）
* **aws_ssm_parameter.cors_origins**: CORS設定

## 🌍 DNS・SSL

### Certificate Manager・Route53
* **aws_route53_zone.main**: Route53ホストゾーン
* **aws_acm_certificate.main**: SSL証明書（ワイルドカード証明書含む）
* **aws_route53_record.cert_validation**: SSL証明書のDNS検証レコード
* **aws_acm_certificate_validation.main**: SSL証明書検証リソース
* **aws_route53_record.main**: APIのDNSレコード（Aレコード）

## ⚖️ ロードバランサー

### ALB関連
* **aws_lb.main**: Application Load Balancer
* **aws_lb_target_group.main**: ターゲットグループ（ポート3000、ヘルスチェック：/health）
* **aws_lb_listener.http**: HTTPリスナー（HTTPS リダイレクト）
* **aws_lb_listener.https**: HTTPSリスナー（SSL終端）

## 🐳 コンテナ・コンピューティング

### ECS関連
* **aws_ecs_cluster.main**: ECSクラスター（ECS Exec設定含む）
* **aws_ecr_repository.app**: ECRリポジトリ（Dockerイメージ保存、脆弱性スキャン有効）
* **aws_ecs_task_definition.main**: ECSタスク定義（CPU: 256, Memory: 512MB, ARM64アーキテクチャ）
* **aws_ecs_service.main**: ECSサービス（desired_count: 1）- `desired_count`: ECSサービスが自動的にこの数のタスクを維持しようとします

### IAM・権限
* **aws_iam_role.ecs_task_execution_role**: ECSタスク実行ロール
* **aws_iam_role_policy_attachment.ecs_task_execution_role_policy**: 標準ECS実行ポリシーのアタッチ
* **aws_iam_role_policy.ecs_task_execution_role_ssm_policy**: Parameter Store アクセス用カスタムポリシー
* **aws_iam_role.ecs_task_role**: ECSタスクロール

## 📊 監視・ログ

### CloudWatch
* **aws_cloudwatch_log_group.ecs**: ECS用CloudWatchロググループ（保持期間: 7日）

## 📋 データソース（参照のみ）

### 外部データ取得
* **data.aws_availability_zones.available**: 利用可能なアベイラビリティゾーン情報
* **locals.availability_zones**: 使用するアベイラビリティゾーン（ap-northeast-1a, ap-northeast-1c）

## 📊 合計リソース数

* **作成されるリソース**: 約37個（ECSサービス除く）
* **参照されるデータソース**: 1個
* **ローカル値**: 1個
* **合計管理対象**: 39個

## 💰 主要な課金対象リソース

### 継続課金
* **ECS Fargate**: CPU/Memory使用時間（ARM64アーキテクチャ）
* **RDS**: インスタンス稼働時間
* **ALB**: 稼働時間 + 処理されたデータ量
* **NAT Gateway**: 稼働時間 + 処理されたデータ量（1個のみ）
* **Elastic IP**: 1個の固定IP
* **Route53**: ホストゾーン維持 + DNSクエリ数

### 従量課金
* **CloudWatch Logs**: ログ保存量
* **ECR**: イメージ保存量
* **Parameter Store**: 暗号化パラメータ数