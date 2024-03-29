provider "google" {
  project = var.project_id
  region  = var.region
}

# Armazena o "estado" do Terraform 
terraform {
  backend "gcs" {
    bucket = "pipeline-terraform-state"
    prefix = "terraform/state"
  }
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "3.67.0"
    }
  }
}