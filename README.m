% Car Rental Application - Unified .m file with comments

% Initialization: Setup constants and variables
% The car rental service operates on a simple RESTful API system, 
% which interacts with cars and their rental statuses through HTTP methods.

% Car List Initialization - List of cars with their details (plate number, brand, price, and rental status)
cars = struct('plateNumber', {'11AA22', '22BB33', '33CC44'}, ...
              'brand', {'Toyota', 'Honda', 'Ford'}, ...
              'price', {50, 60, 70}, ...
              'rented', {false, false, false});  % All cars are initially available

% Define the API Base URL
baseURL = 'http://localhost:8080/cars';  % Base URL for accessing the car rental API

% Example API Call 1: Fetch list of unrented cars
% This uses the GET method to retrieve all cars that are available for rent
disp('Fetching available cars...');
response = webread(baseURL);  % GET request to fetch all available cars
disp('Available cars:');
disp(response);  % Display the list of available cars

% Example API Call 2: Rent a car (PUT request)
% The car with plate number '11AA22' will be rented from 4/11/2024 to 20/11/2024
% We use the PUT method to update the rental status to 'true'
carPlate = '11AA22';
rentalData = struct('begin', '4/11/2024', 'end', '20/11/2024');  % Rental period

disp('Renting car with plate number 11AA22...');
options = weboptions('ContentType', 'json', 'RequestMethod', 'put');
url = sprintf('%s/%s?rent=true', baseURL, carPlate);  % URL with specific car plate
response = webwrite(url, rentalData, options);  % Send PUT request
disp('Car rented successfully!');
disp(response);

% Example API Call 3: Return a car (PUT request)
% Returning the car with plate number '11AA22' and making it available again
disp('Returning car with plate number 11AA22...');
url = sprintf('%s/%s?rent=false', baseURL, carPlate);  % URL to mark car as available
response = webwrite(url, rentalData, options);  % Send PUT request to mark as available
disp('Car returned successfully!');
disp(response);

% Git Commands - Process for updating the repository with a new feature or fix

% Create a new branch for the feature or fix
system('git branch newcarservice');  % Create a new branch named 'newcarservice'
system('git checkout newcarservice');  % Switch to the new branch

% After making changes to the code, commit and push to GitHub
system('git commit -a -m "newcarservice"');  % Commit changes with a message
system('git checkout main');  % Switch back to the main branch
system('git push -u origin newcarservice');  % Push the changes to GitHub

% Merge the branch into the main branch after successful changes
system('git checkout main');  % Ensure you are on the main branch
system('git pull origin main');  % Pull the latest changes from GitHub

% Optional: Delete the feature branch locally and remotely
system('git branch -D newcarservice');  % Delete the branch locally
system('git push origin --delete newcarservice');  % Delete the branch from GitHub

% Docker Commands - Building, Running, and Publishing Docker Images

% Build a Docker image from the Dockerfile
system('docker build -t rentalservice .');  % Build the Docker image

% Run the Docker container
system('docker run -p 4000:8080 rentalservice');  % Run the container on port 4000

% Publish Docker image to Docker Hub
system('docker tag 4da2332370c7 votreIdDocherHub/rental:1');  % Tag the image
system('docker login');  % Login to Docker Hub
system('docker push votreIdDocherHub/rental:1');  % Push the image to Docker Hub

% Kubernetes Commands - Deploying to Minikube

% Start Minikube cluster
system('minikube start --driver=docker');  % Start the cluster with Docker driver

% Check the cluster nodes
disp('Checking nodes in the cluster...');
system('kubectl get nodes');  % Retrieve nodes in the Minikube cluster

% Open Minikube dashboard to inspect the cluster
disp('Opening Minikube dashboard...');
system('minikube dashboard');  % Open the Minikube dashboard

% Deploy the Docker image to Minikube cluster
system('kubectl create deployment rentalservice --image=charroux/rentalservice:1');  % Deploy

% Verify that the deployment was successful
disp('Checking deployment status...');
system('kubectl get pods');  % Verify the status of pods

% Scale the deployment to 2 replicas for high availability
system('kubectl scale --replicas=2 deployment/rentalservice');  % Scale to 2 replicas

% Delete a pod to test auto-restarting functionality
disp('Deleting a pod to test restart...');
system('kubectl delete pod rentalservice-5b746d6f65-t5m8v');  % Delete a pod

% Expose the deployment via LoadBalancer
system('kubectl expose deployment rentalservice --type=LoadBalancer');  % Expose service

% Retrieve the service URL
disp('Getting service URL...');
system('minikube service rentalservice --url');  % Get the URL for the service

% Apply Kubernetes deployment configuration via YAML
disp('Applying Kubernetes deployment...');
system('kubectl apply -f deployment.yml');  % Apply deployment from YAML file

% Istio Setup - Install Istio and configure the service mesh

% Download and install Istio
system('cd istio-1.17.0');  % Navigate to Istio directory
system('export PATH=$PWD/bin:$PATH');  % Update PATH for Istio binaries
system('istioctl install --set profile=demo -y');  % Install Istio with demo profile

% Enable auto-injection of Istio sidecars for the default namespace
system('kubectl label namespace default istio-injection=enabled');  % Label namespace

% Apply Istio addons (Kiali, Prometheus, Jaeger, Grafana)
system('kubectl apply -f samples/addons');  % Install Istio addons

% Kubernetes Gateway - Expose services via Istio Gateway
system('kubectl apply -f deployment.yml');  % Apply configuration again
system('kubectl -n istio-system port-forward deployment/istio-ingressgateway 31380:8080');  % Forward port

% Test the service through Istio gateway in the browser
disp('Testing service through Istio Gateway...');
disp('Visit: http://localhost:31380/rentalservice/cars');  % URL to access the service

% End of script
