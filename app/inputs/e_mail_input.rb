# Wanted to have class of EmailInput, but couldn't get simple_form to recognize.
class EMailInput < SimpleForm::Inputs::Base

  def input
    template.content_tag(:div, class: 'input-prepend') do
      template.safe_join([
        template.content_tag(:span, template.icon_email, class: 'add-on') ,
        @builder.text_field(attribute_name, input_html_options),
      ], '')
    end
  end

end