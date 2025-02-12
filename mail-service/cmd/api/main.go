package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"strconv"
)

type Config struct {
	Mailer Mail
}

const webPort = "80"

func main() {
	app := Config{
		Mailer: createMailer(),
	}

	log.Println("Starting mail service on port", webPort)

	srv := &http.Server{
		Addr:    fmt.Sprintf(":%s", webPort),
		Handler: app.routes(),
	}

	err := srv.ListenAndServe()
	if err != nil {
		log.Panic(err)
	}
}

func createMailer() Mail {
	mailPort, _ := strconv.Atoi(os.Getenv("MAIL_PORT"))
	m := Mail{
		Domain:      os.Getenv("MAIL_DOMAIN"),
		Host:        os.Getenv("MAIL_HOST"),
		Port:        mailPort,
		Username:    os.Getenv("MAIL_USERNAME"),
		Password:    os.Getenv("MAIL_PASSWORD"),
		FromAddress: os.Getenv("MAIL_FROM_ADDRESS"),
		FromName:    os.Getenv("MAIL_FROM_NAME"),
		Encryption:  os.Getenv("MAIL_ENCRYPTION"),
	}

	return m
}
