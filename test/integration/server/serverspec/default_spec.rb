require 'spec_helper'
require 'serverspec'

describe 'mycookbook::nginx' do
    it 'should install the nginx package' do
        expect(package('nginx')).to be_installed
    end

    it 'should place the nginx config' do
        nginx_config = file('/etc/nginx/sites-enabled/myapp')

        expect(nginx_config).to be_file
        expect(nginx_config).to be_mode(644)
        expect(nginx_config).to be_owned_by('www-data')
    end

    it 'should enable and start the nginx service' do
        expect(service('nginx')).to be_enabled
        expect(service('nginx')).to be_running
    end

    it 'should listen on port 80' do
        expect(port(80)).to be_listening
    end
end