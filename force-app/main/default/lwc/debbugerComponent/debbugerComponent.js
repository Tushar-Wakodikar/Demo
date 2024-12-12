import { LightningElement } from 'lwc';

export default class DebbugerComponent extends LightningElement {
    a;

    connectedCallback(){
        console.log(this.a.b);
    }
}