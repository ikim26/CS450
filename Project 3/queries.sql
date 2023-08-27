--1 ('branch_name' should be actual branch name, like 'Fairfax Branch')
SELECT offer_id, action, o_date 
FROM Offers 
WHERE Offers.offer_id IN 
   (SELECT offer_id 
	FROM Offers_Branches 
	WHERE Offers_Branches.branch_id IN 
	   (SELECT branch_id 
		FROM Branches 
		WHERE Branches.branch_name = 'branch_name'
		)
);

--2 ('c_name' should be customer name)
SELECT tref, amount, t_points, t_date 
FROM Transactions 
WHERE Transactions.cid IN
   (SELECT cid
	FROM Customers
	WHERE Customers.cname = 'cname'
);

--3
SELECT Branches.branch_id, 
   (SELECT COUNT(*) FROM Offers_Branches 
	WHERE Branches.branch_id = Offers_Branches.branch_id) AS num_of_offers
FROM Branches;

--4
SELECT Branches.branch_name, 
   (SELECT COUNT(*) FROM Offers_Branches 
	WHERE Branches.branch_id = Offers_Branches.branch_id) AS num_of_offers 
FROM Branches;

--5 ('tref' should be a particular transaction reference, e.g. 't1')
SELECT Transactions.tref,
	   Transactions.t_date,
	   Transactions.t_time,
	   Transactions.amount,
	   Transactions.t_points,
	   Products.prod_id,
	   Products.prod_name,
	   Transactions_Products.quantity,
	   Products.price,
	   Products.prod_points
FROM Transactions, Products, Transactions_Products
WHERE Transactions.tref = 'tref'
AND Transactions.tref = Transactions_Products.tref 
AND Products.prod_id = Transactions_Products.prod_id;

--6
SELECT COUNT(*) AS num_expired_cards FROM Cards WHERE Cards.status = 'E';

--7 
SELECT cid, COUNT(*) AS max FROM Cards GROUP BY cid ORDER BY max DESC FETCH FIRST 1 ROWS ONLY;

--8 ('Scarlet Hudson' is customer name)
SELECT Redemption_History.prize_id,
	   Prizes.p_description,
	   Customers.cname,
	   Redemption_History.center_id,
	   Prizes.points_needed AS redeemed_points
FROM Redemption_History, Customers, Prizes
WHERE Customers.cname = 'Scarlet Hudson'
AND Redemption_History.cid IN Customers.cid
AND Redemption_History.prize_id = Prizes.prize_id;


--9 ('Obama' is family name)
SELECT Customers.occupation,
	   Customers.cname
FROM Customers
WHERE Customers.family_id IN 
	(SELECT Families.family_id FROM Families
	WHERE Families.family_name = 'Obama'
);


--10 (18 is family id)
SELECT SUM(Point_Accounts.num_of_points) AS points_sum
FROM Point_Accounts
WHERE Point_Accounts.family_id IN
	(SELECT Families.family_id FROM Families
	WHERE Families.family_id = 18
);


--11
SELECT Customers.cname AS max_customer FROM Customers 
WHERE Customers.cid =
(SELECT Point_Accounts.cid FROM Point_Accounts 
WHERE Point_Accounts.num_of_points = 
(SELECT MAX(Point_Accounts.num_of_points) FROM Point_Accounts));


--12 ('05-12-2022' is the particular date)
SELECT SUM(points_needed * quantity) AS points_redeemed 
FROM (SELECT Redemption_History.prize_id, Prizes.points_needed, Redemption_History.quantity FROM Redemption_History, Prizes 
WHERE Redemption_History.r_date = TO_DATE('05-12-2022', 'MM-DD-YYYY')
AND Redemption_History.prize_id = Prizes.prize_id);

--13 ('5' is particular customer id)
SELECT SUM(quantity) AS num_redeemed
FROM Redemption_History
WHERE Redemption_History.cid = '5';

--14 ('3' is particular center id)
SELECT COUNT(cid) AS cust_count
FROM Redemption_History
WHERE Redemption_History.center_id = '3';

--15
SELECT COUNT(*) AS total_prizes FROM Prizes;

--16
SELECT cname
FROM Customers
WHERE Customers.occupation = 'Engineer'
AND Customers.cid IN 
	(SELECT cid
	FROM Addresses
	WHERE Addresses.city = 'Fairfax'
);

--17
SELECT prod_name
FROM Products
WHERE Products.prod_id NOT IN
	(SELECT prod_id
	FROM Transactions_Products
);

--18
SELECT prod_id, COUNT(prod_id) AS prod_count
FROM Transactions_Products
GROUP BY prod_id
ORDER BY prod_count DESC
FETCH FIRST 1 ROWS ONLY;