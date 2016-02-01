class DateMmyyyyInput < DateBaseInput

  private
  
  def hint_text
    '(MM/YYYY)'
  end
  
  def date_picker_class
    'datepicker-month'
  end

  def date_format
    "MM/YYYY"
  end  
end