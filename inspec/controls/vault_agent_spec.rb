describe file('/etc/vault_agent.d/') do
    it { should be_directory }
    it { should be_owned_by 'vault'}
    its('mode') { should cmp '0640' }
end

describe file('/etc/vault_agent.d/vault_agent.hcl') do
    it { should be_file }
    it { should be_owned_by 'vault'}
    its('mode') { should cmp '0640' }
end
