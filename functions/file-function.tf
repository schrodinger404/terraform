variable "users" {
    type = string
    default = "shreekant"
  
}


resource "aws_iam_user" "user" {

    name = var.users
  
}

resource "aws_iam_user_policy" "lb_ro" {
  name   = "${aws_iam_user.user.name}-ec2_full_access-policy"
  user   = aws_iam_user.user.name

  policy = file("./ec2-full-access.json") # file function in use
}