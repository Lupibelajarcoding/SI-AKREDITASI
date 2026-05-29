const express = require('express');
const router = express.Router();
const panduanController = require('../../controllers/master/buku_panduan');
const { verifyToken, authorize } = require('../../middlewares/auth');
const { UNITS } = require('../../config/permissions');

// Semua rute di bawah wajib melampirkan JWT Token
router.use(verifyToken);

// ==========================================
// RUTE UNTUK SEMUA USER (Membaca Panduan)
// ==========================================

// User menarik data panduan miliknya sendiri berdasarkan id_unit
router.get('/unit/:id_unit', panduanController.showByUnit);


// ==========================================
// RUTE KHUSUS ADMIN (CRUD Panduan)
// ==========================================

// Kunci rute di bawah ini HANYA untuk ADMIN
router.use(authorize(UNITS.ADMIN));

router.get('/', panduanController.index);             // Lihat semua panduan lintas unit
router.get('/:id', panduanController.show);           // Ambil 1 data untuk form edit
router.post('/', panduanController.store);            // Simpan panduan baru
router.put('/:id', panduanController.update);         // Update panduan
router.delete('/:id', panduanController.destroy);     // Hapus panduan

module.exports = router;