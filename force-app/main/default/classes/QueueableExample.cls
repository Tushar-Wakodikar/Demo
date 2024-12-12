public class QueueableExample implements Queueable{
    public static void execute(QueueableContext qc){
        profile p = [SELECT id FROM Profile WHERE Name='Standard User'];
        UserRole r = [SELECT id FROM UserRole WHERE Name='COO'];
        User usr = new User(alias='apexs', email='akshayWakodikar1997@gmail.com', emailencodingkey='UTF-8', 
                            lastName = 'lName', languagelocalekey='en_US', localesidkey='en_US', profileId =p.id, 
                            userroleid= r.id, timezonesidkey='America/Los_Angeles', 
                            userName='AkshayWakodikar@apexhours.com');
        insert usr;
    }
}