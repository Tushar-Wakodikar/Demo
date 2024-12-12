import { LightningElement, wire } from 'lwc';
import mychannel from '@salesforce/messageChannel/getcontact__c';
import { subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';
import getContact from '@salesforce/apex/accountRecordRetrive.getContact';
import { NavigationMixin } from 'lightning/navigation';
import LightningConfirm from 'lightning/confirm';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from "lightning/platformShowToastEvent";

export default class NevigateContactComponent extends NavigationMixin(LightningElement) {
    subscription = null;
    accountId = '';
    contactId = '';
    accountName = '';
    title = 'Get Contacts';
    createContact = false;
    editContact = false;
    contacts = [];
    hasContact = false;

    @wire(MessageContext)
    msgContext;

    async callContact(){
        this.contacts = await getContact({accountId: this.accountId});
        this.hasContact = (this.contacts.length>0)? true : false;
    }

    connectedCallback(){
        console.log('Connected Callback Executed');
        if(!this.subscription) {
            this.subscription = subscribe(
                this.msgContext,
                mychannel,
                (message) => this.handleMessage(message),
                {scope: APPLICATION_SCOPE}
            );
        }
    }

    handleMessage(data){
        this.accountId = data.recordId;
        this.accountName  = data.reccordName;
        this.title = this.accountName+"'s Contacts";
        this.callContact();
    }

    disconnectedCallback(){
        console.log('Dissconnected Callback Executed');
        unsubscribe(this.subscription);
        this.subscription = null;
    }

    handleContact(){
        this.createContact = true;
    }

    cancleAddContact(){
        this.createContact = false;
    }

    handleContactSuccess(){
        this.createContact = false;
        this.showNotification('Contact Saved','Contact Saved Successfully', 'success');
        this.callContact();
    }

    showNotification(titelText, messageText, variant) {
        const evt = new ShowToastEvent({
          title: titelText,
          message: messageText,
          variant: variant,
        });
        this.dispatchEvent(evt);
      }

    async handleDeleteContact(event){
        this.contactId = event.target.dataset.contactId;
        const result = await LightningConfirm.open({
            message: 'Are you sure you want to delete this Cotact?',
            variant: 'headerless',
            label: 'this is the aria-label value',
            // setting theme would have no effect
        });
        if(result){
            this.callContact();
            let deleteResult = await deleteRecord(this.contactId);
            this.showNotification('Contact Deleted','Contact Deleted Successfully', 'info');
        }
    }

    cancleEditContact(){
        this.editContact = false;
    }

    handleContactEditSuccess(){
        this.editContact = false;
        this.callContact();
        this.showNotification('Contact Updated','Contact Updated Successfully', 'success');
    }

    handleOpp(){
        this[NavigationMixin.Navigate]({
            type: 'standard__recordRelationshipPage',
            attributes: {
                recordId: this.accountId,
                objectApiName: 'Account',
                relationshipApiName: 'Opportunities',
                actionName: 'view'
            },
        });
    }

    handleEditContact(event){
        this.editContact = true;
        this.contactId = event.target.dataset.contactId;
    }

}