/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Models.Pessoa;

/**
 *
 * @author Thiago
 */
public interface IPessoaDAO 
{
    public Pessoa VerificarLogin(String email, String senha) throws Exception;
    public void Cadastrar(Pessoa pessoa) throws Exception;
    public Pessoa Search(String texto) throws Exception;
    
}
