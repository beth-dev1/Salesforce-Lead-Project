trigger EventSpeakerTrigger on Event_Speaker__c (before insert, before update) {
    // Sadece tetiklendiğinde Handler'daki ilgili metodu çağırıyoruz
    if (Trigger.isBefore && (Trigger.isInsert || Trigger.isUpdate)) {
        EventSpeakerHandler.checkDuplicates(Trigger.new);
    }
}