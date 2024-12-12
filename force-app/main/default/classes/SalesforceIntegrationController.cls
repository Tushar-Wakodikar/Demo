public class SalesforceIntegrationController {
    @future(callout=true)
    public static void getDetails(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Integration_with_Org/services/apexrest/Account/');
        req.setHeader('content-type','application/json; charset=UTF-8');
        req.setHeader('Accept', 'application/json');
        req.setMethod('GET');
        Http http = new Http();
        HttpResponse response = http.send(req);
        
        system.debug('Status :'+response.getStatusCode());
        system.debug('Get Body'+response.getBody());
    }
    
    @future(callout=true)
    public static void createAccountInTargetOrg(){
        HttpRequest req = new HttpRequest();
        req.setEndpoint('callout:Integration_with_Org/services/apexrest/Account/');
        req.setHeader('content-type','application/json; charset=UTF-8');
        req.setHeader('Accept', 'application/json');
        req.setBody('{"accname":"Akshay","phone":"987654321","industry":"Banking","rating":"Hot"}');
        req.setMethod('POST');
        Http http = new Http();
        HttpResponse response = http.send(req);
        
        system.debug('Status :'+response.getStatusCode());
        system.debug('Get Body'+response.getBody());
    }
}