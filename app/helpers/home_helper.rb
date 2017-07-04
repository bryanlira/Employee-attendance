module HomeHelper
  # Set the class active to the employees nav tabs.
  def active_tab(tab)
    controller = request.path_parameters[:action]
    case
      when controller == tab
        'active'
      else
        ''
    end
  end

  # Add style to the row in case the check in is marked as delayed.
  def set_style_if_late(record)
    if record.check_in?
      'bgcolor=#FEE659' if record.check_in.strftime('%T') > '09:00:00'
    end
  end
end
