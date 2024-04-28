# aws_iam_user.dev-admin:
resource "aws_iam_user" "dev-admin" {
  name                 = "dev-admin"
  path                 = "/"
  permissions_boundary = null
  tags                 = {}
  tags_all             = {}
}

resource "aws_iam_user_policy_attachment" "dev-admin_access_attachment" {
  user       = aws_iam_user.dev-admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}