CREATE TABLE [dbo].[FactAirQualityMonthly] (

	[year] int NULL, 
	[month] int NULL, 
	[parameter] varchar(8000) NULL, 
	[unit] varchar(8000) NULL, 
	[avg_value] float NULL, 
	[min_value] float NULL, 
	[max_value] float NULL, 
	[days_count] bigint NULL, 
	[sensor_count] bigint NULL, 
	[date_key] bigint NULL, 
	[metric_key] bigint NULL
);