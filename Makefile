# Переменные
IMAGE_NAME = ping-pong-api
CONTAINER_NAME = ping-pong-container
PORT = 8000

# Помощь по командам
.PHONY: help
help:
	@echo "Доступные команды:"
	@echo "make build    - Собрать Docker образ"
	@echo "make run      - Запустить контейнер"
	@echo "make stop     - Остановить контейнер"
	@echo "make restart  - Перезапустить контейнер"
	@echo "make logs     - Показать логи контейнера"
	@echo "make clean    - Удалить контейнер и образ"
	@echo "make test     - Проверить API"
	@echo "make status   - Проверить статус контейнера"

# Сборка Docker образа
.PHONY: build
build:
	docker build -t $(IMAGE_NAME) .

# Запуск контейнера
.PHONY: run
run:
	@echo "Запуск контейнера $(CONTAINER_NAME) на порту $(PORT)..."
	@docker run -d --name $(CONTAINER_NAME) \
		-p $(PORT):$(PORT) \
		--restart unless-stopped \
		$(IMAGE_NAME) || (echo "Ошибка запуска контейнера" && exit 1)
	@echo "Контейнер успешно запущен"

# Остановка контейнера
.PHONY: stop
stop:
	@echo "Остановка контейнера $(CONTAINER_NAME)..."
	@docker stop $(CONTAINER_NAME) 2>/dev/null || true
	@docker rm $(CONTAINER_NAME) 2>/dev/null || true
	@echo "Контейнер остановлен"

# Перезапуск контейнера
.PHONY: restart
restart: stop run

# Просмотр логов
.PHONY: logs
logs:
	docker logs -f $(CONTAINER_NAME)

# Очистка - удаление контейнера и образа
.PHONY: clean
clean: stop
	docker rmi $(IMAGE_NAME)

# Тестирование API
.PHONY: test
test:
	@echo "Проверка доступности API..."
	@curl -s http://localhost:$(PORT)/ping || (echo "Ошибка: API недоступен" && exit 1)

# Проверка статуса контейнера
.PHONY: status
status:
	@echo "Статус контейнера $(CONTAINER_NAME):"
	@docker ps -f name=$(CONTAINER_NAME) --format "Status: {{.Status}}\nPorts: {{.Ports}}"