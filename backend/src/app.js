const express = require('express');
const cors = require('cors');
require('dotenv').config();

// 1. Import Routes (IKU: Pengembangan RESTful API)
const authRoutes = require('./routes/authRoutes');

// Import Routes Master
const pegawaiRoutes = require('./routes/master/pegawaiRoutes');
const dosenRoutes = require('./routes/master/dosenRoutes');
const tendikRoutes = require('./routes/master/tendikRoutes');
const userRoutes = require('./routes/master/userRoutes');
const prodiRoutes = require('./routes/master/prodiRoutes');
const tahunAkademikRoutes = require('./routes/master/tahunAkademikRoutes');

// Import Routes Upps
const route1a1 = require('./routes/upps/1a1_pimpinan_dan_tupoksi');
const route1a4 = require('./routes/upps/1a4_beban_dtpr');
const route3a3 = require('./routes/upps/3a3_pengembangan_dtpr');
const route6 = require('./routes/upps/6_visi_misi');

// import Routes Tpm
const route1b = require('./routes/tpm/1b_unit_spmi');
const app = express();

//import Routes Keuangan
const route1a2 = require('./routes/keuangan/1a2_sumber_pendanaan');
const route1a3 = require('./routes/keuangan/1a3_penggunaan_dana');

//import Routes Kepegawaian
const route1a5 = require('./routes/kepegawaian/1a5_tendik');

//import Routes Sarpras
const route3a1 = require('./routes/sarpras/3a1_sarana_prasarana');
const route4a1 = require('./routes/sarpras/4a1_sarana_prasarana');
const route5_2 = require('./routes/sarpras/5_2_sarana_prasarana');

// 2. Middleware Global
app.use(cors()); 
app.use(express.json()); 

// 3. Definisi Route Utama
app.use('/api/auth', authRoutes);

// Master Routes
app.use('/api/master/pegawai', pegawaiRoutes);
app.use('/api/master/dosen', dosenRoutes);
app.use('/api/master/tendik', tendikRoutes);
app.use('/api/master/users', userRoutes);
app.use('/api/master/prodi', prodiRoutes);
app.use('/api/master/tahun-akademik', tahunAkademikRoutes);

// Routes Upps
app.use('/api/upps/1a1-pimpinan', route1a1); 
app.use('/api/upps/1a4-beban', route1a4);
app.use('/api/upps/3a3-pengembangan', route3a3);
app.use('/api/upps/6-visi-misi', route6);

// Routes Tpm
app.use('/api/tpm/1b-spmi', route1b);

// Routes Keuangan
app.use('/api/keuangan/1a2-sumber-pendanaan', route1a2);
app.use('/api/keuangan/1a3-penggunaan-dana', route1a3);

// Routes Kepegawaian
app.use('/api/kepegawaian/1a5-tendik', route1a5);

// Routes Sarpras
app.use('/api/sarpras/3a1-sarana-prasarana', route3a1);
app.use('/api/sarpras/4a1-sarana-prasarana-pkm', route4a1);
app.use('/api/sarpras/5-2-sarana-prasarana', route5_2);

// 4. Root Endpoint (Checking Status)
app.get('/', (req, res) => {
    res.json({
        success: true,
        message: 'API Sistem Akreditasi STIKOM PGRI Banyuwangi - Online',
        version: '2.1 (LAM INFOKOM)'
    });
});

// 5. Global Error Handling (IKU: Error Handling yang Informatif)
app.use((err, req, res, next) => {
    console.error(`[Error]: ${err.message}`);
    res.status(err.status || 500).json({ 
        success: false, 
        message: err.message || 'Terjadi kesalahan internal pada server.'
    });
});

// 6. Menjalankan Server
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => {
    console.log(`🚀 Server berjalan di port ${PORT}`);
    console.log(`✅ Auth: http://localhost:${PORT}/api/auth/login`);
});