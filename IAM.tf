#creating an IAM role for CC_infra_2 EC2 instances 

resource "aws_iam_role" "CC_infra_2_role" {
  name = "CC_infra_2_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "CC_infra_2_role"
  }
}

#creating instance profile for CC_infra_2

resource "aws_iam_instance_profile" "CC_infra_2_role" {
  name = "CC-infra-2-role"
  role = aws_iam_role.CC_infra_2_role.id
}

#creating a role policy for CC_infra_2

resource "aws_iam_role_policy" "CC_infra_2_policy" {
  name = "CC-infra-2-policy"
  role = aws_iam_role.CC_infra_2_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "iam:*",
          "organizations:DescribeAccount",
          "organizations:DescribeOrganization",
          "organizations:DescribeOrganizationalUnit",
          "organizations:DescribePolicy",
          "organizations:ListChildren",
          "organizations:ListParents",
          "organizations:ListPoliciesForTarget",
          "organizations:ListRoots",
          "organizations:ListPolicies",
          "organizations:ListTargetsForPolicy"
        ],
        "Resource" : "*"
      }
    ]
  })
}