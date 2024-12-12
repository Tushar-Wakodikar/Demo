import { LightningElement, api } from 'lwc';

export default class Address extends LightningElement {
    @api line1;
    @api city;
    @api state;
    @api pinCode;
    @api country;

    handleAddress(event){
        if(this.line1 !== event.target.street){
            this.line1 = event.target.street;
            this.sendData('streetchange' , this.line1);
        }

        if(this.city !== event.target.city){
            this.city = event.target.city;
            this.sendData('citychange' , this.city);
        }
        
        if(this.state !== event.target.province){
            this.state = event.target.province;
            this.sendData('statechange' , this.state);
        }
        
        if(this.pinCode !== event.target.postalCode){
            this.pinCode = event.target.postalCode;
            this.sendData('pincodechange' , this.pinCode);
        }
        
        if(this.country !== event.target.country){
            this.country = event.target.country;
            this.sendData('countrychange' , this.country);
        }
    }

    sendData(eventName, data){
        let addressEvent = new CustomEvent(eventName, {detail : data});
        this.dispatchEvent(addressEvent);
    }
}