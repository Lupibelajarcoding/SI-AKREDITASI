const db = require('../../config/db');

/**
 * Model Tabel 2.B.5 Kesesuaian Bidang Kerja Lulusan
 */
const Model2b5 = {
    // 1. Ambil data aktif
    findAllRange: async (id_prodi, id_tahun) => {
        const sql = `
            SELECT k.*, m.id_tahun, t.tahun AS nama_tahun, m.jumlah_lulusan, m.jumlah_terlacak
            FROM \`2b5_kesesuaian_kerja\` k
            JOIN \`2b4_masa_tunggu\` m ON k.id_2b4 = m.id_2b4
            JOIN tahun_akademik t ON m.id_tahun = t.id_tahun
            WHERE m.id_prodi = ? AND m.id_tahun BETWEEN (? - 2) AND ? AND k.deleted_at IS NULL
            ORDER BY m.id_tahun DESC
        `;
        const [rows] = await db.execute(sql, [id_prodi, id_tahun, id_tahun]);
        return rows;
    },

    // 2. Ambil data di tempat sampah
    findTrash: async (id_prodi) => {
        const sql = `
            SELECT k.*, t.tahun AS nama_tahun
            FROM \`2b5_kesesuaian_kerja\` k
            JOIN \`2b4_masa_tunggu\` m ON k.id_2b4 = m.id_2b4
            JOIN tahun_akademik t ON m.id_tahun = t.id_tahun
            WHERE m.id_prodi = ? AND k.deleted_at IS NOT NULL
            ORDER BY k.deleted_at DESC
        `;
        const [rows] = await db.execute(sql, [id_prodi]);
        return rows;
    },

    create: async (data) => {
        const sql = `INSERT INTO \`2b5_kesesuaian_kerja\` 
            (id_2b4, profesi_infokom, profesi_non_infokom, lingkup_multinasional, 
             lingkup_nasional, lingkup_wirausaha, created_by) 
            VALUES (?, ?, ?, ?, ?, ?, ?)`;
        return await db.execute(sql, [
            data.id_2b4, data.profesi_infokom, data.profesi_non_infokom, 
            data.lingkup_multinasional, data.lingkup_nasional, 
            data.lingkup_wirausaha, data.created_by
        ]);
    },

    update: async (id, data) => {
        const sql = `UPDATE \`2b5_kesesuaian_kerja\` 
            SET profesi_infokom = ?, profesi_non_infokom = ?, 
                lingkup_multinasional = ?, lingkup_nasional = ?, 
                lingkup_wirausaha = ?, updated_by = ? 
            WHERE id_2b5 = ?`;
        return await db.execute(sql, [
            data.profesi_infokom, data.profesi_non_infokom, 
            data.lingkup_multinasional, data.lingkup_nasional, 
            data.lingkup_wirausaha, data.updated_by, id
        ]);
    },

    softDelete: async (id, deleted_by) => {
        const sql = "UPDATE `2b5_kesesuaian_kerja` SET deleted_at = CURRENT_TIMESTAMP, deleted_by = ? WHERE id_2b5 = ?";
        return await db.execute(sql, [deleted_by, id]);
    },

    restore: async (id) => {
        const sql = "UPDATE `2b5_kesesuaian_kerja` SET deleted_at = NULL, deleted_by = NULL WHERE id_2b5 = ?";
        return await db.execute(sql, [id]);
    },

    hardDelete: async (id) => {
        const sql = "DELETE FROM `2b5_kesesuaian_kerja` WHERE id_2b5 = ?";
        return await db.execute(sql, [id]);
    }
};

module.exports = Model2b5;