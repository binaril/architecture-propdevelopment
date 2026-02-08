Запустить сервисы

Создание namespace
```bash
kubectl create namespace dev
```

```bash
kubectl run front-end-app --image=nginx --labels role=front-end --expose --port 80 -n dev
kubectl run back-end-api-app --image=nginx --labels role=back-end-api --expose --port 80 -n dev
kubectl run admin-front-end-app --image=nginx --labels role=admin-front-end --expose --port 80 -n dev
kubectl run admin-back-end-api-app --image=nginx --labels role=admin-back-end-api --expose --port 80 -n dev
```



Применить политику

```bash
kubectl apply -f non-admin-api-allow.yaml
```

Проверить трафик

```bash
kubectl run test-$RANDOM --rm -i -t --image=alpine -n dev -- sh 
/ # wget -qO- --timeout=2 http://front-end-app
/ # wget -qO- --timeout=2 http://back-end-api-app
/ # wget -qO- --timeout=2 http://admin-front-end-app
/ # wget -qO- --timeout=2 http://admin-back-end-api-app
```
