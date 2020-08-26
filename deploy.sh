docker build -t profemzy/multi-client:latest -t profemzy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t profemzy/multi-server:latest -t profemzy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t profemzy/multi-worker:latest -t profemzy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push profemzy/multi-client:latest
docker push profemzy/multi-server:latest
docker push profemzy/multi-worker:latest

docker push profemzy/multi-client:$SHA
docker push profemzy/multi-server:$SHA
docker push profemzy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=profemzy/multi-server:$SHA
kubectl set image deployments/client-deployment client=profemzy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=profemzy/multi-worker:$SHA
