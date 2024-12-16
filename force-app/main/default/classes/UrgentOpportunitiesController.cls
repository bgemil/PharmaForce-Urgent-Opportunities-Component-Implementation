public with sharing class UrgentOpportunitiesController {
    @AuraEnabled(cacheable=true)
    public static List<Opportunity> fetchUrgentOpportunities(String searchKey, Id accountId, Integer offset, Integer limitValue) {
        try {
            String searchFilter;
            if(searchKey == null) {
                searchFilter = '%';
            } else {
                searchFilter = '%' + searchKey + '%';
            }

            return [
                SELECT Id, Name, StageName, Amount, CloseDate
                FROM Opportunity
                WHERE Urgent__c = true
                AND AccountId = :accountId
                AND Name LIKE :searchFilter
                ORDER BY CloseDate DESC
                LIMIT :limitValue OFFSET :offset
            ];

        } catch (Exception e) {
            ErrorHandler.logError(e, 'UrgentOpportunitiesController', 'fetchUrgentOpportunities', 'ERROR');
            throw new AuraHandledException('An error occurred while fetching opportunities.');
        }
    }

    @AuraEnabled(cacheable=true)
    public static Integer fetchTotalRecordCount(String searchKey, Id accountId) {
        try {
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
        } catch (Exception e) {
            ErrorHandler.logError(e, 'UrgentOpportunitiesController', 'fetchTotalRecordCount', 'ERROR');
            throw new AuraHandledException('An error occurred while fetching the total record count.');
        }
    }

    @AuraEnabled
    public static void saveNewOpportunity(Opportunity opportunity) {
        Integer retryCount = 0;
        Boolean success = false;

        while (retryCount < 3 && !success) {
            try {
                insert opportunity;
                success = true;
            } catch (Exception e) {
                retryCount++;
                if (retryCount == 3) {
                    ErrorHandler.logError(e, 'UrgentOpportunitiesController', 'saveNewOpportunity', 'ERROR');
                    throw new AuraHandledException('An error occurred while saving the opportunity. Please try again later.');
                }
            }
        }
    }

}