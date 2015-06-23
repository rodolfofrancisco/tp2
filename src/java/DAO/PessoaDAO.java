/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Models.Pessoa;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 *
 * @author Thiago
 */
public class PessoaDAO implements IPessoaDAO
{
    
    ConexaoDAO conexao = new ConexaoDAO();           
    ResultSet resultSet = null;
    PreparedStatement query = null;    

    public Pessoa VerificarLogin(String email, String senha) throws Exception 
    {       
        conexao.AbrirConexao();
        
        try 
        {            
            query = conexao.conexao.prepareStatement("SELECT P.nome FROM pessoa AS P WHERE P.email = ? AND P.senha = ?");
            query.setString(1, email);
            query.setString(2, senha);               
            resultSet = query.executeQuery();  

            if (resultSet.next())
            {                
                Pessoa pessoa = new Pessoa();
                pessoa.setEmail(email);
                pessoa.setSenha(senha);
                pessoa.setNome(resultSet.getString("nome"));               

                return pessoa;
            } 
            
            else 
            {
                return null;
            }
        } 
        catch (Exception e)
        {
            e.printStackTrace();
        } 
        finally 
        {
            conexao.FecharConexao();
        }
        
        return null;
    }

    public void Cadastrar(Pessoa pessoa) throws Exception 
    {
        try
        {
            conexao.AbrirConexao();

            query = conexao.conexao.prepareStatement("INSERT INTO Pessoa(Nome, Nascimento, Foto, Email, Senha) VALUES(?,?,?,?,?)");

            query.setString(1, pessoa.getNome());
            query.setString(2, pessoa.getNascimento());
            query.setBlob(3, pessoa.getFoto());
            query.setString(4, pessoa.getEmail());
            query.setString(5, pessoa.getSenha());

            query.execute();
        }
        
        catch(Exception e)
        {
            e.printStackTrace();
        }
        
        finally
        {
            conexao.FecharConexao();
        }

    }

}
