import { LightningElement, api, track } from 'lwc';

export default class CreateUrgentOpportunity extends LightningElement {
    @track opportunityName = '';
    @track stageName = '';
    @track amount = null;
    @track closeDate = null;

    @api stageOptions = [
        { label: 'Prospecting', value: 'Prospecting' },
        { label: 'Qualification', value: 'Qualification' },
        { label: 'Needs Analysis', value: 'Needs Analysis' },
        { label: 'Value Proposition', value: 'Value Proposition' },
        { label: 'Id. Decision Makers', value: 'Id. Decision Makers' },
        { label: 'Perception Analysis', value: 'Perception Analysis' },
        { label: 'Proposal/Price Quote', value: 'Proposal/Price Quote' },
        { label: 'Negotiation/Review', value: 'Negotiation/Review' },
        { label: 'Closed Won', value: 'Closed Won' },
        { label: 'Closed Lost', value: 'Closed Lost' },
    ];

    handleFieldChange(event) {
        const field = event.target.dataset.field;
        console.log(`Field changed: ${field}, Value: ${event.target.value}`);
        this[field] = event.target.value;
    }

    handleCancel() {
        this.dispatchEvent(new CustomEvent('cancel'));
    }

    handleSave() {
        // Check for null or undefined values
        if (!this.opportunityName) {
            console.error('Missing opportunityName.');
            return;
        } else if (!this.stageName) {
            console.error('Missing stageName.');
            return;
        } else if (!this.amount) {
            console.error('Missing amount.');
            return;
        } else if (!this.closeDate) {
            console.error('Missing closeDate.');
            return;
        }
    
        const opportunity = {
            Name: this.opportunityName,
            StageName: this.stageName,
            Amount: this.amount,
            CloseDate: this.closeDate,
        };
    
        console.log('Dispatching save event with opportunity:', opportunity);
        this.dispatchEvent(new CustomEvent('save', { detail: opportunity, bubbles: true, composed: true }));
    }
    
}