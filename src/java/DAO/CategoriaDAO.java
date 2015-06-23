/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Models.Categoria;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author 'Rodolfo
 */
public class CategoriaDAO implements ICategoriaDAO {
    
    private ConexaoDAO conn;
    
    public CategoriaDAO() throws Exception{
        try{
            this.conn = new ConexaoDAO();
        }catch(Exception e){
            throw new Exception("Erro: " + e.getMessage());
        }
    }
    
    @Override
    public List getCategorias() throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        ResultSet rs = null;
        try {
            conn = this.conn;
            conn.AbrirConexao();
            ps = conn.conexao.prepareStatement("SELECT * FROM categoria");
            rs = ps.executeQuery();
            List<Categoria> list = new ArrayList<Categoria>();
            while(rs.next()){
                Categoria c = new Categoria();
                c.setId(rs.getInt("id"));
                c.setDescricao(rs.getString("descricao"));
                list.add(c);
            }
            return list;
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
    }

    @Override
    public void saveCategoria(Categoria categoria, String id) throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        try {
            conn = this.conn;
            conn.AbrirConexao();
            if (id == null) {
                ps = conn.conexao.prepareStatement("INSERT INTO categoria (descricao) VALUES (?)");
            } else {
                ps = conn.conexao.prepareStatement("UPDATE categoria SET descricao = ? WHERE id = ?");
                ps.setString(2, id);
            }
            ps.setString(1, categoria.getDescricao());
            ps.executeUpdate();
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
    }

    @Override
    public Categoria getCategoria(String id) throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        ResultSet rs = null;
        try {
            conn = this.conn;
            conn.AbrirConexao();
            ps = conn.conexao.prepareStatement("SELECT * FROM categoria WHERE id = ?");
            ps.setString(1, id);
            rs = ps.executeQuery();
            Categoria c = new Categoria();
            while(rs.next()){
                c.setId(rs.getInt("id"));
                c.setDescricao(rs.getString("descricao"));
            }
            return c;
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
    }

    @Override
    public void deleteCategoria(String id) throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        try {
            conn = this.conn;
            conn.AbrirConexao();
            ps = conn.conexao.prepareStatement("DELETE FROM categoria WHERE id = ?");
            ps.setString(1, id);
            ps.executeUpdate();
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
    }
}
