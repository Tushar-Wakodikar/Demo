import { LightningElement } from 'lwc';

export default class ConditionalRendering3 extends LightningElement {
    visiblity = "slds-hide";
    content = "Hide";
    showHideContent(){
        this.visiblity = (this.visiblity === "slds-hide") ? "" : "slds-hide";
        this.content = (this.content === "Hide") ? "Show" : "Hide";
    }
}