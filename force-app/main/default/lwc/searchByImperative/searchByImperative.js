import { LightningElement } from 'lwc';
import getContactDetails from '@salesforce/apex/getContact.getContacts';

export default class SearchByImperative extends LightningElement {

    columnsData = [ 
        {label: "ID", fieldName: "Id", type: "text"},
        {label: "Name", fieldName: "Name", type: "text"},
        {label: "Phone", fieldName: "Phone", type: "phone"},
        {label: "Email", fieldName: "Email", type: "email"},
    ];

    searhText;

    contactResult = [];
    error;

    handleSearch(event){
        this.searhText = event.target.value;
    }

    handleClick(){
        getContactDetails({name: this.searhText})
        .then((data) => {
            this.contactResult = data;
        })
        .catch( (error) => {
            this.error = error;
        })
    }
}