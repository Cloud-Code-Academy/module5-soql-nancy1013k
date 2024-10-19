/**
* The SOQL class serves as a primer into the Salesforce Object Query Language in Apex.
* It covers fundamental aspects such as SELECT statements, WHERE clauses, Relationship queries, and LIMIT keyword.
*
* This class introduces developers to the concept of retrieving data from Salesforce using SOQL. It provides
* a step-by-step guide on how to construct SOQL queries, filter results using WHERE clause, retrieve related
* records, and manage data volume using the LIMIT keyword.
* 
* Topics covered in this class include:
* - Understanding the structure of a SOQL query.
* - Crafting basic SELECT statements in SOQL.
* - Applying filters using the WHERE clause in SOQL.
* - Fetching related records using Relationship queries.
* - Controlling the amount of data retrieved using the LIMIT keyword.
* 
* Users of this class can expect to gain a solid understanding of SOQL in Apex and
* be prepared to handle data retrieval tasks in Salesforce development.
* 
* @author Nancy Kolodziej
*/

public with sharing class SOQL {
    
    /**
     * Question 1
     * Update/Uncomment the template code to create a method
     * Returns all leads from Salesforce Org
     * @return List of all leads with Id, LastName, Company, Phone, Email
     * Update the corresponding test class and testGetAllLeads method to cover this method
     */
   //[public | private ] [static] data_type GetAllLeads (input parameters) {
    //  The body of the method
    public static List<Lead> getAllLeads(){
        List<Lead> leads = [SELECT Id, LastName, Company, Phone, Email FROM Lead];
        return leads;
    }   
    //}

    /**
     * Question 2
     * Update/Uncomment the template code to create a method
     * Returns all contacts with first name of John.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByFirstName method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
    public static List<Contact> getContactsByFirstName(){
        List<Contact> contacts = [SELECT Id, FirstName, LastName, Name FROM Contact WHERE FirstName = 'John'];
        return contacts;
    }

    /**
     * Question 3
     * Update/Uncomment the template code to create a method
     * Returns the Contact Id for all contacts with last name of Smith or Jones
     * @return A list of Contact Ids.
     * Update the corresponding test class and testGetContactIdsByLastName method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
    public static List<Id> GetContactIdsByLastName(){
        List<Contact> contacts = [SELECT Id FROM Contact WHERE LastName = 'Smith' OR LastName = 'Jones'];
        List<Id> contactIds = new List<Id>();
        for (Contact eachContact : contacts){
            contactIds.add(eachContact.Id);
        }
        return contactIds;
    }

    /**
     * Question 4
     * Update/Uncomment the template code to create a method
     * Returns List of closed won opportunities for a specific Account.
     * Example: yourMethodName('001XXXXXXXXXXXX') should return the list of closed won opportunities for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Opportunities with important opportunities fields
     * Update the corresponding test class and testGetClosedWonOpportunityCountByAccount method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}

    public static List<Opportunity> GetClosedWonOpportunityCountByAccount(String accountId) {
        List<Opportunity> opportunities = [SELECT Id, Name, AccountId, Amount, StageName, CloseDate 
                                        FROM Opportunity 
                                        WHERE StageName = 'Closed Won' AND AccountId = :accountId
                                        ];
    return opportunities;
}

    /**
     * Question 5
     * Update/Uncomment the template code to create a method
     * Returns the total count of Account records.
     * @return The Integer count of Account records.
     * Update the corresponding test class and testGetAccountCount method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
    /**public static Integer GetAccountCount() {
        Integer accountCount = [SELECT COUNT(Id) FROM Account];
        return accountCount;
    }

    public static Integer GetAccountCount(){
        List<Account> accounts = [SELECT Id FROM Account];
        return accounts*/
    
    public static Integer GetAccountCount() {
        Integer accountCount = [SELECT COUNT() FROM Account];
        return accountCount;
    }

    /**
     * Question 6
     * Update/Uncomment the template code to create a method
     * Return Key Value pair of Task Id and Task records for any tasks due date within the next 7 days.
     * @return A map of Task Ids to Task records.
     * Update the corresponding test class and testGetTasksDueNextWeek method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
    public static map<Id, Task> getTasksDueNextWeek(){
        Map<Id, Task> records = new Map<Id,Task>([SELECT Id FROM Task WHERE ActivityDate = NEXT_N_DAYS:7]);
        return records;
    }

    /**
     * Question 7
     * Update/Uncomment the template code to create a method
     * Retrieves all Contacts that have a example.com domain in their Email.
     * @return A list of Contact records.
     * Update the corresponding test class and testGetContactsByEmailDomain method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}
/*    public static List<Contact> getContactsByEmailDomain(){
        String str = 'example.com';
        List<Contact> contacts = [SELECT Id, email
                                    FROM Contact
                                    WHERE Email LIKE 'str%'];
    return contacts; 
    }
 */   
    public static List<Contact> getContactsByEmailDomain(){
        List<Contact> contacts = [SELECT Id, Email
                                    FROM Contact
                                    WHERE Email LIKE 'example.com%'];
    return contacts; 
    }

    /**
     * Question 8
     * Retrieves all Opportunities that have a specific keyword in their Name.
     * Example: getOpportunitiesByNameKeyword('keyword') should return all Opportunities that have 'keyword' in their Name.
     * @param keyword The keyword to search for in the Opportunity Name.
     * @return A list of Opportunity records.
     */
    public static List<Opportunity> getOpportunitiesByNameKeyword(String keyword) {
        List<Opportunity> opportunities = new List<Opportunity>([SELECT Id, Name
                                            FROM Opportunity
                                            WHERE Name LIKE 'keyword%']);
        return opportunities; // Replace null with the variable you used to store the result
    }

    /**
     * Question 9
     * Retrieves all Cases that Case Origin is not Web or Email or Blank
     * @return A list of Case records.
     */
    public static List<Case> getFilterCaseOrigins() {
        List<Case> cases = [SELECT Id, Origin
                            FROM Case
                            WHERE Origin = 'Phone'];
        return cases; 
    }

    /**
     * Question 10
     * Update/Uncomment the template code to create a method
     * Retrieves all Leads that have a specific Lead Source or contain a specific keyword in their Title.
     * Example: yourMethodName('Web', 'Engineer') should return all Leads that have 'Web' in their Lead Source or 'Engineer' in their Title.
     * @param leadSource The Lead Source to search for.
     * @param keyword The keyword to search for in the Lead Title.
     * @return A list of Lead records.
     * Update the corresponding test class and testGetLeadsBySourceOrTitle method to cover this method
     */
    //[public | private ] [static] data_type method_name (input parameters) {
    //  The body of the method
    //}    
    Public static list<Lead> getFilterCaseOrigins(String Web, String Engineer){
        List<Lead> leads = [SELECT Id, LeadSource, Title
                            FROM Lead
                            WHERE (LeadSource = 'Web') or (Title LIKE 'Engineer%')];
        return leads;
    }

    /**
     * Question 11
     * Returns the names of all Contacts associated with an Account.
     * Example: getContactNamesByAccount('001XXXXXXXXXXXX') should return the list of Contact LastNames for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A list of Contact LastName.
     */
    public static List<String> getContactNamesByAccount(string accountId) {
        // Create a list to hold the Contact LastNames
        List<String> contactLastNames = new List<String>();

        List<Contact> contacts = [SELECT LastName 
                                    FROM Contact
                                    WHERE AccountId = :accountId];
            For (Contact contact : contacts) {
                contactLastNames.add(contact.LastName);
            }
        return contactLastNames;
    }
        // Query the Contacts
        // Loop through each Contact and add the LastName to the list
        //for () {
        //    
        //}

        // Return the list of Contact LastNames
        // Replace null with the variable you used to store the result
    

    /**
     * Question 12
     * Returns the total revenue for all Opportunities in a specific Stage or if the amount is greater than 10000.
     * Example: getTotalRevenueByStage('Closed Won') should return the total revenue for all Opportunities in the 'Closed Won' Stage.
     * @param stage The Stage value to filter Opportunities.
     * @return The total revenue.
     */
    public static Decimal getTotalRevenueByStage(String stage) {
        AggregateResult[] result = [
            SELECT SUM(Amount) totalRevenue
            FROM Opportunity
            WHERE StageName = :stage OR Amount > 10000];
        Decimal totalRevenue = (Decimal) result[0].get('totalRevenue');
        return totalRevenue != null ? totalRevenue : 0; 
    }


    /**
     * Question 13
     * Retrieves the first 10 Accounts ordered by Name.
     * @return A list of the first 10 Accounts ordered by Name.
     */
    public static List<Account> getFirstTenAccounts() {
        List<Account> accounts = [
            SELECT Id, Name 
            FROM Account 
            ORDER BY Name 
            LIMIT 10];
        return accounts; 
    }
    
    /**
     * Question 14
     * Retrieves the Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     * @return A list of Opportunities with an Amount greater than 100,000, ordered by CloseDate, and limited to 5 records.
     */
    public static List<Opportunity> getHighValueOpportunities() {
        List<Opportunity> opportunities = [
            SELECT Id, Name, Amount, CloseDate 
            FROM Opportunity 
            WHERE Amount > 100000
            ORDER BY CloseDate 
            LIMIT 5];
        return opportunities; 
    }
    
    /**
     * Question 15
     * Retrieves the Contacts with the most recent Birthdate, ordered by Birthdate, and limited to 3 records.
     * @return A list of Contacts
     */
    public static List<Contact> getBirthdateContacts() {
        List<Contact> contacts = [
            SELECT Id, Name, Birthdate 
            FROM Contact 
            WHERE Birthdate != NULL 
            ORDER BY Birthdate DESC 
            LIMIT 3
        ];return contacts; 
    }
    
    /**
     * Question 16
     * Retrieves the Cases in the Open Status, ordered by CreatedDate, and limited to 10 records with an offset of 5.
     * @return A list of Cases
     */
    public static List<Case> getCasesWithStatus() {
        List<Case> cases = [
            SELECT Id, CaseNumber, Status, CreatedDate
            FROM Case
            WHERE Status = 'Open'
            ORDER BY CreatedDate
            LIMIT 10 OFFSET 5];
        return cases; // Replace null with the variable you used to store the result
    }

    /**
     * Question 17
     * Returns Set of Case Ids for a specific Account.
     * Example: getCaseIdsByAccount('001XXXXXXXXXXXX') should return the set of Case Ids for the Account with the Id
     * @param accountId The ID of the Account.
     * @return A set of Case Ids.
     */
    public static Set<Id> getCaseIdsByAccount(Id accountId) {
        Set<Id> caseIds = new Set<Id>();
        List<Case> cases = [
            SELECT Id 
            FROM Case 
            WHERE AccountId = :accountId];
        for (Case c : cases) {
            caseIds.add(c.Id);
            }
        return caseIds;
    }

    /**
     * Question 18
     * Return Map of Account Ids to Account Names Not in a specific Country.
     * Example: getAccountIdsToNamesNotInCountry('United States') should return the map of Account Ids to Account Names for Accounts that are not in the United States.
     * @param country The country to filter Accounts.
     * @return A map of Account Ids to Account Names.
     */
    public static Map<Id, String> getAccountIdsToNamesNotInCountry(String country) {
        Map<Id, String> accountIdsToNames = new Map<Id, String>();
        List<Account> accounts = [
            SELECT Id, Name 
            FROM Account 
            WHERE BillingCountry != :country];
        for (Account acc : accounts) {
            accountIdsToNames.put(acc.Id, acc.Name);   
        } 
        return accountIdsToNames; 
    }

    /**
     * Question 19
     * Retrieves the Account Name for a given Contact.
     * Example: getAccountNameForContact('003XXXXXXXXXXXX') should return the Account Name for the Contact with the Id
     * @param contactId The Id of the Contact.
     * @return The Account Name of the Contact.
     */
    public static String getAccountNameForContact(String contactId) {
        String accountName = null;
        List<Contact> contacts = [
            SELECT Account.Name 
            FROM Contact 
            WHERE Id = :contactId
            LIMIT 1];
        if (!contacts.isEmpty() && contacts[0].Account != null) {
            accountName = contacts[0].Account.Name;
        }
        return accountName; // Replace null with the variable you used to store the result
    }    

    /**
     * Question 20
     * Returns single Account that has related opportunities in the same query
     * Example: getAccountAndOpportunitiesFromAccountId('001XXXXXXXXXXXX') should return the Account Name for the Account with the Id and all related Opportunities
     * @param accountId The ID of the Account.
     * @return An Account record with related Opportunities.
     */
    public static Account getAccountAndOpportunitiesFromAccountId(Id accountId) {
        Account accountWithOpportunities = [
            SELECT Id, Name, (SELECT Id, Name, Amount, CloseDate FROM Opportunities) 
            FROM Account 
            WHERE Id = :accountId 
            LIMIT 1];
        return accountWithOpportunities; // Replace null with the variable you used to store the result
    }

    /**
     * Question 21
     * Retrieves all contacts that have the Mailing State similar to the Account Billing State.
     * Example: getAccountsWithContactsByState('001XXXXXXXXXXXX') should return a list of Contacts that have the same Mailing State as the Account with the Id
     * @param Account Id
     * @return List of contacts with the same Mailing State as the Account Billing State
     */
    public static List<Contact> getAccountsWithContactsByState(Id accountId) {
        Account account = [
            SELECT BillingState 
            FROM Account 
            WHERE Id = :accountId 
            LIMIT 1];
        String billingState = account.BillingState;
        List<Contact> contactsWithSameState = [
            SELECT Id, FirstName, LastName, MailingState 
            FROM Contact 
            WHERE MailingState = :billingState];
        return contactsWithSameState; 
    }

    /**
     * Question 22
     * Extracts email domains from them leads, then finds Accounts with matching website domains
     * If Lead Email = test@test.com return account with website = www.test.com
     * Example: findAccountsByLeadEmailDomains([set of lead ids]) should return a list of Accounts with matching email domains
     * @param A set of Lead Ids.
     * @return A list of Accounts with matching email domains.
     */
    public static List<Account> findAccountsByLeadEmailDomains(Set<Id> leadIds) {
        List<Lead> leads = [
            SELECT Email 
            FROM Lead 
            WHERE Id IN :leadIds 
            AND Email != null];
        Set<String> emailDomains = new Set<String>();
        for (Lead lead : leads) {
            // Get the email from the Lead
            String email = lead.Email;

            // Check if the email is not null
            if (email != null) {
                // Extract the domain from the email
                String domain = email.substring(email.indexOf('@') + 1);
                // Add the email domain to the set
                emailDomains.add(domain);
            }
        }
        List<Account> accounts = [
            SELECT Id, Name, Website 
            FROM Account 
            WHERE Website IN :emailDomains];
        return accounts;
    }

    
    /**
     * Question 23
     * Clones and Inserts Opportunity Line Items from an original Opportunity to a list of cloned Opportunities.
     * Adds a randomized number between 1 to 3 to the quantity of each line item.
     * Example: cloneLineItems('001XXXXXXXXXXXX', [list of opportunity ids]) should clone the line items from the Opportunity with the Id to each Opportunity in the list
     * @param Original Opportunity Id
     * @param List of cloned Opportunity Ids
     */
    public static void cloneLineItems(Id origOppId, List<Id> cloneOppIds) {
        List<OpportunityLineItem> originalLineItems = [
            SELECT Id, OpportunityId, Product2Id, Quantity, UnitPrice, PricebookEntryId 
            FROM OpportunityLineItem 
            WHERE OpportunityId = :origOppId];
        List<OpportunityLineItem> newLineItems = new List<OpportunityLineItem>();
        for (Id cloneOppId : cloneOppIds) {
            for (OpportunityLineItem originalLineItem : originalLineItems) {
                OpportunityLineItem clonedLineItem = originalLineItem.clone();
                clonedLineItem.OpportunityId = cloneOppId;
                Integer randomQuantity = Integer.valueOf(Math.floor(Math.random() * 3) + 1);
                clonedLineItem.Quantity += randomQuantity;
                clonedLineItem.PricebookEntryId = originalLineItem.PricebookEntryId;
                newLineItems.add(clonedLineItem);
                System.debug(clonedLineItem);
            }
        }
        if (!newLineItems.isEmpty()) {
            insert newLineItems;
        }
    }
        
    
    
    /**
     * Question 24
     * Retrieves the Opportunity Name, Account Name, and Owner Name for Opportunities that have a Stage of 'Closed Won'.
     * Example: getOpportunityDetailsForClosedWon()
     * @return A list of filtered Opportunity
     */
    public static List<Opportunity> getOpportunityDetailsForClosedWon() {        
        List<Opportunity> opportunities = [
            SELECT Id, Name, Account.Name, Owner.Name 
            FROM Opportunity 
            WHERE StageName = 'Closed Won'];
        return opportunities; 
    }

    /**
     * Question 25
     * Sets the 'Primary_Contact__c' field for all Closed Won Opportunities to first Contact on the Account.
     * Example: setPrimaryContact() should set the 'Primary_Contact__c' field for every Opportunity in the org
     */
       
        public static void setPrimaryContact() {
            List<Opportunity> closedWonOpportunities = fetchClosedWonOpportunities();
            Set<Id> accountIds = new Set<Id>();
            for (Opportunity opp : closedWonOpportunities) {
                if (opp.AccountId != null) {
                    accountIds.add(opp.AccountId);
                }
            }
    
            Map<Id, Id> accountToContactMap = new Map<Id, Id>();
            for (Contact contact : [
                SELECT Id, AccountId 
                FROM Contact 
                WHERE AccountId IN :accountIds
                ORDER BY Name
            ]) {
                if (!accountToContactMap.containsKey(contact.AccountId)) {
                    accountToContactMap.put(contact.AccountId, contact.Id);
                }
            }
    
            List<Opportunity> opportunitiesToUpdate = new List<Opportunity>();
            for (Opportunity opp : closedWonOpportunities) {
                if (accountToContactMap.containsKey(opp.AccountId)) {
                    opp.Primary_Contact__c = accountToContactMap.get(opp.AccountId);
                    opportunitiesToUpdate.add(opp);

                }
            }
                if (!opportunitiesToUpdate.isEmpty()) {
                update opportunitiesToUpdate;
            }
        }
    
        public static List<Opportunity> fetchClosedWonOpportunities() {
            List<Opportunity> opportunities = [
                SELECT Id, Name, AccountId
                FROM Opportunity 
                WHERE StageName = 'Closed Won'
            ];
    
            return opportunities;
        }
    }
