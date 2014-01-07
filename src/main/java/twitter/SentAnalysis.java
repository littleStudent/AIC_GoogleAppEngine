package twitter;


import org.json.JSONArray;
import org.json.JSONObject;
import org.json.JSONTokener;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.text.Format;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SentAnalysis {

	public static final String TWEETS_SERVER_URL = "54.204.29.207:3001";
	SentimentClassifier sentClassifier;
	private double sentResult;

	String text;
	String from;
	String to;
	int parts;
	int part;

	public SentAnalysis(String text, String from, String to, int parts, int part, String classifierURL) {
		this.sentClassifier = new SentimentClassifier(classifierURL);
		this.text = text;
		this.from = from;
		this.to = to;
		this.parts = parts;
		this.part = part;
		sentClassifier.classifyString("test");
	}

	public void run() {
		Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		try {
			this.performQuery(text, from, to, parts, part);
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void performQuery(String text, String from, String to, int parts, int part) throws InterruptedException, IOException {
		Date date = new Date(Date.parse(from));
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");

		URL url = new URL(
				"http://" + TWEETS_SERVER_URL + "/search?search=" + text + "&from=" + df.format(new Date(Date.parse(from))) + "&to=" + df.format(new Date(Date.parse(to))) + "&parts=" + parts + "&part=" + part);
		URLConnection connection = url.openConnection();
		connection.setConnectTimeout(60000);
		System.out.println("http://" + TWEETS_SERVER_URL + "/search?search=" + text + "&from=" + from + "&to=" + to + "&parts=" + parts + "&part=" + part);
		String line;
		StringBuilder builder = new StringBuilder();
		BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		while ((line = reader.readLine()) != null) {
			builder.append(line);
		}

		JSONTokener tokener = new JSONTokener(builder.toString());
		List<Double> result = new ArrayList<Double>();

		try {
			JSONArray finalResult = new JSONArray(tokener);
			for (int i = 0; i < finalResult.length(); i++) {
				JSONObject tweet = finalResult.getJSONObject(i);
				result.add(getValueForString(sentClassifier.classifyString(tweet.getJSONObject("obj").getString("text"))));
			}
//			double sent = sentClassifier.classify(status.getText());
//			String sentString = sentClassifier.classifyString(status.getText());
//			System.out.println("Sentiment: " + sentString + " " + sent);

		} catch (org.json.JSONException e) {
			e.printStackTrace();
		}
		Double sum = 0.0;
		for (Double value : result) {
			sum += value;
		}
		System.out.println("RESULT: " + sum / result.size());
		sentResult = sum / result.size();
	}

	private Double getValueForString(String value) {
		if (value.equalsIgnoreCase("pos")) {
			return 10.0;
		} else if (value.equalsIgnoreCase("neg")) {
			return 0.0;
		} else {
			return 5.0;
		}
	}

	public double getResult() {
		return sentResult;
	}
}
