# the data block is used to read the resource from outside the terraform
data "local_file" "example" {
    filename = "${path.module}/example.txt"
}

output "content" {
    value = data.local_file.example.content
}