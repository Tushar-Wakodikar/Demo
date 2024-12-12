trigger FaceBookWebhookTrigger on Lead (before insert,before update,after insert,after update) {

    String url = 'https://bajajsteel-dev-ed.develop.lightning.force.com';

    String content = Webhook.jsonContent(Trigger.new, Trigger.old);

    Webhook.callout(url, content);

}