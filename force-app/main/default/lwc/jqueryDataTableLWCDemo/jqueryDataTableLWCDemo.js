import { LightningElement } from 'lwc';
import dataTableResource from '@salesforce/resourceUrl/DataTableZip';
import JqueryResource from '@salesforce/resourceUrl/NewJqueryjsFile';
import { loadScript, loadStyle } from 'lightning/platformResourceLoader';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getAccounts from '@salesforce/apex/LWCExampleController.getAccounts';

export default class JqueryDataTableLWCDemo extends LightningElement {
    accounts = [];
    error;

    async connectedCallback() {
        await this.fetchAccoutns();

        Promise.all([
            loadScript(this, JqueryResource+'/jquery.min.js'),
            loadScript(this, dataTableResource+'/media/js/jquery.dataTables.min.js'),
            loadStyle(this, dataTableResource+ '/media/css/jquery.dataTables.min.css'),
        ]).then(() => {
            console.log('script loaded sucessfully');

            const table = this.template.querySelector('.tableClass');
            const columnNames = ['Name', 'Industry', 'Type', 'Phone', 'Rating'];
            let tableHeaders = '<thead> <tr>';
            columnNames.forEach(header => {
                tableHeaders += '<th>' + header + '</th>';
            });
            tableHeaders += '</tr></thead>';
            table.innerHTML = tableHeaders;

            let jqTable = $(table).DataTable();
            $('div.dataTables_filter input').addClass('slds-input');
            $('div.dataTables_filter input').css("marginBottom", "10px");

            this.accounts.forEach(rec => {
                let tableRows = [];
                tableRows.push('<a href="/lightning/r/Account/' + rec.Id + '/view">' + rec.Name + '</a>');
                tableRows.push(rec.Industry != undefined ? rec.Industry : '');
                tableRows.push(rec.Type != undefined ? rec.Type : '');
                tableRows.push(rec.Phone != undefined ? rec.Phone : '');
                tableRows.push(rec.Rating != undefined ? rec.Rating : '');
                jqTable.row.add(tableRows);
            });
            jqTable.draw();

        }).catch(error => {
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error!!',
                    message: JSON.stringify(error),
                    variant: 'error',
                }),
            );
        });
    }

    async fetchAccoutns() {
        await getAccounts()
            .then(data => {
                if (data) {
                    this.accounts = data;
                }
            })
            .catch(error => {
                this.error = error;
                this.accounts = undefined;
                this.error = 'Unknown error';
                if (Array.isArray(error.body)) {
                    this.error = error.body.map(e => e.message).join(', ');
                } else if (typeof error.body.message === 'string') {
                    this.error = error.body.message;
                }
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error!!',
                        message: error,
                        variant: 'error',
                    }),
                );
            });
    }
}