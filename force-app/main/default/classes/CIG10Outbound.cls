public class CIG10Outbound {
	private static String consumerKey = '3MVG9pRzvMkjMb6k5xa6qskx.8JBxlwprpivgQVgi85iLh9zQ4kUrP.EHoNbVQrfQsu.2qatt3wuKDA69Sy62';
    private static String consumerSecret = '3EBE769F10D0255AECEF8C684D91630994FF87A612326EC5FC42947D86E1357D';
    private static String username = 'rattamaarloengineers@gmail.com';
    private static String password = 'pass@123gaIBFUpCYiOGkaqomaaxStF9y';
    
    public static void getAccessToken(){
        String requestBody = 'grant_type=password&client_id='+consumerKey+'&client_secret='+consumerSecret+'&username='+username+'&password='+password;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token');
        request.setMethod('POST');
        request.setBody(requestBody);
        
        HttpResponse response = http.send(request);
        system.debug('Response: '+response);
        system.debug('Response Body: '+response.getBody());
        String responseString = response.getBody();
    }
}