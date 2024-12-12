import { LightningElement } from 'lwc';

export default class CaptureEventDemoGreatGrandParent extends LightningElement {
    connectedCallback(){
        this.template.addEventListener('dummyclick', this.handleDummyClickEvent.bind(this), true);

    }

    handleDummyClickEvent(event){
        console.log('Received Event in great grand Parent: '+event.detail);
    }
}