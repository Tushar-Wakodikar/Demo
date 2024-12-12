import { LightningElement } from 'lwc';

export default class DynamicStyleChange extends LightningElement {
    content;
    colorval;
    backColor;
    fontFamily = "Times New Roman";
    handleColor(event){
        this.colorval = event.target.value;
        let element = this.template.querySelector('.textstyle');
        element.style.color = this.colorval;
    }
    handleValue(event){
        this.content = event.target.value;
    }

    handleStyle(event){
        this.backColor = event.target.value;
        let element = this.template.querySelector('.textstyle');        
        element.style.backgroundColor = this.backColor;
    }

    handleFont(event){
        this.fontFamily = event.target.value;
        let element = this.template.querySelector('.textstyle');
        element.style.fontFamily = this.fontFamily;
    }
}