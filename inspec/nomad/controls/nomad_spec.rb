title 'Ensure nomad is installed, but not running'

describe service('nomad') do 
    it { should be_installed }
    it {should be_enabled}
    it {should_not be_running}
end

describe service('nomad-config-injector') do 
    it { should be_installed }
    it {should be_enabled}
    it {should_not be_running}
end

describe user('nomad') do
    it { should exist }
    its('group') { should eq 'nomad' }
end

describe file('/etc/nomad.d') do
    it { should be_directory }
end

describe file('/opt/nomad') do
    it { should be_directory }
end
