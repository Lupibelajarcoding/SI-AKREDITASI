const ModelPanduan = require('../../models/master/buku_panduan');

const PanduanController = {
    // ADMIN: Melihat semua panduan
    index: async (req, res) => {
        try {
            const [rows] = await ModelPanduan.getAll();
            res.json({ success: true, data: rows });
        } catch (err) {
            res.status(500).json({ success: false, message: err.message });
        }
    },

    // USER: Melihat panduan miliknya sendiri berdasarkan id_unit di token
    showByUnit: async (req, res) => {
        try {
            // id_unit diambil dari parameter, tapi frontend harus mengirimkan id_unit dari session login
            const { id_unit } = req.params;
            const [rows] = await ModelPanduan.getByUnit(id_unit);
            res.json({ success: true, data: rows });
        } catch (err) {
            res.status(500).json({ success: false, message: err.message });
        }
    },

    // ADMIN: Tambah panduan baru
    store: async (req, res) => {
        try {
            const { id_unit, judul, konten, link_lampiran } = req.body;
            const user_id = req.user.id_user; // Dari verifyToken middleware

            if (!id_unit || !judul || !konten) {
                return res.status(400).json({ success: false, message: "ID Unit, Judul, dan Konten wajib diisi!" });
            }

            await ModelPanduan.create([id_unit, judul, konten, link_lampiran || null, user_id]);
            res.status(201).json({ success: true, message: "Buku Panduan berhasil ditambahkan." });
        } catch (err) {
            res.status(500).json({ success: false, message: err.message });
        }
    },

    // ADMIN: Detail 1 panduan untuk form edit
    show: async (req, res) => {
        try {
            const panduan = await ModelPanduan.getById(req.params.id);
            if (!panduan) return res.status(404).json({ success: false, message: "Panduan tidak ditemukan." });
            res.json({ success: true, data: panduan });
        } catch (err) {
            res.status(500).json({ success: false, message: err.message });
        }
    },

    // ADMIN: Update panduan
    update: async (req, res) => {
        try {
            const { id_unit, judul, konten, link_lampiran } = req.body;
            const user_id = req.user.id_user;

            await ModelPanduan.update(req.params.id, [id_unit, judul, konten, link_lampiran || null, user_id]);
            res.json({ success: true, message: "Buku Panduan berhasil diperbarui." });
        } catch (err) {
            res.status(500).json({ success: false, message: err.message });
        }
    },

    // ADMIN: Hapus panduan
    destroy: async (req, res) => {
        try {
            await ModelPanduan.delete(req.params.id);
            res.json({ success: true, message: "Buku Panduan berhasil dihapus." });
        } catch (err) {
            res.status(500).json({ success: false, message: err.message });
        }
    }
};

module.exports = PanduanController;