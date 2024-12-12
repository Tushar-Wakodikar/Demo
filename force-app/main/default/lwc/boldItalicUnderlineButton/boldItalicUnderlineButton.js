import { LightningElement } from 'lwc';

export default class BoldItalicUnderlineButton extends LightningElement {

    holdvalue = '';
    bold = false;
    italic = false;
    underline = false;

    handleValue(event){
        this.holdvalue = event.target.value;
    }
    handleBold(){
        this.bold = !this.bold;
    }
    handleItalic(){
        this.italic = !this.italic;
    }
    handleUnderline(){
        this.underline = !this.underline;
    }


    get finalStyle(){
        let returnvalue;
        if(this.bold && !this.italic && !this.underline){
            this.returnvalue = '<b>'+this.holdvalue+'</b>';
        }
        else if(this.italic && !this.bold && !this.underline){
            this.returnvalue = '<i>'+this.holdvalue+'</i>';
        }
        else if(this.underline && !this.bold && !this.italic){
            this.returnvalue = '<u>'+this.holdvalue+'</u>';
        }
        else if(!this.underline && this.bold && this.italic){
            this.returnvalue = '<b><i>'+this.holdvalue+'</i></b>';
        }
        else if(this.underline && this.bold && !this.italic){
            this.returnvalue = '<b><u>'+this.holdvalue+'</u></b>';
        }
        else if(this.underline && !this.bold && this.italic){
            this.returnvalue = '<i><u>'+this.holdvalue+'</u></i>';
        }
        else if(this.underline && this.bold && this.italic){
            this.returnvalue = '<b><i><u>'+this.holdvalue+'</u></i></b>';
        }
        else {
            this.returnvalue = this.holdvalue;
        }
        return this.returnvalue;
    }
}