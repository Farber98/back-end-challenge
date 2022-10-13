package controllers

import (
	"net/http"
	"strconv"
	"th-amaro/internal/models"
	"th-amaro/internal/services"

	"github.com/labstack/echo/v4"
)

const (
	ERR_PARTIAL_SUCCESS = "ERROR. Successful inserts."
	ERR_PARTIAL_FAILURE = "ERROR. Failed inserts."
	OK_INSERTS_SUCCESS  = "Succesful inserts."
	ERR_ID_FORMAT       = "Wrong ID format."
	OK_SEARCH_SUCCESS   = "Succesful search."
	ERR_DEFAULT         = "ERROR. Please, call the administrator."
)

type ProductsController struct {
	services.ProductsService
}

func (controller *ProductsController) LoadRoutes(gr *echo.Group) {
	grProducts := gr.Group("/products")
	grProducts.POST("/batch-insert", controller.BatchInsert, pasetoAuth)
	grProducts.GET("/search", controller.Search, pasetoAuth)
}

func (controller *ProductsController) BatchInsert(c echo.Context) error {
	productJSON := models.ProductsJSON{}

	if err := c.Bind(&productJSON); err != nil {
		return c.JSON(http.StatusBadRequest, models.NewResponseWithoutData(ERR_DEFAULT))
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
			return c.JSON(http.StatusInternalServerError, models.NewResponseWithData(ERR_PARTIAL_SUCCESS, SuccededProducts))
		}

		SuccededProducts = append(SuccededProducts, dbProduct.Product)
	}

	if FailedProducts != nil || len(FailedProducts) > 0 {
		return c.JSON(http.StatusMultiStatus, models.NewResponseWithData(ERR_PARTIAL_FAILURE, FailedProducts))
	}

	return c.JSON(http.StatusOK, models.NewResponseWithData(OK_INSERTS_SUCCESS, SuccededProducts))
}

func (controller *ProductsController) Search(c echo.Context) error {
	var idInt uint64
	var err error

	prodId := c.QueryParam("id")
	prodName := c.QueryParam("name")
	prodTag := c.QueryParam("tag")

	if prodId != "" {
		idInt, err = strconv.ParseUint(prodId, 10, 32)
		if err != nil {
			return c.JSON(http.StatusBadRequest, models.NewResponseWithoutData(ERR_ID_FORMAT))
		}
	}
	search := &models.Product{IDProduct: uint16(idInt), Product: prodName, Tag: prodTag}
	resp, err := controller.ProductsService.Search(search)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, models.NewResponseWithoutData(ERR_DEFAULT))
	}

	return c.JSON(http.StatusOK, models.NewResponseWithData(OK_SEARCH_SUCCESS, resp))
}
