5. Implementing Notifications for Urgent Opportunities
-> Set up Salesforce Notifications (the bell icon): created a new NotificationType;
-> Created an Apex Trigger: trigger NewUrgentOpportunityTrigger on Opportunity (after insert) {...};
-> Created a helper Apex Class:
   public with sharing class NotificationsAndEmailsSender {
     public static void sendNotificationsAndEmails(Opportunity opportunity, Id recipientId, Boolean isCreator, String notificationTypeId, List<Messaging.SingleEmailMessage> emailMessages) {...}
   }
   
