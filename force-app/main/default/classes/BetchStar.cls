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

        List<Database.UpsertResult> srList = Database.upsert(stars, false);

        for (Database.UpsertResult ur : srList) {
            if (ur.isSuccess()) {
                System.debug('Successfully inserted account. Account ID: ' + ur.getId());
            }
            else {             
                for(Database.Error err : ur.getErrors()) {
                    System.debug('The following error has occurred.');                    
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                }
            }
        }
    }

    global void finish(Database.BatchableContext BC) {

    }
}
