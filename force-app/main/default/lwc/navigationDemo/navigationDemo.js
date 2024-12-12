import { LightningElement } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class NavigationDemo extends NavigationMixin(LightningElement) {

    handleNavigate(){
        this[NavigationMixin.GenerateUrl]({
            type: 'standard__recordPage',
            attributes: {
                recordId: '001IT00002p8doHYAQ',
                objectApiName: 'Account',
                actionName: 'view'
            }
        })
        .then(url =>{
            console.log('Generated Url Is: '+url);
            window.open(url,'_self');
        })
    }
}