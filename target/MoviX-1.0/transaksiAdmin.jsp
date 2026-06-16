<%-- 
    Document   : transaksiAdmin
    Created on : 22 May 2026, 16.00.45
    Author     : Hp
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MoviX Admin - Riwayat Transaksi</title>

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
        
        .logo { 
            font-size: 30px;
            font-weight: bold; 
            color: #E51919; 
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
        
        .content-panel {
            padding: 30px;
        }
        
        .history-box {
            background-color: #181c24;
            border: 1px solid #232a35;
            border-radius: 12px;
            padding: 25px;
        }
        
        .text-muted-custom {
            color: #6c757d;
        }
        
        .table-admin {
            width: 100%;
            border-collapse: collapse;
            background: transparent;
        }

        .table-admin th {
            padding: 15px 10px;
            color: #6c757d;
            font-weight: bold;
            text-align: left;
            border-bottom: 2px solid #2d3646;
            background: transparent;
        }

        .table-admin td {
            padding: 15px 10px;
            color: #ffffff;
            background: transparent !important;
            border-bottom: 1px solid #2d3646;
        }

        .table-admin tr:last-child td {
            border-bottom: none;
        }

        input, button, select, textarea, p, div, h3, h5, th, td, small, a, span {
            font-family: "Times New Roman", Times, serif !important;
        }
    </style>
</head>
<body>

<div class="main-container">

    <nav class="navbar navbar-custom d-flex justify-content-between align-items-center">
        <div class="logo"><span style="color:white;">Movi</span>X Admin</div>
        <div>
            <a href="dashboardAdmin.jsp" class="btn btn-nav-custom btn-sm me-1">Dashboard</a>
            <a href="logout.jsp" class="btn btn-nav-custom btn-sm me-1">Keluar</a>
            <a href="checkout.jsp" class="btn btn-nav-custom btn-sm">Kembali</a>
        </div>
    </nav>

    <div class="content-panel">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h3 class="fw-bold m-0">Riwayat Transaksi Seluruh Pengguna</h3>
            <span class="text-muted-custom">Administrator</span>
        </div>
        
        <div class="history-box">
            <table class="table-admin">
                <thead>
                    <tr>
                        <th style="width: 10%;">No</th>
                        <th style="width: 40%;">Judul Film</th>
                        <th style="width: 30%;">Waktu Nonton</th>
                        <th style="width: 20%;">Total Bayar</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>Judul Film</td>
                        <td>Hari, Tanggal — Jam</td>
                        <td class="fw-bold">Rp 0</td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td>Judul Film</td>
                        <td>Hari, Tanggal — Jam</td>
                        <td class="fw-bold">Rp 0</td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td>Judul Film</td>
                        <td>Hari, Tanggal — Jam</td>
                        <td class="fw-bold">Rp 0</td>
                    </tr>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>