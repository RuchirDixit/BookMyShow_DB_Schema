
-- CREATE MOVIE TABLE
CREATE TABLE MOVIE (
  movie_id INTEGER PRIMARY KEY,
  movie_name TEXT NOT NULL
);


-- CREATE CUSTOMER TABLE
CREATE TABLE CUSTOMER (
  customer_id INTEGER PRIMARY KEY,
  customer_name TEXT NOT NULL,
  email TEXT,
  phone_number VARCHAR(15) NOT NULL CHECK (phone_number REGEXP '^[0-9]{10}$')
);

-- CREATE THEATRE TABLE
CREATE TABLE THEATRE (
  theatre_id INTEGER PRIMARY KEY,
  theatre_name TEXT NOT NULL,
  location TEXT
);

-- CREATE SHOWS TABLE
CREATE TABLE SHOWS (
  show_id INTEGER PRIMARY KEY,
  theatre_id INTEGER NOT NULL,
  movie_id INTEGER NOT NULL,
  screen_id INTEGER NOT NULL,
  date DATE NOT NULL,
  time TEXT NOT NULL,
  FOREIGN KEY (theatre_id) REFERENCES THEATRE(theatre_id),
  FOREIGN KEY (movie_id) REFERENCES MOVIE(movie_id)
);

-- CREATE BOOKING TABLE
CREATE TABLE BOOKING (
  booking_id INTEGER PRIMARY KEY,
  show_id INTEGER NOT NULL,
  customer_id INTEGER NOT NULL,
  no_of_seats_booked INTEGER NOT NULL,
  creation_date DATE NOT NULL,
  FOREIGN KEY (show_id) REFERENCES SHOWS(show_id),
  FOREIGN KEY (customer_id) REFERENCES CUSTOMER(customer_id)
);

-- CREATE SEAT_PRICE TABLE
CREATE TABLE SEAT_PRICE (
  seat_price_id INTEGER PRIMARY KEY,
  seat_type TEXT NOT NULL,
  price INTEGER NOT NULL
);

-- CREATE SEAT TABLE
CREATE TABLE SEAT (
  seat_id INTEGER PRIMARY KEY,
  seat_number INTEGER NOT NULL,
  seat_price_id INTEGER NOT NULL,
  FOREIGN KEY (seat_price_id) REFERENCES SEAT_PRICE(seat_price_id)
);


INSERT INTO MOVIE (movie_id, movie_name) VALUES 
(1, 'Inception'),
(2, 'The Matrix'),
(3, 'Interstellar');

INSERT INTO CUSTOMER (customer_id, customer_name, email, phone_number) VALUES 
(1, 'Karan Shergil', 'karans@example.com', '9876543210'),
(2, 'Udesh Shergil', 'pshergil@example.com', '8765432109'),
(3, 'Romila Dutta', 'romidutta@example.com', '7654321098');

INSERT INTO THEATRE (theatre_id, theatre_name, location) VALUES 
(1, 'PVR Cinemas', 'Pune'),
(2, 'INOX', 'Mumbai');

INSERT INTO SEAT_PRICE (seat_price_id, seat_type, price) VALUES 
(1, 'Front Seats', 200),
(2, 'Standard', 400),
(3, 'Premium', 600);

INSERT INTO SHOWS (show_id, theatre_id, movie_id, screen_id, date, time) VALUES 
(1, 1, 1, 5, '2024-09-01', '18:00'),
(2, 2, 2, 3, '2024-09-02', '20:00'),
(3, 2, 1, 3, '2024-09-02', '06:20'),
(4, 1, 3, 7, '2024-09-03', '21:00');

INSERT INTO SEAT (seat_id, seat_number, seat_price_id) VALUES 
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

INSERT INTO BOOKING (booking_id, show_id, customer_id, no_of_seats_booked, creation_date) VALUES 
(1, 1, 1, 2, '2024-08-30'),
(2, 2, 2, 3, '2024-08-31'),
(3, 3, 3, 1, '2024-09-01');


-- Query to list all the shows and its timings on 2nd Sept 2024 at Inox

SELECT m.movie_name,s.time,t.theatre_name FROM SHOWS s
INNER JOIN THEATRE t ON s.theatre_id = t.theatre_id
INNER JOIN MOVIE m ON s.movie_id = m.movie_id
WHERE t.theatre_name = 'INOX' AND s.date='2024-09-02';

