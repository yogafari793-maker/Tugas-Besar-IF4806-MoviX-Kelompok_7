<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MoviX - Katalog Film</title>
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', Arial, sans-serif;
        }
        body {
            background: #05070D; /* Warna seragam dengan pilih_tiket */
            color: white;
            padding: 20px 30px;
        }

        /* Navbar & Top Bar */
        .top-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            max-width: 1200px;
            margin: 0 auto 30px auto;
            padding-bottom: 20px;
            border-bottom: 1px solid #1E2530;
        }
        .logo {
            font-size: 28px;
            font-weight: bold;
            color: #E51919;
            text-decoration: none;
            letter-spacing: 1px;
        }
        .navbar-nav {
            display: flex;
            gap: 1.5rem;
            align-items: center;
        }
        .nav-link {
            color: #8E97A4;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 8px;
            transition: 0.3s;
        }
        .nav-link:hover {
            color: white;
            background: rgba(255, 255, 255, 0.05);
        }
        .nav-link.active {
            color: white;
            background: rgba(255, 255, 255, 0.1);
        }

        /* Container Layout */
        .container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            gap: 25px;
        }

        /* Sidebar Filter */
        .sidebar {
            width: 260px;
            background: #0B0E14; /* Warna kontainer seragam */
            border: 1px solid #1E2530;
            border-radius: 18px;
            padding: 25px;
            height: fit-content;
        }
        .filter-title {
            font-size: 1.1rem;
            font-weight: 600;
            color: white;
            margin-bottom: 20px;
        }
        .filter-section {
            margin-bottom: 20px;
        }
        .filter-label {
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: #8E97A4;
            margin-bottom: 10px;
            font-weight: 600;
        }
        .filter-options {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }
        .filter-checkbox {
            display: flex;
            align-items: center;
            gap: 10px;
            cursor: pointer;
            color: #8E97A4;
            font-size: 0.95rem;
            transition: color 0.2s;
        }
        .filter-checkbox:hover {
            color: white;
        }
        .filter-checkbox input {
            width: 16px;
            height: 16px;
            accent-color: #E51919;
            cursor: pointer;
        }
        .btn-reset {
            width: 100%;
            padding: 10px;
            background: transparent;
            border: 1px solid #323E4F;
            color: white;
            border-radius: 8px;
            cursor: pointer;
            transition: 0.3s;
            font-weight: 500;
            margin-top: 10px;
        }
        .btn-reset:hover {
            background: #1D2432;
        }

        /* Main Content */
        .main-content {
            flex: 1;
        }
        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 25px;
        }
        .page-title {
            font-size: 24px;
            font-weight: bold;
        }
        .search-box {
            position: relative;
        }
        .search-box i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: #8E97A4;
        }
        .search-input {
            background: #0B0E14;
            border: 1px solid #1E2530;
            padding: 10px 15px 10px 35px;
            border-radius: 8px;
            color: white;
            width: 250px;
            transition: 0.3s;
        }
        .search-input:focus {
            outline: none;
            border-color: #E51919;
        }

        /* Grid Film */
        .movie-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        /* Movie Card (Mengikuti gaya pilih_tiket.jsp) */
        .movie-card {
            background: #0F131D;
            border: 2px solid #1E2530;
            border-radius: 20px;
            padding: 20px;
            display: flex;
            flex-direction: column;
            transition: 0.3s;
            text-decoration: none;
            color: white;
        }
        .movie-card:hover {
            transform: translateY(-4px);
            border-color: #E51919;
            box-shadow: 0 0 20px rgba(229, 25, 25, 0.2);
        }

        .poster-wrapper {
            width: 100%;
            height: 350px;
            border-radius: 12px;
            overflow: hidden;
            margin-bottom: 15px;
            background: #1D2432; /* Fallback color */
        }
        .movie-poster {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        .movie-card:hover .movie-poster {
            transform: scale(1.05);
        }

        .movie-info {
            display: flex;
            flex-direction: column;
            flex: 1;
        }
        .movie-title {
            font-size: 18px;
            font-weight: bold;
            margin-bottom: 8px;
            line-height: 1.3;
        }
        .movie-tags {
            display: flex;
            gap: 8px;
            margin-bottom: 12px;
            flex-wrap: wrap;
        }
        .tag {
            background: #1D2432;
            border: 1px solid #323E4F;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 11px;
            color: #8E97A4;
            font-weight: 600;
        }
        .tag-age {
            background: rgba(229, 25, 25, 0.15);
            color: #E51919;
            border-color: rgba(229, 25, 25, 0.3);
        }
        .movie-desc {
            color: #8E97A4;
            font-size: 13px;
            line-height: 1.5;
            margin-bottom: 20px;
            display: -webkit-box;
            -webkit-line-clamp: 3;
            -webkit-box-orient: vertical;
            overflow: hidden;
            flex: 1;
        }

        /* Tombol Beli */
        .btn-buy {
            display: block;
            text-align: center;
            background: #E51919;
            color: white;
            text-decoration: none;
            padding: 12px;
            border-radius: 8px;
            font-weight: bold;
            transition: 0.3s;
            margin-top: auto;
        }
        .btn-buy:hover {
            background: #cc0000;
        }

        @media (max-width: 900px) {
            .container { flex-direction: column; }
            .sidebar { width: 100%; }
        }
    </style>
</head>
<body>

    <!-- Top Bar Mirip pilih_tiket -->
    <nav class="top-bar">
        <a href="index.html" class="logo"><span style="color:white;">Movi</span>X</a>
        <div class="navbar-nav">
            <a href="index.html" class="nav-link">Beranda</a>
            <a href="katalog" class="nav-link active">Katalog Film</a>
            <a href="#" class="nav-link">Riwayat</a>
            <a href="login.jsp" class="nav-link"><i class="fa-solid fa-sign-out-alt"></i> Keluar</a>
        </div>
    </nav>

    <div class="container">
        <!-- Sidebar Filter -->
        <aside class="sidebar">
            <h2 class="filter-title">Filter Pencarian</h2>
            
            <div class="filter-section">
                <div class="filter-label">Genre</div>
                <div class="filter-options">
                    <label class="filter-checkbox"><input type="checkbox" checked> Semua Genre</label>
                    <label class="filter-checkbox"><input type="checkbox"> Action</label>
                    <label class="filter-checkbox"><input type="checkbox"> Drama</label>
                    <label class="filter-checkbox"><input type="checkbox"> Horror</label>
                    <label class="filter-checkbox"><input type="checkbox"> Komedi</label>
                </div>
            </div>

            <div class="filter-section">
                <div class="filter-label">Rating Usia</div>
                <div class="filter-options">
                    <label class="filter-checkbox"><input type="checkbox" checked> Semua</label>
                    <label class="filter-checkbox"><input type="checkbox"> SU</label>
                    <label class="filter-checkbox"><input type="checkbox"> 13+</label>
                    <label class="filter-checkbox"><input type="checkbox"> 17+</label>
                </div>
            </div>

            <button class="btn-reset">Reset Filter</button>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="header-actions">
                <h1 class="page-title">Sedang Tayang</h1>
                
                <div style="display: flex; gap: 15px; align-items: center;">
                    <div class="search-box">
                        <i class="fa-solid fa-search"></i>
                        <input type="text" class="search-input" placeholder="Cari judul film...">
                    </div>
                    <c:if test="${sessionScope.userRole == 'Admin'}">
                        <a href="<%= request.getContextPath() %>/admin?action=dashboard" 
                           style="background: #E51919; color: white; padding: 10px 20px; border-radius: 8px; font-weight: bold; text-decoration: none; display: flex; align-items: center; gap: 8px;">
                            <i class="fa-solid fa-gear" style="font-size: 18px;"></i> Panel Admin
                        </a>
                        <a href="<%= request.getContextPath() %>/transaksiAdmin.jsp" 
                           style="background: #E51919; color: white; padding: 10px 20px; border-radius: 8px; font-weight: bold; text-decoration: none; display: flex; align-items: center; gap: 8px; margin-left: 10px;">
                            <i class="fa-solid fa-file-invoice" style="font-size: 18px;"></i> Riwayat Transaksi
                        </a>
                    </c:if>
                </div>
            </div>


            <div class="movie-grid">
                <c:choose>
                    <c:when test="${empty daftarFilm}">
                        <div style="color:#8E97A4; grid-column: 1/-1; text-align:center; padding: 50px;">
                            <i class="fa-solid fa-film fa-3x" style="margin-bottom: 15px; opacity:0.5;"></i>
                            <h3>Belum ada film yang tersedia saat ini.</h3>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <c:forEach var="film" items="${daftarFilm}">
                            
                            <div class="movie-card">

                                <div class="poster-wrapper">
                                    <c:choose>
                                        <c:when test="${not empty film.posterUrl}">
                                            <img src="${film.posterUrl}" alt="${film.judul}" class="movie-poster">
                                        </c:when>
                                        <c:otherwise>

                                            <div style="width:100%; height:100%; display:flex; align-items:center; justify-content:center; background:#1D2432;">
                                                <i class="fa-solid fa-image fa-3x" style="color:#323E4F;"></i>
                                            </div>
                                        </c:otherwise>
                                    </c:choose>
                                </div>


                                <div class="movie-info">
                                    <h2 class="movie-title">${film.judul}</h2>
                                    
                                    <div class="movie-tags">
                                        <span class="tag">${film.genre}</span>
                                        <span class="tag">${film.durasi} Menit</span>
                                        <span class="tag tag-age">${film.ratingUsia}</span>
                                    </div>
                                    
                                    <p class="movie-desc">
                                        ${film.sinopsis}
                                    </p>
                                    

                                    <a href="${pageContext.request.contextPath}/jadwal?filmId=${film.id}" class="btn-buy">
                                        Pilih Jadwal & Tiket
                                    </a>
                                </div>
                            </div>
                            
                        </c:forEach>
                    </c:otherwise>
                </c:choose>
            </div>
            
        </main>
    </div>

</body>
</html>
