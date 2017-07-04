puts '==> Initializing the \'permissions\' table...'

# Delete all existing records.
Permission.delete_all

# Resets the sequence of the id to 1.
ActiveRecord::Base.connection.reset_pk_sequence!('permissions')
