import { LightningElement } from 'lwc';

export default class LifecycleHookChild extends LightningElement {

    childvalue = '';

    renderedCallback(){
        console.log('Rendered CallBack Executed in Child');
    }

    connectedCallback(){
        console.log('Connected CallBack Executed in Child');
        let a;
        console.log('a = '+a.b);
    }

    constructor(){
        console.log('Constructor Executed in Child');
        super();
    }

    disconnectedCallback(){
        console.log('DisConnected callback Executed in child');
        alert('DisConnected callback Executed in child');
    }

    errorCallback(error, stack){
        console.log('Error callback Executed in child');
        console.log('Error :'+error);
        console.log('Stack :'+stack)
    }

    handlevalue(event){
        this.childvalue = event.target.value;
    }

    visiablity = true;

    isVisible(){
        this.visiablity = !this.visiablity
    }
}