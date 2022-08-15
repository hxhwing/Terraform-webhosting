# Terraform sample for Webhosting on AWS

 Terrform 示例模版，在 AWS 上部署一套简单的 Webhosting 架构，具体如下图：

![Architecture](/Architectures/Terraform-webhosting.png)


示例模版包括：
 - main.tf:  主模版文件，包含所有需要部署的资源
 - variables.tf:  预定义变量，并声明了多个Credential Profile，通过在 main.tf 中切换 Profile，可部署到不同的 AWS 环境中
 - Install_nginx.sh:  EC2 启动的 User Data 脚本
 - outputs.tf:  定义 terraform 部署完成后需要输出的结果，比如 ALB 的 URL
 - terraform.tfvars: 可用于覆盖 variables.tf 中声明的变量赋值
  
       
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