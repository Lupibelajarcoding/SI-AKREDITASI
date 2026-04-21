const express = require('express');
const router = express.Router();
const controller2b5 = require('../../controllers/kemahasiswaan/2b5_kesesuaian_kerja');
const { verifyToken, authorize } = require('../../middlewares/auth');

router.use(verifyToken, authorize('MHS', 'ADMIN'));

// --- CRUD Aktif ---
router.get('/', controller2b5.index);
router.post('/', controller2b5.store);
router.put('/:id', controller2b5.update);
router.delete('/:id', controller2b5.destroy);

// --- Trash & Maintenance (Sesuai Standar) ---
router.post('/restore/:id', controller2b5.restore);
router.delete('/hard/:id', controller2b5.hardDestroy);

// --- Export ---
router.get('/export', controller2b5.exportExcel);

module.exports = router;