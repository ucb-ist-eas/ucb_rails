require 'spec_helper'

describe 'UcbRails::Renderer::LdapPersonSearchResultLink' do
  ActionView::Base.send(:include, UcbRails::LdapPersonSearchHelper)
  ActionView::Base.send(:include, UcbRails::ExtractableHelper)
  ActionView::Base.send(:include, Bootstrap::ButtonHelper)
  ActionView::Base.send(:include, Bootstrap::CommonHelper)

  let(:klass) { UcbRails::Renderer::LdapPersonSearchResultLink }
  let(:entry) { double('entry', uid: '123', first_name: 'Art', last_name: 'Andrews', email: 'aa@example.com') }
  let(:template) do
    ActionView::Base.new.tap do |t|
      allow(t).to receive(:params) { {} }
    end
  end

  it "defaults" do
    html = klass.new(template, entry).html
    link = Capybara.string(html).find('a.result-link.result-link-default')

    expect(link.text).to eq('Add')
    expect(link['href']).to eq('#')
    expect(link['data-method']).to eq('get')
    expect(link['data-uid']).to eq('123')
    expect(link['data-first-name']).to eq('Art')
    expect(link['data-last-name']).to eq('Andrews')
    expect(link['data-email']).to eq('aa@example.com')
  end

  it "url" do
    allow(template).to receive(:params) { {"result-link-url" => '/url'} }
    html = klass.new(template, entry).html
    link = Capybara.string(html).find('a.result-link')

    expect(link['href']).to eq("/url?first_name=Art&last_name=Andrews&uid=123")
    expect(link['data-remote']).to eq('true')
  end

  it "url w/param, method" do
    allow(template).to receive(:params) {
      {"result-link-url" => '/url?foo=bar', 'result-link-http-method' => :post}
    }
    html = klass.new(template, entry).html
    link = Capybara.string(html).find('a.result-link')

    expect(link['href']).to eq("/url?foo=bar&first_name=Art&last_name=Andrews&uid=123")
    expect(link['class']).to_not match /result-link-default/
    expect(link['data-remote']).to eq('true')
    expect(link['data-method']).to eq('post')
  end

  it "change label" do
    allow(template).to receive(:params) { {"result-link-text" => 'Select'} }
    html = klass.new(template, entry).html
    link = Capybara.string(html).find('a.result-link')

    expect(link.text).to eq('Select')
  end

  it "additional class" do
    allow(template).to receive(:params) { {"result-link-class" => 'my-class'} }
    html = klass.new(template, entry, class: 'my-class').html
    link = Capybara.string(html).find('a.result-link.my-class')
    expect(link['class']).to_not match /result-link-default/
  end

end
