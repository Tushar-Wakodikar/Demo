import { LightningElement } from 'lwc';

export default class CaptureEventDemoGrandParent extends LightningElement {
    connectedCallback(){
        this.template.addEventListener('dummyclick', this.handleDummyClickEvent.bind(this), true);
    }

    handleDummyClickEvent(event){
        console.log('Received Event in grand Parent: '+event.detail);
        event.stopPropagation();
    }
}