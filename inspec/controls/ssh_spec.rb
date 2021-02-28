describe file('/etc/ssh/ssh_host_rsa_key-cert.pub') do
    its('mode') { should cmp '0640' }
    its('owner') { should eq 'root' }
end

describe service('sshd') do
    it { should be_enabled }
    it { should be_running }
end