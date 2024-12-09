# PharmaForce-Urgent-Opportunities-Component-Implementation
# Description
PharmaForce is one of our clients interested in what Sales Cloud has to offer. It’s a company in the pharmaceutics industry and it needs our help to manage their opportunities. They would like to see and create urgent opportunities directly on the account’s related tab. 

The team working on a specific account needs to get a notification whenever a new urgent opportunity is created. 

There should be a flag on Opportunity object to highlight Urgent opportunities 

On the Account Record Page, in the Related tab, show a table which contains all the linked urgent opportunities for the specific Account.

The table should also have a New Opportunity button, used to create new Urget Opportunities.

The table columns should contain Opportunity Name, Stage, Amount, Close Date 

When clicking the New Opportunity button it will open a custom modal with fields (Opportunity Name, Stage, Amount, Close Date) to fill in together with Cancel and Save buttons 

The opportunity created from the button should automatically be linked to the account on which the button was pressed and also flagged as Urgent 

After the opportunity was added it should be displayed in the table 

If the current User is a member of the account team, he should receive a notification mentioning: You've successfully created the XYZ urgent opportunity. 

The other members of the account team should receive a notification displaying the following message: User ABC created a new urgent opportunity (XYZ).
