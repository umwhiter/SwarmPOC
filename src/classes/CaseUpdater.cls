public with Sharing Class CaseUpdater {

    public class CaseUpdate{
        @InvocableVariable(required= true)
        public String id;
        
       	@InvocableVariable(required= true)
        public String status;
        
        @InvocableVariable(required= true)
        public String comments;
    }
    
    @InvocableMethod(Label ='Update Case')
    public static void updateCase(List<CaseUpdate> input)
    {
        Case caseToUpdate = [Select Id, CaseStatus__c, External_Comments__c from Case where Id =:input.get(0).id].get(0);
        caseToUpdate.CaseStatus__c = input.get(0).status;
        caseToUpdate.External_Comments__c = caseToUpdate.External_Comments__c + input.get(0).comments+'\r\n';
        
        System.debug('Updates:'+caseToUpdate);
        
        update caseToUpdate;
    }
}