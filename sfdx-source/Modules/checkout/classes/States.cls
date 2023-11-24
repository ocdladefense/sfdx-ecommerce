public without sharing class States {
    // will consist of state code and state name (including 'XX' for 'all states' option)

    private static Map<String, String> buildStateMapThing() {
        Map<String, String> thingy = new Map<String, String>();
        thingy.put('OR', 'Oregon');
        thingy.put('WA', 'Washington');
        thingy.put('CA', 'California');
        thingy.put('ID', 'Idaho');
        thingy.put('HI', 'Hawaii');
        thingy.put('XX', '--- ALL STATES ---');
        thingy.put('AL', 'Alabama');
        thingy.put('AK', 'Alaska');
        thingy.put('AZ', 'Arizona');
        thingy.put('AR', 'Arkansas');
        thingy.put('CA', 'California');
        thingy.put('CO', 'Colorado');
        thingy.put('CT', 'Connecticut');
        thingy.put('DE', 'Delaware');
        thingy.put('FL', 'Florida');
        thingy.put('GA', 'Georgia');
        thingy.put('HI', 'Hawaii');
        thingy.put('ID', 'Idaho');
        thingy.put('IL', 'Illinois');
        thingy.put('IN', 'Indiana');
        thingy.put('IA', 'Iowa');
        thingy.put('KS', 'Kansas');
        thingy.put('KY', 'Kentucky');
        thingy.put('LA', 'Louisiana');
        thingy.put('ME', 'Maine');
        thingy.put('MD', 'Maryland');
        thingy.put('MA', 'Massachusetts');
        thingy.put('MI', 'Michigan');
        thingy.put('MN', 'Minnesota');
        thingy.put('MS', 'Mississippi');
        thingy.put('MO', 'Missouri');
        thingy.put('MT', 'Montana');
        thingy.put('NE', 'Nebraska');
        thingy.put('NV', 'Nevada');
        thingy.put('NH', 'New Hampshire');
        thingy.put('NJ', 'New Jersey');
        thingy.put('NM', 'New Mexico');
        thingy.put('NY', 'New York');
        thingy.put('NC', 'North Carolina');
        thingy.put('ND', 'North Dakota');
        thingy.put('OH', 'Ohio');
        thingy.put('OK', 'Oklahoma');
        thingy.put('OR', 'Oregon');
        thingy.put('PA', 'Pennsylvania');
        thingy.put('RI', 'Rhode Island');
        thingy.put('SC', 'South Carolina');
        thingy.put('SD', 'South Dakota');
        thingy.put('TN', 'Tennessee');
        thingy.put('TX', 'Texas');
        thingy.put('UT', 'Utah');
        thingy.put('VT', 'Vermont');
        thingy.put('VA', 'Virginia');
        thingy.put('WA', 'Washington');
        thingy.put('WV', 'West Virginia');
        thingy.put('WI', 'Wisconsin');
        thingy.put('WY', 'Wyoming');
        thingy.put('DC', 'Washington DC');

        return thingy;
    }

    public static List<SelectOption> getAsSelectOptions() {
        List<SelectOption> optionList = new List<SelectOption>();
        Map<String, String> states = buildStateMapThing();

        for (String code : states.keySet()) {
            String state = states.get(code);
            if (code == 'XX') {
                optionList.add(new SelectOption(code, state, true)); // disabled option
                continue; // move to next iteration in loop
            }
            optionList.add(new SelectOption(code, state));
        }

        return optionList;
    }
    
}