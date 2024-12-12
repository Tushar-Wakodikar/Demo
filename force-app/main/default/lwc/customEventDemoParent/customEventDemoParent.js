import { LightningElement } from 'lwc';

export default class CustomEventDemoParent extends LightningElement {
    handleDummyClick(event){
        console.log('Data received: '+event.detail);
    }
}