module ApplicationHelper
  # Loads the translations for the javascript.
  def current_translations
    @translator = I18n.backend
    @translator.load_translations
    @translations = @translator.send(:translations)[I18n.locale]
  end

  # Checks whether a user has permissions to view the link.
  def has_policy(record, actions, devise_controller = nil)
    return true if current_user.god?
    record = record.classify.constantize if record.is_a? String
    actions.each { |query| return true if policy(record).send('general_policy', record, query, devise_controller) }
    false
  end

  # Verifies that the browser is valid to access to the system.
  def browser_valid?(browser)
    (browser.chrome? && browser.version < '45') || (browser.firefox? && browser.version < '40') ||
        (browser.ie? && browser.version < '9') || (browser.safari? && browser.version < '9') ||
        (browser.platform.windows? && browser.safari?)
  end

  # Filters the options to display according to your role.
  def collection_scope(user, scope)
    policy_name = (scope.to_s + 'Policy').classify.constantize
    policy_name::ScopeActions.new(user, scope).collection_scope
  end

  # Allows to define the number of pagination to be displayed
  def custom_paginator(resource, resource_class = '')
    will_paginate resource, class: "pagination pagination-sm #{resource_class}",
                  next_label: '<i class="fa fa-chevron-right"></i>'.html_safe,
                  previous_label: '<i class="fa fa-chevron-left"></i>'.html_safe
  end

  # Checks whether a user has permissions to view multiple records.
  def has_policy_multiple_records(records, actions, devise_controller = nil)
    return true if current_user.god?
    records.each do |record|
      record = record.classify.constantize if record.is_a? String
      actions.each { |query| return true if policy(record).send('general_policy', record, query, devise_controller) }
    end
    false
  end
end
