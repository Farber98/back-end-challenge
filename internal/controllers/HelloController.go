package controllers

import (
	"net/http"
	"th-amaro/internal/models"

	"github.com/labstack/echo/v4"
)

type HelloController struct{}

func (controller *HelloController) LoadRoutes(gr *echo.Group) {
	gr.GET("/hello", controller.Hello)
}

func (controller *HelloController) Hello(c echo.Context) error {
	return c.JSON(http.StatusOK, models.NewResponseWithoutData("Hello from th-amaro"))
}
