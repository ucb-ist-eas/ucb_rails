class DateYyyyInput < DateBaseInput

  private
  
  def hint_text
    '(YYYY)'
  end
  
  def date_picker_class
    'datepicker-year'
  end

  def date_format
    "YYYY"
  end  
end