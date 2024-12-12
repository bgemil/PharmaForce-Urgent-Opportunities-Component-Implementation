public with sharing class UrgentOpportunitiesController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> fetchUrgentOpportunities(String searchKey, Id accountId, Integer offset, Integer limitValue) {
        String searchFilter;
        if(searchKey == null) {
            searchFilter = '%';
        } else {
            searchFilter = '%' + searchKey + '%';
        }

        List<Opportunity> opportunities = [
            SELECT Id, Name, StageName, Amount, CloseDate
            FROM Opportunity
            WHERE Urgent__c = true
            AND AccountId = :accountId
            AND Name LIKE :searchFilter
            ORDER BY CloseDate DESC
            LIMIT :limitValue OFFSET :offset
        ];

        return opportunities;
    }

    @AuraEnabled(cacheable=true)
    public static Integer fetchTotalRecordCount(String searchKey, Id accountId) {
        String searchFilter;
        if(searchKey == null) {
            searchFilter = '%';
        } else {
            searchFilter = '%' + searchKey + '%';
        }

        return [
            SELECT COUNT()
            FROM Opportunity
            WHERE Urgent__c = TRUE
            AND AccountId = :accountId
            AND Name LIKE :searchFilter
        ];
    }

    @AuraEnabled
    public static void saveNewOpportunity(Opportunity opportunity) {
        insert opportunity;

        // // Notify account team members
        // sendOpportunityNotification(opportunity);
    }

    // private static void sendOpportunityNotification(Opportunity opportunity) {
    //     // Logic for sending notifications to team members
    // }

}