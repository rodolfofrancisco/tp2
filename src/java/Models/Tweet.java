/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.io.Serializable;

/**
 *
 * @author 'Rodolfo
 */
public class Tweet implements Serializable {
    
    private int id;
    private long usuario;
    private String dataPostagem;
    private String tweet;
    private long tweetId;
    private int categoriaId;
    private int localizacaoId;
    
    public Tweet() {
        
    }

    public Tweet(int id, long usuario, String dataPostagem, String tweet, long tweetId, int categoriaId, int localizacaoId) {
        this.id = id;
        this.usuario = usuario;
        this.dataPostagem = dataPostagem;
        this.tweet = tweet;
        this.tweetId = tweetId;
        this.categoriaId = categoriaId;
        this.localizacaoId = localizacaoId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public long getUsuario() {
        return usuario;
    }

    public void setUsuario(long usuario) {
        this.usuario = usuario;
    }

    public String getDataPostagem() {
        return dataPostagem;
    }

    public void setDataPostagem(String dataPostagem) {
        this.dataPostagem = dataPostagem;
    }

    public String getTweet() {
        return tweet;
    }

    public void setTweet(String tweet) {
        this.tweet = tweet;
    }

    public long getTweetId() {
        return tweetId;
    }

    public void setTweetId(long tweetId) {
        this.tweetId = tweetId;
    }

    public int getCategoriaId() {
        return categoriaId;
    }

    public void setCategoriaId(int categoriaId) {
        this.categoriaId = categoriaId;
    }

    public int getLocalizacaoId() {
        return localizacaoId;
    }

    public void setLocalizacaoId(int localizacaoId) {
        this.localizacaoId = localizacaoId;
    }
    
}
