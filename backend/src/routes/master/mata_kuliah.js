const express = require('express');
const router = express.Router();
const mataKuliahController = require('../../controllers/master/mata_kuliah');

router.get('/', mataKuliahController.index);
router.get('/:id', mataKuliahController.show);
router.post('/', mataKuliahController.store);
router.put('/:id', mataKuliahController.update);
router.delete('/:id', mataKuliahController.destroy);

module.exports = router;
