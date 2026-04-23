const express = require('express');
const router = express.Router();
const profilLulusanController = require('../../controllers/master/profil_lulusan');

router.get('/', profilLulusanController.index);
router.get('/:id', profilLulusanController.show);
router.post('/', profilLulusanController.store);
router.put('/:id', profilLulusanController.update);
router.delete('/:id', profilLulusanController.destroy);

module.exports = router;
