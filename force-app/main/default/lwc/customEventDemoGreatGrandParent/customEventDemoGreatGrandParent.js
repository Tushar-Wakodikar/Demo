import { LightningElement } from 'lwc';

export default class CustomEventDemoGreatGrandParent extends LightningElement {
    handleClick(event){
        console.log('Data received in great grand Parent: '+event.detail);
    }
}