docker build -t duyguemre/multi-client:latest -t duyguemre/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t duyguemre/multi-server:latest -t duyguemre/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t duyguemre/multi-worker:latest -t duyguemre/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push duyguemre/multi-client:latest
docker push duyguemre/multi-server:latest
docker push duyguemre/multi-worker:latest

docker push duyguemre/multi-client:$SHA
docker push duyguemre/multi-server:$SHA
docker push duyguemre/multi-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/client-deployment client=duyguemre/multi-client:$SHA
kubectl set image deployments/server-deployment server=duyguemre/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=duyguemre/multi-worker:$SHA
