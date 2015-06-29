/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.controller;

import antlr.debug.Event;
import br.com.modelo.Categoria;
import java.util.List;
import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.Transaction;

/**
 *
 * @author 'Rodolfo
 */
public class CategoriaDAO extends AbstractDao {
    
    public CategoriaDAO() {
        super();
    }

    /**
     * Insert a new Event into the database.
     * @param event
     */
    public void create(Categoria categoria) throws DataAccessLayerException {
        super.saveOrUpdate(categoria);
    }


    /**
     * Delete a detached Event from the database.
     * @param event
     */
    public void delete(Categoria categoria) throws DataAccessLayerException {
        super.delete(categoria);
    }

    /**
     * Find an Event by its primary key.
     * @param id
     * @return
     */
    public Categoria find(int id) throws DataAccessLayerException {
        return (Categoria) super.find(Categoria.class, id);
    }

    /**
     * Updates the state of a detached Event.
     *
     * @param event
     */
    public void update(Categoria categoria) throws DataAccessLayerException {
        super.saveOrUpdate(categoria);
    }

    /**
     * Finds all Events in the database.
     * @return
     */
    public List findAll() throws DataAccessLayerException{
        return super.findAll(Categoria.class);
    }
   
}
