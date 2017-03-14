require 'spec_helper'

describe 'UcbRails::Renderer::Base' do
  let(:template) {double('template')}
  let(:renderer_base) {UcbRails::Renderer::Base.new(template)}

  describe '.initialize' do
    it "sets template" do
      expect(renderer_base.template).to eq(template)
    end

    it "options defaults to {}" do
      expect(renderer_base.options).to eq({})
    end

    it "sets options" do
      options = double('options')
      renderer_base = UcbRails::Renderer::Base.new(template, options)
      expect(renderer_base.options).to eq(options)
    end
  end

  describe '#method_missing' do
    it "delegates methods to template" do
      expect(template).to receive(:foo).with(:bar)
      renderer_base.foo(:bar)
    end
  end
end
