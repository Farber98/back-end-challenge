package token

import (
	"errors"
	"fmt"
	"log"
	"sync"
	"th-amaro/internal/config"
	"time"

	"github.com/aead/chacha20poly1305"
	"github.com/o1egl/paseto"
)

const ERR_INVALID_TOKEN = "invalid token."
const ERR_EXPIRED_TOKEN = "expired token."

var pasetoInstance *PasetoHandler
var oncePaseto sync.Once

type Paseto struct {
	paseto       *paseto.V2
	symmetricKey []byte
}

type PasetoHandler struct {
	Paseto *Paseto
}

func ConstructTokenMaker() *PasetoHandler {
	oncePaseto.Do(func() {
		maker, err := newPasetoMaker(config.Get().Token.Key)
		if err != nil {
			log.Println(err.Error())
			return
		}
		pasetoInstance = &PasetoHandler{Paseto: maker}
	})
	return pasetoInstance
}

func newPasetoMaker(symmetricKey string) (*Paseto, error) {
	if len(symmetricKey) != chacha20poly1305.KeySize {
		return nil, fmt.Errorf("invalid key size: must be exactly %d characters", chacha20poly1305.KeySize)
	}

	maker := &Paseto{
		paseto:       paseto.NewV2(),
		symmetricKey: []byte(symmetricKey),
	}

	return maker, nil
}

func (p *Paseto) CreateToken(username string, duration time.Duration) (string, error) {
	payload, err := newPayload(username, duration)
	if err != nil {
		return "", err
	}

	return p.paseto.Encrypt(p.symmetricKey, payload, nil)
}

func (p *Paseto) VerifyToken(token string) (*Payload, error) {
	payload := &Payload{}

	err := p.paseto.Decrypt(token, p.symmetricKey, payload, nil)
	if err != nil {
		return nil, errors.New(ERR_INVALID_TOKEN)
	}

	err = payload.Valid()
	if err != nil {
		return nil, err
	}

	return payload, nil
}
