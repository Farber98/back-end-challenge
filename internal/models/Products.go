package models

type Product struct {
	IDProduct uint16   `json:"id_product,omitempty"`
	Product   string   `json:"product,omitempty"`
	Tags      []string `json:"tags,omitempty"`
	Tag       string   `json:"tag,omitempty"`
}

type FailedProduct struct {
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

type SearchProductResult struct {
	RowCount    uint        `json:"row_count,omitempty"`
	QueryResult interface{} `json:"query_result,omitempty"`
	PageSize    uint        `json:"page_size,omitempty"`
	PageNumber  uint        `json:"page_number,omitempty"`
}
