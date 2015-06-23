/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Beans;

import Models.Categoria;
import Models.Localizacao;
import Models.Tweet;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import twitter4j.*;
import twitter4j.auth.OAuth2Token;
import twitter4j.conf.ConfigurationBuilder;

import java.util.Map;

/**
 *
 * @author 'Rodolfo
 */
public class Crawler {

	//	Set this to your actual CONSUMER KEY and SECRET for your application as given to you by dev.twitter.com
	private static final String CONSUMER_KEY		= "aljnGUyIuROVGKJSbavAuvLcP";
	private static final String CONSUMER_SECRET 	= "1L9BoJZ89diEVHT287OPWqT5FimtA5qNGTBBYvHk8C67RAeIpQ";

	//	How many tweets to retrieve in every call to Twitter. 100 is the maximum allowed in the API
	private static final int TWEETS_PER_QUERY		= 100;

	//	This controls how many queries, maximum, we will make of Twitter before cutting off the results.
	//	You will retrieve up to MAX_QUERIES*TWEETS_PER_QUERY tweets.
	//
	//  If you set MAX_QUERIES high enough (e.g., over 450), you will undoubtedly hit your rate limits
	//  and you an see the program sleep until the rate limits reset
	private static final int MAX_QUERIES			= 5;

	//	What we want to search for in this program.  Justin Bieber always returns as many results as you could
	//	ever want, so it's safe to assume we'll get multiple pages back...
	private static final String SEARCH_TERM			= "exclude:retweets assalto BH OR \"Belo Horizonte\" OR \"Belo Horizonte, Minas Gerais\"";


	/**
	 * Replace newlines and tabs in text with escaped versions to making printing cleaner
	 *
	 * @param text	The text of a tweet, sometimes with embedded newlines and tabs
	 * @return		The text passed in, but with the newlines and tabs replaced
	 */
	public static String cleanText(String text)
	{
		text = text.replace("\n", "\\n");
		text = text.replace("\t", "\\t");

		return text;
	}


	/**
	 * Retrieve the "bearer" token from Twitter in order to make application-authenticated calls.
	 *
	 * This is the first step in doing application authentication, as described in Twitter's documentation at
	 * https://dev.twitter.com/docs/auth/application-only-auth
	 *
	 * Note that if there's an error in this process, we just print a message and quit.  That's a pretty
	 * dramatic side effect, and a better implementation would pass an error back up the line...
	 *
	 * @return	The oAuth2 bearer token
	 */
	public static OAuth2Token getOAuth2Token()
	{
		OAuth2Token token = null;
		ConfigurationBuilder cb;

		cb = new ConfigurationBuilder();
		cb.setApplicationOnlyAuthEnabled(true);

		cb.setOAuthConsumerKey(CONSUMER_KEY).setOAuthConsumerSecret(CONSUMER_SECRET);

		try
		{
			token = new TwitterFactory(cb.build()).getInstance().getOAuth2Token();
		}
		catch (Exception e)
		{
			System.out.println("Could not get OAuth2 token");
			e.printStackTrace();
			System.exit(0);
		}

		return token;
	}

	/**
	 * Get a fully application-authenticated Twitter object useful for making subsequent calls.
	 *
	 * @return	Twitter4J Twitter object that's ready for API calls
	 */
	public static Twitter getTwitter()
	{
		OAuth2Token token;

		//	First step, get a "bearer" token that can be used for our requests
		token = getOAuth2Token();

		//	Now, configure our new Twitter object to use application authentication and provide it with
		//	our CONSUMER key and secret and the bearer token we got back from Twitter
		ConfigurationBuilder cb = new ConfigurationBuilder();

		cb.setApplicationOnlyAuthEnabled(true);

		cb.setOAuthConsumerKey(CONSUMER_KEY);
		cb.setOAuthConsumerSecret(CONSUMER_SECRET);

		cb.setOAuth2TokenType(token.getTokenType());
		cb.setOAuth2AccessToken(token.getAccessToken());

		//	And create the Twitter object!
		return new TwitterFactory(cb.build()).getInstance();

	}

	public String teste() {
            String result = "";
            int	totalTweets = 0;
            long maxID = -1;
            
            GeoLocation geo = new GeoLocation(Double.parseDouble("-19.9225"), Double.parseDouble("-43.9450"));
            result += geo.getLatitude()+" "+geo.getLongitude()+"<br><br>";

            Twitter twitter = getTwitter();

	
            try {
		Map<String, RateLimitStatus> rateLimitStatus = twitter.getRateLimitStatus("search");
                RateLimitStatus searchTweetsRateLimit = rateLimitStatus.get("/search/tweets");

                result += "You have "+searchTweetsRateLimit.getRemaining()+" calls remaining out of "+searchTweetsRateLimit.getLimit()+", Limit resets in "+searchTweetsRateLimit.getSecondsUntilReset()+" seconds<br/><br/>";


		for (int queryNumber=0;queryNumber < MAX_QUERIES; queryNumber++) {
                    //	Do we need to delay because we've already hit our rate limits?
                    if (searchTweetsRateLimit.getRemaining() == 0) {
                        //	Yes we do, unfortunately ...
//                        System.out.printf("!!! Sleeping for %d seconds due to rate limits\n", searchTweetsRateLimit.getSecondsUntilReset());

					//	If you sleep exactly the number of seconds, you can make your query a bit too early
					//	and still get an error for exceeding rate limitations
					//
					// 	Adding two seconds seems to do the trick. Sadly, even just adding one second still triggers a
					//	rate limit exception more often than not.  I have no idea why, and I know from a Comp Sci
					//	standpoint this is really bad, but just add in 2 seconds and go about your business.  Or else.
//					Thread.sleep((searchTweetsRateLimit.getSecondsUntilReset()+2) * 1000l);
                    }

                    Query q = new Query(SEARCH_TERM); //.geoCode((geo), 100, "mi");			// Search for tweets that contains this term
                    q.setCount(TWEETS_PER_QUERY);				// How many tweets, max, to retrieve
//                    q.setGeoCode(geo, 100, Query.Unit.mi);
//                    q.setSince("2012-02-20");
//                                
//				q.resultType("recent");						// Get all tweets
//				q.setLang("en");							// English language tweets, please

                    
				//	If maxID is -1, then this is our first call and we do not want to tell Twitter what the maximum
				//	tweet id is we want to retrieve.  But if it is not -1, then it represents the lowest tweet ID
				//	we've seen, so we want to start at it-1 (if we start at maxID, we would see the lowest tweet
				//	a second time...
                    if (maxID != -1) {
                        q.setMaxId(maxID - 1);
                    }

				//	This actually does the search on Twitter and makes the call across the network
                    QueryResult r = twitter.search(q);

				//	If there are NO tweets in the result set, it is Twitter's way of telling us that there are no
				//	more tweets to be retrieved.  Remember that Twitter's search index only contains about a week's
				//	worth of tweets, and uncommon search terms can run out of week before they run out of tweets
                    if (r.getTweets().size() == 0) {
                            break;			// Nothing? We must be done
                    }


				//	loop through all the tweets and process them.  In this sample program, we just print them
				//	out, but in a real application you might save them to a database, a CSV file, do some
				//	analysis on them, whatever...
				for (Status s: r.getTweets())				// Loop through all the tweets...
				{
					//	Increment our count of tweets retrieved
					totalTweets++;

					//	Keep track of the lowest tweet ID.  If you do not do this, you cannot retrieve multiple
					//	blocks of tweets...
					if (maxID == -1 || s.getId() < maxID)
					{
						maxID = s.getId();
					}
					//	Do something with the tweet....
					result += "ID: "+s.getId()+" Data "+s.getCreatedAt().toString()+ " user "+s.getUser().getScreenName()+" texto: "+cleanText(s.getText())+"  <br/>";

				}

				//	As part of what gets returned from Twitter when we make the search API call, we get an updated
				//	status on rate limits.  We save this now so at the top of the loop we can decide whether we need
				//	to sleep or not before making the next call.
				searchTweetsRateLimit = r.getRateLimitStatus();
			}

		}
		catch (Exception e)
		{
			//	Catch all -- you're going to read the stack trace and figure out what needs to be done to fix it
                }
                result += "<br><br>"+totalTweets+"<br>";
                return result;
        }
        
        public List search(Categoria categoria, Localizacao localizacao) throws Exception {
            long maxID = -1;
            
            List<Tweet> list = new ArrayList<Tweet>();
            Twitter twitter = getTwitter();
            try {
		Map<String, RateLimitStatus> rateLimitStatus = twitter.getRateLimitStatus("search");
                RateLimitStatus searchTweetsRateLimit = rateLimitStatus.get("/search/tweets");
		for (int queryNumber=0;queryNumber < MAX_QUERIES; queryNumber++) {
                    if (searchTweetsRateLimit.getRemaining() == 0) {
                    }
                    
                    String works = localizacao.getPalavrasChaves();
                    String[] arrWorks = works.split(",");
                    String keywork = "", or = "OR";

                    for (int i = 0; i < arrWorks.length; i++) {
                        if ((i + 1) >= arrWorks.length) {
                            or = "";
                        }
                        keywork += " \""+arrWorks[i] +"\" "+or;
                    }
                    System.out.println("exclude:retweets "+categoria.getDescricao()+keywork);
                    Query q = new Query("exclude:retweets "+categoria.getDescricao()+keywork);
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
                        String dataPostagem = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(s.getCreatedAt());
                        t.setDataPostagem(dataPostagem);
                        t.setTweet(s.getText());
                        t.setTweetId(s.getId());
                        t.setCategoriaId(categoria.getId());
                        t.setLocalizacaoId(localizacao.getId());
                        list.add(t);
                    }
                    searchTweetsRateLimit = r.getRateLimitStatus();
                }
            } catch (Exception e) {
		throw e;
            }
            
            return list;
        }
}