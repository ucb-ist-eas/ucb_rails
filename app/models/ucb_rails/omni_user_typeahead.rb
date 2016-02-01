module UcbRails
  # Typeahead that searches both Local and Calnet(ldap)
  class OmniUserTypeahead < UserTypeahead

    alias_method :local_results, :results

    def results(query)
      return local_results(query) + ldap_results(query)
    end

    def ldap_results(query)
      return [] if query.length <= 3
      # TODO: figure out how to search ldap via tokens(first or last or first and last)
      tokens = query.to_s.strip.split(/\s+/)
      results = UcbRails::LdapPerson::Finder.find_by_first_last(
        tokens,
        tokens, 
        sort: :last_first_downcase,
        operator: :|,
        return_result: false,
        size: 10
      )
      results.map{|r| { uid: r.uid, first_last_name: r.full_name } }
    end
  end
end