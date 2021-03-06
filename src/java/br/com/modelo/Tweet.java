package br.com.modelo;
// Generated 28/06/2015 17:58:58 by Hibernate Tools 4.3.1


import java.util.Date;

/**
 * Tweet generated by hbm2java
 */
public class Tweet  implements java.io.Serializable {


     private Integer id;
     private Categoria categoria;
     private Localizacao localizacao;
     private long usuario;
     private Date dataPostagem;
     private String tweet;
     private long tweetId;

    public Tweet() {
    }

    public Tweet(Categoria categoria, Localizacao localizacao, long usuario, Date dataPostagem, String tweet, long tweetId) {
       this.categoria = categoria;
       this.localizacao = localizacao;
       this.usuario = usuario;
       this.dataPostagem = dataPostagem;
       this.tweet = tweet;
       this.tweetId = tweetId;
    }
   
    public Integer getId() {
        return this.id;
    }
    
    public void setId(Integer id) {
        this.id = id;
    }
    public Categoria getCategoria() {
        return this.categoria;
    }
    
    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }
    public Localizacao getLocalizacao() {
        return this.localizacao;
    }
    
    public void setLocalizacao(Localizacao localizacao) {
        this.localizacao = localizacao;
    }
    public long getUsuario() {
        return this.usuario;
    }
    
    public void setUsuario(long usuario) {
        this.usuario = usuario;
    }
    public Date getDataPostagem() {
        return this.dataPostagem;
    }
    
    public void setDataPostagem(Date dataPostagem) {
        this.dataPostagem = dataPostagem;
    }
    public String getTweet() {
        return this.tweet;
    }
    
    public void setTweet(String tweet) {
        this.tweet = tweet;
    }
    public long getTweetId() {
        return this.tweetId;
    }
    
    public void setTweetId(long tweetId) {
        this.tweetId = tweetId;
    }




}


