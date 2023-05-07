# DIS_Final_Project

## Description

The importance of Autoscaling cannot be underestimated as it enables services on the interned to be deployed reliably. For autoscaling to work successfully, it needs to have access to values inorder to configure the parameters such as the minimum and maximum amount of resources to be provisioned, the unit increase and decrease in resources when a scaling-out or scaling-in event occurs and the specific trigger for the scaling event. We have come up with mathematical expressions to ascertain the impact of these parameters on autoscaling while explaining their logical semantics and backing them empirically. We avoid the additional overhead of repeatedly ascertaining a pattern based on incoming and current data while instead empirically inferring a static correlation between system performance with various autoscaling parameters and attempting to balance this performance with some degree of resource utilization.

We start off by studying parameters in terms of the requirement of the value to be in a specififc range and their impact on the running of the overall system. We then learn the optimal values based on our empirical data which is partially based on existing research and also obtained through analysis of a dummy web server built using a Python Flask framework in the form of a REST API server. Any new relations found between the application’s metrics, the load patterns, and the underlying aim of keeping the application and its parameters generalized will be used to revise the empirical analysis and will contribute to the project findings.



## Building the setup

This project ***must*** be deployed on a machine with atleast 21GB of disk space and 4GB of memory.

Start by opening the terminal and typing in `git clone https://github.com/dion-trevor/DIS_Final_Project.git`

Then open the terminal inside the cloned repository and Run the `build.sh` script file with the command `sh build.sh`

### Application Container Image
`build.sh' containerizes the flask API on which our autosclaing configuration is tested and uploads it to dockerhub to be efficiently pulled and deployed in the Kubernetes cluster. Alternatively, for testing and verification the container image can be reconstructed using the `docker build  ` command which is provided in a comment in the `build.sh` file. This uses the dockerfile present at the root directory to build the container image developed using standard dockerfile commands to containerize a flask application.

### _kubectl_ and _minikube_

`build.sh` then proceeds to install _kubectl_ which is a command line interface to interact with a kubernetes cluster and _minikube_ which helps to create a kubernetes cluster locally for non-production purposes. 

After this, the script then creates the deployment environment by using _kubectl_ to leverage the `deployment.yaml` file. _kubectl_ is also used to configure the load balancer and the Horizontal Pod Autoscaler using the `HorizontalPodAutoscaler.yaml` file. The `build.sh` script upon execution provides the API URL which can be used to validate the application by using the command `curl <url provided after running build.sh>`.

-----------------------------------------------------------------

In order to delete a Kubernetes Pod, use the following deletion command:

kubectl delete $(kubectl get pods -o name)

## Running tests

In order to test and evaluate our system, we use locust. Locust is an easy to use, scriptable and scalable performance testing tool where we define the behaviour of our users in regular Python code. Instructions for installing locust can be found [here](https://github.com/locustio/locust).

Once you do that, in the same directory as before, use command 'locust' and navigate to the URL provided. If that does not work, open `localhost:8089` in your web broswer(default).

This will allow you to specify users, spawn rate, the host (which will be the URL provided by build.sh) and the run time.
  
### Steps during an iteration:
  
- We first configure the minimum and maximum number of pods available in the system to process the incoming requests
- We then configure our setup with the minimum and maximum intended average utilization in mind; starting at an arbitrary number for % utilization and then amending  it iteratitvely according to the experienced failure rate
- Based on the results we tweak our parameters and run the system once again.
- In order to delete a Kubernetes Pod, use the following deletion command: `kubectl delete $(kubectl get pods -o name)`
 



