class DateMmddyyyyInput < DateBaseInput

  private
  
  def hint_text
    '(MM/DD/YYYY)'
  end
  
  def date_picker_class
    'datepicker'
  end
  
  def date_format
    "MM/DD/YYYY"
  end

  def strftime_format
    "%-m/%-d/%Y"
  end
end