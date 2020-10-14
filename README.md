# how to deploy app with terraform

## Terraform instance AWS

Before create instances in terraform aws, create env vars in our local OS :

    
    export AWS_ACCESS_KEY_ID=XXXXXX....
    export AWS_SECRET_ACCESS_KEY=xXxX...
    

1. Generate ssh key 

    ```ssh-keygen -f sg-key-pair```

2. Initiate terraform

    ```terraform init```
    
3. Check terraform resource before apply

    ```terraform plan```

4. Ready? apply resources

    ```terraform apply```

## Deploy in gitlab

Now, assuming we have ssh connection to our server, and docker, git is installed on our server we can go ahead with the following:

1. Make sure you can connect to your server via your ssh-key without requiring password.

2. On gitlab, go to your repository > settings > CI/CD > Variables

3. Add a new variable SSH_PRIVATE_KEY. The value is your ssh private key (e.g content of ~/.ssh/id_rsa)

4. Add a new variable DOCKER_USER, DOCKER_PASSWORD, URL_REGISTRY. The value is about our docker authentication registry.

5. Add a new variable IP_SERVER. the value is ip server apps

6. Push to gitlab repository