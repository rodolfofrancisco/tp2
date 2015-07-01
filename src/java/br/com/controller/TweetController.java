/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package br.com.controller;

import br.com.modelo.Categoria;
import br.com.modelo.Localizacao;
import br.com.modelo.Tweet;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.bean.SessionScoped;
import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.faces.model.DataModel;
import org.primefaces.model.chart.Axis;
import org.primefaces.model.chart.AxisType;
import org.primefaces.model.chart.BarChartModel;
import org.primefaces.model.chart.CategoryAxis;
import org.primefaces.model.chart.ChartSeries;
import org.primefaces.model.chart.LineChartModel;
import twitter4j.GeoLocation;
import twitter4j.JSONObject;
import twitter4j.Query;
import twitter4j.QueryResult;
import twitter4j.RateLimitStatus;
import twitter4j.Status;
import twitter4j.Twitter;
import twitter4j.TwitterFactory;
import twitter4j.auth.OAuth2Token;
import twitter4j.conf.ConfigurationBuilder;

/**
 *
 * @author 'Rodolfo
 */
@ManagedBean
@RequestScoped
public class TweetController {
    
    private TweetDAO jpa = new TweetDAO();
    private Tweet tweet = new Tweet();
    public DataModel tweets = null;
    private List categorias = null;
    private String categoria = null;
    private List localizacoes = null;
    private String localizacao = null;
    private BarChartModel barModel;
    private LineChartModel lineModel;
    
    @PostConstruct
    public void init() {
        createBarModels();
    }
 
    public BarChartModel getBarModel() {
        return barModel;
    }
    
    public LineChartModel getLineModel() {
        return lineModel;
    }
    
    private BarChartModel initBarModel() {
        BarChartModel model = new BarChartModel();
        
        try {
            List tweets = new DAO.TweetDAO().getDataGraphBar();
            for (Iterator it = tweets.iterator(); it.hasNext();) {
                ChartSeries graph = new ChartSeries();
                List<String> tweet = (List<String>) it.next();
                graph.setLabel(tweet.get(0));
                graph.set("", Integer.parseInt(tweet.get(1)));
                model.addSeries(graph);
            }
        } catch (Exception ex) {
            Logger.getLogger(TweetController.class.getName()).log(Level.SEVERE, null, ex);
        }
         
        return model;
    }
     
    private void createBarModels() {
        createBarModel();
    }
     
    private void createBarModel() {
        barModel = initBarModel();
         
        barModel.setTitle("Assalto");
        barModel.setLegendPosition("ne");
         
        Axis xAxis = barModel.getAxis(AxisType.X);
        xAxis.setLabel("cidades");
         
        Axis yAxis = barModel.getAxis(AxisType.Y);
        yAxis.setLabel("tweets");
        yAxis.setMin(0);
//        yAxis.setMax(200);
        
        lineModel = initCategoryModel();
        lineModel.setTitle("tweets");
        lineModel.setLegendPosition("e");
        lineModel.setShowPointLabels(true);
        lineModel.getAxes().put(AxisType.X, new CategoryAxis("postagem"));
        yAxis = lineModel.getAxis(AxisType.Y);
        yAxis.setLabel("tweets");
        yAxis.setMin(0);
//        yAxis.setMax(200);
    }
    
    private LineChartModel initCategoryModel() {
        LineChartModel model = new LineChartModel();
 
        try {
            List tweets = new DAO.TweetDAO().getDataGraphLine();
            String[] loc = null; int i = 1;
            for (Iterator iterator = tweets.iterator(); iterator.hasNext();) {
                List<List<String>> localizacoes = (List<List<String>>) iterator.next();
                ChartSeries line = new ChartSeries();
                for (Iterator<List<String>> iterator1 = localizacoes.iterator(); iterator1.hasNext();) {
                    List<String> next = iterator1.next();
                    line.setLabel(next.get(0));
                    String oldstring = next.get(3);
                    Date date = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S").parse(oldstring);
                    String newstring = new SimpleDateFormat("dd/MM").format(date);
                    line.set(newstring, Integer.parseInt(next.get(1)));
                }
                model.addSeries(line);
            }
            
        } catch (Exception ex) {
            Logger.getLogger(TweetController.class.getName()).log(Level.SEVERE, null, ex);
        }
         
        return model;
    }
    
    public Tweet getTweet() {
        return tweet;
    }
    
    public void setTweet(Tweet tweet) {
        this.tweet = tweet;
    }

    public List getCategorias() {
        return categorias;
    }

    public void setCategorias(List categorias) {
        this.categorias = categorias;
    }

    public String getCategoria() {
        return categoria;
    }

    public void setCategoria(String categoria) {
        this.categoria = categoria;
    }

    public List getLocalizacoes() {
        return localizacoes;
    }

    public void setLocalizacoes(List localizacoes) {
        this.localizacoes = localizacoes;
    }

    public String getLocalizacao() {
        return localizacao;
    }

    public void setLocalizacao(String localizacao) {
        this.localizacao = localizacao;
    }
    
    public TweetController() {
        categorias = new CategoriaDAO().findAll();
        localizacoes = new LocalizacaoDAO().findAll();
        createBarModels();
    }
    
    private static final String CONSUMER_KEY = "aljnGUyIuROVGKJSbavAuvLcP";
    private static final String CONSUMER_SECRET	= "1L9BoJZ89diEVHT287OPWqT5FimtA5qNGTBBYvHk8C67RAeIpQ";

    private static final int TWEETS_PER_QUERY = 100;
    private static final int MAX_QUERIES = 5;

    public static String cleanText(String text) {
        text = text.replace("\n", "\\n");
        text = text.replace("\t", "\\t");

        return text;
    }


    public static OAuth2Token getOAuth2Token() {
        OAuth2Token token = null;
        ConfigurationBuilder cb;

        cb = new ConfigurationBuilder();
        cb.setApplicationOnlyAuthEnabled(true);

        cb.setOAuthConsumerKey(CONSUMER_KEY).setOAuthConsumerSecret(CONSUMER_SECRET);

        try {
            token = new TwitterFactory(cb.build()).getInstance().getOAuth2Token();
        } catch (Exception e) {
            System.out.println("Could not get OAuth2 token");
            e.printStackTrace();
            System.exit(0);
        }

        return token;
    }

    
    public static Twitter getTwitter() {
        OAuth2Token token;

        token = getOAuth2Token();
        ConfigurationBuilder cb = new ConfigurationBuilder();

        cb.setApplicationOnlyAuthEnabled(true);

        cb.setOAuthConsumerKey(CONSUMER_KEY);
        cb.setOAuthConsumerSecret(CONSUMER_SECRET);

        cb.setOAuth2TokenType(token.getTokenType());
        cb.setOAuth2AccessToken(token.getAccessToken());

        return new TwitterFactory(cb.build()).getInstance();
    }
    
    public String search() {
        Categoria c = new CategoriaDAO().find(Integer.parseInt(categoria));
        Localizacao l = new LocalizacaoDAO().find(Integer.parseInt(localizacao));
        long maxID = -1;

        Twitter twitter = getTwitter();
        try {
            Map<String, RateLimitStatus> rateLimitStatus = twitter.getRateLimitStatus("search");
            RateLimitStatus searchTweetsRateLimit = rateLimitStatus.get("/search/tweets");
            for (int queryNumber=0;queryNumber < MAX_QUERIES; queryNumber++) {
                if (searchTweetsRateLimit.getRemaining() == 0) { }

                String works = c.getPalavrasChaves();
                String[] arrWorks = works.split(",");
                String keywork = "", or = "OR", query = "";

                for (int i = 0; i < arrWorks.length; i++) {
                    if ((i + 1) >= arrWorks.length) {
                        or = "";
                    }
                    keywork += " \""+arrWorks[i] +"\" "+or;
                }
                
                query = "exclude:retweets "+keywork;
                
                works = l.getPalavrasChaves();
                arrWorks = works.split(",");
                keywork = ""; or = "OR";

                for (int i = 0; i < arrWorks.length; i++) {
                    if ((i + 1) >= arrWorks.length) {
                        or = "";
                    }
                    keywork += " \""+arrWorks[i] +"\" "+or;
                }
                
                query += keywork;
                
                Query q = new Query(query);
                q.setCount(TWEETS_PER_QUERY);
                if (maxID != -1) {
                    q.setMaxId(maxID - 1);
                }
                QueryResult r = twitter.search(q);
                if (r.getTweets().size() == 0) {
                    break;
                }
                for (Status s: r.getTweets()) {
                    if (maxID == -1 || s.getId() < maxID) {
                        maxID = s.getId();
                    }
                    
                    Tweet t = new Tweet();
                    t.setUsuario(s.getUser().getId());
                    t.setDataPostagem(s.getCreatedAt());
                    t.setTweet(s.getText());
                    if (! new DAO.TweetDAO().hastTweet(s.getId())) {
                        t.setTweetId(s.getId());
                        t.setCategoria(c);
                        t.setLocalizacao(l);
                        jpa.saveOrUpdate(t);
                    }
                }
                searchTweetsRateLimit = r.getRateLimitStatus();
            }
        } catch (Exception e) { }
        
        
        return "index";
    }
    
}
