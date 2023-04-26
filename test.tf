resource "aws_instance" "this" {
  ami                     = "ami-0ff8a91507f77f867"
  instance_type           = "c7g.metal"
}
