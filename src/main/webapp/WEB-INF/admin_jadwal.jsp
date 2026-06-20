<%@page contentType="text/html" pageEncoding="UTF-8"
        import="java.util.List, model.JadwalTayang, model.Film"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Panel Admin: Kelola Data - MoviX</title>
        <style>
            * { margin: 0; padding: 0; box-sizing: border-box; font-family: Arial, Helvetica, sans-serif; }
            body { background: #05070D; color: white; padding: 30px; }
            .container { max-width: 1400px; margin: 0 auto; background: #0B0E14; border: 1px solid #1E2530; border-radius: 18px; padding: 30px; }
            .header-admin { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; border-bottom: 1px solid #1E2530; padding-bottom: 20px; position: relative; }
            .header-admin .btn-back { padding: 10px 18px; background: #1D2432; border: 1px solid #323E4F; border-radius: 8px; color: white; text-decoration: none; font-size: 14px; font-weight: bold; }
            .header-admin .btn-back:hover { background: #323E4F; }
            .logo { font-size: 28px; font-weight: bold; color: #E51919; } .logo span { color: white; }
            .badge-admin { background: #E51919; color: white; padding: 5px 12px; border-radius: 6px; font-size: 12px; font-weight: bold; text-transform: uppercase; }
            
            .tab-buttons { display: flex; gap: 10px; margin-bottom: 20px; }
            .tab-btn { padding: 10px 20px; background: #1D2432; border: none; color: white; border-radius: 8px; cursor: pointer; font-weight: bold; }
            .tab-btn.active { background: #E51919; }
            .tab-content { display: none; }
            .tab-content.active { display: block; }
            
            .main-grid { display: flex; gap: 30px; }
            .form-section { width: 350px; background: #0F131D; border: 1px solid #1E2530; border-radius: 15px; padding: 25px; flex-shrink: 0; height: fit-content; }
            .form-section h3 { font-size: 20px; margin-bottom: 20px; color: #E51919; }
            .form-group { margin-bottom: 15px; }
            .form-group label { display: block; font-size: 13px; color: #8E97A4; margin-bottom: 6px; }
            .form-control { width: 100%; padding: 10px 14px; background: #1D2432; border: 1px solid #323E4F; border-radius: 8px; color: white; outline: none; }
            .btn-submit { width: 100%; padding: 12px; background: #E51919; border: none; border-radius: 8px; color: white; font-weight: bold; cursor: pointer; margin-top: 10px; }
            .btn-submit:hover { background: #b81414; }
            .btn-cancel { width: 100%; padding: 10px; background: #1D2432; border: 1px solid #323E4F; border-radius: 8px; color: white; cursor: pointer; margin-top: 8px; display: none; }
            
            .table-section { flex: 1; background: #0F131D; border: 1px solid #1E2530; border-radius: 15px; padding: 25px; }
            .data-table { width: 100%; border-collapse: collapse; text-align: left; font-size: 14px; }
            .data-table th { padding: 12px; background: #121620; color: #8E97A4; border-bottom: 1px solid #1E2530; }
            .data-table td { padding: 14px 12px; border-bottom: 1px solid #1E2530; color: #B0B7C3; }
            
            .action-btn { padding: 6px 10px; border-radius: 6px; font-size: 12px; text-decoration: none; font-weight: bold; cursor: pointer; border: none; margin-right: 5px; }
            .btn-edit { background: #3b82f6; color: white; }
            .btn-delete { background: #ef4444; color: white; }
            .alert-success { padding: 12px; background: #143220; border: 1px solid #22c55e; color: #a3e635; border-radius: 8px; margin-bottom: 20px; }
        </style>
    </head>
    <body>
        <div class="container">
            <div class="header-admin">
                <a href="<%= request.getContextPath() %>/katalog" class="btn-back">&larr; Kembali ke Katalog</a>
                <div><span class="badge-admin">Admin Dashboard</span></div>
                <div class="logo"><span>Movi</span>X</div>
            </div>

            <c:if test="${not empty success}">
                <div class="alert-success">&#10003; ${success}</div>
            </c:if>

            <div class="tab-buttons">
                <button class="tab-btn active" onclick="openTab('tab-jadwal')">Kelola Jadwal</button>
                <button class="tab-btn" onclick="openTab('tab-film')">Kelola Film</button>
            </div>

            <!-- TAB JADWAL -->
            <div id="tab-jadwal" class="tab-content active">
                <div class="main-grid">
                    <div class="form-section">
                        <h3 id="formTitleJadwal">Tambah Jadwal</h3>
                        <form id="formJadwal" method="POST" action="<%= request.getContextPath() %>/admin">
                            <input type="hidden" name="action" id="actionJadwal" value="insertJadwal" />
                            <input type="hidden" name="id" id="jadwalId" value="" />
                            
                            <div class="form-group">
                                <label>Pilih Film</label>
                                <select name="filmId" id="jadwalFilmId" class="form-control" required>
                                    <c:forEach var="f" items="${semuaFilm}">
                                        <option value="${f.id}">${f.id} - ${f.judul}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Pilih Studio</label>
                                <select name="studioId" id="studioId" class="form-control" required>
                                    <option value="1">Studio 1 (Reguler)</option>
                                    <option value="2">Studio 2 (Premiere)</option>
                                    <option value="3">Studio 3 (Reguler)</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Hari Tayang</label>
                                <select name="hari" id="hari" class="form-control" required>
                                    <option value="Senin">Senin</option><option value="Selasa">Selasa</option>
                                    <option value="Rabu">Rabu</option><option value="Kamis">Kamis</option>
                                    <option value="Jumat">Jumat</option><option value="Sabtu">Sabtu</option>
                                    <option value="Minggu">Minggu</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Jam Tayang</label>
                                <input type="text" name="jamTayang" id="jamTayang" class="form-control" placeholder="HH:MM" required />
                            </div>
                            <div class="form-group">
                                <label>Harga Tiket (Rp)</label>
                                <input type="number" name="harga" id="harga" class="form-control" required />
                            </div>
                            <button type="submit" id="btnSubmitJadwal" class="btn-submit">Simpan Jadwal</button>
                            <button type="button" id="btnCancelJadwal" class="btn-cancel" onclick="resetFormJadwal()">Batal</button>
                        </form>
                    </div>

                    <div class="table-section">
                        <h3>Daftar Jadwal Tayang</h3>
                        <table class="data-table">
                            <thead>
                                <tr><th>ID</th><th>Judul Film</th><th>Studio</th><th>Waktu</th><th>Harga</th><th>Aksi</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach var="j" items="${semuaJadwal}">
                                    <tr>
                                        <td>${j.id}</td>
                                        <td style="color:white; font-weight:bold;">${j.namaFilm}</td>
                                        <td>${j.namaStudio}</td>
                                        <td><span style="color:#22c55e;">${j.hari}</span>, ${j.jamTayang}</td>
                                        <td>Rp ${j.harga}</td>
                                        <td>
                                            <button class="action-btn btn-edit" onclick="editJadwal('${j.id}','${j.filmId}','${j.studioId}','${j.hari}','${j.jamTayang}','${j.harga}')">Edit</button>
                                            <a class="action-btn btn-delete" href="<%= request.getContextPath() %>/admin?action=deleteJadwal&id=${j.id}" onclick="return confirm('Hapus jadwal ini?')">Hapus</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

            <!-- TAB FILM -->
            <div id="tab-film" class="tab-content">
                <div class="main-grid">
                    <div class="form-section">
                        <h3 id="formTitleFilm">Tambah Film</h3>
                        <form id="formFilm" method="POST" action="<%= request.getContextPath() %>/admin">
                            <input type="hidden" name="action" id="actionFilm" value="insertFilm" />
                            <input type="hidden" name="filmIdEdit" id="filmIdEdit" value="" />
                            
                            <div class="form-group">
                                <label>Judul Film</label>
                                <input type="text" name="judulFilm" id="judulFilm" class="form-control" required />
                            </div>
                            <div class="form-group">
                                <label>Genre</label>
                                <input type="text" name="genreFilm" id="genreFilm" class="form-control" required />
                            </div>
                            <div class="form-group">
                                <label>Durasi (Menit)</label>
                                <input type="number" name="durasiFilm" id="durasiFilm" class="form-control" required />
                            </div>
                            <div class="form-group">
                                <label>Rating Usia</label>
                                <select name="ratingUsia" id="ratingUsia" class="form-control" required>
                                    <option value="SU">SU (Semua Umur)</option>
                                    <option value="13+">13+</option>
                                    <option value="17+">17+</option>
                                    <option value="21+">21+</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>Sinopsis</label>
                                <textarea name="sinopsis" id="sinopsis" class="form-control" rows="3" required></textarea>
                            </div>
                            <div class="form-group">
                                <label>URL Poster</label>
                                <input type="text" name="posterUrl" id="posterUrl" class="form-control" placeholder="Contoh: images/posters/avatar.jpg" required />
                            </div>
                            <button type="submit" id="btnSubmitFilm" class="btn-submit">Simpan Film</button>
                            <button type="button" id="btnCancelFilm" class="btn-cancel" onclick="resetFormFilm()">Batal</button>
                        </form>
                    </div>

                    <div class="table-section">
                        <h3>Daftar Film Master</h3>
                        <table class="data-table">
                            <thead>
                                <tr><th>ID</th><th>Judul</th><th>Genre</th><th>Durasi</th><th>Rating</th><th>Aksi</th></tr>
                            </thead>
                            <tbody>
                                <c:forEach var="f" items="${semuaFilm}">
                                    <tr>
                                        <td>${f.id}</td>
                                        <td style="color:white; font-weight:bold;">${f.judul}</td>
                                        <td>${f.genre}</td>
                                        <td>${f.durasi} mnt</td>
                                        <td>${f.ratingUsia}</td>
                                        <td>
                                            <button class="action-btn btn-edit" data-sinopsis="<c:out value='${f.sinopsis}'/>" onclick="editFilm('${f.id}','${f.judul}','${f.genre}','${f.durasi}','${f.ratingUsia}','${f.posterUrl}', this.getAttribute('data-sinopsis'))">Edit</button>
                                            <a class="action-btn btn-delete" href="<%= request.getContextPath() %>/admin?action=deleteFilm&id=${f.id}" onclick="return confirm('Hapus film ini?')">Hapus</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function openTab(tabId) {
                document.querySelectorAll('.tab-content').forEach(t => t.classList.remove('active'));
                document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
                document.getElementById(tabId).classList.add('active');
                event.currentTarget.classList.add('active');
            }

            function editJadwal(id, filmId, studioId, hari, jam, harga) {
                document.getElementById('formTitleJadwal').innerText = 'Edit Jadwal #' + id;
                document.getElementById('actionJadwal').value = 'updateJadwal';
                document.getElementById('jadwalId').value = id;
                document.getElementById('jadwalFilmId').value = filmId;
                document.getElementById('studioId').value = studioId;
                document.getElementById('hari').value = hari;
                document.getElementById('jamTayang').value = jam;
                document.getElementById('harga').value = parseInt(parseFloat(harga));
                document.getElementById('btnSubmitJadwal').innerText = 'Simpan Perubahan';
                document.getElementById('btnCancelJadwal').style.display = 'block';
            }

            function resetFormJadwal() {
                document.getElementById('formTitleJadwal').innerText = 'Tambah Jadwal';
                document.getElementById('actionJadwal').value = 'insertJadwal';
                document.getElementById('formJadwal').reset();
                document.getElementById('btnSubmitJadwal').innerText = 'Simpan Jadwal';
                document.getElementById('btnCancelJadwal').style.display = 'none';
            }

            function editFilm(id, judul, genre, durasi, rating, poster, sinopsis) {
                document.getElementById('formTitleFilm').innerText = 'Edit Film #' + id;
                document.getElementById('actionFilm').value = 'updateFilm';
                document.getElementById('filmIdEdit').value = id;
                document.getElementById('judulFilm').value = judul;
                document.getElementById('genreFilm').value = genre;
                document.getElementById('durasiFilm').value = durasi;
                document.getElementById('ratingUsia').value = rating;
                document.getElementById('posterUrl').value = poster;
                document.getElementById('sinopsis').value = sinopsis;
                document.getElementById('btnSubmitFilm').innerText = 'Simpan Perubahan';
                document.getElementById('btnCancelFilm').style.display = 'block';
            }

            function resetFormFilm() {
                document.getElementById('formTitleFilm').innerText = 'Tambah Film';
                document.getElementById('actionFilm').value = 'insertFilm';
                document.getElementById('formFilm').reset();
                document.getElementById('btnSubmitFilm').innerText = 'Simpan Film';
                document.getElementById('btnCancelFilm').style.display = 'none';
            }
        </script>
    </body>
</html>
