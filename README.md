# 📘 Vehicle Rental System - Database Design & SQL Queries

**ERD Link:** [👉 https://drawsql.app/teams/rts-7/diagrams/vehicle-rental-system]

## 🧩 Project Explanation
This project is based on a **Vehicle Rental System**, which manages information about **Users**, **Vehicles**, and **Bookings**.  
It demonstrates how to design a relational database using **Primary Keys (PK)**, **Foreign Keys (FK)**, and proper relationships:
- **One-to-Many:** User → Bookings  
- **Many-to-One:** Bookings → Vehicles  
- **Logical One-to-One:** Each booking connects exactly one user and one vehicle  

The database supports:
- Storing user and vehicle information  
- Handling bookings between users and vehicles  
- Tracking booking and availability status  

---

## 🧍 Users Table
| Column | Type | Constraints | Description |
|--------|------|--------------|--------------|
| user_id | SERIAL | PRIMARY KEY | Unique ID for each user |
| name | VARCHAR(100) | NOT NULL | User's full name |
| email | VARCHAR(100) | UNIQUE, NOT NULL | Each email must be unique |
| password | VARCHAR(100) | NOT NULL |
| phone | VARCHAR(20) |  | Contact number |
| role | VARCHAR(20) | CHECK (role IN ('admin','customer')) | User role type |

---

## 🚘 Vehicles Table
| Column | Type | Constraints | Description |
|--------|------|--------------|--------------|
| vehicle_id | SERIAL | PRIMARY KEY | Unique vehicle ID |
| name | VARCHAR(100) | NOT NULL | Vehicle name |
| type | VARCHAR(50) | CHECK (type IN ('car','bike','truck')) | Vehicle type |
| model | VARCHAR(50) |  | Model of the vehicle |
| registration_number | VARCHAR(50) | UNIQUE, NOT NULL | Must be unique |
| rental_price | INT | NOT NULL | Price per day |
| status | VARCHAR(20) | CHECK (status IN ('available','rented','maintenance')) | Current vehicle status |

---

## 📅 Bookings Table
| Column | Type | Constraints | Description |
|--------|------|--------------|--------------|
| booking_id | SERIAL | PRIMARY KEY | Unique booking ID |
| user_id | INT | FOREIGN KEY → users(user_id) | Which user made the booking |
| vehicle_id | INT | FOREIGN KEY → vehicles(vehicle_id) | Which vehicle was booked |
| start_date | DATE | NOT NULL | Rental start date |
| end_date | DATE | NOT NULL | Rental end date |
| status | VARCHAR(20) | CHECK (status IN ('pending','confirmed','completed','cancelled')) | Current booking status |
| total_cost | INT | NOT NULL | Total cost of the booking |

🧠 **Logical One-to-One:**  
Each booking connects **exactly one user** and **exactly one vehicle**.

---

## 🔗 ERD Relationships
| Relationship | Type | Cardinality | Description |
|---------------|------|--------------|--------------|
| Users → Bookings | One-to-Many | 1 → ∞ | A user can make many bookings |
| Bookings → Vehicles | Many-to-One | ∞ → 1 | Many bookings can belong to one vehicle |
| Booking ↔ User & Vehicle | Logical One-to-One | 1:1 | Each booking connects exactly one user and one vehicle |


## 💻 SQL Queries with Solutions

### 1️⃣ INNER JOIN  
Retrieve booking information with customer and vehicle names.
```sql

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


2️⃣ EXISTS

Find all vehicles that have never been booked.

SELECT * FROM vehicles
WHERE NOT EXISTS(
  SELECT 1 FROM bookings WHERE bookings.vehicle_id = vehicles.vehicle_id
)


3️⃣ WHERE

Retrieve all available vehicles of a specific type (e.g., cars).

SELECT * FROM vehicles 
  WHERE vehicles.type = 'car' 
  AND vehicles.status = 'available'


4️⃣ GROUP BY and HAVING

Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

SELECT 
  vehicles.name AS vehicle_name,
  COUNT(bookings.booking_id) AS total_bookings
FROM vehicles
JOIN bookings 
  ON vehicles.vehicle_id = bookings.vehicle_id
GROUP BY vehicles.name
HAVING COUNT(bookings.booking_id) > 2;


👩‍💻 Information

Language Used: SQL
Tools Used: PostgreSQL / drawSQL / VS Code