class DateBaseInput < SimpleForm::Inputs::Base
  def input
    options[:hint] = hint_text unless options.has_key?(:hint)
    input_html_options[:class] << date_picker_class
    input_html_options[:class] << options[:class]
    input_html_options[:class] << "form-control"

    input_html_options[:data] ||= {} 
    input_html_options[:data]["date-format"] ||= date_format if date_format.present?
    
    template.content_tag(:div, class: 'date') do
      # template.concat @builder.label(attribute_name, class: 'control-label')
      template.content_tag(:div, class: 'input-group date') do 
        template.concat @builder.text_field(attribute_name, input_html_options)
        template.concat template.content_tag(:span, template.content_tag(:i, "", class: "glyphicon glyphicon-th"), class: 'input-group-addon')
      end
    end
  end

  private
  
  # Wrap the icon in a <label> so clicking on it activates the datepicker
  def wrapped_calendar_icon
    date_input_id = "#{@builder.object.class.model_name.to_s.underscore}_#{attribute_name}"

    template.content_tag(:span, class: 'add-on') do
      template.content_tag(:label, template.icon_datepicker, for: date_input_id)
    end
  end

  def date_format
  end
end
