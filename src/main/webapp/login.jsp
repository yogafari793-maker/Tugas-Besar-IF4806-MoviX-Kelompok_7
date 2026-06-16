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
            background-color: #141414;
        }

        .register-box{
            margin-top: 80px;
        }

        .card{
            border-radius: 15px;
            box-shadow: 0px 0px 20px rgba(0,0,0,0.4);
        }

        .logo-title{
            color: #dc3545;
            font-weight: bold;
            font-size: 40px;
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

                        <h1 class="logo-title">
                            MoviX
                        </h1>

                        <p class="text-muted">
                            Login
                        </p>

                    </div>

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