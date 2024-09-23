/* 

---> terraform.tfvars file that defines value to all the variables.

---> If file name is terraform.tfvars → Terraform will automatically load values from it

---> If file name is different like dev.tfvars → You have to explicitly define the file 
during plan / apply operation.

ex. terraform plan -var-file="dev.tfvars"


*/

instance_type = "t2.large"