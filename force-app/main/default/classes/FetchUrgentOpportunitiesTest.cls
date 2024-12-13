@isTest
public class FetchUrgentOpportunitiesTest {
    @isTest
    static void testFetchUrgentOpportunities() {
        // Step 1: Create test data
        // Create a test Account
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        // Create test Opportunities linked to the test Account
        List<Opportunity> testOpportunities = new List<Opportunity>();
        for (Integer i = 0; i < 5; i++) {
            testOpportunities.add(new Opportunity(
                Name = 'Urgent Opportunity ' + i,
                StageName = 'Prospecting',
                CloseDate = Date.today().addDays(30),
                Amount = 1000 * (i + 1),
                Urgent__c = true,
                AccountId = testAccount.Id
            ));
        }
        insert testOpportunities;

        // Step 2: Call the method being tested
        String searchKey = 'Urgent';
        Id accountId = testAccount.Id;
        Integer offset = 0;
        Integer limitValue = 2;

        // Test the fetchUrgentOpportunities method
        List<Opportunity> result = UrgentOpportunitiesController.fetchUrgentOpportunities(searchKey, accountId, offset, limitValue);

        // Step 3: Assert results
        System.assertNotEquals(null, result, 'The result should not be null');
        System.assertEquals(2, result.size(), 'The result size should match the limitValue');
        System.assert(result[0].Name.contains('Urgent'), 'The first Opportunity name should contain "Urgent"');
    }
}