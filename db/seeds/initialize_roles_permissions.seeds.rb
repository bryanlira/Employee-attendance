puts '==> Initializing the \'roles_permissions\' table...'

# Elimina todos los registros existentes.
PermissionRole.delete_all

# Reinicia la secuencia de id a 1.
ActiveRecord::Base.connection.reset_pk_sequence!('permission_roles')
