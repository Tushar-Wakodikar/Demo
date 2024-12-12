import { LightningElement, wire } from "lwc";
import { getRecord, getFieldValue } from "lightning/uiRecordApi";

export default class UiRecordApiDemo2 extends LightningElement {
    firstName;
    email;
    phone;

    @wire(getRecord, { recordId: "001IT00002s0pw5YAA", layoutTypes: ["Full"], modes: ["View"] })
  wiredFunction({data,error}){
    if(data){
        console.log("Data: "+JSON.stringify(data));
        this.firstName = data.fields.Name.value;
        this.email = data.fields.Email_ID__c.value;
        this.phone = data.fields.Phone.value;
    }
    else if(error){
        console.log("Error: "+error);
    }
  };
}