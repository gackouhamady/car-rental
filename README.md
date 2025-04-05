% Car Rental Service - API Endpoints for Car Rental Management
% This file merges the functionalities of two car rental services:
% 1. A service to manage the list of available cars
% 2. A service to rent or return cars via HTTP requests

%% Dependencies
% These curl commands will be used for interacting with the car rental system via HTTP.

% Retrieve the list of all available cars:
% This command retrieves all cars that are available for rental.
curl --header "Content-Type: application/json" --request GET http://localhost:8080/cars

% Rent a car:
% This request updates the status of a specific car to 'rented' with the given rental period.
curl --header "Content-Type: application/json" --request PUT --data '{"begin":"4/11/2024","end":"20/11/2024"}' 'http://localhost:8080/cars/11AA22?rent=true'

% ---------------------------
% Workflow for Code Updates
% ---------------------------

% Steps to create a new branch and commit changes for the rental service.
% This is done to version control the updates and follow a GitHub workflow.

% Create a new branch for feature updates:
git branch newcarservice

% Move to the new branch:
git checkout newcarservice

% Commit the changes to the branch:
git commit -a -m "newcarservice"

% Switch back to the main branch:
git checkout main

% Push the changes to GitHub:
git push -u origin newcarservice

% Create a Pull Request (PR) on GitHub and follow the workflow.
% Merge the branch on GitHub if everything looks good.
% Pull the new main version after merging:
git checkout main
git pull origin main

% Delete the old branch if necessary:
git branch -D newcarservice
git push origin --delete newcarservice

% ---------------------------
% Docker for Car Rental Service
% ---------------------------

% Create a Dockerfile to containerize the rental service:
% Dockerfile defines how the application will be packaged and run in a container.
docker build -t rentalservice .

% Run the Docker container on the local machine:
docker run -p 4000:8080 rentalservice

% Verify if the service is running by accessing the URL:
http://localhost:4000/cars

% Publish the Docker image to Docker Hub:
% Tag the image with the appropriate Docker Hub user ID and version number.
docker tag 4da2332370c7 votreIdDockerHub/rental:1

% Log in to Docker Hub:
docker login

% Push the image to Docker Hub:
docker push votreIdDockerHub/rental:1

% ---------------------------
% Kubernetes Setup with Minikube
% ---------------------------

% Install Minikube (a local Kubernetes environment) to deploy the car rental service.
minikube start --driver=docker

% Check the number of nodes in the Kubernetes cluster:
kubectl get nodes

% Start the Minikube dashboard to inspect the cluster:
minikube dashboard

% Deploy the Docker image to the Kubernetes cluster:
kubectl create deployment rentalservice --image=charroux/rentalservice:1

% Verify the pod is running correctly:
kubectl get pods

% Scale the deployment to two replicas:
kubectl scale --replicas=2 deployment/rentalservice

% Simulate a pod failure to test its restart behavior:
kubectl delete pod rentalservice-5b746d6f65-t5m8v

% Expose the service with a load balancer:
kubectl expose deployment rentalservice --type=LoadBalancer

% Retrieve the service URL:
minikube service rentalservice --url

% Test the car rental service via the browser:
http://127.0.0.1:50784/cars

% ---------------------------
% Kubernetes Deployment using YAML
% ---------------------------

% Deploy the car rental service with a YAML configuration file.
kubectl apply -f deployment.yml

% Check the configuration at the following line in the deployment YAML:
% https://github.com/charroux/st2scl/blob/main/deployment.yml

% ---------------------------
% Setup Istio Gateway for API Gateway
% ---------------------------

% Install Istio for service mesh and API gateway capabilities:
istioctl install --set profile=demo -y

% Enable auto-injection of Istio sidecars for pod management:
kubectl label namespace default istio-injection=enabled

% Install Istio addons for monitoring and tracing:
kubectl apply -f samples/addons

% Configure Docker to use the Kubernetes cluster:
eval $(minikube -p minikube docker-env)

% Check the configuration of the Kubernetes gateway:
kubectl -n istio-system port-forward deployment/istio-ingressgateway 31380:8080

% Test the gateway by accessing it via browser:
http://localhost:31380/rentalservice/cars

% ---------------------------
% API Gateway with OpenAPI Documentation
% ---------------------------

% Add OpenAPI documentation support to the service.
% Include this library in the project dependencies:
implementation 'org.springdoc:springdoc-openapi-starter-webmvc-ui:2.6.0'

% Rebuild the project, recreate the Docker image, and push it to Docker Hub:
docker push votreIdDockerHub/rental:2

% Deploy the updated service and access the Swagger UI documentation:
http://localhost:31380/rentalservice/swagger-ui/index.html

% ---------------------------
% Car Rental Application API Endpoints
% ---------------------------

% The following endpoints can be used to interact with the rental service.

% 1. Get all available cars:
% Method: GET
% Endpoint: /cars
% Description: Retrieves a list of all unrented cars.

% 2. Get details of a specific car:
% Method: GET
% Endpoint: /cars/{plateNumber}
% Description: Retrieves detailed information about a car.

% 3. Rent a car:
% Method: PUT
% Endpoint: /cars/{plateNumber}?rent=true
% Description: Marks a car as rented and updates rental period.

% 4. Return a car:
% Method: PUT
% Endpoint: /cars/{plateNumber}?rent=false
% Description: Marks a car as available again after return.

% ---------------------------
% PowerShell Example for Renting a Car
% ---------------------------

% Use PowerShell to send a PUT request to rent a car.
Invoke-RestMethod -Uri "http://localhost:8080/cars/11AA22?rent=true" -Method Put -Headers @{"Content-Type"="application/json"} -Body '{"begin":"4/11/2024","end":"20/11/2024"}'

% ---------------------------
% Postman Example for Renting a Car
% ---------------------------

% Use Postman to send a PUT request to rent a car.
% Method: PUT
% URL: http://localhost:8080/cars/11AA22?rent=true
% Headers: Content-Type: application/json
% Body: { "begin": "4/11/2024", "end": "20/11/2024" }
