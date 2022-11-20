postgres:
	podman run --name postgres15 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:15-alpine

createdb:
	podman exec -it postgres15 createdb --username=root --owner=root gobank

dropdb:
	podman exec -it postgres15 dropdb gobank

migrateup:
	migrate -path db/migrations -database "postgresql://root:secret@localhost:5432/gobank?sslmode=disable" -verbose up	

migratedown:
	migrate -path db/migrations -database "postgresql://root:secret@localhost:5432/gobank?sslmode=disable" -verbose down	

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server:
	go run main.go

.PHONY: createdb dropdb postgres migrateup migratedown sqlc test server

# psql -U root gobank