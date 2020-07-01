import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;

import java.io.IOException;

public class goldScrape {
    public static double currentMPOfGold() {
        String url = "https://www.apmex.com/gold-price";

        //Creates page document in readable html format
        Document document = null;
        try {
            document = Jsoup.connect(url).get();
        } catch (IOException e) {
            e.printStackTrace();
        }
        
        //Creates a string containing market value of gold from document; targets p.price tag
        String textGoldVal = document.select("p.price").first().text();

        //Converts and returns a double of market value of gold
        textGoldVal = textGoldVal.replaceAll("[^.?0-9]+", ""); 
        double goldPrice = Double.parseDouble(textGoldVal);
        return goldPrice;
    }

    public static double dateMPOfGold(String date) {
        String url = "https://goldprice.org/gold-price-today/" + date;

        Document document = null;
        try {
            document = Jsoup.connect(url).get();
        } catch (IOException e) {
            e.printStackTrace();
        }

        String textGoldVal = document.select("td.text-right").first().text();

        textGoldVal = textGoldVal.replaceAll("[^.?0-9]+","");
        double goldPrice = Double.parseDouble(textGoldVal);
        return goldPrice;
    }
}