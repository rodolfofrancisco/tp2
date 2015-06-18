/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.io.InputStream;
import java.io.Serializable;
import java.sql.Blob;
import javax.faces.bean.ManagedBean;

/**
 *
 * @author Thiago
 */
@ManagedBean
public class Pessoa implements java.io.Serializable
{    
    private int IdPessoa;
    
    private String Nome;
    
    private String Nascimento;
    
    private InputStream Foto;
    
    private String Email;
    
    private String Senha;     
    
    public Pessoa (){}

    public Pessoa(String Nome, String Nascimento, InputStream Foto, String Email, String Senha) {
        this.Nome = Nome;
        this.Nascimento = Nascimento;
        this.Foto = Foto;
        this.Email = Email;
        this.Senha = Senha;
    }

    public int getIdPessoa() {
        return IdPessoa;
    }

    public void setIdPessoa(int IdPessoa) {
        this.IdPessoa = IdPessoa;
    }

    public String getNome() {
        return Nome;
    }

    public void setNome(String Nome) {
        this.Nome = Nome;
    }

    public String getNascimento() {
        return Nascimento;
    }

    public void setNascimento(String Nascimento) {
        this.Nascimento = Nascimento;
    }

    public InputStream getFoto() {
        return Foto;
    }

    public void setFoto(InputStream Foto) {
        this.Foto = Foto;
    }

    public String getEmail() {
        return Email;
    }

    public void setEmail(String Email) {
        this.Email = Email;
    }

    public String getSenha() {
        return Senha;
    }

    public void setSenha(String Senha) {
        this.Senha = Senha;
    }

    
    
    
}
