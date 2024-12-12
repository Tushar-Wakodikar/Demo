import { LightningElement, wire } from 'lwc';
import mychannel from '@salesforce/messageChannel/mychannel__c';
import { subscribe, unsubscribe, APPLICATION_SCOPE, MessageContext } from 'lightning/messageService';

export default class LmsReceiver extends LightningElement {
    receivedData;
    @wire(MessageContext)
    msgContext;

    subscription = null;
    connectedCallback(){
        if(!this.subscription){
            this.subscription = subscribe(
                this.msgContext,
                mychannel,
                (message) => this.handleData(message),
                {scope: APPLICATION_SCOPE }
            );
        }
    }

    handleData(data){
        this.receivedData = data.messageData;
    }

    disconnectedCallback(){
        unsubscribe(this.subscription);
        this.subscription = null;
    }
}