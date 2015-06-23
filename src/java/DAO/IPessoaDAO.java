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
    
}
