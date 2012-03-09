module SFImport
  class Contact < SFObject

    @map = {:lastname => "LastName",
            :firstname => "FirstName",
            :title => "Title",
            :mailingstreet => "MailingStreet",
            :mailingcity => "MailingCity",
            :mailingstate => "MailingState",
            :mailingpostalcode => "MailingPostalCode",
            :mailingcountry => "MailingCountry"}

    class << self
      attr_accessor :map
    end

    attr_accessor :firstname
    attr_accessor :lastname
    attr_accessor :title
    attr_accessor :mailingstreet
    attr_accessor :mailingcity
    attr_accessor :mailingstate
    attr_accessor :mailingpostalcode
    attr_accessor :mailingcountry

  end
end
