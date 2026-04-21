const db = require('../../config/db');

/**
 * Model Tabel 2.B.4 Rata-rata Masa Tunggu Lulusan
 * Berfungsi sebagai Master Transaksi Alumni untuk Tabel 2.B.5
 */
const Model2b4 = {
    // 1. Ambil data aktif dalam rentang TS, TS-1, TS-2
    findAllRange: async (id_prodi, id_tahun) => {
        const sql = `
            SELECT 
                m.*, 
                t.tahun AS nama_tahun
            FROM \`2b4_masa_tunggu\` m
            JOIN tahun_akademik t ON m.id_tahun = t.id_tahun
            WHERE m.id_prodi = ? 
            AND m.id_tahun BETWEEN (? - 2) AND ? 
            AND m.deleted_at IS NULL
            ORDER BY m.id_tahun DESC
        `;
        const [rows] = await db.execute(sql, [id_prodi, id_tahun, id_tahun]);
        return rows;
    },

    // 2. Ambil data di tempat sampah
    findTrash: async (id_prodi) => {
        const sql = `
            SELECT m.*, t.tahun AS nama_tahun
            FROM \`2b4_masa_tunggu\` m
            JOIN tahun_akademik t ON m.id_tahun = t.id_tahun
            WHERE m.id_prodi = ? AND m.deleted_at IS NOT NULL
            ORDER BY m.deleted_at DESC
        `;
        const [rows] = await db.execute(sql, [id_prodi]);
        return rows;
    },

    // 3. Tambah Data Baru
    create: async (data) => {
        const sql = `INSERT INTO \`2b4_masa_tunggu\` 
            (id_prodi, id_tahun, jumlah_lulusan, jumlah_terlacak, rata_tunggu, created_by) 
            VALUES (?, ?, ?, ?, ?, ?)`;
        return await db.execute(sql, [
            data.id_prodi, data.id_tahun, data.jumlah_lulusan, 
            data.jumlah_terlacak, data.rata_tunggu, data.created_by
        ]);
    },

    // 4. Update Data
    update: async (id, data) => {
        const sql = `UPDATE \`2b4_masa_tunggu\` 
            SET jumlah_lulusan = ?, jumlah_terlacak = ?, rata_tunggu = ?, updated_by = ? 
            WHERE id_2b4 = ?`;
        return await db.execute(sql, [
            data.jumlah_lulusan, data.jumlah_terlacak, data.rata_tunggu, data.updated_by, id
        ]);
    },

    // 5. Fungsi Utility: Cari ID berdasarkan prodi dan tahun (untuk sinkronisasi 2B5)
    findByProdiTahun: async (id_prodi, id_tahun) => {
        const sql = "SELECT id_2b4 FROM `2b4_masa_tunggu` WHERE id_prodi = ? AND id_tahun = ? AND deleted_at IS NULL LIMIT 1";
        const [rows] = await db.execute(sql, [id_prodi, id_tahun]);
        return rows[0];
    },

    softDelete: async (id, deleted_by) => {
        const sql = "UPDATE `2b4_masa_tunggu` SET deleted_at = CURRENT_TIMESTAMP, deleted_by = ? WHERE id_2b4 = ?";
        return await db.execute(sql, [deleted_by, id]);
    },

    restore: async (id) => {
        const sql = "UPDATE `2b4_masa_tunggu` SET deleted_at = NULL, deleted_by = NULL WHERE id_2b4 = ?";
        return await db.execute(sql, [id]);
    },

    hardDelete: async (id) => {
        const sql = "DELETE FROM `2b4_masa_tunggu` WHERE id_2b4 = ?";
        return await db.execute(sql, [id]);
    }
};

module.exports = Model2b4;