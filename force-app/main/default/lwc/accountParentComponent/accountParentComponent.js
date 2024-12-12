import { LightningElement } from 'lwc';

export default class AccountParentComponent extends LightningElement {
    searchTextParent = '';
    handleEvent(event){
        this.searchTextParent = event.detail;
    }
}