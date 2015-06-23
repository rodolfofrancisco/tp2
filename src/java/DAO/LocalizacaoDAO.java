/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Models.Localizacao;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author 'Rodolfo
 */
public class LocalizacaoDAO implements ILocalizacaoDAO {
    
    private ConexaoDAO conn;
    
    public LocalizacaoDAO() throws Exception{
        try{
            this.conn = new ConexaoDAO();
        }catch(Exception e){
            throw new Exception("Erro: " + e.getMessage());
        }
    }
    
    @Override
    public List getLocalizacoes() throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        ResultSet rs = null;
        try {
            conn = this.conn;
            conn.AbrirConexao();
            ps = conn.conexao.prepareStatement("SELECT * FROM localizacao");
            rs = ps.executeQuery();
            List<Localizacao> list = new ArrayList<Localizacao>();
            while(rs.next()){
                Localizacao loc = new Localizacao();
                loc.setId(rs.getInt("id"));
                loc.setDescricao(rs.getString("descricao"));
                loc.setPalavrasChaves(rs.getString("palavras_chaves"));
                loc.setLatitude(rs.getString("latitude"));
                loc.setLongitude(rs.getString("longitude"));
                list.add(loc);
            }
            return list;
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
    }

    @Override
    public void saveLocalizacao(Localizacao localizacao, String id) throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        try {
            conn = this.conn;
            conn.AbrirConexao();
            if (id == null) {
                ps = conn.conexao.prepareStatement("INSERT INTO localizacao (descricao, palavras_chaves) VALUES (?, ?)");
            } else {
                ps = conn.conexao.prepareStatement("UPDATE localizacao SET descricao = ?, palavras_chaves = ? WHERE id = ?");
                ps.setString(3, id);
            }
            ps.setString(1, localizacao.getDescricao());
            ps.setString(2, localizacao.getPalavrasChaves());
            ps.executeUpdate();
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
    }

    @Override
    public Localizacao getLocalizacao(String id) throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        ResultSet rs = null;
        Localizacao l = null;
        try {
            conn = this.conn;
            conn.AbrirConexao();
            ps = conn.conexao.prepareStatement("SELECT * FROM localizacao WHERE id = ?");
            ps.setString(1, id);
            rs = ps.executeQuery();
            l = new Localizacao();
            while(rs.next()){
                l.setId(rs.getInt("id"));
                l.setDescricao(rs.getString("descricao"));
                l.setPalavrasChaves(rs.getString("palavras_chaves"));
            }
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
        
        return l;
    }

    @Override
    public void deleteLocalizacao(String id) throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        try {
            conn = this.conn;
            conn.AbrirConexao();
            ps = conn.conexao.prepareStatement("DELETE FROM localizacao WHERE id = ?");
            ps.setString(1, id);
            ps.executeUpdate();
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
    }

}
