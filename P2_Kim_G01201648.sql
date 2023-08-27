/* Isaac Kim Project Component 2 CS 450 */
/* Example:
https://docs.oracle.com/cd/A58617_01/server.804/a58241/ch5.htm

list of tables:
Customers(Family)(Point_Account)(Login)	-		1
Address-
Phone-
Transations(Point_Account)-
Login-			5
Products-
Offers-				
Branches-
Point_Accounts(Family)-
prizes-		10
Cards-
ExchgCenters-
Families-
Redemption_History (Customers, exchgCenters, Pointacc, prizes) -
Transactions_Products -
Transactions_Offers -
Offers_Branches -

need to add address and phone number tables

*/
--1
CREATE TABLE Address(
	street VARCHAR2(30),
	apt VARCHAR2(30),
	city VARCHAR2(30),
	states VARCHAR2(30),
	zip NUMBER(10,0),
	PRIMARY KEY (street, apt, city, states, zip)
);
--2
CREATE TABLE Phone(
	phone_number NUMBER(10,0),
	PRIMARY KEY (phone_number)
);
--7
CREATE TABLE Families(
	family_id VARCHAR2(30),
	num_members NUMBER(10,0),
	family_name VARCHAR2(30),
	percent_added NUMBER(10,0),
	PRIMARY KEY (family_id)
);
--3
CREATE TABLE Customers(
	cid VARCHAR2(30),
	cname VARCHAR2(30),
	mstatus NUMBER(1,0),
	is_member NUMBER(1,0),
	email VARCHAR2(30),
	dob DATE,
	occupation VARCHAR2(30),
	ssn NUMBER(9,0),
	gender VARCHAR2(30),
	street VARCHAR2(30),
	apt VARCHAR2(30),
	city VARCHAR2(30),
	states VARCHAR2(30),
	zip NUMBER(10,0),
	phone_number NUMBER(10,0),
	family_id VARCHAR2(30),
    username VARCHAR2(30) UNIQUE,
	FOREIGN KEY (street, apt, city, states, zip) REFERENCES Address(street, apt, city, states, zip),
	FOREIGN KEY (phone_number) REFERENCES Phone(phone_number),
	FOREIGN KEY (family_id) REFERENCES Families(family_id),
	PRIMARY KEY (cid)
);
--4
CREATE TABLE Login(
	username VARCHAR2(30),
	passwd VARCHAR2(30),
	cid VARCHAR2(30),
	FOREIGN KEY (username) REFERENCES Customers(username),
	FOREIGN KEY (cid) REFERENCES Customers(cid)
);
--5
CREATE TABLE Prizes(
	prize_id VARCHAR2(30),
	points_needed NUMBER(10,0),
	p_description VARCHAR2(30),
	PRIMARY KEY (prize_id)
);
--6
CREATE TABLE Cards(
	card_id VARCHAR2(30),
	status VARCHAR2(30),
	exp_date DATE,
	c_date DATE,
	cid VARCHAR2(30),
	PRIMARY KEY (card_id),
	FOREIGN KEY (cid) REFERENCES Customers(cid)
	ON DELETE CASCADE
);

--8
CREATE TABLE Point_Accounts(
	point_acc_no VARCHAR2(30),
	num_of_points NUMBER(10,0),
	family_id VARCHAR2(30),
	cid VARCHAR2(30),
	PRIMARY KEY (point_acc_no),
	FOREIGN KEY (family_id) REFERENCES Families(family_id),
	FOREIGN KEY (cid) REFERENCES Customers(cid)
);
--9
CREATE TABLE Transactions(
	t_description VARCHAR2(30),
	t_points NUMBER(10,0),
	t_time VARCHAR2(30),
	t_date DATE,
	cashier_name VARCHAR2(30),
	amount NUMBER(10,2),
	t_ref VARCHAR2(30),
	Point_Account VARCHAR2(30),
	cid VARCHAR2(30),
	PRIMARY KEY (t_ref),
	FOREIGN KEY (Point_Account) REFERENCES Point_Accounts(point_acc_no),
	FOREIGN KEY (cid) REFERENCES Customers(cid)
);
--10
CREATE TABLE Products(
	prod_name VARCHAR2(30),
	price NUMBER(10,2),
	prod_points NUMBER(10,0),
	prod_id VARCHAR2(30),
	PRIMARY KEY (prod_id)
);
--11
CREATE TABLE Branches(
	branch_name VARCHAR2(30),
	branch_id VARCHAR2(30),
	b_location VARCHAR2(30),
	opening_hours VARCHAR2(30),
	PRIMARY KEY (branch_id)
);
--12
CREATE TABLE Offers(
	action VARCHAR2(30),
	offer_id VARCHAR2(30),
	o_date DATE,
	o_description VARCHAR2(30),
	PRIMARY KEY (offer_id)
);
--13
CREATE TABLE ExchgCenters(
	center_id VARCHAR2(30),
	c_location VARCHAR2(30),
	center_name VARCHAR2(30),
	PRIMARY KEY (center_id)
);
--14
CREATE TABLE Transactions_Products(
	quantity NUMBER(10),
	prod_id VARCHAR2(30) NOT NULL,
	t_ref VARCHAR2(30),
	PRIMARY KEY (prod_id),
	FOREIGN KEY (t_ref) REFERENCES Transactions(t_ref),
	FOREIGN KEY (prod_id) REFERENCES Products(prod_id)
);
--15
CREATE TABLE Transactions_Offers(
	offer_id VARCHAR2(30),
	t_ref VARCHAR2(30),
	FOREIGN KEY (t_ref) REFERENCES Transactions(t_ref),
	FOREIGN KEY (offer_id) REFERENCES Offers(offer_id)
);
--16
CREATE TABLE Offers_Branches(
	offer_id VARCHAR2(30),
	branch_id VARCHAR2(30) NOT NULL,
	FOREIGN KEY (offer_id) REFERENCES Offers(offer_id),
	FOREIGN KEY (branch_id) REFERENCES Branches(branch_id)
);
--17
CREATE TABLE Redemption_History(
	quanity NUMBER(10,0),
	r_date DATE,
	center_id VARCHAR2(30) NOT NULL,
	point_acc_no VARCHAR2(30) NOT NULL,
	cid VARCHAR2(30),
	prize_id VARCHAR2(30),
	PRIMARY KEY (cid, prize_id, center_id, point_acc_no),
	FOREIGN KEY (cid) REFERENCES Customers(cid),
	FOREIGN KEY (center_id) REFERENCES ExchgCenters(center_id),
	FOREIGN KEY (prize_id) REFERENCES Prizes(prize_id),
	FOREIGN KEY (point_acc_no) REFERENCES Point_Accounts(point_acc_no)
);
