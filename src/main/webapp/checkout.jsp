<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout — MoviX</title>
    <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
    <style>
        :root {
            --bg:        #0d0f14;
            --surface:   #151820;
            --surface2:  #1c2030;
            --border:    rgba(255,255,255,.07);
            --text:      #e8eaf0;
            --muted:     #6b7280;
            --accent:    #e50914;
            --accent2:   #ff3d3d;
            --radius:    12px;
            --font-head: 'Syne', sans-serif;
            --font-body: 'DM Sans', sans-serif;
        }
        *, *::before, *::after { box-sizing: border-box; margin:0; padding:0; }
        body {
            background: var(--bg);
            color: var(--text);
            font-family: var(--font-body);
            font-size: 15px;
            min-height: 100vh;
            line-height: 1.5;
        }
        nav {
            position: sticky; top: 0; z-index: 100;
            background: rgba(13,15,20,.85); backdrop-filter: blur(16px);
            border-bottom: 1px solid var(--border);
            padding: 0 32px; height: 60px;
            display: flex; align-items: center; justify-content: space-between;
        }
        .nav-logo { font-family: var(--font-head); font-size: 22px; font-weight: 800; color: var(--text); }
        .nav-logo span { color: var(--accent); }
        .nav-links a {
            color: var(--muted); text-decoration: none; font-size: 14px; font-weight: 500;
            margin-left: 20px; transition: color .2s;
        }
        .nav-links a:hover { color: var(--text); }

        main { max-width: 1000px; margin: 0 auto; padding: 40px 20px; display: flex; gap: 40px; align-items: flex-start; }
        
        .left-col { flex: 1; }
        .right-col { width: 380px; position: sticky; top: 90px; }

        .section-title { font-family: var(--font-head); font-size: 24px; font-weight: 700; margin-bottom: 20px; }

        .card { background: var(--surface); border: 1px solid var(--border); border-radius: var(--radius); padding: 24px; margin-bottom: 24px; }
        
        .row-info { display: flex; justify-content: space-between; align-items: baseline; padding: 12px 0; border-bottom: 1px solid var(--border); }
        .row-info:last-child { border-bottom: none; }
        .row-info .label { color: var(--muted); font-size: 14px; }
        .row-info .val { font-weight: 500; text-align: right; max-width: 60%; }
        
        .seats-badge { display: inline-block; background: var(--surface2); border: 1px solid var(--border); padding: 4px 10px; border-radius: 6px; font-size: 13px; font-weight: 600; color: var(--accent); margin-left: 5px; margin-bottom: 5px; }

        .form-group { display: flex; gap: 10px; margin-bottom: 10px; }
        .form-control { flex: 1; background: var(--surface2); border: 1px solid var(--border); color: var(--text); padding: 12px 16px; border-radius: 8px; font-family: var(--font-body); font-size: 14px; outline: none; transition: border .2s; }
        .form-control:focus { border-color: var(--accent); }
        .btn-secondary { background: transparent; border: 1px solid var(--border); color: var(--text); padding: 12px 20px; border-radius: 8px; font-weight: 600; cursor: pointer; transition: all .2s; }
        .btn-secondary:hover { background: var(--surface2); }
        
        .text-green { color: #22c55e !important; }
        
        .total-row { padding-top: 16px !important; margin-top: 8px; border-top: 2px dashed var(--border) !important; }
        .total-row .label { font-size: 16px; font-weight: 600; color: var(--text); }
        .total-row .val { font-family: var(--font-head); font-size: 22px; font-weight: 700; color: var(--accent); }

        .btn-primary { width: 100%; background: var(--accent); color: #fff; padding: 16px; border: none; border-radius: 10px; font-family: var(--font-head); font-size: 16px; font-weight: 700; cursor: pointer; transition: all .2s; box-shadow: 0 4px 20px rgba(229,9,20,.35); margin-top: 10px; }
        .btn-primary:hover { background: var(--accent2); transform: translateY(-2px); box-shadow: 0 6px 24px rgba(229,9,20,.5); }

        .receipt-container { background: #0b0d12; border: 1px dashed #3a4454; border-radius: 15px; padding: 25px; position: relative; }
        .receipt-container::before, .receipt-container::after { content: ''; position: absolute; width: 24px; height: 24px; background: var(--bg); border-radius: 50%; top: 60px; border: 1px dashed #3a4454; }
        .receipt-container::before { left: -12px; border-right-color: transparent; border-top-color: transparent; border-bottom-color: transparent; transform: rotate(45deg); }
        .receipt-container::after { right: -12px; border-left-color: transparent; border-top-color: transparent; border-bottom-color: transparent; transform: rotate(-45deg); }
        
        .receipt-header { text-align: center; margin-bottom: 20px; padding-bottom: 20px; border-bottom: 1px dashed #3a4454; }
        .receipt-header h4 { font-family: var(--font-head); font-weight: 800; color: var(--accent); font-size: 20px; margin-bottom: 4px; }
        .receipt-header p { font-size: 12px; color: var(--muted); }

        .qr-box { background: var(--surface2); height: 180px; border-radius: 8px; display: flex; align-items: center; justify-content: center; flex-direction: column; color: var(--muted); margin-top: 20px; border: 1px solid var(--border); }
        .qr-box span { font-size: 12px; margin-top: 10px; opacity: 0.7; }

        @media (max-width: 800px) {
            main { flex-direction: column; }
            .right-col { width: 100%; position: static; }
        }
        
        .alert { padding: 12px 16px; border-radius: 8px; margin-bottom: 20px; font-size: 14px; }
        .alert-error { background: rgba(229,9,20,.1); border: 1px solid rgba(229,9,20,.3); color: #ffcccc; }
        .alert-success { background: rgba(34,197,94,.1); border: 1px solid rgba(34,197,94,.3); color: #bbf7d0; }
    </style>
</head>
<body>

<nav>
    <div class="nav-logo">Movi<span>X</span></div>
    <div class="nav-links">
        <a href="${pageContext.request.contextPath}/katalog">Kembali ke Katalog</a>
    </div>
</nav>

<main>
    <div class="left-col">
        <h1 class="section-title">Detail Pesanan</h1>
        
        <% 
            String errorMsg = (String) session.getAttribute("errorPromo");
            String successMsg = (String) session.getAttribute("successPromo");
            if (errorMsg != null) { 
        %>
            <div class="alert alert-error"><%= errorMsg %></div>
        <% 
                session.removeAttribute("errorPromo");
            } 
            if (successMsg != null) {
        %>
            <div class="alert alert-success"><%= successMsg %></div>
        <% 
                session.removeAttribute("successPromo");
            } 
        %>

        <div class="card">
            <div class="row-info">
                <span class="label">Film</span>
                <span class="val">${sessionScope.filmTitle}</span>
            </div>
            <div class="row-info">
                <span class="label">Jadwal</span>
                <span class="val">${sessionScope.filmDate}, ${sessionScope.filmTime}</span>
            </div>
            <div class="row-info">
                <span class="label">Studio</span>
                <span class="val">${sessionScope.studioName}</span>
            </div>
            <div class="row-info" style="align-items: center; padding: 16px 0;">
                <span class="label">Kursi</span>
                <div style="text-align: right; max-width: 60%;">
                    <% 
                        String[] seats = (String[]) session.getAttribute("selectedSeats");
                        if (seats != null) {
                            for (String s : seats) {
                    %>
                        <span class="seats-badge"><%= s %></span>
                    <%      }
                        }
                    %>
                </div>
            </div>
        </div>

        <h2 class="section-title" style="font-size: 18px;">Kode Promo</h2>
        <div class="card">
            <form action="${pageContext.request.contextPath}/checkout" method="POST">
                <input type="hidden" name="aksi" value="terapkanPromo">
                <div class="form-group">
                    <input type="text" name="kodePromo" class="form-control" placeholder="Masukkan kode promo..." value="${sessionScope.kodePromo != null ? sessionScope.kodePromo : ''}">
                    <button type="submit" class="btn-secondary">Gunakan</button>
                </div>
                <% if (sessionScope.kodePromo != null) { %>
                    <p style="font-size: 13px; color: var(--muted); margin-top: 8px;">
                        Promo aktif: <strong>${sessionScope.promoDeskripsi}</strong> 
                        (<a href="${pageContext.request.contextPath}/checkout?aksi=hapusPromo" style="color: var(--accent); text-decoration: none;">Hapus</a>)
                    </p>
                <% } %>
            </form>
        </div>
        
        <form action="${pageContext.request.contextPath}/checkout" method="POST" id="formBayar">
            <input type="hidden" name="aksi" value="bayarDanCetak">
            <button type="submit" class="btn-primary" ${sessionScope.bayarSukses != null ? 'style="display:none;"' : ''}>Konfirmasi Pembayaran</button>
        </form>
        
        <% if (sessionScope.bayarSukses != null) { %>
            <div class="alert alert-success" style="text-align: center; margin-top: 20px;">
                <strong>Pembayaran Berhasil!</strong><br>
                Pesanan tiket Anda telah terkonfirmasi. Silakan simpan Struk Digital Anda.
            </div>
        <% } %>
    </div>

    <div class="right-col">
        <div class="receipt-container">
            <div class="receipt-header">
                <h4>Movi<span>X</span></h4>
                <p>E-Ticket Resmi</p>
            </div>
            
            <div class="row-info">
                <span class="label">Kode Booking</span>
                <span class="val" style="color: var(--text); font-family: monospace; font-size: 16px;">
                    ${sessionScope.kodeBooking != null ? sessionScope.kodeBooking : 'MENUNGGU PEMBAYARAN'}
                </span>
            </div>
            
            <div class="row-info">
                <span class="label">Harga Tiket (${sessionScope.jumlahKursi}x)</span>
                <span class="val">Rp ${sessionScope.subtotalFormatted}</span>
            </div>
            
            <% if (sessionScope.diskon > 0) { %>
            <div class="row-info">
                <span class="label">Diskon Promo</span>
                <span class="val text-green">- Rp ${sessionScope.diskonFormatted}</span>
            </div>
            <% } %>
            
            <div class="row-info">
                <span class="label">Biaya Layanan</span>
                <span class="val">Rp 4.000</span>
            </div>
            
            <div class="row-info total-row">
                <span class="label">Total Bayar</span>
                <span class="val">Rp ${sessionScope.totalAkhirFormatted}</span>
            </div>

            <div class="qr-box">
                <% if (sessionScope.bayarSukses != null) { %>
                    <img src="https://api.qrserver.com/v1/create-qr-code/?size=120x120&data=${sessionScope.kodeBooking}&bgcolor=1c2030&color=e8eaf0" alt="QR Code" width="120" height="120" style="border-radius: 8px;">
                    <span>Scan at the gate</span>
                <% } else { %>
                    <div style="width: 80px; height: 80px; border: 2px dashed var(--muted); border-radius: 8px; opacity: 0.5;"></div>
                    <span>Selesaikan pembayaran</span>
                <% } %>
            </div>
        </div>
    </div>
</main>

</body>
</html>