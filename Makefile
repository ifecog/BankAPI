postgres:
	docker run --name postgres16 -p 5433:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=Darasimi302 -d postgres:16.3-alpine

createdb:
	docker exec -it postgres16 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres16 dropdb simple_bank

migrateup:
	migrate -path DbMigration -database "postgresql://root:Darasimi302@localhost:5433/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path DbMigration -database "postgresql://root:Darasimi302@localhost:5433/simple_bank?sslmode=disable" -verbose down

makeFileDir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

sqlc:
	docker run --rm -v ${pwd}:/src -w /src kjconroy/sqlc generate

.PHONY: postgres createdb drop migrateup migratedown