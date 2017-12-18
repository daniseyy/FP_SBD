create table siswa(
	no_siswa char(5) not null primary key,
	s_nama varchar(150),
	s_alamat varchar(150),
	s_noktp varchar(20),
	s_telp varchar(15),
	s_email varchar(100),
	s_tgldaftar date
);

create table pengajar(
	id_pengajar char(5) not null primary key,
	p_nama varchar(100),
	p_alamat varchar(150),
	p_telp varchar(15),
	p_email varchar(50)
);

create table level_table(
	lv_id char(5) not null primary key,
	lv_nama varchar(100),
	lv_deskripsi varchar(300)
);

create table cabang(
  id_cabang char(5) not null primary key,
  lokasi_cabang varchar(100),
  telp_cabang varchar(20)
);

create table paket_kursus(
	id_pk char(5) not null primary key,
	lv_id char(5) not null,
	id_pengajar char(5) not null,
  id_cabang char(5) not null,
	pk_nama varchar(100),
	pk_deskripsi varchar(300),
	pk_tarif integer,
	pk_tglmulai date,
	pk_tglselesai date
);

create table detil_kursus(
	id_pk char(5) not null,
	no_siswa char(5) not null,
	status_tes varchar(10),
 	nilai_tes integer
);

alter table detil_kursus
add constraint fk_id_pk
foreign key (id_pk) references paket_kursus(id_pk);

alter table detil_kursus
add constraint fk_no_siswa
foreign key (no_siswa) references siswa(no_siswa);

alter table paket_kursus
add constraint fk_lv_id
foreign key (lv_id) references level_table(lv_id);

alter table paket_kursus
add constraint fk_id_pengajar
foreign key (id_pengajar) references pengajar(id_pengajar);

alter table paket_kursus
add constraint fk_id_cabang
foreign key (id_cabang) references cabang(id_cabang);

/*TRANSKRIP*/
--no. 1--
SELECT no_siswa as "ID" , s_nama as "Nama", s_alamat as "Alamat", s_telp as "Telepon"
FROM siswa s
WHERE s.no_siswa ='S0002';

--no. 2--
SELECT pk.PK_TGLMULAI as "Tgl Mulai",CB.lokasi_cabang AS "Cabang Kursus",l.lv_nama as "Level",pj.P_NAMA as "Pengajar",pk.PK_NAMA as "Nama Kursus"
FROM cabang cb, paket_kursus pk, pengajar pj, detil_kursus dk, LEVEL_TABLE l, siswa s
WHERE cb.ID_CABANG=pk.ID_CABANG
AND l.LV_ID=pk.LV_ID
AND pj.ID_PENGAJAR=pk.ID_PENGAJAR 
AND dk.ID_PK=pk.ID_PK
AND s.NO_SISWA = dk.NO_SISWA
AND s.NO_SISWA = 'S0002'
AND dk.STATUS_TES IS NULL;

--no. 3--
SELECT pk.pk_tglselesai as "Tgl Selesai", CB.lokasi_cabang AS "Cabang Kursus", l.lv_nama AS "Level", pk.pk_nama AS "Nama Kursus", dk.nilai_tes as "Nilai", dk.status_tes as "Status"
FROM cabang cb, paket_kursus pk, pengajar pj, detil_kursus dk, LEVEL_TABLE l, siswa s
WHERE cb.ID_CABANG=pk.ID_CABANG
AND l.LV_ID=pk.LV_ID
AND pj.ID_PENGAJAR=pk.ID_PENGAJAR 
AND dk.ID_PK=pk.ID_PK
AND s.NO_SISWA = dk.NO_SISWA
AND s.no_siswa = 'S0002'
AND dk.status_tes IS NOT NULL;

/*LAPORAN*/
--no. 1--
select l.lv_nama, AVG(dk.nilai_tes) as "RATA-RATA"
from detil_kursus dk, paket_kursus pk, level_table l, cabang cb
where dk.id_pk= pk.id_pk
and pk.lv_id = l.lv_id
and pk.id_cabang = cb.id_cabang
and cb.lokasi_cabang = 'Kertajaya'
group by l.lv_nama
order by avg(dk.nilai_tes) desc;

--no.2--
SELECT pk.pk_nama, COUNT(pk.pk_nama) as "JUMLAH SISWA"
FROM detil_kursus dk, paket_kursus pk
WHERE dk.id_pk = pk.id_pk
GROUP BY pk.pk_nama
ORDER BY COUNT(pk.pk_nama) DESC;

--no3--
SELECT pj.p_nama as "Pengajar", pk.pk_nama "Nama Kursus", AVG(dk.nilai_tes) as "Rata-Rata Nilai Kelas", pk.pk_tglmulai as "Tgl Mulai Kursus", pk.pk_tglselesai as "Tgl Selesai Kursus"
FROM pengajar pj, paket_kursus pk, detil_kursus dk, level_table lv, cabang cb
WHERE pj.id_pengajar = pk.id_pengajar
AND pk.lv_id = lv.lv_id
AND dk.id_pk = pk.id_pk
AND pk.id_cabang = cb.id_cabang
AND pk.id_cabang = 'CB002'
AND dk.status_tes IS NOT NULL
GROUP BY pj.p_nama, pk.pk_nama, pk.pk_tglmulai, pk.pk_tglselesai
ORDER BY AVG(dk.nilai_tes)
DESC;

/*soal*/
--no. 1--
SELECT pk.pk_nama, COUNT(dk.status_tes)
FROM DETIL_KURSUS dk, paket_kursus pk
WHERE dk.id_pk = pk.id_pk
AND dk.status_tes = 'LULUS'
AND pk.pk_nama = 'Conversation Basic'
GROUP BY pk.pk_nama;

--no. 2--
SELECT DISTINCT s.s_nama
FROM siswa s, detil_kursus dk, paket_kursus pk, pengajar p, level_table lt
WHERE s.no_siswa=dk.no_siswa
	AND dk.id_pk=pk.id_pk
	AND pk.id_pengajar=p.id_pengajar
	AND pk.lv_id=lt.lv_id
	AND s_nama <> 'Shafira'
	AND p.id_pengajar IN ( SELECT id_pengajar
							FROM paket_kursus
							WHERE id_pk IN (SELECT id_pk
											FROM detil_kursus
											WHERE no_siswa IN ( SELECT no_siswa
																FROM siswa
																WHERE s_nama = 'Shafira')))
                      
--no.2--          
SELECT DISTINCT cb.lokasi_cabang
FROM cabang cb, siswa s, detil_kursus dk, paket_kursus pk, pengajar p, level_table lt
WHERE s.no_siswa=dk.no_siswa
	AND dk.id_pk=pk.id_pk
	AND pk.id_pengajar=p.id_pengajar
	AND pk.lv_id=lt.lv_id
	AND lv_nama = 'Intermediate'
  AND lt.lv_id IN ( SELECT lv_id
							FROM paket_kursus
							WHERE id_pk IN (SELECT id_pk
											FROM paket_kursus
											WHERE id_cabang IN ( SELECT COUNT(id_cabang)
																FROM cabang
																WHERE lokasi_cabang <> 'Rungkut')));