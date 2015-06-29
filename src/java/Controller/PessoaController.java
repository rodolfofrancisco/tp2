/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Controller;

import DAO.PessoaDAO;
import Models.Pessoa;
import java.io.InputStream;
import java.io.Serializable;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

/**
 *
 * @author 'Rodolfo
 */
@ManagedBean
@SessionScoped
public class PessoaController implements Serializable {

    private String Nome;
    private String Nascimento;
    private InputStream Foto;
    private String Email;
    private String senha;
    private String texto;
    private Pessoa pessoa;    
    
    public PessoaController ()
    {
        
    }

    public Pessoa getPessoa() {
        return pessoa;
    }

    public void setPessoa(Pessoa pessoa) {
        this.pessoa = pessoa;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
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
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }
    
    public String loginAction() {
        return "login";
    }
    
    public String cadastroAction() {
        return "cadastro";
    }

    public String login() {
        try {           
            
            HttpSession session = (HttpSession) FacesContext.getCurrentInstance().getExternalContext().getSession(true);
            
            PessoaDAO pessoaDAO = new PessoaDAO();

            pessoa = pessoaDAO.VerificarLogin(Email, senha);

            if (pessoa == null) {
                session.invalidate();
            } else {
                session.setAttribute("pessoa", pessoa);
                return "index";
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public String logout() {
        System.out.println("logouta");
        HttpSession session = (HttpSession) FacesContext.getCurrentInstance().getExternalContext().getSession(true);

        session.invalidate();
        pessoa = null;
        System.out.println("logout");
        return "login";
    }

    public String Cadastrar() 
    {
        HttpSession session = (HttpSession) FacesContext.getCurrentInstance().getExternalContext().getSession(true);
        
        try 
        {           
            PessoaDAO pessoaDAO;
            //InputStream inputStream = null;

            //Part foto =  (Part) Foto;
            //inputStream = foto.getInputStream();            
            pessoa = new Pessoa(
                    Nome,
                    Nascimento,
                    null,
                    Email,
                    senha);

            pessoaDAO = new PessoaDAO();
            pessoaDAO.Cadastrar(pessoa);
            session.setAttribute("pessoa", pessoa);
            return ("index");

        } 
        catch (Exception e) 
        {
            e.printStackTrace();
        }
        return null;
    }
    
}
