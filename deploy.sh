docker build -t nikolaysemyonov/multi-client:latest -t nikolaysemyonov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t nikolaysemyonov/multi-server:latest -t nikolaysemyonov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t nikolaysemyonov/multi-worker:latest -t nikolaysemyonov/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push nikolaysemyonov/multi-client:latest
docker push nikolaysemyonov/multi-server:latest
docker push nikolaysemyonov/multi-worker:latest

docker push nikolaysemyonov/multi-client:$SHA
docker push nikolaysemyonov/multi-server:$SHA
docker push nikolaysemyonov/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=nikolaysemyonov/multi-server:$SHA
kubectl set image deployments/client-deployment client=nikolaysemyonov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=nikolaysemyonov/multi-worker:$SHA