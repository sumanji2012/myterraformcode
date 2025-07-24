terraform {
  backend "s3" {
    bucket         = "storetfstatesumang12"   # ← Replace with your actual bucket
    key            = "terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "lock_tf_state"        # ← Optional, but recommended
  }
}

