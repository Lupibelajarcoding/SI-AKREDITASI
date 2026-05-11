-- MySQL dump 10.13  Distrib 8.0.35, for Win64 (x86_64)
--
-- Host: localhost    Database: si_akreditasi
-- ------------------------------------------------------
-- Server version	8.0.35

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `1a1_pimpinan_dan_tupoksi`
--

DROP TABLE IF EXISTS `1a1_pimpinan_dan_tupoksi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `1a1_pimpinan_dan_tupoksi` (
  `id_pimpinan` int NOT NULL AUTO_INCREMENT,
  `id_pegawai` int NOT NULL,
  `periode_mulai` year NOT NULL,
  `periode_selesai` year NOT NULL,
  `tupoksi` text,
  `sks_jabatan` decimal(4,2) DEFAULT '0.00',
  `id_jafung` int DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_pimpinan`),
  KEY `id_pegawai` (`id_pegawai`),
  KEY `fk_1a1_jafung` (`id_jafung`),
  CONSTRAINT `1a1_pimpinan_dan_tupoksi_ibfk_1` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id_pegawai`),
  CONSTRAINT `fk_1a1_jafung` FOREIGN KEY (`id_jafung`) REFERENCES `jabatan_fungsional` (`id_jafung`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `1a1_pimpinan_dan_tupoksi`
--

LOCK TABLES `1a1_pimpinan_dan_tupoksi` WRITE;
/*!40000 ALTER TABLE `1a1_pimpinan_dan_tupoksi` DISABLE KEYS */;
INSERT INTO `1a1_pimpinan_dan_tupoksi` VALUES (1,2,2023,2024,'blablabla',7.00,NULL,'2026-04-15 09:18:08',3,NULL,NULL,NULL,NULL),(2,1,2024,2026,'bla',0.00,NULL,'2026-04-15 09:19:41',3,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `1a1_pimpinan_dan_tupoksi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `1a2_sumber_pendanaan_upps`
--

DROP TABLE IF EXISTS `1a2_sumber_pendanaan_upps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `1a2_sumber_pendanaan_upps` (
  `id_sumber` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `nama_sumber` varchar(255) NOT NULL,
  `jumlah_dana` int NOT NULL COMMENT 'Dalam jutaan rupiah',
  `link_bukti` varchar(255) NOT NULL,
  `id_tahun` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_sumber`),
  KEY `fk_1a2_tahun` (`id_tahun`),
  CONSTRAINT `fk_1a2_tahun` FOREIGN KEY (`id_tahun`) REFERENCES `tahun_akademik` (`id_tahun`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `1a2_sumber_pendanaan_upps`
--

LOCK TABLES `1a2_sumber_pendanaan_upps` WRITE;
/*!40000 ALTER TABLE `1a2_sumber_pendanaan_upps` DISABLE KEYS */;
INSERT INTO `1a2_sumber_pendanaan_upps` VALUES (1,1,'SPP Mahasiswa',15000000,'https://vsdg',3,'2026-04-13 12:08:40',3,NULL,NULL,NULL,NULL),(2,1,'SPP Mahasiswa',5000000,'https://ghhjh.gdrive',2,'2026-04-29 08:01:37',3,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `1a2_sumber_pendanaan_upps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `1a3_penggunaan_dana_upps`
--

DROP TABLE IF EXISTS `1a3_penggunaan_dana_upps`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `1a3_penggunaan_dana_upps` (
  `id_penggunaan` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `nama_penggunaan` varchar(255) NOT NULL COMMENT 'Contoh: Pendidikan, Penelitian, PkM, dll',
  `jumlah_dana` int DEFAULT '0' COMMENT 'Dalam jutaan rupiah',
  `link_bukti` varchar(255) NOT NULL,
  `id_tahun` int NOT NULL COMMENT 'Tahun Akademik (TS)',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_penggunaan`),
  KEY `fk_1a3_tahun` (`id_tahun`),
  CONSTRAINT `fk_1a3_tahun` FOREIGN KEY (`id_tahun`) REFERENCES `tahun_akademik` (`id_tahun`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `1a3_penggunaan_dana_upps`
--

LOCK TABLES `1a3_penggunaan_dana_upps` WRITE;
/*!40000 ALTER TABLE `1a3_penggunaan_dana_upps` DISABLE KEYS */;
INSERT INTO `1a3_penggunaan_dana_upps` VALUES (1,1,'Lomba Mahasiswa',3000000,'https://ghhjh.gdrive',3,'2026-04-14 05:36:51',3,'2026-04-21 20:04:58',NULL,NULL,NULL),(2,1,'Lomba Mahasiswa',2000000,'https://ghhjh.gdrive',2,'2026-04-14 05:37:07',3,'2026-04-21 20:07:54',NULL,NULL,NULL);
/*!40000 ALTER TABLE `1a3_penggunaan_dana_upps` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `1a4_beban_dtpr`
--

DROP TABLE IF EXISTS `1a4_beban_dtpr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `1a4_beban_dtpr` (
  `id_beban_kerja` int NOT NULL AUTO_INCREMENT,
  `id_dosen` int NOT NULL,
  `id_pimpinan` int DEFAULT NULL,
  `sks_ps_sendiri` decimal(4,2) DEFAULT '0.00',
  `sks_ps_lain` decimal(4,2) DEFAULT '0.00',
  `sks_pt_lain` decimal(4,2) DEFAULT '0.00',
  `sks_penelitian` decimal(4,2) DEFAULT '0.00',
  `sks_pkm` decimal(4,2) DEFAULT '0.00',
  `sks_manajemen_pt_lain` decimal(4,2) DEFAULT '0.00',
  `id_tahun` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_beban_kerja`),
  KEY `id_dosen` (`id_dosen`),
  KEY `id_pimpinan` (`id_pimpinan`),
  KEY `id_tahun` (`id_tahun`),
  CONSTRAINT `1a4_beban_dtpr_ibfk_1` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`),
  CONSTRAINT `1a4_beban_dtpr_ibfk_2` FOREIGN KEY (`id_pimpinan`) REFERENCES `1a1_pimpinan_dan_tupoksi` (`id_pimpinan`),
  CONSTRAINT `1a4_beban_dtpr_ibfk_3` FOREIGN KEY (`id_tahun`) REFERENCES `tahun_akademik` (`id_tahun`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `1a4_beban_dtpr`
--

LOCK TABLES `1a4_beban_dtpr` WRITE;
/*!40000 ALTER TABLE `1a4_beban_dtpr` DISABLE KEYS */;
INSERT INTO `1a4_beban_dtpr` VALUES (1,2,3,1.00,1.00,1.00,1.00,1.00,1.00,1,'2026-04-08 07:02:44',3,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `1a4_beban_dtpr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `1a5_kualifikasi_tendik`
--

DROP TABLE IF EXISTS `1a5_kualifikasi_tendik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `1a5_kualifikasi_tendik` (
  `id_1a5` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `id_tahun` int NOT NULL,
  `id_tendik` int NOT NULL,
  `pendidikan_snapshot` varchar(50) NOT NULL,
  `jenis_tendik_snapshot` varchar(100) NOT NULL,
  `nama_unit_snapshot` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_1a5`),
  KEY `fk_1a5_prodi` (`id_prodi`),
  KEY `fk_1a5_tahun` (`id_tahun`),
  KEY `fk_1a5_tendik` (`id_tendik`),
  CONSTRAINT `fk_1a5_prodi` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`),
  CONSTRAINT `fk_1a5_tahun` FOREIGN KEY (`id_tahun`) REFERENCES `tahun_akademik` (`id_tahun`),
  CONSTRAINT `fk_1a5_tendik` FOREIGN KEY (`id_tendik`) REFERENCES `tenaga_kependidikan` (`id_tendik`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `1a5_kualifikasi_tendik`
--

LOCK TABLES `1a5_kualifikasi_tendik` WRITE;
/*!40000 ALTER TABLE `1a5_kualifikasi_tendik` DISABLE KEYS */;
INSERT INTO `1a5_kualifikasi_tendik` VALUES (1,1,3,2,'S1','Laboran/Teknisi','SISFO','2026-04-16 06:44:24',3,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `1a5_kualifikasi_tendik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `1b_unit_spmi_dan_sdm`
--

DROP TABLE IF EXISTS `1b_unit_spmi_dan_sdm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `1b_unit_spmi_dan_sdm` (
  `id_unit_spmi` int NOT NULL AUTO_INCREMENT,
  `jenis_unit` varchar(50) DEFAULT NULL,
  `dokumen_spmi` varchar(255) DEFAULT NULL COMMENT 'Link Dokumen SPMI',
  `jumlah_auditor` int DEFAULT '0',
  `auditor_certified` int DEFAULT '0',
  `auditor_non_certified` int DEFAULT '0',
  `frekuensi_audit` int DEFAULT '0' COMMENT 'Frekuensi Audit per Tahun',
  `bukti_certified_auditor` varchar(255) DEFAULT NULL COMMENT 'Link Bukti Sertifikat',
  `laporan_audit` varchar(255) DEFAULT NULL COMMENT 'Link Laporan Hasil Audit',
  `unit_kerja_id_unit` int NOT NULL,
  `tahun_akademik_id_tahun` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_unit_spmi`),
  KEY `fk_spmi_unit` (`unit_kerja_id_unit`),
  KEY `fk_spmi_tahun` (`tahun_akademik_id_tahun`),
  CONSTRAINT `fk_spmi_tahun` FOREIGN KEY (`tahun_akademik_id_tahun`) REFERENCES `tahun_akademik` (`id_tahun`),
  CONSTRAINT `fk_spmi_unit` FOREIGN KEY (`unit_kerja_id_unit`) REFERENCES `unit_kerja` (`id_unit`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `1b_unit_spmi_dan_sdm`
--

LOCK TABLES `1b_unit_spmi_dan_sdm` WRITE;
/*!40000 ALTER TABLE `1b_unit_spmi_dan_sdm` DISABLE KEYS */;
INSERT INTO `1b_unit_spmi_dan_sdm` VALUES (1,NULL,'https://drjhgjyu',2,1,1,1,'https://drjhgjyu','https://drjhgjyu',2,1,'2026-04-13 03:52:34',3,'2026-04-13 04:44:58',NULL,NULL,NULL);
/*!40000 ALTER TABLE `1b_unit_spmi_dan_sdm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `2a1_data_mahasiswa`
--

DROP TABLE IF EXISTS `2a1_data_mahasiswa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `2a1_data_mahasiswa` (
  `id_2a1` int unsigned NOT NULL AUTO_INCREMENT,
  `prodi_id_prodi` int NOT NULL,
  `tahun_akademik_id_tahun` int NOT NULL,
  `daya_tampung` int unsigned DEFAULT '0',
  `pendaftar` int unsigned DEFAULT '0',
  `pendaftar_afirmasi` int unsigned DEFAULT '0',
  `pendaftar_khusus` int unsigned DEFAULT '0',
  `maba_reg_diterima` int unsigned DEFAULT '0',
  `maba_reg_afirmasi` int unsigned DEFAULT '0',
  `maba_reg_khusus` int unsigned DEFAULT '0',
  `maba_rpl_diterima` int unsigned DEFAULT '0',
  `maba_rpl_afirmasi` int unsigned DEFAULT '0',
  `maba_rpl_khusus` int unsigned DEFAULT '0',
  `aktif_reg_diterima` int unsigned DEFAULT '0',
  `aktif_reg_afirmasi` int unsigned DEFAULT '0',
  `aktif_reg_khusus` int unsigned DEFAULT '0',
  `aktif_rpl_diterima` int unsigned DEFAULT '0',
  `aktif_rpl_afirmasi` int unsigned DEFAULT '0',
  `aktif_rpl_khusus` int unsigned DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `pmb_deleted_at` datetime DEFAULT NULL,
  `pmb_deleted_by` int DEFAULT NULL,
  `ala_deleted_at` datetime DEFAULT NULL,
  `ala_deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_2a1`),
  UNIQUE KEY `idx_prodi_tahun` (`prodi_id_prodi`,`tahun_akademik_id_tahun`),
  UNIQUE KEY `idx_unique_prodi_tahun` (`prodi_id_prodi`,`tahun_akademik_id_tahun`),
  KEY `idx_2a1_prodi_tahun` (`prodi_id_prodi`,`tahun_akademik_id_tahun`),
  KEY `fk_2a1_tahun` (`tahun_akademik_id_tahun`),
  CONSTRAINT `fk_2a1_prodi` FOREIGN KEY (`prodi_id_prodi`) REFERENCES `prodi` (`id_prodi`),
  CONSTRAINT `fk_2a1_tahun` FOREIGN KEY (`tahun_akademik_id_tahun`) REFERENCES `tahun_akademik` (`id_tahun`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `2a1_data_mahasiswa`
--

LOCK TABLES `2a1_data_mahasiswa` WRITE;
/*!40000 ALTER TABLE `2a1_data_mahasiswa` DISABLE KEYS */;
INSERT INTO `2a1_data_mahasiswa` VALUES (1,1,3,96,50,0,0,45,0,0,4,0,0,500,40,3,100,1,0,'2026-05-04 08:13:53',4,'2026-05-05 06:08:20',3,'2026-05-05 13:08:20',3,NULL,NULL),(2,1,2,50,100,10,0,30,5,0,20,3,0,400,40,0,100,20,0,'2026-05-05 03:29:46',3,'2026-05-05 03:32:13',6,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `2a1_data_mahasiswa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `2b1_isi_pembelajaran`
--

DROP TABLE IF EXISTS `2b1_isi_pembelajaran`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `2b1_isi_pembelajaran` (
  `id_2b1` int NOT NULL AUTO_INCREMENT,
  `id_mk` int NOT NULL,
  `id_pl` int NOT NULL,
  `id_tahun` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_2b1`),
  KEY `fk_2b1_mk` (`id_mk`),
  KEY `fk_2b1_pl` (`id_pl`),
  KEY `fk_2b1_tahun` (`id_tahun`),
  CONSTRAINT `fk_2b1_mk` FOREIGN KEY (`id_mk`) REFERENCES `master_mata_kuliah` (`id_mk`),
  CONSTRAINT `fk_2b1_pl` FOREIGN KEY (`id_pl`) REFERENCES `master_profil_lulusan` (`id_pl`),
  CONSTRAINT `fk_2b1_tahun` FOREIGN KEY (`id_tahun`) REFERENCES `tahun_akademik` (`id_tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `2b1_isi_pembelajaran`
--

LOCK TABLES `2b1_isi_pembelajaran` WRITE;
/*!40000 ALTER TABLE `2b1_isi_pembelajaran` DISABLE KEYS */;
/*!40000 ALTER TABLE `2b1_isi_pembelajaran` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `2b2_pemetaan_cpl_pl`
--

DROP TABLE IF EXISTS `2b2_pemetaan_cpl_pl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `2b2_pemetaan_cpl_pl` (
  `id_2b2` int NOT NULL AUTO_INCREMENT,
  `id_cpl` int NOT NULL,
  `id_pl` int NOT NULL,
  `id_tahun` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_2b2`),
  KEY `fk_2b2_cpl` (`id_cpl`),
  KEY `fk_2b2_pl` (`id_pl`),
  KEY `fk_2b2_tahun` (`id_tahun`),
  CONSTRAINT `fk_2b2_cpl` FOREIGN KEY (`id_cpl`) REFERENCES `master_cpl` (`id_cpl`),
  CONSTRAINT `fk_2b2_pl` FOREIGN KEY (`id_pl`) REFERENCES `master_profil_lulusan` (`id_pl`),
  CONSTRAINT `fk_2b2_tahun` FOREIGN KEY (`id_tahun`) REFERENCES `tahun_akademik` (`id_tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `2b2_pemetaan_cpl_pl`
--

LOCK TABLES `2b2_pemetaan_cpl_pl` WRITE;
/*!40000 ALTER TABLE `2b2_pemetaan_cpl_pl` DISABLE KEYS */;
/*!40000 ALTER TABLE `2b2_pemetaan_cpl_pl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `2b3_peta_pemenuhan_cpl`
--

DROP TABLE IF EXISTS `2b3_peta_pemenuhan_cpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `2b3_peta_pemenuhan_cpl` (
  `id_2b3` int NOT NULL AUTO_INCREMENT,
  `id_cpl` int NOT NULL,
  `id_cpmk` int NOT NULL,
  `id_mk` int NOT NULL,
  `id_tahun` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_2b3`),
  KEY `fk_2b3_cpl` (`id_cpl`),
  KEY `fk_2b3_cpmk` (`id_cpmk`),
  KEY `fk_2b3_mk` (`id_mk`),
  KEY `fk_2b3_tahun` (`id_tahun`),
  CONSTRAINT `fk_2b3_cpl` FOREIGN KEY (`id_cpl`) REFERENCES `master_cpl` (`id_cpl`),
  CONSTRAINT `fk_2b3_cpmk` FOREIGN KEY (`id_cpmk`) REFERENCES `master_cpmk` (`id_cpmk`),
  CONSTRAINT `fk_2b3_mk` FOREIGN KEY (`id_mk`) REFERENCES `master_mata_kuliah` (`id_mk`),
  CONSTRAINT `fk_2b3_tahun` FOREIGN KEY (`id_tahun`) REFERENCES `tahun_akademik` (`id_tahun`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `2b3_peta_pemenuhan_cpl`
--

LOCK TABLES `2b3_peta_pemenuhan_cpl` WRITE;
/*!40000 ALTER TABLE `2b3_peta_pemenuhan_cpl` DISABLE KEYS */;
/*!40000 ALTER TABLE `2b3_peta_pemenuhan_cpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `2b4_masa_tunggu`
--

DROP TABLE IF EXISTS `2b4_masa_tunggu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `2b4_masa_tunggu` (
  `id_2b4` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `id_tahun` int NOT NULL COMMENT 'TS, TS-1, atau TS-2',
  `jumlah_lulusan` int unsigned DEFAULT '0',
  `jumlah_terlacak` int unsigned DEFAULT '0',
  `rata_tunggu` decimal(5,2) DEFAULT '0.00' COMMENT 'Dalam satuan bulan',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_2b4`),
  KEY `fk_2b4_prodi` (`id_prodi`),
  KEY `fk_2b4_tahun` (`id_tahun`),
  CONSTRAINT `fk_2b4_prodi` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`),
  CONSTRAINT `fk_2b4_tahun` FOREIGN KEY (`id_tahun`) REFERENCES `tahun_akademik` (`id_tahun`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `2b4_masa_tunggu`
--

LOCK TABLES `2b4_masa_tunggu` WRITE;
/*!40000 ALTER TABLE `2b4_masa_tunggu` DISABLE KEYS */;
INSERT INTO `2b4_masa_tunggu` VALUES (1,1,3,50,20,4.51,'2026-04-21 04:45:44',3,'2026-04-22 04:19:45',3,NULL,NULL);
/*!40000 ALTER TABLE `2b4_masa_tunggu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `2b5_kesesuaian_kerja`
--

DROP TABLE IF EXISTS `2b5_kesesuaian_kerja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `2b5_kesesuaian_kerja` (
  `id_2b5` int NOT NULL AUTO_INCREMENT,
  `id_2b4` int NOT NULL COMMENT 'Relasi ke data masa tunggu TS yang sama',
  `profesi_infokom` int unsigned DEFAULT '0',
  `profesi_non_infokom` int unsigned DEFAULT '0',
  `lingkup_multinasional` int unsigned DEFAULT '0',
  `lingkup_nasional` int unsigned DEFAULT '0',
  `lingkup_wirausaha` int unsigned DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_2b5`),
  KEY `fk_2b5_to_2b4` (`id_2b4`),
  CONSTRAINT `fk_2b5_to_2b4` FOREIGN KEY (`id_2b4`) REFERENCES `2b4_masa_tunggu` (`id_2b4`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `2b5_kesesuaian_kerja`
--

LOCK TABLES `2b5_kesesuaian_kerja` WRITE;
/*!40000 ALTER TABLE `2b5_kesesuaian_kerja` DISABLE KEYS */;
INSERT INTO `2b5_kesesuaian_kerja` VALUES (2,1,5,15,4,15,1,'2026-04-22 04:15:32',3,'2026-04-22 04:20:01',NULL,NULL,NULL);
/*!40000 ALTER TABLE `2b5_kesesuaian_kerja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `2b6_kepuasan_pengguna`
--

DROP TABLE IF EXISTS `2b6_kepuasan_pengguna`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `2b6_kepuasan_pengguna` (
  `id_2b6` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `id_tahun` int NOT NULL,
  `jenis_kemampuan` varchar(100) NOT NULL,
  `sangat_baik` decimal(5,2) DEFAULT '0.00',
  `baik` decimal(5,2) DEFAULT '0.00',
  `cukup` decimal(5,2) DEFAULT '0.00',
  `kurang` decimal(5,2) DEFAULT '0.00',
  `rencana_tindak_lanjut` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_2b6`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `2b6_kepuasan_pengguna`
--

LOCK TABLES `2b6_kepuasan_pengguna` WRITE;
/*!40000 ALTER TABLE `2b6_kepuasan_pengguna` DISABLE KEYS */;
INSERT INTO `2b6_kepuasan_pengguna` VALUES (1,1,3,'Kerjasama Tim',50.00,10.00,20.00,20.00,'eaa','2026-04-22 07:54:49',3,NULL,NULL,NULL,NULL),(2,1,3,'Keahlian di Bidang Prodi',60.00,20.00,5.00,15.00,'eaa','2026-04-22 07:54:49',3,NULL,NULL,NULL,NULL),(3,1,3,'Kemampuan Berbahasa Asing (Inggris)',70.00,10.00,10.00,10.00,'ea','2026-04-22 07:54:49',3,NULL,NULL,NULL,NULL),(4,1,3,'Kemampuan Berkomunikasi',50.00,20.00,10.00,20.00,'eaaaa','2026-04-22 07:54:49',3,NULL,NULL,NULL,NULL),(5,1,3,'Pengembangan Diri',40.00,20.00,20.00,20.00,'aaaa','2026-04-22 07:54:49',3,NULL,NULL,NULL,NULL),(6,1,3,'Kepemimpinan',60.00,5.00,15.00,20.00,'eee','2026-04-22 07:54:49',3,NULL,NULL,NULL,NULL),(7,1,3,'Etos Kerja',30.00,50.00,10.00,10.00,'aaaa','2026-04-22 07:54:49',3,'2026-04-22 08:11:14',NULL,NULL,NULL);
/*!40000 ALTER TABLE `2b6_kepuasan_pengguna` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `2b6_metadata_lulusan`
--

DROP TABLE IF EXISTS `2b6_metadata_lulusan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `2b6_metadata_lulusan` (
  `id_metadata` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `id_tahun` int NOT NULL,
  `jml_alumni_3_tahun` int unsigned DEFAULT '0',
  `jml_responden` int unsigned DEFAULT '0',
  `jml_mhs_aktif_ts` int unsigned DEFAULT '0',
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_metadata`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `2b6_metadata_lulusan`
--

LOCK TABLES `2b6_metadata_lulusan` WRITE;
/*!40000 ALTER TABLE `2b6_metadata_lulusan` DISABLE KEYS */;
INSERT INTO `2b6_metadata_lulusan` VALUES (1,1,3,50,30,0,NULL);
/*!40000 ALTER TABLE `2b6_metadata_lulusan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `2d_ref_sumber_rekognisi`
--

DROP TABLE IF EXISTS `2d_ref_sumber_rekognisi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `2d_ref_sumber_rekognisi` (
  `id_ref_sumber` int unsigned NOT NULL AUTO_INCREMENT,
  `nama_sumber` varchar(255) NOT NULL,
  `is_default` tinyint(1) DEFAULT '0' COMMENT '1 jika bawaan LKPS, 0 jika tambahan user',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_ref_sumber`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `2d_ref_sumber_rekognisi`
--

LOCK TABLES `2d_ref_sumber_rekognisi` WRITE;
/*!40000 ALTER TABLE `2d_ref_sumber_rekognisi` DISABLE KEYS */;
INSERT INTO `2d_ref_sumber_rekognisi` VALUES (1,'Masyarakat',1,'2026-04-24 07:30:06'),(2,'Dunia Usaha',1,'2026-04-24 07:30:06'),(3,'Dunia Industri',1,'2026-04-24 07:30:06'),(4,'Dunia Kerja',1,'2026-04-24 07:30:06');
/*!40000 ALTER TABLE `2d_ref_sumber_rekognisi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `2d_rekognisi_lulusan`
--

DROP TABLE IF EXISTS `2d_rekognisi_lulusan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `2d_rekognisi_lulusan` (
  `id_2d` int unsigned NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `id_tahun` int NOT NULL,
  `id_ref_sumber` int unsigned NOT NULL,
  `jenis_rekognisi` text NOT NULL,
  `link_bukti` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_2d`),
  KEY `fk_2d_prodi_idx` (`id_prodi`),
  KEY `fk_2d_tahun_idx` (`id_tahun`),
  KEY `fk_2d_sumber_idx` (`id_ref_sumber`),
  CONSTRAINT `fk_2d_prodi` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`),
  CONSTRAINT `fk_2d_sumber` FOREIGN KEY (`id_ref_sumber`) REFERENCES `2d_ref_sumber_rekognisi` (`id_ref_sumber`),
  CONSTRAINT `fk_2d_tahun` FOREIGN KEY (`id_tahun`) REFERENCES `tahun_akademik` (`id_tahun`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `2d_rekognisi_lulusan`
--

LOCK TABLES `2d_rekognisi_lulusan` WRITE;
/*!40000 ALTER TABLE `2d_rekognisi_lulusan` DISABLE KEYS */;
INSERT INTO `2d_rekognisi_lulusan` VALUES (1,1,3,1,'Koding bersama STIKOM BALI','https://ghedug','2026-04-24 07:47:55',3,NULL,NULL,NULL,NULL),(2,1,3,2,'Koding bersama STIKOM BANDUNG','https://ghedug','2026-04-24 07:49:36',3,NULL,NULL,NULL,NULL),(3,1,1,4,'Koding bersama STIKOM Bnyuwangi','https://ghedug','2026-04-24 07:50:13',3,'2026-04-24 08:01:25',NULL,'2026-04-24 08:01:25',3);
/*!40000 ALTER TABLE `2d_rekognisi_lulusan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `3a1_sarana_prasarana_penelitian`
--

DROP TABLE IF EXISTS `3a1_sarana_prasarana_penelitian`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `3a1_sarana_prasarana_penelitian` (
  `id_3a1` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `nama_prasarana` varchar(255) NOT NULL COMMENT 'Diisi nama laboratorium',
  `daya_tampung` int unsigned DEFAULT '0',
  `luas_ruang` decimal(10,2) DEFAULT '0.00' COMMENT 'Dalam satuan m2',
  `status_milik` enum('M','W') NOT NULL DEFAULT 'M',
  `status_lisensi` enum('L','P','T') NOT NULL DEFAULT 'L',
  `perangkat` text COMMENT 'Hard/Soft-ware, bandwidth, device, tool, dll',
  `info_tambahan` text COMMENT 'Untuk mengisi kolom ..... di gambar',
  `link_bukti` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_3a1`),
  KEY `fk_3a1_prodi` (`id_prodi`),
  CONSTRAINT `fk_3a1_prodi` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `3a1_sarana_prasarana_penelitian`
--

LOCK TABLES `3a1_sarana_prasarana_penelitian` WRITE;
/*!40000 ALTER TABLE `3a1_sarana_prasarana_penelitian` DISABLE KEYS */;
INSERT INTO `3a1_sarana_prasarana_penelitian` VALUES (1,1,'Laboratorium AI/Citra',30,100.00,'M','L','PC HP','info info','https://ghhjh.gdrive','2026-04-16 07:59:41',3,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `3a1_sarana_prasarana_penelitian` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `3a3_pengembangan_dtpr`
--

DROP TABLE IF EXISTS `3a3_pengembangan_dtpr`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `3a3_pengembangan_dtpr` (
  `id_pengembangan` int NOT NULL AUTO_INCREMENT,
  `id_dosen` int NOT NULL,
  `jenis_pengembangan` varchar(255) DEFAULT NULL,
  `nama_pengembangan` varchar(255) DEFAULT NULL,
  `link_bukti` varchar(255) DEFAULT NULL,
  `id_tahun` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_pengembangan`),
  KEY `id_dosen` (`id_dosen`),
  KEY `id_tahun` (`id_tahun`),
  CONSTRAINT `3a3_pengembangan_dtpr_ibfk_1` FOREIGN KEY (`id_dosen`) REFERENCES `dosen` (`id_dosen`),
  CONSTRAINT `3a3_pengembangan_dtpr_ibfk_2` FOREIGN KEY (`id_tahun`) REFERENCES `tahun_akademik` (`id_tahun`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `3a3_pengembangan_dtpr`
--

LOCK TABLES `3a3_pengembangan_dtpr` WRITE;
/*!40000 ALTER TABLE `3a3_pengembangan_dtpr` DISABLE KEYS */;
INSERT INTO `3a3_pengembangan_dtpr` VALUES (1,2,'sertifikasi auditor','auditor nasional indonesia raya','https://ghhjh.gdrive',3,'2026-04-09 03:19:19',3,'2026-04-09 03:19:41',NULL,NULL,NULL),(2,2,'sertifikasi marah marah','auditor marah marah','https://ghhjh.gdrive',2,'2026-04-09 03:25:04',3,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `3a3_pengembangan_dtpr` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `4a1_sarana_prasarana_pkm`
--

DROP TABLE IF EXISTS `4a1_sarana_prasarana_pkm`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `4a1_sarana_prasarana_pkm` (
  `id_4a1` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `nama_prasarana` varchar(255) NOT NULL COMMENT 'Diisi nama laboratorium, bengkel, dll',
  `daya_tampung` int unsigned DEFAULT '0',
  `luas_ruang` decimal(10,2) DEFAULT '0.00',
  `status_milik` enum('M','W') NOT NULL DEFAULT 'M',
  `status_lisensi` enum('L','P','T') NOT NULL DEFAULT 'L',
  `perangkat` text COMMENT 'Hard/Soft-ware, bandwidth, device, tool, dll',
  `info_tambahan` text COMMENT 'Untuk mengisi kolom ..... di gambar',
  `link_bukti` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_4a1`),
  KEY `fk_4a1_prodi` (`id_prodi`),
  CONSTRAINT `fk_4a1_prodi` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `4a1_sarana_prasarana_pkm`
--

LOCK TABLES `4a1_sarana_prasarana_pkm` WRITE;
/*!40000 ALTER TABLE `4a1_sarana_prasarana_pkm` DISABLE KEYS */;
INSERT INTO `4a1_sarana_prasarana_pkm` VALUES (1,1,'Laboratorium Basis Data',30,50.00,'M','L','Meja dan Kursi','','https://ghhjh.gdrive','2026-04-16 08:31:42',3,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `4a1_sarana_prasarana_pkm` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `5_2_sarana_prasarana_pendidikan`
--

DROP TABLE IF EXISTS `5_2_sarana_prasarana_pendidikan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `5_2_sarana_prasarana_pendidikan` (
  `id_5_2` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `nama_prasarana` varchar(255) NOT NULL COMMENT 'Ruang kelas, Lab, Perpustakaan, dsb',
  `daya_tampung` int unsigned DEFAULT '0',
  `luas_ruang` decimal(10,2) DEFAULT '0.00',
  `status_milik` enum('M','W') NOT NULL DEFAULT 'M',
  `status_lisensi` enum('L','P','T') NOT NULL DEFAULT 'L',
  `perangkat` text COMMENT 'Hard/Soft-ware, bandwidth, device, tool, dll',
  `info_tambahan` text COMMENT 'Untuk mengisi kolom ..... di gambar',
  `link_bukti` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_5_2`),
  KEY `fk_5_2_prodi` (`id_prodi`),
  CONSTRAINT `fk_5_2_prodi` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `5_2_sarana_prasarana_pendidikan`
--

LOCK TABLES `5_2_sarana_prasarana_pendidikan` WRITE;
/*!40000 ALTER TABLE `5_2_sarana_prasarana_pendidikan` DISABLE KEYS */;
INSERT INTO `5_2_sarana_prasarana_pendidikan` VALUES (1,1,'Laboratorium Pemrograman',50,200.00,'M','L','Proyektor','','https://ghhjh.gdrive','2026-04-16 09:13:10',3,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `5_2_sarana_prasarana_pendidikan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `6_visi_misi`
--

DROP TABLE IF EXISTS `6_visi_misi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `6_visi_misi` (
  `id_vm` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `visi_pt` text,
  `misi_pt` text,
  `visi_upps` text,
  `misi_upps` text,
  `visi_keilmuan_ps` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `created_by` int DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` int DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `deleted_by` int DEFAULT NULL,
  PRIMARY KEY (`id_vm`),
  KEY `id_prodi` (`id_prodi`),
  CONSTRAINT `6_visi_misi_ibfk_1` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `6_visi_misi`
--

LOCK TABLES `6_visi_misi` WRITE;
/*!40000 ALTER TABLE `6_visi_misi` DISABLE KEYS */;
INSERT INTO `6_visi_misi` VALUES (1,1,'blablabla','blablabla','blabla','blabla','blabla','2026-04-09 08:38:21',3,NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `6_visi_misi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dosen`
--

DROP TABLE IF EXISTS `dosen`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `dosen` (
  `id_dosen` int NOT NULL AUTO_INCREMENT,
  `id_pegawai` int NOT NULL,
  `nidn` varchar(20) DEFAULT NULL,
  `nuptk` varchar(20) DEFAULT NULL,
  `id_prodi` int DEFAULT NULL,
  `perguruan_tinggi` varchar(150) DEFAULT 'STIKOM PGRI Banyuwangi',
  `id_jabatan_fungsional` int DEFAULT NULL,
  PRIMARY KEY (`id_dosen`),
  UNIQUE KEY `nidn` (`nidn`),
  UNIQUE KEY `nuptk` (`nuptk`),
  KEY `id_pegawai` (`id_pegawai`),
  KEY `id_prodi` (`id_prodi`),
  KEY `id_jabatan_fungsional` (`id_jabatan_fungsional`),
  CONSTRAINT `dosen_ibfk_1` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id_pegawai`),
  CONSTRAINT `dosen_ibfk_2` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`),
  CONSTRAINT `dosen_ibfk_3` FOREIGN KEY (`id_jabatan_fungsional`) REFERENCES `jabatan_fungsional` (`id_jafung`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dosen`
--

LOCK TABLES `dosen` WRITE;
/*!40000 ALTER TABLE `dosen` DISABLE KEYS */;
INSERT INTO `dosen` VALUES (1,1,'0701018001','NUPTK001',1,'STIKOM PGRI Banyuwangi',2),(2,2,'0702028502','NUPTK002',1,'STIKOM PGRI Banyuwangi',2);
/*!40000 ALTER TABLE `dosen` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jabatan_fungsional`
--

DROP TABLE IF EXISTS `jabatan_fungsional`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jabatan_fungsional` (
  `id_jafung` int NOT NULL AUTO_INCREMENT,
  `nama_jafung` varchar(50) NOT NULL,
  PRIMARY KEY (`id_jafung`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jabatan_fungsional`
--

LOCK TABLES `jabatan_fungsional` WRITE;
/*!40000 ALTER TABLE `jabatan_fungsional` DISABLE KEYS */;
INSERT INTO `jabatan_fungsional` VALUES (1,'Asisten Ahli'),(2,'Lektor'),(3,'Lektor Kepala');
/*!40000 ALTER TABLE `jabatan_fungsional` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jabatan_struktural`
--

DROP TABLE IF EXISTS `jabatan_struktural`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jabatan_struktural` (
  `id_jabatan_struktural` int NOT NULL AUTO_INCREMENT,
  `nama_jabatan` varchar(50) NOT NULL,
  PRIMARY KEY (`id_jabatan_struktural`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jabatan_struktural`
--

LOCK TABLES `jabatan_struktural` WRITE;
/*!40000 ALTER TABLE `jabatan_struktural` DISABLE KEYS */;
INSERT INTO `jabatan_struktural` VALUES (1,'Ketua'),(2,'Staff');
/*!40000 ALTER TABLE `jabatan_struktural` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_cpl`
--

DROP TABLE IF EXISTS `master_cpl`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_cpl` (
  `id_cpl` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `kode_cpl` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `deskripsi_cpl` text COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_cpl`),
  KEY `fk_cpl_prodi` (`id_prodi`),
  CONSTRAINT `fk_cpl_prodi` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_cpl`
--

LOCK TABLES `master_cpl` WRITE;
/*!40000 ALTER TABLE `master_cpl` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_cpl` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_cpmk`
--

DROP TABLE IF EXISTS `master_cpmk`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_cpmk` (
  `id_cpmk` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `kode_cpmk` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `deskripsi_cpmk` text COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_cpmk`),
  KEY `fk_cpmk_prodi` (`id_prodi`),
  CONSTRAINT `fk_cpmk_prodi` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_cpmk`
--

LOCK TABLES `master_cpmk` WRITE;
/*!40000 ALTER TABLE `master_cpmk` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_cpmk` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_mata_kuliah`
--

DROP TABLE IF EXISTS `master_mata_kuliah`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_mata_kuliah` (
  `id_mk` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `kode_mk` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `nama_mk` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `sks` int NOT NULL,
  `semester` int NOT NULL,
  PRIMARY KEY (`id_mk`),
  KEY `fk_mk_prodi` (`id_prodi`),
  CONSTRAINT `fk_mk_prodi` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_mata_kuliah`
--

LOCK TABLES `master_mata_kuliah` WRITE;
/*!40000 ALTER TABLE `master_mata_kuliah` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_mata_kuliah` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_profil_lulusan`
--

DROP TABLE IF EXISTS `master_profil_lulusan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_profil_lulusan` (
  `id_pl` int NOT NULL AUTO_INCREMENT,
  `id_prodi` int NOT NULL,
  `kode_pl` varchar(50) COLLATE utf8mb4_general_ci NOT NULL,
  `deskripsi_pl` text COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_pl`),
  KEY `fk_pl_prodi` (`id_prodi`),
  CONSTRAINT `fk_pl_prodi` FOREIGN KEY (`id_prodi`) REFERENCES `prodi` (`id_prodi`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_profil_lulusan`
--

LOCK TABLES `master_profil_lulusan` WRITE;
/*!40000 ALTER TABLE `master_profil_lulusan` DISABLE KEYS */;
/*!40000 ALTER TABLE `master_profil_lulusan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `master_sks_jabatan`
--

DROP TABLE IF EXISTS `master_sks_jabatan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `master_sks_jabatan` (
  `id_sks_jabatan` int NOT NULL AUTO_INCREMENT,
  `nama_pencarian` varchar(100) DEFAULT NULL,
  `sks` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`id_sks_jabatan`),
  UNIQUE KEY `nama_pencarian` (`nama_pencarian`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `master_sks_jabatan`
--

LOCK TABLES `master_sks_jabatan` WRITE;
/*!40000 ALTER TABLE `master_sks_jabatan` DISABLE KEYS */;
INSERT INTO `master_sks_jabatan` VALUES (1,'Ketua STIKOM',12.00),(2,'Wakil Ketua STIKOM',10.00),(3,'Ketua Jurusan',8.00),(4,'Sekretaris Jurusan',7.00),(5,'Ketua Prodi',7.00),(6,'Sekretaris Prodi',5.00),(7,'Kepala Bagian',4.00),(8,'Kepala Sub Bagian',2.00),(9,'Ketua TPM',4.00),(10,'Staf',0.00),(11,'Non Struktural',0.00);
/*!40000 ALTER TABLE `master_sks_jabatan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pegawai`
--

DROP TABLE IF EXISTS `pegawai`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pegawai` (
  `id_pegawai` int NOT NULL AUTO_INCREMENT,
  `nama_lengkap` varchar(255) NOT NULL,
  `nikp` varchar(50) DEFAULT NULL,
  `id_unit` int DEFAULT NULL,
  `id_jabatan_struktural` int DEFAULT NULL,
  `pendidikan_terakhir` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id_pegawai`),
  UNIQUE KEY `nikp` (`nikp`),
  KEY `id_unit` (`id_unit`),
  KEY `id_jabatan_struktural` (`id_jabatan_struktural`),
  CONSTRAINT `pegawai_ibfk_1` FOREIGN KEY (`id_unit`) REFERENCES `unit_kerja` (`id_unit`),
  CONSTRAINT `pegawai_ibfk_2` FOREIGN KEY (`id_jabatan_struktural`) REFERENCES `jabatan_struktural` (`id_jabatan_struktural`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pegawai`
--

LOCK TABLES `pegawai` WRITE;
/*!40000 ALTER TABLE `pegawai` DISABLE KEYS */;
INSERT INTO `pegawai` VALUES (1,'Erdiyanto, M.Kom.','NIKP.001.2024',1,1,'S2'),(2,'Rhegysa, M.T.','NIKP.002.2024',9,1,'S2'),(3,'Budi Santoso, S.Kom.','NIKP.003.2024',5,2,'S1');
/*!40000 ALTER TABLE `pegawai` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prodi`
--

DROP TABLE IF EXISTS `prodi`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prodi` (
  `id_prodi` int NOT NULL AUTO_INCREMENT,
  `nama_prodi` varchar(100) NOT NULL,
  `id_unit` int DEFAULT NULL,
  PRIMARY KEY (`id_prodi`),
  KEY `id_unit` (`id_unit`),
  CONSTRAINT `prodi_ibfk_1` FOREIGN KEY (`id_unit`) REFERENCES `unit_kerja` (`id_unit`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prodi`
--

LOCK TABLES `prodi` WRITE;
/*!40000 ALTER TABLE `prodi` DISABLE KEYS */;
INSERT INTO `prodi` VALUES (1,'Teknik Informatika',9),(2,'Manajemen Informatika',9);
/*!40000 ALTER TABLE `prodi` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tahun_akademik`
--

DROP TABLE IF EXISTS `tahun_akademik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tahun_akademik` (
  `id_tahun` int NOT NULL AUTO_INCREMENT,
  `tahun` int NOT NULL,
  PRIMARY KEY (`id_tahun`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tahun_akademik`
--

LOCK TABLES `tahun_akademik` WRITE;
/*!40000 ALTER TABLE `tahun_akademik` DISABLE KEYS */;
INSERT INTO `tahun_akademik` VALUES (1,2020),(2,2021),(3,2022),(4,2023),(5,2024),(6,2025),(7,2026),(8,2027),(9,2028),(10,2029),(11,2030),(12,2031),(13,2032),(14,2033),(15,2034),(16,2035),(17,2036),(18,2037),(19,2038),(20,2039),(21,2040),(22,2041),(23,2042),(24,2043),(25,2044),(26,2045),(27,2046),(28,2047),(29,2048),(30,2049),(31,2050),(32,2051),(33,2052),(34,2053),(35,2054),(36,2055),(37,2056),(38,2057),(39,2058),(40,2059),(41,2060),(42,2061),(43,2062),(44,2063),(45,2064),(46,2065),(47,2066),(48,2067),(49,2068),(50,2069),(51,2070),(52,2071),(53,2072),(54,2073),(55,2074),(56,2075),(57,2076),(58,2077),(59,2078),(60,2079),(61,2080),(62,2081),(63,2082),(64,2083),(65,2084),(66,2085),(67,2086),(68,2087),(69,2088),(70,2089),(71,2090),(72,2091),(73,2092),(74,2093),(75,2094),(76,2095),(77,2096),(78,2097),(79,2098),(80,2099),(81,2100);
/*!40000 ALTER TABLE `tahun_akademik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tenaga_kependidikan`
--

DROP TABLE IF EXISTS `tenaga_kependidikan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tenaga_kependidikan` (
  `id_tendik` int NOT NULL AUTO_INCREMENT,
  `id_pegawai` int NOT NULL,
  `jenis_tendik` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_tendik`),
  KEY `id_pegawai` (`id_pegawai`),
  CONSTRAINT `tenaga_kependidikan_ibfk_1` FOREIGN KEY (`id_pegawai`) REFERENCES `pegawai` (`id_pegawai`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tenaga_kependidikan`
--

LOCK TABLES `tenaga_kependidikan` WRITE;
/*!40000 ALTER TABLE `tenaga_kependidikan` DISABLE KEYS */;
INSERT INTO `tenaga_kependidikan` VALUES (2,3,'Laboran/Teknisi');
/*!40000 ALTER TABLE `tenaga_kependidikan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `unit_kerja`
--

DROP TABLE IF EXISTS `unit_kerja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `unit_kerja` (
  `id_unit` int NOT NULL AUTO_INCREMENT,
  `nama_unit` varchar(100) NOT NULL,
  PRIMARY KEY (`id_unit`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `unit_kerja`
--

LOCK TABLES `unit_kerja` WRITE;
/*!40000 ALTER TABLE `unit_kerja` DISABLE KEYS */;
INSERT INTO `unit_kerja` VALUES (1,'UPPS'),(2,'TPM'),(3,'PMB'),(4,'SARPRAS'),(5,'SISFO'),(6,'ALA'),(7,'WAKET 2'),(8,'KEUANGAN'),(9,'PRODI'),(10,'KEMAHASISWAAN'),(11,'LPPM'),(12,'KEPEGAWAIAN'),(13,'ADMIN');
/*!40000 ALTER TABLE `unit_kerja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id_user` int NOT NULL AUTO_INCREMENT,
  `id_unit` int NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id_user`),
  UNIQUE KEY `username` (`username`),
  KEY `id_unit` (`id_unit`),
  CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_unit`) REFERENCES `unit_kerja` (`id_unit`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,5,'sisfo','$2a$12$OV4aMPsI8KpzgyuLtbn.heVQiSsrYqfFliGmfOPd4BvlbUY.B.oa6'),(2,11,'lppm','$2a$12$OV4aMPsI8KpzgyuLtbn.heVQiSsrYqfFliGmfOPd4BvlbUY.B.oa6'),(3,13,'admin','$2a$12$OV4aMPsI8KpzgyuLtbn.heVQiSsrYqfFliGmfOPd4BvlbUY.B.oa6'),(4,3,'pmb','$2a$12$OV4aMPsI8KpzgyuLtbn.heVQiSsrYqfFliGmfOPd4BvlbUY.B.oa6'),(5,6,'ala','$2a$12$OV4aMPsI8KpzgyuLtbn.heVQiSsrYqfFliGmfOPd4BvlbUY.B.oa6');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-05 16:21:36


-- =========================================================
-- ADDITION: MODUL LPPM (Penelitian, PkM, Roadmap)
-- Generated by System (No Data, Schema Only)
-- =========================================================

-- Table structure for table `roadmap_lppm`
DROP TABLE IF EXISTS `roadmap_lppm`;
CREATE TABLE `roadmap_lppm` (
  `id_roadmap` int(11) NOT NULL AUTO_INCREMENT,
  `id_prodi` int(11) NOT NULL,
  `id_tahun` int(11) NOT NULL,
  `jenis_roadmap` varchar(100) NOT NULL,
  `link_dokumen` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_roadmap`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Table structure for table `3a2_penelitian_dtpr`
DROP TABLE IF EXISTS `3a2_penelitian_dtpr`;
CREATE TABLE `3a2_penelitian_dtpr` (
  `id_3a2` int(11) NOT NULL AUTO_INCREMENT,
  `id_dosen` int(11) NOT NULL,
  `id_tahun` int(11) NOT NULL,
  `id_roadmap` int(11) NOT NULL,
  `judul_penelitian` varchar(255) NOT NULL,
  `jumlah_mahasiswa` int(11) DEFAULT 0,
  `jenis_hibah` varchar(100) DEFAULT NULL,
  `sumber` varchar(100) DEFAULT NULL,
  `durasi` int(11) DEFAULT NULL,
  `jumlah_dana` int(11) DEFAULT 0,
  `link_bukti` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_3a2`),
  KEY `fk_3a2_roadmap` (`id_roadmap`),
  CONSTRAINT `fk_3a2_roadmap` FOREIGN KEY (`id_roadmap`) REFERENCES `roadmap_lppm` (`id_roadmap`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Table structure for table `3c1_kerjasama_penelitian`
DROP TABLE IF EXISTS `3c1_kerjasama_penelitian`;
CREATE TABLE `3c1_kerjasama_penelitian` (
  `id_3c1` int(11) NOT NULL AUTO_INCREMENT,
  `id_3a2` int(11) NOT NULL,
  `id_tahun` int(11) NOT NULL,
  `judul_kerjasama` varchar(255) NOT NULL,
  `mitra_kerja_sama` varchar(255) NOT NULL,
  `sumber` varchar(100) DEFAULT NULL,
  `durasi` int(11) DEFAULT NULL,
  `jumlah_dana` int(11) DEFAULT 0,
  `link_bukti` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_3c1`),
  KEY `id_3a2` (`id_3a2`),
  CONSTRAINT `3c1_kerjasama_penelitian_ibfk_1` FOREIGN KEY (`id_3a2`) REFERENCES `3a2_penelitian_dtpr` (`id_3a2`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4;

-- Table structure for table `3c2_publikasi_penelitian`
DROP TABLE IF EXISTS `3c2_publikasi_penelitian`;
CREATE TABLE `3c2_publikasi_penelitian` (
  `id_3c2` int(11) NOT NULL AUTO_INCREMENT,
  `id_3a2` int(11) NOT NULL,
  `id_tahun` int(11) NOT NULL,
  `judul_publikasi` varchar(255) NOT NULL,
  `jenis_publikasi` varchar(100) DEFAULT NULL,
  `link_bukti` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_3c2`),
  KEY `id_3a2` (`id_3a2`),
  CONSTRAINT `3c2_publikasi_penelitian_ibfk_1` FOREIGN KEY (`id_3a2`) REFERENCES `3a2_penelitian_dtpr` (`id_3a2`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `3c3_perolehan_hki`
DROP TABLE IF EXISTS `3c3_perolehan_hki`;
CREATE TABLE `3c3_perolehan_hki` (
  `id_3c3` int(11) NOT NULL AUTO_INCREMENT,
  `id_3a2` int(11) NOT NULL,
  `id_tahun` int(11) NOT NULL,
  `judul_hki` varchar(255) NOT NULL,
  `jenis_hki` varchar(100) NOT NULL,
  `link_bukti` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_3c3`),
  KEY `id_3a2` (`id_3a2`),
  CONSTRAINT `3c3_perolehan_hki_ibfk_1` FOREIGN KEY (`id_3a2`) REFERENCES `3a2_penelitian_dtpr` (`id_3a2`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `4a2_pkm_dtpr`
DROP TABLE IF EXISTS `4a2_pkm_dtpr`;
CREATE TABLE `4a2_pkm_dtpr` (
  `id_4a2` int(11) NOT NULL AUTO_INCREMENT,
  `id_dosen` int(11) NOT NULL,
  `id_tahun` int(11) NOT NULL,
  `id_roadmap` int(11) NOT NULL,
  `judul_pkm` varchar(255) NOT NULL,
  `jumlah_mahasiswa` int(11) DEFAULT 0,
  `jenis_hibah` varchar(100) DEFAULT NULL,
  `sumber` varchar(100) DEFAULT NULL,
  `durasi` int(11) DEFAULT NULL,
  `jumlah_dana` int(11) DEFAULT 0,
  `link_bukti` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_4a2`),
  KEY `fk_4a2_roadmap` (`id_roadmap`),
  CONSTRAINT `fk_4a2_roadmap` FOREIGN KEY (`id_roadmap`) REFERENCES `roadmap_lppm` (`id_roadmap`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `4c1_kerjasama_pkm`
DROP TABLE IF EXISTS `4c1_kerjasama_pkm`;
CREATE TABLE `4c1_kerjasama_pkm` (
  `id_4c1` int(11) NOT NULL AUTO_INCREMENT,
  `id_4a2` int(11) NOT NULL,
  `id_tahun` int(11) NOT NULL,
  `judul_kerjasama` varchar(255) NOT NULL,
  `mitra_kerja_sama` varchar(255) NOT NULL,
  `sumber` varchar(100) DEFAULT NULL,
  `durasi` int(11) DEFAULT NULL,
  `jumlah_dana` int(11) DEFAULT 0,
  `link_bukti` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_4c1`),
  KEY `id_4a2` (`id_4a2`),
  CONSTRAINT `4c1_kerjasama_pkm_ibfk_1` FOREIGN KEY (`id_4a2`) REFERENCES `4a2_pkm_dtpr` (`id_4a2`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `4c2_diseminasi_hasil_pkm`
DROP TABLE IF EXISTS `4c2_diseminasi_hasil_pkm`;
CREATE TABLE `4c2_diseminasi_hasil_pkm` (
  `id_4c2` int(11) NOT NULL AUTO_INCREMENT,
  `id_4a2` int(11) NOT NULL,
  `id_tahun` int(11) NOT NULL,
  `judul_diseminasi` varchar(255) NOT NULL,
  `tingkat_diseminasi` varchar(100) DEFAULT NULL,
  `link_bukti` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_4c2`),
  KEY `id_4a2` (`id_4a2`),
  CONSTRAINT `4c2_diseminasi_hasil_pkm_ibfk_1` FOREIGN KEY (`id_4a2`) REFERENCES `4a2_pkm_dtpr` (`id_4a2`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Table structure for table `4c3_perolehan_hki_pkm`
DROP TABLE IF EXISTS `4c3_perolehan_hki_pkm`;
CREATE TABLE `4c3_perolehan_hki_pkm` (
  `id_4c3` int(11) NOT NULL AUTO_INCREMENT,
  `id_4a2` int(11) NOT NULL,
  `id_tahun` int(11) NOT NULL,
  `judul_hki` varchar(255) NOT NULL,
  `jenis_hki` varchar(100) NOT NULL,
  `link_bukti` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_by` int(11) DEFAULT NULL,
  `updated_by` int(11) DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_4c3`),
  KEY `id_4a2` (`id_4a2`),
  CONSTRAINT `4c3_perolehan_hki_pkm_ibfk_1` FOREIGN KEY (`id_4a2`) REFERENCES `4a2_pkm_dtpr` (`id_4a2`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- =========================================================
-- ADDITION: LPPM Foreign Keys to Master Tables (Dosen, Prodi, Tahun)
-- =========================================================
ALTER TABLE oadmap_lppm ADD CONSTRAINT k_roadmap_prodi FOREIGN KEY (id_prodi) REFERENCES prodi (id_prodi) ON UPDATE CASCADE;
ALTER TABLE oadmap_lppm ADD CONSTRAINT k_roadmap_tahun FOREIGN KEY (id_tahun) REFERENCES 	ahun_akademik (id_tahun) ON UPDATE CASCADE;

ALTER TABLE 3a2_penelitian_dtpr ADD CONSTRAINT k_3a2_dosen FOREIGN KEY (id_dosen) REFERENCES dosen (id_dosen) ON UPDATE CASCADE;
ALTER TABLE 3a2_penelitian_dtpr ADD CONSTRAINT k_3a2_tahun FOREIGN KEY (id_tahun) REFERENCES 	ahun_akademik (id_tahun) ON UPDATE CASCADE;

ALTER TABLE 4a2_pkm_dtpr ADD CONSTRAINT k_4a2_dosen FOREIGN KEY (id_dosen) REFERENCES dosen (id_dosen) ON UPDATE CASCADE;
ALTER TABLE 4a2_pkm_dtpr ADD CONSTRAINT k_4a2_tahun FOREIGN KEY (id_tahun) REFERENCES 	ahun_akademik (id_tahun) ON UPDATE CASCADE;
