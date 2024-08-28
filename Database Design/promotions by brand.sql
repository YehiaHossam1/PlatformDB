use platformdb1;

CREATE TABLE `promotionbybrand` (
  `id` int NOT NULL auto_increment primary key,
  `brand_id` int DEFAULT NULL,
  `uplift` decimal(10,2) DEFAULT NULL,
  `promo_volume_sales_p12m` decimal(10,2) DEFAULT NULL,
  `vsod_p12m` decimal(10,2) DEFAULT NULL,
  `vsod_lya` decimal(10,2) DEFAULT NULL,
  `value_uplift` decimal(10,2) DEFAULT NULL,
  `value_uplift_lya` decimal(10,2) DEFAULT NULL,
  `discount_depth` decimal(10,2) DEFAULT NULL,
  `promo_efficiency` decimal(10,2) DEFAULT NULL,
  `last_update` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  
  FOREIGN KEY (brand_id) REFERENCES brand(brand_id) ON DELETE CASCADE ON UPDATE CASCADE
);
