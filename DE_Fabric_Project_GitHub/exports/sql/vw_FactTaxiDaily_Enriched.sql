-- Auto Generated (Do not modify) 056BD6CE2C40319413F7EB34255E8B4557E64AE2F4F8684E460D17100AD22E0C
CREATE   VIEW dbo.vw_FactTaxiDaily_Enriched AS
SELECT
  dd.[date]  AS [date],
  dd.[year]  AS [year],
  dd.[month] AS [month],

  dz.zone_key,
  dz.zone_name,
  dz.borough,
  dz.service_zone,

  f.trip_count,
  f.total_amount_usd,
  f.fare_amount_usd,
  f.tip_amount_usd,

  f.total_amount_eur,
  f.fare_amount_eur,
  f.tip_amount_eur,

  f.avg_trip_distance,
  f.avg_trip_minutes,
  f.avg_passenger_count,

  f.usd_per_eur,
  f.eur_per_usd,
  f.usa_gdp_usd
FROM dbo.FactTaxiDaily f
JOIN dbo.DimDate dd
  ON f.date_key = dd.date_key
JOIN dbo.DimZone dz
  ON f.zone_key = dz.zone_key;