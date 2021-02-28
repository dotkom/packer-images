describe file('/etc/consul-template.d') do
    it { should be_directory }
    it { should be_owned_by 'consul'}
    its('mode') { should cmp '0640' }
end

describe file('/etc/consul-template.d/templates') do
    it { should be_directory }
    it { should be_owned_by 'consul'}
    its('mode') { should cmp '0640' }
end

describe file('/etc/consul-template.d/scripts') do
    it { should be_directory }
    it { should be_owned_by 'consul'}
    its('mode') { should cmp '0640' }
end

describe file('/etc/consul-template.d/consul-template.hcl') do
    it { should be_file }
    it { should be_owned_by 'consul'}
    its('mode') { should cmp '0640' }
end

describe service('consul-template') do
    it { should be_enabled }
end