package main

import (
	"golang.org/x/tools/go/analysis/singlechecker"

	"github.com/novadev94/go-enumer/pkg/linter"
)

func main() {
	cfg := linter.Config{}

	singlechecker.Main(linter.New(&cfg))
}
