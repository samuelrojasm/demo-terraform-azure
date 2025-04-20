# Asignación de valores a las varibales

location           = "eastus"
service            = "vnet"
purpose            = "entraid-demo"
vnet_address_space = ["10.0.0.0/16"]
subnet_prefix      = ["10.0.1.0/24"]
admin_username     = "azureuser"
# admin_ssh_key = file("~/.ssh/mi_clave_azure.pub")
admin_ssh_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEArD8F1jjcU4bpOt4JXzG4UgguyxYn2qgIXHhj2hNRrXt6tUpAqFVHUlHdkDea5UEwM12dhCq6NEmeptmw5gs0tpxqbb5gQwry0cfJNGWcAjtQkw5ScnkCJbGR1XyFGEONyyBhKcQyYbt1I7slH5lYxubSjpFYH9ElqSoxFNiHqv2A1Xnl6tQnqvwd48wB5p6fElYtbAkBdpmWfAw5fR0khrHO3Oe0cOpSZ7WbEijrShvZT3Og0J2pxpHrtmjglEznl35W6cPMr1uayL+NiOVh8J9ARVuReO0u7aU8osQpgHuW5dPQYALmQmdJ+dXkF5Um9EWSK3TgCRtRIwsmA0gdHwsbtjYoDiXnY6vfbIXK7Rxltw== terraform@dummy"