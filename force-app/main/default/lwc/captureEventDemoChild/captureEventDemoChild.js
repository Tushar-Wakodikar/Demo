import { LightningElement } from 'lwc';

export default class CaptureEventDemoChild extends LightningElement {
    handleDummyEvent(){
        let dummyEvent = new CustomEvent('dummyclick',{detail: 'Button was clicked', bubbles:true, composed:true});
        this.dispatchEvent(dummyEvent);
    }
}