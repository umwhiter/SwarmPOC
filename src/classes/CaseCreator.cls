public with Sharing Class CaseCreator {

    public class CROutput{
        @InvocableVariable(required= true)
        public String caseId;
    }

    public class CRInput{
        @InvocableVariable(required= true)
        public String postal_code;
        
        @InvocableVariable(required= true)
        public Date birth_date;
    }
    
    @InvocableMethod(Label ='Create Case')
    public static List<CROutput> createCase(List<CRInput> input)
    {
        List<CROutput> output = new List<CROutput>();
        //Find The accounts
        Contact con = findContact(input.get(0).postal_code, input.get(0).birth_date);
            
        //Create a Case
        Case newCase = new Case();
        newCase.ContactId = con.id;
        newCase.CaseStatus__c = 'Initiated';
        newCase.External_Comments__c='Case automatically created by Chatbot.\r\n';
        insert newCase;
        
        CROutput out = new CROutput();
        out.caseId = newCase.id;
        output.add(out);
        
        return output;
    }
    
    private static Contact findContact(String postal_code, Date birthdate)
    {
        String formatted = birthdate.format();
        System.debug('Formatted:'+formatted);
        List<Contact> contacts = [SELECT Id, MailingPostalCode, Birthdate FROM Contact WHERE MailingPostalCode =: postal_code];
        System.debug('Contacts:'+contacts);
        List<Contact> filtered = new List<Contact>();
        for (Contact c : contacts)
        {
            if (c.Birthdate.format().Equals(formatted))
                filtered.add(c);
        }
        System.debug('filtered:'+filtered);
        if (filtered.size() > 0)
        	return filtered.get(0);
        else 
             return null;
    }
}