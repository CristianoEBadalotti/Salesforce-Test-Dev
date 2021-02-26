@isTest
private class StarServiceTest {
    @isTest public static void getAllStarsTest() {
        Star__c  star = new Star__c();
        star.Login__c = 'test';
        star.Name = 'test';
        star.ExternalID__c = '121395510';
        star.NumberForks__c = 233;
        star.NumberStars__c = 455;
        insert star;

        Test.startTest();

        System.assert(StarService.getAllStars().size() == 1);

        Test.stopTest();
    }
}
