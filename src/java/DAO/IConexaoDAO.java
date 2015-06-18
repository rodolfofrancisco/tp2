/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

/**
 *
 * @author Thiago
 */
public interface IConexaoDAO 
{
    public void AbrirConexao() throws Exception;
    public void FecharConexao()throws Exception;
}
