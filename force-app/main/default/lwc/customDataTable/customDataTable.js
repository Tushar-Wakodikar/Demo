import { LightningElement,track,wire } from 'lwc';
import getContacts from "@salesforce/apex/getContact.getContacts";
import { loadStyle, loadScript } from 'lightning/platformResourceLoader';
import DataTableCssFile from '@salesforce/resourceUrl/DataTableCssFile';
import DataTableJsFile from '@salesforce/resourceUrl/DataTableJsFile';
import JqueryjsFile from '@salesforce/resourceUrl/JqueryjsFile';

export default class CustomDataTable extends LightningElement {
    @track contacts = '';
    @track result = [];
    @track name = 'Akshay';
    isLibraryLoaded = false;

    async renderedCallback(){
        if (!this.isLibraryLoaded) {
            this.isLibraryLoaded = true;
            await this.loadExternalLibraries();
        }
        this.initializeDataTable();
    }
    
    async loadExternalLibraries() {
        loadScript(this, JqueryjsFile).then(() => {
            console.log('jQuery loaded:', typeof window.$ !== 'undefined');
            loadStyle(this, DataTableCssFile).then(() => {
                loadScript(this, DataTableJsFile).then(() => {
                    console.log('DataTables loaded:', typeof window.$.fn.dataTable !== 'undefined');
                    this.initializeDataTable();
                })
            })
        })
        /*Promise.all([loadScript(this, JqueryjsFile),
            //loadScript(this, DataTableJsFile + '/DataTables-1.10.25/js/jquery.dataTables.min.js'),
            //loadScript(this, DataTableJsFile + '/Responsive-2.2.9/js/responsive.dataTables.min.js'),
            loadScript(this, DataTableJsFile),

           // loadStyle(this, DataTableCssFile + '/DataTables-1.10.25/css/jquery.dataTables.min.css'),
            //loadStyle(this, DataTableCssFile + '/Responsive-2.2.9/css/responsive.dataTables.min.css'),
            loadStyle(this, DataTableCssFile),
        ])
        .then(() => {
            this.initializeDataTable();
        })
        .catch(error => {
            console.log('library loading failed:', error);
        }); */
    }

    initializeDataTable() {
        console.log('jQuery loaded:', typeof window.$ !== 'undefined');
        if(typeof window.$ !== 'undefined'){
        $(this.template.querySelector('.example')).DataTable();
        /*new DataTable(this.template.querySelector('.example'),{
            layout: {
                bottomEnd: {
                    paging: {
                        firstLast: false
                    }
                }
            }
        });*/
        }
    }

    @wire (getContacts,{name:'$contacts'})
    wiredContacts (value,error) {
        if (value){
            this.result = value;
        } else if (error) {
            console.log('error',error);
        }
    }
}