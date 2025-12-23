--Query 1 :

SELECT
  bookings.booking_id,
  users.name as user_name,
  vehicles.name as vehicle_name,
  bookings.start_date,
  bookings.end_date,
  bookings.status,
  bookings.total_cost
  FROM bookings INNER JOIN users ON bookings.user_id = users.user_id 
  INNER JOIN vehicles ON bookings.vehicle_id = vehicles.vehicle_id


-- Query 2 :

SELECT * FROM vehicles
WHERE NOT EXISTS(
  SELECT 1 FROM bookings WHERE bookings.vehicle_id = vehicles.vehicle_id
)


-- Query 3 :

SELECT * FROM vehicles 
  WHERE vehicles.type = 'car' 
  AND vehicles.status = 'available'


-- Query 4 :

SELECT 
  vehicles.name AS vehicle_name, 
  COUNT(bookings.booking_id) AS total_bookings
FROM vehicles
JOIN bookings 
  ON vehicles.vehicle_id = bookings.vehicle_id
GROUP BY vehicles.name
HAVING COUNT(bookings.booking_id) > 2;
