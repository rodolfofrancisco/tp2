/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import Models.Tweet;
import java.util.List;
import twitter4j.JSONObject;

/**
 *
 * @author 'Rodolfo
 */
public interface ITweetDAO {
    
    public List getTweets() throws Exception;
    
    public void saveTweet(Tweet tweet, String id) throws Exception;
    
    public Tweet getTweet(String id) throws Exception;
    
    public boolean hastTweet(long id) throws Exception;
    
    public List getDataGraphBar() throws Exception;
    
    public List getDataGraphLine() throws Exception;
     
}
