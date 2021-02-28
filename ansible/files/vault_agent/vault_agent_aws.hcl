exit_after_auth = true
pid_file = "./pidfile"

auto_auth {
   method "aws" {
       mount_path = "auth/aws"
       config = {
           type = "iam"
           role = "default"
       }
   }

   sink "file" {
       wrap_ttl = "5m"
       config = {
           path = "/tmp/vault/agent/token"
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