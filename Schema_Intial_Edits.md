# Database Schema Edits

![Platform](./Platform%20Updated%20EER.png)

# Tables 

## Raw Data 
Main table we ingest the data in it valueSales,volumeSales And WOD

1. **ID** Primary key of the table
2. **sku_ID** Foreign key of the sku table
2. **reigon_ID** Foreign key of the reigon table
2. **size_bracket_ID** Foreign key of the sizebracket table
2. **brand_ID** Foreign key of the brand table
2. **category_ID** Foreign key of the category table
2. **date_id** Foreign key of the dates table
2. **value_sales** The value of sales of all the market
2. **volume_sales** The number of products sold of all the market
3. **WOD** Weighted distribution

## SKU 
Table which got sku id and it's names

1. **sku_name** name of each sku
2. **sku_ID** primary key of the sku table


## Reigon 
Table which got Region id and it's names
`sorry for misspelling while creating the table`


1. **Reigon_name** name of each Reigon
2. **Reigon_ID** primary key of the Reigon table

## Category
Table which got Category id and it's names

1. **Category_name** name of each Category
2. **Category_ID** primary key of the Category table

## size bracket 
Table which got size_bracket id and it's names

1. **size_bracket_name** name of each size_bracket
2. **size_bracket_id** primary key of the size_bracket table

## Brand
Table which got brand id,names and some brands calculations which was took from dashboard table

1. **brand_name** name of each brand
2. **brand_ID** primary key of the brand table
3. **brand_value_idx_avmv** Measures the brand value performance relative to the market average.

```math
Brand\ Value\ Index = \frac{Brand\ Value\ Sales}{Average\ Market\ Value\ Sales} 
```
3. **brand_value_idx_ly** Evaluates how the brand's value sales have changed relative to the previous
year.

```math
Brand\ Value\ Index = \frac{Value\ Sales\ Of\ Your\ Brand\ This\ Year}{Value\ Sales\ Of\ Your\ Brand\ Last\ Year} 
```

## Dates
Table which takes date and add year,month and quarter columns

1. **date_id** primary key of the date table
2. **date** Date which was taken from data
3. **year** year which auto calculated from the date
3. **month** month which auto calculated from the date
3. **quarter** quarter which auto calculated from the date

## Promotions
Table which shows if the product promoted or not

1. **ID** primary key of the promotions table
2. **Rawdata_id** Id of the raw data table (Foreign key)
3. **Status** Show if the raw of this data sku is promoted or not 

## Distribution Effeciency 
Focuses on the efficiency of product distribution, calculated by dividing the
value sales by the weighted distribution (WTD).

1. **DistributionEfficiency** Measures how effectively value sales are tracked or achieved in relation
to the weighted distribution.
```math
Distribution\ Efficiency= \frac{Value\ Sales}{WOD} 
```
2. **rawdata_id** which takes the data from rawdata table

## Dashboard 
Same as the given documentation 

I removed brand value index amv and brand value index ly  and added them to the brand id 

**brand_id** the brand id is to relate this table with brand table

**trade_vs_brand_idx** to be calcualted after brand fair share

**price_change_idx** to be calculated after nowing the manufacturers


## BrandPromotion 

Same as documentation to be deleviered by tomorrow.
