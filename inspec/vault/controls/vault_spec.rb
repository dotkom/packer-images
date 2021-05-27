title 'Ensure vault is installed, but not running'

describe service('vault') do
    it { should be_installed }
    it {should be_enabled}
    it {should_not be_running}
end


describe user('vault') do
    it { should exist }
    its('group') { should eq 'vault' }
end

describe file('/etc/vault.d') do
    it { should be_directory }
end

describe file('/opt/vault') do
    it { should be_directory }
    it { should be_owned_by 'vault'}
end
