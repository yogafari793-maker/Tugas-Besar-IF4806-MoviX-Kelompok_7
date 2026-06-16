<%-- 
    Document   : login
    Created on : 21 May 2026, 10.24.51
    Author     : ghifa
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

    <title>Login MoviX</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>

        body{
            background-color: #05070D;
            color: white;
            font-family: 'Inter', Arial, sans-serif;
        }

        .register-box{
            margin-top: 80px;
        }

        .card{
            border-radius: 15px;
            box-shadow: 0px 4px 20px rgba(0,0,0,0.6);
            background-color: #0B0E14;
            border: 1px solid #1E2530;
            color: white;
        }

        .logo { 
            font-family: 'Inter', Arial, sans-serif;
            font-size:30px;
            font-weight:800; 
            letter-spacing: -0.5px;
            color: white; 
            text-decoration: none;
        }
        .logo span {
            color: #E51919;
        }

        .text-muted {
            color: #8E97A4 !important;
        }

        .form-floating > .form-control {
            background-color: #0F131D;
            border: 1px solid #1E2530;
            color: white;
        }

        .form-floating > .form-control:focus {
            background-color: #0F131D;
            color: white;
            border-color: #E51919;
            box-shadow: none;
        }

        .form-floating > label {
            color: #8E97A4;
        }
        
        .form-floating > label::after {
            background-color: transparent !important;
        }

        .form-floating > .form-control:focus ~ label,
        .form-floating > .form-control:not(:placeholder-shown) ~ label {
            color: white !important;
        }
        
        .form-floating > .form-control:-webkit-autofill {
            -webkit-box-shadow: 0 0 0 30px #0F131D inset !important;
            -webkit-text-fill-color: white !important;
        }

        .btn-danger {
            background-color: #E51919;
            border-color: #E51919;
        }
        .btn-danger:hover {
            background-color: #cc0000;
            border-color: #cc0000;
        }

    </style>

</head>

<body>

<div class="container register-box">

    <div class="row justify-content-center">

        <div class="col-md-5">

            <div class="card">

                <div class="card-body p-5">

                    <div class="text-center mb-4">

                        <h1 class="logo">Movi<span>X</span></h1>

                        <p class="text-muted">
                            Login
                            <a href="loginadmin.jsp" class="text-decoration-none text-danger">admin?</a>
                        </p>
                    </div>

                    <% if (request.getAttribute("errorMessage") != null) { %>
                        <div class="alert alert-danger text-center" role="alert">
                            <%= request.getAttribute("errorMessage") %>
                        </div>
                    <% } %>
                    <% if (request.getAttribute("successMessage") != null) { %>
                        <div class="alert alert-success text-center" role="alert">
                            <%= request.getAttribute("successMessage") %>
                        </div>
                    <% } %>

                    <form action="login" method="POST">

                    <input type="hidden" name="action" value="login">
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="username" placeholder="Username" required>
                        <label>Username</label>
                    </div>
                    <div class="form-floating mb-3">
                        <input type="password" class="form-control" name="password" placeholder="Password" required>
                        <label>Password</label>
                    </div>

                        <button type="submit"
                                class="btn btn-danger w-100">
                            Login
                        </button>

                    </form>

                    <div class="text-center mt-4">

                        Belum punya akun?

                        <a href="register.jsp"
                           class="text-decoration-none">

                            Daftar disini

                        </a>
                    </div>

                </div>

            </div>

        </div>

    </div>

</div>

</body>
</html>