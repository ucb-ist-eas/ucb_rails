require 'spec_helper'

describe UcbRails::LpsTypeaheadHelper do

  it "default" do
    html = helper.lps_typeahead_search_field(label: 'User', ldap_modal_search: true)

    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('label.control-label[for="person_search"]', text: 'User')
      div_cg.find('div.controls').tap do |div_c|
        div_c.find('div.input-append').tap do |div_ia|
          div_ia.find('input.typeahead-lps-search').tap do |input|
            expect(input['autocomplete']).to eq('off')
            expect(input['data-uid-dom-id']).to eq('uid')
            expect(input['data-typeahead-url']).to eq('/ucb_rails/person_search')
            expect(input['id']).to eq('person_search_uid')
            expect(input['name']).to eq('person_search')
            expect(input['placeholder']).to eq('Type name to search')
            expect(input['type']).to eq('text')
          end
        end
        div_c.find('span.add-on.ldap-person-search').tap do |span|
          expect(span['data-url']).to eq('null')
          expect(span['data-result-link-class']).to eq('lps-typeahead-item')
          expect(span['data-result-link-text']).to eq('Select')
          expect(span['data-search-field-name']).to eq('person_search')
          span.find('i.glyphicon-search')
        end
        div_c.find('p.help-block', text: 'Click icon to search CalNet')
      end
    end
  end

  it "name" do
    html = helper.lps_typeahead_search_field(name: 'foo_name', label: 'User', ldap_modal_search: true)

    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('label.control-label[for="foo_name"]', text: 'User')
      div_cg.find('div.controls').tap do |div_c|
        div_c.find('div.input-append').tap do |div_ia|
          div_ia.find('input.typeahead-lps-search').tap do |input|
            expect(input['id']).to eq('person_search_uid')
            expect(input['name']).to eq('foo_name')
          end
        end
        div_c.find('span.add-on.ldap-person-search').tap do |span|
          expect(span['data-search-field-name']).to eq('foo_name')
        end
      end
    end
  end

  it "label" do
    html = helper.lps_typeahead_search_field(label: 'foo_label')

    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('label.control-label[for="person_search"]', text: 'foo_label')
    end
  end

  it "required" do
    html = helper.lps_typeahead_search_field(required: true, label: 'User')

    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('label.control-label[for="person_search"]', text: 'User').tap do |label|
        label.find('abbr[title="required"]', text: '*')
      end
    end
  end

  it "value" do
    html = helper.lps_typeahead_search_field(value: 'foo_value')

    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('input[value="foo_value"]')
    end
  end

  it "placeholder" do
    html = helper.lps_typeahead_search_field(placeholder: 'foo_placeholder')

    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('input[placeholder="foo_placeholder"]')
    end
  end

  it "hint" do
    html = helper.lps_typeahead_search_field(hint: 'foo_hint', ldap_modal_search: true)

    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('p.help-block', text: 'foo_hint')
    end
  end

  it "result link text" do
    html = helper.lps_typeahead_search_field(result_link_text: 'foo_rlt', ldap_modal_search: true)

    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('span.add-on[data-result-link-text="foo_rlt"]')
    end
  end

  it "result link class" do
    html = helper.lps_typeahead_search_field(result_link_class: 'foo_rlc', ldap_modal_search: true)

    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('span.add-on[data-result-link-class="foo_rlc"]')
    end
  end

  it "uid dom id" do
    html = helper.lps_typeahead_search_field(uid_dom_id: 'uid2')

    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('input[data-uid-dom-id="uid2"]')
    end
  end

  it "typeahead url" do
    html = helper.lps_typeahead_search_field(typeahead_url: '/ta_url')
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('input[data-typeahead-url="/ta_url"]')
    end
  end

  it "ldap search url" do
    html = helper.lps_typeahead_search_field(ldap_search_url: '/ls_url', ldap_modal_search: true)
    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('span[data-url="/ls_url"]')
    end
  end

  it "no ldap search" do
    html = helper.lps_typeahead_search_field(ldap_modal_search: false, label: 'User')

    Capybara.string(html).find('div.control-group.lps-typeahead').tap do |div_cg|
      div_cg.find('label.control-label[for="person_search"]', text: 'User')
      div_cg.find('div.controls').tap do |div_c|
        div_c.find('input.typeahead-lps-search').tap do |input|
          expect(input['autocomplete']).to eq('off')
          expect(input['data-uid-dom-id']).to eq('uid')
          expect(input['data-typeahead-url']).to eq('/ucb_rails/person_search')
          expect(input['id']).to eq('person_search_uid')
          expect(input['name']).to eq('person_search')
          expect(input['placeholder']).to eq('Type name to search')
          expect(input['type']).to eq('text')
        end
        expect(div_c).to_not have_css('p.help-block')
      end
    end

  end

  it "unknown option" do
    expect { helper.lps_typeahead_search_field(bad: 'option') }
      .to raise_error(ArgumentError, /Unknown lps_typeahead_search_field option/)
  end

end
