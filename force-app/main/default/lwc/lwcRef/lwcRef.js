import { LightningElement } from 'lwc';

export default class LwcRef extends LightningElement {

    renderedCallback(){
        let element = this.refs.childCom;
        console.log('private Property call from Child : '+element.privateProperty);
        console.log('private Property call from Child : '+element.publicProperty);
        element.childFuntion();
    }
}