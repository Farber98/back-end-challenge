package infraestructure

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"strings"
	"sync"
	"th-amaro/internal/config"
	"time"

	// Mysql Driver
	_ "github.com/go-sql-driver/mysql"
)

//DbHandler models a connection
type DbHandler struct {
	Conn   *sql.DB
	logger *log.Logger
}

//SpOut returns stored procedures JSON encoded values.
type SpOut []byte

var onceDB sync.Once
var dbInstance *DbHandler

const MysqlDatetimeLayout = "2006-01-02 15:04:05"

//ConstructDB calls initDB to initialize connection.
func ConstructDB() *DbHandler {
	onceDB.Do(func() {
		connection, err := initDB()
		if err != nil {
			log.Println(err.Error())
			return
		}
		dbInstance = &DbHandler{Conn: connection, logger: log.Default()}
	})
	return dbInstance
}

//GetDB Gets singleton DB connection
func (h *DbHandler) GetDB() *sql.DB {
	return h.Conn
}

func initDB() (*sql.DB, error) {
	conf := config.Get().DB

	cadena := fmt.Sprintf("%s:%s@tcp(mysql)/%s?interpolateParams=true&collation=utf8mb4_0900_ai_ci", conf.Username, conf.Password, conf.Schema)

	conn, err := sql.Open("mysql", cadena)
	if err != nil {
		return nil, err
	}

	err = conn.Ping()
	if err != nil {
		conn.Close()
		return nil, err
	}

	conn.SetConnMaxLifetime(10 * time.Second)
	return conn, nil
}

// Query sql.Query wrapper
func (h *DbHandler) Query(query string, args interface{}) (*sql.Rows, error) {
	c := config.Get().Context
	if c.Debug {
		input, err := json.Marshal(args)
		if err != nil {
			return nil, err
		}
		h.log(query, string(input))
	}
	return h.Conn.Query(query, args)
}

// QueryRow sql.QueryRow wrapper
func (h *DbHandler) QueryRow(query string, args ...interface{}) *sql.Row {
	c := config.Get().Context
	if c.Debug {
		h.log(query, args)
	}

	return h.Conn.QueryRow(query, args...)
}

func (h *DbHandler) log(query string, args interface{}) {
	arg := fmt.Sprintf("%v", args)
	str := strings.Replace(query, "?", arg, 1)
	h.logger.Println(str)
}
