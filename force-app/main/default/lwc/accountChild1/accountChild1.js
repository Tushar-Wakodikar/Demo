import { LightningElement } from 'lwc';

export default class AccountChild1 extends LightningElement {
    searchText = '';

    handleSearch(event){
        this.searchText = event.target.value;
    }

    handleClick(){
        this.dispatchEvent(new CustomEvent('fireevent', {detail : this.searchText}));
    }
}