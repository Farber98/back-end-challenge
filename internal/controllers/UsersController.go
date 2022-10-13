package controllers

import (
	"net/http"
	"th-amaro/internal/config"
	"th-amaro/internal/helpers"
	"th-amaro/internal/models"
	"th-amaro/internal/token"
	"time"

	"github.com/labstack/echo/v4"
)

const ERR_INVALID_CREDENTIALS = "ERROR. Invalid credentials."
const OK_LOGIN_SUCCESS = "Succesful login."

type UsersController struct {
}

func (controller *UsersController) LoadRoutes(gr *echo.Group) {
	gr.POST("/login", controller.Login)
}

func (controller *UsersController) Login(c echo.Context) error {
	loginReq := models.LoginRequest{}

	if err := c.Bind(&loginReq); err != nil {
		return c.JSON(http.StatusInternalServerError, models.NewResponseWithoutData(ERR_DEFAULT))
	}

	if loginReq.Username != config.Get().User.Username || helpers.GetMD5Hash(loginReq.Password) != config.Get().User.Password {
		return c.JSON(http.StatusUnauthorized, models.NewResponseWithoutData(ERR_INVALID_CREDENTIALS))
	}

	tokenMaker := token.ConstructTokenMaker()
	accessToken, err := tokenMaker.Paseto.CreateToken(loginReq.Username, 15*time.Minute)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, models.NewResponseWithoutData(ERR_DEFAULT))
	}

	loginResponse := &models.LoginResponse{AccessToken: accessToken, CreatedAt: time.Now(), ExpiresAt: time.Now().Add(15 * time.Minute)}

	return c.JSON(http.StatusOK, models.NewResponseWithData(OK_LOGIN_SUCCESS, loginResponse))
}
