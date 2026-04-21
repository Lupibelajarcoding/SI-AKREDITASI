const Model2b5 = require('../../models/kemahasiswaan/2b5_kesesuaian_kerja');
const ExcelJS = require('exceljs');

const controller2b5 = {
    // 1. Tampil Data Aktif
    index: async (req, res) => {
        try {
            const { id_prodi, id_tahun } = req.query;
            const data = await Model2b5.findAllRange(id_prodi, id_tahun);
            res.status(200).json({ success: true, data });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 2. Tampil Data Sampah
    trash: async (req, res) => {
        try {
            const { id_prodi } = req.query;
            const data = await Model2b5.findTrash(id_prodi);
            res.status(200).json({ success: true, data });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 3. Simpan Data
    store: async (req, res) => {
        try {
            await Model2b5.create({ ...req.body, created_by: req.user.id_user });
            res.status(201).json({ success: true, message: "Data Kesesuaian Kerja berhasil disimpan" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 4. Update Data
    update: async (req, res) => {
        try {
            await Model2b5.update(req.params.id, { ...req.body, updated_by: req.user.id_user });
            res.status(200).json({ success: true, message: "Data Kesesuaian Kerja diperbarui" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 5. Soft Delete
    destroy: async (req, res) => {
        try {
            await Model2b5.softDelete(req.params.id, req.user.id_user);
            res.status(200).json({ success: true, message: "Data dipindahkan ke sampah" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 6. Restore Data
    restore: async (req, res) => {
        try {
            await Model2b5.restore(req.params.id);
            res.status(200).json({ success: true, message: "Data berhasil dipulihkan" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 7. Hard Delete
    hardDestroy: async (req, res) => {
        try {
            await Model2b5.hardDelete(req.params.id);
            res.status(200).json({ success: true, message: "Data dihapus permanen" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    // 8. Ekspor Excel
    exportExcel: async (req, res) => {
        try {
            const { id_prodi, id_tahun } = req.query;
            const data = await Model2b5.findAllRange(id_prodi, id_tahun);
            const workbook = new ExcelJS.Workbook();
            const worksheet = workbook.addWorksheet('2.B.5 Kesesuaian Kerja');

            worksheet.mergeCells('A1:H1');
            worksheet.getCell('A1').value = 'Tabel 2.B.5 Kesesuaian Bidang Kerja Lulusan';
            worksheet.getCell('A1').font = { bold: true };
            worksheet.getCell('A1').alignment = { horizontal: 'center' };

            // Header Bertingkat
            worksheet.mergeCells('A2:A3'); worksheet.getCell('A2').value = 'Tahun Lulus';
            worksheet.mergeCells('B2:B3'); worksheet.getCell('B2').value = 'Jumlah Lulusan';
            worksheet.mergeCells('C2:C3'); worksheet.getCell('C2').value = 'Lulusan Terlacak';
            worksheet.mergeCells('D2:D3'); worksheet.getCell('D2').value = 'Profesi Kerja Bidang Infokom';
            worksheet.mergeCells('E2:E3'); worksheet.getCell('E2').value = 'Profesi Kerja Bidang NON Infokom';
            worksheet.mergeCells('F2:H2'); worksheet.getCell('F2').value = 'Lingkup Tempat Kerja';
            
            const h3 = worksheet.getRow(3);
            h3.values = ['', '', '', '', '', 'Multinasional/ Internasional', 'Nasional', 'Wirausaha'];

            [2,3].forEach(rowIdx => {
                worksheet.getRow(rowIdx).eachCell(c => {
                    c.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'BFBFBF' } };
                    c.border = { top:{style:'thin'}, left:{style:'thin'}, bottom:{style:'thin'}, right:{style:'thin'} };
                    c.alignment = { horizontal: 'center', vertical: 'middle', wrapText: true };
                    c.font = { bold: true, size: 9 };
                });
            });

            data.forEach(item => {
                const r = worksheet.addRow([
                    item.nama_tahun, item.jumlah_lulusan, item.jumlah_terlacak,
                    item.profesi_infokom, item.profesi_non_infokom,
                    item.lingkup_multinasional, item.lingkup_nasional, item.lingkup_wirausaha
                ]);
                r.eachCell(c => {
                    c.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'FFFF00' } };
                    c.border = { top:{style:'thin'}, left:{style:'thin'}, bottom:{style:'thin'}, right:{style:'thin'} };
                    c.alignment = { horizontal: 'center' };
                });
            });

            worksheet.columns = [
                { width: 12 }, { width: 12 }, { width: 12 }, { width: 15 }, 
                { width: 15 }, { width: 15 }, { width: 15 }, { width: 15 }
            ];

            res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            res.setHeader('Content-Disposition', 'attachment; filename=Tabel_2B5_Kesesuaian_Kerja.xlsx');
            await workbook.xlsx.write(res);
            res.end();
        } catch (error) { res.status(500).send(error.message); }
    }
};

module.exports = controller2b5;