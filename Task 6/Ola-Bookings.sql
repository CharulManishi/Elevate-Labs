CREATE DATABASE Ola;
USE Ola;

# 1. Q: How do you extract the month and year from a date column in SQL?

SELECT EXTRACT(YEAR FROM STR_TO_DATE(date, '%d-%m-%Y')) AS year,
EXTRACT(MONTH FROM STR_TO_DATE(date, '%d-%m-%Y')) AS month
FROM Bookings;


# 2. Q: How can you calculate the total monthly revenue from ride bookings?

SELECT EXTRACT(MONTH FROM STR_TO_DATE(date, '%d-%m-%y')) AS month, SUM(booking_value) AS total_revenue
FROM bookings
WHERE booking_status = 'Success'
GROUP BY month;


# 3. Q: What's the difference between COUNT(*) and COUNT(DISTINCT col)?

SELECT COUNT(*) FROM Bookings;                                        # COUNT(*) counts all rows, including duplicates.

SELECT COUNT(Booking_ID), Booking_Status FROM Bookings                           
WHERE Booking_Status = "Success" ;

SELECT COUNT(DISTINCT Booking_ID), Booking_Status FROM Bookings      # COUNT(DISTINCT col) counts only unique, non-null values in the specified column.
GROUP BY Booking_Status;


# 4. Q: How do SQL aggregate functions handle NULLs?

SELECT COUNT(Cancelled_Rides_by_Driver)                              # COUNT(column) only counts non-null entries.
FROM BOOKINGS; 

SELECT SUM(COALESCE(booking_value, 0)) AS total_revenue               # Use COALESCE(column, 0) to replace NULLs if needed.
FROM Bookings;          


# 5. Q: How do you identify the top 3 months with the highest revenue?

SELECT EXTRACT(MONTH FROM STR_TO_DATE(date, '%d-%m-%y')) AS month, SUM(COALESCE(booking_value, 0)) AS total_revenue
FROM bookings
WHERE booking_status = 'Success'
GROUP BY month
ORDER BY total_revenue DESC
LIMIT 3;


# 6. Q: List the top 5 customers who booked the highest number of rides

SELECT COUNT(Booking_ID), Customer_ID FROM Bookings
GROUP BY Customer_ID
ORDER BY COUNT(Booking_ID) DESC
LIMIT 5;


