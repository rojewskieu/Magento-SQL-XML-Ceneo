SELECT
'<?xml version="1.0" encoding="utf-8"?>
<offers xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" version="1">
<group name="other">'
UNION ALL
SELECT

CONCAT ('	<o id="',p.entity_id,'" ','url="https://www.websiteurl.pl/',url.`value`,'.html" ','price="',ROUND(dc.`value`,2),'" ','avail="1" set="0" ','weight="',ROUND(dc2.`value`,2),'" ','basket="1" ','stock="',ROUND(st.qty,0),'">',
'
	<cat>
			<![CDATA[',xm.`kategorie`,']]>
	</cat>
	<name>
			<![CDATA[',pv.`value`,']]>
	</name>
	<imgs>
			<main url="https://www.websiteurl.pl/media/catalog/product',pm.`value`,'" />
	</imgs>
	<desc>
			<![CDATA[',IFNULL(pt.`value`,' '),']]>
	</desc>
	<attrs>
			<a name="Producent">
			<![CDATA[',IFNULL(va.`value`,' '),']]>
			</a>
			<a name="EAN">
			<![CDATA[',IFNULL(en.`value`,' '),']]>
			</a>
	</attrs>
</o>')

FROM
	`catalog_product_entity` AS p
INNER JOIN `catalog_product_entity_varchar` AS pv ON pv.`entity_id` = p.`entity_id`
AND pv.`attribute_id` = 71 -- nazwa
LEFT OUTER JOIN `catalog_product_entity_text` AS pt ON p.`entity_id` = pt.`entity_id` 
AND pt.`attribute_id` = 72 -- opis
LEFT OUTER JOIN `catalog_product_entity_varchar` AS en ON en.`entity_id` = p.`entity_id`
AND en.`attribute_id` = 132 -- ean
INNER JOIN `catalog_product_entity_int` AS sta ON sta.`entity_id` = p.`entity_id`
AND sta.`attribute_id` = 102 -- widocznoœæ
INNER JOIN `catalog_product_entity_int` AS stan ON stan.`entity_id` = p.`entity_id`
AND stan.`attribute_id` = 96 -- status

LEFT OUTER JOIN `catalog_product_entity_int` AS sta2 ON sta2.`entity_id` = p.`entity_id`
AND sta2.`attribute_id` = 81 -- brand
LEFT OUTER JOIN `eav_attribute_option_value` AS va ON va.option_id = sta2.`value`

INNER JOIN `catalog_product_entity_decimal` AS dc2 ON dc2.`entity_id` = p.`entity_id`
AND dc2.`attribute_id` = 80 -- waga
INNER JOIN `catalog_product_entity_decimal` AS dc ON dc.`entity_id` = p.`entity_id`
AND dc.`attribute_id` = 75 -- cena 
INNER JOIN `catalog_product_entity_varchar` AS url ON url.`entity_id` = p.`entity_id`
AND url.`attribute_id` = 97 -- url
INNER JOIN `cataloginventory_stock_item` AS st ON st.`item_id` = p.`entity_id`  -- cena
INNER JOIN `catalog_category_product` AS cp ON cp.`product_id` = p.`entity_id`

INNER JOIN concat AS xm ON xm.sku = p.`entity_id`
  
LEFT JOIN `catalog_product_entity_media_gallery` AS pm ON pm.`entity_id` = p.`entity_id`
AND pm.`attribute_id` = 88 -- media

WHERE sta.`value` = 4 and stan.`value` = 1
GROUP BY
p.entity_id
-- cp.`product_id`
-- pm.`entity_id`
-- LIMIT 15
UNION ALL
SELECT
'</group>
</offers>'