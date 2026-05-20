const db = require('../../config/db');

const Model2c = {
    // Ambil semua data dengan join ke Prodi, Tahun, dan Bentuk Pembelajaran
    getAll: async (id_prodi, id_tahun) => {
        let sql = `
            SELECT t.*, p.nama_prodi, th.tahun, b.nama_bentuk 
            FROM \`2c_fleksibilitas_pembelajaran\` t
            JOIN prodi p ON t.id_prodi = p.id_prodi
            JOIN tahun_akademik th ON t.id_tahun = th.id_tahun
            JOIN master_bentuk_pembelajaran b ON t.id_bentuk = b.id_bentuk
            WHERE t.deleted_at IS NULL
        `;
        const params = [];
        if (id_prodi) { sql += " AND t.id_prodi = ?"; params.push(id_prodi); }
        if (id_tahun) { sql += " AND t.id_tahun = ?"; params.push(id_tahun); }
        
        sql += " ORDER BY th.tahun DESC, t.id_2c DESC";
        const [rows] = await db.execute(sql, params);
        return rows;
    },

    findById: async (id) => {
        const sql = `
            SELECT t.*, b.nama_bentuk 
            FROM \`2c_fleksibilitas_pembelajaran\` t
            JOIN master_bentuk_pembelajaran b ON t.id_bentuk = b.id_bentuk
            WHERE t.id_2c = ? AND t.deleted_at IS NULL
        `;
        const [rows] = await db.execute(sql, [id]);
        return rows[0];
    },

    findTrash: async (id_prodi) => {
        let sql = "SELECT * FROM \`2c_fleksibilitas_pembelajaran\` WHERE deleted_at IS NOT NULL";
        const params = [];
        if (id_prodi) { sql += " AND id_prodi = ?"; params.push(id_prodi); }
        const [rows] = await db.execute(sql, params);
        return rows;
    },

    create: async (data) => {
        const sql = `
            INSERT INTO \`2c_fleksibilitas_pembelajaran\` 
            (id_prodi, id_tahun, id_bentuk, jumlah_mhs, link_bukti, created_by) 
            VALUES (?, ?, ?, ?, ?, ?)
        `;
        return await db.execute(sql, [
            data.id_prodi, data.id_tahun, data.id_bentuk, 
            data.jumlah_mhs || 0, data.link_bukti, data.created_by
        ]);
    },

    update: async (id, data) => {
        const sql = `
            UPDATE \`2c_fleksibilitas_pembelajaran\` 
            SET id_prodi = ?, id_tahun = ?, id_bentuk = ?, jumlah_mhs = ?, link_bukti = ?, updated_by = ?
            WHERE id_2c = ?
        `;
        return await db.execute(sql, [
            data.id_prodi, data.id_tahun, data.id_bentuk, 
            data.jumlah_mhs, data.link_bukti, data.updated_by, id
        ]);
    },

    softDelete: async (id, deleted_by) => {
        const sql = "UPDATE \`2c_fleksibilitas_pembelajaran\` SET deleted_at = CURRENT_TIMESTAMP, deleted_by = ? WHERE id_2c = ?";
        return await db.execute(sql, [deleted_by, id]);
    },

    restore: async (id) => {
        const sql = "UPDATE \`2c_fleksibilitas_pembelajaran\` SET deleted_at = NULL, deleted_by = NULL WHERE id_2c = ?";
        return await db.execute(sql, [id]);
    },

    hardDelete: async (id) => {
        const sql = "DELETE FROM \`2c_fleksibilitas_pembelajaran\` WHERE id_2c = ?";
        return await db.execute(sql, [id]);
    }
};

module.exports = Model2c;
