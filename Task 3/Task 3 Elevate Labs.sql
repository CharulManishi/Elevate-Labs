CREATE DATABASE Ola_Bookings;
USE Ola_Bookings;
select * from bookings
LIMIT 100001;


# 1. Retrieve all successful bookings:

SELECT * FROM Bookings
WHERE Booking_Status = "Success";         # OR

CREATE VIEW Successful_Bookings AS
SELECT * FROM Bookings
WHERE Booking_Status = "Success";

SELECT * FROM Successful_Bookings;


# 2. Find the average ride distance for each vehicle type:

CREATE VIEW average_ride_distance AS
SELECT Vehicle_Type, avg(Ride_Distance) FROM bookings
GROUP BY Vehicle_Type;

SELECT * FROM average_ride_distance;


#3. Get the total number of cancelled rides by customers:

SELECT COUNT(*) total_cancelled_rides_by_customers FROM bookings
WHERE Cancelled_Rides_by_Customer = 1;                                         # OR

SELECT COUNT(*) total_cancelled_rides_by_customers FROM bookings
WHERE Booking_Status = "Cancelled by Customer";


# 4. List the top 5 customers who booked the highest number of rides:

SELECT Customer_ID, COUNT(Booking_ID) FROM bookings
GROUP BY Customer_ID
ORDER BY COUNT(Booking_ID) DESC
LIMIT 5;


# 5. Get the number of rides cancelled by drivers due to personal and car-related issues:

SELECT COUNT(*) FROM bookings
WHERE Booking_Status = "Cancelled by Driver" AND Reason_for_cancelling_by_Driver = "Personal & Car related issues";  # OR

SELECT COUNT(*) FROM bookings
WHERE Reason_for_cancelling_by_Driver = "Personal & Car related issues";


# 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:

SELECT vehicle_type, max(Driver_Ratings), min(Driver_Ratings) FROM bookings
GROUP BY Vehicle_Type;

SELECT vehicle_type, max(Driver_Ratings), min(Driver_Ratings) FROM bookings
WHERE Vehicle_Type = "Prime Sedan" ;


# 7. Retrieve all rides where payment was made using UPI:

SELECT * FROM bookings
WHERE Payment_Method = "UPI";


# 8. Find the average customer rating per vehicle type:

SELECT Vehicle_Type, avg(Customer_Rating) FROM bookings
GROUP BY Vehicle_Type;


# 9. Calculate the total booking value of rides completed successfully:

SELECT count(Booking_Value) AS total_booking_value_of_successful_rides 
FROM bookings
WHERE Booking_Status = "Success";

# 10. List all incomplete rides along with the reason:

SELECT Booking_ID, Incomplete_Rides_Reason FROM bookings
WHERE Incomplete_Rides = 1;

# 11. Get total fare by vehicle type and order by total fare.

SELECT VehicleType, SUM(Booking_Value) AS TotalFare FROM bookings
GROUP BY Vehicle_Type
ORDER BY TotalFare DESC;

# 12. Join ola_bookings with customers to get customer names and their bookings.

USE Customer;
SELECT b.BookingID, c.CustomerName, b.Date, b.Fare
FROM bookings b
INNER JOIN customers c ON b.CustomerID = c.CustomerID;

# 13. Left Join to get all bookings, even if the customer information is missing.

SELECT b.BookingID, c.CustomerName, b.Date, b.Fare
FROM bookings b
LEFT JOIN customers c ON b.CustomerID = c.CustomerID;

# 14. Right Join to get all customers, even if they have no bookings.

SELECT c.CustomerName, b.BookingID, b.Date
FROM bookings b
RIGHT JOIN customers c ON b.CustomerID = c.CustomerID;

# 15. Subquery to get customers who have a total fare above a certain amount.

SELECT Customer_ID, SUM(Booking_Value) AS TotalFare FROM bookings
GROUP BY Customer_ID
HAVING SUM(Booking_Value) > (SELECT AVG(Booking_Value) FROM bookings);

# 16. Create a view for daily booking summary by vehicle type.

CREATE VIEW daily_booking_summary AS
SELECT Date, Vehicle_Type, COUNT(*) AS TotalBookings, SUM(Booking_Value) AS TotalFare
FROM bookings
GROUP BY Date, Vehicle_Type;

SELECT * FROM daily_booking_summary WHERE Date = '2025-03-10';

# Optimizing Queries with Indexes

# 17. Create an index on the CustomerID column for faster searches.

CREATE INDEX idx_customer_id ON bookings(Customer_ID(50));

DESCRIBE bookings;

# 18. Create an index on Date for faster range queries (e.g., retrieving bookings in a date range).

CREATE INDEX idx_date ON bookings(Date);
 DESCRIBE Bookings;    # Date: data type - Text
 
 # To convert the Date column to DATE type:
 ALTER TABLE bookings MODIFY Date DATE;
 
 # If you need to keep the column as TEXT:
CREATE INDEX idx_date ON bookings(Date(50));


















