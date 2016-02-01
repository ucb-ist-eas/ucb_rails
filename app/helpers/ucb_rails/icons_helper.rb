module UcbRails::IconsHelper
  
  def announcements_text
    icon('bullhorn', 'Announcements')
  end

  def icon_file(options = {})
    icon('file', options)
  end
  
  def icon_datepicker
    icon('calendar')
  end
  
  def icon_draft(options = {})
    icon('pencil', options)
  end
  
  def icon_email
    icon('envelope')
  end
  
  def icon_rs(options = {})
    icon('search', options)
  end  
end