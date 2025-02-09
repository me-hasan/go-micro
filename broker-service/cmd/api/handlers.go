package main

import (
	"net/http"
)

func (app *Config) Broker(w http.ResponseWriter, r *http.Request) {

	payload := jsonResponse{
		Error:   false,
		Message: "Hit the broker and sent a message",
	}

	_ = app.writeJSON(w, http.StatusAccepted, payload)
}
