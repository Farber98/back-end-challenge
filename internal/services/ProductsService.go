package services

import (
	"database/sql"
	"encoding/json"
	"th-amaro/internal/infraestructure"
	"th-amaro/internal/models"
)

type ProductsService struct{}

// Inserts a product in the DB.
func (service *ProductsService) Insert(p *models.Product) (*models.Product, error) {
	jsonPayload, err := json.Marshal(p)
	if err != nil {
		return nil, err
	}

	db := infraestructure.ConstructDB()
	row := db.QueryRow("CALL am_products_insert(?)", string(jsonPayload))

	var out infraestructure.SpOut
	if err := row.Scan(&out); err != nil && err != sql.ErrNoRows {
		return nil, err
	}
	if out == nil {
		return nil, nil
	}

	if err := json.Unmarshal(out, p); err != nil {
		return nil, err
	}

	return p, nil
}

// Inserts product tags in the DB.
func (service *ProductsService) InsertTags(p *models.Product) ([]*models.Product, error) {
	jsonPayload, err := json.Marshal(p)
	if err != nil {
		return nil, err
	}

	db := infraestructure.ConstructDB()
	row := db.QueryRow("CALL am_product_tags_insert(?)", string(jsonPayload))

	var out infraestructure.SpOut

	if err := row.Scan(&out); err != nil && err != sql.ErrNoRows {
		return nil, err
	}
	if out == nil {
		return nil, nil
	}
	prodArray := make([]*models.Product, 0)
	if err := json.Unmarshal(out, &prodArray); err != nil {
		return nil, err
	}

	return prodArray, nil
}

func (service *ProductsService) Search(search *models.Product) (result *models.SearchProductResult, err error) {
	jsonSearch, err := json.Marshal(search)
	if err != nil {
		return nil, err
	}

	cache := infraestructure.ConstructCache()

	val, ok := cache.Get(string(jsonSearch))
	if !ok {
		db := infraestructure.ConstructDB()

		row := db.QueryRow("CALL am_products_search(?)", string(jsonSearch))

		var out infraestructure.SpOut
		if err := row.Scan(&out); err != nil && err != sql.ErrNoRows {
			return nil, err
		}
		if out == nil {
			return nil, nil
		}

		result = &models.SearchProductResult{}

		if err := json.Unmarshal(out, &result); err != nil {
			return nil, err
		}

		cache.Set(string(jsonSearch), result)

	} else {
		result = val.(*models.SearchProductResult)
	}

	return result, nil
}
