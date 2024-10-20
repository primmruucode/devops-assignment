terraform {
  backend "gcs" {
    bucket = "tf-state-bucket-devops-asm" 
    prefix = "terraform/state"  
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = ">= 4.0.0"
    }
  }
}
