<%-- 
    Document   : login
    Created on : 1 d�c. 2015, 22:03:40
    Author     : Nico
--%>

<form action="j_security_check" method=post>
    <div id="loginBox">
        <p><strong>username:</strong>
            <input type="text" size="20" name="j_username"></p>

        <p><strong>password:</strong>
            <input type="password" size="20" name="j_password"></p>

        <p><input type="submit" value="submit"></p>
    </div>
</form>