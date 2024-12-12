import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class BuildLoginPage extends NavigationMixin(LightningElement) {
    @api username;
    @api password;

    handleSignUp(){
        this[NavigationMixin.Navigate]({
            type: 'standard__component',
            attributes: {
                componentName: 'c__NavigatetoAura'
            }
        });
    }

    handleLWCSignup(){
        let cmpDef = {
            componentDef:"c:singupPage"
        };
        let encodeDef = btoa(JSON.stringify(cmpDef));

        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: '/one/one.app#'+encodeDef
            }
        });
    }

}