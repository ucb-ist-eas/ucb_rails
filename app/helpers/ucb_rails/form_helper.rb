module UcbRails::FormHelper
  def error_messages_for(record)
    if record.errors.present?
      content_tag(:div, class: %w(alert alert-error error-wrapper)) do
        content_tag(:h4, 'Correct the following errors:') +
        content_tag(:ul) do
          lis = record.errors.full_messages.map { |fm| content_tag(:li, fm) }
          safe_join(lis, "\n")
        end
      end
    end
  end  
end