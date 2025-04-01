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