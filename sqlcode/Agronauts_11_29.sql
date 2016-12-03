-- phpMyAdmin SQL Dump
-- version 4.0.10deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 29, 2016 at 06:03 PM
-- Server version: 5.5.53-0ubuntu0.14.04.1
-- PHP Version: 5.5.9-1ubuntu4.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `Agronauts`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `calc`(IN `GPS_Coordinates_P1_x1` DECIMAL(6,4), IN `GPS_Coordinates_P1_y1` DECIMAL(6,4), IN `GPS_Coordinates_P2_x2` DECIMAL(6,4), IN `GPS_Coordinates_P2_y2` DECIMAL(6,4), IN `GPS_Coordinates_P3_x3` DECIMAL(6,4), IN `GPS_Coordinates_P3_y3` DECIMAL(6,4), IN `GPS_Coordinates_P4_x4` DECIMAL(6,4), IN `GPS_Coordinates_P4_y4` DECIMAL(6,4), OUT `Area` DECIMAL(9,4))
BEGIN

SET Area = abs((
(((GPS_Coordinates_P1_x1)*(GPS_Coordinates_P2_y2))-((GPS_Coordinates_P2_x2)*(GPS_Coordinates_P1_y1)))+
(((GPS_Coordinates_P2_x2)*(GPS_Coordinates_P3_y3))-((GPS_Coordinates_P3_x3)*(GPS_Coordinates_P2_y2)))+
(((GPS_Coordinates_P3_x3)*(GPS_Coordinates_P4_y4))-((GPS_Coordinates_P4_x4))*(GPS_Coordinates_P3_y3))+
(((GPS_Coordinates_P4_x4)*(GPS_Coordinates_P1_y1))-((GPS_Coordinates_P1_x1)*(GPS_Coordinates_P4_y4))))/2);


END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `calcArea`(IN `GPS_Coordinates_P1_x1` DECIMAL(6,4), IN `GPS_Coordinates_P1_y1` DECIMAL(6,4), IN `GPS_Coordinates_P2_x2` DECIMAL(6,4), IN `GPS_Coordinates_P2_y2` DECIMAL(6,4), IN `GPS_Coordinates_P3_x3` DECIMAL(6,4), IN `GPS_Coordinates_P3_y3` DECIMAL(6,4), IN `GPS_Coordinates_P4_x4` DECIMAL(6,4), IN `GPS_Coordinates_P4_y4` DECIMAL(6,4))
UPDATE FIELD SET Area = abs((
(((GPS_Coordinates_P1_x1)*(GPS_Coordinates_P2_y2))-((GPS_Coordinates_P2_x2)*(GPS_Coordinates_P1_y1)))+
(((GPS_Coordinates_P2_x2)*(GPS_Coordinates_P3_y3))-((GPS_Coordinates_P3_x3)*(GPS_Coordinates_P2_y2)))+
(((GPS_Coordinates_P3_x3)*(GPS_Coordinates_P4_y4))-((GPS_Coordinates_P4_x4))*(GPS_Coordinates_P3_y3))+
(((GPS_Coordinates_P4_x4)*(GPS_Coordinates_P1_y1))-((GPS_Coordinates_P1_x1)*(GPS_Coordinates_P4_y4))))/2) 
WHERE GPS_Coordinates_P1_x1 =GPS_Coordinates_P1_x1 AND GPS_Coordinates_P1_y1 =GPS_Coordinates_P1_y1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Store_Proc_Backup`()
BEGIN

DECLARE BackupFile varchar(91);
DECLARE strSQL varchar(8000);
DECLARE DateSuffix char(16);




     

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `AGROADMIN`
--

CREATE TABLE IF NOT EXISTS `AGROADMIN` (
  `AgroAdmin_ID` varchar(40) NOT NULL,
  `AgroAdmin_FName` varchar(40) NOT NULL,
  `AgroAdmin_LName` varchar(40) NOT NULL,
  `AgroAdmin_Username` varchar(200) NOT NULL,
  `AgroAdmin_Password` varchar(45) NOT NULL,
  `AgroAdmin_Email` varchar(50) NOT NULL,
  `Field_ID` int(20) NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Inserted_By` varchar(50) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(50) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  PRIMARY KEY (`AgroAdmin_ID`),
  KEY `Field_ID` (`Field_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `AGROADMIN`
--

INSERT INTO `AGROADMIN` (`AgroAdmin_ID`, `AgroAdmin_FName`, `AgroAdmin_LName`, `AgroAdmin_Username`, `AgroAdmin_Password`, `AgroAdmin_Email`, `Field_ID`, `TimeStamp`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`) VALUES
('1', 'Admin', 'AL', 'admin', 'admin', 'admin@gmail.com', 1, '2016-11-09 02:20:44', 'Ramyasri', '2016-11-08 17:00:00', 'Nitin', '2016-11-08 13:00:00');

--
-- Triggers `AGROADMIN`
--
DROP TRIGGER IF EXISTS `Trigger_sp_Area`;
DELIMITER //
CREATE TRIGGER `Trigger_sp_Area` BEFORE INSERT ON `AGROADMIN`
 FOR EACH ROW call calc()
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `AGROVIEW`
--
CREATE TABLE IF NOT EXISTS `AGROVIEW` (
`Speed_Of_Repotruck_While_Traversing` int(45)
,`Speed_Of_Repotruck_While_Entering_Storageblock` int(45)
,`Speed_Of_Repotruck_When_Reached_Storageblock` int(45)
,`Waiting_Time_After_Truck_Gets_Loaded` time
,`Waiting_Time_After_Truck_Gets_Unloaded` time
,`Maximum_Load_Weight` int(45)
,`Where_To_Transfer_Information` varchar(45)
,`From_Where_To_Recieve_Information` varchar(45)
,`Priority_Queue_Of_Information` varchar(45)
,`Inserted_By` varchar(45)
,`Inserted_Date` date
,`Modified_By` varchar(45)
,`Modified_Date` date
,`TimeStamp` timestamp
,`Repotruck_Rule_Table_ID` varchar(45)
);
-- --------------------------------------------------------

--
-- Table structure for table `CHARGING_STATION`
--

CREATE TABLE IF NOT EXISTS `CHARGING_STATION` (
  `Charging_Stn_ID` int(250) NOT NULL,
  `Inserted_By` varchar(50) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(50) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Work_Status` tinyint(1) NOT NULL,
  `SOS_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Charging_Stn_ID`),
  UNIQUE KEY `Charging_Stn_ID` (`Charging_Stn_ID`),
  KEY `SOS_ID` (`SOS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CHARGING_STATION`
--

INSERT INTO `CHARGING_STATION` (`Charging_Stn_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Work_Status`, `SOS_ID`) VALUES
(1, 'Ramya', '2016-11-08 11:00:00', 'Nitin', '2016-11-08 18:00:00', '2016-11-09 00:59:42', 1, '1'),
(2, 'vikas', '2016-11-15 07:25:30', 'vikas', '2016-11-16 07:25:37', '2016-11-20 21:26:44', 1, '1'),
(3, 'vikas', '2016-11-16 00:00:00', 'vikas', '2016-11-21 00:00:00', '2016-11-21 00:00:00', 1, '1'),
(4, 'vikas', '2016-11-24 07:26:33', 'Vikas', '2016-11-23 11:37:47', '2016-11-21 18:36:56', 1, '1');

-- --------------------------------------------------------

--
-- Table structure for table `CLOUD`
--

CREATE TABLE IF NOT EXISTS `CLOUD` (
  `Server_ID` int(200) NOT NULL,
  `Hotspot_Tower_ID` int(20) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Work_Status` tinyint(1) NOT NULL,
  `Weather_Type` varchar(45) NOT NULL,
  `Temperature` int(4) NOT NULL,
  PRIMARY KEY (`Server_ID`),
  KEY `Hotspot_Tower_ID` (`Hotspot_Tower_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CLOUD`
--

INSERT INTO `CLOUD` (`Server_ID`, `Hotspot_Tower_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Work_Status`, `Weather_Type`, `Temperature`) VALUES
(1, 1, 'Ramya', '2016-11-08 10:00:00', 'Nitin', '2016-11-08 17:00:00', '2016-11-09 02:07:39', 0, 'Sunny', 73);

-- --------------------------------------------------------

--
-- Table structure for table `CROP`
--

CREATE TABLE IF NOT EXISTS `CROP` (
  `Crop_ID` int(100) NOT NULL,
  `Crop_Category_ID` int(40) NOT NULL,
  `Crop_Name` varchar(100) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Crop_Rule_Table_ID` varchar(45) NOT NULL,
  `PlantingDaysRequired` int(11) NOT NULL,
  `TenderingDaysRequired` int(11) NOT NULL,
  `HarvestingDaysRequired` int(11) NOT NULL,
  `TotalDaysRequired` int(11) NOT NULL,
  PRIMARY KEY (`Crop_ID`),
  KEY `Crop_Category_ID` (`Crop_Category_ID`),
  KEY `Crop_Rule_Table_ID` (`Crop_Rule_Table_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CROP`
--

INSERT INTO `CROP` (`Crop_ID`, `Crop_Category_ID`, `Crop_Name`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Crop_Rule_Table_ID`, `PlantingDaysRequired`, `TenderingDaysRequired`, `HarvestingDaysRequired`, `TotalDaysRequired`) VALUES
(1, 1, 'Cotton', 'Ramya', '2016-11-08 12:00:00', 'Nitin', '2016-11-08 17:00:00', '2016-11-09 00:16:42', '1', 10, 15, 10, 35),
(2, 1, 'Rice', 'Vikas', '2016-11-20 00:00:00', 'Vikas', '2016-11-20 03:00:00', '2016-11-30 19:19:39', '3', 90, 90, 90, 180),
(3, 2, 'Barley', 'vikas', '2016-11-23 06:21:25', 'Vikas', '2016-11-24 09:29:31', '2016-11-21 18:34:06', '4', 30, 30, 30, 30),
(4, 3, 'Soya', 'Vikas', '2016-11-24 09:32:39', 'Vikas', '2016-11-30 07:26:33', '2016-11-21 18:35:44', '5', 35, 35, 35, 35);

-- --------------------------------------------------------

--
-- Table structure for table `CROP_CATEGORY`
--

CREATE TABLE IF NOT EXISTS `CROP_CATEGORY` (
  `Crop_Category_ID` int(40) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Crop_Category_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CROP_CATEGORY`
--

INSERT INTO `CROP_CATEGORY` (`Crop_Category_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`) VALUES
(1, 'Ramya', '2016-11-08 05:00:00', 'Ramya', '2016-11-08 13:00:00', '2016-11-08 22:54:04'),
(2, 'vikas', '2016-11-23 08:30:39', 'vikas', '2016-11-23 09:32:37', '2016-11-21 18:27:45'),
(3, 'Vikas', '2016-11-23 07:29:40', 'Vikas', '2016-11-23 10:33:41', '2016-11-21 18:28:57'),
(4, 'vikas', '2016-11-30 08:29:00', 'Vikas', '2016-11-29 07:27:33', '2016-11-21 20:36:49');

-- --------------------------------------------------------

--
-- Table structure for table `CROP_RULE_TABLE`
--

CREATE TABLE IF NOT EXISTS `CROP_RULE_TABLE` (
  `Tempetaure` float NOT NULL,
  `Humidity` float NOT NULL,
  `Soil_Type` varchar(45) NOT NULL,
  `Soil_pH` float NOT NULL,
  `Range_Of_Optimum_Soil_Temperature` double(45,0) NOT NULL,
  `Range_Of_Optimum_Soil_Moisture` double NOT NULL,
  `Depth_Of_Sowing` float(60,0) NOT NULL,
  `Length_Between_Seeds` float(60,0) NOT NULL,
  `Breadth_Between_Seeds` float(60,0) NOT NULL,
  `Frequency_of_Water` int(45) NOT NULL,
  `Water_Requirement` int(100) NOT NULL,
  `Fertilizer_Type` varchar(50) NOT NULL,
  `Fertilizer_Quantity` double NOT NULL,
  `Frequency_Of_Fertilizer` int(50) NOT NULL,
  `Cutting_Style` varchar(50) NOT NULL,
  `Length_Above_Ground_Cut` double NOT NULL,
  `Storage_Life` int(50) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Crop_Rule_Table_ID` varchar(45) NOT NULL,
  `PercentageCompleted` float NOT NULL,
  PRIMARY KEY (`Crop_Rule_Table_ID`),
  KEY `Crop_Rule_Table_ID` (`Crop_Rule_Table_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `CROP_RULE_TABLE`
--

INSERT INTO `CROP_RULE_TABLE` (`Tempetaure`, `Humidity`, `Soil_Type`, `Soil_pH`, `Range_Of_Optimum_Soil_Temperature`, `Range_Of_Optimum_Soil_Moisture`, `Depth_Of_Sowing`, `Length_Between_Seeds`, `Breadth_Between_Seeds`, `Frequency_of_Water`, `Water_Requirement`, `Fertilizer_Type`, `Fertilizer_Quantity`, `Frequency_Of_Fertilizer`, `Cutting_Style`, `Length_Above_Ground_Cut`, `Storage_Life`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Crop_Rule_Table_ID`, `PercentageCompleted`) VALUES
(60, 70, 'black', 7, 65, 3, 2, 5, 6, 5, 5, 'Phosphorous', 5, 15, 'cut', 7, 60, 'Ramya', '2016-11-08 10:00:00', 'Nitin', '2016-11-08 17:00:00', '2016-11-09 00:13:45', '1', 0),
(34, 35, 'Black', 4, 34, 35, 34, 34, 34, 33, 3, 'Nitrogen', 0, 3, 'Horizontal', 5, 3, 'vikas', '2016-11-20 06:00:00', 'vikas', '2016-11-20 23:32:00', '2016-11-20 19:04:51', '3', 0),
(45, 45, 'Black', 5, 35, 45, 23, 23, 23, 3, 34, 'Nitrogen', 34, 3, 'horizontal', 34, 56, 'vikas', '2016-11-23 04:23:33', 'vikas', '2016-11-25 05:22:34', '2016-11-25 06:25:35', '4', 45),
(55, 70, 'Alluvial', 6, 50, 70, 15, 10, 10, 23, 3, 'Phosphorous', 45, 34, 'Vertical', 20, 40, 'Nitin', '2016-11-11 00:00:00', 'Nitin', '2016-11-11 08:00:00', '2016-11-12 02:25:35', '5', 0);

-- --------------------------------------------------------

--
-- Table structure for table `DATA_COLLECTOR`
--

CREATE TABLE IF NOT EXISTS `DATA_COLLECTOR` (
  `Data_Collector_ID` int(200) NOT NULL,
  `Sector_ID` int(100) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Work_Status` tinyint(1) NOT NULL,
  `SOS_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Data_Collector_ID`),
  KEY `Sector_ID` (`Sector_ID`),
  KEY `SOS_ID` (`SOS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `DATA_COLLECTOR`
--

INSERT INTO `DATA_COLLECTOR` (`Data_Collector_ID`, `Sector_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Work_Status`, `SOS_ID`) VALUES
(1, 1, 'Ramya', '2016-11-08 11:00:00', 'Nitin', '2016-11-08 16:00:00', '2016-11-09 01:53:14', 1, '1'),
(2, 2, 'vikas', '2016-11-21 05:21:32', 'vikas', '2016-11-24 04:18:27', '2016-11-20 21:34:57', 1, '1'),
(3, 1, 'vikas', '2016-11-15 05:23:33', 'vikas', '2016-11-25 00:00:00', '2016-11-23 07:31:43', 1, '1'),
(4, 2, 'vikas', '2016-11-20 09:40:59', 'vikas', '2016-11-22 16:53:59', '2016-11-23 02:20:35', 1, '1');

-- --------------------------------------------------------

--
-- Table structure for table `FARMER`
--

CREATE TABLE IF NOT EXISTS `FARMER` (
  `Farmer_ID` int(40) NOT NULL,
  `Farmer_FName` varchar(100) NOT NULL,
  `Farmer_LName` varchar(100) NOT NULL,
  `Farmer_Email` varchar(100) NOT NULL,
  `Farmer_Address_Line1` varchar(500) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `SOS_ID` varchar(45) NOT NULL,
  `Farmer_City` varchar(50) NOT NULL,
  `Farmer_Zipcode` int(45) NOT NULL,
  `Farmer_Address_Line2` varchar(50) NOT NULL,
  `Farmer_State` varchar(45) NOT NULL,
  `Farmer_Country` varchar(50) NOT NULL,
  `Field_Details` varchar(500) NOT NULL,
  `Payment_Status` tinyint(1) NOT NULL,
  `Card_Expiry_Date` date NOT NULL,
  `Card_Name` varchar(50) NOT NULL,
  `Card_Number` int(45) NOT NULL,
  `CVV_Code` int(10) NOT NULL,
  `ApproveOperation` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`Farmer_ID`),
  UNIQUE KEY `farmer_ID` (`Farmer_ID`),
  KEY `SOS_ID` (`SOS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `FARMER`
--

INSERT INTO `FARMER` (`Farmer_ID`, `Farmer_FName`, `Farmer_LName`, `Farmer_Email`, `Farmer_Address_Line1`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `SOS_ID`, `Farmer_City`, `Farmer_Zipcode`, `Farmer_Address_Line2`, `Farmer_State`, `Farmer_Country`, `Field_Details`, `Payment_Status`, `Card_Expiry_Date`, `Card_Name`, `Card_Number`, `CVV_Code`, `ApproveOperation`) VALUES
(1, 'Farmer', 'F1', 'farmer@gmail.com', 'field 1,land-1,Texas', 'Ramya', '2016-11-08 11:00:00', 'Nitin', '2016-11-08 16:00:00', '2016-11-09 00:50:08', '1', 'Boston', 2120, '6b city', 'MA', 'USA', 'good', 0, '2016-11-24', 'vikas', 12345678, 123, 0);

--
-- Triggers `FARMER`
--
DROP TRIGGER IF EXISTS `OperationTrigger`;
DELIMITER //
CREATE TRIGGER `OperationTrigger` AFTER INSERT ON `FARMER`
 FOR EACH ROW BEGIN 

UPDATE FARMER SET ApproveOperation=1; 

UPDATE OPERATION SET OPERATION_ID=(SELECT POperation_ID FROM PLANTING 
                                   WHERE OPERATION.Modified_By= PLANTING.Modified_By);
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `FIELD`
--

CREATE TABLE IF NOT EXISTS `FIELD` (
  `Field_ID` int(100) NOT NULL,
  `Farmer_ID` int(40) NOT NULL,
  `Sector_ID` int(100) NOT NULL,
  `GPS_Coordinates_P1_x1` decimal(6,4) NOT NULL,
  `GPS_Coordinates_P1_y1` decimal(6,4) NOT NULL,
  `GPS_Coordinates_P2_x2` decimal(6,4) NOT NULL,
  `GPS_Coordinates_P2_y2` decimal(6,4) NOT NULL,
  `GPS_Coordinates_P3_x3` decimal(6,4) NOT NULL,
  `GPS_Coordinates_P3_y3` decimal(6,4) NOT NULL,
  `GPS_Coordinates_P4_x4` decimal(6,4) NOT NULL,
  `GPS_Coordinates_P4_y4` decimal(6,4) NOT NULL,
  `Area` float(9,4) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`Field_ID`),
  KEY `Sector_ID` (`Sector_ID`),
  KEY `Farmer_ID` (`Farmer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `FIELD`
--

INSERT INTO `FIELD` (`Field_ID`, `Farmer_ID`, `Sector_ID`, `GPS_Coordinates_P1_x1`, `GPS_Coordinates_P1_y1`, `GPS_Coordinates_P2_x2`, `GPS_Coordinates_P2_y2`, `GPS_Coordinates_P3_x3`, `GPS_Coordinates_P3_y3`, `GPS_Coordinates_P4_x4`, `GPS_Coordinates_P4_y4`, `Area`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`) VALUES
(1, 1, 1, 4.0000, 2.0000, 4.0000, 2.0000, 4.0000, 6.0000, 2.0000, 6.0000, 4.0000, 'Ramya', '2016-11-08 15:00:00', 'Nitin', '2016-11-08 15:00:00', '2016-11-09 01:47:55'),
(2, 1, 2, 10.0000, 8.0000, 4.0000, 4.0000, 4.0000, 6.0000, 4.0000, 6.0000, 6.0000, 'Ramya', '2016-11-12 08:00:00', 'vikas', '0000-00-00 00:00:00', '2016-11-12 16:02:31'),
(3, 1, 3, 2.0000, 4.0000, 6.0000, 4.0000, 2.0000, 6.0000, 4.0000, 6.0000, 2.0000, 'vikas', '2016-11-23 10:25:25', 'vikas', '2016-11-24 10:33:44', '2016-11-12 19:09:44'),
(4, 1, 4, 10.0000, 35.0900, 25.0000, 40.9000, 30.9000, 50.0900, 25.0000, 40.0900, 8.4645, 'vikas', '2016-11-24 12:36:45', 'vikas', '2016-11-24 11:28:36', '2016-11-21 19:07:41');

--
-- Triggers `FIELD`
--
DROP TRIGGER IF EXISTS `Trigger_Area_INSERT`;
DELIMITER //
CREATE TRIGGER `Trigger_Area_INSERT` BEFORE INSERT ON `FIELD`
 FOR EACH ROW BEGIN

SET New.Area = abs((
(((New.GPS_Coordinates_P1_x1)*(New.GPS_Coordinates_P2_y2))-((New.GPS_Coordinates_P2_x2)*(New.GPS_Coordinates_P1_y1)))+
(((New.GPS_Coordinates_P2_x2)*(New.GPS_Coordinates_P3_y3))-((New.GPS_Coordinates_P3_x3)*(New.GPS_Coordinates_P2_y2)))+
(((New.GPS_Coordinates_P3_x3)*(New.GPS_Coordinates_P4_y4))-((New.GPS_Coordinates_P4_x4))*(New.GPS_Coordinates_P3_y3))+
(((New.GPS_Coordinates_P4_x4)*(New.GPS_Coordinates_P1_y1))-((New.GPS_Coordinates_P1_x1)*(New.GPS_Coordinates_P4_y4))))/2);


END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `Trigger_Area_UPDATE`;
DELIMITER //
CREATE TRIGGER `Trigger_Area_UPDATE` BEFORE UPDATE ON `FIELD`
 FOR EACH ROW BEGIN

SET New.Area = abs((
(((New.GPS_Coordinates_P1_x1)*(New.GPS_Coordinates_P2_y2))-((New.GPS_Coordinates_P2_x2)*(New.GPS_Coordinates_P1_y1)))+
(((New.GPS_Coordinates_P2_x2)*(New.GPS_Coordinates_P3_y3))-((New.GPS_Coordinates_P3_x3)*(New.GPS_Coordinates_P2_y2)))+
(((New.GPS_Coordinates_P3_x3)*(New.GPS_Coordinates_P4_y4))-((New.GPS_Coordinates_P4_x4))*(New.GPS_Coordinates_P3_y3))+
(((New.GPS_Coordinates_P4_x4)*(New.GPS_Coordinates_P1_y1))-((New.GPS_Coordinates_P1_x1)*(New.GPS_Coordinates_P4_y4))))/2);


END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `HARVESTER_RULE_TABLE`
--

CREATE TABLE IF NOT EXISTS `HARVESTER_RULE_TABLE` (
  `Harvesting_Style` varchar(45) NOT NULL,
  `Number_of_Crops_To_Pick_At_A_Time` int(45) NOT NULL,
  `Force_Applied_To_Cut_Crop` int(45) NOT NULL,
  `Length_Above_Ground_To_Make_Cut` int(45) NOT NULL,
  `Speed_While_Traversing` int(45) NOT NULL,
  `Speed_While_Harvesting` int(45) NOT NULL,
  `Speed_While_Transporting` int(45) NOT NULL,
  `Speed_While_Reaching_Near_To_Repotruck` int(45) NOT NULL,
  `Speed_While_Reached_To_Repotruck` int(45) NOT NULL,
  `Where_To_Transfer_Information` varchar(45) NOT NULL,
  `From_Where_To_Recieve_Information` varchar(45) NOT NULL,
  `Priority_Queue_Of_Information` varchar(45) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` date NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Harvesting_Rule_Table_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Harvesting_Rule_Table_ID`),
  KEY `Harvesting_Rule_Table_ID` (`Harvesting_Rule_Table_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `HARVESTER_RULE_TABLE`
--

INSERT INTO `HARVESTER_RULE_TABLE` (`Harvesting_Style`, `Number_of_Crops_To_Pick_At_A_Time`, `Force_Applied_To_Cut_Crop`, `Length_Above_Ground_To_Make_Cut`, `Speed_While_Traversing`, `Speed_While_Harvesting`, `Speed_While_Transporting`, `Speed_While_Reaching_Near_To_Repotruck`, `Speed_While_Reached_To_Repotruck`, `Where_To_Transfer_Information`, `From_Where_To_Recieve_Information`, `Priority_Queue_Of_Information`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Harvesting_Rule_Table_ID`) VALUES
('cut', 5, 20, 5, 15, 10, 20, 20, 5, 'hotspot tower', 'robocluster', '1', 'Ramya', '2016-11-08 10:00:00', '2016-11-08', '2016-11-09 15:00:00', '2016-11-08 23:46:19', '1'),
('Vertical', 35, 46, 20, 23, 34, 23, 9, 0, 'Data collector', 'Hotspot Tower', '4', 'vikas', '2016-11-24 09:30:38', '0000-00-00', '2016-11-29 05:20:26', '2016-11-21 19:11:17', '2'),
('horizontal', 10, 10, 10, 18, 18, 20, 2, 3, 'data collector', 'hotspot tower', '5', 'vikas', '2016-11-23 04:18:28', '2016-11-23', '2016-11-23 05:23:30', '2016-11-20 22:04:27', '3'),
('vertical', 3, 4, 56, 43, 56, 7, 87, 6, 'data colector', 'hotspot tower', '3', 'vikas', '2016-11-23 10:35:43', '0000-00-00', '2016-11-25 07:27:38', '2016-11-25 02:10:18', '7');

-- --------------------------------------------------------

--
-- Table structure for table `HARVESTING`
--

CREATE TABLE IF NOT EXISTS `HARVESTING` (
  `HOperation_ID` varchar(45) NOT NULL,
  `RepoTruck_ID` varchar(45) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Harvesting_Rule_Table_ID` varchar(45) NOT NULL,
  `Crop_Rule_Table_ID` varchar(45) NOT NULL,
  `HDaysCompleted` int(11) NOT NULL,
  `HPercentageCompleted` float DEFAULT NULL,
  `H_Working_Status` tinyint(1) NOT NULL,
  `SoS_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`HOperation_ID`),
  KEY `RepoTruck_ID` (`RepoTruck_ID`),
  KEY `Harvesting_Rule_Table_ID` (`Harvesting_Rule_Table_ID`),
  KEY `Crop_Rule_Table_ID` (`Crop_Rule_Table_ID`),
  KEY `SoS_ID` (`SoS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `HARVESTING`
--

INSERT INTO `HARVESTING` (`HOperation_ID`, `RepoTruck_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Harvesting_Rule_Table_ID`, `Crop_Rule_Table_ID`, `HDaysCompleted`, `HPercentageCompleted`, `H_Working_Status`, `SoS_ID`) VALUES
('1', '1', 'vikas', '2016-11-23 09:32:41', 'vikas', '2016-11-23 08:31:42', '2016-11-27 20:53:32', '1', '1', 4, 40, 0, '1');

--
-- Triggers `HARVESTING`
--
DROP TRIGGER IF EXISTS `CalculatePercentageH`;
DELIMITER //
CREATE TRIGGER `CalculatePercentageH` BEFORE UPDATE ON `HARVESTING`
 FOR EACH ROW BEGIN

SET New.HPercentageCompleted=((New.HDaysCompleted)/(
SELECT CROP.HarvestingDaysRequired
FROM `CROP`  
INNER JOIN `HARVESTING` 
WHERE HARVESTING.Crop_Rule_Table_ID = CROP.Crop_Rule_Table_ID))*100;

END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `HOTSPOT_TOWER`
--

CREATE TABLE IF NOT EXISTS `HOTSPOT_TOWER` (
  `Hotspot_Tower_ID` int(10) NOT NULL,
  `Data_Collector_ID` int(200) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Work_Status` tinyint(1) NOT NULL,
  `SoS_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Hotspot_Tower_ID`),
  KEY `Data_Collector_ID` (`Data_Collector_ID`),
  KEY `SoS_ID` (`SoS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `HOTSPOT_TOWER`
--

INSERT INTO `HOTSPOT_TOWER` (`Hotspot_Tower_ID`, `Data_Collector_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Work_Status`, `SoS_ID`) VALUES
(1, 1, 'Ramya', '2016-11-08 13:00:00', 'Nitin', '2016-11-08 15:00:00', '2016-11-09 01:58:18', 1, '1');

-- --------------------------------------------------------

--
-- Table structure for table `OPERATION`
--

CREATE TABLE IF NOT EXISTS `OPERATION` (
  `Operation_ID` int(10) NOT NULL,
  `Date_Time` datetime NOT NULL,
  `Robo_Cluster_ID` int(100) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Operation_Type` varchar(34) NOT NULL,
  `TotalDaysCompleted` float NOT NULL,
  `TotalPercentageCompleted` float NOT NULL,
  PRIMARY KEY (`Operation_ID`),
  KEY `Robo_Cluster_ID` (`Robo_Cluster_ID`),
  KEY `Robo_Cluster_ID_2` (`Robo_Cluster_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `OPERATION`
--

INSERT INTO `OPERATION` (`Operation_ID`, `Date_Time`, `Robo_Cluster_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Operation_Type`, `TotalDaysCompleted`, `TotalPercentageCompleted`) VALUES
(1, '2016-11-08 09:00:00', 1, 'Ramya', '2016-11-08 13:00:00', 'Nitin', '2016-11-08 13:00:00', '2016-11-09 02:11:16', 'POperation', 0, 0);

--
-- Triggers `OPERATION`
--
DROP TRIGGER IF EXISTS `CalculateTotalPercentage`;
DELIMITER //
CREATE TRIGGER `CalculateTotalPercentage` BEFORE INSERT ON `OPERATION`
 FOR EACH ROW BEGIN

SET New.TotalPercentageCompleted=((OPERATION.TotalDaysCompleted)/(
SELECT CROP.TotalDaysRequired
FROM `CROP` 
INNER JOIN `OPERATION` 
WHERE OPERATION.Crop_Rule_Table_ID = CROP.Crop_Rule_Table_ID))*100;

END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `PLANTING`
--

CREATE TABLE IF NOT EXISTS `PLANTING` (
  `POperation_ID` int(45) NOT NULL,
  `SeedFertilizer_Dispenser_ID` int(200) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` date NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` date NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Planting_Rule_Table_ID` varchar(45) NOT NULL,
  `Crop_Rule_Table_ID` varchar(45) NOT NULL,
  `PDaysCompleted` int(11) DEFAULT NULL,
  `PPercentageCompleted` float DEFAULT NULL,
  `P_Working_Status` tinyint(1) NOT NULL,
  `SoS_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`POperation_ID`),
  UNIQUE KEY `Planting_Rule_Table_ID_2` (`Planting_Rule_Table_ID`),
  UNIQUE KEY `POperation_ID` (`POperation_ID`),
  KEY `Planting_Rule_Table_ID` (`Planting_Rule_Table_ID`,`Crop_Rule_Table_ID`),
  KEY `Crop_Rule_Table_ID` (`Crop_Rule_Table_ID`),
  KEY `SeedFertilizer_Dispenser_ID` (`SeedFertilizer_Dispenser_ID`),
  KEY `Planting_Rule_Table_ID_3` (`Planting_Rule_Table_ID`),
  KEY `SOS_ID` (`SoS_ID`),
  KEY `SoS_ID_2` (`SoS_ID`),
  KEY `SoS_ID_3` (`SoS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `PLANTING`
--

INSERT INTO `PLANTING` (`POperation_ID`, `SeedFertilizer_Dispenser_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Planting_Rule_Table_ID`, `Crop_Rule_Table_ID`, `PDaysCompleted`, `PPercentageCompleted`, `P_Working_Status`, `SoS_ID`) VALUES
(1, 1, 'Ramya', '2016-11-27', 'Vikas', '2016-11-27', '2016-11-27 21:38:28', '2', '1', 10, 0, 0, '1'),
(2, 1, 'Ramya', '2016-11-27', 'Vikas', '2016-11-27', '2016-11-27 21:42:54', '1', '1', 3, 30, 0, '1');

--
-- Triggers `PLANTING`
--
DROP TRIGGER IF EXISTS `CalculatePercentageP`;
DELIMITER //
CREATE TRIGGER `CalculatePercentageP` BEFORE INSERT ON `PLANTING`
 FOR EACH ROW BEGIN

SET New.PPercentageCompleted=((New.PDaysCompleted)/(
SELECT CROP.PlantingDaysRequired
FROM `CROP` 
INNER JOIN `PLANTING` 
WHERE PLANTING.Crop_Rule_Table_ID = CROP.Crop_Rule_Table_ID))*100;


END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `OperationShift`;
DELIMITER //
CREATE TRIGGER `OperationShift` BEFORE UPDATE ON `PLANTING`
 FOR EACH ROW BEGIN

IF New.PPercentageCompleted = 100 THEN

UPDATE PLANTING SET P_Working_Status = 0;

UPDATE TENDERING SET T_Working_Status = 1;

UPDATE TENDERING SET TOperationID = 1;

END IF;

END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `PLANTING_RULE_TABLE`
--

CREATE TABLE IF NOT EXISTS `PLANTING_RULE_TABLE` (
  `Seed_Type` varchar(45) NOT NULL,
  `Depth_Of_Sowing` int(45) NOT NULL,
  `Length_Of_Sowing` int(45) NOT NULL,
  `Width_Of_Sowing` int(45) NOT NULL,
  `Start_Time` time NOT NULL,
  `Area_Assigned` int(45) NOT NULL,
  `Speed_While_Planting` int(45) NOT NULL,
  `Speed_While_Traversing` int(45) NOT NULL,
  `Speed_While_Coming_Near_Seed_Dispenser` int(45) NOT NULL,
  `Speed_When_Reached_Seed_Dispenser` int(45) NOT NULL,
  `Fertilizer_Type` varchar(45) NOT NULL,
  `Quantity_Of_Fertilizer` int(45) NOT NULL,
  `Where_To_Transfer_Information` varchar(45) NOT NULL,
  `From_Where_To_Recieve_Information` varchar(45) NOT NULL,
  `Priority_Queue_Of_Information` varchar(45) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` date NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` date NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Planting_Rule_Table_ID` varchar(45) NOT NULL,
  `Distance_Travelled` int(45) NOT NULL,
  PRIMARY KEY (`Planting_Rule_Table_ID`),
  KEY `Planting_Rule_Table_ID` (`Planting_Rule_Table_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `PLANTING_RULE_TABLE`
--

INSERT INTO `PLANTING_RULE_TABLE` (`Seed_Type`, `Depth_Of_Sowing`, `Length_Of_Sowing`, `Width_Of_Sowing`, `Start_Time`, `Area_Assigned`, `Speed_While_Planting`, `Speed_While_Traversing`, `Speed_While_Coming_Near_Seed_Dispenser`, `Speed_When_Reached_Seed_Dispenser`, `Fertilizer_Type`, `Quantity_Of_Fertilizer`, `Where_To_Transfer_Information`, `From_Where_To_Recieve_Information`, `Priority_Queue_Of_Information`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Planting_Rule_Table_ID`, `Distance_Travelled`) VALUES
('grains', 3, 4, 5, '05:00:00', 450, 15, 20, 25, 20, 'natural', 20, 'abc', 'bcd', '1', 'Ramya', '2016-11-08', 'Nitin', '2016-11-08', '2016-11-08 23:40:02', '1', 0),
('Wheat', 30, 30, 30, '02:00:00', 450, 33, 23, 3, 0, 'Phosphorus', 34, 'Data Collector', 'Hotspot Tower', '3', 'Vikas', '2016-11-23', 'Vikas', '2016-11-23', '2016-11-21 19:59:48', '2', 45),
('dark', 3, 3, 4, '19:02:14', 33, 3, 3, 3, 3, 'three', 3, 'qwewe', 'qwe', 'qwe', 'weeeee', '2016-11-20', 'wootwoot', '2016-11-20', '2016-11-20 19:02:14', '3', 3),
('Soya', 30, 45, 45, '02:00:00', 450, 34, 23, 3, 0, 'Nitrogen', 34, 'Data Collector', 'Hotspot Tower', '4', 'Vikas', '2016-11-24', 'Vikas', '2016-11-24', '2016-11-21 20:01:50', '4', 45);

-- --------------------------------------------------------

--
-- Table structure for table `PROGRESS_TABLE`
--

CREATE TABLE IF NOT EXISTS `PROGRESS_TABLE` (
  `PPercentageCompleted` int(11) NOT NULL,
  `TPercentageCompleted` int(11) NOT NULL,
  `HPercentageCompleted` int(11) NOT NULL,
  `ProgressValue` int(11) NOT NULL,
  `DaysP` int(11) NOT NULL,
  `POperation_ID` int(11) NOT NULL,
  `TOperation_ID` varchar(45) NOT NULL,
  `HOperation_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`ProgressValue`),
  UNIQUE KEY `DaysP` (`DaysP`),
  UNIQUE KEY `ProgressValue` (`ProgressValue`),
  KEY `PPercentageCompleted` (`PPercentageCompleted`),
  KEY `TPercentageCompleted` (`TPercentageCompleted`),
  KEY `HPercentageCompleted` (`HPercentageCompleted`),
  KEY `POperation_ID` (`POperation_ID`),
  KEY `TOperation_ID` (`TOperation_ID`),
  KEY `HOperation_ID` (`HOperation_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `PROGRESS_TABLE`
--
DROP TRIGGER IF EXISTS `Calc_Progress_Value`;
DELIMITER //
CREATE TRIGGER `Calc_Progress_Value` BEFORE INSERT ON `PROGRESS_TABLE`
 FOR EACH ROW BEGIN

SET New.ProgressValue =(
(SELECT TENDERING.TPercentageCompleted
FROM`TENDERING`
 INNER JOIN `PROGRESS_TABLE`
WHERE PROGRESS_TABLE.TOPerations_ID = TENDERING.TOperation_ID) + 
(SELECT PLANTING.PPercentageCompleted
FROM `PLANITNG`
INNER JOIN `PROGRESS_TABLE`
WHERE PROGRESS_TABLE.POperations_ID = PLANTING.POperation_ID)+
(SELECT HARVESTING.HPercentageCompleted
FROM `HARVESTING`
INNER JOIN `PROGRESS_TABLE`
WHERE PROGRESS_TABLE.HOperation_ID = HARVESTING.HOperation_ID))/3;
 
END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `REPOTRUCK_RULE_TABLE`
--

CREATE TABLE IF NOT EXISTS `REPOTRUCK_RULE_TABLE` (
  `Speed_Of_Repotruck_While_Traversing` int(45) NOT NULL,
  `Speed_Of_Repotruck_While_Entering_Storageblock` int(45) NOT NULL,
  `Speed_Of_Repotruck_When_Reached_Storageblock` int(45) NOT NULL,
  `Waiting_Time_After_Truck_Gets_Loaded` time NOT NULL,
  `Waiting_Time_After_Truck_Gets_Unloaded` time NOT NULL,
  `Maximum_Load_Weight` int(45) NOT NULL,
  `Where_To_Transfer_Information` varchar(45) NOT NULL,
  `From_Where_To_Recieve_Information` varchar(45) NOT NULL,
  `Priority_Queue_Of_Information` varchar(45) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` date NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` date NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Repotruck_Rule_Table_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Repotruck_Rule_Table_ID`),
  KEY `Repotruck_Rule_Table_ID` (`Repotruck_Rule_Table_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `REPOTRUCK_RULE_TABLE`
--

INSERT INTO `REPOTRUCK_RULE_TABLE` (`Speed_Of_Repotruck_While_Traversing`, `Speed_Of_Repotruck_While_Entering_Storageblock`, `Speed_Of_Repotruck_When_Reached_Storageblock`, `Waiting_Time_After_Truck_Gets_Loaded`, `Waiting_Time_After_Truck_Gets_Unloaded`, `Maximum_Load_Weight`, `Where_To_Transfer_Information`, `From_Where_To_Recieve_Information`, `Priority_Queue_Of_Information`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Repotruck_Rule_Table_ID`) VALUES
(20, 15, 8, '01:00:00', '01:00:00', 4000, 'Datacollector', 'Datacollector', '1', 'Ramya', '2016-11-08', 'Nitin', '2016-11-08', '2016-11-09 00:01:20', '1'),
(34, 23, 0, '00:00:10', '00:00:10', 1000, 'Hotspot Tower', 'Data Collector', '2', 'vikas', '2016-11-23', 'vikas', '2016-11-22', '2016-11-21 19:28:19', '2'),
(34, 23, 0, '00:00:10', '00:00:10', 10000, 'Hotspot Tower', 'Data Collector', '3', 'vikas', '2016-11-23', 'nitin', '2016-11-30', '2016-11-21 19:30:05', '3'),
(34, 23, 0, '00:00:10', '00:00:10', 10000, 'Hotspot Tower', 'Data Collector', '3', 'Vikas', '2016-11-23', 'vikas', '2016-11-25', '2016-11-21 19:31:08', '4');

-- --------------------------------------------------------

--
-- Table structure for table `REPO_TRUCK`
--

CREATE TABLE IF NOT EXISTS `REPO_TRUCK` (
  `RepoTruck_ID` varchar(45) NOT NULL,
  `StorageBlockID` int(100) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` date NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` date NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Repotruck_Rule_Table_ID` varchar(45) NOT NULL,
  `Crop_Rule_Table_ID` varchar(45) NOT NULL,
  `Work_Status` tinyint(1) NOT NULL,
  `SOS_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`RepoTruck_ID`),
  KEY `StorageBlockID` (`StorageBlockID`),
  KEY `Crop_Rule_Table_ID` (`Crop_Rule_Table_ID`),
  KEY `Repotruck_Rule_Table_ID` (`Repotruck_Rule_Table_ID`),
  KEY `SOS_ID` (`SOS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `REPO_TRUCK`
--

INSERT INTO `REPO_TRUCK` (`RepoTruck_ID`, `StorageBlockID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Repotruck_Rule_Table_ID`, `Crop_Rule_Table_ID`, `Work_Status`, `SOS_ID`) VALUES
('1', 1, 'Ramya', '2016-11-08', 'Nitin', '2016-11-08', '2016-11-09 02:24:56', '1', '1', 1, '1'),
('2', 2, 'vikas', '2016-11-23', 'vikas', '2016-11-24', '2016-11-21 19:32:23', '2', '3', 1, '1'),
('3', 3, 'vikas', '2016-11-25', 'vikas', '2016-11-25', '2016-11-21 19:32:59', '3', '4', 1, '1'),
('4', 4, 'vikas', '2016-11-25', 'nitin', '2016-11-29', '2016-11-21 19:33:35', '4', '5', 1, '1');

-- --------------------------------------------------------

--
-- Table structure for table `ROBOT`
--

CREATE TABLE IF NOT EXISTS `ROBOT` (
  `Robot_ID` int(250) NOT NULL,
  `Robo_Cluster_ID` int(100) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` date NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` date NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Work_Status` tinyint(1) NOT NULL,
  `SOS_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Robot_ID`),
  KEY `Robo_Cluster_ID` (`Robo_Cluster_ID`),
  KEY `SOS_ID` (`SOS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ROBOT`
--

INSERT INTO `ROBOT` (`Robot_ID`, `Robo_Cluster_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Work_Status`, `SOS_ID`) VALUES
(1, 1, 'Ramya', '2016-11-08', 'Nitin', '2016-11-08', '2016-11-09 02:09:45', 1, '1'),
(2, 2, 'Vikas', '2016-11-24', 'Vikas', '2016-11-24', '2016-11-21 20:08:17', 1, '1'),
(3, 2, 'Vikas', '2016-11-24', 'Vikas', '2016-11-24', '2016-11-21 20:08:44', 1, '1'),
(4, 3, 'Vikas', '2016-11-16', 'vikas', '2016-11-25', '2016-11-21 20:09:48', 1, '1');

-- --------------------------------------------------------

--
-- Table structure for table `ROBOYARD`
--

CREATE TABLE IF NOT EXISTS `ROBOYARD` (
  `Roboyard_ID` int(100) NOT NULL,
  `Charging_Station_ID` int(200) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` date NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` date NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `SOS_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Roboyard_ID`),
  KEY `Charging_Station_ID` (`Charging_Station_ID`),
  KEY `Charging_Station_ID_2` (`Charging_Station_ID`),
  KEY `SOS_ID` (`SOS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ROBOYARD`
--

INSERT INTO `ROBOYARD` (`Roboyard_ID`, `Charging_Station_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `SOS_ID`) VALUES
(1, 1, 'Ramya', '2016-11-08', 'Nitin', '2016-11-08', '2016-11-09 01:00:41', '1'),
(2, 2, 'vikas', '2016-11-23', 'vikas', '2016-11-24', '2016-11-21 18:47:16', '1'),
(3, 3, 'vikas', '2016-11-23', 'vikas', '2016-11-24', '2016-11-21 18:47:46', '1'),
(4, 4, 'vikas', '2016-11-24', 'vikas', '2016-11-25', '2016-11-21 18:48:37', '1');

-- --------------------------------------------------------

--
-- Table structure for table `ROBO_CLUSTER`
--

CREATE TABLE IF NOT EXISTS `ROBO_CLUSTER` (
  `Robo_Cluster_ID` int(100) NOT NULL,
  `Data_Collector_ID` int(200) NOT NULL,
  `RoboYard_ID` int(100) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` date NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` date NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Work_Status` tinyint(1) NOT NULL,
  `SOS_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Robo_Cluster_ID`),
  UNIQUE KEY `Robo_Cluster_ID` (`Robo_Cluster_ID`),
  KEY `Data_Collector_ID` (`Data_Collector_ID`,`RoboYard_ID`),
  KEY `RoboYard_ID` (`RoboYard_ID`),
  KEY `SOS_ID` (`SOS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ROBO_CLUSTER`
--

INSERT INTO `ROBO_CLUSTER` (`Robo_Cluster_ID`, `Data_Collector_ID`, `RoboYard_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Work_Status`, `SOS_ID`) VALUES
(1, 1, 1, 'Ramya', '2016-11-08', 'Nitin', '2016-11-08', '2016-11-09 02:08:59', 1, '1'),
(2, 2, 3, 'vikas', '2016-11-20', 'vikas', '2016-11-24', '2016-11-21 18:51:21', 1, '1'),
(3, 3, 3, 'vikas', '2016-11-24', 'vikas', '2016-11-23', '2016-11-21 18:52:09', 1, '1'),
(4, 4, 4, 'vikas', '2016-11-23', 'Nitin', '2016-11-25', '2016-11-21 18:52:43', 1, '1');

-- --------------------------------------------------------

--
-- Table structure for table `SEASON`
--

CREATE TABLE IF NOT EXISTS `SEASON` (
  `Season_ID` int(10) NOT NULL,
  `Crop_Category_ID` int(40) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` date NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` date NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Season_Type` varchar(45) NOT NULL,
  PRIMARY KEY (`Season_ID`),
  KEY `Crop_Category_ID` (`Crop_Category_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SEASON`
--

INSERT INTO `SEASON` (`Season_ID`, `Crop_Category_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Season_Type`) VALUES
(1, 1, 'Nitin', '2016-11-08', 'Ramya', '2016-11-08', '2016-11-08 22:56:23', 'Summer'),
(2, 2, 'vikas', '2016-11-22', 'vikas', '2016-11-23', '2016-11-21 20:12:06', 'Spring'),
(3, 2, 'vikas', '2016-11-23', 'vikas', '2016-11-24', '2016-11-21 20:12:25', 'WInter'),
(4, 3, 'vikas', '2016-11-23', 'vikas', '2016-11-24', '2016-11-21 20:13:04', 'Autumn');

-- --------------------------------------------------------

--
-- Table structure for table `SECTOR`
--

CREATE TABLE IF NOT EXISTS `SECTOR` (
  `Sector_ID` int(100) NOT NULL,
  `Sprinkler_Cluster_ID` int(100) NOT NULL,
  `RoboCluster_ID` int(100) NOT NULL,
  `Crop_ID` int(100) NOT NULL,
  `GPS_Coordinates_SP1_x1` decimal(6,4) NOT NULL,
  `GPS_Coordinates_SP1_y1` decimal(6,4) NOT NULL,
  `GPS_Coordinates_SP2_x2` decimal(6,4) NOT NULL,
  `GPS_Coordinates_SP2_y2` decimal(6,4) NOT NULL,
  `GPS_Coordinates_SP3_x3` decimal(6,4) NOT NULL,
  `GPS_Coordinates_SP3_y3` decimal(6,4) NOT NULL,
  `GPS_Coordinates_SP4_x4` decimal(6,4) NOT NULL,
  `GPS_Coordinates_SP4_y4` decimal(6,4) NOT NULL,
  `Area` decimal(9,4) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` date NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` date NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Sector_Rule_Table_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Sector_ID`),
  UNIQUE KEY `Sector_ID` (`Sector_ID`),
  KEY `RoboCluster_ID` (`RoboCluster_ID`),
  KEY `Sprinkler_Cluster_ID` (`Sprinkler_Cluster_ID`,`RoboCluster_ID`,`Crop_ID`),
  KEY `Crop_ID` (`Crop_ID`),
  KEY `Sector_Rule_Table_ID` (`Sector_Rule_Table_ID`),
  KEY `Sector_Rule_Table_ID_2` (`Sector_Rule_Table_ID`),
  KEY `Sprinkler_Cluster_ID_2` (`Sprinkler_Cluster_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SECTOR`
--

INSERT INTO `SECTOR` (`Sector_ID`, `Sprinkler_Cluster_ID`, `RoboCluster_ID`, `Crop_ID`, `GPS_Coordinates_SP1_x1`, `GPS_Coordinates_SP1_y1`, `GPS_Coordinates_SP2_x2`, `GPS_Coordinates_SP2_y2`, `GPS_Coordinates_SP3_x3`, `GPS_Coordinates_SP3_y3`, `GPS_Coordinates_SP4_x4`, `GPS_Coordinates_SP4_y4`, `Area`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Sector_Rule_Table_ID`) VALUES
(1, 1, 1, 1, 2.0000, 2.0000, 4.0000, 2.0000, 4.0000, 6.0000, 2.0000, 6.0000, 8.0000, 'Ramya', '2016-11-08', 'Nitin', '2016-11-08', '2016-11-09 01:50:09', '1'),
(2, 1, 1, 1, 4.0000, 2.0000, 4.0000, 2.0000, 4.0000, 6.0000, 2.0000, 6.0000, 4.0000, 'Ramya', '2016-11-12', 'vikas', '0000-00-00', '2016-11-12 17:31:54', '1'),
(3, 2, 3, 3, 20.3680, 45.5690, 25.8650, 45.0000, 35.0000, 45.0980, 32.9870, 52.9080, 59.5322, 'vikas', '2016-11-30', 'vikas', '2016-11-30', '2016-11-21 18:54:47', '1'),
(4, 3, 3, 3, 25.0000, 46.9800, 25.8900, 46.8500, 30.8600, 55.9800, 20.9300, 45.0000, 16.8995, 'vikas', '2016-11-23', 'vikas', '2016-11-24', '2016-11-21 18:57:23', '1');

--
-- Triggers `SECTOR`
--
DROP TRIGGER IF EXISTS `Trigger_SArea_INSERT`;
DELIMITER //
CREATE TRIGGER `Trigger_SArea_INSERT` BEFORE INSERT ON `SECTOR`
 FOR EACH ROW BEGIN

SET New.Area = abs((
(((New.GPS_Coordinates_SP1_x1)*(New.GPS_Coordinates_SP2_y2))-((New.GPS_Coordinates_SP2_x2)*(New.GPS_Coordinates_SP1_y1)))+
(((New.GPS_Coordinates_SP2_x2)*(New.GPS_Coordinates_SP3_y3))-((New.GPS_Coordinates_SP3_x3)*(New.GPS_Coordinates_SP2_y2)))+
(((New.GPS_Coordinates_SP3_x3)*(New.GPS_Coordinates_SP4_y4))-((New.GPS_Coordinates_SP4_x4))*(New.GPS_Coordinates_SP3_y3))+
(((New.GPS_Coordinates_SP4_x4)*(New.GPS_Coordinates_SP1_y1))-((New.GPS_Coordinates_SP1_x1)*(New.GPS_Coordinates_SP4_y4))))/2);


END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `Trigger_SArea_UPDATE`;
DELIMITER //
CREATE TRIGGER `Trigger_SArea_UPDATE` BEFORE UPDATE ON `SECTOR`
 FOR EACH ROW BEGIN

SET New.Area = abs((
(((New.GPS_Coordinates_SP1_x1)*(New.GPS_Coordinates_SP2_y2))-((New.GPS_Coordinates_SP2_x2)*(New.GPS_Coordinates_SP1_y1)))+
(((New.GPS_Coordinates_SP2_x2)*(New.GPS_Coordinates_SP3_y3))-((New.GPS_Coordinates_SP3_x3)*(New.GPS_Coordinates_SP2_y2)))+
(((New.GPS_Coordinates_SP3_x3)*(New.GPS_Coordinates_SP4_y4))-((New.GPS_Coordinates_SP4_x4))*(New.GPS_Coordinates_SP3_y3))+
(((New.GPS_Coordinates_SP4_x4)*(New.GPS_Coordinates_SP1_y1))-((New.GPS_Coordinates_SP1_x1)*(New.GPS_Coordinates_SP4_y4))))/2);


END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `SECTOR_RULE_TABLE`
--

CREATE TABLE IF NOT EXISTS `SECTOR_RULE_TABLE` (
  `Coordinates_Of_Sector` int(100) NOT NULL,
  `Area_Of_Sector` varchar(50) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` date NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` date NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Sector_Rule_Table_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Sector_Rule_Table_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SECTOR_RULE_TABLE`
--

INSERT INTO `SECTOR_RULE_TABLE` (`Coordinates_Of_Sector`, `Area_Of_Sector`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Sector_Rule_Table_ID`) VALUES
(150, '1500', 'Ramya', '2016-11-08', 'Nitin', '2016-11-08', '2016-11-09 00:05:27', '1'),
(160, '1600', 'vikas', '2016-11-24', 'vikas', '2016-11-24', '2016-11-21 19:03:38', '2'),
(170, '1700', 'vikas', '2016-11-26', 'vikas', '2016-11-25', '2016-11-21 19:04:10', '3'),
(180, '1800', 'vikas', '2016-11-23', 'vikas', '2016-11-24', '2016-11-21 19:04:33', '4');

-- --------------------------------------------------------

--
-- Table structure for table `SEED/FERTILIZER/PESTICIDE_DISPENSER_RULE_TABLE`
--

CREATE TABLE IF NOT EXISTS `SEED/FERTILIZER/PESTICIDE_DISPENSER_RULE_TABLE` (
  `Quantity_Of_Seed_Dispense` int(45) NOT NULL,
  `Quantity_Of_Fertilizer_Dispense` int(45) NOT NULL,
  `Where_To_Transfer_Information` varchar(45) NOT NULL,
  `When_To_Transfer_Information` time NOT NULL,
  `From_Where_To_Recieve_Information` varchar(45) NOT NULL,
  `Priority_Queue_Of_Information` varchar(45) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` date NOT NULL,
  `Modified_Date` date NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Seed_Dispenser_Rule_Table_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Seed_Dispenser_Rule_Table_ID`),
  KEY `Seed_Dispenser_Rule_Table_ID` (`Seed_Dispenser_Rule_Table_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SEED/FERTILIZER/PESTICIDE_DISPENSER_RULE_TABLE`
--

INSERT INTO `SEED/FERTILIZER/PESTICIDE_DISPENSER_RULE_TABLE` (`Quantity_Of_Seed_Dispense`, `Quantity_Of_Fertilizer_Dispense`, `Where_To_Transfer_Information`, `When_To_Transfer_Information`, `From_Where_To_Recieve_Information`, `Priority_Queue_Of_Information`, `Inserted_By`, `Inserted_Date`, `Modified_Date`, `Modified_By`, `TimeStamp`, `Seed_Dispenser_Rule_Table_ID`) VALUES
(200, 1000, 'Data collector', '10:00:00', 'Robocluster', '1', 'Ramya', '2016-11-08', '2016-11-08', 'Nitin', '2016-11-09 02:17:54', '1'),
(400, 300, 'Data Collector', '02:00:00', 'Hotspot Tower', '2', 'Vikas', '2016-11-23', '2016-11-29', 'Vikas', '2016-11-21 19:46:29', '2'),
(3000, 3000, 'Data Collector', '19:06:25', 'HotSpot Tower', '3', 'vikas', '2016-11-19', '2016-11-20', 'vikas', '2016-11-20 19:06:25', '3'),
(400, 500, 'Data Collector', '03:00:00', 'Hotspot Tower', '3', 'Vikas', '2016-11-23', '2016-11-24', 'vikas', '2016-11-21 19:47:42', '4');

-- --------------------------------------------------------

--
-- Table structure for table `SEED_DISPENSER`
--

CREATE TABLE IF NOT EXISTS `SEED_DISPENSER` (
  `Seed_Dispenser_ID` int(200) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` date NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` date NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Seed_Dispenser_Rule_Table_ID` varchar(45) NOT NULL,
  `Crop_Rule_Table_ID` varchar(45) NOT NULL,
  `Work_Status` tinyint(1) NOT NULL,
  `SOS_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Seed_Dispenser_ID`),
  KEY `Seed_Dispenser_Rule_Table_ID` (`Seed_Dispenser_Rule_Table_ID`),
  KEY `Crop_Rule_Table_ID` (`Crop_Rule_Table_ID`),
  KEY `Seed_Dispenser_Rule_Table_ID_2` (`Seed_Dispenser_Rule_Table_ID`),
  KEY `Crop_Rule_Table_ID_2` (`Crop_Rule_Table_ID`),
  KEY `SOS_ID` (`SOS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SEED_DISPENSER`
--

INSERT INTO `SEED_DISPENSER` (`Seed_Dispenser_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Seed_Dispenser_Rule_Table_ID`, `Crop_Rule_Table_ID`, `Work_Status`, `SOS_ID`) VALUES
(1, 'Ramya', '2016-11-08', 'Nitin', '2016-11-08', '2016-11-09 02:18:37', '1', '1', 1, '1'),
(2, 'vikas', '2016-11-22', 'vikas', '2016-11-24', '2016-11-21 19:51:22', '3', '4', 1, '1'),
(3, 'qwe', '2016-11-20', 'qwe', '2016-11-20', '2016-11-20 19:15:49', '3', '3', 1, '1'),
(4, 'vikas', '2016-11-23', 'vikas', '2016-11-25', '2016-11-21 19:51:54', '3', '4', 1, '1');

-- --------------------------------------------------------

--
-- Table structure for table `SOS`
--

CREATE TABLE IF NOT EXISTS `SOS` (
  `SOS_ID` varchar(45) NOT NULL,
  `Time_Start` datetime NOT NULL,
  `Time_Stop` datetime NOT NULL,
  `Inserted_By` varchar(50) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(50) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `SOS_IsOn` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`SOS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SOS`
--

INSERT INTO `SOS` (`SOS_ID`, `Time_Start`, `Time_Stop`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `SOS_IsOn`) VALUES
('1', '2016-11-27 08:00:00', '2016-11-27 16:00:00', 'Ramya', '2016-11-08 05:00:00', 'Nitin', '2016-11-08 12:00:00', '2016-11-09 00:27:52', 0);

--
-- Triggers `SOS`
--
DROP TRIGGER IF EXISTS `SendSOS`;
DELIMITER //
CREATE TRIGGER `SendSOS` BEFORE INSERT ON `SOS`
 FOR EACH ROW BEGIN 

UPDATE SOS SET SOS_IsOn =1; 

UPDATE CHARGING_STATION SET Work_Status =1; 

UPDATE HOTSPOT_TOWER SET Work_Status =1; 

UPDATE REPO_TRUCK SET Work_Status =1; 

UPDATE ROBOT SET Work_Status =1; 



UPDATE ROBO_CLUSTER SET Work_Status =1; 

UPDATE SEED_DISPENSER SET Work_Status =1; 

UPDATE SPRINKLER_CLUSTER SET Work_Status =1; 

UPDATE STORAGE_BLOCK SET Work_Status =1; 

UPDATE DATA_COLLECTOR SET Work_Status =1;
END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `SendSOSUpdate`;
DELIMITER //
CREATE TRIGGER `SendSOSUpdate` BEFORE UPDATE ON `SOS`
 FOR EACH ROW BEGIN 
 
SET    New.SOS_IsOn = IF(New.Time_Start < NOW( ) AND NOW( ) < New.Time_Stop, 1, 0);


UPDATE  `PLANTING` SET P_Working_status = IF(P_Working_status = 0,0,IF(New.SOS_IsOn = 1,0,1));

UPDATE  `TENDERING` SET T_Working_status = IF(T_Working_status = 0,0,IF(New.SOS_IsOn = 1,0,1));

UPDATE  `HARVESTING` SET H_Working_status = IF(H_Working_status = 0,0,IF(New.SOS_IsOn = 1,0,1));

UPDATE  `CHARGING_STATION` SET Work_status = IF(New.SOS_IsOn = 1,0,1);

UPDATE `HOTSPOT_TOWER` SET Work_Status = IF(New.SOS_IsOn = 1,0,1);

UPDATE `REPO_TRUCK` SET Work_Status = IF(New.SOS_IsOn = 1,0,1); 

UPDATE `ROBOT` SET Work_Status = IF(New.SOS_IsOn = 1,0,1); 

UPDATE `ROBO_CLUSTER`  SET Work_Status = IF(New.SOS_IsOn = 1,0,1); 

UPDATE `SEED_DISPENSER` SET Work_Status = IF(New.SOS_IsOn = 1,0,1); 

UPDATE `SPRINKLER_CLUSTER` SET Work_Status = IF(New.SOS_IsOn = 1,0,1); 

UPDATE `STORAGE_BLOCK`  SET Work_Status = IF(New.SOS_IsOn = 1,0,1); 

UPDATE `DATA_COLLECTOR`  SET Work_Status = IF(New.SOS_IsOn = 1,0,1);

END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `SPRINKLER_CLUSTER`
--

CREATE TABLE IF NOT EXISTS `SPRINKLER_CLUSTER` (
  `Sprinkler_Cluster_ID` int(20) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` date NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` date NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Sprinkler_Rule_Table_ID` varchar(45) NOT NULL,
  `Crop_Rule_Table_ID` varchar(45) NOT NULL,
  `Work_Status` tinyint(1) NOT NULL,
  `SOS_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Sprinkler_Cluster_ID`),
  KEY `Sprinkler_Cluster_ID` (`Sprinkler_Cluster_ID`),
  KEY `Crop_Rule_Table_ID` (`Crop_Rule_Table_ID`),
  KEY `Sprinkler_Rule_Table_ID` (`Sprinkler_Rule_Table_ID`),
  KEY `SOS_ID` (`SOS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SPRINKLER_CLUSTER`
--

INSERT INTO `SPRINKLER_CLUSTER` (`Sprinkler_Cluster_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Sprinkler_Rule_Table_ID`, `Crop_Rule_Table_ID`, `Work_Status`, `SOS_ID`) VALUES
(1, 'Ramya', '2016-11-08', 'Nitin', '2016-11-08', '2016-11-09 00:33:12', '1', '1', 1, '1'),
(2, 'vikas', '2016-11-22', 'vikas', '2016-11-24', '2016-11-21 18:43:05', '1', '3', 1, '1'),
(3, 'vikas', '2016-11-20', 'vikas', '2016-11-24', '2016-11-21 18:44:11', '1', '3', 1, '1'),
(4, 'vikas', '2016-11-16', 'nitin', '2016-11-30', '2016-11-21 18:45:02', '1', '4', 1, '1');

-- --------------------------------------------------------

--
-- Table structure for table `SPRINKLER_RULE_TABLE`
--

CREATE TABLE IF NOT EXISTS `SPRINKLER_RULE_TABLE` (
  `Volume_Of_Water_In_One_Shot` int(45) NOT NULL,
  `Frequency_Of_Water_Spraying` int(45) NOT NULL,
  `Duration_Of_Sprinkling` int(45) NOT NULL,
  `Where_To_Transfer_Information` varchar(45) NOT NULL,
  `From_Where_To_Recieve_Information` varchar(45) NOT NULL,
  `Priority_Queue_Of_Information` varchar(45) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Sprinkler_Rule_Table_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Sprinkler_Rule_Table_ID`),
  KEY `Sprinkler_Rule_Table_ID` (`Sprinkler_Rule_Table_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `SPRINKLER_RULE_TABLE`
--

INSERT INTO `SPRINKLER_RULE_TABLE` (`Volume_Of_Water_In_One_Shot`, `Frequency_Of_Water_Spraying`, `Duration_Of_Sprinkling`, `Where_To_Transfer_Information`, `From_Where_To_Recieve_Information`, `Priority_Queue_Of_Information`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `TimeStamp`, `Sprinkler_Rule_Table_ID`) VALUES
(50, 5, 30, 'Datacollector', 'robocluster', '1', 'Ramya', '2016-11-08 14:00:00', 'Nitin', '2016-11-09 00:25:33', '1'),
(4, 4, 20, 'Data Collector', 'Hotspot Tower', '3', 'Vikas', '2016-11-23 07:23:27', 'Vikas', '2016-11-21 20:17:42', '2'),
(4, 4, 17, 'Data Collector', 'Hotspot Tower', '4', 'Vikas', '2016-11-23 07:25:32', 'Vikas', '2016-11-21 20:19:08', '3'),
(3, 4, 18, 'Data Collector', 'Hotspot Tower', '4', 'Vikas', '2016-11-23 08:29:37', 'Vikas', '2016-11-21 20:21:09', '4');

-- --------------------------------------------------------

--
-- Table structure for table `STORAGE_BLOCK`
--

CREATE TABLE IF NOT EXISTS `STORAGE_BLOCK` (
  `StorageBlockID` int(100) NOT NULL,
  `Hotspot_Tower_ID` int(20) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Storageblock_Rule_Table_ID` varchar(45) NOT NULL,
  `Crop_Rule_Table_ID` varchar(45) NOT NULL,
  `Work_Status` tinyint(1) NOT NULL,
  `SOS_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`StorageBlockID`),
  KEY `Hotspot_Tower_ID` (`Hotspot_Tower_ID`),
  KEY `Crop_Rule_Table_ID` (`Crop_Rule_Table_ID`),
  KEY `Storageblock_Rule_Table_ID` (`Storageblock_Rule_Table_ID`),
  KEY `SOS_ID` (`SOS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `STORAGE_BLOCK`
--

INSERT INTO `STORAGE_BLOCK` (`StorageBlockID`, `Hotspot_Tower_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Storageblock_Rule_Table_ID`, `Crop_Rule_Table_ID`, `Work_Status`, `SOS_ID`) VALUES
(1, 1, 'Ramya', '2016-11-08 11:00:00', 'Nitin', '2016-11-08 17:00:00', '2016-11-09 02:24:09', '1', '1', 1, '1'),
(2, 1, 'vikas', '2016-11-24 13:29:27', 'vikas', '2016-11-23 08:21:21', '2016-11-21 19:22:08', '2', '3', 1, '1'),
(3, 1, 'vikas', '2016-11-22 08:22:23', 'vikas', '2016-11-23 09:28:32', '2016-11-21 19:23:24', '3', '4', 1, '1'),
(4, 1, 'vikas', '2016-11-24 08:28:37', 'nitin', '2016-11-23 09:30:36', '2016-11-21 19:25:33', '4', '5', 1, '1');

-- --------------------------------------------------------

--
-- Table structure for table `STORAGE_UNIT_RULE_TABLE`
--

CREATE TABLE IF NOT EXISTS `STORAGE_UNIT_RULE_TABLE` (
  `Volume` int(50) NOT NULL,
  `Current_Temperature` double NOT NULL,
  `Optimum_Temperature` double NOT NULL,
  `Current_Humidity` double NOT NULL,
  `Optimum_Humidity` double NOT NULL,
  `Type_Of_Crop` varchar(50) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Storageblock_Rule_Table_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Storageblock_Rule_Table_ID`),
  KEY `Storageblock_Rule_Table_ID` (`Storageblock_Rule_Table_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `STORAGE_UNIT_RULE_TABLE`
--

INSERT INTO `STORAGE_UNIT_RULE_TABLE` (`Volume`, `Current_Temperature`, `Optimum_Temperature`, `Current_Humidity`, `Optimum_Humidity`, `Type_Of_Crop`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Storageblock_Rule_Table_ID`) VALUES
(500000, 65, 68, 70, 65, 'Potato', 'Ramya', '2016-11-08 10:00:00', 'Nitin', '2016-11-08 14:00:00', '2016-11-09 00:20:15', '1'),
(600000, 34, 35, 23, 30, 'wheat', 'vikas', '2016-11-24 06:21:25', 'nitin', '2016-11-24 15:31:20', '2016-11-21 19:18:09', '2'),
(600000, 34, 37, 15, 20, 'Rice', 'vikas', '2016-11-23 09:27:32', 'nitin', '2016-11-23 07:26:34', '2016-11-21 19:19:05', '3'),
(500000, 34, 35, 30, 30, 'Soya', 'vikas', '2016-11-30 11:25:21', 'vikas', '2016-11-30 09:30:34', '2016-11-21 19:20:09', '4');

-- --------------------------------------------------------

--
-- Table structure for table `TENDERING`
--

CREATE TABLE IF NOT EXISTS `TENDERING` (
  `TOperation_ID` varchar(45) NOT NULL,
  `SoS_ID` varchar(45) NOT NULL,
  `SeedFertilizer_Dispenser_ID` int(200) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Tendering_Rule_Table_ID` varchar(45) NOT NULL,
  `Crop_Rule_Table_ID` varchar(45) NOT NULL,
  `TPercentageCompleted` float NOT NULL,
  `TDaysCompleted` int(11) NOT NULL,
  `T_Working_Status` tinyint(1) NOT NULL,
  PRIMARY KEY (`TOperation_ID`),
  KEY `SeedFertilizer_Dispenser_ID` (`SeedFertilizer_Dispenser_ID`),
  KEY `Tendering_Rule_Table_ID` (`Tendering_Rule_Table_ID`,`Crop_Rule_Table_ID`),
  KEY `Crop_Rule_Table_ID` (`Crop_Rule_Table_ID`),
  KEY `SoS_ID` (`SoS_ID`),
  KEY `SoS_ID_2` (`SoS_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `TENDERING`
--

INSERT INTO `TENDERING` (`TOperation_ID`, `SoS_ID`, `SeedFertilizer_Dispenser_ID`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Tendering_Rule_Table_ID`, `Crop_Rule_Table_ID`, `TPercentageCompleted`, `TDaysCompleted`, `T_Working_Status`) VALUES
('1', '1', 1, 'vikas', '2016-11-15 08:29:36', 'vikas', '2016-11-16 10:35:41', '2016-11-15 06:21:29', '1', '1', 20, 3, 0);

--
-- Triggers `TENDERING`
--
DROP TRIGGER IF EXISTS `CalculatePercentageT`;
DELIMITER //
CREATE TRIGGER `CalculatePercentageT` BEFORE UPDATE ON `TENDERING`
 FOR EACH ROW BEGIN

SET New.TPercentageCompleted=((New.TDaysCompleted)/(
SELECT CROP.TenderingDaysRequired
FROM `CROP` 
INNER JOIN `TENDERING` 
WHERE TENDERING.Crop_Rule_Table_ID = CROP.Crop_Rule_Table_ID))*100;

END
//
DELIMITER ;
DROP TRIGGER IF EXISTS `Operation_Change`;
DELIMITER //
CREATE TRIGGER `Operation_Change` BEFORE INSERT ON `TENDERING`
 FOR EACH ROW BEGIN

IF New.TPercentageCompleted = 100 THEN

UPDATE TENDERING SET T_Working_Status = 0;

UPDATE HARVESTING SET H_Working_Status = 1;

UPDATE HARVESTING SET HOperation_ID = 1;

END IF;

END
//
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `TENDERING_RULE_TABLE`
--

CREATE TABLE IF NOT EXISTS `TENDERING_RULE_TABLE` (
  `Fertilizer_Type` varchar(45) NOT NULL,
  `Quantity_Of_Fertilizer_At_One_Shot` int(45) NOT NULL,
  `Start_Time` time NOT NULL,
  `Area_Assigned` int(45) NOT NULL,
  `Number_Of_Rounds_Traverse` int(45) NOT NULL,
  `Time_Gap_Between_Each_Round` time NOT NULL,
  `Speed_While_Tendering` int(45) NOT NULL,
  `Speed_While_Traversing` int(45) NOT NULL,
  `Speed_While_Travelling_Near_Dispenser` int(45) NOT NULL,
  `Speed_When_Reached_Dispenser` int(45) NOT NULL,
  `Where_To_Transfer_Information` varchar(45) NOT NULL,
  `From_Where_To_Recieve_Information` varchar(45) NOT NULL,
  `Priority_Queue_Of_Information` varchar(45) NOT NULL,
  `Inserted_By` varchar(45) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(45) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Tendering_Rule_Table_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Tendering_Rule_Table_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `TENDERING_RULE_TABLE`
--

INSERT INTO `TENDERING_RULE_TABLE` (`Fertilizer_Type`, `Quantity_Of_Fertilizer_At_One_Shot`, `Start_Time`, `Area_Assigned`, `Number_Of_Rounds_Traverse`, `Time_Gap_Between_Each_Round`, `Speed_While_Tendering`, `Speed_While_Traversing`, `Speed_While_Travelling_Near_Dispenser`, `Speed_When_Reached_Dispenser`, `Where_To_Transfer_Information`, `From_Where_To_Recieve_Information`, `Priority_Queue_Of_Information`, `Inserted_By`, `Inserted_Date`, `Modified_By`, `Modified_Date`, `TimeStamp`, `Tendering_Rule_Table_ID`) VALUES
('Nitrogen', 5, '09:00:00', 300, 3, '00:30:00', 10, 15, 20, 8, 'Datacollector', 'Robocluster', '1', 'Ramya', '2016-11-08 08:00:00', 'Nitin', '2016-11-08 15:00:00', '2016-11-08 23:56:24', '1'),
('Phosphorous', 5, '03:00:00', 450, 45, '00:20:00', 23, 30, 3, 0, 'Data Collector', 'Hotspot Tower', '3', 'vikas', '2016-11-23 09:30:37', 'vikas', '2016-11-23 12:31:36', '2016-11-21 20:25:12', '2'),
('Nitrogen', 34, '06:00:00', 450, 65, '00:20:00', 34, 23, 3, 0, 'Data Collector', 'Hotspot Tower', '3', 'vikas', '2016-11-23 07:23:28', 'Vikas', '2016-11-30 05:19:23', '2016-11-21 20:27:38', '3'),
('Phosphorus', 34, '06:00:00', 450, 34, '05:00:00', 34, 30, 3, 0, 'Data Collector', 'Hotspot Tower', '5', 'vikas', '2016-11-23 11:23:26', 'Vikas', '2016-11-24 10:25:25', '2016-11-21 20:29:59', '4');

-- --------------------------------------------------------

--
-- Table structure for table `USERDATA`
--

CREATE TABLE IF NOT EXISTS `USERDATA` (
  `User_Password` varchar(50) NOT NULL,
  `Inserted_By` varchar(50) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_By` varchar(50) NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `User_Password2` varchar(50) NOT NULL,
  `Farmer_Username` varchar(60) NOT NULL,
  `Farmer_ID` int(40) NOT NULL,
  KEY `Farmer_ID` (`Farmer_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `WATERING`
--

CREATE TABLE IF NOT EXISTS `WATERING` (
  `Sprinkler_Cluster_ID` int(11) NOT NULL,
  `Inserted_By` varchar(40) NOT NULL,
  `Modified_By` varchar(40) NOT NULL,
  `Inserted_Date` datetime NOT NULL,
  `Modified_Date` datetime NOT NULL,
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `TOperation_ID` varchar(45) NOT NULL,
  PRIMARY KEY (`Sprinkler_Cluster_ID`),
  KEY `TOperation_ID` (`TOperation_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Structure for view `AGROVIEW`
--
DROP TABLE IF EXISTS `AGROVIEW`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `AGROVIEW` AS select `REPOTRUCK_RULE_TABLE`.`Speed_Of_Repotruck_While_Traversing` AS `Speed_Of_Repotruck_While_Traversing`,`REPOTRUCK_RULE_TABLE`.`Speed_Of_Repotruck_While_Entering_Storageblock` AS `Speed_Of_Repotruck_While_Entering_Storageblock`,`REPOTRUCK_RULE_TABLE`.`Speed_Of_Repotruck_When_Reached_Storageblock` AS `Speed_Of_Repotruck_When_Reached_Storageblock`,`REPOTRUCK_RULE_TABLE`.`Waiting_Time_After_Truck_Gets_Loaded` AS `Waiting_Time_After_Truck_Gets_Loaded`,`REPOTRUCK_RULE_TABLE`.`Waiting_Time_After_Truck_Gets_Unloaded` AS `Waiting_Time_After_Truck_Gets_Unloaded`,`REPOTRUCK_RULE_TABLE`.`Maximum_Load_Weight` AS `Maximum_Load_Weight`,`REPOTRUCK_RULE_TABLE`.`Where_To_Transfer_Information` AS `Where_To_Transfer_Information`,`REPOTRUCK_RULE_TABLE`.`From_Where_To_Recieve_Information` AS `From_Where_To_Recieve_Information`,`REPOTRUCK_RULE_TABLE`.`Priority_Queue_Of_Information` AS `Priority_Queue_Of_Information`,`REPOTRUCK_RULE_TABLE`.`Inserted_By` AS `Inserted_By`,`REPOTRUCK_RULE_TABLE`.`Inserted_Date` AS `Inserted_Date`,`REPOTRUCK_RULE_TABLE`.`Modified_By` AS `Modified_By`,`REPOTRUCK_RULE_TABLE`.`Modified_Date` AS `Modified_Date`,`REPOTRUCK_RULE_TABLE`.`TimeStamp` AS `TimeStamp`,`REPOTRUCK_RULE_TABLE`.`Repotruck_Rule_Table_ID` AS `Repotruck_Rule_Table_ID` from `REPOTRUCK_RULE_TABLE`;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `AGROADMIN`
--
ALTER TABLE `AGROADMIN`
  ADD CONSTRAINT `AGROADMIN_ibfk_1` FOREIGN KEY (`Field_ID`) REFERENCES `FIELD` (`Field_ID`);

--
-- Constraints for table `CHARGING_STATION`
--
ALTER TABLE `CHARGING_STATION`
  ADD CONSTRAINT `CHARGING_STATION_ibfk_1` FOREIGN KEY (`SOS_ID`) REFERENCES `SOS` (`SOS_ID`);

--
-- Constraints for table `CLOUD`
--
ALTER TABLE `CLOUD`
  ADD CONSTRAINT `CLOUD_ibfk_1` FOREIGN KEY (`Hotspot_Tower_ID`) REFERENCES `HOTSPOT_TOWER` (`Hotspot_Tower_ID`);

--
-- Constraints for table `CROP`
--
ALTER TABLE `CROP`
  ADD CONSTRAINT `CROP_ibfk_1` FOREIGN KEY (`Crop_Category_ID`) REFERENCES `CROP_CATEGORY` (`Crop_Category_ID`),
  ADD CONSTRAINT `CROP_ibfk_2` FOREIGN KEY (`Crop_Rule_Table_ID`) REFERENCES `CROP_RULE_TABLE` (`Crop_Rule_Table_ID`);

--
-- Constraints for table `DATA_COLLECTOR`
--
ALTER TABLE `DATA_COLLECTOR`
  ADD CONSTRAINT `DATA_COLLECTOR_ibfk_1` FOREIGN KEY (`Sector_ID`) REFERENCES `SECTOR` (`Sector_ID`),
  ADD CONSTRAINT `DATA_COLLECTOR_ibfk_2` FOREIGN KEY (`SOS_ID`) REFERENCES `SOS` (`SOS_ID`);

--
-- Constraints for table `FARMER`
--
ALTER TABLE `FARMER`
  ADD CONSTRAINT `FARMER_ibfk_1` FOREIGN KEY (`SOS_ID`) REFERENCES `SOS` (`SOS_ID`);

--
-- Constraints for table `FIELD`
--
ALTER TABLE `FIELD`
  ADD CONSTRAINT `FIELD_ibfk_1` FOREIGN KEY (`Farmer_ID`) REFERENCES `FARMER` (`Farmer_ID`),
  ADD CONSTRAINT `FIELD_ibfk_2` FOREIGN KEY (`Sector_ID`) REFERENCES `SECTOR` (`Sector_ID`);

--
-- Constraints for table `HARVESTING`
--
ALTER TABLE `HARVESTING`
  ADD CONSTRAINT `HARVESTING_ibfk_1` FOREIGN KEY (`Harvesting_Rule_Table_ID`) REFERENCES `HARVESTER_RULE_TABLE` (`Harvesting_Rule_Table_ID`),
  ADD CONSTRAINT `HARVESTING_ibfk_2` FOREIGN KEY (`Crop_Rule_Table_ID`) REFERENCES `CROP_RULE_TABLE` (`Crop_Rule_Table_ID`),
  ADD CONSTRAINT `HARVESTING_ibfk_3` FOREIGN KEY (`RepoTruck_ID`) REFERENCES `REPO_TRUCK` (`RepoTruck_ID`),
  ADD CONSTRAINT `HARVESTING_ibfk_4` FOREIGN KEY (`SoS_ID`) REFERENCES `SOS` (`SOS_ID`);

--
-- Constraints for table `HOTSPOT_TOWER`
--
ALTER TABLE `HOTSPOT_TOWER`
  ADD CONSTRAINT `HOTSPOT_TOWER_ibfk_1` FOREIGN KEY (`Data_Collector_ID`) REFERENCES `DATA_COLLECTOR` (`Data_Collector_ID`),
  ADD CONSTRAINT `HOTSPOT_TOWER_ibfk_2` FOREIGN KEY (`SoS_ID`) REFERENCES `SOS` (`SOS_ID`);

--
-- Constraints for table `OPERATION`
--
ALTER TABLE `OPERATION`
  ADD CONSTRAINT `OPERATION_ibfk_1` FOREIGN KEY (`Robo_Cluster_ID`) REFERENCES `ROBO_CLUSTER` (`Robo_Cluster_ID`);

--
-- Constraints for table `PLANTING`
--
ALTER TABLE `PLANTING`
  ADD CONSTRAINT `PLANTING_ibfk_1` FOREIGN KEY (`Planting_Rule_Table_ID`) REFERENCES `PLANTING_RULE_TABLE` (`Planting_Rule_Table_ID`),
  ADD CONSTRAINT `PLANTING_ibfk_2` FOREIGN KEY (`Crop_Rule_Table_ID`) REFERENCES `CROP_RULE_TABLE` (`Crop_Rule_Table_ID`),
  ADD CONSTRAINT `PLANTING_ibfk_3` FOREIGN KEY (`SeedFertilizer_Dispenser_ID`) REFERENCES `SEED_DISPENSER` (`Seed_Dispenser_ID`),
  ADD CONSTRAINT `PLANTING_ibfk_4` FOREIGN KEY (`SoS_ID`) REFERENCES `SOS` (`SOS_ID`);

--
-- Constraints for table `PROGRESS_TABLE`
--
ALTER TABLE `PROGRESS_TABLE`
  ADD CONSTRAINT `PROGRESS_TABLE_ibfk_3` FOREIGN KEY (`HOperation_ID`) REFERENCES `HARVESTING` (`HOperation_ID`),
  ADD CONSTRAINT `PROGRESS_TABLE_ibfk_1` FOREIGN KEY (`POperation_ID`) REFERENCES `PLANTING` (`POperation_ID`),
  ADD CONSTRAINT `PROGRESS_TABLE_ibfk_2` FOREIGN KEY (`TOperation_ID`) REFERENCES `TENDERING` (`TOperation_ID`);

--
-- Constraints for table `REPO_TRUCK`
--
ALTER TABLE `REPO_TRUCK`
  ADD CONSTRAINT `REPO_TRUCK_ibfk_1` FOREIGN KEY (`StorageBlockID`) REFERENCES `STORAGE_BLOCK` (`StorageBlockID`),
  ADD CONSTRAINT `REPO_TRUCK_ibfk_2` FOREIGN KEY (`Repotruck_Rule_Table_ID`) REFERENCES `REPOTRUCK_RULE_TABLE` (`Repotruck_Rule_Table_ID`),
  ADD CONSTRAINT `REPO_TRUCK_ibfk_3` FOREIGN KEY (`Crop_Rule_Table_ID`) REFERENCES `CROP_RULE_TABLE` (`Crop_Rule_Table_ID`),
  ADD CONSTRAINT `REPO_TRUCK_ibfk_4` FOREIGN KEY (`SOS_ID`) REFERENCES `SOS` (`SOS_ID`);

--
-- Constraints for table `ROBOT`
--
ALTER TABLE `ROBOT`
  ADD CONSTRAINT `ROBOT_ibfk_1` FOREIGN KEY (`Robo_Cluster_ID`) REFERENCES `ROBO_CLUSTER` (`Robo_Cluster_ID`),
  ADD CONSTRAINT `ROBOT_ibfk_2` FOREIGN KEY (`SOS_ID`) REFERENCES `SOS` (`SOS_ID`);

--
-- Constraints for table `ROBOYARD`
--
ALTER TABLE `ROBOYARD`
  ADD CONSTRAINT `ROBOYARD_ibfk_1` FOREIGN KEY (`Charging_Station_ID`) REFERENCES `CHARGING_STATION` (`Charging_Stn_ID`),
  ADD CONSTRAINT `ROBOYARD_ibfk_2` FOREIGN KEY (`SOS_ID`) REFERENCES `SOS` (`SOS_ID`);

--
-- Constraints for table `ROBO_CLUSTER`
--
ALTER TABLE `ROBO_CLUSTER`
  ADD CONSTRAINT `ROBO_CLUSTER_ibfk_1` FOREIGN KEY (`Data_Collector_ID`) REFERENCES `DATA_COLLECTOR` (`Data_Collector_ID`),
  ADD CONSTRAINT `ROBO_CLUSTER_ibfk_2` FOREIGN KEY (`RoboYard_ID`) REFERENCES `ROBOYARD` (`Roboyard_ID`),
  ADD CONSTRAINT `ROBO_CLUSTER_ibfk_3` FOREIGN KEY (`SOS_ID`) REFERENCES `SOS` (`SOS_ID`);

--
-- Constraints for table `SEASON`
--
ALTER TABLE `SEASON`
  ADD CONSTRAINT `SEASON_ibfk_1` FOREIGN KEY (`Crop_Category_ID`) REFERENCES `CROP_CATEGORY` (`Crop_Category_ID`);

--
-- Constraints for table `SECTOR`
--
ALTER TABLE `SECTOR`
  ADD CONSTRAINT `SECTOR_ibfk_4` FOREIGN KEY (`Sprinkler_Cluster_ID`) REFERENCES `SPRINKLER_CLUSTER` (`Sprinkler_Cluster_ID`),
  ADD CONSTRAINT `SECTOR_ibfk_1` FOREIGN KEY (`RoboCluster_ID`) REFERENCES `ROBO_CLUSTER` (`Robo_Cluster_ID`),
  ADD CONSTRAINT `SECTOR_ibfk_2` FOREIGN KEY (`Crop_ID`) REFERENCES `CROP` (`Crop_ID`),
  ADD CONSTRAINT `SECTOR_ibfk_3` FOREIGN KEY (`Sector_Rule_Table_ID`) REFERENCES `SECTOR_RULE_TABLE` (`Sector_Rule_Table_ID`);

--
-- Constraints for table `SEED_DISPENSER`
--
ALTER TABLE `SEED_DISPENSER`
  ADD CONSTRAINT `SEED_DISPENSER_ibfk_1` FOREIGN KEY (`Seed_Dispenser_Rule_Table_ID`) REFERENCES `SEED/FERTILIZER/PESTICIDE_DISPENSER_RULE_TABLE` (`Seed_Dispenser_Rule_Table_ID`),
  ADD CONSTRAINT `SEED_DISPENSER_ibfk_2` FOREIGN KEY (`Crop_Rule_Table_ID`) REFERENCES `CROP_RULE_TABLE` (`Crop_Rule_Table_ID`),
  ADD CONSTRAINT `SEED_DISPENSER_ibfk_3` FOREIGN KEY (`SOS_ID`) REFERENCES `SOS` (`SOS_ID`);

--
-- Constraints for table `SPRINKLER_CLUSTER`
--
ALTER TABLE `SPRINKLER_CLUSTER`
  ADD CONSTRAINT `SPRINKLER_CLUSTER_ibfk_1` FOREIGN KEY (`Sprinkler_Rule_Table_ID`) REFERENCES `SPRINKLER_RULE_TABLE` (`Sprinkler_Rule_Table_ID`),
  ADD CONSTRAINT `SPRINKLER_CLUSTER_ibfk_2` FOREIGN KEY (`Crop_Rule_Table_ID`) REFERENCES `CROP_RULE_TABLE` (`Crop_Rule_Table_ID`),
  ADD CONSTRAINT `SPRINKLER_CLUSTER_ibfk_3` FOREIGN KEY (`SOS_ID`) REFERENCES `SOS` (`SOS_ID`);

--
-- Constraints for table `STORAGE_BLOCK`
--
ALTER TABLE `STORAGE_BLOCK`
  ADD CONSTRAINT `STORAGE_BLOCK_ibfk_1` FOREIGN KEY (`Hotspot_Tower_ID`) REFERENCES `HOTSPOT_TOWER` (`Hotspot_Tower_ID`),
  ADD CONSTRAINT `STORAGE_BLOCK_ibfk_2` FOREIGN KEY (`Crop_Rule_Table_ID`) REFERENCES `CROP_RULE_TABLE` (`Crop_Rule_Table_ID`),
  ADD CONSTRAINT `STORAGE_BLOCK_ibfk_3` FOREIGN KEY (`Storageblock_Rule_Table_ID`) REFERENCES `STORAGE_UNIT_RULE_TABLE` (`Storageblock_Rule_Table_ID`),
  ADD CONSTRAINT `STORAGE_BLOCK_ibfk_4` FOREIGN KEY (`SOS_ID`) REFERENCES `SOS` (`SOS_ID`);

--
-- Constraints for table `TENDERING`
--
ALTER TABLE `TENDERING`
  ADD CONSTRAINT `TENDERING_ibfk_4` FOREIGN KEY (`SoS_ID`) REFERENCES `SOS` (`SOS_ID`),
  ADD CONSTRAINT `TENDERING_ibfk_1` FOREIGN KEY (`SeedFertilizer_Dispenser_ID`) REFERENCES `SEED_DISPENSER` (`Seed_Dispenser_ID`),
  ADD CONSTRAINT `TENDERING_ibfk_2` FOREIGN KEY (`Crop_Rule_Table_ID`) REFERENCES `CROP_RULE_TABLE` (`Crop_Rule_Table_ID`),
  ADD CONSTRAINT `TENDERING_ibfk_3` FOREIGN KEY (`Tendering_Rule_Table_ID`) REFERENCES `TENDERING_RULE_TABLE` (`Tendering_Rule_Table_ID`);

--
-- Constraints for table `USERDATA`
--
ALTER TABLE `USERDATA`
  ADD CONSTRAINT `FARMER_ibfk_2` FOREIGN KEY (`Farmer_ID`) REFERENCES `FARMER` (`Farmer_ID`);

--
-- Constraints for table `WATERING`
--
ALTER TABLE `WATERING`
  ADD CONSTRAINT `WATERING_ibfk_2` FOREIGN KEY (`TOperation_ID`) REFERENCES `TENDERING` (`TOperation_ID`),
  ADD CONSTRAINT `WATERING_ibfk_1` FOREIGN KEY (`Sprinkler_Cluster_ID`) REFERENCES `SPRINKLER_CLUSTER` (`Sprinkler_Cluster_ID`);

DELIMITER $$
--
-- Events
--
CREATE DEFINER=`root`@`localhost` EVENT `Store_Proc_Backup` ON SCHEDULE EVERY 5 SECOND STARTS '2016-11-15 12:10:11' ON COMPLETION PRESERVE DISABLE DO Update AGROADMIN SET Inserted_BY = 'Ramyasri' where AgroAdmin_ID=1$$

DELIMITER ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
