public with Sharing Class ForgotPassword
{
    public class FPOutput{
        @InvocableVariable(required= true)
        public String response;
    }

    public class FPInput{
        @InvocableVariable(required= true)
        public String username;
        
        @InvocableVariable(required= true)
        public String postal_code;
        
        @InvocableVariable(required= true)
        public String birth_date;
    }

    @InvocableMethod(Label ='Forgot Password')
    public static List<FPOutput> forgotPassword(List<FPInput> input)
    {
        System.debug('Forgot Password Called!');
        List<FPOutput> results = new List<FPOutput>();
         FPOutput output = new FPOutput();
        
         //Call the Forgot password flow
         FPInput info = input.get(0);
         if (validInfo(info.username, info.postal_code, info.birth_date))
         {
            output.response = 'A temporary password has been sent to your email. Please login using the temporary password.'; 
         }
         else
         {
             output.response = 'The info you provied does not match our records. Please verify the info is correct and try again.';
         }
        System.debug('Output is :'+output.response);
        results.add(output);
        return results;
    }
    
    private static boolean validInfo(String username, String postal_code, String birth_date)
    {
        //validate the info provided
        
        return true;

    }
}