puts '==> Initializing the \'roles_permissions\' table...'

# Delete all existing records.
PermissionRole.delete_all

# Resets the sequence of the id to 1.
ActiveRecord::Base.connection.reset_pk_sequence!('permission_roles')
