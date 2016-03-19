require 'spec_helper'
require 'serverspec'


describe file('/media/myrepo') do
	it {should be_directory}
	it {should be_writable.by('owner')}
	it {should be_executable.by('group')}
end

describe package('nginx') do
	it {should be_installed}
end

describe file('/etc/index.php') do
	it {should be_file}
	it {should be_writable.by('owner')}
    it {should be_readable.by('group')}
end
    
describe file( '/etc/nginx/nginx.conf' ) do
  its(:content) { should match (/.*tcp_nopush on;$/) }
end

describe file( '/etc/nginx/nginx.conf' ) do
  its(:content) { should match (/.*keepalive_timeout 65;$/) }
end

#tcp_nopush on;

    #it 'creates a directory with attributes' do
    #expect(chef_run).to create_directory('/media/myrepo/with_attributes').with(
    #owner: 'root',
    #group: 'root',
    #mode: '755'
  #)
  #end
#end