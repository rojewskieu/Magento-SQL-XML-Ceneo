SELECT
	`p`.`entity_id` AS `sku`,
	`fl`.`path` AS `c_path`,
	`fl`.`level` AS `c_level`,
	`fl`.`name` AS `kk`,
	`fl`.`store_id` AS `store`
FROM
	(
		(
			`catalog_product_entity` `p`
			LEFT JOIN `catalog_category_product` `cp` ON (
				(
					`p`.`entity_id` = `cp`.`product_id`
				)
			)
		)
		JOIN `catalog_category_flat_store_1` `fl` ON (
			(
				`fl`.`entity_id` = `cp`.`category_id`
			)
		)
	)
WHERE
	(
		(`fl`.`level` > 1)
		AND (`fl`.`store_id` = 1)
		AND (`fl`.`path` LIKE '1/2%')
	)
GROUP BY
	`fl`.`level`,
	`p`.`sku`