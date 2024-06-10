output "Webserver-Public-IP" {
    value = aws_instance.webserver.public_ip
}

output "Webserver-Public-DNS" {
    value = aws_instance.webserver.public_dns
}

output "Webserver-Status" {
    value = aws_instance.webserver.instance_state
}

output "Webserver-Private-IP" {
    value = aws_instance.webserver.private_ip
}