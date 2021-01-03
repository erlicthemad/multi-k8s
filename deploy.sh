docker build -t naujocke/multi-client:latest -t naujocke/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t naujocke/multi-server:latest -t naujocke/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t naujocke/multi-worker:latest -t naujocke/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push naujocke/multi-client:latest
docker push naujocke/multi-client:$SHA
docker push naujocke/multi-server:latest
docker push naujocke/multi-server:$SHA
docker push naujocke/multi-worker:latest
docker push naujocke/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=naujocke/multi-server:$SHA
kubectl set image deployments/client-deployment client=naujocke/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=naujocke/multi-worker:$SHA
