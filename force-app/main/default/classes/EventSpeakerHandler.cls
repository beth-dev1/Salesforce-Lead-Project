public with sharing class EventSpeakerHandler {
    
    // Bu metot Trigger'dan gelen listeyi alır ve kontrol eder
    public static void checkDuplicates(List<Event_Speaker__c> newRecords) {
        
        Set<Id> speakerIds = new Set<Id>();
        Set<Id> eventIds = new Set<Id>();

        // 1. Gelen kayıtlardaki ID'leri topla
        for (Event_Speaker__c es : newRecords) {
            if (es.Speaker__c != null && es.Event__c != null) {
                speakerIds.add(es.Speaker__c);
                eventIds.add(es.Event__c);
            }
        }

        // 2. Veritabanında mevcut kayıt var mı sorgula (SOQL)
        List<Event_Speaker__c> existingRecords = [SELECT Speaker__c, Event__c 
                                                  FROM Event_Speaker__c 
                                                  WHERE Speaker__c IN :speakerIds 
                                                  AND Event__c IN :eventIds];

        // 3. Karşılaştır ve hata varsa işaretle
        for (Event_Speaker__c newRec : newRecords) {
            for (Event_Speaker__c oldRec : existingRecords) {
                if (newRec.Speaker__c == oldRec.Speaker__c && newRec.Event__c == oldRec.Event__c) {
                    newRec.addError('Dikkat! Bu konuşmacı bu etkinliğe zaten eklenmiş.');
                }
            }
        }
    }
}