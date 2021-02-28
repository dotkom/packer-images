describe file('/etc/vault-agent.d/') do
    it { should be_directory }
    it { should be_owned_by 'vault'}
    its('mode') { should cmp '0640' }
end

describe file('/etc/vault-agent.d/vault-agent.hcl') do
    it { should be_file }
    it { should be_owned_by 'vault'}
    its('mode') { should cmp '0640' }
end
