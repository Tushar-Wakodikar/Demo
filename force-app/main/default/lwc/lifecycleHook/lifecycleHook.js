import { LightningElement } from 'lwc';

export default class LifecycleHook extends LightningElement {
    inputvalue;
    renderedCallback(){
        console.log('Rendered CallBack Executed in parent');
    }

    connectedCallback(){
        console.log('Connected CallBack Executed in parent');
    }

    constructor(){
        console.log('Constructor Executed in parent');
        super();
    }

    disconnectedCallback(){
        console.log('DisConnected callback Executed in parent');
        alert('DisConnected callback Executed in parent');
    }
    handlevalue(event){
        this.inputvalue = event.target.value;
    }

    errorCallback(error, stack){
        console.log('Error callback Executed in parent');
        console.log('Error :'+error);
        console.log('Stack :'+stack)
    }

    visibility = true;
    isVisible(){
        this.visibility = !this.visibility;
    }
}