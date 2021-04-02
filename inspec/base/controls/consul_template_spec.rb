describe file('/etc/consul_template.d') do
    it { should be_directory }
end

describe service('consul-template') do
    it { should_not be_enabled }
    it { should_not be_running }
    it { should be_installed }
end

