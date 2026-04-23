const express = require('express');
const router = express.Router();
const cpmkController = require('../../controllers/master/cpmk');

router.get('/', cpmkController.index);
router.get('/:id', cpmkController.show);
router.post('/', cpmkController.store);
router.put('/:id', cpmkController.update);
router.delete('/:id', cpmkController.destroy);

module.exports = router;
