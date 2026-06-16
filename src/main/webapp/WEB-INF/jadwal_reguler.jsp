<%-- 
    Document   : jadwal_reguler
    Created on : 9 Jun 2026, 09.59.56
    Author     : ghifa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import="java.util.List, test.model.JadwalTayang"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Jadwal Reguler — MoviX</title>
        <style>
            * { 
                margin:0; 
                padding:0; 
                box-sizing:border-box; 
                font-family:Arial,Helvetica,sans-serif;
            }
            body {
                background:#05070D; 
                padding:25px; 
                color:white; 
            }
            .container { 
                width:100%; 
                background:#0B0E14; 
                border:1px solid #1E2530; 
                border-radius:18px; 
                padding:20px;
            }
            .top-bar { 
                display:flex; 
                justify-content:space-between; 
                align-items:center; 
                margin-bottom:25px; 
            }
            .btn-back {
                padding:10px 18px; 
                background:#1D2432; 
                border:1px solid #323E4F;
                border-radius:8px; 
                color:white; 
                cursor:pointer; 
                transition:0.3s;
                text-decoration:none; 
                display:inline-block;
            }
            .btn-back:hover { 
                background:#323E4F;
            }
            .logo { 
                font-size:30px;
                font-weight:bold; 
                color:#E51919; 
            }
            .main-content { 
                display:flex; 
                gap:20px; 
            }
            .sidebar { 
                width:270px;
                background:#121620;
                border:1px solid #1E2530; 
                border-radius:15px; 
                padding:20px; 
                flex-shrink:0; }
            .sidebar h2 { 
                margin-bottom:20px; 
                padding-bottom:12px; 
                border-bottom:1px solid #1E2530; 
            }
            .info-group { 
                margin-bottom:20px;
            }
            .info-label { 
                color:#8E97A4; 
                font-size:13px; 
            }
            .info-value { 
                margin-top:5px; 
                font-size:18px; 
                font-weight:bold; 
            }
            .price-box { 
                margin-top:40px; 
                border-top:1px solid #1E2530;
                padding-top:18px; 
            }
            .checkout-btn {
                width:100%; 
                margin-top:20px; 
                padding:14px; 
                border:none;
                border-radius:10px; 
                background:#E51919; 
                color:white;
                font-weight:bold; 
                cursor:pointer; 
                transition:0.3s;
            }
            .checkout-btn:hover { 
                background:#b81414; 
            }
            .checkout-btn:disabled { 
                background:#555; 
                cursor:not-allowed; 
            }
            .content { 
                flex:1; 
            }
            .content-title { 
                font-size:32px; 
                font-weight:bold; 
                margin-bottom:20px; 
            }
            .schedule-card {
                background:#0F131D; 
                border:2px solid #E51919; 
                border-radius:18px;
                padding:20px; 
                box-shadow:0 0 20px rgba(229,25,25,0.45); 
                margin-bottom:20px;
            }
            .schedule-header { 
                display:flex; 
                justify-content:space-between;
                align-items:center; 
                margin-bottom:15px; 
            }
            .schedule-header h2 {
                font-size:24px; 
                color: #fff; 
            }
            .film-title-tag { 
                font-size: 20px; 
                font-weight: bold; 
                color: #E51919; 
                margin-bottom: 5px; 
            }
            .badge { 
                background:#E51919; 
                padding:7px 16px; 
                border-radius:20px; 
                font-size:13px; 
                font-weight:bold; 
            }
            .studio-text { 
                color:#8E97A4; 
                margin-bottom:5px; 
                font-size:13px; 
            }
            .studio-name { 
                font-size:22px; 
                font-weight:bold; 
                margin-bottom:20px; 
            }
            .time-wrapper {
                display:flex; 
                gap:10px; 
                margin-bottom:20px; 
                flex-wrap:wrap; 
            }
            .time-btn {
                width:110px;
                height:65px; 
                border:2px solid #334155; 
                border-radius:12px;
                background:#1D2432; 
                color:white; 
                cursor:pointer; 
                transition:0.3s;
                display:flex; 
                flex-direction:column; 
                justify-content:center; 
                align-items:center; 
                gap:2px;
            }
            .time-btn:hover { 
                background:#334155; 
            }
            .time-btn.active { 
                background:#E51919; 
                border-color:#E51919; 
                box-shadow:0 0 12px rgba(229,25,25,0.5); 
            }
            .time-text { 
                font-size:22px; 
                font-weight:bold; 
            }
            .time-hari { 
                font-size:11px; 
                color:#aaa; 
            }
            .time-btn.active .time-hari { 
                color:#ffcccc; 
            }
            .desc { 
                color:#B0B7C3; 
                margin-bottom:20px; 
                font-size:14px; 
            }
            .empty-state { 
                text-align:center; 
                padding:40px 20px; 
                color:#8E97A4; 
            }
            .info-box {
                margin-top:25px; 
                background:#121620; 
                border:1px solid #1E2530; 
                border-radius:15px; 
                padding:20px; 
            }
            .info-box h3 { 
                margin-bottom:12px; 
            }
            .info-box p { 
                color:#B0B7C3; 
                line-height:1.7; 
            }
            .error-banner {
                background:#3D1515; 
                border:1px solid #E51919; 
                border-radius:10px;
                padding:14px 18px; 
                margin-bottom:20px; 
                color:#ffaaaa;
            }
        </style>
    </head>
    <body>

        <%
            List<JadwalTayang> jadwalList = (List<JadwalTayang>) request.getAttribute("jadwalList");
            String namaFilm   = (String) request.getAttribute("namaFilm");
            String namaStudio = (String) request.getAttribute("namaStudio");
            String errorMsg   = (String) request.getAttribute("error");
            if (namaFilm   == null){
                namaFilm   = "-";
            }
            if (namaStudio == null){
                namaStudio = "-";
            }
        %>

        <div class="container">

            <div class="top-bar">
                <a href="${pageContext.request.contextPath}/jadwal?filmId=<%= request.getAttribute("filmId") %>" class="btn-back">← Kembali Pilih Kelas Tiket</a>
                <div class="logo"><span style="color:white;">Movi</span>X</div>
            </div>

            <% if (errorMsg != null) { %>
                <div class="error-banner">⚠️ <%= errorMsg %></div>
            <% } %>

            <div class="main-content">

                <div class="sidebar">
                    <h2>Ringkasan</h2>
                    <div class="info-group">
                        <div class="info-label">Film</div>
                        <div class="info-value" id="sidebarFilm"><%= namaFilm %></div>
                    </div>
                    <div class="info-group">
                        <div class="info-label">Studio</div>
                        <div class="info-value" id="sidebarStudio"><%= namaStudio %></div>
                    </div>
                    <div class="info-group">
                        <div class="info-label">Hari, Jam</div>
                        <div class="info-value" id="selectedTime">Belum dipilih</div>
                    </div>
                    <div class="price-box">
                        <div class="info-label">Harga per Tiket</div>
                        <div class="info-value" id="sidebarHarga">Rp 35.000</div>
                        <form method="post" action="<%= request.getContextPath() %>/jadwal">
                            <input type="hidden" name="tipe"     value="reguler"/>
                            <input type="hidden" name="jadwalId" id="inputJadwalId" value=""/>
                            <button type="submit" class="checkout-btn" id="btnLanjut" disabled>
                                Lanjut ke Pemilihan Kursi
                            </button>
                        </form>
                    </div>
                </div>

                <div class="content">
                    <div class="content-title">Pilih Jadwal Film Reguler</div>

                    <%
                        boolean adaJadwal = (jadwalList != null && !jadwalList.isEmpty());
                        String studioSaatIni = "";
                        boolean cardTerbuka  = false;
                    %>

                    <% if (!adaJadwal) { %>
                        <div class="schedule-card">
                            <div class="empty-state">Tidak ada jadwal reguler yang tersedia saat ini.</div>
                        </div>
                    <% } else {
                        for (int i = 0; i < jadwalList.size(); i++) {
                            JadwalTayang j = (JadwalTayang) jadwalList.get(i);
                            boolean studioBaru = !j.getNamaStudio().equals(studioSaatIni);

                            if (studioBaru) {
                                if (cardTerbuka) { %>
                                        </div>
                                        <div class="desc">Pilih jam tayang yang tersedia.</div>
                                    </div>
                    <%          }
                                studioSaatIni = j.getNamaStudio();
                                cardTerbuka   = true;
                    %>
                                <div class="schedule-card">
                                    <div class="schedule-header">
                                        <h2>Jadwal Reguler</h2>
                                        <div class="badge">Reguler</div>
                                    </div>
                                    <div class="film-title-tag"><%= j.getNamaFilm() %></div>
                                    <div class="studio-text">Studio</div>
                                    <div class="studio-name"><%= studioSaatIni %></div>
                                    <div class="time-wrapper">
                    <%          } %>
                                        <button class="time-btn"
                                                data-id="<%= j.getId() %>"
                                                data-time="<%= j.getJamTayang() %>"
                                                data-hari="<%= j.getHari() %>"
                                                data-harga="<%= j.getHargaFormatted() %>"
                                                data-film="<%= j.getNamaFilm() %>"
                                                data-studio="<%= j.getNamaStudio() %>">
                                            <div class="time-text"><%= j.getJamTayang() %></div>
                                            <div class="time-hari"><%= j.getHari() %></div>
                                        </button>
                    <%      } %>
                                </div>
                                <div class="desc">Pilih jam tayang yang tersedia.</div>
                            </div>
                    <% } %>

                    <div class="info-box">
                        <h3>Keterangan Jadwal</h3>
                        <p>
                            Semua jam tayang adalah waktu setempat.<br>
                            Jadwal dapat berubah sewaktu-waktu.<br>
                            Silakan tiba 15 menit sebelum film dimulai.
                        </p>
                    </div>
                </div>

            </div>
        </div>

        <script>
            var timeButtons   = document.querySelectorAll(".time-btn");
            var selectedTime  = document.getElementById("selectedTime");
            var inputJadwalId = document.getElementById("inputJadwalId");
            var btnLanjut     = document.getElementById("btnLanjut");
            var sidebarHarga  = document.getElementById("sidebarHarga");
            var sidebarStudio = document.getElementById("sidebarStudio");
            var sidebarFilm   = document.getElementById("sidebarFilm");

            for (var i = 0; i < timeButtons.length; i++) {
                timeButtons[i].addEventListener("click", function() {
                    for (var j = 0; j < timeButtons.length; j++) {
                        timeButtons[j].classList.remove("active");
                    }
                    this.classList.add("active");
                    selectedTime.innerText  = this.getAttribute("data-hari") + ", " + this.getAttribute("data-time");
                    sidebarHarga.innerText  = this.getAttribute("data-harga");
                    sidebarStudio.innerText = this.getAttribute("data-studio");
                    sidebarFilm.innerText   = this.getAttribute("data-film"); // Update Nama Film di Sidebar saat diklik
                    inputJadwalId.value     = this.getAttribute("data-id");
                    btnLanjut.disabled      = false;
                });
            }
        </script>
    </body>
</html>
