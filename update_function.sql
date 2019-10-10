/*
Navicat MySQL Data Transfer

Source Server         : Localhost
Source Server Version : 100406
Source Host           : localhost:3306
Source Database       : demo

Target Server Type    : MYSQL
Target Server Version : 100406
File Encoding         : 65001

Date: 2019-10-10 13:31:17
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Procedure structure for err_all
-- ----------------------------
DROP PROCEDURE IF EXISTS `err_all`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `err_all`()
BEGIN
	CALL set_year_process;

	CALL err_all_a;
	CALL err_all_b('2563');
	CALL err_all_b('2562');
	CALL err_all_b('2561');
	CALL err_all_b('2560');
	CALL err_all_b('2559');

	CALL last_err_check;

	CALL run_sys_dhdc_count_file;
	

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for err_all_b
-- ----------------------------
DROP PROCEDURE IF EXISTS `err_all_b`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `err_all_b`(IN `yy` varchar(4))
BEGIN
call start_process;

SET @byear = yy;

#TRUNCATE err_zall;
DELETE FROM err_zall WHERE BYEAR = @byear;

call err_anc_b(@byear);
call err_charge_opd_b(@byear);
call err_chronic_b(@byear);
call err_chronicfu_b(@byear);
call err_dental_b(@byear);
call err_diagnosis_opd_b(@byear);
call err_disability_b(@byear);
call err_drugallergy_b(@byear);
call err_drug_opd_b(@byear);
call err_epi_b(@byear);
call err_fp_b(@byear);
call err_functional_b(@byear);
call err_icf_b(@byear);
call err_labfu_b(@byear);
call err_labor_b(@byear);
call err_ncdscreen_b(@byear);
call err_newborn_b(@byear);
call err_newborncare_b(@byear);
call err_nutrition_b(@byear);
call err_person_b(@byear);
call err_postnatal_b(@byear);
call err_prenatal_b(@byear);
call err_procedure_opd_b(@byear);
call err_provider_b(@byear);
call err_rehabilitation_b(@byear);
call err_service_b(@byear);
call err_specialpp_b(@byear);
call err_village_b(@byear);
	
	call end_process;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for run_sys_dhdc_count_file
-- ----------------------------
DROP PROCEDURE IF EXISTS `run_sys_dhdc_count_file`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `run_sys_dhdc_count_file`()
BEGIN
		CALL start_process;
		UPDATE sys_check_process t SET t.fnc_name = 'run_sys_dhdc_count_file',t.time = NOW();
		CALL sys_dhdc_count_file('2563');
		CALL sys_dhdc_count_file('2562');
		CALL sys_dhdc_count_file('2561');
		CALL sys_dhdc_count_file('2560');
		CALL sys_dhdc_count_file('2559');
		CALL sys_dhdc_count_file('2558');
		CALL end_process;

END
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for sys_dhdc_count_file
-- ----------------------------
DROP PROCEDURE IF EXISTS `sys_dhdc_count_file`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `sys_dhdc_count_file`(IN `byear` varchar(4))
BEGIN

	
CREATE TABLE IF NOT EXISTS sys_dhdc_count_file (
  `hospcode` varchar(5) NOT NULL DEFAULT '',
  `date_process` date NOT NULL DEFAULT '0000-00-00',
  `tb` varchar(255) NOT NULL,
  `b_year` varchar(4) NOT NULL,
  `m10` int(21) NOT NULL DEFAULT '0',
  `m11` int(21) NOT NULL DEFAULT '0',
  `m12` int(21) NOT NULL DEFAULT '0',
  `m01` int(21) NOT NULL DEFAULT '0',
  `m02` int(21) NOT NULL DEFAULT '0',
  `m03` int(21) NOT NULL DEFAULT '0',
  `m04` int(21) NOT NULL DEFAULT '0',
  `m05` int(21) NOT NULL DEFAULT '0',
  `m06` int(21) NOT NULL DEFAULT '0',
  `m07` int(21) NOT NULL DEFAULT '0',
  `m08` int(21) NOT NULL DEFAULT '0',
  `m09` int(21) NOT NULL DEFAULT '0',
  `total` int(21) NOT NULL DEFAULT '0',
  PRIMARY KEY (`hospcode`,`tb`,`b_year`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;



SET @b_year = byear;

SET @tb = 'service';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543-1,'1031') THEN t.HOSPCODE END)  m10
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1101') AND CONCAT(@b_year-543-1,'1131') THEN t.HOSPCODE END)  m11
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1201') AND CONCAT(@b_year-543-1,'1231') THEN t.HOSPCODE END)  m12
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0101') AND CONCAT(@b_year-543,'0131') THEN t.HOSPCODE END)  m01
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0201') AND CONCAT(@b_year-543,'0231') THEN t.HOSPCODE END)  m02
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0301') AND CONCAT(@b_year-543,'0331') THEN t.HOSPCODE END)  m03
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0401') AND CONCAT(@b_year-543,'0431') THEN t.HOSPCODE END)  m04
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0501') AND CONCAT(@b_year-543,'0531') THEN t.HOSPCODE END)  m05
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0601') AND CONCAT(@b_year-543,'0631') THEN t.HOSPCODE END)  m06
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0701') AND CONCAT(@b_year-543,'0731') THEN t.HOSPCODE END)  m07
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0801') AND CONCAT(@b_year-543,'0831') THEN t.HOSPCODE END)  m08
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0901') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  m09
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  total
FROM service  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode
GROUP BY h.hoscode );

SET @tb = 'diagnosis_opd';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543-1,'1031') THEN t.HOSPCODE END)  m10
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1101') AND CONCAT(@b_year-543-1,'1131') THEN t.HOSPCODE END)  m11
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1201') AND CONCAT(@b_year-543-1,'1231') THEN t.HOSPCODE END)  m12
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0101') AND CONCAT(@b_year-543,'0131') THEN t.HOSPCODE END)  m01
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0201') AND CONCAT(@b_year-543,'0231') THEN t.HOSPCODE END)  m02
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0301') AND CONCAT(@b_year-543,'0331') THEN t.HOSPCODE END)  m03
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0401') AND CONCAT(@b_year-543,'0431') THEN t.HOSPCODE END)  m04
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0501') AND CONCAT(@b_year-543,'0531') THEN t.HOSPCODE END)  m05
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0601') AND CONCAT(@b_year-543,'0631') THEN t.HOSPCODE END)  m06
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0701') AND CONCAT(@b_year-543,'0731') THEN t.HOSPCODE END)  m07
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0801') AND CONCAT(@b_year-543,'0831') THEN t.HOSPCODE END)  m08
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0901') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  m09
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  total
FROM diagnosis_opd  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode
GROUP BY h.hoscode );


SET @tb = 'procedure_opd';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543-1,'1031') THEN t.HOSPCODE END)  m10
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1101') AND CONCAT(@b_year-543-1,'1131') THEN t.HOSPCODE END)  m11
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1201') AND CONCAT(@b_year-543-1,'1231') THEN t.HOSPCODE END)  m12
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0101') AND CONCAT(@b_year-543,'0131') THEN t.HOSPCODE END)  m01
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0201') AND CONCAT(@b_year-543,'0231') THEN t.HOSPCODE END)  m02
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0301') AND CONCAT(@b_year-543,'0331') THEN t.HOSPCODE END)  m03
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0401') AND CONCAT(@b_year-543,'0431') THEN t.HOSPCODE END)  m04
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0501') AND CONCAT(@b_year-543,'0531') THEN t.HOSPCODE END)  m05
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0601') AND CONCAT(@b_year-543,'0631') THEN t.HOSPCODE END)  m06
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0701') AND CONCAT(@b_year-543,'0731') THEN t.HOSPCODE END)  m07
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0801') AND CONCAT(@b_year-543,'0831') THEN t.HOSPCODE END)  m08
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0901') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  m09
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  total
FROM procedure_opd  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode
GROUP BY h.hoscode );

CALL procedure_dental;
SET @tb = 'procedure_dental';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543-1,'1031') THEN t.HOSPCODE END)  m10
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1101') AND CONCAT(@b_year-543-1,'1131') THEN t.HOSPCODE END)  m11
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1201') AND CONCAT(@b_year-543-1,'1231') THEN t.HOSPCODE END)  m12
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0101') AND CONCAT(@b_year-543,'0131') THEN t.HOSPCODE END)  m01
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0201') AND CONCAT(@b_year-543,'0231') THEN t.HOSPCODE END)  m02
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0301') AND CONCAT(@b_year-543,'0331') THEN t.HOSPCODE END)  m03
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0401') AND CONCAT(@b_year-543,'0431') THEN t.HOSPCODE END)  m04
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0501') AND CONCAT(@b_year-543,'0531') THEN t.HOSPCODE END)  m05
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0601') AND CONCAT(@b_year-543,'0631') THEN t.HOSPCODE END)  m06
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0701') AND CONCAT(@b_year-543,'0731') THEN t.HOSPCODE END)  m07
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0801') AND CONCAT(@b_year-543,'0831') THEN t.HOSPCODE END)  m08
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0901') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  m09
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  total
FROM dhdc_procedure_dental  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode
GROUP BY h.hoscode );


SET @tb = 'epi';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543-1,'1031') THEN t.HOSPCODE END)  m10
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1101') AND CONCAT(@b_year-543-1,'1131') THEN t.HOSPCODE END)  m11
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1201') AND CONCAT(@b_year-543-1,'1231') THEN t.HOSPCODE END)  m12
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0101') AND CONCAT(@b_year-543,'0131') THEN t.HOSPCODE END)  m01
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0201') AND CONCAT(@b_year-543,'0231') THEN t.HOSPCODE END)  m02
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0301') AND CONCAT(@b_year-543,'0331') THEN t.HOSPCODE END)  m03
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0401') AND CONCAT(@b_year-543,'0431') THEN t.HOSPCODE END)  m04
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0501') AND CONCAT(@b_year-543,'0531') THEN t.HOSPCODE END)  m05
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0601') AND CONCAT(@b_year-543,'0631') THEN t.HOSPCODE END)  m06
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0701') AND CONCAT(@b_year-543,'0731') THEN t.HOSPCODE END)  m07
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0801') AND CONCAT(@b_year-543,'0831') THEN t.HOSPCODE END)  m08
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0901') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  m09
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  total
FROM epi  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode
GROUP BY h.hoscode );

SET @tb = 'specialpp';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543-1,'1031') THEN t.HOSPCODE END)  m10
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1101') AND CONCAT(@b_year-543-1,'1131') THEN t.HOSPCODE END)  m11
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1201') AND CONCAT(@b_year-543-1,'1231') THEN t.HOSPCODE END)  m12
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0101') AND CONCAT(@b_year-543,'0131') THEN t.HOSPCODE END)  m01
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0201') AND CONCAT(@b_year-543,'0231') THEN t.HOSPCODE END)  m02
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0301') AND CONCAT(@b_year-543,'0331') THEN t.HOSPCODE END)  m03
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0401') AND CONCAT(@b_year-543,'0431') THEN t.HOSPCODE END)  m04
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0501') AND CONCAT(@b_year-543,'0531') THEN t.HOSPCODE END)  m05
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0601') AND CONCAT(@b_year-543,'0631') THEN t.HOSPCODE END)  m06
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0701') AND CONCAT(@b_year-543,'0731') THEN t.HOSPCODE END)  m07
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0801') AND CONCAT(@b_year-543,'0831') THEN t.HOSPCODE END)  m08
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0901') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  m09
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  total
FROM specialpp  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode
GROUP BY h.hoscode );

SET @tb = 'anc';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543-1,'1031') THEN t.HOSPCODE END)  m10
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1101') AND CONCAT(@b_year-543-1,'1131') THEN t.HOSPCODE END)  m11
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1201') AND CONCAT(@b_year-543-1,'1231') THEN t.HOSPCODE END)  m12
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0101') AND CONCAT(@b_year-543,'0131') THEN t.HOSPCODE END)  m01
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0201') AND CONCAT(@b_year-543,'0231') THEN t.HOSPCODE END)  m02
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0301') AND CONCAT(@b_year-543,'0331') THEN t.HOSPCODE END)  m03
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0401') AND CONCAT(@b_year-543,'0431') THEN t.HOSPCODE END)  m04
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0501') AND CONCAT(@b_year-543,'0531') THEN t.HOSPCODE END)  m05
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0601') AND CONCAT(@b_year-543,'0631') THEN t.HOSPCODE END)  m06
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0701') AND CONCAT(@b_year-543,'0731') THEN t.HOSPCODE END)  m07
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0801') AND CONCAT(@b_year-543,'0831') THEN t.HOSPCODE END)  m08
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0901') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  m09
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  total
FROM anc  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode
GROUP BY h.hoscode );


SET @tb = 'ncdscreen';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543-1,'1031') THEN t.HOSPCODE END)  m10
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1101') AND CONCAT(@b_year-543-1,'1131') THEN t.HOSPCODE END)  m11
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1201') AND CONCAT(@b_year-543-1,'1231') THEN t.HOSPCODE END)  m12
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0101') AND CONCAT(@b_year-543,'0131') THEN t.HOSPCODE END)  m01
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0201') AND CONCAT(@b_year-543,'0231') THEN t.HOSPCODE END)  m02
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0301') AND CONCAT(@b_year-543,'0331') THEN t.HOSPCODE END)  m03
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0401') AND CONCAT(@b_year-543,'0431') THEN t.HOSPCODE END)  m04
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0501') AND CONCAT(@b_year-543,'0531') THEN t.HOSPCODE END)  m05
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0601') AND CONCAT(@b_year-543,'0631') THEN t.HOSPCODE END)  m06
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0701') AND CONCAT(@b_year-543,'0731') THEN t.HOSPCODE END)  m07
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0801') AND CONCAT(@b_year-543,'0831') THEN t.HOSPCODE END)  m08
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0901') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  m09
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  total
FROM ncdscreen  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode
GROUP BY h.hoscode );

SET @tb = 'dental';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543-1,'1031') THEN t.HOSPCODE END)  m10
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1101') AND CONCAT(@b_year-543-1,'1131') THEN t.HOSPCODE END)  m11
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1201') AND CONCAT(@b_year-543-1,'1231') THEN t.HOSPCODE END)  m12
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0101') AND CONCAT(@b_year-543,'0131') THEN t.HOSPCODE END)  m01
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0201') AND CONCAT(@b_year-543,'0231') THEN t.HOSPCODE END)  m02
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0301') AND CONCAT(@b_year-543,'0331') THEN t.HOSPCODE END)  m03
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0401') AND CONCAT(@b_year-543,'0431') THEN t.HOSPCODE END)  m04
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0501') AND CONCAT(@b_year-543,'0531') THEN t.HOSPCODE END)  m05
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0601') AND CONCAT(@b_year-543,'0631') THEN t.HOSPCODE END)  m06
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0701') AND CONCAT(@b_year-543,'0731') THEN t.HOSPCODE END)  m07
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0801') AND CONCAT(@b_year-543,'0831') THEN t.HOSPCODE END)  m08
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0901') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  m09
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  total
FROM dental  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode
GROUP BY h.hoscode );

SET @tb = 'labfu';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543-1,'1031') THEN t.HOSPCODE END)  m10
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1101') AND CONCAT(@b_year-543-1,'1131') THEN t.HOSPCODE END)  m11
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1201') AND CONCAT(@b_year-543-1,'1231') THEN t.HOSPCODE END)  m12
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0101') AND CONCAT(@b_year-543,'0131') THEN t.HOSPCODE END)  m01
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0201') AND CONCAT(@b_year-543,'0231') THEN t.HOSPCODE END)  m02
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0301') AND CONCAT(@b_year-543,'0331') THEN t.HOSPCODE END)  m03
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0401') AND CONCAT(@b_year-543,'0431') THEN t.HOSPCODE END)  m04
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0501') AND CONCAT(@b_year-543,'0531') THEN t.HOSPCODE END)  m05
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0601') AND CONCAT(@b_year-543,'0631') THEN t.HOSPCODE END)  m06
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0701') AND CONCAT(@b_year-543,'0731') THEN t.HOSPCODE END)  m07
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0801') AND CONCAT(@b_year-543,'0831') THEN t.HOSPCODE END)  m08
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543,'0901') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  m09
,COUNT(CASE WHEN  t.DATE_SERV BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  total
FROM labfu  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode
GROUP BY h.hoscode );


SET @tb = 'labor';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,COUNT(CASE WHEN  t.BDATE BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543-1,'1031') THEN t.HOSPCODE END)  m10
,COUNT(CASE WHEN  t.BDATE BETWEEN CONCAT(@b_year-543-1,'1101') AND CONCAT(@b_year-543-1,'1131') THEN t.HOSPCODE END)  m11
,COUNT(CASE WHEN  t.BDATE BETWEEN CONCAT(@b_year-543-1,'1201') AND CONCAT(@b_year-543-1,'1231') THEN t.HOSPCODE END)  m12
,COUNT(CASE WHEN  t.BDATE BETWEEN CONCAT(@b_year-543,'0101') AND CONCAT(@b_year-543,'0131') THEN t.HOSPCODE END)  m01
,COUNT(CASE WHEN  t.BDATE BETWEEN CONCAT(@b_year-543,'0201') AND CONCAT(@b_year-543,'0231') THEN t.HOSPCODE END)  m02
,COUNT(CASE WHEN  t.BDATE BETWEEN CONCAT(@b_year-543,'0301') AND CONCAT(@b_year-543,'0331') THEN t.HOSPCODE END)  m03
,COUNT(CASE WHEN  t.BDATE BETWEEN CONCAT(@b_year-543,'0401') AND CONCAT(@b_year-543,'0431') THEN t.HOSPCODE END)  m04
,COUNT(CASE WHEN  t.BDATE BETWEEN CONCAT(@b_year-543,'0501') AND CONCAT(@b_year-543,'0531') THEN t.HOSPCODE END)  m05
,COUNT(CASE WHEN  t.BDATE BETWEEN CONCAT(@b_year-543,'0601') AND CONCAT(@b_year-543,'0631') THEN t.HOSPCODE END)  m06
,COUNT(CASE WHEN  t.BDATE BETWEEN CONCAT(@b_year-543,'0701') AND CONCAT(@b_year-543,'0731') THEN t.HOSPCODE END)  m07
,COUNT(CASE WHEN  t.BDATE BETWEEN CONCAT(@b_year-543,'0801') AND CONCAT(@b_year-543,'0831') THEN t.HOSPCODE END)  m08
,COUNT(CASE WHEN  t.BDATE BETWEEN CONCAT(@b_year-543,'0901') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  m09
,COUNT(CASE WHEN  t.BDATE BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  total
FROM labor  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode
GROUP BY h.hoscode );



SET @tb = 'admission';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,COUNT(CASE WHEN  date(t.DATETIME_DISCH) BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543-1,'1031') THEN t.HOSPCODE END)  m10
,COUNT(CASE WHEN  date(t.DATETIME_DISCH) BETWEEN CONCAT(@b_year-543-1,'1101') AND CONCAT(@b_year-543-1,'1131') THEN t.HOSPCODE END)  m11
,COUNT(CASE WHEN  date(t.DATETIME_DISCH) BETWEEN CONCAT(@b_year-543-1,'1201') AND CONCAT(@b_year-543-1,'1231') THEN t.HOSPCODE END)  m12
,COUNT(CASE WHEN  date(t.DATETIME_DISCH) BETWEEN CONCAT(@b_year-543,'0101') AND CONCAT(@b_year-543,'0131') THEN t.HOSPCODE END)  m01
,COUNT(CASE WHEN  date(t.DATETIME_DISCH) BETWEEN CONCAT(@b_year-543,'0201') AND CONCAT(@b_year-543,'0231') THEN t.HOSPCODE END)  m02
,COUNT(CASE WHEN  date(t.DATETIME_DISCH) BETWEEN CONCAT(@b_year-543,'0301') AND CONCAT(@b_year-543,'0331') THEN t.HOSPCODE END)  m03
,COUNT(CASE WHEN  date(t.DATETIME_DISCH) BETWEEN CONCAT(@b_year-543,'0401') AND CONCAT(@b_year-543,'0431') THEN t.HOSPCODE END)  m04
,COUNT(CASE WHEN  date(t.DATETIME_DISCH) BETWEEN CONCAT(@b_year-543,'0501') AND CONCAT(@b_year-543,'0531') THEN t.HOSPCODE END)  m05
,COUNT(CASE WHEN  date(t.DATETIME_DISCH) BETWEEN CONCAT(@b_year-543,'0601') AND CONCAT(@b_year-543,'0631') THEN t.HOSPCODE END)  m06
,COUNT(CASE WHEN  date(t.DATETIME_DISCH) BETWEEN CONCAT(@b_year-543,'0701') AND CONCAT(@b_year-543,'0731') THEN t.HOSPCODE END)  m07
,COUNT(CASE WHEN  date(t.DATETIME_DISCH) BETWEEN CONCAT(@b_year-543,'0801') AND CONCAT(@b_year-543,'0831') THEN t.HOSPCODE END)  m08
,COUNT(CASE WHEN  date(t.DATETIME_DISCH) BETWEEN CONCAT(@b_year-543,'0901') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  m09
,COUNT(CASE WHEN  date(t.DATETIME_DISCH) BETWEEN CONCAT(@b_year-543-1,'1001') AND CONCAT(@b_year-543,'0931') THEN t.HOSPCODE END)  total
FROM admission  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode
GROUP BY h.hoscode );



SET @tb = 'chronic';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,0  m10
,0  m11
,0  m12
,0  m01
,0  m02
,0  m03
,0  m04
,0  m05
,0  m06
,0  m07
,0  m08
,0  m09
,COUNT(DISTINCT t.PID)  total
FROM chronic  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode 
GROUP BY h.hoscode );


SET @tb = 'person';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,0  m10
,0  m11
,0  m12
,0  m01
,0  m02
,0  m03
,0  m04
,0  m05
,0  m06
,0  m07
,0  m08
,0  m09
,COUNT(DISTINCT t.PID)  total
FROM person  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode 
GROUP BY h.hoscode );

SET @tb = 'home';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,0  m10
,0  m11
,0  m12
,0  m01
,0  m02
,0  m03
,0  m04
,0  m05
,0  m06
,0  m07
,0  m08
,0  m09
,COUNT(DISTINCT t.HID)  total
FROM home  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode 
GROUP BY h.hoscode );

SET @tb = 'village';
DELETE FROM sys_dhdc_count_file WHERE b_year = @b_year and tb = @tb;
REPLACE INTO sys_dhdc_count_file (
SELECT  h.hoscode,CURDATE(),@tb,@b_year
,0  m10
,0  m11
,0  m12
,0  m01
,0  m02
,0  m03
,0  m04
,0  m05
,0  m06
,0  m07
,0  m08
,0  m09
,COUNT(DISTINCT t.VID)  total
FROM village  t,chospital_amp h
WHERE t.HOSPCODE = h.hoscode 
GROUP BY h.hoscode );






END
;;
DELIMITER ;
