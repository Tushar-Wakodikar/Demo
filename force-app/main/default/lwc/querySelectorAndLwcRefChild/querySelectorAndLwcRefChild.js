import { LightningElement, api} from 'lwc';

export default class QuerySelectorAndLwcRefChild extends LightningElement {
    privateProperty = 'Pass Content into child private Property';
    @api publicProperty = 'Pass Content into child Public Property';

    @api
    childFuntion(){
        alert('This is fuction From Chid');
    }
}