docker-compose down -v --remove-orphans
docker system prune -a --volumes --force
docker-compose up --build 


docker exec -it 6c7e7f982f55 psql -U postgres -d bekommerce



SELECT * FROM users ORDER BY id DESC LIMIT 10;
