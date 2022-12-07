# CVE-2022-32224 RAILS
#
# There was a bug in Rails allowing YAML-serialized data to be vulnerable to RCE.
# Spina uses the serialize method to store various preferences stored using symbols.
# We've now changed this so preferences are stored with strings as keys instead of
# symbols, but in order to not break existing projects we're adding 'Symbol' to the
# list of permitted classes.
# This can be removed in the future.
#
# More information:
# https://discuss.rubyonrails.org/t/cve-2022-32224-possible-rce-escalation-bug-with-serialized-columns-in-active-record/81017

if ActiveRecord.respond_to?(:yaml_column_permitted_classes)
  Rails.application.config.active_record.yaml_column_permitted_classes ||= []
  Rails.application.config.active_record.yaml_column_permitted_classes += [Symbol]
end
