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
	status_tes varchar(10)
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

INSERT INTO siswa VALUES ('S0001','Rizka','Jl. Pondok Maritim II no 3','357820640797','081234789269','pelkenuk@gmail.com',to_date('24-07-2017','dd-mm-yyyy'));
INSERT INTO siswa VALUES ('S0002','Shafira','Jl. Dinoyo Sekolahan gg 1','647435981000','081198000287','wagoonlife@gmail.com',to_date('25-07-2017','dd-mm-yyyy'));
INSERT INTO siswa VALUES ('S0003','Nafiar','Jl. Keputih Perintis 5','729489301934','085253718192','nafiar_dedek@hotmail.com',to_date('31-07-2017','dd-mm-yyyy'));
INSERT INTO siswa VALUES ('S0004','Rafiar','Jl. Keputih Perintis 5','726842019719','088265319210','rafiar_kakak@hotmail.com',to_date('31-07-2017','dd-mm-yyyy'));
INSERT INTO siswa VALUES ('S0005','Nafia','Jl. Raya Mulyosari 24','351829198631','08562383719','naf_iya@yahoo.co.id',to_date('02-08-2017','dd-mm-yyyy'));
INSERT INTO siswa VALUES ('S0006','Cynthia','Jl. Ciputra 219','263638169991','081673176883','cynd3@mhs.if.its.ac.id',to_date('08-08-2017','dd-mm-yyyy'));
INSERT INTO siswa VALUES ('S0007','Subhan','Jl. Manyar Selatan 21b','291028939713','081515580376','sabhuncolek@yahoo.com',to_date('11-08-2017','dd-mm-yyyy'));
INSERT INTO siswa VALUES ('S0008','Brama','Jl. Ciputra 219','831719931804','08289372989','bramski@mhs.if.its.ac.id',to_date('11-08-2017','dd-mm-yyyy'));

INSERT INTO level_table VALUES ('LV001','BEGINNER','Level ini diperuntukkan bagi pemula');
INSERT INTO level_table VALUES ('LV002','INTERMEDIATE','Level ini telah melewati jenjang beginner dengan standar yang telah ditentukan');
INSERT INTO level_table VALUES ('LV003','ADVANCE','Level ini telah melewati jenjang intermediate dengan standar yang telah ditentukan');

/*INSERT INTO pengajar VALUES ('P0001','Hari Sudirman','Perumdos blok U-9','081673176883','sudirman38@gmail.com');
INSERT INTO pengajar VALUES ('P0002','Sugeng','Jl. Kedung doro 21','085739384826','sugenggeng@yahoo.com');
INSERT INTO pengajar VALUES ('P0003','Bondan Hartono','Jl. Achmad Yan 14','088975367131','bondan_ganz@yahoo.com');
INSERT INTO pengajar VALUES ('P0004','Hariyoso','Jl. Banyu Urip 119','081519848921','har_manchester@ymail.com');
INSERT INTO pengajar VALUES ('P0005','Sulastrini','Jl. Siwalan Kerto 99','085649829199','sulastri11@google.com');

INSERT INTO paket_kursus VALUES ('PK001','LV001','P0001','Class Basic','Kelas ini diperuntukkan bagi siswa yang mempelajari hal dasar','1000000',to_date('01-08-2017','dd-mm-yyyy'),to_date('01-09-2017','dd-mm-yyyy'));
INSERT INTO paket_kursus VALUES ('PK002','LV001','P0005','Conversation Basic','1150000',to_date('01-08-2017','dd-mm-yyyy'),to_date('01-09-2017','dd-mm-yyyy'));
INSERT INTO paket_kursus VALUES ('PK003','LV001','P0004','Writing Basic','1200000',to_date('01-08-2017','dd-mm-yyyy'),to_date('01-09-2017','dd-mm-yyyy'));
INSERT INTO paket_kursus VALUES ('PK004','LV002','P0001','Class Mediate','2000000',to_date('11-08-2017','dd-mm-yyyy'),to_date('11-09-2017','dd-mm-yyyy'));
INSERT INTO paket_kursus VALUES ('PK005','LV002','P0003','Conversation Mediate','2150000',to_date('11-08-2017','dd-mm-yyyy'),to_date('11-09-2017','dd-mm-yyyy'));
INSERT INTO paket_kursus VALUES ('PK006','LV002','P0005','Writing Mediate','2200000',to_date('11-08-2017','dd-mm-yyyy'),to_date('11-09-2017','dd-mm-yyyy'));
INSERT INTO paket_kursus VALUES ('PK007','LV003','P0002','Class Pro','2500000',to_date('21-08-2017','dd-mm-yyyy'),to_date('21-09-2017','dd-mm-yyyy'));
INSERT INTO paket_kursus VALUES ('PK008','LV003','P0003','Conversation Pro','2800000',to_date('21-08-2017','dd-mm-yyyy'),to_date('21-09-2017','dd-mm-yyyy')); */