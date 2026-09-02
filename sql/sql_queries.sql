-- Q1: Which hotel has the highest cancellation percentage?
SELECT
    hotel,
    COUNT(*) as total_bookings,
    SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) as cancelled_bookings,
    ROUND(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as cancellation_percentage
FROM hotel_bookings
GROUP BY hotel
ORDER BY cancellation_percentage DESC;

-- Q2: Which months receive the highest number of bookings?
SELECT
    arrival_date_month,
    COUNT(*) as total_bookings
FROM hotel_bookings
GROUP BY arrival_date_month
ORDER BY total_bookings DESC;

-- Q3: Which customer types have the highest average ADR?
SELECT
    customer_type,
    ROUND(AVG(adr), 2) as avg_adr,
    COUNT(*) as total_bookings
FROM hotel_bookings
WHERE adr > 0
GROUP BY customer_type
ORDER BY avg_adr DESC;

-- Q4: Lead time vs Cancellation - create groups
SELECT
    CASE
        WHEN lead_time BETWEEN 0 AND 30 THEN '0 to 30 days'
        WHEN lead_time BETWEEN 31 AND 90 THEN '31 to 90 days'
        WHEN lead_time BETWEEN 91 AND 180 THEN '91 to 180 days'
        ELSE 'More than 180 days'
    END as lead_time_group,
    COUNT(*) as total_bookings,
    SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) as cancelled_bookings,
    ROUND(SUM(CASE WHEN is_canceled = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) as cancellation_rate
FROM hotel_bookings
GROUP BY lead_time_group
ORDER BY cancellation_rate DESC;

-- Q5: Top 5 countries generating highest completed bookings
SELECT
    country,
    COUNT(*) as completed_bookings,
    ROUND(AVG(adr), 2) as avg_adr
FROM hotel_bookings
WHERE is_canceled = 0 AND country IS NOT NULL
GROUP BY country
ORDER BY completed_bookings DESC
LIMIT 5;