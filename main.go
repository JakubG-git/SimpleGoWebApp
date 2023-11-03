package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		n, err := fmt.Fprintf(w, "Hello, you've requested: %s on Server %s\n", r.URL.Path, r.Host)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Fprintf: %v\n", err)
		}
		fmt.Printf("Bytes written: %d\n", n)
		fmt.Printf("Hello, you've requested: %s\n", r.URL.Path)
		fmt.Printf("Server name: %s\n", r.Host)
		fmt.Printf("User ip: %s\n", r.RemoteAddr)

	})

	http.ListenAndServe(":8080", nil)
}
