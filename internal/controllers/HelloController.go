package controllers

import (
	"net/http"
	"th-amaro/internal/models"

	"github.com/labstack/echo/v4"
)

const OK_HELLO = "Hello from th-amaro."

type HelloController struct{}

func (controller *HelloController) LoadRoutes(gr *echo.Group) {
	gr.GET("/hello", controller.Hello)
}

func (controller *HelloController) Hello(c echo.Context) error {
	return c.JSON(http.StatusOK, models.NewResponseWithoutData(OK_HELLO))
}
