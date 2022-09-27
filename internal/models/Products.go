package models

type Product struct {
	IDProduct uint16   `json:"id_product,omitempty"`
	Name      string   `json:"product,omitempty"`
	Tags      []string `json:"tags,omitempty"`
}

type FailedInsertion struct {
	IDProduct uint16   `json:"id_product,omitempty"`
	Tags      []string `json:"tags,omitempty"`
	Error     error    `json:"error,omitempty"`
}

type ProductsJSON struct {
	Products []struct {
		ID   int      `json:"id"`
		Name string   `json:"name"`
		Tags []string `json:"tags"`
	} `json:"products"`
}
