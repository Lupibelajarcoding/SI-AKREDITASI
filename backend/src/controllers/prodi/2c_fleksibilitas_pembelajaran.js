const Model2c = require('../../models/prodi/2c_fleksibilitas_pembelajaran');

const controller2c = {
    index: async (req, res) => {
        try {
            const { id_prodi, id_tahun } = req.query;
            if (!id_prodi || !id_tahun) {
                return res.status(400).json({ success: false, message: "id_prodi dan id_tahun wajib diisi" });
            }

            const result = await Model2c.findMatrix(id_prodi, id_tahun);
            
            // Kalkulasi Summary per Tahun (Total Mhs Bentuk, Total Mhs Aktif, % Total)
            const summary = result.years.map(y => {
                const totalMhsBentuk = result.rows.reduce((sum, row) => sum + (row.values[y.id_tahun] || 0), 0);
                const mhsAktifObj = result.mhs_aktif.find(m => m.id_tahun == y.id_tahun);
                const totalMhsAktif = mhsAktifObj ? mhsAktifObj.total : 0;
                const persentase = totalMhsAktif > 0 ? ((totalMhsBentuk / totalMhsAktif) * 100).toFixed(2) : "0.00";

                return {
                    id_tahun: y.id_tahun,
                    tahun: y.tahun,
                    total_mhs_bentuk: totalMhsBentuk,
                    total_mhs_aktif: totalMhsAktif,
                    persentase: persentase + "%"
                };
            });

            res.status(200).json({ 
                success: true, 
                data: result.rows,
                years: result.years,
                summary: summary
            });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    show: async (req, res) => {
        try {
            const data = await Model2c.findById(req.params.id);
            if (!data) return res.status(404).json({ success: false, message: "Data tidak ditemukan" });
            res.status(200).json({ success: true, data });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    trash: async (req, res) => {
        try {
            const data = await Model2c.findTrash(req.query.id_prodi);
            res.status(200).json({ success: true, data });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    store: async (req, res) => {
        try {
            const { id_prodi, id_tahun, details } = req.body;
            
            if (details && Array.isArray(details)) {
                // Batch Upsert Mode (dari test-2c.html)
                await Model2c.batchUpsert(id_prodi, details, req.user.id_user);
                return res.status(201).json({ 
                    success: true, 
                    message: "Seluruh data Fleksibilitas Pembelajaran (2.C) berhasil diperbarui secara massal." 
                });
            } else {
                // Single Create Mode
                const [result] = await Model2c.create({ ...req.body, created_by: req.user.id_user });
                return res.status(201).json({ 
                    success: true, 
                    message: "Data Fleksibilitas Pembelajaran (2.C) berhasil disimpan",
                    id_2c: result.insertId 
                });
            }
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    update: async (req, res) => {
        try {
            await Model2c.update(req.params.id, { ...req.body, updated_by: req.user.id_user });
            res.status(200).json({ success: true, message: "Data Fleksibilitas (2.C) diperbarui" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    destroy: async (req, res) => {
        try {
            await Model2c.softDelete(req.params.id, req.user.id_user);
            res.status(200).json({ success: true, message: "Data dipindahkan ke sampah" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    restore: async (req, res) => {
        try {
            await Model2c.restore(req.params.id);
            res.status(200).json({ success: true, message: "Data dipulihkan" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    hardDestroy: async (req, res) => {
        try {
            await Model2c.hardDelete(req.params.id);
            res.status(200).json({ success: true, message: "Data dihapus permanen" });
        } catch (error) { res.status(500).json({ success: false, message: error.message }); }
    },

    exportExcel: async (req, res) => {
        try {
            const { id_prodi, id_tahun } = req.query;
            const result = await Model2c.findMatrix(id_prodi, id_tahun);
            
            // Hitung Summary per Tahun
            const summary = result.years.map(y => {
                const totalMhsBentuk = result.rows.reduce((sum, row) => sum + (row.values[y.id_tahun] || 0), 0);
                const mhsAktifObj = result.mhs_aktif.find(m => m.id_tahun == y.id_tahun);
                const totalMhsAktif = mhsAktifObj ? mhsAktifObj.total : 0;
                const persentase = totalMhsAktif > 0 ? ((totalMhsBentuk / totalMhsAktif) * 100).toFixed(2) : "0.00";
                return { totalMhsBentuk, totalMhsAktif, persentase };
            });

            const ExcelJS = require('exceljs');
            const workbook = new ExcelJS.Workbook();
            const worksheet = workbook.addWorksheet('2.C Fleksibilitas');

            // 1. Judul
            worksheet.mergeCells(`A1:${String.fromCharCode(65 + result.years.length + 1)}1`);
            worksheet.getCell('A1').value = 'Tabel 2.c Fleksibilitas Dalam Proses Pembelajaran';
            worksheet.getCell('A1').font = { bold: true, size: 12 };
            worksheet.getCell('A1').alignment = { horizontal: 'center' };

            // 2. Header
            const hRow = worksheet.getRow(3);
            const headers = ['Tahun Akademik', ...result.years.map(y => `${y.label} (${y.tahun})`), 'Link Bukti'];
            hRow.values = headers;
            hRow.eachCell(c => {
                c.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'D9D9D9' } };
                c.font = { bold: true };
                c.border = { top:{style:'thin'}, left:{style:'thin'}, bottom:{style:'thin'}, right:{style:'thin'} };
                c.alignment = { horizontal: 'center', vertical: 'middle' };
            });

            // 3. Baris Mahasiswa Aktif
            const mRow = worksheet.getRow(4);
            mRow.values = ['Jumlah Mahasiswa Aktif', ...summary.map(s => s.totalMhsAktif), ''];
            mRow.eachCell(c => {
                c.font = { bold: true };
                c.border = { top:{style:'thin'}, left:{style:'thin'}, bottom:{style:'thin'}, right:{style:'thin'} };
            });

            // 4. Baris Judul Tengah
            const midRow = worksheet.getRow(5);
            midRow.values = ['Bentuk Pembelajaran', 'Jumlah mahasiswa untuk setiap bentuk pembelajaran', '', '', ''];
            worksheet.mergeCells(`B5:${String.fromCharCode(65 + result.years.length)}5`);
            midRow.eachCell(c => {
                c.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'F2F2F2' } };
                c.font = { bold: true, italic: true, size: 9 };
                c.alignment = { horizontal: 'center' };
                c.border = { top:{style:'thin'}, left:{style:'thin'}, bottom:{style:'thin'}, right:{style:'thin'} };
            });

            // 5. Data Kuning
            result.rows.forEach((item, idx) => {
                const row = worksheet.addRow([
                    item.nama_bentuk,
                    ...result.years.map(y => item.values[y.id_tahun] || 0),
                    item.link_bukti || ''
                ]);
                row.eachCell((c, colIdx) => {
                    if (colIdx > 1) c.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'FFFF99' } }; // Kuning
                    c.border = { top:{style:'thin'}, left:{style:'thin'}, bottom:{style:'thin'}, right:{style:'thin'} };
                    c.alignment = { horizontal: 'center' };
                });
            });

            // 6. Summary Footer
            const sumRow = worksheet.addRow(['Jumlah', ...summary.map(s => s.totalMhsBentuk), '']);
            const perRow = worksheet.addRow(['Persentase (%)', ...summary.map(s => s.persentase + '%'), '']);
            
            [sumRow, perRow].forEach(row => {
                row.eachCell(c => {
                    c.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'D9D9D9' } };
                    c.font = { bold: true };
                    c.border = { top:{style:'thin'}, left:{style:'thin'}, bottom:{style:'thin'}, right:{style:'thin'} };
                    c.alignment = { horizontal: 'center' };
                });
            });

            worksheet.columns = [{width: 30}, {width: 15}, {width: 15}, {width: 15}, {width: 30}];

            res.setHeader('Content-Type', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
            res.setHeader('Content-Disposition', `attachment; filename=Tabel_2C_Matrix.xlsx`);
            await workbook.xlsx.write(res);
            res.end();
        } catch (error) { res.status(500).send(error.message); }
    }

};

module.exports = controller2c;
