import java.util.Scanner;

public class goldMaster {
    public static void main (String[] args) {
        //Date of purchase has been hardcoded for testing purposes
        String stringConvBoughtPrice = inputGoldScrape.purchaseDate(05, 10, 2020);

        //piecePrice is given a temp hardcoded value for testing purposes
        Double piecePrice = 675.00;
        Double goldPriceWhenBought = goldScrape.dateMPOfGold(stringConvBoughtPrice);
        Double goldPriceOnSellDay = goldScrape.currentMPOfGold();

        double adjustedPrice = jewelryPriceAdjust.priceAdjust(goldPriceWhenBought, goldPriceOnSellDay, piecePrice);

        System.out.println("Price of gold when bought: " + goldPriceWhenBought);
        System.out.println("Price of gold today: " + goldPriceOnSellDay);
        System.out.println("Price of piece when bought: " + piecePrice);
        System.out.println("The adjusted price for piece is: " + adjustedPrice);
    }
}