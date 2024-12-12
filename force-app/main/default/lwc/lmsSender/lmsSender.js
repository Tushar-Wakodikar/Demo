import { LightningElement, wire } from 'lwc';
import mychannel from '@salesforce/messageChannel/mychannel__c';
import { publish, MessageContext } from 'lightning/messageService';

export default class LmsSender extends LightningElement {
    @wire(MessageContext)
    msgContext;

    broadcastData(){
        let data = {messageData : 'Data From LMS Sender'};
        publish(this.msgContext, mychannel, data);
    }
}