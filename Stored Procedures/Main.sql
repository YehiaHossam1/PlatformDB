Use platformdb1;

# Brand Procedures
call UpdateBrandValueIdxAVMV();
call UpdateBrandValueIdxLY();

# Dashboard Procedures
call rgm_index();

# Market Procedures
call UpdateRegionSalesGrowth();
-- call UpdateMarketShare();
