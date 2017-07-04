puts '==> Initializing the \'permissions\' table...'

# Elimina todos los registros existentes.
Permission.delete_all

# Reinicia la secuencia de id a 1.
ActiveRecord::Base.connection.reset_pk_sequence!('permissions')
