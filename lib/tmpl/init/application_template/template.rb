@app_name = app_name
def source_paths
  ["#{__dir__}/template"]
end

# Database
inside 'config' do
  remove_file "database.yml"
  copy_file "database.yml"
  gsub_file 'database.yml', /%APPNAME%/, @app_name
  gsub_file 'database.yml', /%APPNAME_UPPERCASE%/, @app_name.upcase
end
