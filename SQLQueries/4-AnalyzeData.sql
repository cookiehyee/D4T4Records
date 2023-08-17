/*	SQL QUERY TO ANALYZE DATABASE DATA AND DERIVE BUSINESS INSIGHTS	*/

/*	GET TOTAL SALES PER RECORD TYPE AND SORT BY HIGHEST SALES	*/
SELECT RecordType AS "Record Type", 
       CONCAT("$ ", FORMAT(SUM(Price), "C")) AS "Total Sales"
FROM Record WHERE SalesDate IS NOT NULL GROUP BY RecordType ORDER BY 2 DESC;

/*	GET TOTAL RECORD SALES, TOTAL INSTRUMENT REPAIR FEE AND NET REVENUE	*/
SELECT CONCAT("$ ", FORMAT(SUM(Price), "C")) AS "Total Record Sales", 
       CONCAT("$ ", FORMAT(SUM(RepairFee), "C")) AS "Total Repair Fee",
	   CONCAT("$ ", FORMAT((SUM(Price) - SUM(RepairFee)), "C")) AS "Net Revenue" 
FROM Record, Repair WHERE SalesDate IS NOT NULL;

/*	ORGANIZE AND SORT INSTRUMENTS BY HIGHEST NUMBER OF REPAIRS AND REPAIR FEE SPENT*/
SELECT InstrumentID, COUNT(InstrumentID) AS "Number of Repairs", 
	   CONCAT("$ ", FORMAT(SUM(RepairFee), "C")) AS "Repair Fee Spent" 
FROM Repair GROUP BY InstrumentID 
ORDER BY COUNT(InstrumentID) DESC, SUM(RepairFee) DESC, LENGTH( SUM(RepairFee));

/*	GET RECORDS OVER TEN YEARS OLD THAT ARE NOT YET SOLD AND SORT BY OLDEST AGE	*/
SELECT Name, CONCAT("$ ", FORMAT(Price,"C")) AS Price, YEAR(ManufactDate) AS "Manufacture Year", 
	   TIMESTAMPDIFF(YEAR,ManufactDate,CURDATE()) AS "Inventory Age"
FROM Record WHERE SalesDate IS NULL ORDER BY 4 DESC;

/*	GET CUSTOMER PAYMENT METHODS AND SORT BY HIGHEST NUMBER OF TRANSACTIONS	*/
SELECT PaymentMethod AS "Payment Method", 
       COUNT(PaymentMethod) AS "Number of Transactions" 
FROM CustomerPayment GROUP BY PaymentMethod ORDER BY 2 DESC;
