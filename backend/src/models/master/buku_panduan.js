const db = require('../../config/db');

const ModelPanduan = {
    // Ambil semua panduan (Untuk Dashboard ADMIN)
    getAll: async () => {
        const query = `
            SELECT p.*, u.nama_unit 
            FROM buku_panduan p
            JOIN unit_kerja u ON p.id_unit = u.id_unit
            ORDER BY u.nama_unit ASC, p.updated_at DESC
        `;
        return db.execute(query);
    },

    // Ambil panduan spesifik berdasarkan ID Unit yang sedang login (Untuk User)
    getByUnit: async (id_unit) => {
        const query = `
            SELECT p.*, u.nama_unit 
            FROM buku_panduan p
            JOIN unit_kerja u ON p.id_unit = u.id_unit
            WHERE p.id_unit = ?
            ORDER BY p.created_at ASC
        `;
        return db.execute(query, [id_unit]);
    },

    // Ambil 1 panduan untuk diedit oleh ADMIN
    getById: async (id_panduan) => {
        const query = `SELECT * FROM buku_panduan WHERE id_panduan = ?`;
        const [rows] = await db.execute(query, [id_panduan]);
        return rows[0];
    },

    // Simpan panduan baru
    create: async (data) => {
        const query = `
            INSERT INTO buku_panduan (id_unit, judul, konten, link_lampiran, created_by) 
            VALUES (?, ?, ?, ?, ?)
        `;
        return db.execute(query, data);
    },

    // Update panduan
    update: async (id_panduan, data) => {
        const query = `
            UPDATE buku_panduan 
            SET id_unit = ?, judul = ?, konten = ?, link_lampiran = ?, updated_by = ?
            WHERE id_panduan = ?
        `;
        return db.execute(query, [...data, id_panduan]);
    },

    // Hapus panduan
    delete: async (id_panduan) => {
        const query = `DELETE FROM buku_panduan WHERE id_panduan = ?`;
        return db.execute(query, [id_panduan]);
    }
};

module.exports = ModelPanduan;