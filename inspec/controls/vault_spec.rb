describe user('vault') do
    it { should exist }
    its('group') { should eq 'vault' }
end

describe file('/etc/vault.d') do
    it { should be_directory }
    it { should be_owned_by 'vault'}
end

describe file('/opt/vault') do
    it { should be_directory }
    it { should be_owned_by 'vault'}
end

describe service('vault') do 
    it {should_not be_enabled}
    it {should_not be_running}
    it { should be_installed }
end