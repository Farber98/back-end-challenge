package controllers

import (
	"net/http"
	"th-amaro/internal/models"
	"th-amaro/internal/services"

	"github.com/labstack/echo/v4"
)

type ProductsController struct {
	services.ProductsService
}

func (controller *ProductsController) LoadRoutes(gr *echo.Group) {
	grTokens := gr.Group("/products")
	grTokens.POST("/batch", controller.BatchInsert)
	grTokens.GET("/search", controller.Search)
}

func (controller *ProductsController) BatchInsert(c echo.Context) error {
	productJSON := models.ProductsJSON{}

	if err := c.Bind(&productJSON); err != nil {
		return c.JSON(http.StatusBadRequest, models.NewResponseWithoutData(err.Error()))
	}

	var FailedProducts []*models.FailedInsertion

	for i := range productJSON {
		_, err := controller.ProductsService.Insert(productJSON[i])
		if err != nil {
			FailedProducts = append(FailedProducts, &models.FailedInsertion{IDProduct: productJSON[i].IDProduct, Error: err})
			continue
		}
	}
	if FailedProducts != nil || len(FailedProducts) > 0 {
		return c.JSON(http.StatusOK, models.NewResponseWithData("Inserted with errors.", FailedProducts))
	}

	return c.JSON(http.StatusOK, models.NewResponseWithoutData("Succesful insert."))
}

func (controller *ProductsController) Search(c echo.Context) error {
	return nil
}
