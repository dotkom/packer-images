describe file('/etc/resolv.conf') do
    its('mode') { should cmp '0640' }
    it { should be_owned_by 'root'}
end

describe file('/etc/dnsmasq.d/dnsmasq.conf') do
    its('mode') { should cmp '0640' }
    it { should be_owned_by 'root'}
end

describe service('dnsmasq') do
    it { should be_enabled }
    it { should be_running }
end

describe service('systemd-resolved') do
    it { should_not be_enabled }
    it { should_not be_running }
end

describe host('online.ntnu.no') do
    it { should be_resolvable }
end
  