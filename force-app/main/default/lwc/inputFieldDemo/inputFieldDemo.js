import { LightningElement } from 'lwc';

export default class InputFieldDemo extends LightningElement {
    firstname;
    lastname;
    line1 = "Manish Nagar";
    line2 = "Nagpur";
    isVisible = false;
    updateline1;
    updateline2;

    handleFirstName(event){
        this.firstname = event.target.value;
    }
    handleLastName(event){
        this.lastname = event.target.value;
    }

    handleAddress(event){
        if(event.target.label === 'Line 1'){
            this.line1 = event.target.value;
        }
        else{
            this.line2 = event.target.value;
        }
    }

    handleClick(){
        if(this.isVisible===true){
            this.isVisible=false;
        }
        else{
            this.isVisible=true;
        }
    }

    updateAddress(){
        this.updateline1 = this.line1;
        this.updateline2 = this.line2;
    }
}