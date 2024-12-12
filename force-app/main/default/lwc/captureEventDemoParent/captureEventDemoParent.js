import { LightningElement } from 'lwc';

export default class CaptureEventDemoParent extends LightningElement {
    connectedCallback(){
        this.template.addEventListener('dummyclick', this.handleDummyClickEvent.bind(this), true);
    }

    handleDummyClickEvent(event){
        console.log('Received Event in Parent: '+event.detail);
    }
}