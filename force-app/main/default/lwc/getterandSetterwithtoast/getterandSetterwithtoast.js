import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class GetterandSetterwithtoast extends LightningElement {

    msgColor = 'success';

    handleinput(event){
        this.toastmsg = event.target.value;
    }

    set toastmsg(value){
        if(value === 'red'){
            this.msgColor = 'error';
        }
        else if (value === 'green'){
            this.msgColor = 'success';
        }
        else if(value === 'grey'){
            this.msgColor = 'info';
        }
        else if(value === 'orange'){
            this.msgColor = 'warning';
        }
    }
    handletoast(){
            const toast = new ShowToastEvent({
            title: 'Success',
            message: 'This is Success msg',
            variant: this.msgColor
        });
        this.dispatchEvent(toast);
    }
}