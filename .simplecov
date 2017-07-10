if ENV['COVERAGE']

   SimpleCov.start 'rails' do
    add_group 'Controllers', 'app/controllers/'
    add_group 'Models', 'app/models/'
    add_group 'Helpers', 'app/helpers/'
    add_group 'Mailers', 'app/mailers/'
  end

end
