import { LightningElement } from 'lwc';

export default class CustomEventDemoChild extends LightningElement {
    sendData(){
        let dummyEvent = new CustomEvent('dummyclick' , {detail : 'Button was Click', bubbles:true, composed:true});
        this.dispatchEvent(dummyEvent);
    }
}