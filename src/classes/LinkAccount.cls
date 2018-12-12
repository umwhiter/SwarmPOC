public with Sharing Class LinkAccount
{
    public class LAOutput{
        @InvocableVariable(required= true)
        public String response;
    }

    public class LAInput{
        @InvocableVariable(required= true)
        public String account_type;
        
        @InvocableVariable(required= true)
        public String client_number;
        
        @InvocableVariable(required= true)
        public String account_number;
    }

    @InvocableMethod(Label ='Link Account' description='links an account to a client number')
    public static List<LAOutput> linkAccount(List<LAInput> input)
    {
        LAOutput output = new LAOutput();
        
        //Call the link account flow
        LAInput info = input.get(0);
        
        if (info.account_type == 'CORPORATE') {
            if (accountExists(info.client_number, info.account_number)) {
                output.response ='Thank you. Please fill out our secure form at the following link: https://www.google.ca/search?q=corporate';
            } else {
                output.response ='We were unable to find the account you requested. You can find the client number on your statements';
            }
        } else if (info.account_type == 'TRUST') {
            if (accountExists(info.client_number, info.account_number)) {
                output.response ='Thank you. Please fill out our secure form at the following link: https://www.google.ca/search?q=trust';
            } else {
                output.response ='We were unable to find the account you requested. You can find the client number on your statements';
            }
        } else if (info.account_type == 'OTHER') {
            if (accountExists(info.client_number, info.account_number)) {
                output.response ='Thank you. We have put in a request to have your account linked. Please check back tomorrow morning after 10:00AM CT';
            } else {
                output.response ='We were unable to find the account you requested. You can find the client number on your statements';
            }
        }
        return new List<LAOutput>{output};     
    }
    
    private static boolean accountExists(String clientNumber, String accountNumber)
    {
        //Verify the account is associated with the client number provided
        
        return true;
    }
}