-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 06 Nov 2024 pada 13.20
-- Versi server: 10.4.28-MariaDB
-- Versi PHP: 8.1.17

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `titik_suara`
--

-- --------------------------------------------------------

--
-- Struktur dari tabel `komentar_pengaduan`
--

CREATE TABLE `komentar_pengaduan` (
  `id_komentar` int(11) NOT NULL,
  `id_pengaduan` varchar(20) DEFAULT NULL,
  `id_pengguna` int(11) DEFAULT NULL,
  `komentar` text NOT NULL,
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `lampiran_pengaduan`
--

CREATE TABLE `lampiran_pengaduan` (
  `id_lampiran` int(11) NOT NULL,
  `id_pengaduan` varchar(20) DEFAULT NULL,
  `nama_file` varchar(255) NOT NULL,
  `file_data` mediumblob NOT NULL,
  `tipe_file` varchar(50) NOT NULL,
  `diunggah_pada` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `notifikasi`
--

CREATE TABLE `notifikasi` (
  `id_notifikasi` int(11) NOT NULL,
  `id_pengguna` int(11) DEFAULT NULL,
  `id_pengaduan` varchar(20) DEFAULT NULL,
  `pesan` text NOT NULL,
  `dibaca` tinyint(1) DEFAULT 0,
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengaduan`
--

CREATE TABLE `pengaduan` (
  `id_pengaduan` varchar(20) NOT NULL,
  `deskripsi` text NOT NULL,
  `kategori` enum('Fasilitas','Peralatan','Kebersihan','Keamanan','Lainnya') NOT NULL,
  `id_status` int(11) DEFAULT NULL,
  `id_pelapor` int(11) DEFAULT NULL,
  `id_validator` int(11) DEFAULT NULL,
  `id_admin` int(11) DEFAULT NULL,
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp(),
  `diperbarui_pada` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Trigger `pengaduan`
--
DELIMITER $$
CREATE TRIGGER `before_pengaduan_insert` BEFORE INSERT ON `pengaduan` FOR EACH ROW BEGIN
    DECLARE next_id INT;
    SET next_id = (SELECT IFNULL(MAX(SUBSTRING(id_pengaduan, 9)), 0) + 1 
                   FROM pengaduan);
    SET NEW.id_pengaduan = CONCAT('PGD', DATE_FORMAT(NOW(), '%Y%m'), 
                                 LPAD(next_id, 4, '0'));
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `pengguna`
--

CREATE TABLE `pengguna` (
  `id_pengguna` int(11) NOT NULL,
  `nama_lengkap` varchar(50) NOT NULL,
  `kata_sandi` varchar(8) NOT NULL,
  `jabatan` varchar(50) NOT NULL,
  `alamat` varchar(225) NOT NULL,
  `no_telp` int(12) NOT NULL,
  `peran` enum('admin','osis','karyawan') NOT NULL,
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp(),
  `diperbarui_pada` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `foto_profil` mediumblob DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `riwayat_pengaduan`
--

CREATE TABLE `riwayat_pengaduan` (
  `id_riwayat` int(11) NOT NULL,
  `id_pengaduan` varchar(20) DEFAULT NULL,
  `status_lama` int(11) DEFAULT NULL,
  `status_baru` int(11) DEFAULT NULL,
  `diubah_oleh` int(11) DEFAULT NULL,
  `catatan` text DEFAULT NULL,
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Struktur dari tabel `status_pengaduan`
--

CREATE TABLE `status_pengaduan` (
  `id_status` int(11) NOT NULL,
  `nama_status` varchar(50) NOT NULL,
  `keterangan` text DEFAULT NULL,
  `dibuat_pada` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data untuk tabel `status_pengaduan`
--

INSERT INTO `status_pengaduan` (`id_status`, `nama_status`, `keterangan`, `dibuat_pada`) VALUES
(1, 'Diajukan', 'Pengaduan baru yang diajukan oleh karyawan', '2024-10-23 11:34:44'),
(2, 'Dalam Proses Validasi', 'Pengaduan yang sedang diperiksa oleh OSIS', '2024-10-23 11:34:44'),
(3, 'Valid', 'Pengaduan yang telah divalidasi oleh OSIS', '2024-10-23 11:34:44'),
(4, 'Tidak Valid', 'Pengaduan yang dianggap tidak valid oleh OSIS', '2024-10-23 11:34:44'),
(5, 'Sedang Diproses', 'Pengaduan yang sedang ditangani', '2024-10-23 11:34:44'),
(6, 'Selesai', 'Pengaduan yang sudah berhasil ditangani', '2024-10-23 11:34:44');

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `komentar_pengaduan`
--
ALTER TABLE `komentar_pengaduan`
  ADD PRIMARY KEY (`id_komentar`),
  ADD KEY `id_pengaduan` (`id_pengaduan`),
  ADD KEY `id_pengguna` (`id_pengguna`);

--
-- Indeks untuk tabel `lampiran_pengaduan`
--
ALTER TABLE `lampiran_pengaduan`
  ADD PRIMARY KEY (`id_lampiran`),
  ADD KEY `id_pengaduan` (`id_pengaduan`);

--
-- Indeks untuk tabel `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD PRIMARY KEY (`id_notifikasi`),
  ADD KEY `id_pengguna` (`id_pengguna`),
  ADD KEY `id_pengaduan` (`id_pengaduan`);

--
-- Indeks untuk tabel `pengaduan`
--
ALTER TABLE `pengaduan`
  ADD PRIMARY KEY (`id_pengaduan`),
  ADD KEY `id_status` (`id_status`),
  ADD KEY `id_pelapor` (`id_pelapor`),
  ADD KEY `id_validator` (`id_validator`),
  ADD KEY `id_admin` (`id_admin`);

--
-- Indeks untuk tabel `pengguna`
--
ALTER TABLE `pengguna`
  ADD PRIMARY KEY (`id_pengguna`),
  ADD UNIQUE KEY `nama_lengkap` (`nama_lengkap`),
  ADD UNIQUE KEY `no_telp` (`no_telp`);

--
-- Indeks untuk tabel `riwayat_pengaduan`
--
ALTER TABLE `riwayat_pengaduan`
  ADD PRIMARY KEY (`id_riwayat`),
  ADD KEY `id_pengaduan` (`id_pengaduan`),
  ADD KEY `status_lama` (`status_lama`),
  ADD KEY `status_baru` (`status_baru`),
  ADD KEY `diubah_oleh` (`diubah_oleh`);

--
-- Indeks untuk tabel `status_pengaduan`
--
ALTER TABLE `status_pengaduan`
  ADD PRIMARY KEY (`id_status`);

--
-- AUTO_INCREMENT untuk tabel yang dibuang
--

--
-- AUTO_INCREMENT untuk tabel `komentar_pengaduan`
--
ALTER TABLE `komentar_pengaduan`
  MODIFY `id_komentar` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `lampiran_pengaduan`
--
ALTER TABLE `lampiran_pengaduan`
  MODIFY `id_lampiran` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `notifikasi`
--
ALTER TABLE `notifikasi`
  MODIFY `id_notifikasi` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `pengguna`
--
ALTER TABLE `pengguna`
  MODIFY `id_pengguna` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `riwayat_pengaduan`
--
ALTER TABLE `riwayat_pengaduan`
  MODIFY `id_riwayat` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT untuk tabel `status_pengaduan`
--
ALTER TABLE `status_pengaduan`
  MODIFY `id_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `komentar_pengaduan`
--
ALTER TABLE `komentar_pengaduan`
  ADD CONSTRAINT `komentar_pengaduan_ibfk_1` FOREIGN KEY (`id_pengaduan`) REFERENCES `pengaduan` (`id_pengaduan`),
  ADD CONSTRAINT `komentar_pengaduan_ibfk_2` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id_pengguna`);

--
-- Ketidakleluasaan untuk tabel `lampiran_pengaduan`
--
ALTER TABLE `lampiran_pengaduan`
  ADD CONSTRAINT `lampiran_pengaduan_ibfk_1` FOREIGN KEY (`id_pengaduan`) REFERENCES `pengaduan` (`id_pengaduan`);

--
-- Ketidakleluasaan untuk tabel `notifikasi`
--
ALTER TABLE `notifikasi`
  ADD CONSTRAINT `notifikasi_ibfk_1` FOREIGN KEY (`id_pengguna`) REFERENCES `pengguna` (`id_pengguna`),
  ADD CONSTRAINT `notifikasi_ibfk_2` FOREIGN KEY (`id_pengaduan`) REFERENCES `pengaduan` (`id_pengaduan`);

--
-- Ketidakleluasaan untuk tabel `pengaduan`
--
ALTER TABLE `pengaduan`
  ADD CONSTRAINT `pengaduan_ibfk_1` FOREIGN KEY (`id_status`) REFERENCES `status_pengaduan` (`id_status`),
  ADD CONSTRAINT `pengaduan_ibfk_2` FOREIGN KEY (`id_pelapor`) REFERENCES `pengguna` (`id_pengguna`),
  ADD CONSTRAINT `pengaduan_ibfk_3` FOREIGN KEY (`id_validator`) REFERENCES `pengguna` (`id_pengguna`),
  ADD CONSTRAINT `pengaduan_ibfk_4` FOREIGN KEY (`id_admin`) REFERENCES `pengguna` (`id_pengguna`);

--
-- Ketidakleluasaan untuk tabel `riwayat_pengaduan`
--
ALTER TABLE `riwayat_pengaduan`
  ADD CONSTRAINT `riwayat_pengaduan_ibfk_1` FOREIGN KEY (`id_pengaduan`) REFERENCES `pengaduan` (`id_pengaduan`),
  ADD CONSTRAINT `riwayat_pengaduan_ibfk_2` FOREIGN KEY (`status_lama`) REFERENCES `status_pengaduan` (`id_status`),
  ADD CONSTRAINT `riwayat_pengaduan_ibfk_3` FOREIGN KEY (`status_baru`) REFERENCES `status_pengaduan` (`id_status`),
  ADD CONSTRAINT `riwayat_pengaduan_ibfk_4` FOREIGN KEY (`diubah_oleh`) REFERENCES `pengguna` (`id_pengguna`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
