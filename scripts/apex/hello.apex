// Use .apex files to store anonymous Apex.
// You can execute anonymous Apex in VS Code by selecting the
//     apex text and running the command:
//     SFDX: Execute Anonymous Apex with Currently Selected Text
// You can also execute the entire file by running the command:
//     SFDX: Execute Anonymous Apex with Editor Contents
// https://developer.salesforce.com/docs/atlas.en-us.apexcode.meta/apexcode/apex_platform_cache_org_examples.htm  


String instanceUrl = URL.getOrgDomainURL();

System.debug(instanceUrl);


String accessToken = (String)Cache.Org.get('local.Default.accessToken');

        CreateCustomerRequest req = new CreateCustomerRequest();
        
        // HttpClient client = new QuickBooksSandboxClient();
        /*req.setHeader('Authorization','bearer '+accessToken);
        req.setHeader('Accept','application/json');
        req.setMethod('POST');
        */
        // req = cust.getAsHttpRequest();
        // HttpResponseMessage resp = client.send(req);
        // System.debug(resp.getBody());  

        String newAccessToken = OAuthController.getNewAccessToken();

        System.debug(newAccessToken);