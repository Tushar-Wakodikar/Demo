import { LightningElement } from 'lwc';
import lable from '@salesforce/label/c.Greeting';
import hindi from '@salesforce/label/c.Hindi';
import actor from '@salesforce/resourceUrl/bollywoodactors';

export default class UiComponent extends LightningElement {
    greeting = lable;
    langvalue = 'english';

    options = [
        {label: 'English', value: 'english'},
        {label: 'Spanish', value: 'spanish'},
        {label: 'French', value: 'french'},
        {label: 'Chinese', value: 'chinese'},
        {label: 'Hindi', value: 'hindi'}
    ];

    handleChange(event) {
        this.langvalue = event.detail.value;
    }

    get inputlabel(){
        let Language;
        if(this.langvalue === 'hindi'){
            Language = hindi;
        }else if(this.langvalue === 'spanish'){
            Language = 'ingrese el nombre';
        }else if(this.langvalue === 'french'){
            Language = 'entrez le nom';
        }
        else if(this.langvalue === 'chinese'){
            Language = '輸入姓名';
        }
        else{
            Language = 'Enter Name';
        }
        return Language;
    }

    actors = [
        {
            id:"1",
            header : "Sharukh Khan",
            src :  actor+'/Actor/SharukhKhan.jpg',
            description : "Sharukh Khan is India Bollywood Romantic Actor"           
        },
        {
            id:"2",
            header : "Shalman Khan",
            src :  actor+'/Actor/SalmanKhan.jpeg',
            description : "Salman Khan is India Bollywood Budhau Actor"           
        },
        {
            id:"3",
            header : "Amir Khan",
            src :  actor+'/Actor/AmirKhan.jpeg',
            description : "Amir Khan is India Bollywood Serious Actor"           
        }
    ];

}