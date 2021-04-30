# Introduction

The primary output from this demo is a single instance (this can be increased changing the Desired Count see Usage) container running a publically available web page powered by NGINX. Although you can use your own Dockerfile that will be used as input to the build, push and provision. 

Here we use [Fargate](https://aws.amazon.com/fargate) which is a serverless compute engine but I have not added the load balancer as I do not want to incur additional costs.

**Note** - Any Amazon ECS service using the Fargate launch type is end for CloudWatch CPU and memory utilization metrics automatically and fine tuning these metrics will enable autoscaling. The capability to fine tune will be added to this codebase but curently the default scaling will be used.

- Creation of Core Network - VPC, IGW, Route Tables (RT), Routes, RT Association and Subnets
- Creation of [Elastic Container Registry](https://aws.amazon.com/ecr/)
- Image build and push to ECR 
- Creation of [Elastic Container Service](https://aws.amazon.com/ecs/) Cluster 
- Creation of [ECS Service](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs_services.html)
- Creation of [ECS Task](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task_definitions.html) 

## Pre-requisites

You will need to ensure your credentials are reachable in order to authenticate with AWS see this link
[AWS Provider Authentication Options](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

As we automate the process to log into the AWS Private Registry, build the image and push it, you will need [Docker](https://docs.docker.com/get-docker/) installed.

Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) as we need to log into the Registry in order to push our newly built image.

First run aws configure and enter **YOUR** values

```bash
$ aws configure
AWS Access Key ID [None]: accesskey
AWS Secret Access Key [None]: secretkey
Default region name [None]: us-west-2
Default output format [None]:
```

Now when running Terraform Apply later this command will successfully login to your repository

```bash
aws ecr get-login-password --region "$region" | docker login --username AWS --password-stdin "$repository_url" 
```

## Usage

This is not meant to be overly complex. 

Navigate to the cloned repository locally on your device. A *webapp.tfvars* file has been provided as a base to update/amend values as you please. No data held in this [tfvars](https://www.terraform.io/docs/language/values/variables.html) file is sensitive but always exercise caution when storing these types of files on public reposititories as sensitive values can be present even by accident.

Once happy with the inputs, you may execute

[Terraform Init](https://www.terraform.io/docs/cli/commands/init.html)

```bash
terraform init
```
[Terraform Plan](https://www.terraform.io/docs/cli/commands/plan.html)

```bash
terraform plan -var-file=webapp.tfvars -out=path<ADD YOUR TARGET>
```

If the result is what you expected, feel free to

[Terraform Apply](https://www.terraform.io/docs/cli/commands/apply.html)

```bash
terraform apply -auto-approve -var-file=webapp.tfvars <YOUR PLAN NAME AS ABOVE>
```

Note when you [Terraform Destroy](https://www.terraform.io/docs/cli/commands/destroy.html) you'll need to provide that tfvar file as input again.

## Providers

[AWS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)\
[NULL](https://registry.terraform.io/providers/hashicorp/null/latest)

## In Progress

- [] Add ALB functionality
- [] Move state to S3 with Dynamo providing the locking
- [] Add switch functionality to turn on/off certain modules
- [] Move modules to own repositories
- [] Create more flexibility in data structure to process more objects i.e. for_each
- [] Split the existing Root module and create more state seperation together with wrapper script for executing commands with good user experience
- [] Add workspaces
- [] Enrich the current modules with the additional functionality provided by the Provider
- [] Add Terratest tests

## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)
