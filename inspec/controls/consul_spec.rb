title 'Ensure consul is setup properly'

describe service('consul') do
    it { should be_enabled }
end

describe user('consul') do
    it { should exist }
    its('group') { should eq 'consul' }
end

describe file('/etc/consul.d/consul.hcl') do
    it { should_not exist }
end

describe file('/etc/consul.d/consul.json') do
    it { should be_file }
    it { should be_owned_by 'consul'}
    its('mode') { should cmp '0640' }
end

describe file('/etc/consul.d') do
    it { should be_directory }
    it { should be_owned_by 'consul'}
    its('mode') { should cmp '0640' }
end

describe file('/opt/consul') do
    it { should be_directory }
    it { should be_owned_by 'consul'}
    its('mode') { should cmp '0640' }
end