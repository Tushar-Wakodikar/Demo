public class ClientController {
	@AuraEnabled
	Public static id createClient(string firstname, string middlename, string lastname, string phone, string email){
		Client__c client = new Client__c();
		client.First_Name__c = firstname;
		client.Last_Name__c = lastname;
		client.Middle_Number__c = middlename;
		client.Contact_Number__c = phone;
		client.Email_ID__c = email;
		insert client;
		return client.id;
	}
}