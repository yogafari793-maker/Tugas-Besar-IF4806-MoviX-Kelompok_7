<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="dao.TransaksiDAO"%>
<%@page import="model.Transaksi"%>
<%@page import="java.util.List"%>
<%
    TransaksiDAO dao = new TransaksiDAO();
    List<Transaksi> listTransaksi = dao.getAllTransaksi();
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin - Riwayat Transaksi</title>
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
            --font-head: 'Syne', sans-serif;
            --font-body: 'DM Sans', sans-serif;
        }
        *, *::before, *::after { box-sizing: border-box; margin:0; padding:0; }
        body { background: var(--bg); color: var(--text); font-family: var(--font-body); padding: 40px; }
        
        .header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
        .header h1 { font-family: var(--font-head); font-weight: 700; color: var(--accent); }
        .btn-back { background: var(--surface2); border: 1px solid var(--border); color: var(--text); padding: 10px 16px; border-radius: 8px; text-decoration: none; font-weight: 600; transition: .2s; }
        .btn-back:hover { background: var(--surface); color: #fff; }

        .table-wrapper { background: var(--surface); border: 1px solid var(--border); border-radius: 12px; overflow: hidden; }
        table { width: 100%; border-collapse: collapse; text-align: left; }
        th { background: var(--surface2); padding: 16px; font-weight: 600; color: var(--muted); font-size: 14px; border-bottom: 1px solid var(--border); }
        td { padding: 16px; border-bottom: 1px solid var(--border); font-size: 14px; color: var(--text); }
        tr:last-child td { border-bottom: none; }
        tr:hover { background: rgba(255,255,255,.02); }
        
        .badge { display: inline-block; background: rgba(229,9,20,.1); border: 1px solid rgba(229,9,20,.3); padding: 4px 10px; border-radius: 6px; font-size: 12px; font-weight: 600; color: #ffcccc; margin-right: 4px; margin-bottom: 4px;}
        .empty-state { text-align: center; padding: 40px; color: var(--muted); }
    </style>
</head>
<body>

    <div class="header">
        <h1>Riwayat Transaksi</h1>
        <a href="${pageContext.request.contextPath}/katalog" class="btn-back">Kembali ke Katalog</a>
    </div>

    <div class="table-wrapper">
        <table>
            <thead>
                <tr>
                    <th>WAKTU</th>
                    <th>KODE BOOKING</th>
                    <th>PELANGGAN</th>
                    <th>FILM</th>
                    <th>JADWAL</th>
                    <th>KURSI</th>
                    <th>TOTAL</th>
                </tr>
            </thead>
            <tbody>
                <% if (listTransaksi == null || listTransaksi.isEmpty()) { %>
                    <tr><td colspan="7" class="empty-state">Belum ada transaksi</td></tr>
                <% } else { 
                    for (Transaksi t : listTransaksi) { 
                %>
                    <tr>
                        <td style="color: var(--muted);"><%= t.getWaktuTransaksi() %></td>
                        <td style="font-family: monospace; font-weight: 600;"><%= t.getKodeBooking() %></td>
                        <td><%= t.getNamaUser() %></td>
                        <td><%= t.getJudulFilm() %></td>
                        <td><%= t.getHari() %>, <%= t.getJamTayang() %><br><small style="color: var(--muted);"><%= t.getNamaStudio() %></small></td>
                        <td>
                            <% 
                                String[] kursiList = t.getKursiDipilih().split(",");
                                for(String k : kursiList) {
                            %>
                                <span class="badge"><%= k.trim() %></span>
                            <% } %>
                        </td>
                        <td style="font-weight: bold; color: #22c55e;">Rp <%= java.text.NumberFormat.getInstance(new java.util.Locale("id", "ID")).format(t.getTotalHarga()) %></td>
                    </tr>
                <%  } 
                   } %>
            </tbody>
        </table>
    </div>

</body>
</html>
