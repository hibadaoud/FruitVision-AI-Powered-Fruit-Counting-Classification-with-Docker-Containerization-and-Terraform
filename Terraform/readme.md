## Before running terraform plan/apply
In order to authenticate the terraform to your Azure Account, you should install "az cli" in your local machine and than run 
```
az login
```
..
After that, in order to ssh to your VM instance, you should generate ssh id_rsa key-pair and set the value of id_rsa.pub to the environment variable.
For that you need to generate id_rsa key-pair (if you have not already that):
```
$ ssh-keygen
```
You can tape enter enter until generating the id_rsa key-pair. And then , execute this command to set the environment variable
```
Linux:
$ export TF_VAR_ssh_public_key="$(cat ~/.ssh/id_rsa.pub)"

Windows: 
$env:TF_VAR_ssh_public_key = Get-Content -Raw -Path "C:\Users\Farah Elloumi\.ssh\id_rsa.pub"
```
In variables.tf change your adress ip there to permit the access.
```
```
## Run terraform init
## Run terraform apply
## After running terraform plan/apply
In order to ssh to the ec2 instance(s) created, execute the following (replace ec2_instance_public_IP_or_DNS with the value of instance_public_ip or instance_dns you found in the output of terraform apply ):
```
ssh -i ~/.ssh/id_rsa adminuser@<instance_public_ip>
```