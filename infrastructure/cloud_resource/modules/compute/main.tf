# modules/compute/main.tf
resource "aws_key_pair" "deployer" {
  key_name   = "${var.environment}-deployer-key"
  public_key = file(var.public_key_path)

  tags = var.tags
}

resource "aws_instance" "rancher" {
  ami           = var.ami_id  
  instance_type = var.instance_type               
  subnet_id     = var.subnet_ids[0]

  vpc_security_group_ids = var.security_group_ids
  key_name              = aws_key_pair.deployer.key_name
  user_data            = file("${path.root}/scripts/rancher.sh")

  root_block_device {
    volume_size = 20   
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-rancher"
  })
}

resource "aws_instance" "k3s" {
  ami           = var.ami_id  
  instance_type = var.instance_type               
  subnet_id     = var.subnet_ids[0]

  vpc_security_group_ids = var.security_group_ids
  key_name              = aws_key_pair.deployer.key_name
  user_data            = file("${path.root}/scripts/k3s.sh")

  root_block_device {
    volume_size = 20    
  }

  tags = merge(var.tags, {
    Name = "${var.environment}-k3s"
  })
}