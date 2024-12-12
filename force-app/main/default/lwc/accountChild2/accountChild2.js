import { LightningElement, api, wire } from 'lwc';
import getAccount from '@salesforce/apex/accountRecordRetrive.getAccount';
import mychannel from '@salesforce/messageChannel/getcontact__c';
import { publish, MessageContext } from 'lightning/messageService';

export default class AccountChild2 extends LightningElement {
    @api searchText2;
    accountId = '';
    accountName = '';
    accounts = [];
    error;

    columns = [
        {label: 'ID', fieldName: 'Id'},
        {label: 'Name', fieldName: 'Name'},
        {label: 'Action', fieldName: 'Action', type: "button", typeAttributes:
            {label: 'View Contact', value: 'viewcontact', variant: 'brand'}
        }
    ];

    handleRowAction(event){
        this.accountId = event.detail.row.Id;
        this.accountName = event.detail.row.Name;
        console.log('Account Id'+this.accountId);
        publish(this.msgContext, mychannel, {recordId :this.accountId, reccordName:this.accountName});
    }


    @wire(getAccount, {accountName:'$searchText2'})
    wireAccount({data,error}){
        if(data){
            this.accounts = data;
            console.log(JSON.stringify(data));
        }
        else if(error){
            console.log('Error occured'+JSON.stringify(error));            
        }
    }

    @wire(MessageContext)
    msgContext;
}