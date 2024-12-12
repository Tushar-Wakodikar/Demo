import { LightningElement, wire, track} from 'lwc';
import getContact from '@salesforce/apex/FetchContactLWC.getContact';
import mergeContactsApex from '@salesforce/apex/FetchContactLWC.mergeContacts';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class MegerContact extends NavigationMixin(LightningElement) {
    conName = '';
    conEmail = '';
    isShowModal = false;
    contactData = [];
    error;
    mergeButton = true;
    selectedRow = [];
    primaryContact = {};
    secondaryContact = {};
    @track priFirstName;
    @track priLastName;
    @track priPhone;
    @track priEmail;
    @track secFirstName;
    @track secLastName;
    @track secPhone;
    @track secEmail;

    columnData = [
        {label: 'First Name', fieldName: 'FirstName', type: 'text'},
        {label: 'Last Name', fieldName: 'LastName', type: 'text'},
        {label: 'Email', fieldName: 'Email', type: 'email'},        
        {label: 'Phone', fieldName: 'Phone', type: 'phone'},
        {label: 'Account Name', fieldName: 'AccountName', type: 'text'},
        {label: 'Created Date', fieldName: 'CreatedDate', type: 'date'}
    ];

    handleContact(event){
        if(event.target.label === "Contact Name"){
            this.conName = event.target.value;
        }
        else{
            this.conEmail = event.target.value;
        }
    }

    handleRowSelection(event){
        this.selectedRow = event.detail.selectedRows;
        if(this.selectedRow.length === 2 && this.selectedRow[0].AccountId === this.selectedRow[1].AccountId && this.selectedRow[0].Email === this.selectedRow[1].Email){
            this.primaryContact = this.selectedRow[0];
            this.secondaryContact = this.selectedRow[1];
            this.mergeButton = false;
        }
        else if((this.selectedRow.length === 2 && this.selectedRow[0].AccountId !== this.selectedRow[1].AccountId && this.selectedRow[0].Email !== this.selectedRow[1].Email)){
            this.mergeButton = true;
            this.showToast('Error Occurred!', 'Your Selected Rows Contacts must have same AccountId and EmailId to enable Merge button', 'error');
        }
        else{
            this.mergeButton = true;
        }
    }

    showToast(title, message, variant){
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(event);
    }

    @wire(getContact,{name:'$conName', mailId:'$conEmail'})
    wiredContact({data,error}){
        if(data){
            this.contactData = data.map(contact => {
                return {
                    ...contact,
                    AccountName: contact.Account ? contact.Account.Name : ''
                };
            });
        } 
        else if(error){
            this.error = error;
            console.log("The Error in Data is "+this.error);
        }
    }

    showModalBox() {
        this.priFirstName = this.primaryContact.FirstName;
        this.priLastName = this.primaryContact.LastName;
        this.priPhone = this.primaryContact.Phone;
        this.priEmail = this.primaryContact.Email;
        this.secFirstName = this.secondaryContact.FirstName;
        this.secLastName = this.secondaryContact.LastName;
        this.secPhone = this.secondaryContact.Phone;
        this.secEmail = this.secondaryContact.Email;
        this.isShowModal = true;
    }

    handleFieldChange(event){
        if(event.target.label === "First Name"){
            this.priFirstName = event.target.value;
        }
        else if(event.target.label === "Last Name"){
            this.priLastName = event.target.value;
        }
        else if(event.target.label === "Email"){
            this.priEmail = event.target.value;
        }
        else if(event.target.label === "Phone"){
            this.priPhone = event.target.value;
        }
    }

    handleNav(event){
        if(event.target.name === "firstNameLeft"){
            this.priFirstName = this.secFirstName;
        }
        else if(event.target.name === "lastNameLeft"){
            this.priLastName = this.secLastName;
        }
        else if(event.target.name === "emailLeft"){
            this.priEmail = this.secEmail;
        }
        else if(event.target.name === "phoneLeft"){
            this.priPhone = this.secPhone;
        }
    }

    mergeContacts(){
        const updatedPrimaryContact = {
            FirstName: this.priFirstName,
            LastName: this.priLastName,
            Email: this.priEmail,
            Phone: this.priPhone
        };

        mergeContactsApex({priConId: this.primaryContact.Id, secConId: this.secondaryContact.Id, priContact: updatedPrimaryContact})
        .then((data) => {
            this.showToast('Merge Successfully!', 'Your Selected Rows Contacts merged Successfully', 'success');
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: this.primaryContact.Id,
                    objectApiName: 'Contact',
                    actionName: 'view'
                },
            });
        })
        .catch((error) => {
            this.showToast('Error Occurred!', 'Error merging contacts: ' + error.body.message, 'error');
        });
    }

    hideModalBox() {  
        this.isShowModal = false;
    }
}