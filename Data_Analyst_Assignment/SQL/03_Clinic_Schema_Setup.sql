DROP TABLE IF EXISTS expenses;
DROP TABLE IF EXISTS clinic_sales;
DROP TABLE IF EXISTS customer;
DROP TABLE IF EXISTS clinics;

CREATE TABLE clinics (
  cid VARCHAR(50) PRIMARY KEY,
  clinic_name VARCHAR(100),
  city VARCHAR(100),
  state VARCHAR(100),
  country VARCHAR(100)
);

CREATE TABLE customer (
  uid VARCHAR(50) PRIMARY KEY,
  name VARCHAR(100),
  mobile VARCHAR(30)
);

CREATE TABLE clinic_sales (
  oid VARCHAR(50) PRIMARY KEY,
  uid VARCHAR(50),
  cid VARCHAR(50),
  amount DECIMAL(12,2),
  datetime DATETIME,
  sales_channel VARCHAR(100),
  FOREIGN KEY (uid) REFERENCES customer(uid),
  FOREIGN KEY (cid) REFERENCES clinics(cid)
);

CREATE TABLE expenses (
  eid VARCHAR(50) PRIMARY KEY,
  cid VARCHAR(50),
  description VARCHAR(255),
  amount DECIMAL(12,2),
  datetime DATETIME,
  FOREIGN KEY (cid) REFERENCES clinics(cid)
);

INSERT INTO clinics VALUES
('cnc-0100001', 'XYZ clinic', 'lorem', 'ipsum', 'dolor'),
('cnc-0200002', 'ABC clinic', 'delta', 'beta', 'gamma'),
('cnc-0300003', 'HealthPlus', 'city1', 'state1', 'country1'),
('cnc-0400004', 'CareWell', 'city2', 'state1', 'country1');

INSERT INTO customer VALUES
('bk-09f3e-95hj', 'Jon Doe', '97XXXXXXXX'),
('uid-8390-ash2', 'Neha Sharma', '98XXXXXXXX'),
('uid-1209-zsn4', 'Ravi Patel', '99XXXXXXXX');

INSERT INTO clinic_sales VALUES
('ord-00100-00100', 'bk-09f3e-95hj', 'cnc-0100001', 24999, '2021-09-23 12:03:22', 'sodat'),
('ord-00100-00101', 'uid-8390-ash2', 'cnc-0100001', 17999, '2021-09-23 14:20:10', 'online'),
('ord-00100-00102', 'uid-1209-zsn4', 'cnc-0200002', 30999, '2021-09-24 11:05:00', 'walk-in'),
('ord-00100-00103', 'bk-09f3e-95hj', 'cnc-0200002', 12500, '2021-10-12 09:15:00', 'phone'),
('ord-00100-00104', 'uid-8390-ash2', 'cnc-0300003', 42000, '2021-10-14 16:45:00', 'online'),
('ord-00100-00105', 'uid-1209-zsn4', 'cnc-0100001', 9800, '2021-11-05 10:50:00', 'online'),
('ord-00100-00106', 'bk-09f3e-95hj', 'cnc-0200002', 24000, '2021-11-15 13:30:00', 'walk-in'),
('ord-00100-00107', 'uid-8390-ash2', 'cnc-0400004', 15000, '2021-11-20 14:00:00', 'online');

INSERT INTO expenses VALUES
('exp-0100-00100', 'cnc-0100001', 'first-aid supplies', 557, '2021-09-23 07:36:48'),
('exp-0100-00101', 'cnc-0100001', 'rent', 15000, '2021-09-30 09:00:00'),
('exp-0100-00102', 'cnc-0200002', 'utilities', 9800, '2021-10-01 11:00:00'),
('exp-0100-00103', 'cnc-0300003', 'salaries', 25000, '2021-10-10 08:30:00'),
('exp-0100-00104', 'cnc-0200002', 'medicines', 7200, '2021-11-05 15:00:00'),
('exp-0100-00105', 'cnc-0100001', 'marketing', 12400, '2021-11-10 12:00:00'),
('exp-0100-00106', 'cnc-0300003', 'maintenance', 4500, '2021-11-18 10:10:00'),
('exp-0100-00107', 'cnc-0400004', 'supplies', 5000, '2021-11-21 09:00:00');
