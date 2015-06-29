/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.controller;

import br.com.modelo.Categoria;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.model.DataModel;
import javax.faces.model.ListDataModel;

/**
 *
 * @author 'Rodolfo
 */
@ManagedBean
@SessionScoped
public class CategoriaController {
    
    private CategoriaDAO jpa = new CategoriaDAO();
    private Categoria categoria = new Categoria();
    public DataModel categorias = null;
    
    public Categoria getCategoria() {
        return categoria;
    }
    
    public void setCategoria(Categoria categoria) {
        this.categoria = categoria;
    }
    
    public String listAction() {
        return "/categoria/list";
    }
    
    public String newAction() {
        categoria = new Categoria();
        return "/categoria/new";
    }
    
    public String editAction() {
        categoria = (Categoria) categorias.getRowData();
        return "/categoria/edit";
    }
    
    public String deleteAction() {
        jpa.delete(categoria);
        return "/categoria/list";
    }
    
    public DataModel getCategorias() {
        categorias = new ListDataModel(jpa.findAll());
        return categorias;
    }
    
    public String saveCategoria() {
        jpa.saveOrUpdate(categoria);
        return "/categoria/list";
    }
    
}
