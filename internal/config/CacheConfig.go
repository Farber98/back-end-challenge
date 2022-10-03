package config

import "errors"

type CacheConfig struct {
	Address string `toml:"address"`
}

func (conf *CacheConfig) SelfCheck() error {
	if conf.Address == "" {
		return errors.New("invalid address")
	}
	return nil
}
