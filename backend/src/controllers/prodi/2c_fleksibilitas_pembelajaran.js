const Model2c = require('../../models/prodi/2c_fleksibilitas_pembelajaran');
const Prodi = require('../../models/master/prodi');
const db = require('../../config/db');

const getAutoProdiId = async (req) => {
    try {
        if (!req.user) return null;
        if (req.user.nama_unit === 'ADMIN') {
            return (req.query ? req.query.id_prodi : null) || (req.body ? req.body.id_prodi : null);
        }
        const prodi = await Prodi.getByUnit(req.user.id_unit);
        return prodi ? prodi.id_prodi : null;
    } catch (err) { return null; }
};

// Fungsi Helper untuk Validasi Limit Mahasiswa
const validateMhsLimit = async (id_prodi, id_tahun, jumlah_input) => {
    const [mhsData] = await db.execute(`
        SELECT (aktif_reg_diterima + aktif_reg_afirmasi + aktif_reg_khusus + aktif_rpl_diterima + aktif_rpl_afirmasi + aktif_rpl_khusus) as total_aktif 
        FROM 2a1_data_mahasiswa 
        WHERE prodi_id_prodi = ? AND tahun_akademik_id_tahun = ?
    `, [id_prodi, id_tahun]);
    
    if (mhsData.length === 0) return { valid: true }; // Jika data 2A1 belum ada, lewatkan (atau bisa divalidasi harus isi 2A1 dulu)
    const limit = mhsData[0].total_aktif;
    if (parseInt(jumlah_input) > limit) {
        return { valid: false, limit };
    }
    return { valid: true };
};

const controller2c = {
    index: async (req, res) => {
        try {
            const id_prodi = await getAutoProdiId(req);
            const { id_tahun_ts } = req.query;
            const [tahunList] = await db.execute("SELECT id_tahun, tahun FROM tahun_akademik ORDER BY tahun DESC LIMIT 3");
            let tsHeaders = tahunList.reverse();
            if (id_tahun_ts && id_tahun_ts !== 'null' && id_tahun_ts !== '') {
                const [targetYear] = await db.execute("SELECT tahun FROM tahun_akademik WHERE id_tahun = ?", [id_tahun_ts]);
                if (targetYear.length > 0) {
                    const [list] = await db.execute("SELECT id_tahun, tahun FROM tahun_akademik WHERE tahun <= ? ORDER BY tahun DESC LIMIT 3", [targetYear[0].tahun]);
                    tsHeaders = list.reverse();
                }
            }
            let mhsAktif = [];
            if (id_prodi && tsHeaders.length > 0) {
                const idsTahun = tsHeaders.map(t => t.id_tahun).join(',');
                const [mhsData] = await db.execute(`
                    SELECT tahun_akademik_id_tahun as id_tahun, 
                    (aktif_reg_diterima + aktif_reg_afirmasi + aktif_reg_khusus + aktif_rpl_diterima + aktif_rpl_afirmasi + aktif_rpl_khusus) as total_aktif 
                    FROM 2a1_data_mahasiswa WHERE prodi_id_prodi = ? AND tahun_akademik_id_tahun IN (${idsTahun})
                `, [id_prodi]);
                mhsAktif = mhsData;
            }
            const rawData = await Model2c.getAll(id_prodi);
            const [masterBentuk] = await db.execute("SELECT id_bentuk, nama_bentuk FROM master_bentuk_pembelajaran ORDER BY id_bentuk ASC");
            const [masterProdi] = await db.execute("SELECT id_prodi, nama_prodi FROM prodi ORDER BY nama_prodi ASC");
            const [allTahun] = await db.execute("SELECT id_tahun, tahun FROM tahun_akademik ORDER BY tahun DESC");
            res.status(200).json({ success: true, data: rawData, borang: { tahunHeaders: tsHeaders, barisBentuk: masterBentuk, mhsAktif: mhsAktif }, master: { tahun: allTahun, prodi: masterProdi, bentuk: masterBentuk } });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    show: async (req, res) => { try { const data = await Model2c.findById(req.params.id); res.json({ success: true, data }); } catch (error) { res.status(500).json({ success: false, message: error.message }); } },
    trash: async (req, res) => { try { const id_prodi = await getAutoProdiId(req); const data = await Model2c.findTrash(id_prodi); res.status(200).json({ success: true, data }); } catch (error) { res.status(500).json({ success: false, message: error.message }); } },

    store: async (req, res) => {
        try {
            const id_prodi = await getAutoProdiId(req);
            const { id_tahun, jumlah_mhs } = req.body;
            
            // VALIDASI BACKEND: Cek limit vs 2.A.1
            const check = await validateMhsLimit(id_prodi, id_tahun, jumlah_mhs);
            if (!check.valid) {
                return res.status(400).json({ success: false, message: `Gagal! Jumlah mahasiswa (${jumlah_mhs}) melebihi total mahasiswa aktif (${check.limit}) di tabel 2.A.1.` });
            }

            const [result] = await Model2c.create({ ...req.body, id_prodi, created_by: req.user.id_user });
            res.status(201).json({ success: true, message: "Data berhasil disimpan", id: result.insertId });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    update: async (req, res) => {
        try {
            const id_prodi = await getAutoProdiId(req);
            const { id_tahun, jumlah_mhs } = req.body;

            // VALIDASI BACKEND: Cek limit vs 2.A.1
            const check = await validateMhsLimit(id_prodi, id_tahun, jumlah_mhs);
            if (!check.valid) {
                return res.status(400).json({ success: false, message: `Gagal! Jumlah mahasiswa (${jumlah_mhs}) melebihi total mahasiswa aktif (${check.limit}) di tabel 2.A.1.` });
            }

            await Model2c.update(req.params.id, { ...req.body, id_prodi, updated_by: req.user.id_user });
            res.status(200).json({ success: true, message: "Data diperbarui" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    destroy: async (req, res) => { try { await Model2c.softDelete(req.params.id, req.user.id_user); res.status(200).json({ success: true, message: "Data dihapus" }); } catch (error) { res.status(500).json({ success: false, message: error.message }); } },
    restore: async (req, res) => { try { await Model2c.restore(req.params.id); res.status(200).json({ success: true, message: "Data dipulihkan" }); } catch (error) { res.status(500).json({ success: false, message: error.message }); } },
    hardDestroy: async (req, res) => { try { await Model2c.hardDelete(req.params.id); res.status(200).json({ success: true, message: "Data dihapus permanen" }); } catch (error) { res.status(500).json({ success: false, message: error.message }); } },

    exportExcel: async (req, res) => {
        try {
            const id_prodi = await getAutoProdiId(req);
            const { id_tahun_ts } = req.query;
            const [tahunList] = await db.execute("SELECT id_tahun, tahun FROM tahun_akademik ORDER BY tahun DESC LIMIT 3");
            let tsHeaders = tahunList.reverse();
            if (id_tahun_ts && id_tahun_ts !== 'null' && id_tahun_ts !== '') {
                const [targetYear] = await db.execute("SELECT tahun FROM tahun_akademik WHERE id_tahun = ?", [id_tahun_ts]);
                if (targetYear.length > 0) {
                    const [list] = await db.execute("SELECT id_tahun, tahun FROM tahun_akademik WHERE tahun <= ? ORDER BY tahun DESC LIMIT 3", [targetYear[0].tahun]);
                    tsHeaders = list.reverse();
                }
            }
            const rawData = await Model2c.getAll(id_prodi);
            const [masterBentuk] = await db.execute("SELECT id_bentuk, nama_bentuk FROM master_bentuk_pembelajaran ORDER BY id_bentuk ASC");
            let mhsAktif = [];
            if (id_prodi && tsHeaders.length > 0) {
                const idsTahun = tsHeaders.map(t => t.id_tahun).join(',');
                const [mhsData] = await db.execute(`
                    SELECT tahun_akademik_id_tahun as id_tahun, 
                    (aktif_reg_diterima + aktif_reg_afirmasi + aktif_reg_khusus + aktif_rpl_diterima + aktif_rpl_afirmasi + aktif_rpl_khusus) as total_aktif 
                    FROM 2a1_data_mahasiswa WHERE prodi_id_prodi = ? AND tahun_akademik_id_tahun IN (${idsTahun})
                `, [id_prodi]);
                mhsAktif = mhsData;
            }

            const ExcelJS = require('exceljs');
            const workbook = new ExcelJS.Workbook();
            const worksheet = workbook.addWorksheet('Tabel 2.C');
            const greyFill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'D3D3D3' } };
            const yellowFill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'FFFF00' } };
            const borderStyle = { top: { style: 'thin' }, left: { style: 'thin' }, bottom: { style: 'thin' }, right: { style: 'thin' } };
            const centerStyle = { vertical: 'middle', horizontal: 'center' };

            worksheet.mergeCells('A1:E1');
            worksheet.getCell('A1').value = 'Tabel 2.C Fleksibilitas Dalam Proses Pembelajaran';
            worksheet.getCell('A1').font = { bold: true };
            worksheet.getCell('A1').alignment = centerStyle;

            worksheet.getCell('A2').value = 'Tahun Akademik';
            worksheet.getCell('A2').fill = greyFill; worksheet.getCell('A2').border = borderStyle; worksheet.getCell('A2').font = { bold: true };
            tsHeaders.forEach((th, idx) => {
                const label = (2-idx === 0) ? 'TS' : `TS-${2-idx}`;
                const cell = worksheet.getCell(2, 2 + idx);
                cell.value = `${th.tahun} (${label})`;
                cell.fill = greyFill; cell.border = borderStyle; cell.font = { bold: true }; cell.alignment = centerStyle;
            });
            worksheet.getCell('E2').value = 'Link Bukti';
            worksheet.getCell('E2').fill = greyFill; worksheet.getCell('E2').border = borderStyle; worksheet.getCell('E2').font = { bold: true }; worksheet.getCell('E2').alignment = centerStyle;

            let currentRow = 3;
            worksheet.getCell(`A${currentRow}`).value = 'Jumlah Mahasiswa Aktif';
            worksheet.getCell(`A${currentRow}`).border = borderStyle;
            tsHeaders.forEach((th, idx) => {
                const found = mhsAktif.find(m => m.id_tahun === th.id_tahun);
                const cell = worksheet.getCell(currentRow, 2 + idx);
                cell.value = found ? found.total_aktif : 0;
                cell.fill = yellowFill; cell.border = borderStyle; cell.alignment = centerStyle;
            });
            worksheet.getCell(`E${currentRow}`).fill = yellowFill; worksheet.getCell(`E${currentRow}`).border = borderStyle;
            currentRow++;

            worksheet.getCell(`A${currentRow}`).value = 'Bentuk Pembelajaran';
            worksheet.getCell(`A${currentRow}`).fill = greyFill; worksheet.getCell(`A${currentRow}`).border = borderStyle; worksheet.getCell(`A${currentRow}`).font = { bold: true };
            worksheet.mergeCells(`B${currentRow}:E${currentRow}`);
            worksheet.getCell(`B${currentRow}`).value = 'Jumlah mahasiswa untuk setiap bentuk pembelajaran';
            worksheet.getCell(`B${currentRow}`).fill = greyFill; worksheet.getCell(`B${currentRow}`).border = borderStyle;
            currentRow++;

            let totalPerTahun = tsHeaders.map(() => 0);
            masterBentuk.forEach(b => {
                worksheet.getCell(`A${currentRow}`).value = b.nama_bentuk;
                worksheet.getCell(`A${currentRow}`).border = borderStyle;
                tsHeaders.forEach((th, idx) => {
                    const found = rawData.find(d => d.id_bentuk === b.id_bentuk && d.id_tahun === th.id_tahun);
                    const val = found ? found.jumlah_mhs : 0;
                    const cell = worksheet.getCell(currentRow, 2 + idx);
                    cell.value = val; cell.fill = yellowFill; cell.border = borderStyle; cell.alignment = centerStyle;
                    totalPerTahun[idx] += val;
                });
                const linkFound = rawData.find(d => d.id_bentuk === b.id_bentuk);
                worksheet.getCell(`E${currentRow}`).value = linkFound ? linkFound.link_bukti : '-';
                worksheet.getCell(`E${currentRow}`).fill = yellowFill; worksheet.getCell(`E${currentRow}`).border = borderStyle;
                currentRow++;
            });

            worksheet.getCell(`A${currentRow}`).value = 'Jumlah';
            worksheet.getCell(`A${currentRow}`).fill = greyFill; worksheet.getCell(`A${currentRow}`).border = borderStyle; worksheet.getCell(`A${currentRow}`).font = { bold: true };
            totalPerTahun.forEach((val, idx) => {
                const cell = worksheet.getCell(currentRow, 2 + idx);
                cell.value = val; cell.fill = yellowFill; cell.border = borderStyle; cell.alignment = centerStyle; cell.font = { bold: true };
            });
            worksheet.getCell(`E${currentRow}`).fill = yellowFill; worksheet.getCell(`E${currentRow}`).border = borderStyle;
            currentRow++;

            worksheet.getCell(`A${currentRow}`).value = 'Persentase';
            worksheet.getCell(`A${currentRow}`).fill = greyFill; worksheet.getCell(`A${currentRow}`).border = borderStyle; worksheet.getCell(`A${currentRow}`).font = { bold: true };
            totalPerTahun.forEach((val, idx) => {
                const th = tsHeaders[idx];
                const active = mhsAktif.find(m => m.id_tahun === th.id_tahun);
                const pct = (active && active.total_aktif > 0) ? (val / active.total_aktif) : 0;
                const cell = worksheet.getCell(currentRow, 2 + idx);
                cell.value = pct; cell.numFmt = '0.00%'; cell.fill = yellowFill; cell.border = borderStyle; cell.alignment = centerStyle; cell.font = { bold: true };
            });
            worksheet.getCell(`E${currentRow}`).fill = yellowFill; worksheet.getCell(`E${currentRow}`).border = borderStyle;

            worksheet.getColumn(1).width = 45;
            worksheet.getColumn(2).width = 15; worksheet.getColumn(3).width = 15; worksheet.getColumn(4).width = 15; worksheet.getColumn(5).width = 30;

            res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            res.setHeader('Content-Disposition', 'attachment; filename=Borang_2C_Fleksibilitas.xlsx');
            await workbook.xlsx.write(res); res.end();
        } catch (error) { res.status(500).send(error.message); }
    }
};

module.exports = controller2c;
