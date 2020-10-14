# region
variable "AWS_REGION" {    
    default = "ap-southeast-1"
}

# AMI (Operating system)
variable "AMI" {
    type = "map"   
    
    default {
        ap-southeast-1 = "ami-03dea29b0216a1e03"
    }
}