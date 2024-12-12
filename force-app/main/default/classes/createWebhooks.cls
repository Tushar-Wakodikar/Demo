@RestResource(urlMapping='/api/invokeWehook/*')
global with sharing class createWebhooks {
    // Verify Token (ensure this matches the token you provide in Facebook setup)
    private static final String VERIFY_TOKEN = 'my_secure_verify_token';

    @HttpGet
    global static void verifyWebhook() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        String mode = req.params.get('hub.mode');
        String token = req.params.get('hub.verify_token');
        String challenge = req.params.get('hub.challenge');

        if (mode == 'subscribe' && token == VERIFY_TOKEN) {
            res.responseBody = Blob.valueOf(challenge); // Respond with hub.challenge
            res.statusCode = 200;
        } else {
            res.statusCode = 403; // Forbidden
        }
    }

    @HttpPost
    global static void handleWebhook() {
        RestRequest req = RestContext.request;
        RestResponse res = RestContext.response;

        try {
            // Parse incoming JSON payload
            String requestBody = req.requestBody.toString();
            Map<String, Object> payload = (Map<String, Object>) JSON.deserializeUntyped(requestBody);

            // Log the received data (optional for debugging)
            System.debug('Received webhook payload: ' + payload);

            // Example: Process leadgen data
            if (payload.containsKey('entry')) {
                List<Object> entries = (List<Object>) payload.get('entry');
                for (Object entry : entries) {
                    Map<String, Object> entryMap = (Map<String, Object>) entry;
                    if (entryMap.containsKey('changes')) {
                        List<Object> changes = (List<Object>) entryMap.get('changes');
                        for (Object change : changes) {
                            Map<String, Object> changeMap = (Map<String, Object>) change;

                            if (changeMap.get('field') == 'leadgen') {
                                Map<String, Object> leadgenData = (Map<String, Object>) changeMap.get('value');
                                String leadId = (String) leadgenData.get('leadgen_id');
                                String adId = (String) leadgenData.get('ad_id');
                                System.debug('Lead ID: ' + leadId);
                                System.debug('Ad ID: ' + adId);

                                // Optionally, process lead data here (e.g., call Facebook Graph API for details)
                                createLeadInSalesforce(leadgenData);
                            }
                        }
                    }
                }
            }
            res.statusCode = 200; // Acknowledge receipt
        } catch (Exception e) {
            System.debug('Error handling webhook: ' + e.getMessage());
            res.statusCode = 500; // Internal server error
        }
    }

    // Example: Method to create a Lead record in Salesforce
    private static void createLeadInSalesforce(Map<String, Object> leadData) {
        Lead newLead = new Lead();
        newLead.FirstName = (String) leadData.get('first_name');
        newLead.LastName = (String) leadData.get('last_name');
        newLead.Email = (String) leadData.get('email');
        newLead.Company = 'Facebook Lead'; // Default company if not provided
        insert newLead;
    }
}