import { LightningElement, api } from 'lwc';

export default class Contact extends LightningElement {
    @api phone;
    @api email;

    handlePhone(event){
        this.phone = event.target.value;
        let phoneEvent = new CustomEvent('phonechange' , {detail : this.phone});
        this.dispatchEvent(phoneEvent);
    }

    handleEmail(event){
        this.email = event.target.value;
        let emailEvent = new CustomEvent('emailchange' ,{detail : this.email});
        this.dispatchEvent(emailEvent);
    }
}