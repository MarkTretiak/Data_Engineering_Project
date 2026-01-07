-- Auto Generated (Do not modify) D859C4CED5DDB23B63E4A76776932179B129B6F06350935949232F4D085D00AA
CREATE   VIEW dbo.vw_TopZonesMonthly AS
WITH zone_month AS (
    SELECT
        dd.[year],
        dd.[month],
        f.zone_key,

        SUM(f.trip_count) AS trip_count,

        SUM(f.total_amount_usd) AS total_amount_usd,
        SUM(f.total_amount_eur) AS total_amount_eur,

        SUM(f.fare_amount_usd) AS fare_amount_usd,
        SUM(f.tip_amount_usd)  AS tip_amount_usd,

        SUM(f.fare_amount_eur) AS fare_amount_eur,
        SUM(f.tip_amount_eur)  AS tip_amount_eur
    FROM dbo.FactTaxiDaily f
    JOIN dbo.DimDate dd
        ON dd.date_key = f.date_key
    GROUP BY dd.[year], dd.[month], f.zone_key
)
SELECT
    *,
    DENSE_RANK() OVER (PARTITION BY [year], [month] ORDER BY trip_count DESC) AS trip_rank,
    DENSE_RANK() OVER (PARTITION BY [year], [month] ORDER BY total_amount_usd DESC) AS revenue_rank_usd
FROM zone_month;