variable "aws_region" {
    type = string
    default = "ap-southeast-1"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}

variable "key_name" {
    type = string
    default = "server_sing"
}

variable "instance_tags" {
    type = map(string)
    default = {
        Name = "Web Server"
        Env = "Development"
    }
}

variable "userdata_file" {
    type = string
    default = "./scripts/httpdservice.sh"
}

variable "sg_cidr_block" {
    type = list(string)
    default = [ "0.0.0.0/0" ]
}

variable "sg_ingress_ports" {
    type = list(number)
    default = [22, 80, 443]
}