package models

type Product struct {
	IDProduct uint16   `json:"id_product,omitempty"`
	Name      string   `json:"name,omitempty"`
	Tags      []string `json:"tags,omitempty"`
}

type ProductsJSON []*Product

type FailedInsertion struct {
	IDProduct uint16 `json:"id_product,omitempty"`
	Error     error  `json:"error,omitempty"`
}
