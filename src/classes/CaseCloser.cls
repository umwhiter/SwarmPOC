public with Sharing Class CaseCloser {

    public class CaseId{
        @InvocableVariable(required= true)
        public String id;
    }
    
    @InvocableMethod(Label ='Close Case')
    public static void closeCase(List<CaseId> input)
    {
        Set<Id> ids = new Set<Id>();
        For (CaseId c : input)
        {
            ids.add(c.Id);
        }
        
        List<Case> casesToClose = [Select Id, CaseStatus__c, External_Comments__c from Case where Id in:ids];
        System.debug('Found '+casesToClose.size()+' cases to close');
        for (Case c : casesToClose)
        {
            System.debug(c);
            c.CaseStatus__c = 'Closed';
            c.status = 'Closed';
            c.External_Comments__c+='Case Closed automatically by Chatbot.\n';
        }
         
        update casesToClose;
    }
}