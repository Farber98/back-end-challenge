package infraestructure

import (
	"context"
	"crypto/md5"
	"encoding/hex"
	"fmt"
	"log"
	"strings"
	"sync"
	"th-amaro/internal/config"
	"time"

	"github.com/go-redis/redis/v8"
)

type CacheHandler struct {
	Conn   *redis.Client
	logger *log.Logger
}

var cacheInstance *CacheHandler
var onceCache sync.Once

//ConstructCache calls initCache to initialize connection.
func ConstructCache() *CacheHandler {
	onceCache.Do(func() {
		connection, err := initCache()
		if err != nil {
			log.Println(err.Error())
			return
		}
		cacheInstance = &CacheHandler{Conn: connection, logger: log.Default()}
	})
	return cacheInstance
}

func initCache() (*redis.Client, error) {
	conf := config.Get().Cache

	conn := redis.NewClient(&redis.Options{
		Addr: conf.Address,
	})

	pong, err := conn.Ping(context.Background()).Result()
	if err != nil {
		conn.Close()
		return nil, err
	}

	if pong == "PONG" {
		log.Println("Redis LIVE on", conf.Address)
	}

	return conn, nil
}

//GetDB Gets singleton DB connection
func (h *CacheHandler) GetCache() *redis.Client {

	return h.Conn
}

func (h *CacheHandler) Get(key string) (string, error) {
	c := config.Get().Context
	if c.Debug {
		h.log("GET", key)
	}
	return h.Conn.Get(context.Background(), key).Result()
}

func (h *CacheHandler) Set(key string, value interface{}) (string, error) {
	c := config.Get().Context
	if c.Debug {
		h.log("SET", key)
	}
	return h.Conn.Set(context.Background(), key, value, 30*time.Second).Result()
}

func (h *CacheHandler) log(operation, key string) {
	str := fmt.Sprintf("[CACHE] %v %v", operation, key)
	h.logger.Println(str)
}

func GenerateCacheKey(storedProcedure, arg string) string {
	str := strings.Replace(storedProcedure, "?", arg, 1)
	hash := md5.Sum([]byte(str))
	return hex.EncodeToString(hash[:])
}
