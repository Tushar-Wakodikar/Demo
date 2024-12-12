public class JSONDeserialization {
    private static string serialized = '{"phoneNumber":"9921616303","lastName":"Wakodikar","isActive":true,"firstName":"Akshay","email":"abc@ci.com","age":23}';
    public static void processDeserialization(){
        map<string,object> wrap = (map<string,object>) JSON.deserializeUntyped(serialized);
        string firstName = (string) wrap.get('firstName');
        system.debug('Deserialised Wrap: '+wrap.get('firstName'));
    }
    public static void processDeserializationTyped(){
        WrapperOne wrap = (WrapperOne) JSON.deserialize(serialized, WrapperOne.class);
        string firstName = wrap.firstName;
        system.debug(wrap);
    }
}