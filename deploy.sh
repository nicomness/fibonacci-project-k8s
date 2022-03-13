docker build -t nmokhrin/multi-client:latest -t nmokhrin/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nmokhrin/multi-server:latest -t nmokhrin/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nmokhrin/multi-worker:latest -t nmokhrin/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nmokhrin/multi-client:latest
docker push nmokhrin/multi-server:latest
docker push nmokhrin/multi-worker:latest

docker push nmokhrin/multi-client:$SHA
docker push nmokhrin/multi-server:$SHA
docker push nmokhrin/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=nmokhrin/multi-client:$SHA
kubectl set image deployments/server-deployment server=nmokhrin/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=nmokhrin/multi-worker:$SHA