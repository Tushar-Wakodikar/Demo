import { LightningElement } from 'lwc';

export default class QuerySelectorAllDemo extends LightningElement {
    renderedCallback(){
        let element = this.template.querySelectorAll('c-query-selector-and-lwc-ref-child');
        console.log('Length of child component is : '+element.length);
        /*for(let i=0; i<element.length; i++){
            console.log(element[i].publicProperty);
            element[i].publicProperty = 'Changed Content :'+i;
            console.log(element[i].publicProperty);
            element[i].childFuntion();
        }*/
            let count = 1;
            element.forEach((ele) => {
                console.log(ele.publicProperty);
                ele.publicProperty = 'Changed Content count :'+count;
                console.log(ele.publicProperty);
                ele.childFuntion();
                count ++;
            })
    }
}