@RestResource(urlMapping='/IndiaMartWebhook')
global with sharing class IndiaMartWebhookHandler {

    @HttpPost
    global static void handleWebhook() {
        try {
            // Capture the incoming request body
            String requestBody = RestContext.request.requestBody.toString();

            // Parse the JSON payload into a map
            Map<String, Object> payload = (Map<String, Object>) JSON.deserializeUntyped(requestBody);

            // Access the "body" object and cast it properly
            Map<String, Object> body = (Map<String, Object>) payload.get('body');
            Map<String, Object> response = (Map<String, Object>) body.get('RESPONSE');

            // Log the payload for debugging
            System.debug('Received Response: ' + response);

            // Extract fields from the payload
            String senderName = (String) response.get('SENDER_NAME');
            String[] nameParts = senderName != null ? senderName.split(' ', 2) : new String[0];

            // Create a new Lead record
            Lead lead = new Lead();

            // Map IndiaMart fields to Salesforce Lead fields
            lead.FirstName = nameParts.size() > 1 ? nameParts[0] : null; // First name from sender name
            lead.LastName = nameParts.size() > 1 ? nameParts[1] : (nameParts.size() == 1 ? nameParts[0] : 'Unknown'); // Default to "Unknown"
            lead.Company = (String) response.get('SENDER_COMPANY');
            lead.Email = (String) response.get('SENDER_EMAIL');
            lead.Phone = (String) response.get('SENDER_MOBILE');
            lead.Description = (String) response.get('QUERY_MESSAGE');
            lead.City = (String) response.get('SENDER_CITY');
            lead.State = (String) response.get('SENDER_STATE');
            lead.PostalCode = (String) response.get('SENDER_PINCODE');
            lead.Country = (String) response.get('SENDER_COUNTRY_ISO');

            // Validate required fields
            if (String.isBlank(lead.LastName)) {
                throw new MissingFieldException('LastName is required');
            }
            if (String.isBlank(lead.Company)) {
                throw new MissingFieldException('Company is required');
            }

            // Insert the Lead record
            insert lead;

            // Return a success response
            RestContext.response.statusCode = 200;
            RestContext.response.responseBody = Blob.valueOf('{"status":"success", "message":"Lead created successfully"}');
        } catch (Exception e) {
            // Log the error
            System.debug('Error: ' + e.getMessage());

            // Return an error response
            RestContext.response.statusCode = 500;
            RestContext.response.responseBody = Blob.valueOf('{"status":"error", "message":"' + e.getMessage() + '"}');
        }
    }

    // Custom exception for missing fields
    public class MissingFieldException extends Exception {}
}