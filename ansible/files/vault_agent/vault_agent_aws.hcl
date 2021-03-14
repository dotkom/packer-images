pid_file = "./pidfile"

auto_auth {
   method "aws" {
       mount_path = "auth/aws"
       config = {
           type = "iam"
           role = "aws_default"
       }
   }

   sink "file" {
       config = {
           path = "/etc/consul_template.d/vault_token"
           mode = 0000
       }
   }
}

cache {
  use_auto_auth_token = true
}

listener "tcp" {
    address = "127.0.0.1:8200"
    tls_disable = true
}

vault {
   address = "https://vault.online.ntnu.no:8200"
}