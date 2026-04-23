const express = require('express');
const router = express.Router();
const pemetaanCplPl2B2Controller = require('../../controllers/prodi/2b2_pemetaan_cpl_pl');

router.get('/', pemetaanCplPl2B2Controller.index);
router.get('/:id', pemetaanCplPl2B2Controller.show);
router.post('/', pemetaanCplPl2B2Controller.store);
router.put('/:id', pemetaanCplPl2B2Controller.update);
router.delete('/:id', pemetaanCplPl2B2Controller.destroy);

module.exports = router;
