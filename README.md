DHDC_UPDATE_FUNCTION
ขั้นตอนการเปลี่ยนปีงบประมาณใน DHDC
1.  เพิ่มข้อมูลในตาราง cbyear และ cyear เพิ่มปีงบปัจจุบัน
2. แก้ไขข้อมูลตาราง pk_byear และ sys_config->yearprocess เปลี่ยนปีงบประมาณ (คศ.)
3. ดาวโหลดฟั่งชั่น เพื่ออัพเดทฟั่งชั่นเดิม ที่  https://github.com/golderboy/DHDC_UPDATE 
4. ก่อนนำเข้าฟังชั่น ให้แก้ไข DEFINER ในฟังชั่น จาก DEFINER=`root`@`localhost` เป็น DEFINER=`ยูสเซอร์ที่เชื่อมฐาน DHDC`@`localhost` ก่อน 
5. BACKUP ก่อน
6. นำเข้าโดย Navicat 
7. ประมวลผลในหน้า admin ตามลำดับ
8. ปรับสคริปเว็บหน้าดูปริมาณ ที่ dhdc/frontend/modules/import/controllers/ CountFileController.php  บรรทัดที่ 32
