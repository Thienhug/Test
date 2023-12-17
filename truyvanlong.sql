--cho biết luong trung binh cua tung phong 
select AVG(NHANVIEN.LUONG)
from NHANVIEN
group by NHANVIEN.PHG
--cho biet ma cac phong ban co luong trung binh cao nhat
select PHONGBAN.MAPHG, PHONGBAN.TENPHG
from PHONGBAN, NHANVIEN
where PHONGBAN.MAPHG = NHANVIEN.PHG
group by PHONGBAN.MAPHG,PHONGBAN.TENPHG
having AVG(NHANVIEN.LUONG)>= all(select AVG(NHANVIEN.LUONG)
								from NHANVIEN
								group by NHANVIEN.PHG)
--với mỗi phòng ban có nhânn viên nữ, cho biết số nhân viên cua phòng ban đó.								
select PHONGBAN.TENPHG, PHONGBAN.MAPHG, COUNT(NHANVIEN.MANV)
from PHONGBAN,NHANVIEN
where PHONGBAN.MAPHG = NHANVIEN.PHG
	 and PHONGBAN.MAPHG in (select NHANVIEN.PHG
	                        from NHANVIEN
	                        where NHANVIEN.PHAI like '%Nu%')
group by PHONGBAN.MAPHG, PHONGBAN.TENPHG

--voi moi phong ban co so nhan vien lon hon 2, cho biet luong cao nhat
select MAX(NHANVIEN.LUONG), NHANVIEN.PHG
from NHANVIEN
GROUP by NHANVIEN.PHG
having COUNT(NHANVIEN.MANV)>2

--Voi moi phong ban cho biet tong luong cua phong ban do
select SUM(NHANVIEN.LUONG), NHANVIEN.PHG
from NHANVIEN
group by NHANVIEN.PHG

select NHANVIEN.MANV, NHANVIEN.LUONG, NHANVIEN.PHG
from NHANVIEN
order by NHANVIEN.PHG desc
compute sum(NHANVIEN.LUONG) BY NHANVIEN.PHG

--cho biet luong trung binh cua tung phong ban
select NHANVIEN.PHG,PHONGBAN.TENPHG, NHANVIEN.LUONG
from PHONGBAN, NHANVIEN
where PHONGBAN.MAPHG = NHANVIEN.PHG
ORDER BY NHANVIEN.PHG
COMPUTE AVG(NHANVIEN.LUONG) BY NHANVIEN.PHG

select NHANVIEN.PHG,PHONGBAN.TENPHG, NHANVIEN.LUONG
from PHONGBAN, NHANVIEN
where PHONGBAN.MAPHG = NHANVIEN.PHG
	  AND PHONGBAN.MAPHG IN ( SELECT PHONGBAN.MAPHG
							   FROM NHANVIEN, PHONGBAN
							   WHERE PHONGBAN.MAPHG = NHANVIEN.PHG
							   group by PHONGBAN.MAPHG
							   HAVING AVG(NHANVIEN.LUONG)>= all(select AVG(NHANVIEN.LUONG)
																from NHANVIEN
																GROUP by NHANVIEN.PHG)
							)
ORDER BY NHANVIEN.PHG
COMPUTE AVG(NHANVIEN.LUONG) BY NHANVIEN.PHG


select NHANVIEN.MANV
from NHANVIEN
where not exists ( select  *
				   from DEAN
				   where MADA not In (select PHANCONG.MADA
									  from PHANCONG
									  where PHANCONG.MA_NVIEN = NHANVIEN.MANV)
				 )