<%-- 
    Document   : pilihKursi
    Created on : May 23, 2026, 12:50:14 PM
    Author     : Daffa
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<!DOCTYPE html>
<html lang="id">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Pilih Kursi — MoviX</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link href="https://fonts.googleapis.com/css2?family=Syne:wght@400;600;700;800&family=DM+Sans:wght@300;400;500&display=swap" rel="stylesheet">
        <style>
            /* ══════════════════════════════════════════════
               TOKENS
            ══════════════════════════════════════════════ */
            :root {
                --bg:        #0d0f14;
                --surface:   #151820;
                --surface2:  #1c2030;
                --border:    rgba(255,255,255,.07);
                --text:      #e8eaf0;
                --muted:     #6b7280;
                --accent:    #e50914;
                --accent2:   #ff3d3d;
                --seat-avail:#2d3348;
                --seat-hover:#3a4060;
                --seat-taken:#1a1c24;
                --seat-sel:  #e50914;
                --radius:    12px;
                --font-head: 'Syne', sans-serif;
                --font-body: 'DM Sans', sans-serif;
            }

            /* ══════════════════════════════════════════════
               RESET / BASE
            ══════════════════════════════════════════════ */
            *, *::before, *::after {
                box-sizing: border-box;
                margin:0;
                padding:0
            }
            html {
                scroll-behavior: smooth
            }
            body {
                background: var(--bg);
                color: var(--text);
                font-family: var(--font-body);
                font-size: 15px;
                min-height: 100vh;
                line-height: 1.5;
            }

            /* ══════════════════════════════════════════════
               NAVBAR
            ══════════════════════════════════════════════ */
            nav {
                position: sticky;
                top: 0;
                z-index: 100;
                background: rgba(13,15,20,.85);
                backdrop-filter: blur(16px);
                border-bottom: 1px solid var(--border);
                padding: 0 32px;
                height: 60px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .nav-logo {
                font-family: var(--font-head);
                font-size: 22px;
                font-weight: 800;
                letter-spacing: -0.5px;
                color: var(--text);
            }
            .nav-logo span {
                color: var(--accent)
            }
            .nav-links {
                display: flex;
                gap: 28px
            }
            .nav-links a {
                color: var(--muted);
                text-decoration: none;
                font-size: 14px;
                font-weight: 500;
                transition: color .2s;
            }
            .nav-links a:hover {
                color: var(--text)
            }

            /* ══════════════════════════════════════════════
               FILM BANNER
            ══════════════════════════════════════════════ */
            .film-banner {
                background: var(--surface);
                border-bottom: 1px solid var(--border);
                padding: 16px 32px;
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
            .film-info {
                display: flex;
                align-items: center;
                gap: 14px
            }
            .film-poster {
                width: 52px;
                height: 68px;
                border-radius: 6px;
                object-fit: cover;
                border: 1px solid var(--border);
            }
            .film-meta h2 {
                font-family: var(--font-head);
                font-size: 16px;
                font-weight: 700;
            }
            .film-meta p {
                font-size: 13px;
                color: var(--muted);
                margin-top: 2px;
            }
            .btn-ubah {
                background: transparent;
                border: 1px solid var(--border);
                color: var(--muted);
                font-size: 13px;
                padding: 6px 16px;
                border-radius: 6px;
                cursor: pointer;
                transition: all .2s;
                font-family: var(--font-body);
            }
            .btn-ubah:hover {
                border-color: var(--text);
                color: var(--text)
            }

            /* ══════════════════════════════════════════════
               MAIN LAYOUT
            ══════════════════════════════════════════════ */
            main {
                max-width: 960px;
                margin: 0 auto;
                padding: 32px 20px 120px
            }

            .section-title {
                font-family: var(--font-head);
                font-size: 22px;
                font-weight: 700;
                margin-bottom: 24px;
                letter-spacing: -0.3px;
            }

            /* ══════════════════════════════════════════════
               SCREEN
            ══════════════════════════════════════════════ */
            .screen-wrap {
                margin-bottom: 32px;
                text-align: center;
            }
            .screen-line {
                width: 70%;
                max-width: 560px;
                height: 4px;
                background: linear-gradient(90deg, transparent, var(--accent), transparent);
                margin: 0 auto 8px;
                border-radius: 2px;
                box-shadow: 0 0 18px 2px rgba(229,9,20,.4);
            }
            .screen-label {
                font-size: 11px;
                letter-spacing: 3px;
                text-transform: uppercase;
                color: var(--muted);
                font-weight: 500;
            }

            /* ══════════════════════════════════════════════
               SEAT GRID
            ══════════════════════════════════════════════ */
            .aisle {
                width:14px;
                flex-shrink:0
            }
            .seat-grid {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
                gap: 8px;
                margin-bottom: 28px;
            }
            .seat-row {
                display: flex;
                align-items: center;
                gap: 6px;
            }
            .col-label-row {
                margin-top: 4px;
            }
            .row-label {
                width: 20px;
                text-align: center;
                font-size: 12px;
                color: #94a3b8;
                font-weight: 500;
                user-select: none;
                flex-shrink: 0;
            }
            .col-numbers {
                display: flex;
                align-items: center;
                gap: 6px;
                margin-left: 20px;
                margin-top: 4px;
            }
            .col-num {
                width: 36px;
                text-align: center;
                font-size: 11px;
                color: var(--muted);
                user-select: none;
            }

            /* ── SEAT BUTTON ─────────────────────────────── */
            .seat {
                width: 24px;
                height: 20px;
                border-radius: 4px 4px 0 0;
                border: none;
                cursor: pointer;
                transition: all 0.15s;
                flex-shrink: 0;
                background: var(--bg-seat);
                font-size: 0;
            }
            .seat.avail {
                background:#2d3748
            }
            .seat.avail:hover {
                background:#3a4060;
                transform:translateY(-2px);
                box-shadow:0 4px 10px rgba(220,38,38,.2)
            }
            .seat.taken {
                background:#1a1c24;
                cursor:not-allowed;
                opacity:.45
            }
            .seat.selected {
                background:#dc2626;
                box-shadow:0 0 10px rgba(220,38,38,.45);
                transform:translateY(-2px)
            }

            .col-labels {
                display:flex;
                align-items:center;
                gap:6px;
                margin-top:8px
            }
            .col-lbl-spacer {
                flex-shrink:0;
                width:20px
            }
            .col-lbl {
                width:24px;
                text-align:center;
                font-size:11px;
                color:#94a3b8;
                flex-shrink:0;
                display:inline-block
            }
            .col-lbl-aisle {
                width:14px;
                flex-shrink:0
            }
            .badge {
                display:inline-flex !important;
                align-items:center !important;
                justify-content:center !important;
                background:#dc2626 !important;
                color:#fff !important;
                font-size:12px !important;
                font-weight:700 !important;
                padding:4px 10px !important;
                border-radius:6px !important;
                line-height:1 !important;
                height:auto !important;
                min-width:36px !important;
                border:none !important;
                cursor:default !important;
                text-align:center !important;
            }

            /* ══════════════════════════════════════════════
               LEGEND
            ══════════════════════════════════════════════ */
            .legend {
                display:flex;
                gap:20px;
                justify-content:center;
                margin-top:16px;
                flex-wrap:wrap;
                padding: 10px 20px;
            }
            .legend-item {
                display:flex;
                align-items:center;
                gap:7px;
                font-size:12px;
                color:#94a3b8
            }
            .legend-dot {
                width:24px;
                height:20px;
                border-radius:4px 4px 0 0
            }
            .ld-avail {
                background:#2d3748
            }
            .ld-sel {
                background:#dc2626
            }
            .ld-taken {
                background:#1a1c24;
                opacity:.45;
                border:1px solid rgba(255,255,255,.08)
            }

            /* ══════════════════════════════════════════════
               SUMMARY CARD
            ══════════════════════════════════════════════ */
            .summary-card {
                background: var(--surface);
                border: 1px solid var(--border);
                border-radius: var(--radius);
                padding: 20px 24px;
                margin-bottom: 24px;
            }
            .summary-row {
                display: flex;
                justify-content: space-between;
                align-items: baseline;
                padding: 8px 0;
                font-size: 14px;
            }
            .summary-row:not(:last-child) {
                border-bottom: 1px solid var(--border)
            }
            .summary-row .label {
                color: var(--muted)
            }
            .summary-row .value {
                font-weight: 500;
                text-align: right;
                max-width: 60%;
            }
            .summary-row-seats {
                align-items: center !important;
                flex-wrap: wrap;
                gap: 8px;
                padding: 12px 0 !important;
            }
            .seats-badges {
                display: flex;
                flex-wrap: wrap;
                gap: 6px;
                justify-content: flex-end;
                flex: 1;
                max-width: none !important;
            }
            .seats-empty {
                color: #475569;
                font-size: 13px;
            }
            .summary-row.total .label {
                font-size: 15px;
                font-weight: 600;
                color: var(--text);
            }
            .summary-row.total .value {
                font-family: var(--font-head);
                font-size: 18px;
                font-weight: 700;
                color: var(--accent);
            }

            /* ══════════════════════════════════════════════
               ACTIONS (sticky footer)
            ══════════════════════════════════════════════ */
            .actions {
                position: fixed;
                bottom: 0;
                left: 0;
                right: 0;
                background: rgba(13,15,20,.92);
                backdrop-filter: blur(16px);
                border-top: 1px solid var(--border);
                padding: 14px 32px;
                display: flex;
                gap: 12px;
                justify-content: center;
            }
            .btn {
                flex: 1;
                max-width: 420px;
                padding: 13px 24px;
                border-radius: 10px;
                font-family: var(--font-head);
                font-size: 14px;
                font-weight: 700;
                letter-spacing: .3px;
                cursor: pointer;
                border: none;
                transition: all .2s;
            }
            .btn-back {
                background: var(--surface2);
                color: var(--muted);
                border: 1px solid var(--border);
            }
            .btn-back:hover {
                background: var(--surface);
                color: var(--text)
            }
            .btn-next {
                background: var(--accent);
                color: #fff;
                box-shadow: 0 4px 20px rgba(229,9,20,.35);
            }
            .btn-next:hover:not(:disabled) {
                background: var(--accent2);
                box-shadow: 0 6px 24px rgba(229,9,20,.5);
                transform: translateY(-1px);
            }
            .btn-next:disabled {
                opacity: .35;
                cursor: not-allowed;
                transform: none;
                box-shadow: none;
            }

            @media (max-width: 600px) {
                nav {
                    padding: 0 16px
                }
                main {
                    padding: 20px 12px 110px
                }
                .seat {
                    width: 30px;
                    height: 28px
                }
                .col-num {
                    width: 30px
                }
                .actions {
                    padding: 12px 16px
                }
            }
        </style>
    </head>
    <body>

        <nav class="navbar">
            <div class="nav-logo">Movi<span>X</span></div>
        </nav>

        <div class="film-banner">
            <div class="film-info">
                <c:choose>
                    <c:when test="${fn:startsWith(posterUrl, 'http')}">
                        <img src="${posterUrl}" alt="poster" class="film-poster" referrerpolicy="no-referrer">
                    </c:when>
                    <c:otherwise>
                        <img src="<%= request.getContextPath() %>/${posterUrl}" alt="poster" class="film-poster">
                    </c:otherwise>
                </c:choose>
                <div class="film-meta">
                    <h2>${filmTitle}</h2>
                    <p>${filmDate} · ${filmTime} · ${studioName}</p>
                </div>
            </div>
            <button class="btn-ubah" onclick="history.back()">Ubah</button>
        </div>

        <main>
            <h1 class="section-title">Pilih Kursi</h1>

            <div class="screen-wrap">
                <div class="screen-line"></div>
                <div class="screen-label">Layar</div>
            </div>

            <form id="seatForm" method="POST" action="${pageContext.request.contextPath}/checkout">
                <input type="hidden" name="aksi" value="review">
                <input type="hidden" name="film"   value="${filmTitle}">
                <input type="hidden" name="date"   value="${filmDate}">
                <input type="hidden" name="time"   value="${filmTime}">
                <input type="hidden" name="studio" value="${studioName}">
                <input type="hidden" id="harga"    name="totalHarga" value="0">

                <div style="display:flex;justify-content:center;">
                    <div class="seat-grid" id="seat-grid"></div>
                </div>

                <div class="legend">
                    <div class="legend-item"><div class="legend-dot ld-avail"></div><span>Tersedia</span></div>
                    <div class="legend-item"><div class="legend-dot ld-sel"></div><span>Dipilih</span></div>
                    <div class="legend-item"><div class="legend-dot ld-taken"></div><span>Terisi</span></div>
                </div>

                <div class="summary-card">
                    <div class="summary-row summary-row-seats">
                        <span class="label" style="flex-shrink:0">Kursi Dipilih</span>
                        <div id="dispSeats" style="display:flex;flex-wrap:wrap;gap:6px;justify-content:flex-end;flex:1;font-size:12px;font-weight:600;color:#fff;">
                            <span style="color:#475569;font-size:13px;font-weight:400;">—</span>
                        </div>
                    </div>
                    <div class="summary-row">
                        <span class="label">Jumlah Kursi</span>
                        <span class="value" id="dispCount">0</span>
                    </div>
                    <div class="summary-row total">
                        <span class="label">Total Harga</span>
                        <span class="value" id="dispTotal">Rp 0</span>
                    </div>
                </div>

            </form>
        </main>

        <div class="actions">
            <button class="btn btn-back" onclick="history.back()">← Kembali</button>
            <button class="btn btn-next" id="btnNext" disabled onclick="submitForm()">
                Lanjut (<span id="lanjutCount">0</span> kursi)
            </button>
        </div>

        <script>
            const TICKET_PRICE = parseInt("${ticketPrice}", 10) || 0;

            const ROWS = (function () {
                const letters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
                const r = [];
                const maxRows = parseInt("${seatRows}", 10) || 8;
                for (let i = 0; i < maxRows; i++)
                    r.push(letters[i]);
                return r;
            })();

            const COLS = parseInt("${seatCols}", 10) || 10;

            const TAKEN = [${takenSeatsFormatted}];

            const MAX = 6;
            let chosen = new Set();

            function renderGrid() {
                const grid = document.getElementById('seat-grid');
                grid.innerHTML = '';

                ROWS.forEach(r => {
                    const row = document.createElement('div');
                    row.className = 'seat-row';
                    const ll = document.createElement('span');
                    ll.className = 'row-label';
                    ll.textContent = r;
                    row.appendChild(ll);

                    for (let c = 1; c <= COLS; c++) {
                        if (c === 6) {
                            const a = document.createElement('div');
                            a.className = 'aisle';
                            row.appendChild(a);
                        }
                        const key = r + c;
                        const taken = TAKEN.includes(key);
                        const sel = chosen.has(key);
                        const btn = document.createElement('button');
                        btn.type = 'button';
                        btn.dataset.seat = key;
                        btn.title = key;

                        let cls = 'seat ';
                        if (taken) {
                            cls += 'taken';
                            btn.disabled = true;
                        } else if (sel) {
                            cls += 'selected';
                        } else {
                            cls += 'avail';
                        }

                        btn.className = cls;
                        if (!taken)
                            btn.addEventListener('click', () => toggleSeat(btn));
                        row.appendChild(btn);
                    }
                    const rl = document.createElement('span');
                    rl.className = 'row-label';
                    rl.textContent = r;
                    row.appendChild(rl);
                    grid.appendChild(row);
                });

                const labelRow = document.createElement('div');
                labelRow.className = 'seat-row col-label-row';
                const sp = document.createElement('span');
                sp.style.cssText = 'width:20px;flex-shrink:0;display:inline-block';
                labelRow.appendChild(sp);

                for (let c = 1; c <= COLS; c++) {
                    if (c === 6) {
                        const a = document.createElement('div');
                        a.className = 'aisle';
                        labelRow.appendChild(a);
                    }
                    const cl = document.createElement('span');
                    cl.className = 'col-lbl';
                    cl.textContent = c;
                    labelRow.appendChild(cl);
                }

                const sp2 = document.createElement('span');
                sp2.style.cssText = 'width:20px;flex-shrink:0;display:inline-block';
                labelRow.appendChild(sp2);
                grid.appendChild(labelRow);
            }

            function showToast(msg) {
                let t = document.getElementById('_toast');
                if (!t) {
                    t = document.createElement('div');
                    t.id = '_toast';
                    t.style.cssText = 'position:fixed;bottom:90px;left:50%;transform:translateX(-50%) translateY(20px);background:#1c2030;color:#e8eaf0;padding:10px 20px;border-radius:8px;font-size:13px;border:1px solid rgba(255,255,255,.1);opacity:0;transition:all .3s;z-index:999;pointer-events:none;';
                    document.body.appendChild(t);
                }
                t.textContent = msg;
                t.style.opacity = '1';
                t.style.transform = 'translateX(-50%) translateY(0)';
                clearTimeout(t._timer);
                t._timer = setTimeout(() => {
                    t.style.opacity = '0';
                    t.style.transform = 'translateX(-50%) translateY(20px)';
                }, 2000);
            }

            function toggleSeat(btn) {
                const id = btn.dataset.seat;
                if (chosen.has(id)) {
                    chosen.delete(id);
                    btn.classList.remove('selected');
                    btn.classList.add('avail');
                } else {
                    if (chosen.size >= MAX) {
                        showToast('Maksimal ' + MAX + ' kursi');
                        return;
                    }
                    chosen.add(id);
                    btn.classList.remove('avail');
                    btn.classList.add('selected');
                }
                updateUI();
            }

            function updateUI() {
                const arr = [...chosen].sort();
                const count = arr.length;
                const total = TICKET_PRICE * count;

                const dispSeats = document.getElementById('dispSeats');
                if (count) {
                    dispSeats.innerHTML = arr.map(k =>
                            `<span class="badge">\${k}</span>`
                    ).join('');
                } else {
                    dispSeats.innerHTML = '<span style="color:#475569;font-size:13px;font-weight:400;">—</span>';
                }
                document.getElementById('dispCount').textContent = count;
                document.getElementById('lanjutCount').textContent = count;
                document.getElementById('dispTotal').textContent = 'Rp ' + total.toLocaleString('id-ID');
                document.getElementById('harga').value = total;
                document.getElementById('btnNext').disabled = count === 0;
            }

            function submitForm() {
                if (chosen.size === 0)
                    return;
                const form = document.getElementById('seatForm');
                document.querySelectorAll('input[name="selected"]').forEach(el => el.remove());
                chosen.forEach(s => {
                    const inp = document.createElement('input');
                    inp.type = 'hidden';
                    inp.name = 'selected';
                    inp.value = s;
                    form.appendChild(inp);
                });
                form.submit();
            }

            renderGrid();
            updateUI();
        </script>
    </body>
</html>
