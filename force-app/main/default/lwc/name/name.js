import { LightningElement, api } from 'lwc';

export default class Name extends LightningElement {
    @api firstname;
    @api middlename;
    @api lastname;

    handleFirstName(event){
        this.firstname = event.target.value;
        //const selectedEvent = new CustomEvent("selected", { detail: this.contact.Id });
        let nameEvent = new CustomEvent('firstnamechange' , {detail : this.firstname});
        this.dispatchEvent(nameEvent);
    }

    handleMiddleName(event){
        this.middlename = event.target.value;
        let nameEvent = CustomEvent('middlenamechange' , {detail : this.middlename});
        this.dispatchEvent(nameEvent);
    }

    handleLastName(event){
        this.lastname = event.target.value;
        let nameEvent = CustomEvent('lastnamechange' , {detail : this.lastname});
        this.dispatchEvent(nameEvent);
    }
}