public with sharing class StarService {
    public static List<Star__c> getStars() {
        List<IntegrationAPI.ItemWrp> items = new List<IntegrationAPI.ItemWrp>();
        IntegrationAPI iAPI = new IntegrationAPI();
        try {
            items = iAPI.getItems();
        } catch (Exception e) {
            
        }

        List<Star__c>  stars = new List<Star__c>();
        for (IntegrationAPI.ItemWrp item : items) {
            stars.add(createStar(item));
        }

        return stars;
    }

    private static Star__c createStar(IntegrationAPI.ItemWrp item) {
        Star__c  star = new Star__c();
        star.Login__c = item.owner.login;
        star.Name = item.name;
        star.ExternalID__c = item.id;
        star.NumberForks__c = item.forks_count;
        star.NumberStars__c = item.stargazers_count;
        return star;
    }

    public static Id getExistingId(String externalId) {
        List<Star__c> stars = [
            SELECT Id, ExternalID__c
            FROM Star__c
            WHERE ExternalID__c = :externalId
        ];

        if (!stars.isEmpty()) {
            return stars.get(0).Id;
        }
        return null;
    }

}
