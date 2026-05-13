const express = require('express');
const router = express.Router();
const controllerBentuk = require('../../controllers/master/bentuk_pembelajaran');
const { verifyToken, authorize } = require('../../middlewares/auth');

router.use(verifyToken, authorize('ADMIN')); // Hanya admin yang boleh edit master

router.get('/', controllerBentuk.index);
router.get('/:id', controllerBentuk.show);
router.post('/', controllerBentuk.store);
router.put('/:id', controllerBentuk.update);
router.delete('/:id', controllerBentuk.destroy);

module.exports = router;
