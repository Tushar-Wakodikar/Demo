public class GetUserCredentialDetails {
    
    public class inputWrapper{
        @invocableVariable public string username;
        @invocableVariable public string password;
    }
    public class outputWrapper{
        @invocableVariable public List<UserDetail__c> userDetails;
    }
    
	@InvocableMethod(label='Get UserDetails By Passing Username,Password')
    public static List<outputWrapper> getUserDetails(List<inputWrapper> input){
        List<outputWrapper> outputWapperList = new List<outputWrapper>();
        outputWrapper wrapper = new outputWrapper();
        wrapper.userDetails = [SELECT id FROM UserDetail__c WHERE Username__c =:input[0].username AND Password__c =:input[0].password];
        outputWapperList.add(wrapper);
        return outputWapperList;
    }

}