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
SELECT no_siswa, s_nama, s_alamat, s_telp
FROM siswa s
WHERE s.s_nama ='Shafira';

--no. 2--
SELECT pk.PK_TGLMULAI,c.LOKASI_CABANG ,l.lv_nama,pj.P_NAMA,pk.PK_NAMA
FROM cabang c, paket_kursus pk, pengajar pj, detil_kursus dk, LEVEL_TABLE l, siswa s
WHERE c.ID_CABANG=pk.ID_CABANG
AND l.LV_ID=pk.LV_ID
AND pj.ID_PENGAJAR=pk.ID_PENGAJAR 
AND dk.ID_PK=pk.ID_PK
AND s.NO_SISWA = dk.NO_SISWA
AND s.NO_SISWA = 'S0002'
AND dk.STATUS_TES = 'BELUM ADA';

--no. 3--
SELECT pk.pk_tglselesai, c.lokasi_cabang, l.lv_nama, pk.pk_nama, dk.nilai_tes, dk.status_tes
FROM cabang c, paket_kursus pk, pengajar pj, detil_kursus dk, LEVEL_TABLE l, siswa s
WHERE c.ID_CABANG=pk.ID_CABANG
AND l.LV_ID=pk.LV_ID
AND pj.ID_PENGAJAR=pk.ID_PENGAJAR 
AND dk.ID_PK=pk.ID_PK
AND s.NO_SISWA = dk.NO_SISWA
AND s.no_siswa = 'S0002'
AND dk.status_tes not in ( SELECT dk.status_tes
						   FROM detil_kursus dk
						   WHERE dk.status_tes = 'BELUM ADA');

/*LAPORAN*/
--no. 1--
