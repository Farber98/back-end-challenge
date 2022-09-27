package services

import (
	"database/sql"
	"encoding/json"
	"th-amaro/internal/database"
	"th-amaro/internal/models"
)

type ProductsService struct{}

// Inserts a product in the DB.
func (service *ProductsService) Insert(p *models.Product) (*models.Product, error) {
	jsonPayload, err := json.Marshal(p)
	if err != nil {
		return nil, err
	}

	db := database.ConstructDB()
	row := db.QueryRow("CALL am_products_insert(?)", string(jsonPayload))

	var out database.SpOut

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
