-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Aug 26, 2016 at 02:27 PM
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `DisplayDrivingExperience` (IN `new_DrivingExperience` INT)  BEGIN
		SELECT * FROM Courier WHERE 	DrivingExperience>new_DrivingExperience;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DisplaySpecificCourier` (IN `new_Courier` VARCHAR(255))  BEGIN
    SELECT * FROM Courier WHERE FName= new_Courier;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DisplaySpecificUser` (IN `new_User` VARCHAR(255))  BEGIN
    SELECT * FROM users WHERE FName= new_User;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Customer_Delivery` (IN `new_CustomerID` INT)  BEGIN
		SELECT * from customers c INNER JOIN delivery  d on c.CustomerID=d.CustomerID and c.CustomerID = new_CustomerID;

	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_Delivery` (IN `new_DeliveryID` INT)  BEGIN
    SELECT * FROM delivery WHERE DeliveryID=new_DeliveryID;

END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_ScooterDelivery` (IN `new_ScooterLicense` INT)  BEGIN
		SELECT * FROM scooterassign s INNER join delivery d WHERE s.ScooterLicense = new_ScooterLicense ORDER BY `d`.`DeliveryID` ASC;
	END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_scooter_Active_Assign` (IN `new_IsActive` INT)  BEGIN
		SELECT * from scooterassign s where s.IsActive=new_IsActive order by s.AssignTime asc; 
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Display_user_by_role` ()  BEGIN
    SELECT * FROM users ORDER by Role;

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

CREATE DEFINER=`root`@`localhost` PROCEDURE `UnAssign_Scooter` (IN `new_ScooterLicense` VARCHAR(7))  BEGIN
 if exists (SELECT *  FROM  scooterassign  WHERE ScooterLicense = new_ScooterLicense and isActive=1) then
 update scooterassign set DropTime=sysDate()  where ScooterLicense = new_ScooterLicense and isActive=1;
  update scooterassign set  isActive=0 where ScooterLicense = new_ScooterLicense and isActive=1;
 else
 select "Error. This scooter is not assign"; 

	
 end if;
 END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Assign_Time` (IN `New_DeliveryID` INT)  BEGIN
	update Delivery set Delivery.AssignTime=sysDate() where DeliveryID=New_DeliveryID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Cancel_Delivery` (IN `New_DeliveryID` INT, IN `New_IsCancel` TINYINT)  BEGIN
    UPDATE Delivery set IsCancel=New_IsCancel where DeliveryID=New_DeliveryID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_Courier` (IN `New_DeliveryID` INT, IN `New_CourierID` INT)  BEGIN
    UPDATE Delivery set CourierID=New_CourierID where DeliveryID=New_DeliveryID;
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

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_DropDownAddress` (IN `New_DeliveryID` INT, IN `New_DropDownAddress` VARCHAR(255))  BEGIN
    UPDATE Delivery set DropDownAddress=New_DropDownAddress where DeliveryID=New_DeliveryID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_DropDown_Time` (IN `New_DeliveryID` INT)  BEGIN
	update Delivery set Delivery.DropDownTime=sysDate() where DeliveryID=New_DeliveryID;
    	update Delivery set IsActive=0 where DeliveryID=New_DeliveryID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_PickupAddress` (IN `New_DeliveryID` INT, IN `New_PickupAddress` VARCHAR(255))  BEGIN
    UPDATE Delivery set PickupAddress=New_PickupAddress where DeliveryID=New_DeliveryID;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Update_PickUp_Time` (IN `New_DeliveryID` INT)  BEGIN
	update Delivery set Delivery.PickUpTime=sysDate() where DeliveryID=New_DeliveryID;
    	update Delivery set isActive=1 where DeliveryID=New_DeliveryID;
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
(21, 'aa', 'aa', 'frvf', '565-4355555', 5),
(22, 'rr', 'rr', 'rr', '555-8889997', 9),
(23, 'cc', 'cc', 'cc', '333-3333333', 5),
(24, 'dd', 'dd', 'dd', '444-4444444', 6),
(25, 'ee', 'ee', 'ee', '555-5555555', 7),
(26, 'bb', 'bb', 'bb', '222-2222222', 4),
(27, 'vv', 'vv', 'vv', '666-6666666', 4),
(28, 'jj', 'jj', 'jj', '666-5566778', 6),
(29, 'fd', 'dfd', 'fd', '563-6756565', 6);

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
(1, 'yy', 'yy', 'yy', '666-6666666', 24),
(2, 'cc', 'cc', 'oiuy', '111-1111111', 23),
(3, 'bb', 'bb', 'bb', '058-7894562', 19),
(4, 'dd', 'dd', 'ddd', '222-2222222', 21),
(5, 'ee', 'ee', 'eec', '222-2222222', 22),
(6, 'dd', 'dd', 'ddc', '888-9999999', 14),
(7, 'rr', 'rr', 'rrc', '777-7777777', 12),
(8, 'tt', 'tt', 'ttc', '555-5555555', 15),
(9, 'gg', 'gg', 'dgd', '345-3452345', 0),
(10, 'gg', 'gg', 'dgd', '345-3452345', 0),
(11, 'aa', 'aa', 'aa', '345-3452345', 0),
(12, 'aa', 'aa', 'aa', '111-1111111', 0),
(13, 'aa', 'aa', 'aa', '111-1111111', 0);

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
  `IsCancel` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=hebrew;

--
-- Dumping data for table `delivery`
--

INSERT INTO `delivery` (`DeliveryID`, `Date`, `PickupAddress`, `DropDownAddress`, `CustomerID`, `CourierID`, `IsActive`, `AssignTime`, `PickupTime`, `DropDownTime`, `IsCancel`) VALUES
(1, '2016-07-12 00:00:00', 'wer', 'ss', 1, 21, 0, '2016-07-08 04:20:00', NULL, NULL, 0),
(2, '2015-07-12 00:00:00', 'qq', 'oiu', 2, 22, 0, '2016-07-08 13:11:22', '2016-07-08 10:29:00', '2016-07-11 21:24:54', 0),
(3, '2015-07-12 00:00:00', 'ww', 'ww', 3, 23, 1, NULL, '2016-07-08 13:15:47', '2016-07-08 17:30:29', 0),
(4, '2014-07-12 00:00:00', 'ee', 'ee', 4, 24, 1, NULL, NULL, '2016-07-08 13:17:01', 0),
(5, '2013-07-12 00:00:00', 'rr', 'rr', 5, 23, 0, NULL, NULL, '2016-07-11 21:25:33', 1),
(6, '2015-07-12 00:00:00', 'qq', 'qq', 2, 21, 1, NULL, NULL, NULL, 0),
(7, '2015-07-12 00:00:00', 'ww', 'ww', 3, 23, 1, NULL, NULL, NULL, 0),
(8, '2015-08-05 00:00:00', 'ee', 'ee', 1, 22, 1, NULL, NULL, NULL, 0),
(9, '2014-07-12 00:00:00', 'rr', 'rr', 1, 23, 1, NULL, '2016-07-11 21:26:33', NULL, 0),
(10, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(11, '2014-06-12 00:00:00', 'tt', 'tt', 2, 24, 1, NULL, NULL, NULL, 0),
(12, '2014-06-12 00:00:00', 'ww', 'ww', 2, 22, 1, NULL, NULL, NULL, 0),
(13, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(14, '2015-05-12 00:00:00', 'vv', 'vv', 2, 21, 1, NULL, NULL, NULL, 0),
(15, '2015-05-12 00:00:00', 'vv', 'vv', 2, 21, 1, NULL, NULL, NULL, 0),
(16, '2015-05-12 00:00:00', 'vv', 'vv', 2, 21, 1, NULL, NULL, NULL, 0),
(17, '2015-05-12 00:00:00', 'tt', 'tt', 2, 23, 1, NULL, NULL, NULL, 0),
(18, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(19, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(20, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(21, '2015-05-12 00:00:00', 'vv', 'vv', 2, 21, 1, NULL, NULL, NULL, 0),
(22, '2015-05-12 00:00:00', 'vv', 'vv', 2, 21, 1, NULL, NULL, NULL, 0),
(23, '2015-05-12 00:00:00', 'vv', 'vv', 2, 21, 1, NULL, NULL, NULL, 0),
(24, '2015-05-12 00:00:00', 'vv', 'vv', 2, 21, 1, NULL, NULL, NULL, 0),
(25, '2016-07-12 00:00:00', 'ss', 'ss', 1, 21, 0, NULL, NULL, NULL, 0),
(26, '2016-07-12 00:00:00', 'ss', 'ss', 1, 22, 0, NULL, NULL, NULL, 0),
(30, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(31, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(37, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(40, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(41, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(42, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(43, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(44, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(45, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(46, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(47, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(55, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(56, '2016-07-12 00:00:00', 'ss', 'ss', 1, 21, 0, NULL, NULL, NULL, 0),
(57, '2016-07-12 00:00:00', 'ss', 'ss', 1, 21, 0, NULL, NULL, NULL, 0),
(58, '2016-07-12 00:00:00', 'ss', 'ss', 1, 21, 0, NULL, NULL, NULL, 0),
(59, '2016-07-12 00:00:00', 'ss', 'ss', 1, 21, 0, NULL, NULL, NULL, 0),
(60, '2016-07-12 00:00:00', 'ss', 'ss', 1, 21, 0, NULL, NULL, NULL, 0),
(61, '2016-07-12 00:00:00', 'ss', 'ss', 1, 21, 0, NULL, NULL, NULL, 0),
(62, '2016-07-12 00:00:00', 'ss', 'ss', 1, 21, 0, NULL, NULL, NULL, 0),
(65, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(66, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(67, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(69, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(70, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(71, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(72, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(73, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(74, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(75, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(76, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(78, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(79, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(80, '2014-06-12 00:00:00', 'yy', 'yy', 2, 25, 1, NULL, NULL, NULL, 0),
(81, '2014-06-12 00:00:00', 'yy', 'yy', 1, 25, 1, NULL, NULL, NULL, 0),
(82, '2016-07-08 00:00:00', 'yy', 'ee', 1, 21, 0, NULL, NULL, NULL, 0),
(83, '0000-00-00 00:00:00', 'qwer', 'qwer', 2, 24, 1, NULL, NULL, NULL, 0),
(84, '2016-07-08 00:00:00', 'yy', 'ee', 1, 21, 0, NULL, NULL, NULL, 0),
(85, '2016-07-08 00:00:00', 'yyee', 'trwy', 3, 25, 0, NULL, NULL, NULL, 0),
(86, '2016-07-08 12:54:28', 'vfer', 'veev', 5, 24, 0, NULL, NULL, NULL, 0),
(87, '2016-07-08 12:55:40', 'rfhy', 'sbsg', 6, 21, 0, NULL, NULL, NULL, 0),
(88, '2016-07-08 13:05:24', 'zxc', 'zxc', 3, 24, 0, NULL, NULL, NULL, 0);

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
('4444444', '2016-11-02 00:00:00', '0000-00-00 00:00:00', 2, 24, 1),
('1111111', '2014-09-12 00:00:00', '0000-00-00 00:00:00', 1, 22, 0),
('1111111', '2016-07-11 19:37:20', '0000-00-00 00:00:00', 2, 27, 1),
('1111111', '2016-07-11 19:45:35', '0000-00-00 00:00:00', 2, 22, 1),
('2222222', '2016-07-11 19:46:21', '0000-00-00 00:00:00', 2, 21, 1);

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
('aaa', '123456', 'aaa', 'aaa', 'ggg', '963-8527415', 2),
('ddd', 'ddd', 'ddd', 'ddd', 'ddd', '444-4444444', 1),
('ffff', 'ffff', 'ffff', 'ffff', 'ffff', '555-5555555', 0),
('ggg', 'ggg', 'ggg', 'ggg', 'ggg', '333-3333333', 0),
('mmm', 'mmm', 'mmm', 'mmm', 'mmm', '222-2222222', 0),
('sss', 'sss', 'sss', 'sss', 'sss', '111-1111111', 1);

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
  MODIFY `CourierID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
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
