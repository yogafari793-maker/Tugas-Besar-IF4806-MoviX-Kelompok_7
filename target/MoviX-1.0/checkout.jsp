<%-- 
    Document   : checkout
    Created on : 22 May 2026, 15.38.21
    Author     : Hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MoviX - Checkout</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            background-color: #0b0d12;
            font-family: "Times New Roman", Times, serif;
            color: #ffffff;
        }
        
        .main-container {
            margin: 20px auto;
            width: 95%;
            min-height: 90vh;
            background: #11141a;
            border: 1px solid #1f242e;
            border-radius: 20px;
            overflow: hidden;
        }
        
        .navbar-custom {
            background-color: #161a23;
            padding: 15px 25px;
            border-bottom: 1px solid #1f242e;
        }
        
        .logo-title {
            color: #dc3545;
            font-weight: bold;
            font-size: 30px;
            margin: 0;
        }
        
        .btn-nav-custom {
            background-color: #1c212c;
            color: #b2bac7;
            border: 1px solid #2d3646;
            transition: 0.2s;
        }
        
        .btn-nav-custom:hover {
            color: #ffffff;
            background-color: #232a35;
            border-color: #3f4a5f;
        }
        
        .left-panel {
            padding: 30px;
        }
        
        .summary-box {
            background-color: #181c24;
            border: 1px solid #232a35;
            border-radius: 12px;
            padding: 20px;
        }
        
        .calculation {
            background-color: #181c24;
            border: 1px solid #232a35;
            border-radius: 12px;
            padding: 20px;
        }
        
        .text-muted-custom {
            color: #6c757d;
        }
        
        .form-control-dark {
            background-color: #1c212c !important;
            border: 1px solid #2d3646 !important;
            color: #ffffff !important;
        }
        
        .form-control-dark::placeholder {
            color: #495469;
        }
        
        .btn-dark-custom {
            background-color: #2a313f;
            color: white;
            border: 1px solid #364052;
            transition: 0.2s;
        }
        
        .btn-dark-custom:hover {
            background-color: #364052;
            color: white;
        }
        
        .btn-confirm {
            background-color: #dc3545;
            color: white;
            font-weight: bold;
            padding: 14px;
            border-radius: 8px;
            width: 100%;
            border: none;
            transition: 0.2s;
            box-shadow: 0 4px 15px #000000;
        }
        
        .btn-confirm:hover {
            background-color: #bd2130;
            color: white;
            box-shadow: 0 4px 20px #000000;
        }
        
        .right-panel {
            background-color: #141820;
            border-left: 1px solid #1f242e;
            padding: 30px;
        }

        .receipt-card {
            border: 1px dashed #3a4454;
            border-radius: 15px;
            padding: 25px;
            background-color: #181c24;
        }
        
        .qr-placeholder {
            border: 1px dashed #3a4454;
            border-radius: 8px;
            height: 250px;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            background-color: #11141a;
            color: #6c757d;
        }

        .table-checkout {
            width: 100%;
            border-collapse: collapse;
            background: transparent;
        }

        .table-checkout td {
            padding: 10px 0;
            color: #ffffff;
            background: transparent !important;
            border: none;
        }

        .table-checkout tr {
            border-bottom: 1px solid #2d3646;
        }

        .table-checkout tr:last-child {
            border-bottom: none;
        }

        .tr-line-dashed {
            border-bottom: 1px dashed #3a4454 !important;
        }

        input, button, select, textarea, p, div, h3, h5, td, small, a {
            font-family: "Times New Roman", Times, serif !important;
        }
    </style>
</head>
<body>

<div class="main-container">

    <nav class="navbar navbar-custom d-flex justify-content-between align-items-center">
        <h5 class="logo-title">■ MoviX</h5>
        <div>
            <a href="logout.jsp" class="btn btn-nav-custom btn-sm me-1">Keluar</a>
            <a href="riwayat.jsp" class="btn btn-nav-custom btn-sm me-1">Riwayat Transaksi</a>
            <a href="pilihKursi.jsp" class="btn btn-nav-custom btn-sm">Kembali</a>
        </div>
    </nav>

    <div class="container-fluid p-0">
        <div class="row g-0">
            
            <div class="col-md-7 left-panel">
                <h3 class="fw-bold mb-4">Pesanan</h3>
                
                <div class="summary-box mb-4">
                    <table class="table-checkout">
                        <tr>
                            <td class="text-white" style="width: 30%">Film</td>
                            <td class="text-end fw-bold">Judul Film</td>
                        </tr>
                        <tr>
                            <td class="text-white" style="width: 30%">Jadwal</td>
                            <td class="text-end fw-bold">Hari, Tanggal</td>
                        </tr>
                        <tr>
                            <td class="text-white" style="width: 30%">Studio</td>
                            <td class="text-end fw-bold">Nama Studio</td>
                        </tr>
                        <tr>
                            <td class="text-white" style="width: 30%">Kursi</td>
                            <td class="text-end fw-bold text-danger">Kode Kursi</td>
                        </tr>
                        <tr>
                            <td class="text-white" style="width: 30%">Jenis Tiket</td>
                            <td class="text-end fw-bold">Jenis Tiket</td>
                        </tr>
                        <tr>
                            <td class="fw-bold">0x Tiket</td>
                            <td class="text-end fw-bold fs-5">Rp 0</td>
                        </tr>
                    </table>
                </div>
                
                <h5 class="fw-bold mb-3">Kode Promo</h5>
                <form action="CheckoutServlet" method="POST" class="mb-4">
                    <input type="hidden" name="aksi" value="terapkanPromo">
                    <div class="input-group">
                        <input type="text" name="kodePromo" class="form-control form-control-dark text-uppercase" placeholder="Masukkan kode promo...">
                        <button type="submit" class="btn btn-dark-custom px-4">Masukkan</button>
                    </div>
                    <small class="text-muted-custom d-block mt-1">Masukkan kode promo</small>
                </form>
                
                <div class="calculation mb-4">
                    <h5 class="fw-bold mb-4">Total Harga</h5>
                    <table class="table-checkout">
                        <tr>
                            <td class="text-white" style="width: 30%">Total Tiket</td>
                            <td class="text-end fw-bold fs-5">Tidak Ada</td>
                        </tr>
                        <tr>
                            <td class="text-white" style="width: 30%">Total Tiket</td>
                            <td class="text-end fw-bold fs-5">Tidak Ada</td>
                        </tr>
                        <tr>
                            <td class="text-success">Diskon</td>
                            <td class="text-end text-success">Tidak Ada</td>
                        </tr>
                        <tr>
                            <td class="text-white" style="width: 30%">Biaya layanan</td>
                            <td class="text-end">Tidak Ada</td>
                        </tr>
                        <tr>
                            <td class="fw-bold fs-5">Total Bayar</td>
                            <td class="text-end fw-bold fs-4">Tidak Ada</td>
                        </tr>
                    </table>
                </div>

                <form action="CheckoutServlet" method="post" class="mb-3">
                    <input type="hidden" name="aksi" value="bayarDanCetak">
                    <button type="submit" class="btn btn-confirm text-uppercase">Konfirmasi Pembayaran</button>
                </form>
                
                <div class="text-center">
                    <a href="riwayatAdmin.jsp" class="text-muted-custom small text-decoration-none">Lihat Riwayat Transaksi (Admin)</a>
                </div>
            </div>

            <div class="col-md-5 right-panel">
                <h3 class="fw-bold mb-4">Struk Digital</h3>
                
                <div class="receipt-card">
                    <div class="text-center mb-4">
                        <h4 class="fw-bold m-0 text-danger">■ MoviX</h4>
                        <small class="text-muted-custom small">Bukti Pemesanan Tiket</small>
                    </div>

                    <table class="table-checkout">
                        <tr>
                            <td class="text-white" style="width: 40%">Kode Booking</td>
                            <td class="text-end fw-bold text-uppercase">Tidak Ada</td>
                        </tr>
                        <tr>
                            <td class="text-white" style="width: 40%">Film</td>
                            <td class="text-end">Judul Film</td>
                        </tr>
                        <tr>
                            <td class="text-white" style="width: 40%">Tanggal</td>
                            <td class="text-end">Hari, Tanggal</td>
                        </tr>
                        <tr>
                            <td class="text-white" style="width: 40%">Jam</td>
                            <td class="text-end">Jam WIB</td>
                        </tr>
                        <tr>
                            <td class="text-white" style="width: 40%">Studio</td>
                            <td class="text-end">Nama Studio</td>
                        </tr>
                        <tr>
                            <td class="text-white" style="width: 40%">Kursi</td>
                            <td class="text-end fw-bold text-danger">-</td>
                        </tr>
                        <tr class="tr-line-dashed">
                            <td class="text-white" style="width: 40%">Jenis Tiket</td>
                            <td class="text-end">Tidak Ada</td>
                        </tr>
                        <tr>
                            <td class="text-white" style="width: 40%">Subtotal</td>
                            <td class="text-end">Tidak Ada</td>
                        </tr>
                        <tr class="tr-line-dashed">
                            <td class="text-success">Diskon</td>
                            <td class="text-end text-success">Tidak Ada</td>
                        </tr>
                        <tr>
                            <td class="fw-bold">Total</td>
                            <td class="text-end fw-bold fs-5">Tidak Ada</td>
                        </tr>
                    </table>

                    <div class="qr-placeholder text-center mt-4">
                        <h5 class="fw-bold mb-1">QR / Barcode Tiket</h5>
                        <p class="m-0 opacity-75 small text-muted-custom">Tunjukkan struk ini kepada petugas bioskop</p>
                    </div>
                </div>
            </div>
            
        </div>
    </div>
</div>

</body>
</html>
