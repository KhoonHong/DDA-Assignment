CREATE TABLE member(
	member_id VARCHAR(8) NOT NULL,
	first_name VARCHAR(25) NOT NULL,
	last_name VARCHAR(25) NOT NULL,
	ic_no VARCHAR(12) NOT NULL UNIQUE,
	birth_date DATE NOT NULL,
	address VARCHAR(30) NOT NULL,
	phone_number VARCHAR(11) NOT NULL UNIQUE,
	email VARCHAR(40) NOT NULL UNIQUE,
	username VARCHAR(30) NOT NULL UNIQUE,
	password VARCHAR(30) NOT NULL,
PRIMARY KEY (member_id)
);

CREATE TABLE publisher(
	publisher_id VARCHAR(7) NOT NULL,
	publisher_category VARCHAR(20) NOT NULL,
	publisher_name VARCHAR(30) NOT NULL UNIQUE,
PRIMARY KEY (publisher_id)
);

CREATE TABLE category(
	category_id VARCHAR(6) NOT NULL,
	category_name VARCHAR(21) NOT NULL UNIQUE,
PRIMARY KEY (category_id)
);

CREATE TABLE author(
	author_id VARCHAR(5) NOT NULL,
	author_name VARCHAR(40) NOT NULL UNIQUE,
PRIMARY KEY (author_id)
);

CREATE TABLE book
(
	book_isbn VARCHAR(13) NOT NULL,
	publisher_id VARCHAR(7) NOT NULL,
	book_name VARCHAR(50) NOT NULL UNIQUE,
	synopsis VARCHAR(1000) NOT NULL,
	quantity NUMBER(3) DEFAULT 1 NOT NULL , 
PRIMARY KEY (book_isbn),
FOREIGN KEY (publisher_id) REFERENCES publisher(publisher_id)
);



CREATE table book_category(
	book_isbn VARCHAR(13) NOT NULL,
	category_id VARCHAR(6) NOT NULL,
PRIMARY KEY (book_isbn, category_id),
FOREIGN KEY (book_isbn)  references book(book_isbn),
FOREIGN KEY (category_id) references category(category_id)
);



CREATE table book_author(
	book_isbn VARCHAR(13) NOT NULL,
	author_id VARCHAR(5) NOT NULL,
PRIMARY KEY (book_isbn, author_id),
FOREIGN KEY (book_isbn) REFERENCES book(book_isbn),
FOREIGN KEY (author_id) REFERENCES author(author_id)
);



CREATE TABLE reservation
(
	reservation_id VARCHAR(9) NOT NULL,
	member_id VARCHAR(8) NOT NULL,
	reservation_date DATE DEFAULT GETDATE() NOT NULL,
	collection_date DATE NOT NULL,
PRIMARY KEY (reservation_id),
FOREIGN KEY (member_id) REFERENCES member(member_id)
);



CREATE TABLE book_reservation
(
	book_isbn VARCHAR(13) NOT NULL,
	reservation_id VARCHAR(9) NOT NULL,
PRIMARY KEY (book_isbn, reservation_id),
FOREIGN KEY (book_isbn) REFERENCES book(book_isbn),
FOREIGN KEY (reservation_id) REFERENCES reservation(reservation_id)
);



CREATE TABLE loan
(
	loan_id VARCHAR(10) NOT NULL,
	member_id VARCHAR(8) NOT NULL,
	book_isbn VARCHAR(13) NOT NULL,
	loan_date DATE DEFAULT GETDATE() NOT NULL,
PRIMARY KEY (loan_id),
FOREIGN KEY (member_id) REFERENCES member(member_id),
FOREIGN KEY (book_isbn) REFERENCES book(book_isbn) 
);



CREATE TABLE return
(
	return_id VARCHAR(10) NOT NULL,
	loan_id VARCHAR(10) NOT NULL,
	return_date DATE DEFAULT GETDATE() NOT NULL,
PRIMARY KEY (return_id),
FOREIGN KEY (loan_id) REFERENCES loan(loan_id)
);


CREATE TABLE payment
(
	payment_id VARCHAR(9) NOT NULL,
	member_id VARCHAR(8) NOT NULL,
	return_id VARCHAR(10) NOT NULL,
	reference_id VARCHAR(30) NOT NULL,
	payment_timestamp TIMESTAMP DEFAULT NOW() NOT NULL,
	amount NUMBER(4,2) NOT NULL,
	payment_method VARCHAR(30) NOT NULL,
	description VARCHAR(20) NOT NULL,
PRIMARY KEY (payment_id),
FOREIGN KEY (member_id) REFERENCES member(member_id),
FOREIGN KEY (return_id) REFERENCES return(return_id)
);


CREATE TABLE rating
(
	rating_id VARCHAR(9) NOT NULL,
	book_isbn VARCHAR(13) NOT NULL,
	plot_rating NUMBER(1) NOT NULL,
	character_rating NUMBER(1) NOT NULL,
	comments VARCHAR(1000),
PRIMARY KEY (rating_id),
FOREIGN KEY (book_isbn) REFERENCES book(book_isbn)
);