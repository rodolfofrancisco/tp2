/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Models.Categoria;
import Models.Localizacao;
import Models.Tweet;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import twitter4j.JSONObject;

/**
 *
 * @author 'Rodolfo
 */
public class TweetDAO implements ITweetDAO {
    
    private ConexaoDAO conn;
    
    public TweetDAO() throws Exception{
        try{
            this.conn = new ConexaoDAO();
        }catch(Exception e){
            throw new Exception("Erro: " + e.getMessage());
        }
    }
    
    @Override
    public List getTweets() throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        ResultSet rs = null;
        try {
            conn = this.conn;
            conn.AbrirConexao();
            ps = conn.conexao.prepareStatement("SELECT * FROM tweet");
            rs = ps.executeQuery();
            List<Tweet> list = new ArrayList<Tweet>();
            while(rs.next()){
                Tweet t = new Tweet();
                t.setId(rs.getInt("id"));
                t.setUsuario(rs.getLong("usuario"));
                t.setDataPostagem(rs.getString("data_postagem"));
                t.setTweet(rs.getString("tweet"));
                t.setTweetId(rs.getLong("tweet_id"));
                t.setCategoriaId(rs.getInt("categoria_id"));
                t.setLocalizacaoId(rs.getInt("localizacao_id"));
                list.add(t);
            }
            return list;
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
    }

    @Override
    public void saveTweet(Tweet tweet, String id) throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        try {
            conn = this.conn;
            conn.AbrirConexao();
            if (id == null) {
                ps = conn.conexao.prepareStatement("INSERT INTO tweet (usuario, data_postagem, tweet, tweet_id, categoria_id, localizacao_id) VALUES (?, ?, ?, ?, ?, ?)");
            } else {
                ps = conn.conexao.prepareStatement("UPDATE categoria SET usuario = ?, data_postagem = ?, tweet = ?, tweet_id = ?, categoria_id = ?, localizacao_id = ? WHERE id = ?");
                ps.setString(7, id);
            }
            ps.setLong(1, tweet.getUsuario());
            ps.setString(2, tweet.getDataPostagem());
            ps.setString(3, tweet.getTweet());
            ps.setLong(4, tweet.getTweetId());
            ps.setInt(5, tweet.getCategoriaId());
            ps.setInt(6, tweet.getLocalizacaoId());
            ps.executeUpdate();
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
    }
    
    @Override
    public Tweet getTweet(String id) throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        ResultSet rs = null;
        Tweet t = null;
        
        try {
            conn = this.conn;
            conn.AbrirConexao();
            ps = conn.conexao.prepareStatement("SELECT * FROM tweet WHERE id = ?");
            ps.setString(1, id);
            rs = ps.executeQuery();
            while(rs.next()){
                t = new Tweet();
                t.setId(rs.getInt("id"));
                t.setUsuario(rs.getLong("usuario"));
                t.setDataPostagem(rs.getString("data_postagem"));
                t.setTweet(rs.getString("tweet"));
                t.setTweetId(rs.getLong("tweet_id"));
                t.setCategoriaId(rs.getInt("categoria_id"));
                t.setLocalizacaoId(rs.getInt("localizacao_id"));
            }
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
        
        return t;
    }

    @Override
    public boolean hastTweet(long id) throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        ResultSet rs = null;
        boolean result = false;
        
        try {
            conn = this.conn;
            conn.AbrirConexao();
            ps = conn.conexao.prepareStatement("SELECT id FROM tweet WHERE tweet_id = ?");
            ps.setLong(1, id);
            rs = ps.executeQuery();
            if (rs.next()){
                result = true;
            }
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
        
        return result;
    }

    @Override
    public List getDataGraphBar() throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        ResultSet rs = null;
        String sql = "";
        List<List<String>> graph = null;
        JSONObject json = new JSONObject();
        try {
            List categorias = new CategoriaDAO().getCategorias();
            int i = 0;
            Iterator<Categoria> iterator = categorias.iterator();
            while (iterator.hasNext()) {
                conn = this.conn;
                conn.AbrirConexao();
                
                sql = "SELECT l.descricao AS city, COUNT(t.id) AS quantity, c.descricao AS category " +
                      "FROM tweet t " +
                      "LEFT JOIN categoria c ON t.categoria_id = c.id " +
                      "LEFT JOIN localizacao l ON t.localizacao_id = l.id " +
                      "WHERE c.id = '"+iterator.next().getId()+"' " +
                      "GROUP BY l.id";
                ps = conn.conexao.prepareStatement(sql);

                rs = ps.executeQuery();
                graph = new ArrayList<List<String>>();
                while(rs.next()){
                    List<String> data = new ArrayList<String>();
                    data.add(rs.getString("city"));
                    data.add(rs.getString("quantity"));
                    data.add(rs.getString("category"));
                    graph.add(data);
                }
                json.put(""+(i++), graph);
            }
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
        
        return graph;
    }
    
    @Override
    public List getDataGraphLine() throws Exception {
        PreparedStatement ps = null;
        ConexaoDAO conn = null;
        ResultSet rs = null;
        String sql = "";
        List<List<String>> graph = null;
        List graph2 = null;
        JSONObject json2 = null;
        JSONObject json = new JSONObject();
        try {
            List categorias = new CategoriaDAO().getCategorias();
                        
            Iterator<Categoria> iterator = categorias.iterator();
            int i = 0;
            conn = this.conn;
            conn.AbrirConexao();
            
            int k = 0;
            
            while (iterator.hasNext()) {
                graph2 = new ArrayList<List<List<String>>>();
                Categoria cat = iterator.next();
                List localizacoes = new LocalizacaoDAO().getLocalizacoes();
                        
                Iterator<Localizacao> iteratorloc = localizacoes.iterator();
                
                JSONObject json1 = null;
                while (iteratorloc.hasNext()) {
                    
                    sql = "SELECT l.descricao AS city, COUNT(t.id) AS quantity, c.descricao AS category, t.data_postagem AS date " +
                          "FROM tweet t " +
                          "LEFT JOIN categoria c ON t.categoria_id = c.id " +
                          "LEFT JOIN localizacao l ON t.localizacao_id = l.id " +
                          "WHERE c.id = '"+cat.getId()+"' AND l.id = '"+iteratorloc.next().getId()+"' " +
                          "GROUP BY t.data_postagem";
                    ps = conn.conexao.prepareStatement(sql);

                    rs = ps.executeQuery();
                    graph = new ArrayList<List<String>>();
                    int j = 0;
                    json1 = new JSONObject();
                    while(rs.next()){
                        List<String> data = new ArrayList<String>();
                        data.add(rs.getString("city"));
                        data.add(rs.getString("quantity"));
                        data.add(rs.getString("category"));
                        data.add(rs.getString("date"));
                        graph.add(data);
                        json1.put(""+(j++), data);
                    }
                    
                    if (graph.size() > 0) {
                        graph2.add(graph);
                    }
                    
                }
                if (graph2.size() > 0) {
                    json.put(""+(i++), graph2);
                }
                
            }
        } catch(SQLException e) {
            throw new Exception(e);
        }finally{
            conn.FecharConexao();
        }
        return graph2;
    }
}
