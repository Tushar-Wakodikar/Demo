import { LightningElement, wire } from 'lwc';
import { getRecords } from 'lightning/uiRecordApi';
import account_name from "@salesforce/schema/Account.Name";
import account_type from "@salesforce/schema/Account.Type";
import account_active from "@salesforce/schema/Account.Active__c";
import contact_name from "@salesforce/schema/Contact.Name";

export default class UiRecordApi extends LightningElement {
    AcountName;
    ContactName;
    @wire(getRecords, {
        records: [
          {
            recordIds: ["001IT00002p8ctAYAQ"],
            fields: [account_name, account_type, account_active]
          },
          {
            recordIds: ["003IT00002kpgXLYAY"],
            fields: [contact_name]
          },
        ],
      })
      wiredFunction({data,error}){
        if(data){
            console.log("Data: "+JSON.stringify(data));
            this.AcountName = data.results[0].result.fields.Name.value;
            this.ContactName = data.results[1].result.fields.Name.value;
        }
        else if(error){
            console.log("Error: "+error);
        }
    };
}