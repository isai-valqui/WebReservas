<%@page import="com.example.utils.PasswordUtils"%>
<%@page import="java.sql.*"%>

<html>
<head>
    <title>Registrar</title>
</head>
<body>
    <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try {
            // Establecer la conexi�n a la base de datos
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/reserva", "root", "");

            // Preparar la consulta SQL
            PreparedStatement stmt = conn.prepareStatement("INSERT INTO users (username, password) VALUES (?, ?)");
            stmt.setString(1, username);
            stmt.setString(2, PasswordUtils.hashPassword(password)); // Almacenar el hash de la contrase�a

            // Ejecutar la consulta
            stmt.executeUpdate();

            // Cerrar los recursos
            stmt.close();
            conn.close();

            // Redirigir al formulario de inicio de sesi�n despu�s del registro exitoso
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            e.printStackTrace();
            // Manejar el error de conexi�n o consulta
        }
    %>
</body>
</html>
