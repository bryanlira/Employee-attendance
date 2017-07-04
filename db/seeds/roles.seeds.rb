puts '==> Filling the \'roles\' table...'

# Delete all existing records.
Role.delete_all

# Resets the sequence of the id to 1.
ActiveRecord::Base.connection.reset_pk_sequence!('roles')

# Content.
Role.create(name: 'God', key: 'god',
            description: 'Super administrador del sistema. Tiene acceso a todo y superpoderes.', scope: 0)
Role.create(name: 'Employee', key: 'employee',
            description: 'Empleado del sistema. Únicamente puede ver los registros que el ha creado.', scope: 1)
