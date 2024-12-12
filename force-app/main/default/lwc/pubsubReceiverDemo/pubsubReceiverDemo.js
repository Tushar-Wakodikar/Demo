import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener, unregisterAllListeners } from 'c/pubsub';

export default class PubsubReceiverDemo extends LightningElement {
    receivedData;
    @wire(CurrentPageReference) pageRef;

    connectedCallback(){
        registerListener('publishedClick', this.handleData, this);
    }
    disconnectedCallback(){
        unregisterAllListeners(this);
    }

    handleData(event){
        this.receivedData = event.data;
    }
}