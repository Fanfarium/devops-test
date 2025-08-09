## CI/CD Pipeline

Пайплайн запускається при пуші у гілку `main`.

---

## Як запустити локально

### Вимоги:

- Docker
- Kubernetes
- kubectl CLI
- Node.js та npm

### Кроки:

1. Клонуйте репозиторій:

   ```bash
   git clone https://github.com/Fanfarium/devops-test.git
   cd devops-test
   
2. Налаштуйте secrets у репозиторії:

- `DOCKER_USERNAME` — ваше ім'я користувача Docker Hub.
- `DOCKER_TOKEN` — токен для доступу до Docker Hub.
- `SSH_PRIVATE_KEY` — приватний SSH ключ для доступу до сервера.
- `KUBE_CONFIG_DATA` — kubeconfig файл закодований у base64 для доступу до Kubernetes кластера.

3. Запуск pipeline

Коли ви пушите зміни в гілку `main`, автоматично запускається GitHub Actions workflow `CI/CD Pipeline`.
Workflow виконує:
- **Checkout** коду з репозиторію (SSH ключ використовується для аутентифікації).
- **Побудову Docker образу** з тегом `manyok007/devops-test:latest`.
- **Запуск юніт-тестів** через `npm test`.
- **Пуш Docker образу** до Docker Hub.
- **Деплой** Kubernetes манифестів через Bash-скрипт, який застосовує Deployment, Service, Ingress, Secret, Config.
Зауваження: для нормальної роботи Githab Actions з локальним сервером потрібно поставити actions-runner.

4. Підключення через браузер

Можна доступитись по IP-node:30080 а до redis по IP-node:30080/redis

## Kubernetes маніфести

Маніфести знаходяться у директорії `kuber/` і містять:

### 1. Deployment (`kuber/dep-redis.yml, kuber/dep-nest.yml`)

### 2. Service (`kuber/service_redis.yml, kuber/service-nest.yml, kuber/ingress-contr.yml`)

### 3. Ingress (`kuber/ingress.yml`)

### 4. Secret (`kuber/sec-redis.yml`)

### 5. ConfigMap (`kuber/conf-nest.yml`)

## Моніторинг

### Кроки:

1. Клонуйте репозиторій:

   ```bash
   git clone https://github.com/Fanfarium/moni.git
   cd moni

2. Запустіть скрипт:

   ```bash
   bash prom_stack.sh

Створяться поди Prometheus, Grafana, AlertManager, Node Exporter та kube-state-metrics. 
