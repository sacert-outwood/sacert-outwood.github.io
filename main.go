package main

import (
	"fmt"
	"log"
	"net/http"
	"os"

	"github.com/joho/godotenv"
)

func main() {
	err := godotenv.Load(".env")
	if err != nil { 
		log.Println(err)
	}
	port := os.Getenv("PORT")
	fs := http.FileServer(http.Dir("."))
	http.Handle("/", fs)
	log.Printf("Server is running at http://localhost:%s", port)
	err = http.ListenAndServe(fmt.Sprintf(":%s", port), nil)
	if err != nil {
		log.Fatal(err)
	}
}
