# learn-terraform

<!-- NFR -->
Non-Functional Requirements ( NFR )
    > Code Should Be Dry.
    > Credentials should not be hardcoded.
    > Re-run of the script should not fail.
    > Code should be multi-environment compatible.

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

> Speak more about: argument vs attribute

> Variables in terraform: 
    This is the most interesting and tricky concept that's going to make code dry and parameterize the code: 

    # Supported datatypes in terraform
        # 1) Numbers  - No need to enclose them in quotes
        # 2) Boolents - No need to enclose them in quotes
        # 3) Strings - Need to enclose them in quotes ( Only double quotes. )

        Note: 
            In terraform, there is no concept of single quotes.

> Variables are of 3 types: 
    1) Regular variable, a key with a single value. 
    2) List variable, a key with multiple values.
    3) Map variable, a key with multiple key value pairds

```
    var.sample    : use this only if this is not in between a set of strings 
    ${var.sample} : use this if your varaible has to be enclosed in a set of strings
```

> Outputs:
    1) They play an important role in terraform
    2) Outputs are used to print something
    3) They are also used to share the information between terraform modules.

Naming Standards:
    1) Either use lowerCase letters with _ or - only
    2) follow camelCase 


What is terraform.tfvars ?
    > This is a file that holds all the default values that needs to be used irrespective of the environment.
    > When you delcare the variable values in this file, you don't have to explicitly mention this file as terraform picks "terraform.tfvars" by default
    > When you declare some value in dev.tfvars, qa.tfvars, prod.tfvars, then while running terraform commands, we need to mention that file

How to run a tf command that has xyz.tfvas,
    $ terraform init ; terraform plan --var-file=dev.tfvars 

How to run a tf command that has xyz.tfvas & cli varaibles,
    $ terraform init ; terraform plan --var-file=dev.tfvars  -var environment=cli

Variable Priority ?
    cliVariables > ***.tfvars > terraform.tfvars > terraform.auto.tfvars

IMP Points to consider: 
> When you use count, you'd be using "count.index"
> If you're using for_each, you'd get  each.key , each.value 

> When we learn anything, we keep on applying the 4 principles 

```
    1) Conditions 
    2) Variables
    3) Functions 
    4) Loops 
```

Modules In Terraform:   
    1) They help in keeping code DRY 
    2) And at the same time, code can be re-used. 

Modules In Terraform are of 2 types: 
    1) Terraform registry modules ( readdily available )
    2) Bulding your own modules

`Terraform init is going to do 3 things`
    1) Initialized the `backend`
    2) Downloads the needed plugings
    3) Initializes the modules

Modules:    
    1) Root Modules : From where you run the terraform commands
    2) Child Module: The actual code 

    Passing information between 2 child modules, cannot be done directly. It would be through root module

        "x-module ---> RootModule ---> y-module"
    Information from x-module to y-module would be done via rootModule in the form of outputs.

    OUTPUT's play a very important role in passing the information between 2 modules.


    > The Root Module
        Every Terraform configuration has at least one module, known as its root module, which consists of the resources defined in the .tf files in the main working directory.

    > Child Modules
        A Terraform module (usually the root module of a configuration) can call other modules to include their resources into the configuration. A module that has been called by another module is often referred to as a child module.

        Child modules can be called multiple times within the same configuration, and multiple configurations can use the same child module.


> When using variables in modules:

    Ensure you declare that the same empty variable as well in the module we are calling.

    Rule of thumb, if you're using a variable in root module, that empty variable has to be declared in the child module, before you use and that where the data-transfer will happen. ( that's a way of receiving the data from the root module )

        1) Declare the variable in the root module
        2) Define the value for that in the root module
        3) Declare empty variable with the same name 
        4) Then use it in the backend module

> How to retrieve the info from backend module to the root ? 
    And that's where output comes up from.
        1) Declare the needed item to be passed to root or another module as output and then supply as an input
    
> Argument vs Attrubute In terraform

    Argument:
        1) Properties needed to provision resource ( like instance_type, disk_size)
    
    Attributes:
        1) Properties that comes up after the provisioning of resources ( Like private_ip, instance_id, arn )

> Datasource: 
        
        1) Datasource helps in querying the information that's already available 

> Provisioners In Terraform:

        1) Local Provisioner      : When you want some action to be performed on the machine you're running terraform, then we use local provisioner
        2) Remote Provisoner      : When you want some action to be performed on the you're provisioned, then we use remote provisioner
        3) Connection Provisioner : To perform some action on the top of the newly provisoned machine, you need to enable a connection and that can be done via connection-provisioner
            > Note: 
                * Provisioners should always be with in the resource.
                * Provisioners are always create time provisioners, that means they will only be executed on the resource during the creation time only. And when you run this for the second time, provisioners won't be executed.
                * To make it run all the time, we can use triggers  
              
> What is terraform state ?
```
    Terraform state is a file that keeps track of the infrastructure Terraform manages. 
    It records resource attributes, dependencies, and metadata. 
    Terraform uses this state to determine changes needed when applying configurations. 
    The state file can be stored locally or remotely for collaboration. 
    Managing state properly is crucial to avoid conflicts and unintended changes.
```

> When you're running Terraform Plan, what exactly is happening ?
```
    1) Terraform reads what properties are there for the xyz resources from the state file
    2) Terraform compiles the *.tf files and then it also validates whether what we have on the code vs what is there on the state file vs what is there on the provisioned infrastructure
    3) If there is a change, terraform consider what is there on the CODE as the source of truth.
```

> If you lost the state file, what will happen ?

    ``` 1) Terraform loses track of evertying and technically it's bad event ```

> Organizing staefile !!!!

```
        What will happen if you store the statefile locally on your machine ?

            1) If you store the Terraform state file (terraform.tfstate) locally, the following will happen:

            2) Limited Collaboration – Other team members won’t have access to the latest state, leading to potential conflicts.

            3) Risk of Loss – If the local machine crashes or the file is accidentally deleted, the state is lost.

            4) Security Concerns – Sensitive data (like credentials or secrets) may be stored in the state file, posing a security risk if not encrypted.
            5) Manual Backups Required – You’ll need to manually back up the state file to prevent data loss.

                    Locks Not Available – Without remote state locking (like in Terraform Cloud or S3 + DynamoDB), multiple users running Terraform at the same time may cause conflicts.
```

> We should also have a strategy to organize the state in a secure and reliable approach
```
    1) If you're using opensource terraform and on AWS, we can organize them on S3 Buckets
    2) Make sure, we use Enryption Keys to enrypt the data on S3 bucket
    3) Also ensure, very limited ppl have write access to the bucket 
    4) Ensure verisoning is enabled on S3.
```

> When you have multiple environments, then organizing state is very important. 
    `We can supply the backend config in separate files , refer 12-remote-state-multi-env/`

> What Terraform Init Does ?
```
    1) Initialize the backed
    2) Initialize the plugins
    3) Initialize the modules 
```

> How to initialize the terraform code that has backend's config define in a separate file
```
    $ terraform init  -backend-config=env-dev/state.tfvars -var-file=env-dev/main.tfvars; 
    $ terraform plan -var-file=env-dev/main.tfvars 
    $ terraform apply -var-file=env-dev/main.tfvars -auto-approve
```

> How do we organize the terraform code ?

    1) We will maintain all the child modules in a separate repo ( tf-module-app/ : backend module)
    2) Root module in a separate repo  (expense-terraform/: root module)

# expense-terraform

This is the root module for the expense-app infrastructure

Code Style:
    1) terraform fmt --recursive 
    2) terraform validate  ( This validates whether your code is valid or not )

> Make sure to create an ami in your account using this as image "DevOps-LabImage-RHEL9" as the base image
Steps:
    1) Create machine using this lab image "DevOps-LabImage-RHEL9"
    2) Install ansible on this instance "pip3.11 install ansible -y"
    3) Create AMI "b59-learning-ami-with-ansible" ( use this going forward)