module UcbRails::LdapPersonSearchHelper
  
  def link_to_ldap_person_entry(entry)
    UcbRails::Renderer::LdapPersonSearchResultLink.new(self, entry).html
  end
  
  def ldap_entry_class(entry)
    Array['ldap-result']
  end
  
  def ldap_already_include?(uid)
    ldap_person_search_existing_uids.include?(uid.to_s)
  end
  
  def ldap_person_search_existing_uids
    @ldap_person_search_existing_uids ||= (@lps_existing_uids || []).map(&:to_s)
  end
  
  def lps_matches
    @lps_entries.size.zero? ? '' : "Matches: #{@lps_entries.size}"
  end
end