# learn-terraform

Terraform is a very powerful Infrastructure As A Code Tool which can be managed via HCL ( Hashicorp Language )

> Points to be noted when dealing terraform!!!
    1) Terraform only recognized the files ending with *.tf or *.auto.tfvars or *.tfvars as the terraform files 
    2) We can either write all the terraform code in a single file or in multiple-files. 
    3) Terraform loads these files in the alphabetical order and compiles them in a logical approach.
    4) Terraform is all about blocks  { }

> In terraform, we typically use these 4 commands:  

    1) terraform init 
    2) terrform plan 
    3) terraform apply
    4) terraform destroy

> How to install terraform ?
    `https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli#install-terraform`
    
> Unline ansible/yaml, HCL Terraform is not indendation specific. But for look and feel, we make sure to follow the standard spacing

How EC2 instance can authorize to AWS Cloud and provision resources ?
    1) We will provision an IAM Role for EC2 service
    2) Then assign the needed roles to the provisioned IAM Roles ( Full Access )
    3) We are going to attach this to WS / Jenkins 
    
    From now, your WS will have needed authorization to AWS Cloud.

> Terraform Rule Of Thumb:
    1) If you're using terraform, you need to align provision / update / maintain everything through terraform only.
    2) Manual changes should not be tolerated.
    3) Even if someone does some changes manaully on a terraform provisioned resource, we need to import to terraform. 

> What is terraform drift ?
    1) When a resource is managed by terraform, if you wish to do the changes to that we only do it via tf code
    2) Doing changes directly from the console, will cause difference in what we have on code vs what is the current from
    3) This causes drift.

> Is terraform apply disruptive or destructive or concurrent? 
    1) Based on the type of change
    2) If you're changing tags or changeing roles, it's happens without any downtime
    3) If you're changing instance_type, it's disruptive, involves downtime.
    4) If you're changing the ami, then it's destructive and then it creates.