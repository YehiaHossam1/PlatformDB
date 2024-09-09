Use platformdb1;

# Brand Procedures
call AddBrandValueShare(Null,Null,Null,NULL,Null);
call AddBrandVolumeShare(Null,Null,Null,NULL,Null);
CALL CalculateBrandFairShare (Null,Null,Null,Null,Null);

call UpdateBrandValueIdxAVMV();
call UpdateBrandValueIdxLY();

-- call CalcualteValueVolumeShare(''); 
# Dashboard Procedures
call rgm_index();

# Market Procedures
call UpdateRegionSalesGrowth();
call UpdateMarketShare();



# Promotions Procedures
call Calculate_PromoVolumeSales_P12M();
call Calculate_VSOD_LY();
call Calculate_VSOD_P12M();
