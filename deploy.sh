docker build -t nmendoza/multi-client:latest -t nmendoza/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nmendoza/multi-server:latest -t nmendoza/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nmendoza/multi-worker:latest -t nmendoza/multi-worker:$SHA -f ./worker/DOckerfile ./worker
docker push nmendoza/multi-client:latest
docker push nmendoza/multi-client:$SHA
docker push nmendoza/multi-server:latest
docker push nmendoza/multi-server:$SHA
docker push nmendoza/multi-worker:latest
docker push nmendoza/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nmendoza/multi-server:$SHA
kubectl set image deployments/client-deployment client=nmendoza/client-server:$SHA
kubectl set image deployments/worker-deployment worker=nmendoza/worker-server:$SHA