-- Auto Generated (Do not modify) 680B74BFB2BBA197B42338E0780349255AE215672957BAF6246FFC19510E61C3
CREATE   VIEW dbo.vw_AirQualityMonthly_Enriched AS
SELECT
    d.date_key,
    d.[date]          AS month_date,
    d.[year]          AS [year],
    d.[month]         AS [month],

    m.metric_key,
    m.parameter,
    m.unit,

    f.avg_value,
    f.min_value,
    f.max_value,
    f.days_count,
    f.sensor_count
FROM dbo.FactAirQualityMonthly f
JOIN dbo.DimDate d
    ON f.date_key = d.date_key
JOIN dbo.DimAirQualityMetric m
    ON f.metric_key = m.metric_key;