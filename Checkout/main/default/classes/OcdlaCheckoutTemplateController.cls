public class OcdlaCheckoutTemplateController extends CommunityTemplateController {
      
     
    private static Boolean scriptsDisabled = False;


      
    
    public OcdlaCheckoutTemplateController(){
        super('CheckoutCommunityConfig');
        

        HtmlStylesheet gFonts = new HtmlStylesheet('css?family=Raleway');
        gFonts.domain = 'fonts.googleapis.com';
        
        
        // HtmlScript jQuery = new HtmlScript('jquery-1.12.2.min.js');
        // jQuery.domain = 'code.jquery.com';
        
        // HtmlScript requireJs = new HtmlScript('sites/all/libraries/require.js',cdn);
        // requireJs.setData('main','sites/all/modules/cart/js/main');

        styles.add(gFonts);

       
        styles.add(new HtmlStylesheet('sites/force.com/assets/css/site-base.css',cdn));
        // styles.add(new HtmlStylesheet('sites/force.com/assets/css/drawer.css',cdn));
        styles.add(new HtmlStylesheet('sites/all/modules/forms/css/forms.css',cdn));

        if(false && !scriptsDisabled) {
            // scripts.add(jQuery);
            scripts.add(new HtmlScript('sites/all/libraries/jquery-cookie/jquery.cookie.js',cdn));
            scripts.add(new HtmlScript('sites/all/modules/cart/js/OCDLA.js',cdn));
            // scripts.add(requireJs);
            scripts.add(new HtmlScript('sites/force.com/assets/js/catalog.js',cdn));
            
            footerScripts.add(new HtmlScript('sites/force.com/assets/js/store.js',cdn));
            footerScripts.add(new HtmlScript('sites/all/modules/cart/js/init.js',cdn));
            footerScripts.add(new HtmlScript('sites/force.com/assets/js/product.js',cdn));
        }
    }

    
    
}