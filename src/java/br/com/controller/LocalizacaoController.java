/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.controller;

import br.com.modelo.Localizacao;
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
public class LocalizacaoController {
    
    private LocalizacaoDAO jpa = new LocalizacaoDAO();
    private Localizacao localizacao = new Localizacao();
    public DataModel localizacoes = null;
    
    public Localizacao getLocalizacao() {
        return localizacao;
    }
    
    public void setLocalizacao(Localizacao localizacao) {
        this.localizacao = localizacao;
    }
    
    public String listAction() {
        return "/localizacao/list";
    }
    
    public String newAction() {
        localizacao = new Localizacao();
        return "/localizacao/new";
    }
    
    public String editAction() {
        localizacao = (Localizacao) localizacoes.getRowData();
        return "/localizacao/edit";
    }
    
    public String deleteAction() {
        jpa.delete(localizacao);
        return "/localizacao/list";
    }
    
    public DataModel getLocalizacoes() {
        localizacoes = new ListDataModel(jpa.findAll());
        return localizacoes;
    }
    
    public String saveLocalizacao() {
        jpa.saveOrUpdate(localizacao);
        return "/localizacao/list";
    }
    
}
