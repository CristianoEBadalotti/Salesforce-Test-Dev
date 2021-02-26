global class BetchStar implements Schedulable, Database.Batchable<sObject>, Database.AllowsCallouts {
    
    global void execute(SchedulableContext sc) {
        Database.executeBatch(this, 10);
    }

    global List<Star__c> start(Database.BatchableContext BC) {
        return StarService.getStars();
    }

    global void execute(Database.BatchableContext BC, List<Star__c> scope) {
        List<Star__c> stars = new List<Star__c>();
        for (Star__c star : scope) {
            star.Id = StarService.getExistingId(star.ExternalID__c);
            stars.add(star);
        }

        upsert stars;
    }

    global void finish(Database.BatchableContext BC) {

    }
}
