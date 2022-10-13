package models

import "time"

type LoginRequest struct {
	Username string `json:"username,omitempty"`
	Password string `json:"password,omitempty"`
}

type LoginResponse struct {
	AccessToken string    `json:"access_token,omitempty"`
	CreatedAt   time.Time `json:"created_at,omitempty"`
	ExpiresAt   time.Time `json:"expires_at,omitempty"`
}
