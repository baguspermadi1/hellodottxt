data "aws_availability_zones" "all" {}
resource "aws_launch_configuration" "my-web" {
    ami = "${lookup(var.AMI, var.AWS_REGION)}"
    instance_type = "t2.medium"
    # VPC
    subnet_id = "${aws_subnet.my-subnet-public-1.id}"
    # Security Group
    vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
    # the Public SSH key
    key_name = "${aws_key_pair.sg-key-pair.id}"
    connection {
        user = "${var.EC2_USER}"
        private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
    }
    lifecycle {
    create_before_destroy = true
  }
}
# aws asg
resource "aws_autoscaling_group" "asg-ec2" {
  launch_configuration = aws_launch_configuration.my-web.id
  availability_zones   = data.aws_availability_zones.all.names
  # VPC
  subnet_id = "${aws_subnet.my-subnet-public-1.id}"
  # Security Group
  vpc_security_group_ids = ["${aws_security_group.ssh-allowed.id}"]
  # the Public SSH key
  key_name = "${aws_key_pair.sg-key-pair.id}"
  connection {
      user = "${var.EC2_USER}"
      private_key = "${file("${var.PRIVATE_KEY_PATH}")}"
  }
  min_size = 2
  max_size = 5
  health_check_grace_period = 300
  health_check_type = "EC2"
  force_delete = true
  tag {
    key                 = "Name"
    value               = "asg-ec2"
    propagate_at_launch = true
  }
}

// Sends your public key to the instance
resource "aws_key_pair" "sg-key-pair" {
    key_name = "sg-key-pair"
    public_key = "${file(var.PUBLIC_KEY_PATH)}"
}