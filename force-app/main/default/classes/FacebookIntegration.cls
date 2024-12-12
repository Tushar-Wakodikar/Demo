public class FacebookIntegration {
    private static final String ENDPOINT = 'https://graph.facebook.com/v21.0/me';
    private static final String token = 'EAAygjZAnKWIEBO5jGrmxZBgyCYdtAs5s5ez4zP4qIcB5rBU3ZAStgDZAx6FdQGZAtyZCl6RwoBon7DVFFIu28V7CRIv6CepPqNSGxTZAPEtQ53oiTaFLMv4QMXI7JLiDMDZAFTfm0FeYSo26N9iXLGPtsZAuwAcSaTqYhulTGaE15TzTc95KLBWKmeTcDtYcY830CqQ5CmGRUZAHjBten9XVScMos2glXsYVXQtwyOjKb9q7v1N6McYGic';
    
    public static void sendRequest(){
        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(ENDPOINT);
        req.setMethod('GET');
        req.setHeader('Authorization', 'Bearer ' + token);
        HttpResponse res = http.send(req);
        system.debug(res.getStatusCode());
        system.debug(res.getBody());
    }
    
    
}