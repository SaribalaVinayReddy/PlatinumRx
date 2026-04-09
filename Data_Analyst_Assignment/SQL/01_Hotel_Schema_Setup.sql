DROP TABLE IF EXISTS booking_commercials;
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  user_id VARCHAR(50) PRIMARY KEY,
  name VARCHAR(100),
  phone_number VARCHAR(30),
  mail_id VARCHAR(100),
  billing_address VARCHAR(255)
);

CREATE TABLE bookings (
  booking_id VARCHAR(50) PRIMARY KEY,
  booking_date DATETIME,
  room_no VARCHAR(50),
  user_id VARCHAR(50),
  FOREIGN KEY (user_id) REFERENCES users(user_id)
);

CREATE TABLE items (
  item_id VARCHAR(50) PRIMARY KEY,
  item_name VARCHAR(100),
  item_rate DECIMAL(10,2)
);

CREATE TABLE booking_commercials (
  id VARCHAR(50) PRIMARY KEY,
  booking_id VARCHAR(50),
  bill_id VARCHAR(50),
  bill_date DATETIME,
  item_id VARCHAR(50),
  item_quantity DECIMAL(10,2),
  FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
  FOREIGN KEY (item_id) REFERENCES items(item_id)
);

INSERT INTO users VALUES
('21wrcxuy-67erfn', 'John Doe', '97XXXXXXXX', 'john.doe@example.com', 'XX, Street Y, ABC City'),
('34kdf-ajs93', 'Jane Smith', '98XXXXXXXX', 'jane.smith@example.com', '12, Lake View, DEF City'),
('grt-1293-hfh2', 'Priya Kumar', '99XXXXXXXX', 'priya.kumar@example.com', '45, Hill Road, GHI City');

INSERT INTO bookings VALUES
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-q034-q4o', '2021-10-05 14:10:05', 'rm-smn9-kjs1', '34kdf-ajs93'),
('bk-2010-dfh8', '2021-10-31 18:12:33', 'rm-abd1-fhd2', '34kdf-ajs93'),
('bk-1234-5678', '2021-11-12 20:05:00', 'rm-xkh4-dfj2', '21wrcxuy-67erfn'),
('bk-2390-aksd', '2021-11-28 22:00:00', 'rm-qwe8-asd2', 'grt-1293-hfh2'),
('bk-1122-3344', '2021-11-20 13:35:00', 'rm-ulj2-fhd3', '34kdf-ajs93');

INSERT INTO items VALUES
('itm-a9e8-q8fu', 'Tawa Paratha', 18),
('itm-a07vh-aer8', 'Mix Veg', 89),
('itm-w978-23u4', 'Lemon Soda', 35),
('itm-p123-45ab', 'Paneer Butter Masala', 120);

INSERT INTO booking_commercials VALUES
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu', 3),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('134lr-oyfo8-3qk4', 'bk-q034-q4o', 'bl-34qhd-r7h8', '2021-10-05 14:10:05', 'itm-w978-23u4', 2),
('q9jf-3892s-df82', 'bk-2010-dfh8', 'bl-47yhu-93jd', '2021-10-31 18:12:33', 'itm-a07vh-aer8', 12),
('q7uj-28dh-93kd', 'bk-2010-dfh8', 'bl-47yhu-93jd', '2021-10-31 18:12:33', 'itm-a9e8-q8fu', 10),
('q3nd-39fj-84nf', 'bk-1234-5678', 'bl-56ykj-92ks', '2021-11-12 20:05:00', 'itm-a07vh-aer8', 8),
('q8uf-10ne-73dn', 'bk-2390-aksd', 'bl-67kjd-45kl', '2021-11-28 22:00:00', 'itm-a07vh-aer8', 12),
('q9dr-44kf-02dk', 'bk-2390-aksd', 'bl-67kjd-45kl', '2021-11-28 22:00:00', 'itm-a9e8-q8fu', 2),
('q5dj-23kf-81jn', 'bk-1122-3344', 'bl-78kdj-34hj', '2021-11-20 13:35:00', 'itm-a9e8-q8fu', 20),
('q6de-57kl-12ml', 'bk-1122-3344', 'bl-99kjd-12xz', '2021-11-20 13:35:00', 'itm-p123-45ab', 10);
