public class inputGoldScrape {

    //purchase and selling method inputs must contain 2 digits for day, month; 4 digits for year

    public static String purchaseDate(int month, int day, int year){
        String sMonth;
        String sDay;
        String sYear = "" + year;
        if (month < 10) {
            sMonth = "0" + month;
        }
        else {
            sMonth = "" + month;
        }
        if (day < 10) {
            sDay = "0" + day;
        }
        else {
            sDay = "" + day;
        }
        String purchaseDate = sYear + "-" + sMonth + "-" + sDay;
        return purchaseDate;
    }

    public static String sellingDate(int month, int day, int year) {
        String sMonth;
        String sDay;
        String sYear = "" + year;
        if (month < 10) {
            sMonth = "0" + month;
        }
        else {
            sMonth = "" + month;
        }
        if (day < 10) {
            sDay = "0" + day;
        }
        else {
            sDay = "" + day;
        }
        String purchaseDate = sYear + "-" + sMonth + "-" + sDay;
        return purchaseDate;
    }

    //public static int jewelryType(String type) { }
}