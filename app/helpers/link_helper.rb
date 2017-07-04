module LinkHelper
  # If the user does not have permissions to see the link, it doesn't show it.
  def link_item(text, url, css_class = nil)
    link_to(text, url, css_class) if link_item_visible?(url)
  end

  private

  # Gets the name of the controller and the action through the route to send it to the Application police.
  def link_item_visible?(url)
    return true if current_user.god?
    parsed_params = Rails.application.routes.recognize_path(url)
    begin
      record = parsed_params[:controller].classify.constantize
    rescue
      record = parsed_params[:controller].singularize.to_sym
    end
    query = "#{parsed_params[:action]}"
    policy(record).send('general_policy', record, query)
  end
end
