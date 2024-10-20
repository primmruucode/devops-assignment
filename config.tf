terraform {
  backend "gcs" {
    bucket = "tf-state-bucket-devops-asm" 
    prefix = "terraform/state"  
  }
}
