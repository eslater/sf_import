require './spec_helper'

describe "Basic SF Import" do

  before :all do
    config = SFImport::Configuration.instance
    #your credentials here
    config.sf_username = ""
    config.sf_password = ""
    config.sf_sectoken = ""
    config.object_type = "Contact"
  end

  specify "Should import contacts as rasta into salesforce org" do
    hh_contact_data1 = {
        :firstname => "Jack",
        :lastname => "Smith",
        :title => "Esq.",
        :mailingstreet => "123 ABC Blvd",
        :mailingcity => "Austin",
        :mailingstate => "Tx",
        :mailingzip => "78705",
        :mailingcountry => "USA"
    }
    hh_contact_data2 = {
        :firstname => "Jo",
        :lastname => "Mama",
        :title => "Mr.",
        :mailingstreet => "321 CBA Blvd",
        :mailingcity => "Austin",
        :mailingstate => "Tx",
        :mailingzip => "78705",
        :mailingcountry => "USA",
    }
    SFImport::Insert.new([hh_contact_data1,hh_contact_data2]).run
  end

end
