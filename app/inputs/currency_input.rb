class CurrencyInput < SimpleForm::Inputs::Base
  
  def input(wrapper_options = nil)
    options[:hint] = 'Numbers only, e.g., 50000' unless options.has_key?(:hint)
    input_html_options[:class] << 'money'
    
    template.content_tag(:div, class: 'input-prepend input-append') do
      template.safe_join([
        template.content_tag(:span, '$', class: 'add-on'),
        @builder.text_field(attribute_name, input_html_options),
        template.content_tag(:span, '.00', class: 'add-on'),
      ], '')
    end
  end
  
end