const express = require('express');
const router = express.Router();
const petaPemenuhanCpl2B3Controller = require('../../controllers/prodi/2b3_peta_pemenuhan_cpl');

router.get('/', petaPemenuhanCpl2B3Controller.index);
router.get('/:id', petaPemenuhanCpl2B3Controller.show);
router.post('/', petaPemenuhanCpl2B3Controller.store);
router.put('/:id', petaPemenuhanCpl2B3Controller.update);
router.delete('/:id', petaPemenuhanCpl2B3Controller.destroy);

module.exports = router;
