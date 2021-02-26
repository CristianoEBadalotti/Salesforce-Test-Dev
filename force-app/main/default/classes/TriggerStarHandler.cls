public without sharing class TriggerStarHandler {
    private static final String PROFILE_NAME = 'Marketing User';

    public static void sendEmail() {

        String textBody = 'Objestos alterados: ';

        for (Star__c star : (List<Star__c>)Trigger.new) {
            textBody += star.Name + ' ';
        }

        List<String> emails = new List<String>();
        for (User user : [
            SELECT Email
            FROM User
            WHERE Profile.Name = :PROFILE_NAME
        ]) {
            emails.add(user.Email);
        }

        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.toAddresses = emails;
        message.optOutPolicy = 'FILTER';
        message.subject = 'Teve alterações de sObjects';
        message.plainTextBody = textBody;
        Messaging.SingleEmailMessage[] messages =   new List<Messaging.SingleEmailMessage> {message};
        Messaging.SendEmailResult[] results = Messaging.sendEmail(messages);
    }
}
