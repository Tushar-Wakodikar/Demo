import { LightningElement } from 'lwc';
import getContacts from '@salesforce/apex/FetchContactLWC.getContacts';

export default class FetchContactWithArray extends LightningElement {
    fname ='';
    lname ='';
    contacts;
    error;

    handleFnameChange(event){
        this.fname = event.target.value;
    }

    handleLnameChange(event){
        this.lname = event.target.value;
    }

    handleSubmit(){

        const name = [this.fname, this.lname];
        
        getContacts({name:name})
        .then(result => {
            this.contacts = result;
            console.log(JSON.stringify(this.contacts));
        })
        .catch(error => {
            this.error = error;
            console.log(error);
        });
    }
}