package controllers

import (
	"net/http"
	"strconv"
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

	var FailedProducts []*models.FailedProduct
	var SuccededProducts []string

	for i := range productJSON.Products {

		product := &models.Product{
			IDProduct: uint16(productJSON.Products[i].ID),
			Product:   productJSON.Products[i].Name,
			Tags:      productJSON.Products[i].Tags,
		}

		// Product insertion
		dbProduct, err := controller.ProductsService.Insert(product)
		if err != nil {
			FailedProducts = append(FailedProducts,
				&models.FailedProduct{IDProduct: product.IDProduct, Tags: product.Tags, Error: err})
			continue
		}

		// Tags insertion
		_, err = controller.ProductsService.InsertTags(product)
		if err != nil {
			return c.JSON(http.StatusInternalServerError, models.NewResponseWithData("ERROR. Successful inserts.", SuccededProducts))
		}

		SuccededProducts = append(SuccededProducts, dbProduct.Product)
	}

	if FailedProducts != nil || len(FailedProducts) > 0 {
		return c.JSON(http.StatusMultiStatus, models.NewResponseWithData("ERROR. Failed.", FailedProducts))
	}

	return c.JSON(http.StatusOK, models.NewResponseWithData("Succesful inserts.", SuccededProducts))
}

func (controller *ProductsController) Search(c echo.Context) error {

	prodId := c.QueryParam("id")
	prodName := c.QueryParam("name")
	prodTag := c.QueryParam("tag")

	var idInt uint64
	var err error
	if prodId != "" {
		idInt, err = strconv.ParseUint(prodId, 10, 32)
		if err != nil {
			return c.JSON(http.StatusBadRequest, models.NewResponseWithoutData(err.Error()))
		}
	}
	search := &models.Product{IDProduct: uint16(idInt), Product: prodName, Tag: prodTag}
	resp, err := controller.ProductsService.Search(search)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, models.NewResponseWithoutData(err.Error()))
	}

	return c.JSON(http.StatusOK, models.NewResponseWithData("Search results.", resp))
}
