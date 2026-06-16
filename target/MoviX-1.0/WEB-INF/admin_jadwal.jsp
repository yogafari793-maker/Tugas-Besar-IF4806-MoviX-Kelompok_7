<%-- 
    Document   : admin_jadwal
    Created on : 16 Jun 2026, 11.36.17
    Author     : ghifa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"
        import="java.util.List, model.JadwalTayang, java.util.ArrayList, dao.JadwalDAO"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Panel Admin: Kelola Jadwal — MoviX</title>
        <style>
            * { 
                margin: 0; 
                padding: 0; 
                box-sizing: border-box; 
                font-family: Arial, Helvetica, sans-serif; 
            }
            body { 
                background: #05070D; 
                color: white; 
                padding: 30px; 
            }
            .container { 
                max-width: 1200px; 
                margin: 0 auto; 
                background: #0B0E14; 
                border: 1px solid #1E2530; 
                border-radius: 18px; 
                padding: 30px; 
            }
            .header-admin { 
                display: flex; 
                justify-content: space-between; 
                align-items: center; 
                margin-bottom: 30px; 
                border-bottom: 1px solid #1E2530; 
                padding-bottom: 20px; 
                position: relative; 
            }
            .header-admin .btn-back { 
                padding: 10px 18px; 
                background: #1D2432; 
                border: 1px solid #323E4F; 
                border-radius: 8px; 
                color: white; 
                cursor: pointer; 
                transition: 0.3s; 
                text-decoration: none; 
                display: inline-block; 
                font-size: 14px; 
                font-weight: bold; 
            }
            .header-admin .btn-back:hover { 
                background: #323E4F; 
            }
            .logo { 
                font-size: 28px; 
                font-weight: bold; 
                color: #E51919; 
            }
            .logo span { 
                color: white; 
            }
            .admin-center-title { 
                position: absolute; 
                left: 50%; 
                transform: translateX(-50%); 
                display: flex; 
                align-items: center; 
            }
            .badge-admin { 
                background: #E51919; 
                color: white; 
                padding: 5px 12px; 
                border-radius: 6px; 
                font-size: 12px; 
                font-weight: bold; 
                text-transform: uppercase; 
            }
            .main-grid { 
                display: flex; 
                gap: 30px; 
            }
            .form-section { 
                width: 350px; 
                background: #0F131D; 
                border: 1px solid #1E2530; 
                border-radius: 15px; 
                padding: 25px; 
                flex-shrink: 0; 
                height: fit-content; 
            }
            .form-section h3 { 
                font-size: 20px; 
                margin-bottom: 20px; 
                color: #E51919; 
            }
            .form-group { 
                margin-bottom: 15px; 
            }
            .form-group label { 
                display: block; 
                font-size: 13px; 
                color: #8E97A4; 
                margin-bottom: 6px; 
            }
            .form-control { 
                width: 100%; 
                padding: 10px 14px; 
                background: #1D2432; 
                border: 1px solid #323E4F; 
                border-radius: 8px; 
                color: white; 
                font-size: 14px; 
                outline: none; 
            }
            .form-control:focus { 
                border-color: #E51919; 
            }
            .input-group-row { 
                display: flex; 
                gap: 8px; 
            }
            .btn-inline-add { 
                background: #14532d; 
                border: 1px solid #22c55e; 
                color: #22c55e; 
                border-radius: 8px; 
                width: 42px; 
                height: 39px; 
                font-size: 18px; 
                font-weight: bold; 
                cursor: pointer; 
                transition: 0.3s; 
                display: flex; 
                align-items: center; 
                justify-content: center; 
                flex-shrink: 0; 
            }
            .btn-inline-add:hover { 
                background: #22c55e; 
                color: white; 
            }
            .btn-submit { 
                width: 100%; 
                padding: 12px; 
                background: #E51919; 
                border: none; 
                border-radius: 8px; 
                color: white; 
                font-weight: bold; 
                font-size: 15px; 
                cursor: pointer; 
                transition: 0.3s; 
                margin-top: 10px; 
            }
            .btn-submit:hover { 
                background: #b81414; 
            }
            .btn-cancel { 
                width: 100%; 
                padding: 10px; 
                background: #1D2432; 
                border: 1px solid #323E4F; 
                border-radius: 8px; 
                color: white; 
                font-size: 13px; 
                cursor: pointer; 
                margin-top: 8px; 
                display: none; 
            }
            .table-section { 
                flex: 1; 
                background: #0F131D; 
                border: 1px solid #1E2530; 
                border-radius: 15px; 
                padding: 25px; 
            }
            .table-section h3 { 
                font-size: 20px; 
                margin-bottom: 20px; 
            }
            .data-table { 
                width: 100%; 
                border-collapse: collapse; 
                text-align: left; 
                font-size: 14px; 
            }
            .data-table th { 
                padding: 12px 16px; 
                background: #121620; 
                color: #8E97A4; 
                border-bottom: 1px solid #1E2530; 
                font-weight: bold; 
            }
            .data-table td { 
                padding: 14px 16px; 
                border-bottom: 1px solid #1E2530; 
                color: #B0B7C3; 
            }
            .badge-class { 
                padding: 4px 8px; 
                border-radius: 4px; 
                font-size: 11px; 
                font-weight: bold; 
                text-transform: uppercase; 
            }
            .badge-reguler { 
                background: #1D2432; 
                color: #8E97A4; 
                border: 1px solid #323E4F; 
            }
            .badge-premier { 
                background: #3D1515; 
                color: #E51919; 
                border: 1px solid #5C1313; 
            }
            .action-btn { 
                padding: 6px 10px; 
                border-radius: 6px; 
                font-size: 12px; 
                text-decoration: none; 
                font-weight: bold; 
                cursor: pointer; 
                display: inline-block; 
                margin-right: 8px; 
                border: none; 
            }
            .btn-edit { 
                background: #3b82f6; 
                color: white; 
                margin-bottom: 5px;
            }
            .btn-edit:hover { 
                background: #2563eb; 
            }
            .btn-delete { 
                background: #ef4444; 
                color: white; 
            }
            .btn-delete:hover { 
                background: #dc2626; 
            }
            .alert { 
                padding: 12px; 
                border-radius: 8px; 
                margin-bottom: 20px; 
                font-size: 14px; 
            }
            .alert-success { 
                background: #143220; 
                border: 1px solid #22c55e; 
                color: #a3e635; 
            }
            .modal-overlay { 
                position: fixed; 
                top: 0; 
                left: 0; 
                width: 100%; 
                height: 100%; 
                background: rgba(0, 0, 0, 0.75); 
                backdrop-filter: blur(4px); 
                display: flex; 
                align-items: center; 
                justify-content: center; 
                z-index: 1000; 
                display: none; 
            }
            .modal-box { 
                background: #0B0E14; 
                border: 1px solid #1E2530; 
                width: 400px; 
                border-radius: 16px; 
                padding: 25px; 
                box-shadow: 0 10px 30px rgba(0,0,0,0.5); 
            }
            .modal-header { 
                display: flex; 
                justify-content: space-between; 
                align-items: center; 
                margin-bottom: 20px; 
                padding-bottom: 10px; 
                border-bottom: 1px solid #1E2530; 
            }
            .modal-header h4 { 
                font-size: 18px; 
                color: white; 
            }
            .btn-close-modal { 
                background: transparent; 
                border: none; 
                color: #8E97A4; 
                font-size: 20px; 
                cursor: pointer; 
            }
            .btn-close-modal:hover { 
                color: #E51919; 
            }
        </style>
    </head>
    <body>
        <%
            List<JadwalTayang> listJadwal = (List<JadwalTayang>) request.getAttribute("semuaJadwal");
            String successMsg = (String) request.getAttribute("success");
            
            if(listJadwal == null) {
                JadwalDAO dao = new JadwalDAO();
                listJadwal = dao.getByTipe("reguler");
                listJadwal.addAll(dao.getByTipe("premier"));
            }
        %>
        
        <div class="container">
            <div class="header-admin">
                <a href="<%= request.getContextPath() %>/index.jsp" class="btn-back">← Lihat Website Utama</a>
                <div class="admin-center-title">
                    <span class="badge-admin" style="font-size: 14px; padding: 6px 16px;">Admin Panel</span>
                </div>
                <div class="logo"><span>Movi</span>X</div>
            </div>

            <% if (successMsg != null) { %>
                <div class="alert alert-success">✓ <%= successMsg %></div>
            <% } %>

            <div class="main-grid">
                <div class="form-section">
                    <h3 id="formTitle">Tambah Jadwal Waktu</h3>
                    <form id="adminForm" method="POST" action="<%= request.getContextPath() %>/jadwal?action=insert">
                        <input type="hidden" name="id" id="jadwalId" value="" />
                        
                        <div class="form-group">
                            <label>Pilih Film</label>
                            <div class="input-group-row">
                                <select name="filmId" id="filmId" class="form-control" required>
                                    <option value="1">1 - Avengers: Secret Wars</option>
                                    <option value="2">2 - Interstellar 2</option>
                                    <option value="3">3 - KKN di Desa Penari 2</option>
                                    <option value="4">4 - Spider-Man: Beyond the Spider-Verse</option>
                                    <option value="5">5 - Dune: Part Three</option>
                                    <option value="6">6 - The Conjuring: Last Rites</option>
                                    <option value="7">7 - Gundala</option>
                                    <option value="8">8 - The Batman - Part II</option>
                                    <option value="9">9 - Fast X: Part 2</option>
                                </select>
                                <button type="button" class="btn-inline-add" title="Tambah Film Baru" onclick="openModal()">+</button>
                            </div>
                        </div>
                        
                        <div class="form-group">
                            <label>Pilih Studio</label>
                            <select name="studioId" id="studioId" class="form-control" required>
                                <option value="1">Studio 1 (Reguler)</option>
                                <option value="2">Studio 2 (Reguler)</option>
                                <option value="3">Studio 3 (Reguler)</option>
                                <option value="4">Studio 4 (Reguler)</option>
                                <option value="5">Studio Premier 1 (Premier)</option>
                                <option value="6">Studio Premier 2 (Premier)</option>
                                <option value="7">Studio Premier 3 (Premier)</option>
                                <option value="8">Studio Premier 4 (Premier)</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label>Hari Tayang</label>
                            <select name="hari" id="hari" class="form-control" required>
                                <option value="Senin">Senin</option>
                                <option value="Selasa">Selasa</option>
                                <option value="Rabu">Rabu</option>
                                <option value="Kamis">Kamis</option>
                                <option value="Jumat">Jumat</option>
                                <option value="Sabtu">Sabtu</option>
                                <option value="Minggu">Minggu</option>
                            </select>
                        </div>
                        
                        <div class="form-group">
                            <label>Jam Tayang</label>
                            <input type="text" name="jamTayang" id="jamTayang" class="form-control" placeholder="HH:MM" required />
                        </div>
                        
                        <div class="form-group">
                            <label>Harga Tiket (Rp)</label>
                            <input type="number" name="harga" id="harga" class="form-control" placeholder="Contoh: 35000" required />
                        </div>
                        
                        <button type="submit" id="btnSubmit" class="btn-submit">+ Tambah ke Database</button>
                        <button type="button" id="btnCancel" class="btn-cancel" onclick="resetForm()">Batal Edit</button>
                    </form>
                </div>

                <div class="table-section">
                    <h3>Daftar Seluruh Jadwal Tayang aktif</h3>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Judul Film</th>
                                <th>Studio</th>
                                <th>Waktu</th>
                                <th>Harga</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% if(listJadwal.isEmpty()) { %>
                                <tr><td colspan="6" style="text-align:center; color:#8E97A4;">Belum ada jadwal tayang dalam database.</td></tr>
                            <% } else {
                                for(JadwalTayang j : listJadwal) { %>
                                    <tr>
                                        <td><%= j.getId() %></td>
                                        <td style="color:white; font-weight:bold;"><%= j.getNamaFilm() %></td>
                                        <td><%= j.getNamaStudio() %></td>
                                        <td><span style="color:#22c55e;"><%= j.getHari() %></span>, <%= j.getJamTayang() %></td>
                                        <td><%= j.getHargaFormatted() %></td>
                                        <td>
                                            <button class="action-btn btn-edit" 
                                                    onclick="prepareEdit('<%= j.getId() %>', '<%= j.getFilmId() %>', '<%= j.getStudioId() %>', '<%= j.getHari() %>', '<%= j.getJamTayang() %>', '<%= (long)j.getHarga() %>')">
                                                Edit
                                            </button>
                                            <a class="action-btn btn-delete" 
                                               href="<%= request.getContextPath() %>/jadwal?action=delete&id=<%= j.getId() %>" 
                                               onclick="return confirm('Apakah Anda yakin ingin menghapus jadwal ini?')">
                                                Hapus
                                            </a>
                                        </td>
                                    </tr>
                            <%   }
                               } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="modal-overlay" id="filmModal">
            <div class="modal-box">
                <div class="modal-header">
                    <h4>Tambah Film Baru</h4>
                    <button type="button" class="btn-close-modal" onclick="closeModal()">×</button>
                </div>
                <form method="POST" action="<%= request.getContextPath() %>/jadwal?action=insertFilm">
                    <div class="form-group">
                        <label>Judul Film</label>
                        <input type="text" name="judulFilm" class="form-control" placeholder="Contoh: Avatar 3" required />
                    </div>
                    <div class="form-group">
                        <label>Genre</label>
                        <input type="text" name="genreFilm" class="form-control" placeholder="Contoh: Action, Adventure" required />
                    </div>
                    <div class="form-group">
                        <label>Durasi (Menit)</label>
                        <input type="number" name="durasiFilm" class="form-control" placeholder="Contoh: 150" required />
                    </div>
                    <button type="submit" class="btn-submit">+ Daftarkan Film</button>
                </form>
            </div>
        </div>

        <script>
            function openModal() {
                document.getElementById("filmModal").style.display = "flex";
            }
            // Penutupan Modal Pop-up
            function closeModal() {
                document.getElementById("filmModal").style.display = "none";
            }

            function prepareEdit(id, filmId, studioId, hari, jam, harga) {
                document.getElementById("formTitle").innerText = "Edit Jadwal Waktu #" + id;
                document.getElementById("btnSubmit").innerText = "Simpan Perubahan";
                document.getElementById("btnCancel").style.display = "block";
                document.getElementById("adminForm").action = "<%= request.getContextPath() %>/jadwal?action=update";
                
                document.getElementById("jadwalId").value = id;
                document.getElementById("filmId").value = filmId;
                document.getElementById("studioId").value = studioId;
                document.getElementById("hari").value = hari;
                document.getElementById("jamTayang").value = jam;
                document.getElementById("harga").value = harga;
            }

            function resetForm() {
                document.getElementById("formTitle").innerText = "Tambah Jadwal Waktu";
                document.getElementById("btnSubmit").innerText = "+ Tambah ke Database";
                document.getElementById("btnCancel").style.display = "none";
                document.getElementById("adminForm").action = "<%= request.getContextPath() %>/jadwal?action=insert";
                document.getElementById("adminForm").reset();
                document.getElementById("jadwalId").value = "";
            }
        </script>
    </body>
</html>