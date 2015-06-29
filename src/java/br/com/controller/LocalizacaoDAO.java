/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.controller;

import br.com.modelo.Localizacao;
import java.util.List;

/**
 *
 * @author 'Rodolfo
 */
public class LocalizacaoDAO extends AbstractDao {
    
    public LocalizacaoDAO() {
        super();
    }

    /**
     * Insere uma nova localização no banco de dados.
     * @param localizacao
     */
    public void create(Localizacao localizacao) throws DataAccessLayerException {
        super.saveOrUpdate(localizacao);
    }


    /**
     * Deleta um registro de localização do banco de dados.
     * @param localizacao
     */
    public void delete(Localizacao localizacao) throws DataAccessLayerException {
        super.delete(localizacao);
    }

    /**
     * Procura uma localização pela chave primária
     * @param id
     * @return
     */
    public Localizacao find(int id) throws DataAccessLayerException {
        return (Localizacao) super.find(Localizacao.class, id);
    }

    /**
     * Atualiza um registro de localização.
     *
     * @param localizacao
     */
    public void update(Localizacao localizacao) throws DataAccessLayerException {
        super.saveOrUpdate(localizacao);
    }

    /**
     * Retorna todos os registros de localização do banco de dados.
     * @return
     */
    public List findAll() throws DataAccessLayerException{
        return super.findAll(Localizacao.class);
    }
   
}
