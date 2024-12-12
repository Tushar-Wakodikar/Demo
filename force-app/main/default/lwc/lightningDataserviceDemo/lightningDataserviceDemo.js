import { LightningElement, wire } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Contact.Name';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import ID_FIELD from '@salesforce/schema/Contact.Id';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import getContact from '@salesforce/apex/getContact.getContacts';

export default class LightningDataserviceDemo extends LightningElement {
    data = [];
    textName = '';
    ContactId;
    handlemode = '';


    handleName(event){
        this.textName = event.target.value;
    }

    columnsData = [
                    {label: 'ID', fieldName: 'Id', type: 'text'},
                    {label: 'Name', fieldName: 'Name', type: 'text'},
                    {label: 'Phone', fieldName: 'Phone', type: 'phone'},
                    {label: 'Email', fieldName: 'Email', type: 'email'},
                    {label: 'Actions', fieldName: 'Actions', type: 'button', typeAttributes:
                        {
                            label: 'Edit Contact',
                            value: 'editContact'
                        }
                    },
                    {label: 'Action 2', fieldName: 'Action2', type: 'button', typeAttributes:
                        {
                            label: 'View Contact',
                            value: 'viewContact'
                        }
                    }
                ];

    handleRowAction(event){
        if(event.detail.action.value === 'editContact'){
        this.ContactId = event.detail.row.Id;
        this.handlemode = 'edit';
        }
        if(event.detail.action.value === 'viewContact'){
            this.ContactId = event.detail.row.Id;
            this.handlemode = 'readonly';
            }
    }
    
    filed=[ID_FIELD,NAME_FIELD,PHONE_FIELD,EMAIL_FIELD];

    @wire(getContact, {name: '$textName'}) 
    result;
}