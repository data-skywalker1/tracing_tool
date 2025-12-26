setup:
	bash setup.sh

dev-up:
	docker-compose up -d

dev-down:
	docker-compose down

dev-logs:
	docker-compose logs -f

dev-status:
	docker-compose ps

clean:
	docker-compose down -v
	rm -rf logs/*.log

kibana:
	@echo "Opening Kibana at http://localhost:5601"
	open http://localhost:5601 || xdg-open http://localhost:5601

.PHONY: setup dev-up dev-down dev-logs dev-status clean kibana