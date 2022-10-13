package controllers

import (
	"net/http"
	"strings"
	"th-amaro/internal/models"
	"th-amaro/internal/token"

	"github.com/labstack/echo/v4"
)

const (
	authorizationHeaderKey    = "authorization"
	authorizationTypeBearer   = "bearer"
	authorizationPayloadKey   = "authorization_payload"
	ERR_AUTH_NOT_PROVIDED     = "ERROR. Authorization header is not provided"
	ERR_INVALID_HEADER_FORMAT = "ERROR. Invalid authorization header format"
	ERR_UNSUPPORTED_AUTH      = "ERROR. Unsupported authorization type: "
)

func pasetoAuth(next echo.HandlerFunc) echo.HandlerFunc {
	return func(c echo.Context) (err error) {
		authorizationHeader := c.Request().Header.Get(authorizationHeaderKey)

		if len(authorizationHeader) == 0 {
			return c.JSON(http.StatusUnauthorized, models.NewResponseWithoutData(ERR_AUTH_NOT_PROVIDED))
		}

		fields := strings.Fields(authorizationHeader)
		if len(fields) < 2 {
			return c.JSON(http.StatusUnauthorized, models.NewResponseWithoutData(ERR_INVALID_HEADER_FORMAT))
		}

		authorizationType := strings.ToLower(fields[0])
		if authorizationType != authorizationTypeBearer {
			return c.JSON(http.StatusUnauthorized, models.NewResponseWithoutData(ERR_INVALID_HEADER_FORMAT+authorizationType))
		}

		accessToken := fields[1]
		pasetoMaker := token.ConstructTokenMaker().Paseto
		payload, err := pasetoMaker.VerifyToken(accessToken)
		if err != nil {
			return c.JSON(http.StatusUnauthorized, models.NewResponseWithoutData(err.Error()))
		}

		c.Set(authorizationPayloadKey, payload)
		next(c)
		return nil
	}
}
