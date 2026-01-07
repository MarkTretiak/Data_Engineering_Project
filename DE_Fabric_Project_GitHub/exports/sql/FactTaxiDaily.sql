CREATE TABLE [dbo].[FactTaxiDaily] (

	[date_key] int NOT NULL, 
	[zone_key] int NOT NULL, 
	[trip_count] bigint NULL, 
	[total_amount_usd] float NULL, 
	[fare_amount_usd] float NULL, 
	[tip_amount_usd] float NULL, 
	[total_amount_eur] float NULL, 
	[fare_amount_eur] float NULL, 
	[tip_amount_eur] float NULL, 
	[avg_trip_distance] float NULL, 
	[avg_trip_minutes] float NULL, 
	[avg_passenger_count] float NULL, 
	[usa_gdp_usd] float NULL, 
	[usd_per_eur] float NULL, 
	[eur_per_usd] float NULL
);