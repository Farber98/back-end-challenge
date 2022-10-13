package config

import "errors"

type User struct {
	Username string `toml:"username"`
	Password string `toml:"password"`
}

func (conf *User) SelfCheck() error {
	if conf.Username == "" {
		return errors.New("invalid username")
	}
	if conf.Password == "" {
		return errors.New("invalid password")
	}
	return nil
}
