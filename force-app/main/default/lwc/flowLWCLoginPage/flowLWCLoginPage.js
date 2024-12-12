import { LightningElement, api, track } from 'lwc';
import { FlowNavigationNextEvent } from 'lightning/flowSupport';

export default class FlowLWCLoginPage extends LightningElement {
    @api username;
    @api password;
    @api availableActions = [];
    @api userNotExists = false;
    @track isShowModal = false;
    @api regUsername;
    @api regPassword;
    @api regConfirmPassword;
    @api redirectTo;

    renderedCallback(){
        if(this.userNotExists){
            this.userNotExists = false;
            let passwordInput = this.template.querySelector('.password');
            passwordInput.setCustomValidity("USERNAME DOES NOT EXISTS");
            passwordInput.reportValidity();
        }
    }

    handleInput(event){
        if(event.target.label === "Username"){
            this.username = event.target.value;
            let passwordInput = this.template.querySelector('.password');
            passwordInput.setCustomValidity('');
            passwordInput.reportValidity();
        }
        else if(event.target.label === "Password"){
            this.password = event.target.value;
        }
    }

    handleLogin(){
        this.redirectTo = "login";
        // check if NEXT is allowed on this screen
        if (this.availableActions.find((action) => action === 'NEXT')) {
            // navigate to the next screen
            const navigateNextEvent = new FlowNavigationNextEvent();
            this.dispatchEvent(navigateNextEvent);
        }
    }

    handleSignup(){
        this.isShowModal = true;
    }

    hideModalBox() {  
        this.isShowModal = false;
    }

    handleRegister(){
        this.redirectTo = "register";
        // check if NEXT is allowed on this screen
        if (this.availableActions.find((action) => action === 'NEXT')) {
            // navigate to the next screen
            const navigateNextEvent = new FlowNavigationNextEvent();
            this.dispatchEvent(navigateNextEvent);
        }
    }

    handleregisterInput(event){
        if(event.target.label === "Username"){
            this.regUsername = event.target.value;
        }
        else if(event.target.label === "Password"){
            this.regPassword = event.target.value;
        }
        else if(event.target.label === "Confirm password"){
            this.regConfirmPassword = event.target.value;
        }
    }
}