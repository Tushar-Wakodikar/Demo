import { LightningElement } from 'lwc';
import createClientRef from '@salesforce/apex/ClientController.createClient';
import { ShowToastEvent} from 'lightning/platformShowToastEvent';
import { NavigationMixin} from 'lightning/navigation';

export default class ParentDetailForm extends NavigationMixin(LightningElement){
    firstname = "Akshay";
    middlename = "Bhuwan";
    lastname = "Wakodikar";

    phone = "8237335821";
    email = "akshaywakodikar1997@gmail.com";

    line1 = "Plot No. 42, Shriram Society, Prem Nagar";
    city = "Nagpur";
    country = "India";
    state = "Maharastra";
    pincode = "440002";

    handleFirstName(event){
        this.firstname = event.detail;
        console.log('First Name : '+this.firstname);
    }

    handleMiddleName(event){
        this.middlename = event.detail;
        console.log('Middle Name : '+this.middlename);
    }

    handleLastName(event){
        this.lastname = event.detail;
        console.log('Last Name : '+this.lastname);
    }

    handlePhone(event){
        this.phone = event.detail;
        console.log('Phone :'+this.phone);
    }

    handleEmail(event){
        this.email = event.detail;
        console.log('Email :'+this.email);
    }

    handleStreet(event){
        this.line1 = event.detail;
        console.log('Line1 : '+this.line1);
    }

    handleCity(event){
        this.city = event.detail;
        console.log('City: '+this.city);
    }

    handleState(event){
        this.state = event.detail;
        console.log('State: '+this.state);
    }

    handlePincode(event){
        this.pincode = event.detail;
        console.log('Pincode: '+this.pincode);
    }

    handleCountry(event){
        this.country = event.detail;
        console.log('Country: '+this.country);
    }

    createClientRec(){
        createClientRef({firstname : this.firstname, middlename : this.middlename, lastname : this.lastname, phone : this.phone, email : this.email})
        .then((data)=>{
            console.log('Client Record Created');
            this[NavigationMixin.Navigate] ({
                type: 'standard__recordPage',
                attributes:{
                    recordId: data,
                    actionName: 'view'
                }
            });
            let clietCreate = new ShowToastEvent ({
                title: 'Client Created!',
                message: 'Client Record Created Successfully',
                variant: 'success'
            });
            this.dispatchEvent(clietCreate);
            
            })
        .catch((error)=>{
            console.log('Client Record Creation Failed : '+error);
            let clietError = new ShowToastEvent ({
                title: 'Error!',
                message: 'Client Record does not Created',
                variant: 'error'
            });
            this.dispatchEvent(clietError);
        });
    }
}