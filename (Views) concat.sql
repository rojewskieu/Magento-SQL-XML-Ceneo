SELECT
	`catalog_product`.`sku` AS `sku`,
	group_concat(
		`catalog_product`.`kk`
		ORDER BY
			`catalog_product`.`c_level` ASC SEPARATOR ' / '
	) AS `kategorie`
FROM
	`catalog_product`
GROUP BY
	`catalog_product`.`sku`