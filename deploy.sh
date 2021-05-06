docker build -t matheusy/multi-client:latest -t matheusy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t matheusy/multi-server:latest -t matheusy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t matheusy/multi-worker:latest -t matheusy/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push matheusy/multi-client:latest
docker push matheusy/multi-server:latest
docker push matheusy/multi-worker:latest

docker push matheusy/multi-client:$SHA
docker push matheusy/multi-server:$SHA
docker push matheusy/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=matheusy/multi-server:$SHA
kubectl set image deployments/client-deployment client=matheusy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=matheusy/multi-worker:$SHA