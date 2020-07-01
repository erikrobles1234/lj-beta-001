public class jewelryPriceAdjust {
    public static double priceAdjust(double goldPriceWhenBought, double goldPriceOnSellDay, double piecePrice) {
        if  (goldPriceWhenBought >= goldPriceOnSellDay) {
            return piecePrice;
        }
        else {
            double percentAdjust = goldPriceOnSellDay - goldPriceWhenBought;
            percentAdjust = (percentAdjust / goldPriceWhenBought) + 1;
            piecePrice = piecePrice * percentAdjust;
            return piecePrice;
        }
    }
}