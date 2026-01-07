-- Auto Generated (Do not modify) D7D11786926C4682CD6FF110AA749CADD6B48CBE2E140F3BA24C4AD122C70354
CREATE   VIEW dbo.vw_MonthlyKPI_Safe AS
SELECT
    [year],
    [month],
    month_start_date AS month_start,
    month_end_date   AS month_end,

    trip_count,

    total_amount_usd,
    fare_amount_usd,
    tip_amount_usd,

    total_amount_eur,
    fare_amount_eur,
    tip_amount_eur,

    avg_trip_distance,
    avg_trip_minutes,
    avg_passenger_count,

    avg_usd_per_eur AS usd_per_eur,
    avg_eur_per_usd AS eur_per_usd,

    usa_gdp_usd,

    active_zones     AS active_zones_count,
    zone_days_loaded AS zone_days_count
FROM dbo.vw_MonthlyKPI;