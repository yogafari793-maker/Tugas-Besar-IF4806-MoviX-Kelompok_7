<%-- 
    Document   : login
    Created on : 21 May 2026, 10.24.51
    Author     : ghifa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>MoviX - Login</title>

    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet">

    <style>

        body{
            background-color: #f5f5f5;
        }

        .main-container{
            margin: 20px auto;
            width: 95%;
            min-height: 90vh;
            background: #fafafa;
            border: 1px solid #ccc;
            border-radius: 20px;
            overflow: hidden;
        }

        .navbar-custom{
            background-color: #e9e7e1;
            padding: 15px 25px;
        }

        .banner{
            height: 180px;
            border: 2px dashed #cfcfcf;
            border-radius: 12px;
            display: flex;
            justify-content: center;
            align-items: center;
            color: gray;
            background-color: white;
        }

        .login-card{
            background: white;
            border-radius: 20px;
            border: 1px solid #ddd;
            padding: 40px;
            min-height: 700px;
        }

        .btn-dark-custom{
            background-color: #222;
            color: white;
        }

        .btn-dark-custom:hover{
            background-color: black;
            color: white;
        }

    </style>

</head>

<body>

<div class="main-container">

    <!-- Navbar -->
    <nav class="navbar navbar-custom d-flex justify-content-between">
        <h5 class="m-0">■ MoviX</h5>

        <div>
            <button class="btn btn-outline-secondary btn-sm">
                Register
            </button>

            <button class="btn btn-dark btn-sm">
                Login
            </button>
        </div>
    </nav>

    <!-- Content -->
    <div class="container-fluid p-4">

        <div class="row g-4">

            <!-- LEFT -->
            <div class="col-md-7">

                <div class="banner mb-4">
                    Ilustrasi / Banner Halaman Utama
                </div>

                <h1 class="fw-bold">
                    Reservasi Tiket Bioskop Online
                </h1>

                <p class="text-muted">
                    Pesan tiket film favoritmu dengan mudah,
                    pilih kursi, dan nikmati pengalaman bioskop
                    terbaik bersama MoviX.
                </p>

                <div class="d-flex gap-2 flex-wrap">

                    <button class="btn btn-light border">
                        Katalog Film
                    </button>

                    <button class="btn btn-light border">
                        Pilih Kursi
                    </button>

                    <button class="btn btn-light border">
                        E-Tiket
                    </button>

                    <button class="btn btn-light border">
                        Promo
                    </button>

                </div>

            </div>

            <!-- RIGHT -->
            <div class="col-md-5">

                <div class="login-card">

                    <h3 class="text-center fw-bold mb-5">
                        Masuk ke Akun Anda
                    </h3>

                    <form action="LoginServlet" method="post">

                        <div class="mb-4">
                            <label class="form-label">
                                Username
                            </label>

                            <input type="text"
                                   name="username"
                                   class="form-control"
                                   placeholder="Masukkan username..."
                                   required>
                        </div>

                        <div class="mb-4">
                            <label class="form-label">
                                Password
                            </label>

                            <input type="password"
                                   name="password"
                                   class="form-control"
                                   placeholder="Masukkan password..."
                                   required>
                        </div>

                        <button type="submit"
                                class="btn btn-dark-custom w-100 mb-3">
                            Login
                        </button>

                        <a href="register.jsp"
                           class="btn btn-outline-secondary w-100">
                            Daftar sebagai Pelanggan
                        </a>

                    </form>

                    <hr class="my-5">

                    <div class="text-center">

                        <p>Login sebagai Admin</p>

                        <a href="adminLogin.jsp"
                           class="btn btn-dark rounded-pill px-4">
                            Hak Akses Admin
                        </a>

                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>
