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
	grProducts := gr.Group("/products")
	grProducts.POST("/batch-insert", controller.BatchInsert)
	grProducts.GET("/search", controller.Search)
}

func (controller *ProductsController) BatchInsert(c echo.Context) error {
	productJSON := models.ProductsJSON{}

	if err := c.Bind(&productJSON); err != nil {
		return c.JSON(http.StatusBadRequest, models.NewResponseWithoutData(err.Error()))
	}

	var FailedProducts []*models.FailedInsertion
	var SuccededProducts []string

	for i := range productJSON.Products {

		product := &models.Product{
			IDProduct: uint16(productJSON.Products[i].ID),
			Name:      productJSON.Products[i].Name,
			Tags:      productJSON.Products[i].Tags,
		}

		// Product insertion
		dbProduct, err := controller.ProductsService.Insert(product)
		if err != nil {
			FailedProducts = append(FailedProducts,
				&models.FailedInsertion{IDProduct: product.IDProduct, Tags: product.Tags, Error: err})
			continue
		}

		// Tags insertion
		_, err = controller.ProductsService.InsertTags(product)
		if err != nil {
			return c.JSON(http.StatusInternalServerError, models.NewResponseWithData("ERROR. Successful inserts:", SuccededProducts))
		}

		SuccededProducts = append(SuccededProducts, dbProduct.Name)
	}

	if FailedProducts != nil || len(FailedProducts) > 0 {
		return c.JSON(http.StatusMultiStatus, models.NewResponseWithData("ERROR. Failed:", FailedProducts))
	}

	return c.JSON(http.StatusOK, models.NewResponseWithData("Succesful inserts.", SuccededProducts))
}

func (controller *ProductsController) Search(c echo.Context) error {
	return nil
}
