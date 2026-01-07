-- Auto Generated (Do not modify) EA6D80BB6AAC265227C497192A25BD6F20809433D73193FFF03B7F0743662C50
CREATE   VIEW dbo.vw_UnifiedMonthly_Long_Complete
AS
WITH
TaxiMonths AS (
    SELECT DISTINCT
        k.[year],
        k.[month],
        k.month_start_date AS month_date,
        CAST(k.[year] * 10000 + k.[month] * 100 + 1 AS int) AS date_key,
        k.month_start_date AS month_start,
        k.month_end_date   AS month_end
    FROM dbo.vw_MonthlyKPI k
),
TaxiMetricList AS (
    -- keep FINAL/standard metric names here (even if source column names differ)
    SELECT 'trip_count' AS metric_name, 'trips' AS unit UNION ALL
    SELECT 'total_amount_usd','USD' UNION ALL
    SELECT 'fare_amount_usd','USD' UNION ALL
    SELECT 'tip_amount_usd','USD' UNION ALL
    SELECT 'total_amount_eur','EUR' UNION ALL
    SELECT 'fare_amount_eur','EUR' UNION ALL
    SELECT 'tip_amount_eur','EUR' UNION ALL
    SELECT 'avg_trip_distance','miles' UNION ALL
    SELECT 'avg_trip_minutes','minutes' UNION ALL
    SELECT 'avg_passenger_count','passengers' UNION ALL
    SELECT 'usd_per_eur','USD/EUR' UNION ALL          -- maps from avg_usd_per_eur
    SELECT 'eur_per_usd','EUR/USD' UNION ALL          -- maps from avg_eur_per_usd
    SELECT 'usa_gdp_usd','USD' UNION ALL
    SELECT 'active_zones_count','zones' UNION ALL     -- maps from active_zones
    SELECT 'zone_days_count','zone-days'              -- maps from zones_days_loaded
),
TaxiValues AS (
    SELECT
        k.[year],
        k.[month],
        k.month_start_date AS month_date,
        CAST(k.[year] * 10000 + k.[month] * 100 + 1 AS int) AS date_key,
        v.metric_name,
        TRY_CAST(v.metric_value AS float) AS metric_value
    FROM dbo.vw_MonthlyKPI k
    CROSS APPLY (VALUES
        ('trip_count',            k.trip_count),
        ('total_amount_usd',      k.total_amount_usd),
        ('fare_amount_usd',       k.fare_amount_usd),
        ('tip_amount_usd',        k.tip_amount_usd),
        ('total_amount_eur',      k.total_amount_eur),
        ('fare_amount_eur',       k.fare_amount_eur),
        ('tip_amount_eur',        k.tip_amount_eur),
        ('avg_trip_distance',     k.avg_trip_distance),
        ('avg_trip_minutes',      k.avg_trip_minutes),
        ('avg_passenger_count',   k.avg_passenger_count),

        -- FIXED mappings:
        ('usd_per_eur',           k.avg_usd_per_eur),
        ('eur_per_usd',           k.avg_eur_per_usd),
        ('usa_gdp_usd',           k.usa_gdp_usd),
        ('active_zones_count',    k.active_zones),
        ('zone_days_count',       k.zone_days_loaded)
    ) v(metric_name, metric_value)
),
TaxiComplete AS (
    SELECT
        m.date_key,
        m.month_date,
        m.[year],
        m.[month],
        m.month_start,
        m.month_end,
        CAST('taxi' AS varchar(10)) AS domain,
        l.metric_name,
        v.metric_value,                 -- stays NULL if missing (this is what we want)
        l.unit
    FROM TaxiMonths m
    CROSS JOIN TaxiMetricList l
    LEFT JOIN TaxiValues v
        ON v.[year] = m.[year]
       AND v.[month] = m.[month]
       AND v.metric_name = l.metric_name
),

AirValues AS (
    SELECT
        f.date_key,
        f.month_date,
        f.[year],
        f.[month],
        f.month_date AS month_start,
        EOMONTH(f.month_date) AS month_end,
        CAST('air' AS varchar(10)) AS domain,
        CONCAT(f.parameter, '_avg') AS metric_name,
        TRY_CAST(f.avg_value AS float) AS metric_value,
        f.unit
    FROM dbo.vw_AirQualityMonthly_Enriched f

    UNION ALL
    SELECT
        f.date_key,
        f.month_date,
        f.[year],
        f.[month],
        f.month_date,
        EOMONTH(f.month_date),
        CAST('air' AS varchar(10)),
        CONCAT(f.parameter, '_min'),
        TRY_CAST(f.min_value AS float),
        f.unit
    FROM dbo.vw_AirQualityMonthly_Enriched f

    UNION ALL
    SELECT
        f.date_key,
        f.month_date,
        f.[year],
        f.[month],
        f.month_date,
        EOMONTH(f.month_date),
        CAST('air' AS varchar(10)),
        CONCAT(f.parameter, '_max'),
        TRY_CAST(f.max_value AS float),
        f.unit
    FROM dbo.vw_AirQualityMonthly_Enriched f
)

SELECT * FROM TaxiComplete
UNION ALL
SELECT * FROM AirValues;