package infraestructure

import (
	"log"
	"sync"
	"time"

	"github.com/patrickmn/go-cache"
)

var cacheInstance *CacheHandler
var onceCache sync.Once

type CacheHandler struct {
	Cache  *cache.Cache
	logger *log.Logger
}

//ConstructCache initializes cache.
func ConstructCache() *CacheHandler {
	onceCache.Do(func() {
		cache := cache.New(5*time.Minute, 10*time.Minute)
		cacheInstance = &CacheHandler{Cache: cache, logger: log.Default()}
	})
	return cacheInstance
}

//GetCache Gets singleton cache
func (c *CacheHandler) GetCache() *cache.Cache {
	return c.Cache
}

func (c *CacheHandler) Get(key string) (interface{}, bool) {
	val, ok := c.Cache.Get(key)
	if ok {
		c.log("hit", key)
	} else {
		c.log("miss", key)
	}
	return val, ok
}

func (c *CacheHandler) Set(key string, val interface{}) {
	c.Cache.SetDefault(key, val)
	c.log("put", key)
}

func (c *CacheHandler) log(msg, key string) {
	c.logger.Println("CACHE: " + msg + " " + key)
}
