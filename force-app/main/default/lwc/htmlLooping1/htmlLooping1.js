import { LightningElement } from 'lwc';

export default class HtmlLooping1 extends LightningElement {
    imageList = [];

    connectedCallback(){
        for(let i=0; i<25; i++){
            if(i % 2 === 0){
                this.imageList.push('https://yt3.googleusercontent.com/ytc/AIdro_lZDVKw-z5nuyyiLjjBOEI2t2A3eIjneJl4jOCPvE8Mmfs=s900-c-k-c0x00ffffff-no-rj');
            }
            else{
                this.imageList.push('https://www.salesforce.com/news/wp-content/uploads/sites/3/2020/09/Industries_feature_tile.png');
            }
        }
    }
}