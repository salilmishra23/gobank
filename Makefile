postgres:
	podman run --name postgres14 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:14-alpine

createdb:
	podman exec -it postgres14 createdb --username=root --owner=root gobank

dropdb:
	podman exec -it postgres14 dropdb gobank

migrateup:
	migrate -path db/migrations -database "postgresql://root:secret@localhost:5432/gobank?sslmode=disable" -verbose up	

migratedown:
	migrate -path db/migrations -database "postgresql://root:secret@localhost:5432/gobank?sslmode=disable" -verbose down	

sqlc:
	sqlc generate

.PHONY: createdb dropdb postgres migrateup migratedown sqlc

# psql -U root gobank