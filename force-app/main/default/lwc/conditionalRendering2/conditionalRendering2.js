import { LightningElement } from 'lwc';

export default class ConditionalRendering2 extends LightningElement {
    visiblityFlag = true;
    showHideContent(){
        this.visiblityFlag = !this.visiblityFlag;
    }

    renderedCallback(){
        console.log('Rendered Callback Executed ... ');
    }
}