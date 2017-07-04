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
end
