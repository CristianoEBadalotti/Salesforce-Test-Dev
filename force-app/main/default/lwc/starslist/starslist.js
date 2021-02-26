import { LightningElement, track, wire } from 'lwc';
import getStars from '@salesforce/apex/StarService.getAllStars';

const COLS = [
    { label: 'Nome', fieldName: 'Name' },
    { label: 'Id', fieldName: 'ExternalID__c' },
    { label: 'Numero de estrelas', fieldName: 'NumberStars__c' },
    { label: 'Numero de forks', fieldName: 'NumberForks__c'},
    { label: 'Login', fieldName: 'Login__c' }
];

export default class Starslist extends LightningElement {
    columns = COLS;
    @track stars;

    @wire(getStars)
    wireStars({ error, data}) {
        if (error) {
            console.log('error');
            console.log(error);
        } else {
            if (data) {
                this.stars = data;
                console.log('data');
                console.log(data);
            }
        }
    }
}