public class PrintWrapperDetails {
    public static void printDetails(list<WrapperOne> wrplist){
        for(WrapperOne wrp:wrplist){
            system.debug('First Name- '+wrp.firstName);
            system.debug('Last Name- '+wrp.lastName);
            system.debug('Email- '+wrp.email);
            system.debug('Phone Number- +91 '+wrp.phoneNumber);
            system.debug('isActive Status- '+wrp.isActive);
            system.debug('Age- '+wrp.age);
        }
            string serialzeWapper = JSON.serialize(wrplist);
            system.debug('JSON.serialize- '+serialzeWapper);
    }
}