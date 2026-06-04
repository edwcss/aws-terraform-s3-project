## Cloud Engineering & Infrastructure Log
A hands-on record of my transition from IT Help Desk to Cloud Engineering. 

---

##  Active Projects

### 1. AWS Infrastructure Automation
**Goal:** Automating secure, public-facing S3 static websites using Terraform.

* **Tech Stack:** Terraform, AWS S3, IAM.
* **Key Focus:** Implementing Least Privilege via Bucket Policies and Public Access Blocks.
* **Live Demo:** [View Site](http://inshunshous-project-2026-v1.s3-website-ap-northeast-1.amazonaws.com)

---

##  Learning Journal

### April 29, 2026: VPC Design & Networking Foundations
Today I moved beyond S3 and started building a custom network environment. The goal was to understand how a "Private Cloud" is structured before deploying servers.

* **Build:** Provisioned a custom VPC with a `10.0.0.0/16` CIDR block.
* **Subnetting:** Created a public subnet (`10.0.1.0/24`) to host future web resources.
* **Connectivity:** Deployed an **Internet Gateway (IGW)** to serve as the entry/exit point for the network.
* **Reflection:** I learned that an IGW alone doesn't grant internet access. Without a **Route Table** entry directing traffic to the IGW, the subnet remains isolated. This will be my next task.
* **Status:** Deployed successfully via Terraform.

---

### Deployment Workflow
1. `terraform init` - Initialize provider
2. `terraform plan` - Preview changes
3. `terraform apply` - Provision resources
