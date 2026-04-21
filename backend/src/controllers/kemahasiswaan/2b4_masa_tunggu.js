const Model2b4 = require('../../models/kemahasiswaan/2b4_masa_tunggu');
const ExcelJS = require('exceljs');

const controller2b4 = {
    // 1. Tampil Data Aktif
    index: async (req, res) => {
        try {
            const { id_prodi, id_tahun } = req.query;
            const data = await Model2b4.findAllRange(id_prodi, id_tahun);
            res.status(200).json({ success: true, data });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 2. Tampil Data Sampah
    trash: async (req, res) => {
        try {
            const { id_prodi } = req.query;
            const data = await Model2b4.findTrash(id_prodi);
            res.status(200).json({ success: true, data });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 3. Simpan Data Baru
    store: async (req, res) => {
        try {
            const [result] = await Model2b4.create({ ...req.body, created_by: req.user.id_user });
            res.status(201).json({ 
                success: true, 
                message: "Data Masa Tunggu berhasil disimpan",
                id_2b4: result.insertId 
            });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 4. Update Data
    update: async (req, res) => {
        try {
            await Model2b4.update(req.params.id, { ...req.body, updated_by: req.user.id_user });
            res.status(200).json({ success: true, message: "Data Masa Tunggu diperbarui" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 5. Soft Delete (Pindah ke Sampah)
    destroy: async (req, res) => {
        try {
            await Model2b4.softDelete(req.params.id, req.user.id_user);
            res.status(200).json({ success: true, message: "Data dipindahkan ke tempat sampah" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 6. Restore Data
    restore: async (req, res) => {
        try {
            await Model2b4.restore(req.params.id);
            res.status(200).json({ success: true, message: "Data berhasil dipulihkan" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 7. Hard Delete
    hardDestroy: async (req, res) => {
        try {
            await Model2b4.hardDelete(req.params.id);
            res.status(200).json({ success: true, message: "Data dihapus permanen" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 8. Ekspor Excel
    exportExcel: async (req, res) => {
        try {
            const { id_prodi, id_tahun } = req.query;
            const data = await Model2b4.findAllRange(id_prodi, id_tahun);
            const workbook = new ExcelJS.Workbook();
            const worksheet = workbook.addWorksheet('2.B.4');

            worksheet.mergeCells('A1:D1');
            worksheet.getCell('A1').value = 'Tabel 2.B.4 Rata-rata Masa Tunggu Lulusan';
            worksheet.getCell('A1').font = { bold: true };
            worksheet.getCell('A1').alignment = { horizontal: 'center' };

            const hRow = worksheet.getRow(2);
            hRow.values = ['Tahun Lulus', 'Jumlah Lulusan', 'Jumlah Terlacak', 'Rata-rata Waktu Tunggu (Bulan)'];
            hRow.eachCell(c => {
                c.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'BFBFBF' } };
                c.font = { bold: true };
                c.border = { top:{style:'thin'}, left:{style:'thin'}, bottom:{style:'thin'}, right:{style:'thin'} };
                c.alignment = { horizontal: 'center' };
            });

            data.forEach(item => {
                const r = worksheet.addRow([item.nama_tahun, item.jumlah_lulusan, item.jumlah_terlacak, item.rata_tunggu]);
                r.eachCell(c => {
                    c.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'FFFF00' } };
                    c.border = { top:{style:'thin'}, left:{style:'thin'}, bottom:{style:'thin'}, right:{style:'thin'} };
                });
            });

            res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            res.setHeader('Content-Disposition', 'attachment; filename=Tabel_2B4_Full.xlsx');
            await workbook.xlsx.write(res);
            res.end();
        } catch (error) { res.status(500).send(error.message); }
    }
};

module.exports = controller2b4;