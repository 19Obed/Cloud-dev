#creating an application load balancer

#creating configuration      
resource "aws_lb_target_group" "Rock_consulting_target_group" {
  name     = "Rock-consulting-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Rock_consulting.id
}

#dening ami
data "aws_ami" "ubuntu" {
  most_recent = true
  owners = [ "099720109477" ]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-20220609"]
  }
}

#creating autoscaling  launch configuration 

resource "aws_launch_configuration" "Rock_consulting_EC2_LC" {
  name          = "Rock-consulting-EC2-LC"
  image_id      = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.Rock_consulting_sec_group.id]
}

#creating aws autoscaling group

resource "aws_autoscaling_group" "Rock_consulting_ASG" {
  min_size             = 1
  max_size             = 3
  desired_capacity     = 1
  launch_configuration = aws_launch_configuration.Rock_consulting_EC2_LC.id
  vpc_zone_identifier  = [aws_subnet.Rock_consulting_pub_sub.id, aws_subnet.Rock_consulting_pub_sub_2.id]
}

#creating application load balancer

resource "aws_lb" "Rock_consulting_lb" {
  name               = "Rock-consulting-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.Rock_consulting_lb_sec_group.id]
  subnets            = [aws_subnet.Rock_consulting_pub_sub.id, aws_subnet.Rock_consulting_pub_sub_2.id]
}

#creating ELB listener

resource "aws_lb_listener" "Rock_consulting_listener" {
  load_balancer_arn = aws_lb.Rock_consulting_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.Rock_consulting_TG.arn
  }
}

#creating ELB target group

resource "aws_lb_target_group" "Rock_consulting_TG" {
  name     = "Rock-consulting-TG"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.Rock_consulting.id
}

resource "aws_autoscaling_attachment" "Rock_on_autoscaling_group_attachment" {
  autoscaling_group_name = aws_autoscaling_group.Rock_consulting_ASG.id
  alb_target_group_arn   = aws_lb_target_group.Rock_consulting_TG.arn
}