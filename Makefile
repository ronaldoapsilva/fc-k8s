###########################################################################
# KUBERNETES - cluster
###########################################################################
create_cluster:
	kind create cluster --config=k8s/kind.yaml --name=fullcycle

switch_cluster:
	kubectl config use-context kind-fullcycle

list_clusters:
	kubectl config get-clusters

###########################################################################
# KUBERNETES - LIST OBJECTS
###########################################################################
list_nodes:
	kubectl get nodes

list_pods:
	kubectl get pods

list_configmap:
	kubectl get configmap

list_pvc:
	kubectl get pvc

###########################################################################
# KUBERNETES - DELETE OBJECTS
###########################################################################
delete_deployment:
	kubectl delete deployment goserver

###########################################################################
# KUBERNETES - OTHERS
###########################################################################
CLUSTER_NAME = kind-fullcycle
start_kind_full_cycle:
	minikube start
	kubectl config use-context $(CLUSTER_NAME)
	docker start 3caeae2b2e52 5e5fbc291671 78c33da1430a 6997336f6682

apply_pod:
	kubectl apply -f k8s/pod.yaml
apply_deployment:
	kubectl apply -f k8s/deployment.yaml

del_pod:
	kubectl delete pod goserver

del_deploy:
	kubectl delete deploy goserver

describe_pod:
	kubectl describe pod goserver-74f6b9f675-2ksqr

watch_pods:
	kubectl apply -f k8s/deployment.yaml && watch -n1 kubectl get pods

apiservices:
	kubectl get apiservices

scale_replicas:
	kubectl scale <deployment ou  statefulset> <objeto name> --replicas=5

###########################################################################
# KUBERNETES - NAMESPACE
###########################################################################	
create_ns:
	kubectl create ns dev

apply_ns:
	kubectl apply -f <yaml file name> -n=dev

# get cluster and user name `kubect config view`
set_context:
	kubectl config set-context prod --namespace=prod --cluster=<clustner name> --user=<user name> 
###########################################################################
# KUBERNETES - PORT FORWARD
###########################################################################

# criar um redirecionamento para acessar o pod
port_forward_pod:
	kubectl port-forward pod/goserver 8000:8080

port_forward_svc:
	kubectl port-forward svc/goserver-service 8000:9000


###########################################################################
# KUBERNETES - checking error
###########################################################################

# aqui podemos entrar no container
kubectl_exec:
	kubectl exec -it <nome do pod> -- bash

# se tiver algum erro, podemos ver o erro. i.e: se tentarmos acessar o app no browser der erro, o erro vai estar no log
kubectl_logs:
	kubectl logs <nome do pod>`

###########################################################################
# CRIAR IMAGEM PARA USAR NO KUBERNETES
###########################################################################
IMAGE_NAME = ronaldoapsilva85/hello-go:v9.6

docker_hub_update:
	docker build -t $(IMAGE_NAME) .
	docker push $(IMAGE_NAME)
	
docker_run:
	docker run --rm -p 8080:8080 $(IMAGE_NAME)

###########################################################################
# OTHERS
###########################################################################
base64:
	echo "Ronaldos" | base64
	echo "123456" | base64
	echo "Um9uYWxkb3MK" --decode 