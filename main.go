package main

import (
	"log"
	"os"

	"github.com/novadev94/go-enumer/cmd/cli"
)

func main() {
	err := cli.Execute(os.Args[1:])
	if err != nil {
		log.Fatal(err)
	}
}
