describe service('sshd') do
    it { should be_enabled }
    it { should be_running }
end

describe file('/etc/ssh/trusted-user-ca-keys.pem') do
    it { should exist }
    its('content') { should_not be_empty }
end