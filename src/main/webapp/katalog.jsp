<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MoviX - Katalog Film</title>
    <!-- Google Fonts: Inter -->
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --bg-color: #0b0f19;
            --surface-color: #151a28;
            --primary-color: #e60000;
            --primary-hover: #cc0000;
            --accent-color: #e60000;
            --text-main: #f0f6fc;
            --text-muted: #8b949e;
            --border-color: rgba(255, 255, 255, 0.08);
            --glass-bg: rgba(21, 26, 40, 0.7);
            --radius-md: 12px;
            --radius-lg: 16px;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', sans-serif;
        }

        body {
            background-color: var(--bg-color);
            color: var(--text-main);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Navbar */
        .navbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 3rem;
            background: var(--glass-bg);
            backdrop-filter: blur(10px);
            border-bottom: 1px solid var(--border-color);
            position: sticky;
            top: 0;
            z-index: 100;
        }

        .navbar-brand {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--accent-color);
            text-decoration: none;
            letter-spacing: 1px;
        }

        .navbar-nav {
            display: flex;
            gap: 1.5rem;
        }

        .nav-link {
            color: var(--text-muted);
            text-decoration: none;
            font-weight: 500;
            padding: 0.5rem 1rem;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .nav-link:hover {
            color: var(--text-main);
            background: rgba(255, 255, 255, 0.05);
        }

        .nav-link.active {
            color: var(--text-main);
            background: rgba(255, 255, 255, 0.1);
        }

        /* Layout Container */
        .container {
            display: flex;
            flex: 1;
            padding: 2rem 3rem;
            gap: 2rem;
            max-width: 1400px;
            margin: 0 auto;
            width: 100%;
        }

        /* Sidebar Filter */
        .sidebar {
            width: 250px;
            flex-shrink: 0;
            background: var(--surface-color);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            border: 1px solid var(--border-color);
            height: fit-content;
        }

        .filter-section {
            margin-bottom: 1.5rem;
        }

        .filter-title {
            font-size: 0.9rem;
            text-transform: uppercase;
            letter-spacing: 1px;
            color: var(--text-muted);
            margin-bottom: 1rem;
            font-weight: 600;
        }

        .filter-options {
            display: flex;
            flex-direction: column;
            gap: 0.5rem;
        }

        .filter-checkbox {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            cursor: pointer;
            color: var(--text-main);
            font-size: 0.95rem;
        }

        .filter-checkbox input {
            appearance: none;
            width: 18px;
            height: 18px;
            border: 2px solid var(--text-muted);
            border-radius: 4px;
            background: transparent;
            cursor: pointer;
            transition: all 0.2s;
            position: relative;
        }

        .filter-checkbox input:checked {
            background: var(--primary-color);
            border-color: var(--primary-color);
        }

        .filter-checkbox input:checked::after {
            content: '\f00c';
            font-family: 'FontAwesome';
            position: absolute;
            color: white;
            font-size: 10px;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .btn-reset {
            width: 100%;
            padding: 0.75rem;
            background: transparent;
            border: 1px solid var(--border-color);
            color: var(--text-main);
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.3s;
            font-weight: 500;
        }

        .btn-reset:hover {
            background: rgba(255, 255, 255, 0.05);
        }

        /* Main Content */
        .main-content {
            flex: 1;
        }

        .header-actions {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 1.75rem;
            font-weight: 700;
        }

        .search-container {
            display: flex;
            gap: 1rem;
            align-items: center;
        }

        .search-box {
            position: relative;
        }

        .search-box i {
            position: absolute;
            left: 12px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
        }

        .search-input {
            background: var(--surface-color);
            border: 1px solid var(--border-color);
            padding: 0.6rem 1rem 0.6rem 2.5rem;
            border-radius: 8px;
            color: white;
            width: 250px;
            transition: border-color 0.3s;
        }

        .search-input:focus {
            outline: none;
            border-color: var(--primary-color);
        }

        .btn-add {
            background: var(--primary-color);
            color: white;
            border: none;
            padding: 0.6rem 1rem;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 0.5rem;
            transition: background 0.3s;
        }

        .btn-add:hover {
            background: var(--primary-hover);
        }

        /* Movie List */
        .movie-list {
            display: flex;
            flex-direction: column;
            gap: 1.5rem;
        }

        .movie-card {
            display: flex;
            background: var(--surface-color);
            border-radius: var(--radius-lg);
            padding: 1.5rem;
            gap: 1.5rem;
            border: 1px solid var(--border-color);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .movie-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.3);
            border-color: rgba(255, 255, 255, 0.15);
        }

        .movie-poster {
            width: 140px;
            height: 200px;
            background: #2a2f42;
            border-radius: var(--radius-md);
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text-muted);
            font-size: 0.9rem;
            flex-shrink: 0;
            overflow: hidden;
            position: relative;
        }
        
        .movie-poster::after {
            content: '';
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background: linear-gradient(to bottom, transparent, rgba(0,0,0,0.7));
            opacity: 0.5;
        }

        .movie-info {
            flex: 1;
            display: flex;
            flex-direction: column;
        }

        .movie-title {
            font-size: 1.4rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }

        .movie-tags {
            display: flex;
            gap: 0.5rem;
            margin-bottom: 1rem;
        }

        .tag {
            background: rgba(255, 255, 255, 0.1);
            padding: 0.2rem 0.6rem;
            border-radius: 4px;
            font-size: 0.8rem;
            color: var(--text-muted);
        }

        .movie-synopsis {
            color: var(--text-muted);
            font-size: 0.95rem;
            line-height: 1.5;
            margin-bottom: 1.5rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .movie-footer {
            margin-top: auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-top: 1px solid var(--border-color);
            padding-top: 1rem;
        }

        .schedules {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }
        
        .schedule-lbl {
            font-size: 0.85rem;
            color: var(--text-muted);
            margin-right: 0.5rem;
        }

        .time-badge {
            background: rgba(59, 130, 246, 0.15);
            color: var(--primary-color);
            padding: 0.4rem 0.8rem;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: 600;
            border: 1px solid rgba(59, 130, 246, 0.3);
        }

        .btn-order {
            background: var(--accent-color);
            color: white;
            border: none;
            padding: 0.6rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            text-decoration: none;
        }

        .btn-order:hover {
            background: #e11d48;
            transform: scale(1.05);
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: flex-end;
            gap: 0.5rem;
            margin-top: 2rem;
        }

        .btn-page {
            background: var(--surface-color);
            border: 1px solid var(--border-color);
            color: var(--text-main);
            padding: 0.5rem 1rem;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-page:hover {
            background: rgba(255,255,255,0.1);
        }
        
        .btn-page:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        /* Responsive */
        @media (max-width: 900px) {
            .container {
                flex-direction: column;
            }
            .sidebar {
                width: 100%;
            }
            .movie-card {
                flex-direction: column;
            }
            .movie-poster {
                width: 100%;
                height: 250px;
            }
            .movie-footer {
                flex-direction: column;
                gap: 1rem;
                align-items: flex-start;
            }
        }
    </style>
</head>
<body>

    <!-- Top Navigation -->
    <nav class="navbar">
        <a href="index.html" class="navbar-brand" style="color: white; font-size: 1.8rem; font-weight: 800; letter-spacing: 0;">
            Movi<span style="color: var(--primary-color);">X</span>
        </a>
        <div class="navbar-nav">
            <a href="index.html" class="nav-link">Beranda</a>
            <a href="katalog.jsp" class="nav-link active">Katalog Film</a>
            <a href="#" class="nav-link">Riwayat</a>
            <a href="login.jsp" class="nav-link"><i class="fa-solid fa-sign-out-alt"></i> Keluar</a>
        </div>
    </nav>

    <div class="container">
        <!-- Sidebar Filter -->
        <aside class="sidebar">
            <h2 class="filter-title" style="color: var(--text-main); font-size: 1.1rem; margin-bottom: 1.5rem;">Filter Film</h2>
            
            <div class="filter-section">
                <div class="filter-title">Genre</div>
                <div class="filter-options">
                    <label class="filter-checkbox">
                        <input type="checkbox" checked> Semua Genre
                    </label>
                    <label class="filter-checkbox">
                        <input type="checkbox"> Action
                    </label>
                    <label class="filter-checkbox">
                        <input type="checkbox"> Drama
                    </label>
                    <label class="filter-checkbox">
                        <input type="checkbox"> Horror
                    </label>
                    <label class="filter-checkbox">
                        <input type="checkbox"> Komedi
                    </label>
                </div>
            </div>

            <div class="filter-section">
                <div class="filter-title">Rating Usia</div>
                <div class="filter-options">
                    <label class="filter-checkbox">
                        <input type="checkbox" checked> Semua
                    </label>
                    <label class="filter-checkbox">
                        <input type="checkbox"> SU
                    </label>
                    <label class="filter-checkbox">
                        <input type="checkbox"> 13+
                    </label>
                    <label class="filter-checkbox">
                        <input type="checkbox"> 17+
                    </label>
                </div>
            </div>

            <button class="btn-reset">Reset Filter</button>
        </aside>

        <!-- Main Content -->
        <main class="main-content">
            <div class="header-actions">
                <h1 class="page-title">Film Sedang Tayang</h1>
                <div class="search-container">
                    <div class="search-box">
                        <i class="fa-solid fa-search"></i>
                        <input type="text" class="search-input" placeholder="Cari judul film...">
                    </div>
                    <!-- Role Admin Only Placeholder -->
                    <button class="btn-add">
                        <i class="fa-solid fa-plus"></i> Tambah Film
                    </button>
                </div>
            </div>

            <div class="movie-list">
                <!-- Movie Item 1 -->
                <div class="movie-card">
                    <div class="movie-poster">
                        <i class="fa-solid fa-image fa-2x" style="opacity: 0.5;"></i>
                    </div>
                    <div class="movie-info">
                        <h2 class="movie-title">Avengers: Endgame</h2>
                        <div class="movie-tags">
                            <span class="tag">Action</span>
                            <span class="tag">181 min</span>
                            <span class="tag">13+</span>
                        </div>
                        <p class="movie-synopsis">
                            Setelah peristiwa menghancurkan di Infinity War, alam semesta hancur. Dengan bantuan sekutu yang tersisa, Avengers berkumpul sekali lagi untuk membalikkan tindakan Thanos dan memulihkan keseimbangan alam semesta.
                        </p>
                        <div class="movie-footer">
                            <div class="schedules">
                                <span class="schedule-lbl">Jadwal:</span>
                                <span class="time-badge">10:00</span>
                                <span class="time-badge">13:30</span>
                                <span class="time-badge">16:00</span>
                            </div>
                            <a href="tiket.jsp" class="btn-order">Pesan Tiket</a>
                        </div>
                    </div>
                </div>

                <!-- Movie Item 2 -->
                <div class="movie-card">
                    <div class="movie-poster">
                        <i class="fa-solid fa-image fa-2x" style="opacity: 0.5;"></i>
                    </div>
                    <div class="movie-info">
                        <h2 class="movie-title">The Conjuring 3</h2>
                        <div class="movie-tags">
                            <span class="tag">Horror</span>
                            <span class="tag">112 min</span>
                            <span class="tag">17+</span>
                        </div>
                        <p class="movie-synopsis">
                            Kisah mengerikan tentang teror, pembunuhan, dan kejahatan tak dikenal yang mengejutkan bahkan penyelidik paranormal yang berpengalaman di kehidupan nyata Ed dan Lorraine Warren.
                        </p>
                        <div class="movie-footer">
                            <div class="schedules">
                                <span class="schedule-lbl">Jadwal:</span>
                                <span class="time-badge">19:00</span>
                                <span class="time-badge">21:30</span>
                            </div>
                            <a href="tiket.jsp" class="btn-order">Pesan Tiket</a>
                        </div>
                    </div>
                </div>
                
                <!-- Movie Item 3 -->
                <div class="movie-card">
                    <div class="movie-poster">
                        <i class="fa-solid fa-image fa-2x" style="opacity: 0.5;"></i>
                    </div>
                    <div class="movie-info">
                        <h2 class="movie-title">Dua Garis Biru</h2>
                        <div class="movie-tags">
                            <span class="tag">Drama</span>
                            <span class="tag">113 min</span>
                            <span class="tag">13+</span>
                        </div>
                        <p class="movie-synopsis">
                            Bima dan Dara adalah sepasang kekasih yang masih duduk di bangku SMA. Kehidupan mereka berubah drastis ketika mereka melanggar batas tanpa mengetahui konsekuensinya.
                        </p>
                        <div class="movie-footer">
                            <div class="schedules">
                                <span class="schedule-lbl">Jadwal:</span>
                                <span class="time-badge">11:00</span>
                                <span class="time-badge">14:30</span>
                            </div>
                            <a href="tiket.jsp" class="btn-order">Pesan Tiket</a>
                        </div>
                    </div>
                </div>
            </div>
            
            <div style="margin-top: 1rem;">
                <button class="btn-add" style="background: transparent; border: 1px dashed var(--primary-color); color: var(--primary-color); width: 100%; justify-content: center;">
                    <i class="fa-solid fa-plus"></i> Tambah Jadwal Tayang (Khusus Admin)
                </button>
            </div>

            <div class="pagination">
                <button class="btn-page" disabled>← Prev</button>
                <button class="btn-page">Next →</button>
            </div>
        </main>
    </div>

</body>
</html>
