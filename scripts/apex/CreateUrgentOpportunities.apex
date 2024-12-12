// Hardcoded list of Account IDs
List<Id> accountIds = new List<Id>{
    '001d200000E7iFjAAJ',
    '001d200000E7iFkAAJ',
    '001d200000E7iFlAAJ',
    '001d200000E7iFmAAJ',
    '001d200000E7iFnAAJ',
    '001d200000E7iFoAAJ',
    '001d200000E7iFpAAJ',
    '001d200000E7iFqAAJ',
    '001d200000E7iFrAAJ',
    '001d200000E7iFsAAJ',
    '001d200000E7iFtAAJ',
    '001d200000E7iFuAAJ',
    '001d200000E7mZNAAZ'
    // Add more Account IDs here as needed
};

if (accountIds.isEmpty()) {
    System.debug('No account IDs provided. Please ensure the list contains valid IDs.');
    return; // Exit the script if no Account IDs are provided
}

List<Opportunity> testOpportunities = new List<Opportunity>();

// Track the account index manually
Integer accountIndex = 0;

// Loop to create opportunities and assign them to the hardcoded account IDs
for (Integer i = 0; i < 100; i++) {
    // Assign the current Account ID and increment the index
    Id currentAccountId = accountIds[accountIndex];
    testOpportunities.add(new Opportunity(
        Name = 'Urgent Opportunity ' + i,
        StageName = 'Prospecting',
        CloseDate = Date.today().addDays(30 + i),
        Amount = 1000 * (i + 1),
        Urgent__c = true,
        AccountId = currentAccountId
    ));

    // Move to the next account ID and reset the index if it exceeds the list size
    accountIndex++;
    if (accountIndex >= accountIds.size()) {
        accountIndex = 0; // Reset to the first Account ID
    }
}

// Insert opportunities
if (!testOpportunities.isEmpty()) {
    insert testOpportunities;
    System.debug('Test opportunities created successfully with hardcoded Account IDs.');
} else {
    System.debug('No opportunities created. The testOpportunities list is empty.');
}
