import { LightningElement, api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import fetchUrgentOpportunities from '@salesforce/apex/UrgentOpportunitiesController.fetchUrgentOpportunities';
import fetchTotalRecordCount from '@salesforce/apex/UrgentOpportunitiesController.fetchTotalRecordCount';
import saveNewOpportunity from '@salesforce/apex/UrgentOpportunitiesController.saveNewOpportunity';

export default class UrgentOpportunitiesTable extends LightningElement {
    @api recordId;
    @track opportunities = [];
    @track totalRecords = 0;
    searchKey = '';
    offset = 0;
    limitValue = 5;

    columns = [
        { label: 'Opportunity Name', fieldName: 'Name', type: 'text' },
        { label: 'Stage', fieldName: 'StageName', type: 'text' },
        { label: 'Amount', fieldName: 'Amount', type: 'currency' },
        { label: 'Close Date', fieldName: 'CloseDate', type: 'date' },
    ];

    connectedCallback() {
        this.loadOpportunities();
    }

    loadOpportunities() {
        if(!this.recordId) {
            console.error('Record ID is undefined.');
            this.showToast('Error', 'Record ID is undefined. Please refresh the page.', 'error');
            return;
        }

        fetchUrgentOpportunities({ searchKey: this.searchKey, accountId: this.recordId, offset: this.offset, limitValue: this.limitValue })
            .then(result => {
                this.opportunities = result;
            })
            .catch(error => {
                let errorMessage = 'Failed to fetch urgent opportunities.';
                if (error.body && error.body.message) {
                    errorMessage = error.body.message;
                }
                console.error('Error fetching urgent opportunities:', errorMessage);
                this.showToast('Error', errorMessage, 'error');
                this.opportunities = [];
            });

        fetchTotalRecordCount({ searchKey: this.searchKey, accountId: this.recordId })
            .then(result => {
                this.totalRecords = result;
            })
            .catch(error => {
                let errorMessage = 'Failed to fetch the total record count.';
                if (error.body && error.body.message) {
                    errorMessage = error.body.message;
                }
                console.error('Error fetching total record count:', errorMessage);
                this.showToast('Error', errorMessage, 'error');
                this.totalRecords = 0;
            });
    }

    handleSearch(event) {
        this.searchKey = event.target.value;
        this.offset = 0;
        this.loadOpportunities();
    }

    handlePrevious() {
        this.offset = Math.max(this.offset - this.limitValue, 0);
        this.loadOpportunities();
    }

    handleNext() {
        if (this.offset + this.limitValue < this.totalRecords) {
            this.offset += this.limitValue;
            this.loadOpportunities();
        }
    }

    get disablePrevious() {
        return this.offset === 0;
    }

    get disableNext() {
        return this.offset + this.limitValue >= this.totalRecords;
    }

    //for Custom Modal
    @track isModalOpen = false;

    handleNewOpportunity() {
        this.isModalOpen = true;
    }

    handleModalCancel() {
        this.isModalOpen = false;
    }

    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant, // Possible values: 'success', 'error', 'warning', 'info'
        });
        this.dispatchEvent(toastEvent);
    }

    handleModalSave(event) {
        const newOpportunity = event.detail;
        console.log('Received opportunity data from modal:', event.detail);
        newOpportunity.AccountId = this.recordId;
        newOpportunity.Urgent__c = true;

        if (!newOpportunity.Name || !newOpportunity.StageName || !newOpportunity.Amount || !newOpportunity.CloseDate) {
            console.error('Opportunity is missing required fields:', newOpportunity);
            this.showToast('Error', 'Missing required fields for the opportunity.', 'error');
            return;
        }

        saveNewOpportunity({ opportunity: newOpportunity })
            .then(() => {
                this.isModalOpen = false;
                this.loadOpportunities();
                this.showToast('Success', 'New urgent opportunity created!', 'success');
            })
            .catch(function (error) {
                let errorMessage = 'An unexpected error occurred.';
                if (error.body && error.body.message) {
                    errorMessage = error.body.message; // Fetch custom message from Apex
                }
                console.error('Error saving opportunity:', errorMessage);
                this.showToast('Error', errorMessage, 'error');
            }.bind(this));                  
        
        this.isModalOpen = false;
    }    

}