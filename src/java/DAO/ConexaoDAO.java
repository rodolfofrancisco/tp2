package DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author Thiago
 */
public class ConexaoDAO implements IConexaoDAO{

    Connection conexao;
    private final String URLBD = "jdbc:mysql://localhost:3306/TP1DB?useUnicode=true&characterEncoding=UTF-8";
    private final String usuario = "root";
    private final String senha = "admin";
     
    public void AbrirConexao() 
    {   
        try 
        {
            Class.forName("com.mysql.jdbc.Driver");
            conexao = DriverManager.getConnection(URLBD, usuario, senha);
        } 
        
        catch (ClassNotFoundException | SQLException e) 
        {
            e.printStackTrace();
        }

    }       
     
    public void FecharConexao() throws SQLException
    {        
        conexao.close();
    }

}
