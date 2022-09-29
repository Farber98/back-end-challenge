package controllers

import (
	"net/http"
	"net/http/httptest"
	"net/url"
	"testing"

	"github.com/labstack/echo/v4"
	"github.com/stretchr/testify/assert"
)

const err_id_format = `{"message":"` + ERR_ID_FORMAT + `"}`

func TestSearch(t *testing.T) {
	e := echo.New()
	controller := &ProductsController{}
	q := make(url.Values)
	rec := httptest.NewRecorder()

	t.Run("400 Wrong ID Format", func(t *testing.T) {
		q.Set("id", "xd")
		req := httptest.NewRequest(http.MethodGet, "/products/search/?"+q.Encode(), nil)
		c := e.NewContext(req, rec)

		if assert.NoError(t, controller.Search(c)) {
			newl := len(rec.Body.String()) - 1

			assert.Equal(t, http.StatusBadRequest, rec.Code)
			assert.Equal(t, err_id_format, rec.Body.String()[:newl])
		}
	})

}
