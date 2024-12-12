import { LightningElement, track } from 'lwc';

export default class ShowImage extends LightningElement {
    @track imagelist = ['https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp'];
    number = 1;
    addImage(){
        this.imagelist.push('https://img-cdn.pixlr.com/image-generator/history/65bb506dcb310754719cf81f/ede935de-1138-4f66-8ed7-44bd16efc709/medium.webp');
        console.log('Handler Executed');
        this.number++;

    }
}