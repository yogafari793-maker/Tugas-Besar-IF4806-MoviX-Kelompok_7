<%-- 
    Document   : pilih_tiket
    Created on : 16 Jun 2026, 08.56.03
    Author     : ghifa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Langkah 2: Pilih Jenis Tiket — MoviX</title>
        <style>
            * { 
                margin:0; 
                padding:0; 
                box-sizing:border-box; 
                font-family:Arial,Helvetica,sans-serif; 
            }
            body { 
                background:#05070D; 
                color:white; 
                padding:30px; 
            }
            .container { 
                max-width:950px; 
                margin:0 auto; 
                background:#0B0E14; 
                border:1px solid #1E2530; 
                border-radius:18px; 
                padding:35px; 
            }
            .top-bar { 
                display:flex; 
                justify-content:space-between; 
                align-items:center; 
                margin-bottom:30px; 
            }
            .btn-back { 
                padding:10px 18px; 
                background:#1D2432; 
                border:1px solid #323E4F; 
                border-radius:8px; 
                color:white; 
                text-decoration:none; 
            }
            .logo { 
                font-family: 'Inter', Arial, sans-serif;
                font-size: 28px; 
                font-weight: 800; 
                letter-spacing: -0.5px;
                color: white; 
                text-decoration: none;
            }
            .logo span {
                color: #E51919;
            }
            .header-info { 
                text-align:center; 
                margin-bottom:35px; 
            }
            .header-info h1 { 
                font-size:28px; 
                margin-bottom:8px; 
            }
            .header-info span { 
                color:#E51919; 
            }
            .header-info p { 
                color:#8E97A4; 
                font-size:14px; 
            }
            
            .ticket-grid { 
                display:flex; 
                gap:25px; 
                justify-content:center; 
                margin-top:20px; 
            }
            .ticket-card { 
                width:380px; 
                background:#0F131D; 
                border:2px solid #1E2530; 
                border-radius:20px; 
                padding:28px; 
                text-decoration:none; 
                color:white; 
                transition:0.3s; 
            }
            .ticket-card:hover { 
                transform:translateY(-4px); 
                border-color:#E51919; 
                box-shadow:0 0 20px rgba(229,25,25,0.2); 
            }
            .badge { 
                display:inline-block; 
                padding:4px 12px; 
                border-radius:12px; 
                font-size:12px; 
                font-weight:bold; 
                margin-bottom:15px; 
            }
            .badge-reg { 
                background:#1D2432; 
                color:white; 
                border:1px solid #323E4F; 
            }
            .badge-pre { 
                background:#E51919; 
                color:white; 
            }
            .card-title { 
                font-size:22px; 
                font-weight:bold; 
                margin-bottom:8px; 
            }
            .card-desc { 
                color:#8E97A4; 
                font-size:14px; 
                line-height:1.5; 
                margin-bottom:20px; 
            }
            .price { 
                font-size:24px; 
                font-weight:bold; 
                color:white; 
                border-top:1px solid #1E2530; 
                padding-top:15px; 
            }
        </style>
    </head>
    
    <body>
        <%
            String filmId = (String) request.getAttribute("filmId");
            String namaFilm = (String) request.getAttribute("namaFilm");
        %>
        <div class="container">
            <div class="top-bar">
                <a href="${pageContext.request.contextPath}/katalog" class="btn-back">← Kembali Cari Film</a>
                <div class="logo">Movi<span>X</span></div>
            </div>

            <div class="header-info">
                <p>Langkah 2: Pilih Kategori Tiket Untuk Film</p>
                <h1><span><%= namaFilm %></span></h1>
            </div>

            <div class="ticket-grid">
                <a href="<%= request.getContextPath() %>/jadwal/reguler?filmId=<%= filmId %>" class="ticket-card">
                    <div class="badge badge-reg">Reguler</div>
                    <div class="card-title">Kelas Reguler</div>
                    <div class="card-desc">Format audio standar dengan kursi empuk ergonomis dan layar jernih berkualitas tinggi.</div>
                </a>

                <a href="<%= request.getContextPath() %>/jadwal/premier?filmId=<%= filmId %>" class="ticket-card">
                    <div class="badge badge-pre">⭐ Premier</div>
                    <div class="ticket-title card-title">Kelas Premier</div>
                    <div class="card-desc">Rasakan kemewahan menonton dengan sofa reclining kulit premium eksklusif dan selimut hangat.</div>
                </a>
            </div>
        </div>
    </body>
</html>

