<%-- 
    Document   : tiket
    Created on : 22 May 2026, 14.59.49
    Author     : ghifa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
#halo
#wassap
#rupiahmenguat
#didesagapakedolar

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<<<<<<< Updated upstream
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Hello World!</h1>
    </body>
</html>
=======
        <title>Pilih Tiket</title>

    <style>
        /* Note  Pribadi  Ghifari*/
        
        /* Set All */
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body{
            background:#0B0E14; /* Main Outer Background */
            padding:20px;
            color: #FFFFFF;
        }

        .container{
            width: 100%;
            background: #0B0E14; /* Background MoviX */
            border: 1px solid #1E2530;
            border-radius: 15px;
            padding: 20px;
        }

        .top-bar{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:20px;
        }

        .logo{
            font-weight:bold;
            font-size:20px;
            color: #E51919; /* Merah untuk X pada MoviX */
        }

        .btn-back{
            padding:8px 18px;
            border:1px solid #323E4F;
            background:#1D2432; /* Tombol sekunder */
            color: #FFFFFF;
            font-weight: bold;
            border-radius:6px;
            cursor:pointer;
            transition: 0.2s; /* Buat nanti pas digabung */
        }
        
        .btn-back:hover{
            background: #323E4F;
            color: #fff;
        }

        /* Biar di samping & ada jarak */
        .main-content{      
            display:flex;
            gap:20px;
        }
        
        /* ------------------------------------------------------------------ */
        /* Sidebar */
        .sidebar{
            width:280px;
            background:#121620; /* Background Ringkasan Panel */
            border:1px solid #1E2530;
            border-radius:12px;
            padding:20px;
        }

        .sidebar h3{
            color: #FFFFFF;
            margin-bottom:20px;
            font-size:18px;
            padding-bottom:10px;
            border-bottom:1px solid #1E2530;
        }

        .info-group{
            margin-bottom:15px;
        }

        .info-label{
            color:#8E97A4; /* Muted text */
            font-size:12px;
        }

        .info-value{
            margin-top:4px;
            font-weight:bold;
            color: #FFFFFF;
        }

        .price-box{
            margin-top:30px;
            padding-top:20px;
            border-top:1px solid #1E2530;
        }
        
        .price-box p {
            color: #8E97A4;
        }

        .chair-btn{
            width:100%;
            padding:12px;
            margin-top:20px;
            background:#E51919; /* Tombol utama merah */
            color:white;
            border:none;
            border-radius:8px;
            cursor:pointer;
            font-weight:bold;
            transition: 0.2s;
        }
        
        .chair-btn:hover{
            background: #b81313;
        }
        
        /* ------------------------------------------------------------------ */
        /* Isi Page */
        .content{
            flex:1;
        }

        /* Buat "Pilih Jenis Tiket" */
        .content-title{
            font-size:24px;
            font-weight:bold;
            margin-bottom:25px;
            color: #FFFFFF;
            display:inline-block;
            padding-right:15px;
            padding-bottom: 2px;
            border-bottom: 2px solid #FFFFFF;
        }

        /* Buat pilihan tiket (reguler/premium) biar ga ke bawah */
        .ticket-wrapper{
            display:flex;
            gap:20px;
        }

        /* Pilihan tiket */
        .ticket-card{
            flex:1;
            border:2px solid #1E2530;
            border-radius:15px;
            padding:25px;
            background:#121620; /* Card background */
            transition: all 0.3s ease;
        }

        /* Efek glow merah menyala kalo kartu dipilih */
        .ticket-card.active{
            border:2px solid #E51919;
            box-shadow: 0 0 15px rgba(229, 25, 25, 0.35);
        }

        /* Biar badge ada di atas */
        .ticket-header{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:15px;
        }
        
        .ticket-header h2 {
            font-size: 22px;
            color: #FFFFFF;
        }

        .badge{ 
            padding:5px 12px;
            border-radius:15px;
            font-size:12px;
            background:#323E4F;
            color: #8E97A4;
        }

        .badge.selected{ /* Badge yg dipilih */
            background:#E51919;
            color:white;
            font-weight: bold;
        }

        .ticket-desc{
            color:#8E97A4;
            line-height:1.6;
            margin-bottom:20px;
            font-size: 14px;
        }

        .price{
            font-size:36px;
            font-weight:bold;
            margin-bottom:15px;
            color: #FFFFFF;
        }

        .price small{
            font-size:16px;
            color:#8E97A4;
        }

        .price-detail{
            display:flex;
            gap:10px;
            margin-bottom:25px;
        }

        .price-tag{
            background:#1E2530; /* Lebih gelap untuk tag info */
            padding:8px 12px;
            border-radius:8px;
            font-size:13px;
            color: #8E97A4;
            border: 1px solid #323E4F;
        }

        .choose-btn{
            width:100%;
            padding:12px;
            border:1px solid #E51919;
            border-radius:8px;
            background: transparent;
            color:#E51919;
            font-weight:bold;
            cursor:pointer;
            transition: 0.2s;
        }

        /* Tombol ketika tiket berstatus aktif/dipilih */
        .ticket-card.active .choose-btn {
            background: #E51919;
            color: white;
        }

        .choose-btn.gray{
            background:#1E2530;
            border: 1px solid #323E4F;
            color:#8E97A4;
        }
        

        /* Info Box Bawah */
        .info-box{
            margin-top:25px;
            background:#121620;
            border:1px solid #1E2530;
            border-radius:10px;
            padding:20px;
        }

        .info-box h4{
            margin-bottom:10px;
            color: #FFFFFF;
        }

        .info-box p{
            color:#8E97A4;
            line-height:1.6;
            font-size: 14px;
        }
    </style>
</head>

<body>
    <div class="container">

        <!-- Bagian Atas -->
        <div class="top-bar">
            <button class="btn-back">
                ← Kembali
            </button>

            <div class="logo"><span style="color: #FFFFFF;">Movi</span>X</div>
        </div>

        <div class="main-content">

            <!-- --------------------------------------------------------------- -->
            <!-- Sidebar -->
            <div class="sidebar">

                <h3>Ringkasan</h3>

                <div class="info-group">
                    <div class="info-label">Film</div>
                    <div class="info-value">Nama Film</div>
                </div>

                <div class="info-group">
                    <div class="info-label">Jadwal</div>
                    <div class="info-value">Hari, jam</div>
                </div>

                <div class="info-group">
                    <div class="info-label">Studio</div>
                    <div class="info-value">Studio X</div>
                </div>

                

                <div class="info-group">
                    <div class="info-label">Jenis Tiket</div>
                    <div class="info-value">Reguler</div>
                </div>

                <div class="price-box">
                    <p>2 x Rp 35.000</p>

                    <h3 style="margin-top:10px;">
                        Rp 70.000
                    </h3>

                    <button class="chair-btn">
                        Lanjut Pilih Kursi
                    </button>
                </div>

            </div>

            <!-- --------------------------------------------------------------- -->
            <!-- Isi Page -->
            <div class="content">

                <div class="content-title">
                    Pilih Jenis Tiket
                </div>

                <div class="ticket-wrapper">

                    <!-- Reguler -->
                    <div class="ticket-card active">

                        <div class="ticket-header">
                            <h2>Tiket Reguler</h2>

                            <div class="badge selected">
                                Dipilih
                            </div>
                        </div>

                        <div class="ticket-desc">
                            Studio standar dengan kursi nyaman.
                            <br>
                            Cocok untuk penonton sehari-hari.
                        </div>

                        <div class="price">
                            Rp 35.000 <small>/ tiket</small>
                        </div>

                        <div class="price-detail">
                            <div class="price-tag">
                                Weekday: Rp 35.000
                            </div>

                            <div class="price-tag">
                                Weekend: Rp 45.000
                            </div>
                        </div>

                        <button class="choose-btn">
                            Pilih Tiket Reguler
                        </button>

                    </div>

                    <!-- Premier -->
                    <div class="ticket-card">

                        <div class="ticket-header">
                            <h2>Tiket Premiere</h2>

                            <div class="badge">
                                Premium
                            </div>
                        </div>

                        <div class="ticket-desc">
                            Studio premier eksklusif dengan kursi
                            recliner dan layanan premium.
                        </div>

                        <div class="price">
                            Rp 75.000 <small>/ tiket</small>
                        </div>

                        <div class="price-detail">
                            <div class="price-tag">
                                Weekday: Rp 75.000
                            </div>

                            <div class="price-tag">
                                Weekend: Rp 90.000
                            </div>
                        </div>

                        <button class="choose-btn gray">
                            Pilih Tiket Premiere
                        </button>

                    </div>

                </div>

                <!-- --------------------------------------------------------------- -->
                <!-- Info -->
                <div class="info-box">
                    <h4>Keterangan Harga</h4>

                    <p>
                        Harga tiket dihitung via metode hitungHarga()
                        berdasarkan jenis tiket & hari tayang.
                        <br>
                        Hari kerja (Senin-Kamis) harga dasar;
                        akhir pekan (Jumat-Minggu) dikenakan biaya tambahan.
                    </p>
                </div>

            </div>

        </div>

    </div>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Pilih Tiket</title>

    <style>
        /* Note  Pribadi  Ghifari*/
        
        /* Set All */
        *{
            margin:0;
            padding:0;
            box-sizing:border-box;
            font-family: Arial, Helvetica, sans-serif;
        }

        body{
            background:#0B0E14; /* Main Outer Background */
            padding:20px;
            color: #FFFFFF;
        }

        .container{
            width: 100%;
            background: #0B0E14; /* Background MoviX */
            border: 1px solid #1E2530;
            border-radius: 15px;
            padding: 20px;
        }

        .top-bar{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:20px;
        }

        .logo{
            font-weight:bold;
            font-size:20px;
            color: #E51919; /* Merah untuk X pada MoviX */
        }

        .btn-back{
            padding:8px 18px;
            border:1px solid #323E4F;
            background:#1D2432; /* Tombol sekunder */
            color: #FFFFFF;
            font-weight: bold;
            border-radius:6px;
            cursor:pointer;
            transition: 0.2s; /* Buat nanti pas digabung */
        }
        
        .btn-back:hover{
            background: #323E4F;
            color: #fff;
        }

        /* Biar di samping & ada jarak */
        .main-content{      
            display:flex;
            gap:20px;
        }
        
        /* ------------------------------------------------------------------ */
        /* Sidebar */
        .sidebar{
            width:280px;
            background:#121620; /* Background Ringkasan Panel */
            border:1px solid #1E2530;
            border-radius:12px;
            padding:20px;
        }

        .sidebar h3{
            color: #FFFFFF;
            margin-bottom:20px;
            font-size:18px;
            padding-bottom:10px;
            border-bottom:1px solid #1E2530;
        }

        .info-group{
            margin-bottom:15px;
        }

        .info-label{
            color:#8E97A4; /* Muted text */
            font-size:12px;
        }

        .info-value{
            margin-top:4px;
            font-weight:bold;
            color: #FFFFFF;
        }

        .price-box{
            margin-top:30px;
            padding-top:20px;
            border-top:1px solid #1E2530;
        }
        
        .price-box p {
            color: #8E97A4;
        }

        .chair-btn{
            width:100%;
            padding:12px;
            margin-top:20px;
            background:#E51919; /* Tombol utama merah */
            color:white;
            border:none;
            border-radius:8px;
            cursor:pointer;
            font-weight:bold;
            transition: 0.2s;
        }
        
        .chair-btn:hover{
            background: #b81313;
        }
        
        /* ------------------------------------------------------------------ */
        /* Isi Page */
        .content{
            flex:1;
        }

        /* Buat "Pilih Jenis Tiket" */
        .content-title{
            font-size:24px;
            font-weight:bold;
            margin-bottom:25px;
            color: #FFFFFF;
            display:inline-block;
            padding-right:15px;
            padding-bottom: 2px;
            border-bottom: 2px solid #FFFFFF;
        }

        /* Buat pilihan tiket (reguler/premium) biar ga ke bawah */
        .ticket-wrapper{
            display:flex;
            gap:20px;
        }

        /* Pilihan tiket */
        .ticket-card{
            flex:1;
            border:2px solid #1E2530;
            border-radius:15px;
            padding:25px;
            background:#121620; /* Card background */
            transition: all 0.3s ease;
        }

        /* Efek glow merah menyala kalo kartu dipilih */
        .ticket-card.active{
            border:2px solid #E51919;
            box-shadow: 0 0 15px rgba(229, 25, 25, 0.35);
        }

        /* Biar badge ada di atas */
        .ticket-header{
            display:flex;
            justify-content:space-between;
            align-items:center;
            margin-bottom:15px;
        }
        
        .ticket-header h2 {
            font-size: 22px;
            color: #FFFFFF;
        }

        .badge{ 
            padding:5px 12px;
            border-radius:15px;
            font-size:12px;
            background:#323E4F;
            color: #8E97A4;
        }

        .badge.selected{ /* Badge yg dipilih */
            background:#E51919;
            color:white;
            font-weight: bold;
        }

        .ticket-desc{
            color:#8E97A4;
            line-height:1.6;
            margin-bottom:20px;
            font-size: 14px;
        }

        .price{
            font-size:36px;
            font-weight:bold;
            margin-bottom:15px;
            color: #FFFFFF;
        }

        .price small{
            font-size:16px;
            color:#8E97A4;
        }

        .price-detail{
            display:flex;
            gap:10px;
            margin-bottom:25px;
        }

        .price-tag{
            background:#1E2530; /* Lebih gelap untuk tag info */
            padding:8px 12px;
            border-radius:8px;
            font-size:13px;
            color: #8E97A4;
            border: 1px solid #323E4F;
        }

        .choose-btn{
            width:100%;
            padding:12px;
            border:1px solid #E51919;
            border-radius:8px;
            background: transparent;
            color:#E51919;
            font-weight:bold;
            cursor:pointer;
            transition: 0.2s;
        }

        /* Tombol ketika tiket berstatus aktif/dipilih */
        .ticket-card.active .choose-btn {
            background: #E51919;
            color: white;
        }

        .choose-btn.gray{
            background:#1E2530;
            border: 1px solid #323E4F;
            color:#8E97A4;
        }
        

        /* Info Box Bawah */
        .info-box{
            margin-top:25px;
            background:#121620;
            border:1px solid #1E2530;
            border-radius:10px;
            padding:20px;
        }

        .info-box h4{
            margin-bottom:10px;
            color: #FFFFFF;
        }

        .info-box p{
            color:#8E97A4;
            line-height:1.6;
            font-size: 14px;
        }
    </style>
</head>

<body>
    <div class="container">

        <!-- Bagian Atas -->
        <div class="top-bar">
            <button class="btn-back">
                ← Kembali
            </button>

            <div class="logo"><span style="color: #FFFFFF;">Movi</span>X</div>
        </div>

        <div class="main-content">

            <!-- --------------------------------------------------------------- -->
            <!-- Sidebar -->
            <div class="sidebar">

                <h3>Ringkasan</h3>

                <div class="info-group">
                    <div class="info-label">Film</div>
                    <div class="info-value">Nama Film</div>
                </div>

                <div class="info-group">
                    <div class="info-label">Jadwal</div>
                    <div class="info-value">Hari, jam</div>
                </div>

                <div class="info-group">
                    <div class="info-label">Studio</div>
                    <div class="info-value">Studio X</div>
                </div>

                

                <div class="info-group">
                    <div class="info-label">Jenis Tiket</div>
                    <div class="info-value">Reguler</div>
                </div>

                <div class="price-box">
                    <p>2 x Rp 35.000</p>

                    <h3 style="margin-top:10px;">
                        Rp 70.000
                    </h3>

                    <button class="chair-btn">
                        Lanjut Pilih Kursi
                    </button>
                </div>

            </div>

            <!-- --------------------------------------------------------------- -->
            <!-- Isi Page -->
            <div class="content">

                <div class="content-title">
                    Pilih Jenis Tiket
                </div>

                <div class="ticket-wrapper">

                    <!-- Reguler -->
                    <div class="ticket-card active">

                        <div class="ticket-header">
                            <h2>Tiket Reguler</h2>

                            <div class="badge selected">
                                Dipilih
                            </div>
                        </div>

                        <div class="ticket-desc">
                            Studio standar dengan kursi nyaman.
                            <br>
                            Cocok untuk penonton sehari-hari.
                        </div>

                        <div class="price">
                            Rp 35.000 <small>/ tiket</small>
                        </div>

                        <div class="price-detail">
                            <div class="price-tag">
                                Weekday: Rp 35.000
                            </div>

                            <div class="price-tag">
                                Weekend: Rp 45.000
                            </div>
                        </div>

                        <button class="choose-btn">
                            Pilih Tiket Reguler
                        </button>

                    </div>

                    <!-- Premier -->
                    <div class="ticket-card">

                        <div class="ticket-header">
                            <h2>Tiket Premiere</h2>

                            <div class="badge">
                                Premium
                            </div>
                        </div>

                        <div class="ticket-desc">
                            Studio premier eksklusif dengan kursi
                            recliner dan layanan premium.
                        </div>

                        <div class="price">
                            Rp 75.000 <small>/ tiket</small>
                        </div>

                        <div class="price-detail">
                            <div class="price-tag">
                                Weekday: Rp 75.000
                            </div>

                            <div class="price-tag">
                                Weekend: Rp 90.000
                            </div>
                        </div>

                        <button class="choose-btn gray">
                            Pilih Tiket Premiere
                        </button>

                    </div>

                </div>

                <!-- --------------------------------------------------------------- -->
                <!-- Info -->
                <div class="info-box">
                    <h4>Keterangan Harga</h4>

                    <p>
                        Harga tiket dihitung via metode hitungHarga()
                        berdasarkan jenis tiket & hari tayang.
                        <br>
                        Hari kerja (Senin-Kamis) harga dasar;
                        akhir pekan (Jumat-Minggu) dikenakan biaya tambahan.
                    </p>
                </div>

            </div>

        </div>

    </div>
</body>
>>>>>>> Stashed changes
