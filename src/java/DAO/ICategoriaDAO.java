/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Models.Categoria;
import java.util.List;

/**
 *
 * @author 'Rodolfo
 */
public interface ICategoriaDAO {
    
    public List getCategorias() throws Exception;
    
    public void saveCategoria(Categoria categoria, String id) throws Exception;
    
    public Categoria getCategoria(String id) throws Exception;
    
    public void deleteCategoria(String id) throws Exception;
     
}
