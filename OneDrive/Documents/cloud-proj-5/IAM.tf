#creating an IAM role for Rock_on EC2 instances 

resource "aws_iam_role" "Rock_on_role" {
  name = "Rock_on_role"

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
    tag-key = "Rock_on_role"
  }
}

#creating instance profile for rock_on

resource "aws_iam_instance_profile" "Rock_on_role" {
  name = "Rock_on_role"
  role = aws_iam_role.Rock_on_role.id
}

#creating a role policy for rock_on

resource "aws_iam_role_policy" "Rock_on_policy" {
  name = "Rock_on_policy"
  role = aws_iam_role.Rock_on_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
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
            "Resource": "*"
        }
    ]
})
}