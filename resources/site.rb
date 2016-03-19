property :homepage, String, default: '<h1>Hello world!</h1>'

load_current_value do
  if ::File.exist?('/var/www/html/index.html')
    homepage IO.read('/var/www/html/index.html')
  end
end

action :create do
  package 'httpd'

  service 'httpd' do
    action [:enable, :start]
  end

  file '/var/www/html/index.html' do
    content homepage
  end
end

action :delete do
  package 'httpd' do
    action :delete
  end
end