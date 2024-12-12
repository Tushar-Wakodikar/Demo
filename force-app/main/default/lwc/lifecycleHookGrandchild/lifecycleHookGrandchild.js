import { LightningElement } from 'lwc';

export default class LifecycleHookGrandchild extends LightningElement {
    renderedCallback(){
        console.log('Rendered CallBack Executed in Grand Child');
    }

    connectedCallback(){
        console.log('Connected CallBack Executed in Grand Child');
        let a;
        console.log('a = '+a.b);
    }

    constructor(){
        console.log('Constructor Executed in Grand Child');
        super();
    }

    disconnectedCallback(){
        console.log('DisConnected callback Executed in Grand Child');
        alert('DisConnected callback Executed in Grand Child');
    }
    dummyContent='';
    handle(event){
        this.dummyContent = event.target.value;
    }
}