-- Auto Generated (Do not modify) 5A40F5EB1BE438A2A25436F7609359F99E35B7FD7AA9031DDB9057C978BABE2C
CREATE   VIEW dbo.vw_MonthlyKPI AS
SELECT
    dd.[year]  AS [year],
    dd.[month] AS [month],

    MIN(dd.[date]) AS month_start_date,
    MAX(dd.[date]) AS month_end_date,

    SUM(f.trip_count) AS trip_count,

    SUM(f.total_amount_usd) AS total_amount_usd,
    SUM(f.fare_amount_usd)  AS fare_amount_usd,
    SUM(f.tip_amount_usd)   AS tip_amount_usd,

    SUM(f.total_amount_eur) AS total_amount_eur,
    SUM(f.fare_amount_eur)  AS fare_amount_eur,
    SUM(f.tip_amount_eur)   AS tip_amount_eur,

    -- Weighted averages (weighted by trip_count)
    CASE WHEN SUM(f.trip_count) = 0 THEN NULL
         ELSE SUM(f.avg_trip_distance * f.trip_count) / SUM(f.trip_count)
    END AS avg_trip_distance,

    CASE WHEN SUM(f.trip_count) = 0 THEN NULL
         ELSE SUM(f.avg_trip_minutes * f.trip_count) / SUM(f.trip_count)
    END AS avg_trip_minutes,

    CASE WHEN SUM(f.trip_count) = 0 THEN NULL
         ELSE SUM(f.avg_passenger_count * f.trip_count) / SUM(f.trip_count)
    END AS avg_passenger_count,

    AVG(f.usd_per_eur) AS avg_usd_per_eur,
    AVG(f.eur_per_usd) AS avg_eur_per_usd,

    MAX(f.usa_gdp_usd) AS usa_gdp_usd,

    COUNT(DISTINCT f.zone_key) AS active_zones,
    COUNT(*) AS zone_days_loaded
FROM dbo.FactTaxiDaily f
JOIN dbo.DimDate dd
    ON dd.date_key = f.date_key
GROUP BY dd.[year], dd.[month];