import { LightningElement } from 'lwc';

export default class CustomEventDemoGrandParent extends LightningElement {
    handleClick(event){
        console.log('Data received in grand Parent: '+event.detail);
        event.stopPropagation();
    }
}