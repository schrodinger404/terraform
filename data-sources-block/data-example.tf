
# This is a data source block which will read the aws intance and stores the data in .tfstate file

# which  will fetch the data from aws instance which has tag of Team and value Production
data "aws_instance" "example" {
 filter {
    name   = "tag:Team"
    values = ["Production"]
  }
}

