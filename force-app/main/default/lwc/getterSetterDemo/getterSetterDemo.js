import { LightningElement } from 'lwc';

export default class GetterSetterDemo extends LightningElement {
    firstname ='';
    middlename ='';
    lastname ='';
    countryValue = '';
    phone = '';
    classChange = "slds-box slds-m-top_medium";

    handleColorChange(event){
        this.colors=event.target.value;
        console.log(this.colors);
    }

    set colors(value){
        if(value === 'red'){
            this.classChange = "slds-box slds-m-top_medium" + " slds-text-color_destructive";
        }
        else if (value === 'green'){
            this.classChange = "slds-box slds-m-top_medium" + " slds-text-color_success";
        }
        else if (value === 'black'){
            this.classChange = "slds-box slds-m-top_medium";
        }
        this.shadowColors = value;
    }
    shadowColors;

    get colors(){
        return this.shadowColors;
    }


    countryOptions = [
        {label: 'India', value:'IN'},
        {label: 'Australia', value:'AU'},
        {label: 'United States', value:'US'}
    ];

    get countryCode(){
        let returnValue;
        if(this.countryValue === 'IN'){
            returnValue = '+91 '+this.phone;
        }else if(this.countryValue === 'AU'){
            returnValue = '+61 ' +this.phone;
        }else if(this.countryValue === 'US'){
            returnValue = '+1 ' +this.phone;
        }
        return returnValue;
    }

    handlePhone(event){
        this.phone = event.target.value;
    }

    handleCountry(event){
        this.countryValue = event.target.value;
    }

    handleFirstName(event){
        this.firstname = event.target.value;
    }
    handleMiddleName(event){
        this.middlename = event.target.value;
    }
    handleLastName(event){
        this.lastname = event.target.value;
    }

    get fullname(){
        return this.firstname + ' ' + this.middlename + ' ' + this.lastname;
    }
}