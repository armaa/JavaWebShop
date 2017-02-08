<%-- 
    Document   : login
    Created on : 31.01.2017., 12:07:56
    Author     : office
--%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="j_security_check" method=post>
            <div id="loginBox">
                <p><strong>username:</strong>
                    <input type="text" size="20" name="j_username"></p>

                <p><strong>password:</strong>
                    <input type="password" size="20" name="j_password"></p>

                <p><input type="submit" value="submit"></p>
            </div>
        </form>
    </body>
</html>
