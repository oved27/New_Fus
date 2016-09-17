-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Sep 17, 2016 at 01:55 AM
-- Server version: 10.1.13-MariaDB
-- PHP Version: 7.0.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `fus`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Assign_Scooter_To_Courier` (IN `new_ScooterLicense` VARCHAR(7), IN `new_CourierID` INT)  BEGIN
DECLARE temp INT ;
DECLARE col_exists INT;
IF
	((SELECT CURRENT_TIME())>'00:00:00' && (SELECT CURRENT_TIME())<'08:00:00') THEN set temp=0;
ELSEIF
	((SELECT CURRENT_TIME())>'08:00:00' && (SELECT CURRENT_TIME())<'16:00:00') THEN set temp=1;
   else
   set temp=2;
 END IF;
 
 if exists (SELECT *  FROM  scooterassign  WHERE ScooterLicense = new_ScooterLicense and isActive=1) then
 select 'Scooter already assign';
 END if;
 if EXISTS (SELECT *  FROM  scooterassign  WHERE CourierID = new_CourierID and isActive=1) then 
 select "this courier already assign scooter";
 
 else
 INSERT INTO scooterassign  (
        	ScooterLicense 		,
            AssignTime		,
            CourierID 		,
            IsActive 		,
			shift	
    )
    VALUES(
        new_ScooterLicense 		,
        sysDate()	 			, 
		new_CourierID 			,
        1						,	
		temp		
        );
	
 end if;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Change_Courier` (IN `New_DeliveryID` INT, IN `New_CourierID` INT)  BEGIN
    UPDATE Delivery set CourierID=New_CourierID where DeliveryID=New_DeliveryID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_If_Assign` (IN `new_DeliverID` INT)  NO SQL
SELECT d.AssignTime from delivery d WHERE d.DeliveryID=new_DeliverID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_If_Pickup` (IN `new_DeliverID` INT)  NO SQL
SELECT d.PickupTime from delivery d WHERE d.DeliveryID=new_DeliverID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `check_If_Time_Exist` (IN `new_DeliverID` INT(1), IN `new_selector` INT(1))  NO SQL
BEGIN
case new_selector
	when 0 then SELECT d.AssignTime from delivery d WHERE d.DeliveryID=new_DeliverID;
	when 1 THEN  SELECT d.PickupTime from delivery d WHERE d.DeliveryID=new_DeliverID;
	WHEN 2 THEN SELECT d.DropDownTime from delivery d WHERE d.DeliveryID=new_DeliverID;

END CASE;
	 
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Check_UserName_Password` (IN `New_User` VARCHAR(255), IN `New_Password` VARCHAR(255))  NO SQL
SELECT u.UserName, u.Password FROM users u WHERE u.UserName=New_User and u.Password =New_Password$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `CourierAndScooterByID` (IN `new_CourierID` INT)  BEGIN
    SELECT * FROM courier INNER JOIN scooterassign INNER JOIN delivery ON courier.CourierID=scooterassign.CourierID and 
	courier.CourierID=delivery.CourierID and courier.CourierID=new_CourierID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Create_New_Courier` (IN `new_FName` VARCHAR(255), IN `new_Lname` VARCHAR(255), IN `new_Address` VARCHAR(255), IN `new_Phone` VARCHAR(11), IN `new_DrivingExperience` INT)  BEGIN
if (new_DrivingExperience>=3) then
    INSERT INTO courier  (
        		FName		, 
                Lname		, 
                Address		, 
                Phone		,
                DrivingExperience
    )
    VALUES(
        new_FName	,
        new_Lname	, 
        new_Address	,
        new_Phone	,
        new_DrivingExperience
        );
else
select"Driving experience is less then 3";
	
end if;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Create_New_Customer` (IN `New_FName` VARCHAR(255), IN `New_Lname` VARCHAR(255), IN `New_Address` VARCHAR(255), IN `New_Phone` VARCHAR(255))  BEGIN
    INSERT INTO Customers  (
				FName		,
        		Lname		,
                Address 	,
                Phone 	
    )
    VALUES(
		New_FName		,
        New_Lname		, 
        New_Address 	,
        New_Phone 		
		);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Create_New_Delivery` (IN `new_PickupAddress` VARCHAR(255), IN `new_DropDownAddress` VARCHAR(255), IN `new_CustomerID` INT, IN `new_CourierID` INT)  BEGIN
    INSERT INTO Delivery  (
				Date			,
        		PickupAddress	,
                DropDownAddress	,
                CustomerID 		,
                CourierID 		,
				IsActive
					
    )
    VALUES(
		sysdate()				,
        new_PickupAddress		, 
        new_DropDownAddress		,
        new_CustomerID 			,
        new_CourierID 			,
		0
        );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Create_New_user` (IN `new_UserName` VARCHAR(255), IN `new_Password` VARCHAR(255), IN `new_FName` VARCHAR(255), IN `new_Lname` VARCHAR(255), IN `new_Address` VARCHAR(255), IN `new_Phone` VARCHAR(11), IN `new_Role` TINYINT(1))  BEGIN
    INSERT INTO users  (
        		UserName 	,
                Password    ,
                FName 	    ,
                Lname 	    ,
                Address     ,
				Phone       ,
				Role
				)
	
	
    VALUes(
		new_UserName	,
        new_Password    ,
        new_FName 	    ,
        new_Lname 	    ,
        new_Address     ,
        new_Phone       ,
		new_Role	
		
        );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Dispaly_Today_Deliveries` ()  NO SQL
SELECT d.DeliveryID, c.FName, c.Lname, d.PickupAddress, d.DropDownAddress,  c.Phone FROM delivery d 
INNER JOIN customers c ON
d.CustomerID=c.CustomerID
where date(d.Date)=curdate() ORDER by d.DeliveryID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DisplayDrivingExperience` (IN `new_DrivingExperience` INT)  BEGIN
		SELECT * FROM Courier WHERE 	DrivingExperience>new_DrivingExperience;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DisplaySpecificCourier` (IN `new_IDCourier` INT(1))  BEGIN
SELECT d.Date, d.DeliveryID, d.PickupAddress, d.DropDownAddress, d.PickupTime, d.DropDownTime, c.FName,c.Lname, cu.FName as FirstName, cu.Lname as LastName , d.AssignTime, d.PickupTime, d.DropDownTime, d.IsActive
FROM courier cu
INNER JOIN delivery d 
ON cu.CourierID=d.CourierID
INNER JOIN customers c 
on c.CustomerID=d.CustomerID
and cu.CourierID=new_IDCourier and d.IsCancel=0
order BY d.Date;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DisplaySpecificUser` (IN `new_User` VARCHAR(255))  BEGIN
    SELECT * FROM users WHERE FName= new_User;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_All_Active_Couriers` ()  NO SQL
SELECT c.FName, c.Lname, c.CourierID, c.Phone, s.ScooterLicense from courier c INNER JOIN scooterassign s on c.CourierID=s.CourierID and s.IsActive=1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_All_Couriers` ()  NO SQL
SELECT *  from courier c$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_all_Courier_Beside_This` (IN `New_CourierID` INT(1))  NO SQL
sELECT c.FName, c.Lname, d.CourierID, d.DeliveryID from delivery d INNER JOIN courier c on d.CourierID=c.CourierID WHERE d.CourierID != (select d.courierID from delivery d WHERE d.DeliveryID=New_CourierID ) GROUP by d.CourierID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_All_Customers` ()  NO SQL
select c.FName, c.Lname, c.CustomerID from customers c$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_All_Delivery` ()  NO SQL
select d.DeliveryID, c.FName, c.Lname, d.Date, d.PickupAddress, d.DropDownAddress, d.CourierID from delivery d INNER JOIN customers c on d.CustomerID=c.CustomerID AND (DATE(d.AssignTime)=CURDATE() ||  DATE(d.DropDownTime)=CURDATE() || DATE(d.PickupTime)=CURDATE())$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Assign_Last_Hour` ()  BEGIN
 select `d`.`DeliveryID` AS `DeliveryID` from `fus`.`delivery` `d` where (`d`.`AssignTime` >= (now() - interval 1 hour)) ;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Cancel_Delivery` ()  NO SQL
SELECT d.DeliveryID, c.FName, c.Lname, d.PickupAddress, c.Phone, time(d.CancelTime) as CancelTime  FROM delivery d INNER JOIN customers c ON d.CustomerID=c.CustomerID  and d.IsCancel=1 and date(d.CancelTime)=curdate() ORDER BY d.DeliveryID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Customer_City` (IN `New_City` VARCHAR(255))  NO SQL
select * from customers c WHERE c.Address=New_City$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Customer_Delivery` (IN `new_CustomerID` INT)  BEGIN


SELECT d.Date,c.FName, c.Lname, d.DeliveryID, d.PickupAddress, d.DropDownAddress,d.AssignTime, d.PickupTime, d.DropDownTime, d.IsActive, d.CancelTime, cu.FName as CourierFName, cu.Lname as courierLName
FROM delivery d 
INNER JOIN customers c ON d.CustomerID=c.CustomerID
INNER JOIN courier cu on d.CourierID=cu.CourierID
and d.CustomerID=new_CustomerID and d.IsCancel=0;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Delivery` (IN `new_DeliveryID` INT)  BEGIN
    SELECT * FROM delivery WHERE DeliveryID=new_DeliveryID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Delivery_By_Courier` (IN `new_DeliverID` INT)  NO SQL
BEGIN


SELECT c.FName, c.Lname, d.DeliveryID, d.PickupAddress, d.DropDownAddress,d.AssignTime, d.PickupTime, d.DropDownTime, d.IsActive, d.CancelTime, d.CourierID , cu.FName as customerFirstName, cu.Lname as customeLastName
FROM delivery d 
INNER JOIN courier c ON 
d.CourierID=c.CourierID 
INNER JOIN customers cu ON
d.CustomerID=cu.CustomerID
and d.DeliveryID=new_DeliverID and d.IsCancel=0;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Delivery_Status` (IN `deliverystatus` INT)  BEGIN
select d.DeliveryID,  d.PickupAddress, d.DropDownAddress, c.FName, c.Lname  from delivery d inner JOIN courier c on d.IsActive=deliverystatus and c.CourierID=d.CourierID ORDER by d.DeliveryID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Drop_Last_Hour` ()  NO SQL
select `d`.`DeliveryID` AS `DeliveryID` from `fus`.`delivery` `d` where (`d`.`DropDownTime` >= (now() - interval 1 hour))$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_EOD_Delivery` ()  NO SQL
SELECT d.DeliveryID, c.FName, c.Lname, time(d.AssignTime) as AssignTime , time(d.PickupTime) as PickupTime , time(d.DropDownTime) as DropDownTime FROM delivery d INNER JOIN customers c ON d.CustomerID=c.CustomerID where date(d.AssignTime)=curdate() or Date(d.DropDownTime)=curdate() OR Date(d.PickupTime)=curdate()$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Pickup_Last_Hour` ()  NO SQL
select `d`.`DeliveryID` AS `DeliveryID` from `fus`.`delivery` `d` where (`d`.`PickupTime` >= (now() - interval 1 hour))$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_ScooterDelivery` (IN `new_ScooterLicense` INT)  BEGIN
		SELECT * FROM scooterassign s INNER join delivery d WHERE s.ScooterLicense = new_ScooterLicense ORDER BY `d`.`DeliveryID` ASC;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_scooter_Active_Assign` (IN `new_IsActive` INT)  BEGIN
       select FName from courier c inner JOIN scooterassign s on c.CourierID=s.CourierID where s.IsActive=new_IsActive order by s.AssignTime asc;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_scooter_Assign_By_CourierID` (IN `new_CourierID` INT)  BEGIN
		SELECT * from scooterassign s where s.CourierID=new_CourierID; 
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_scooter_Assign_By_Date` (IN `new_Date` DATETIME)  BEGIN
		SELECT * from scooterassign s where s.Date>new_Date order by s.AssignTime asc; 
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_scooter_Assign_By_Shift` (IN `new_Shift` TINYINT)  BEGIN
		SELECT * from scooterassign s where s.Shift=new_Shift order by s.CourierID ASC; 
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Scooter_By_KM` (IN `new_CurrentKM` VARCHAR(7))  BEGIN
    SELECT * FROM scooters where CurrentKM>new_CurrentKM;	

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Scooter_By_Model` (IN `new_Model` VARCHAR(7))  BEGIN
    SELECT * FROM scooters where scooters.Model=new_Model;	

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Scooter_By_Nexttretment` (IN `new_Nexttretment` VARCHAR(7))  BEGIN
    SELECT * FROM scooters where scooters.NextTreatment between (new_Nexttretment-10000 +1) and new_Nexttretment;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Scooter_By_Type` (IN `new_Type` VARCHAR(7))  BEGIN
    SELECT * FROM scooters where scooters.Type=new_Type;	

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Scooter_History` (IN `new_ScooterLicense` VARCHAR(7))  BEGIN
    SELECT * FROM scooters INNER JOIN scooterassign on scooters.ScooterLicense=scooterassign.ScooterLicense and scooters.ScooterLicense=new_ScooterLicense;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Shift_Couriers` ()  NO SQL
SELECT DISTINCT c.FName, c.Lname, d.Date, d.DeliveryID, d.PickupAddress, d.DropDownAddress,(SELECT TIME(d.AssignTime)) as "AssignDelivery", (SELECT TIME (d.PickupTime)) as "PickupDelivery", (SELECT TIME (d.DropDownTime)) as "DropDelivery", s.ScooterLicense, (SELECT TIME (s.AssignTime)) as "AssignScooter", (SELECT TIME (s.DropTime)) as "DropScooter" FROM delivery d LEFT JOIN courier c ON c.CourierID=d.CourierID left JOIN scooterassign s ON c.CourierID=s.CourierID WHERE DATE(d.AssignTime)=CURDATE() || DATE(d.DropDownTime)=CURDATE() || DATE(d.PickupTime)=CURDATE() GROUP by d.DeliveryID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Total_Customer_Deliveries` (IN `new_CustomerID` INT)  NO SQL
SELECT COUNT(*)from delivery d WHERE d.CustomerID=new_CustomerID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_user_by_role` ()  BEGIN
    SELECT * FROM users ORDER by Role;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetOfficeByCountry` (IN `countryName` VARCHAR(255))  BEGIN
 SELECT * 
 FROM offices
 WHERE country = countryName;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Insert_New_Scooter` (IN `new_ScooterLicense` VARCHAR(7), IN `new_Type` VARCHAR(255), IN `new_Model` YEAR(4), IN `new_NextTreatment` INT(11), IN `new_CurrentKM` INT(11))  BEGIN
    INSERT INTO Scooters  (
        		ScooterLicense 	,
                Type	 		,
                Model			,
                NextTreatment 	,
                CurrentKM 		
    )
    VALUES(
        new_ScooterLicense 		,
        new_Type	 			, 
        new_Model				,
        new_NextTreatment 		,
        new_CurrentKM 		
        );
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Insert_New_User` (IN `New_UserName` VARCHAR(255), IN `New_Password` VARCHAR(255), IN `New_FName` VARCHAR(255), IN `New_Lname` VARCHAR(255), IN `New_Address` VARCHAR(255), IN `New_Phone` VARCHAR(11), IN `New_Role` INT(1))  NO SQL
INSERT INTO `users`(`UserName`, `Password`, `FName`, `Lname`, `Address`, `Phone`, `Role`) VALUES (New_UserName, New_Password ,New_FName, New_Lname, New_Address, New_Phone, New_Role )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UnAssign_Scooter` (IN `new_ScooterLicense` VARCHAR(7))  BEGIN
 if exists (SELECT *  FROM  scooterassign  WHERE ScooterLicense = new_ScooterLicense and isActive=1) then
 update scooterassign set DropTime=sysDate()  where ScooterLicense = new_ScooterLicense and isActive=1;
  update scooterassign set  isActive=0 where ScooterLicense = new_ScooterLicense and isActive=1;
 else
 select "Error. This scooter is not assign"; 

	
 end if;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_All_Time` (IN `New_DeliveryID` INT, IN `new_selector` INT)  NO SQL
BEGIN

if
 (SELECT delivery.AssignTime FROM delivery WHERE delivery.DeliveryID=New_DeliveryID) IS NULL AND 
 new_selector=0 THEN 
update delivery set delivery.AssignTime=sysDate(), delivery.IsActive=1 
where delivery.DeliveryID=New_DeliveryID;
ELSEIF 
	(SELECT delivery.PickupTime FROM delivery WHERE delivery.DeliveryID=New_DeliveryID) IS NULL AND
	(select delivery.AssignTime from delivery WHERE delivery.DeliveryID=New_DeliveryID ) is NOT NULL  AND 
	new_selector=1  THEN
    update delivery set delivery.PickupTime =sysDate(),  delivery.IsActive=1 where delivery.DeliveryID=New_DeliveryID;
   ELSEIF
   (SELECT delivery.DropDownTime FROM delivery  WHERE delivery.DeliveryID=New_DeliveryID) IS NULL  AND
   (select delivery.AssignTime from delivery WHERE delivery.DeliveryID=New_DeliveryID) IS NOT NULL and
   (select delivery.PickupTime from delivery WHERE delivery.DeliveryID=New_DeliveryID) is NOT null  AND 
   new_selector=2 THEN
  update delivery set delivery.DropDownTime=sysDate() , delivery.IsActive=0 where delivery.DeliveryID=New_DeliveryID;
 
 END IF;
 
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Cancel_Delivery` (IN `New_DeliveryID` INT)  BEGIN
UPDATE delivery d set d.IsCancel=1, d.CancelTime=curtime() where DeliveryID=New_DeliveryID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Courier_Address` (IN `new_Courier` VARCHAR(255), IN `new_Address` VARCHAR(255))  BEGIN
    UPDATE courier set Address=new_Address where courier.Fname=new_Courier;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Courier_Phone` (IN `new_Courier` VARCHAR(255), IN `new_Phone` VARCHAR(255))  BEGIN
    UPDATE courier set Phone=new_Phone where courier.Fname=new_Courier;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Customer_Address` (IN `New_CustomerID` INT, IN `New_Address` VARCHAR(255))  BEGIN
	update customers set Address=New_Address where CustomerID=New_CustomerID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Customer_Phone` (IN `New_CustomerID` INT, IN `New_Phone` VARCHAR(255))  BEGIN
	update customers set Phone=New_Phone where CustomerID=New_CustomerID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Delivery_Address` ()  NO SQL
UPDATE delivery d SET d.DropDownAddress= ELT(1 + FLOOR(RAND()*58),
'Afula       ',
'Akko        ',
'Arad        ',
'Ariel       ',
'Ashdod      ',
'Ashkelon    ',
'Bat Yam     ',
'Beer Sheva  ',
'Beit Shean  ',
'Beit Shemesh',
'Betar Illit ',
'Bnei Berak  ',
'Dimona      ',
'Eilat       ',
'Givatayim   ',
'Hadera      ',
'Haifa       ',
'Herzliya    ',
'Hod HaSharon',
'Holon			',
'Jerusalem     ' ,
'Karmiel       ' ,
'Kfar Sava     ' ,
'Kiryat Ata    ' ,
'Kiryat Bialik ' ,
'Kiryat Gat    ' ,
'Kiryat Malachi' ,
'Kiryat Motzkin' ,
'Kiryat Ono    ' ,
'Kiryat Shemone' ,
'Kiryat Yam    ' ,
'Lod           ' ,
'Maale Adumim  ' ,
'Maalot Tarshih' ,
'Migdal HaEmek ' ,
'Modiin        ' ,
'Nahariya      ' ,
'Nazareth      ' ,
'Nazareth Illit' ,
'Nes Ziona     ' ,
'Nesher        ' ,
'Netanya       ' ,
'Netivot       ' ,
'Or Yehuda     ' ,
'Petah Tikva   ' ,
'Raanana       ' ,
'Ramat Hasharon' ,
'Ramat-Gan     ' ,
'Ramla         ' ,
'Rehovot       ' ,
'Rishon Lezion ' ,
'Rosh Haayin  ' ,
'Sderot        ' ,
'Tel Aviv      ' ,
'Tiberias      ' ,
'Tirat Carmel  ' ,
'Tsfat         ' )$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_DropDownAddress` (IN `New_DeliveryID` INT, IN `New_DropDownAddress` VARCHAR(255))  BEGIN
    UPDATE Delivery set DropDownAddress=New_DropDownAddress where DeliveryID=New_DeliveryID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_PickupAddress` (IN `New_DeliveryID` INT, IN `New_PickupAddress` VARCHAR(255))  BEGIN
    UPDATE Delivery set PickupAddress=New_PickupAddress where DeliveryID=New_DeliveryID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Scooter_CurrentKM` (IN `new_ScooterLicense` VARCHAR(7), IN `new_CurrentKM` INT)  BEGIN
    UPDATE Scooters set CurrentKM=new_CurrentKM where ScooterLicense=new_ScooterLicense;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Scooter_Nexttretment` (IN `new_ScooterLicense` VARCHAR(7))  BEGIN
    UPDATE Scooters set NextTreatment=NextTreatment+10000 where ScooterLicense=new_ScooterLicense;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Status` (IN `New_DeliveryID` INT, IN `New_IsActive` TINYINT)  BEGIN
    UPDATE Delivery set IsActive=New_IsActive where DeliveryID=New_DeliveryID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_User_Address` (IN `new_User` VARCHAR(255), IN `new_Address` VARCHAR(255))  BEGIN
    UPDATE users set Address=new_Address where users.UserName=new_User;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_User_password` (IN `new_User` VARCHAR(255), IN `new_password` VARCHAR(255))  BEGIN
    UPDATE users set password=new_password where users.UserName=new_User;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_User_Phone` (IN `new_User` VARCHAR(255), IN `new_Phone` VARCHAR(11))  BEGIN
    UPDATE users set Phone=new_Phone where users.UserName=new_User;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_User_Role` (IN `new_User` VARCHAR(255), IN `new_role` INT(1))  BEGIN
    UPDATE users set role=new_role where users.UserName=new_User;
END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `Is_TimeUpdate_Possiable` (`New_DeliveryID` INT(1) UNSIGNED) RETURNS INT(10) UNSIGNED NO SQL
BEGIN

IF (SELECT delivery.AssignTime FROM delivery  WHERE delivery.DeliveryID=New_DeliveryID) IS NULL  THEN 
RETURN 1;
ELSEIF 
	(SELECT delivery.PickupTime FROM delivery  WHERE delivery.DeliveryID=New_DeliveryID) IS null  THEN
    RETURN 2;
   ELSEIF
   (SELECT delivery.DropDownTime FROM delivery  WHERE delivery.DeliveryID=New_DeliveryID) IS null  THEN
  RETURN 3;
else
return 4;

 END IF;
 
 END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `courier`
--

CREATE TABLE `courier` (
  `CourierID` int(11) NOT NULL,
  `FName` varchar(255) NOT NULL,
  `Lname` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Phone` varchar(11) NOT NULL,
  `DrivingExperience` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=hebrew;

--
-- Dumping data for table `courier`
--

INSERT INTO `courier` (`CourierID`, `FName`, `Lname`, `Address`, `Phone`, `DrivingExperience`) VALUES
(21, 'James	', 'Karen	    ', 'Migdal haemek ', '565-4355555', 5),
(22, 'John	', 'Ruth	    ', 'Hadera      ', '555-8889997', 9),
(23, 'Robert	', 'Sharon	    ', 'Kiryat shemone', '333-3333333', 5),
(24, 'Michael', 'Susan	    ', 'Raanana       ', '444-4444444', 6),
(25, 'James	', 'Dorothy	', 'Kfar sava     ', '555-5555555', 7),
(26, 'Michael', 'Steven	', 'Modiin        ', '222-2222222', 4),
(27, 'John	', 'Margaret', 'Rishon lezion ', '666-6666666', 4),
(28, 'Michael', 'David	', 'Kiryat ono    ', '666-5566778', 6),
(29, 'Michael', 'Sharon	    ', 'Rehovot       ', '563-6756565', 6),
(30, 'Robert	', 'Larry	', 'Raanana       ', '666-5566778', 6),
(31, 'Robert	', 'Anna	    ', 'Karmiel       ', '555-5544887', 8);

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `CustomerID` int(11) NOT NULL,
  `FName` varchar(255) NOT NULL,
  `Lname` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Phone` varchar(11) NOT NULL,
  `numberOfDelivery` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=hebrew;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`CustomerID`, `FName`, `Lname`, `Address`, `Phone`, `numberOfDelivery`) VALUES
(1, 'John	', 'Richard', 'Jerusalem     ', '666-6666666', 24),
(2, 'Ruth	    ', 'Dorothy	', 'Tirat Carmel  ', '111-1111111', 23),
(3, 'Susan	    ', 'Betty	    ', 'Raanana       ', '058-7894562', 19),
(4, 'Nancy	    ', 'Linda	    ', 'Afula       ', '222-2222222', 21),
(5, 'Mary		', 'Linda	    ', 'Nazareth Illit', '222-2222222', 22),
(6, 'Mary		', 'James	', 'Jerusalem     ', '888-9999999', 14),
(7, 'Amy        ', 'Elizabet   ', 'Netivot       ', '777-7777777', 12),
(8, 'Donald	', 'Lisa	    ', 'Migdal HaEmek ', '555-5555555', 15),
(9, 'Matthew', 'Barbara	', 'Petah Tikva   ', '345-3452345', 0),
(10, 'Paul	', 'Carol	    ', 'Akko        ', '345-3452345', 0),
(11, 'Shirley	', 'Robert	', 'Rosh Haayin  ', '345-3452345', 0),
(12, 'Donna	    ', 'Richard', 'Karmiel       ', '111-1111111', 0),
(13, 'Amy        ', 'Timothy', 'Beit Shean  ', '111-1111111', 0);

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `DeliveryID` int(11) NOT NULL,
  `Date` datetime NOT NULL,
  `PickupAddress` varchar(255) NOT NULL,
  `DropDownAddress` varchar(255) NOT NULL,
  `CustomerID` int(11) NOT NULL,
  `CourierID` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT '0',
  `AssignTime` datetime DEFAULT NULL,
  `PickupTime` datetime DEFAULT NULL,
  `DropDownTime` datetime DEFAULT NULL,
  `IsCancel` tinyint(1) NOT NULL DEFAULT '0',
  `CancelTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=hebrew;

--
-- Dumping data for table `delivery`
--

INSERT INTO `delivery` (`DeliveryID`, `Date`, `PickupAddress`, `DropDownAddress`, `CustomerID`, `CourierID`, `IsActive`, `AssignTime`, `PickupTime`, `DropDownTime`, `IsCancel`, `CancelTime`) VALUES
(1, '2016-09-10 23:36:57', 'Betar Illit ', 'Lod           ', 1, 22, 1, '2016-09-11 00:00:00', '2016-09-10 15:51:57', '2016-09-10 15:52:57', 1, '2016-09-16 00:01:04'),
(2, '2016-09-11 00:00:00', 'Petah Tikva   ', 'Sderot        ', 2, 30, 0, '2016-09-10 11:04:40', '2016-07-08 10:29:00', '2016-09-10 11:06:30', 1, '2016-09-16 00:04:45'),
(3, '2015-07-12 00:00:00', 'Holon			', 'Rishon Lezion ', 3, 30, 1, '2016-09-05 19:51:28', '2016-09-10 11:07:56', '2016-09-10 11:06:45', 0, '0000-00-00 00:00:00'),
(4, '2014-07-12 00:00:00', 'Holon			', 'Nes Ziona     ', 4, 28, 1, '2016-09-10 13:40:56', '2016-09-10 11:08:03', '2016-07-08 13:17:01', 1, '2016-09-16 00:05:34'),
(5, '2016-09-11 00:00:00', 'Nazareth Illit', 'Raanana       ', 5, 30, 0, '2016-09-05 22:09:50', '2016-09-10 15:54:48', '2016-09-05 22:09:38', 1, '0000-00-00 00:00:00'),
(6, '2016-09-11 00:00:00', 'Jerusalem     ', 'Sderot        ', 2, 27, 1, '2016-09-05 22:22:42', '2016-09-10 15:55:08', '2016-09-10 15:56:14', 1, '2016-09-11 20:39:24'),
(7, '2016-09-11 00:00:00', 'Raanana       ', 'Bat Yam     ', 3, 24, 0, '2016-09-10 13:40:56', '2016-09-10 22:41:34', '2016-09-10 22:41:53', 1, '2016-09-05 00:00:00'),
(8, '2016-09-11 00:00:00', 'Ramat-Gan     ', 'Rosh Haayin  ', 1, 29, 0, '2016-09-10 13:40:56', '2016-09-11 17:54:01', '2016-09-11 18:17:33', 1, '2016-09-11 21:07:51'),
(9, '2016-09-11 00:00:00', 'Petah Tikva   ', 'Ashkelon    ', 1, 21, 1, '2016-09-10 13:40:56', '2016-07-11 21:26:33', '2016-09-11 17:54:01', 1, '2016-09-16 00:07:21'),
(10, '2014-06-12 00:00:00', 'Kiryat Ata    ', 'Ramat Hasharon', 2, 29, 0, '2016-09-10 13:40:56', '2016-09-11 17:54:01', '2016-09-11 18:18:54', 0, '0000-00-00 00:00:00'),
(11, '2014-06-12 00:00:00', 'Nesher        ', 'Netivot       ', 2, 29, 0, '2016-09-10 13:40:56', '2016-09-11 17:54:01', '2016-09-13 22:21:10', 0, '0000-00-00 00:00:00'),
(12, '2014-06-12 00:00:00', 'Haifa       ', 'Givatayim   ', 2, 23, 0, '2016-09-10 15:41:31', '2016-09-11 17:54:01', '2016-09-10 13:42:01', 0, '0000-00-00 00:00:00'),
(13, '2014-06-12 00:00:00', 'Holon			', 'Ariel       ', 2, 24, 1, '2016-09-11 17:54:01', '2016-09-14 09:20:02', '2016-09-10 13:42:01', 0, '0000-00-00 00:00:00'),
(14, '2015-05-12 00:00:00', 'Ramat Hasharon', 'Lod           ', 2, 29, 1, '2016-09-11 18:19:23', '2016-09-14 09:25:12', '2016-09-10 13:42:01', 0, '0000-00-00 00:00:00'),
(15, '2015-05-12 00:00:00', 'Afula       ', 'Lod           ', 2, 24, 1, '2016-09-13 18:38:08', '2016-09-15 08:30:31', '2016-09-10 13:42:01', 1, '2016-09-11 00:00:00'),
(16, '2015-05-12 00:00:00', 'Modiin        ', 'Ashkelon    ', 2, 23, 1, '2016-09-15 08:27:45', '2016-09-15 08:27:48', '2016-09-10 13:42:01', 0, '0000-00-00 00:00:00'),
(17, '2015-05-12 00:00:00', 'Arad        ', 'Rehovot       ', 2, 27, 0, NULL, NULL, '2016-09-10 13:42:01', 0, '0000-00-00 00:00:00'),
(18, '2014-06-12 00:00:00', 'Jerusalem     ', 'Tiberias      ', 2, 27, 1, '2016-09-15 14:45:35', '2016-09-15 23:06:36', NULL, 0, '0000-00-00 00:00:00'),
(19, '2014-06-12 00:00:00', 'Nes Ziona     ', 'Beit Shean  ', 2, 24, 0, '2016-09-14 08:35:34', '2016-09-14 08:36:37', '2016-09-14 08:36:51', 0, '0000-00-00 00:00:00'),
(20, '2014-06-12 00:00:00', 'Hod HaSharon', 'Tirat Carmel  ', 2, 28, 1, NULL, NULL, NULL, 0, '2016-09-11 00:00:00'),
(21, '2015-05-12 00:00:00', 'Maalot Tarshih', 'Herzliya    ', 2, 22, 0, '2016-09-15 23:14:29', '2016-09-09 16:43:13', '2016-09-15 23:14:31', 1, '2016-09-16 00:03:35'),
(22, '2015-05-12 00:00:00', 'Tirat Carmel  ', 'Nahariya      ', 2, 31, 1, '2016-09-09 16:33:25', NULL, NULL, 0, '2016-09-11 00:00:00'),
(23, '2015-05-12 00:00:00', 'Afula       ', 'Hadera      ', 2, 27, 1, NULL, NULL, NULL, 0, '2016-09-11 00:00:00'),
(24, '2015-05-12 00:00:00', 'Dimona      ', 'Kiryat Malachi', 2, 24, 1, '2016-09-15 15:13:40', NULL, NULL, 1, '2016-09-16 00:00:36'),
(25, '2016-07-12 00:00:00', '', 'Kiryat Gat    ', 1, 29, 0, '2016-09-14 11:42:08', '2016-09-14 11:42:10', '2016-09-14 11:42:12', 1, '2016-09-16 00:09:08'),
(26, '2016-07-12 00:00:00', 'Jerusalem     ', 'Rosh Haayin  ', 1, 31, 0, NULL, NULL, '2016-09-09 16:37:10', 1, '2016-09-16 00:10:51'),
(30, '2014-06-12 00:00:00', 'Petah Tikva   ', 'Ashdod      ', 2, 24, 1, '2016-09-15 14:53:39', '2016-09-15 23:53:43', NULL, 0, '0000-00-00 00:00:00'),
(31, '2014-06-12 00:00:00', 'Raanana       ', 'Petah Tikva   ', 2, 27, 1, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(37, '2014-06-12 00:00:00', 'Nahariya      ', 'Maale Adumim  ', 2, 27, 1, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(40, '2014-06-12 00:00:00', 'Petah Tikva   ', 'Kiryat Ono    ', 2, 21, 0, '2016-09-14 14:51:24', '2016-09-14 14:51:26', '2016-09-14 17:45:35', 0, '0000-00-00 00:00:00'),
(41, '2014-06-12 00:00:00', 'Tsfat         ', 'Raanana       ', 2, 27, 1, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(42, '2014-06-12 00:00:00', 'Migdal HaEmek ', 'Kiryat Gat    ', 2, 29, 0, '2016-09-14 10:55:22', '2016-09-14 11:31:17', '2016-09-14 11:32:29', 0, '0000-00-00 00:00:00'),
(43, '2014-06-12 00:00:00', '', 'Ramla         ', 2, 31, 1, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(44, '2014-06-12 00:00:00', 'Dimona      ', 'Rehovot       ', 2, 28, 0, '2016-09-15 15:10:36', NULL, '2016-09-15 15:16:17', 0, '0000-00-00 00:00:00'),
(45, '2014-06-12 00:00:00', 'Beer Sheva  ', 'Ramat Hasharon', 2, 30, 0, '2016-09-15 15:16:02', '2016-09-15 15:16:05', '2016-09-15 15:16:07', 0, '0000-00-00 00:00:00'),
(46, '2014-06-12 00:00:00', 'Tirat Carmel  ', 'Kiryat Gat    ', 2, 24, 0, '2016-09-14 08:45:09', '2016-09-14 08:59:19', '2016-09-14 09:00:25', 0, '0000-00-00 00:00:00'),
(47, '2014-06-12 00:00:00', 'Kiryat Gat    ', 'Ramat-Gan     ', 2, 21, 0, '2016-09-14 17:48:03', '2016-09-14 17:49:15', '2016-09-14 17:49:17', 0, '0000-00-00 00:00:00'),
(55, '2014-06-12 00:00:00', 'Hod HaSharon', 'Netivot       ', 2, 27, 1, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(56, '2016-07-12 00:00:00', 'Hadera      ', 'Bnei Berak  ', 1, 28, 1, '2016-09-16 13:43:46', NULL, NULL, 1, '2016-09-16 13:46:10'),
(57, '2016-07-12 00:00:00', 'Kfar Sava     ', 'Ramla         ', 1, 28, 0, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(58, '2016-07-12 00:00:00', 'Bat Yam     ', 'Migdal HaEmek ', 1, 25, 1, '2016-09-15 14:50:20', NULL, NULL, 0, '0000-00-00 00:00:00'),
(59, '2016-07-12 00:00:00', 'Kiryat Ata    ', 'Kiryat Gat    ', 1, 28, 0, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(60, '2016-07-12 00:00:00', 'Netivot       ', 'Kiryat Malachi', 1, 26, 0, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(61, '2016-07-12 00:00:00', 'Kiryat Ata    ', 'Tel Aviv      ', 1, 23, 0, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(62, '2016-07-12 00:00:00', 'Ramat-Gan     ', 'Eilat       ', 1, 26, 0, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(65, '2014-06-12 00:00:00', 'Sderot        ', 'Kiryat Gat    ', 2, 21, 1, '2016-09-15 14:47:27', NULL, NULL, 0, '0000-00-00 00:00:00'),
(66, '2014-06-12 00:00:00', 'Ariel       ', 'Kiryat Shemone', 2, 26, 1, '2016-09-15 21:43:58', NULL, NULL, 0, '0000-00-00 00:00:00'),
(67, '2014-06-12 00:00:00', 'Maale Adumim  ', 'Dimona      ', 2, 27, 1, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(69, '2014-06-12 00:00:00', 'Nahariya      ', 'Kiryat Shemone', 2, 27, 1, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(70, '2014-06-12 00:00:00', 'Kiryat Motzkin', 'Tirat Carmel  ', 2, 25, 0, '2016-09-14 22:49:58', '2016-09-14 23:04:05', '2016-09-14 23:04:06', 0, '0000-00-00 00:00:00'),
(71, '2014-06-12 00:00:00', 'Kiryat Malachi', 'Dimona      ', 2, 28, 1, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(72, '2014-06-12 00:00:00', 'Tel Aviv      ', 'Betar Illit ', 2, 24, 1, '2016-09-15 14:49:53', NULL, NULL, 0, '0000-00-00 00:00:00'),
(73, '2014-06-12 00:00:00', 'Betar Illit ', 'Herzliya    ', 2, 27, 1, '2016-09-15 15:19:53', NULL, NULL, 0, '0000-00-00 00:00:00'),
(74, '2014-06-12 00:00:00', 'Beer Sheva  ', '', 2, 23, 1, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(75, '2014-06-12 00:00:00', 'Beit Shean  ', 'Afula       ', 2, 28, 1, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(76, '2014-06-12 00:00:00', 'Herzliya    ', 'Ariel       ', 2, 29, 0, '2016-09-14 11:30:31', '2016-09-14 11:30:37', '2016-09-14 11:30:48', 0, '0000-00-00 00:00:00'),
(78, '2014-06-12 00:00:00', 'Ariel       ', 'Givatayim   ', 2, 22, 0, '2016-09-14 22:58:04', '2016-09-15 08:13:34', '2016-09-15 08:13:35', 0, '0000-00-00 00:00:00'),
(79, '2014-06-12 00:00:00', 'Kfar Sava     ', 'Beer Sheva  ', 2, 23, 1, '2016-09-14 14:08:22', '2016-09-14 14:08:25', NULL, 0, '0000-00-00 00:00:00'),
(80, '2014-06-12 00:00:00', 'Raanana       ', 'Rehovot       ', 2, 23, 0, '2016-09-14 18:28:25', '2016-09-15 08:15:11', '2016-09-15 08:15:12', 0, '0000-00-00 00:00:00'),
(81, '2014-06-12 00:00:00', 'Raanana       ', 'Tel Aviv      ', 1, 30, 1, '2016-09-15 22:25:25', '2016-09-15 23:03:00', NULL, 0, '0000-00-00 00:00:00'),
(82, '2016-07-08 00:00:00', 'Kiryat Yam    ', 'Ariel       ', 1, 21, 1, '2016-09-15 14:13:18', NULL, NULL, 0, '0000-00-00 00:00:00'),
(83, '0000-00-00 00:00:00', 'Herzliya    ', 'Kiryat Ono    ', 2, 31, 1, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(84, '2016-07-08 00:00:00', 'Tirat Carmel  ', 'Hod HaSharon', 1, 27, 0, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(85, '2016-07-08 00:00:00', 'Ramla         ', 'Ariel       ', 3, 31, 0, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(86, '2016-07-08 12:54:28', 'Hod HaSharon', 'Kiryat Ata    ', 5, 22, 0, '2016-09-15 14:26:46', '2016-09-15 23:07:08', '2016-09-15 23:07:14', 1, '2016-09-16 00:01:54'),
(87, '2016-07-08 12:55:40', 'Ashkelon    ', 'Ramat-Gan     ', 6, 27, 0, NULL, NULL, NULL, 0, '0000-00-00 00:00:00'),
(88, '2016-07-08 13:05:24', 'Lod           ', 'Sderot        ', 3, 27, 0, NULL, NULL, NULL, 0, '0000-00-00 00:00:00');

--
-- Triggers `delivery`
--
DELIMITER $$
CREATE TRIGGER `UpdateDelivery` AFTER INSERT ON `delivery` FOR EACH ROW UPDATE customers c
SET numberOfDelivery=c.numberOfDelivery +1
WHERE new.CustomerID=CustomerID
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `scooterassign`
--

CREATE TABLE `scooterassign` (
  `ScooterLicense` varchar(7) NOT NULL,
  `AssignTime` datetime NOT NULL,
  `DropTime` datetime NOT NULL,
  `Shift` tinyint(4) NOT NULL,
  `CourierID` int(11) NOT NULL,
  `IsActive` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=hebrew;

--
-- Dumping data for table `scooterassign`
--

INSERT INTO `scooterassign` (`ScooterLicense`, `AssignTime`, `DropTime`, `Shift`, `CourierID`, `IsActive`) VALUES
('2222222', '2016-08-03 00:00:00', '0000-00-00 00:00:00', 1, 22, 0),
('9999999', '2016-10-04 00:00:00', '2016-07-11 20:40:18', 2, 23, 0),
('4444444', '2016-11-02 00:00:00', '2016-09-10 01:26:00', 2, 24, 0),
('1111111', '2014-09-12 00:00:00', '0000-00-00 00:00:00', 1, 22, 0),
('1111111', '2016-07-11 19:37:20', '2016-09-10 01:07:09', 2, 27, 0),
('1111111', '2016-07-11 19:45:35', '2016-09-10 01:07:09', 2, 22, 0),
('2222222', '2016-07-11 19:46:21', '2016-09-10 01:08:16', 2, 21, 0),
('2222222', '2016-09-10 01:06:37', '2016-09-10 01:08:16', 0, 25, 0),
('2222222', '2016-09-10 01:08:31', '0000-00-00 00:00:00', 0, 29, 1),
('4444444', '2016-09-10 01:26:38', '0000-00-00 00:00:00', 0, 24, 1);

-- --------------------------------------------------------

--
-- Table structure for table `scooters`
--

CREATE TABLE `scooters` (
  `ScooterLicense` varchar(7) NOT NULL,
  `Type` varchar(255) NOT NULL,
  `Model` year(4) NOT NULL,
  `NextTreatment` int(11) NOT NULL DEFAULT '10000',
  `CurrentKM` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=hebrew;

--
-- Dumping data for table `scooters`
--

INSERT INTO `scooters` (`ScooterLicense`, `Type`, `Model`, `NextTreatment`, `CurrentKM`) VALUES
('1111111', 'aa', 1989, 10000, 7000),
('1234567', 'gfd', 1980, 20000, 15789),
('2222222', 'ss', 0000, 20000, 4562),
('4444444', 'gg', 1990, 20000, 5622),
('8888888', 'ff', 1980, 37000, 5433),
('9999999', 'dd', 1978, 40000, 352);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `UserName` varchar(255) NOT NULL,
  `Password` varchar(255) NOT NULL,
  `FName` varchar(255) NOT NULL,
  `Lname` varchar(255) NOT NULL,
  `Address` varchar(255) DEFAULT NULL,
  `Phone` varchar(11) DEFAULT NULL,
  `Role` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=hebrew;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`UserName`, `Password`, `FName`, `Lname`, `Address`, `Phone`, `Role`) VALUES
('', '', '', '', '', '', 0),
('aaa', '123456', 'Dorothy	', 'Jennifer   ', 'Haifa       ', '963-8527415', 1),
('DanN', '123456', 'Dan', 'Mor', 'Bat-Yam', '058-7894562', 0),
('ddd', 'ddd', 'Maria	    ', 'Brian	', 'Kiryat Motzkin', '444-4444444', 1),
('ffff', 'ffff', 'Kathleen   ', 'Angela	    ', 'Kiryat Motzkin', '555-5555555', 0),
('ggg', 'ggg', 'Brian	', 'Elizabet   ', 'Tel Aviv      ', '333-3333333', 0),
('MikeM', '123456', 'Mike', 'Man', 'Tel-Aviv', '052-7894565', 1),
('mmm', 'mmm', 'Barbara	', 'Virginia   ', 'Eilat       ', '222-2222222', 0),
('sss', 'sss', 'Karen	    ', 'Anthony', 'Kiryat Ata    ', '111-1111111', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `courier`
--
ALTER TABLE `courier`
  ADD PRIMARY KEY (`CourierID`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`CustomerID`);

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`DeliveryID`),
  ADD KEY `CustomerID` (`CustomerID`),
  ADD KEY `CourierID` (`CourierID`);

--
-- Indexes for table `scooterassign`
--
ALTER TABLE `scooterassign`
  ADD KEY `ScooterLicense` (`ScooterLicense`),
  ADD KEY `CourierID` (`CourierID`),
  ADD KEY `Date` (`AssignTime`),
  ADD KEY `IsActive` (`IsActive`);

--
-- Indexes for table `scooters`
--
ALTER TABLE `scooters`
  ADD PRIMARY KEY (`ScooterLicense`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserName`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `courier`
--
ALTER TABLE `courier`
  MODIFY `CourierID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `CustomerID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;
--
-- AUTO_INCREMENT for table `delivery`
--
ALTER TABLE `delivery`
  MODIFY `DeliveryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `delivery_ibfk_1` FOREIGN KEY (`CourierID`) REFERENCES `courier` (`CourierID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `delivery_ibfk_2` FOREIGN KEY (`CustomerID`) REFERENCES `customers` (`CustomerID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `scooterassign`
--
ALTER TABLE `scooterassign`
  ADD CONSTRAINT `scooterassign_ibfk_1` FOREIGN KEY (`CourierID`) REFERENCES `courier` (`CourierID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `scooterassign_ibfk_2` FOREIGN KEY (`ScooterLicense`) REFERENCES `scooters` (`ScooterLicense`) ON DELETE CASCADE ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
