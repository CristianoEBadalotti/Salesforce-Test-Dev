@isTest
private class BetchStarTest {
    @isTest public static void upsertTest() {
        Star__c  star = new Star__c();
        star.Login__c = 'test';
        star.Name = 'test';
        star.ExternalID__c = '121395510';
        star.NumberForks__c = 233;
        star.NumberStars__c = 455;
        insert star;

        Test.startTest();

        Test.setMock(HttpCalloutMock.class, new HttpMock());

        Database.executeBatch(new BetchStar(), 10);

        Test.stopTest();
    }
}
