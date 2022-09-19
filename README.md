# Terraform sample for Webhosting on AWS

 Terrform 示例模版，在 AWS 上部署一套简单的 Webhosting 架构，具体如下图：

![Architecture](/Architecture/Terraform-webhosting.png)


示例模版包括：
 - **main.tf:**  主模版文件，包含所有需要部署的资源
 - **variables.tf:**  预定义变量，并声明了多个Credential Profile，通过在 main.tf 中切换 Profile，可部署到不同的 AWS 环境中
 - **Install_nginx.sh:**  EC2 启动的 User Data 脚本
 - **outputs.tf:**  定义 terraform 部署完成后需要输出的结果，比如 ALB 的 URL
 - **terraform.tfvars:** 可用于覆盖 variables.tf 中声明的变量赋值
  
       
## 执行 Terraform:
 
1. 初始化 Terraform 模版，准备相应的 Provider
```
terraform init
```

2. 查看将会部署或者修改哪些资源 
```
terraform plan
```

3. 执行部署，部署完成后将会输出 outputs.tf 中定义的参数
```
terraform apply (--auto-approve)
```
部署的状态将会保存在 terraform.tfstate 文件中


4. 删除模版中所有已部署的资源
```
terraform destroy
```

## 基于 CodePipeline 和 CodeDeploy 实现 IaC 自动化:

该模版可借助 CodePipeline 自动监控 Github Repo的事件，自动化调度 IaC 的资源部署和管理流程，在 CodeDeploy 中执行 Terraform 命令对资源进行部署和修改。
以下为 CodeDeploy 执行的命令。

```
version: 0.2

phases:

  install:
    commands:
      # for Amazon Linux build runtime
      - sudo yum install -y yum-utils
      - sudo yum-config-manager --add-repo https://rpm.releases.hashicorp.com/AmazonLinux/hashicorp.repo
      - sudo yum -y install terraform
  pre_build:
    commands:
      - terraform init

  build:
    commands:
      - terraform apply -auto-approve
      # - terraform destroy -auto-approve

  post_build:
    commands:
      - echo terraform apply completed on $(date)
      # - echo terraform destroy completed on $(date)
```
