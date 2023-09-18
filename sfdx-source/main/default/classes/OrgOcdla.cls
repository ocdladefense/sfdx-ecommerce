global without sharing class OrgOcdla {
  
    public static final Id membersOnlyBadge = 'a0dj0000000NQUs';
    
    public static final Id MEMBERS_ONLY_BADGE_ID = 'a0dj0000000NQUs';
    
    public static final Id ACCOUNT_MANAGER_DEFAULT_ACCOUNT_OWNER_ID = '005j000000DDkk7';
    
    public static final String GUEST_CHECKOUT_ACCOUNT_NAME = 'Guest Checkout';
    
    public static Id GUEST_CHECKOUT_ACCOUNT_ID;
    
    public static final PageReference CHECKOUT_PAGE = Page.OcdlaShoppingCart;
    
    public static final String COMMUNITY_NAME = 'OCDLA Member Community';
    
    // The required Name for any OrderApi__Price_Rule__c.
	public static final String MEMBER_PRICE_RULE_NAME = 'Member Discount';
    
    public static String STANDARD_PRICE_BOOK_DISPLAY_NAME = 'Members';
    
    public static String NON_MEMBER_PRICE_BOOK_DISPLAY_NAME = 'Non-members';
    
    public static final PageReference SHOPPING_CART_REGENERATE_OPPORTUNITY_PAGE = Page.OcdlaEvents;
    
    // For this Org, this is the Members product pricing, all products.
    public static Id STANDARD_PRICE_BOOK_ID;
    
    // For this Org, this is the Non-members products pricing, limited products.
    public static Id NON_MEMBER_PRICE_BOOK_ID;
    
    public static final String NON_MEMBER_PRICE_BOOK_NAME = 'Non-member';
    
    
    
    
    private static final Map<String, Object> settings = new Map<String, Object>{
        'OrgSchema' => new Map<String, String>{
            'Item' => 'OrderApi__Item__c',
                'ItemClass' => 'OrderApi__Item_Class__c'
      }
    };
        
/*        
tring STANDARD_PRICE_BOOK_DISPLAY_NAME = 'Members';
    
    public static String NON_MEMBER_PRICE_BOOK_DISPLAY_NAME = 'Non-members';
*/     
        
        public static PageReference redirectTo(PageReference p){
            p.setRedirect(True);
            return p;
        }
        
    public static String getPriceBookDisplayName(Id pbId){
        if(pbId == getStdPriceBookId()) return STANDARD_PRICE_BOOK_DISPLAY_NAME;
        else return NON_MEMBER_PRICE_BOOK_DISPLAY_NAME;
    }
    
        public static Id getGuestCheckoutAccountId(){
            if(null != GUEST_CHECKOUT_ACCOUNT_ID) return GUEST_CHECKOUT_ACCOUNT_ID;
            Account a = [SELECT Id, Name FROM Account WHERE NAME LIKE '%Guest Checkout%' LIMIT 1];
            GUEST_CHECKOUT_ACCOUNT_ID = a.Id;
            return GUEST_CHECKOUT_ACCOUNT_ID;
        }
    
    //  ------------------------------------------------------
    //  getStdPricebookId : as of V31, testmethods can locate std pricebook wo seeAlldata=true
    //  ------------------------------------------------------
    public static Id getStdPriceBookId() {
        if(null != STANDARD_PRICE_BOOK_ID) return STANDARD_PRICE_BOOK_ID;
        STANDARD_PRICE_BOOK_ID = Test.isRunningTest() ? Test.getStandardPricebookId() : getStandardPriceBook().Id;
        return STANDARD_PRICE_BOOK_ID;
    } 
    
    public static Id getNonMemberPriceBookId(){
        if(null != NON_MEMBER_PRICE_BOOK_ID) return NON_MEMBER_PRICE_BOOK_ID;
        PriceBook2 pb = getCustomPriceBook(NON_MEMBER_PRICE_BOOK_NAME);
        NON_MEMBER_PRICE_BOOK_ID = null == pb ? null : pb.Id;
        return NON_MEMBER_PRICE_BOOK_ID;
    } 
    
    //  -------------------------------------------------------
    //  getStdPriceBook: Singleton
    //  -------------------------------------------------------
    public static PriceBook2 getStandardPriceBook(){
        List<PriceBook2> pb;
        
        pb = [SELECT Id, Name FROM Pricebook2 WHERE isStandard = True LIMIT 1];
        
        return (null != pb && pb.size() > 0 ? pb[0] : null);
    }
    
    public static PriceBook2 getCustomPriceBook(String name) {
        List<PriceBook2> pb;
        
        pb = [SELECT Id, Name FROM Pricebook2 WHERE Name = :name LIMIT 1];            
        
        return (null != pb && pb.size() > 0 ? pb[0] : null);
    }
    
    private static Map<String,Schema.SObjectType> sObjects = new Map<String,Schema.SObjectType>();
    
    public static final DefaultSettings defaults = new DefaultSettings(settings);
    
    public static Schema.SObjectType getSObject(String typeLookup){
        Schema.SObjectType targetType;
        Map<String,String> types;
        String typeReference;
        
        // Look for a cached value and return it, if found.
        if(sObjects.containsKey(typeLookup)) return sObjects.get(typeLookup);
        
        types = (Map<String,String>)defaults.getSetting('OrgSchema');
        
        typeReference = types.get(typeLookup);
        
        targetType = Schema.getGlobalDescribe().get(typeReference);
        
        return targetType;
    }
    
    public static Boolean isSandbox(){
        Organization myOrg = [SELECT Id, IsSandbox FROM Organization WHERE Id = :UserInfo.getOrganizationId()];
        
        return myOrg.IsSandbox;
    }
    
    webservice static String getOrgInfo(){
        Organization myOrg = [SELECT o.Id, o.Name, o.IsSandbox, o.WebToCaseDefaultOrigin, o.UsesStartDateAsFiscalYearName, o.UiSkin, o.TrialExpirationDate,
                              o.SystemModstamp, o.Street, o.State, o.ReceivesInfoEmails, o.ReceivesAdminInfoEmails, o.PrimaryContact,
                              o.PreferencesRequireOpportunityProducts, o.PostalCode, o.Phone, o.OrganizationType,
                              o.MonthlyPageViewsUsed, o.MonthlyPageViewsEntitlement, o.LastModifiedDate, o.LastModifiedById,
                              o.LanguageLocaleKey, o.FiscalYearStartMonth, o.Fax, o.Division, o.DefaultPricebookAccess, o.DefaultOpportunityAccess,
                              o.DefaultLocaleSidKey, o.DefaultLeadAccess, o.DefaultContactAccess, o.DefaultCaseAccess,
                              o.DefaultCampaignAccess, o.DefaultCalendarAccess, o.DefaultAccountAccess, o.CreatedDate,
                              o.CreatedById, o.Country, o.ComplianceBccEmail, o.City From Organization o];
        
        Map<String,String> theData = new Map<String,String>{
            'Id'  	=> myOrg.Id,
                'Name'	=> myOrg.Name
                };
                    
                    Id networkId = [SELECT Id, Name FROM Network WHERE Name = :COMMUNITY_NAME LIMIT 1].Id;
        
        String loginUrl = Network.getLoginUrl(networkId); 
        String communityBaseUrl;
        
        communityBaseUrl = loginUrl.substring(0,loginUrl.lastIndexOf('/'));
        
        System.debug('XXX:    '+communityBaseUrl); 
        
        theData.put('communityBaseUrl', communityBaseUrl);
        
        return JSON.serialize(theData);
    }
    
    private class UndefinedSObjectTypeException extends Exception {}
    
    private class DefaultSettings {
        
        private Map<String,Object> theSettings;
        
        public DefaultSettings(Map<String,Object> settings){
            this.theSettings = settings;   
        }
        
        public DefaultSettings(){}
        
        public Object getSetting(String key){
            return this.theSettings.get(key);
        }
        
    }
}