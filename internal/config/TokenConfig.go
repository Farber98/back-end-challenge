package config

import "errors"

// DBConfig Database config model
type TokenConfig struct {
	Key string `toml:"key"`
}

func (conf *TokenConfig) SelfCheck() error {
	if conf.Key == "" {
		return errors.New("invalid key")
	}
	return nil
}
