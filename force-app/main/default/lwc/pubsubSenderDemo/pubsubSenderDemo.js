import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsub';

export default class PubsubSenderDemo extends LightningElement {
    @wire(CurrentPageReference) pageRef;
    broadcastData(){
        fireEvent(this.pageRef, 'publishedClick', {data : "Data sent from publisher"});
    }
}