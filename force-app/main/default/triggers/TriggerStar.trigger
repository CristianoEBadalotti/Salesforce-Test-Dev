trigger TriggerStar on Star__c (before insert, before update) {
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        TriggerStarHandler.completeInfos();
    }
}