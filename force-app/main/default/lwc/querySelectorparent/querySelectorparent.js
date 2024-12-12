import { LightningElement } from 'lwc';

export default class QuerySelectorparent extends LightningElement {

    renderedCallback(){
        let element = this.template.querySelector('c-query-selector-and-lwc-ref-child');
        //element.privateProperty = 'Dummy Component to Private Property';
        //element.publicProperty = 'Dumy Component to Public Property';
        element.childFuntion();
        console.log('Private Element :'+element.privateProperty);
        console.log('Public Element :'+element.publicProperty);
    }
    
}