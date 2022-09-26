package main

import (
	"log"
	"th-amaro/internal/config"
	"th-amaro/internal/router"
)

func main() {
	e := router.Init()
	log.Fatal(e.Start(config.Get().Context.Host + ":" + config.Get().Context.Port))
}
