package controllers

import (
	"net/http"
	"net/http/httptest"
	"net/url"
	"strings"
	"testing"

	_ "github.com/go-sql-driver/mysql"
	"github.com/labstack/echo/v4"
	"github.com/stretchr/testify/assert"
)

const err_id_format = `{"message":"` + ERR_ID_FORMAT + `"}`
const err_default = `{"message":"` + ERR_DEFAULT + `"}`

func TestSearchWrongIDFormat(t *testing.T) {
	//	search_query := `CALL am_products_search \(?\)`
	e := echo.New()
	controller := &ProductsController{}
	q := make(url.Values)
	rec := httptest.NewRecorder()

	q.Set("id", "xd")
	req := httptest.NewRequest(http.MethodGet, "/products/search/?"+q.Encode(), nil)
	c := e.NewContext(req, rec)

	if assert.NoError(t, controller.Search(c)) {
		newl := len(rec.Body.String()) - 1

		assert.Equal(t, http.StatusBadRequest, rec.Code)
		assert.Equal(t, err_id_format, rec.Body.String()[:newl])
	}

}

func TestInsertWrongBinding(t *testing.T) {
	wrongJson := `{"name":"Jon Snow","email":"jon@labstack.com"}`
	e := echo.New()
	controller := &ProductsController{}
	rec := httptest.NewRecorder()

	req := httptest.NewRequest(http.MethodPost, "/products/batch-insert", strings.NewReader(wrongJson))
	c := e.NewContext(req, rec)

	if assert.NoError(t, controller.BatchInsert(c)) {
		newl := len(rec.Body.String()) - 1

		assert.Equal(t, http.StatusBadRequest, rec.Code)
		assert.Equal(t, err_default, rec.Body.String()[:newl])
	}

}
