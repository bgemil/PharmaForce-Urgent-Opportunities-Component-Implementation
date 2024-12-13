@isTest
private class NewUrgentOpportunityTriggerTest {
    @isTest
    static void testUrgentOpportunityNotifications() {
        // Create a test account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Add team member
        User testUser = [SELECT Id, Email FROM User WHERE IsActive = TRUE LIMIT 1];
        AccountTeamMember teamMember = new AccountTeamMember(
            AccountId = testAccount.Id,
            UserId = testUser.Id,
            TeamMemberRole = 'Sales Rep'
        );
        insert teamMember;

        // Create test opportunity
        Opportunity testOpp = new Opportunity(
            Name = 'Test Urgent Opportunity',
            AccountId = testAccount.Id,
            CloseDate = Date.today().addDays(30),
            StageName = 'Prospecting',
            Amount = 10000,
            Urgent__c = true
        );
        insert testOpp;

        // Add assertions to verify notifications and emails
        // Example: Check debug logs or mock email sending
    }
}