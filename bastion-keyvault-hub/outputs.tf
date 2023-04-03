output "bastion_ssh_key_public" {
    value = tls_private_key.bastion_ssh_key.public_key_openssh
}