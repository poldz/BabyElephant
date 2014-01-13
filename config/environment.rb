# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
CongregationAccounts::Application.initialize!

ActiveSupport::Inflector.inflections do |inflect|
  inflect.irregular 'tax', 'taxes'
  inflect.singular "taxes", "tax"
  inflect.plural 'tax', 'taxes'
end


UiDatePickerRails3.activate :simple_form