public class AuthorizeDotNet {
    private static String DATE_SEPERATOR_DASH = '-';
    private static String DATE_SEPERATOR_SLASH = '/';
    private static String MILLENNIA = '20';
    private static Integer START_OF_MONTH = 1;

    public static String dateToString(Date expDate) {
        Integer year = expDate.year();
        Integer month = expDate.month();
        // Format as 'YYYY-MM'
        //String formattedDate = String.valueOf(year) + '-' + (month < 10 ? '0' + String.valueOf(month) : String.valueOf(month));
        // New format as MM/YYYY
        String formattedDate = (month < 10 ? '0' + String.valueOf(month) : String.valueOf(month)) + DATE_SEPERATOR_DASH + String.valueOf(year);
        return formattedDate;
    }

    // Expects date to be formatted according to AuthDotNet platform
    public static Date stringToDate(String expDate) {
        String regExp = '['+DATE_SEPERATOR_DASH+DATE_SEPERATOR_SLASH+']';
        String[] parts = expDate.split(regExp);
        String month, year;
        Integer m, y;

        month = parts[1];
        year = parts[0];
        m = Integer.valueOf(month);
        y = Integer.valueOf(year);

        return Date.newInstance(y, m, START_OF_MONTH);
    }
    
    public static String formatDateString(String expDate) {
        String regExp = '['+DATE_SEPERATOR_DASH+DATE_SEPERATOR_SLASH+']';
        String[] parts = expDate.split(regExp);
        String month, year;
        if(parts.size() != 2) {
            throw new AuthorizeDotNetException('PARSE_ERROR: Too few or many components to date.');
        }
        month = parts[0];
        year = parts[1];

        // Validates input date before concatination
        Integer m, y;
        m = Integer.valueOf(month);
        y = Integer.valueOf(year);
        month = String.valueOf(m).leftPad(2, '0');
        year = String.valueOf(y).leftPad(2, '0');

        if(y < 100) {
            year = MILLENNIA + year;
        }

        String template = '{1}' + DATE_SEPERATOR_DASH +'{0}';
        return String.format(template, new List<Object> {month, year});
    }
}