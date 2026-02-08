Создание пользователей

```bash
./add_users.sh
```
Создание namespace
```bash
kubectl create namespace dev
```
Создание ролей
```bash
kubectl apply -f roles.yaml
```
Привязка пользователей к ролям
```
kubectl apply -f bindings.yaml
```