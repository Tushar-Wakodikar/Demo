import { LightningElement, track, api } from 'lwc';

export default class ReactiveProperty extends LightningElement {
    @track Name = 'Akshay'; // Private Reactive Property
    @api Phone = '8237335821'; // Public Reactive Property
    // const address = 'Manish Nagar'; // will not work
    // var address = 'Manish Nagar'; // will not work
    // let address = 'Manish Nagar'; // will not work
    email = 'akshaywakodikar1997@gmail.com' // work same as @track

    name2 = 'Akshay Wakodikar';
    showname(){
        console.log('Name : '+this.name2);
    }
    showAlert(){
        let fullName = this.name2;
        alert('Name : '+fullName);
    }
}