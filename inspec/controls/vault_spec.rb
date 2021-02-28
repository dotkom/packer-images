describe user('vault') do
    it { should exist }
    its('group') { should eq 'vault' }
end

describe file('/etc/vault.d/vault.hcl') do
    it { should_not exist }
end

describe file('/etc/vault.d') do
    it { should be_directory }
    its('mode') { should cmp '0640' }
    it { should be_owned_by 'vault'}
end

describe file('/opt/vault') do
    it { should be_directory }
    its('mode') { should cmp '0640' }
    it { should be_owned_by 'vault'}
end