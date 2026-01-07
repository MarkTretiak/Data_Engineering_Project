-- Auto Generated (Do not modify) C09CBA355C6F670FA84C0095E8B88D7351288A74B9497CD1985093A6A3CBC767
CREATE   VIEW dbo.vw_UnifiedMonthly_Long AS
/* =========================
   TAXI monthly KPIs -> LONG
   ========================= */
SELECT
    (k.[year]*10000 + k.[month]*100 + 1) AS date_key,
    k.[year],
    k.[month],
    CAST(k.month_start AS date) AS month_start,
    CAST(k.month_end   AS date) AS month_end,
    'taxi' AS domain,
    v.metric_name,
    v.metric_value,
    v.unit
FROM dbo.vw_MonthlyKPI_Safe k
CROSS APPLY (VALUES
    ('trip_count',          CAST(k.trip_count          AS decimal(18,6)), 'trips'),

    ('total_amount_usd',    CAST(k.total_amount_usd    AS decimal(18,6)), 'USD'),
    ('fare_amount_usd',     CAST(k.fare_amount_usd     AS decimal(18,6)), 'USD'),
    ('tip_amount_usd',      CAST(k.tip_amount_usd      AS decimal(18,6)), 'USD'),

    ('total_amount_eur',    CAST(k.total_amount_eur    AS decimal(18,6)), 'EUR'),
    ('fare_amount_eur',     CAST(k.fare_amount_eur     AS decimal(18,6)), 'EUR'),
    ('tip_amount_eur',      CAST(k.tip_amount_eur      AS decimal(18,6)), 'EUR'),

    ('avg_trip_distance',   CAST(k.avg_trip_distance   AS decimal(18,6)), 'miles'),
    ('avg_trip_minutes',    CAST(k.avg_trip_minutes    AS decimal(18,6)), 'minutes'),
    ('avg_passenger_count', CAST(k.avg_passenger_count AS decimal(18,6)), 'passengers'),

    ('usd_per_eur',         CAST(k.usd_per_eur         AS decimal(18,6)), 'USD/EUR'),
    ('eur_per_usd',         CAST(k.eur_per_usd         AS decimal(18,6)), 'EUR/USD'),

    ('usa_gdp_usd',         CAST(k.usa_gdp_usd         AS decimal(18,2)), 'USD'),

    ('active_zones_count',  CAST(k.active_zones_count  AS decimal(18,6)), 'zones'),
    ('zone_days_count',     CAST(k.zone_days_count     AS decimal(18,6)), 'zone-days')
) v(metric_name, metric_value, unit)
WHERE v.metric_value IS NOT NULL

UNION ALL

/* =========================
   AIR quality monthly -> LONG
   ========================= */
SELECT
    f.date_key,
    d.[year],
    d.[month],
    CAST(d.[date] AS date) AS month_start,
    EOMONTH(CAST(d.[date] AS date)) AS month_end,
    'air' AS domain,
    CONCAT(m.parameter, '_', s.stat) AS metric_name,
    CAST(s.metric_value AS decimal(18,6)) AS metric_value,
    m.unit
FROM dbo.FactAirQualityMonthly f
JOIN dbo.DimDate d
    ON d.date_key = f.date_key
JOIN dbo.DimAirQualityMetric m
    ON m.metric_key = f.metric_key
CROSS APPLY (VALUES
    ('avg', f.avg_value),
    ('min', f.min_value),
    ('max', f.max_value)
) s(stat, metric_value)
WHERE s.metric_value IS NOT NULL;