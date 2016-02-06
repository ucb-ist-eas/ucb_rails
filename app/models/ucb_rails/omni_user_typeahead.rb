module UcbRails
  # Typeahead that searches both Local and Calnet(ldap)
  class OmniUserTypeahead < UserTypeahead

    alias_method :local_results, :results
    
    Result = Struct.new(:uid, :first_last_name)
    TooManyTokens = Class.new(Exception)

    def results(query)
      results = local_results(query)
      results += ldap_results(query) if results.length < self.limit
      return results
    end

    def ldap_results(query)
      return [] if query.length < 3
      tokens = query.to_s.strip.split(/\s+/)
      raise TooManyTokens if tokens.length >= 4 #only support the semantics of 3 tokens. 

      # search strategy is based on semantics of input
      # 1 token: search that one word in both first and last name
      # 2 tokens: split first word to first name, last word to last name
      # 3 tokens: try first and second word as first name, and last word as last name, and vice versa
      case tokens.length
      when 1
        results = results_for_tokens(query, query, :|)
      when 2
        first = tokens[0]
        last = tokens[1]
        results = results_for_tokens(first, last, :&)
        results += results_for_tokens(query, nil, :|) if results.length < self.limit# also try first and second word as first name
        results += results_for_tokens(nil, query, :|) if results.length < self.limit# and first and second word as last name
      when 3
        results = results_for_tokens(tokens[0..1].join(" "), tokens[2], :&)
        results += results_for_tokens(tokens[0], tokens[1..2].join(" "), :&) if results.length < self.limit
      end
      
      return results
    end

    private
    def results_for_tokens(first, last, operator)
      results = UcbRails::LdapPerson::Finder.find_by_first_last(
        first,
        last, 
        sort: :last_first_downcase,
        operator: operator,
        return_result: false,
        size: self.limit
      )
    end
  end
end