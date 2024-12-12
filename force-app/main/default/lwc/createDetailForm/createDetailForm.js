import { LightningElement} from 'lwc';
import createClient from '@salesforce/apex/CreateClientRecord.createClient';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class CreateDetailForm extends NavigationMixin(LightningElement) {
    firstname ='';
    lastname ='';
    middlename ='';
    phone ='';
    email ='';
    gender ='';
    clientid = '';
    view = false;

    options = [
        { label: 'Male', value: 'Male' },
        { label: 'Female', value: 'Female' },
        { label: 'Other', value: 'Other' }
    ];

    handleFirstName(event){
        this.firstname = event.target.value;
    }
    handleMiddleName(event){
        this.middlename = event.target.value;
    }
    handleLastName(event){
        this.lastname = event.target.value;
    }
    handlePhone(event){
        this.phone = event.target.value;
    }
    handleEmail(event){
        this.email = event.target.value;
    }
    handleGender(event){
        this.gender = event.target.value;
    }
    handleRest(){
        const restFeilds = this.template.querySelector('form');
        restFeilds.reset();
        /*restFeilds.forEach(field =>{
            field.value = '';
            //field.reset();
        });*/
    }
    handleCreate(){
        createClient({firstname: this.firstname, middlename: this.middlename, lastname: this.lastname, phone: this.phone, email: this.email, gender: this.gender})
        .then((result) => {
            alert(result);
            this.clientid = result;
            const event = new ShowToastEvent({
                title: 'Client Created',
                message: 'Client record Created with id: ' + result,
                variant: 'success',
            });
            this.dispatchEvent(event);
        })
        .catch (error => {
            alert(error);
            const event = new ShowToastEvent({
                title: 'Client Created',
                message: 'Client Record does not Created',
                variant: 'error',
            });
            this.dispatchEvent(event);
        });
    }
    handleView(){
        this.view = !this.view;
    }
    handleClient(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                objectApiName: 'Client__c',
                recordId: this.clientid,
                actionName: 'view'
            },
        });
    }
}