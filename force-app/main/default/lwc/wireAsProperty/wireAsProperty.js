import { LightningElement, wire} from 'lwc';
import getContactRef from '@salesforce/apex/getContact.getContacts';
export default class WireAsProperty extends LightningElement {
    columnData = [
                {label: 'ID', fieldName: 'Id', type: 'id'},
                {label: 'First Name', fieldName: 'FirstName', type: 'text'},
                {label: 'Last Name', fieldName: 'LastName', type: 'text'},
                {label: 'Phone', fieldName: 'Phone', type: 'phone'},
                {label: 'Email', fieldName: 'Email', type: 'email'}];
    searchStr = '';

    handleSearchResult(event){
        this.searchStr = event.target.value;
    }

    @wire(getContactRef, {name : '$searchStr'})
    contactData; // {data, error}
}