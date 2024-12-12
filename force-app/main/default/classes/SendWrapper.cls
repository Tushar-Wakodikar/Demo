public class SendWrapper {
    public void sendWrapperDetails(){
        WrapperOne wrp = new WrapperOne();
        wrp.firstName='Akshay';
        wrp.lastName='Wakodikar';
        wrp.phoneNumber ='9921616303';
        wrp.email='abc@ci.com';
        wrp.age=23;
        wrp.isActive=true;
        
        AddressWrapper address = new AddressWrapper();
        address.addressLine1 = 'Manish Nagar';
        address.addressLine2 = 'Besa Road';
        address.city = 'Nagpur';
        address.state = 'Maharastra';
        address.pincode = 440002;
        
        wrp.address = address;
        
        list<WrapperOne> wrpclass = new list<WrapperOne>();
        wrpclass.add(wrp);
        PrintWrapperDetails.printDetails(wrpclass);
    }
}