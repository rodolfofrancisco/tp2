/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.controller;

import br.com.modelo.Tweet;
import java.util.List;

/**
 *
 * @author 'Rodolfo
 */
public class TweetDAO extends AbstractDao {
    
    public TweetDAO() {
        super();
    }

    /**
     * Insere um novo tweet no banco de dados.
     * @param tweet
     */
    public void create(Tweet tweet) throws DataAccessLayerException {
        super.saveOrUpdate(tweet);
    }


    /**
     * Deleta um registro de tweet do banco de dados.
     * @param tweet
     */
    public void delete(Tweet tweet) throws DataAccessLayerException {
        super.delete(tweet);
    }

    /**
     * Pesquisa um tweet pela chave primária.
     * @param id
     * @return
     */
    public Tweet find(int id) throws DataAccessLayerException {
        return (Tweet) super.find(Tweet.class, id);
    }

    /**
     * Atualiza um registro de tweet.
     *
     * @param tweet
     */
    public void update(Tweet tweet) throws DataAccessLayerException {
        super.saveOrUpdate(tweet);
    }

    /**
     * Retorna todos os tweets do banco de dados.
     * @return
     */
    public List findAll() throws DataAccessLayerException{
        return super.findAll(Tweet.class);
    }
   
}
