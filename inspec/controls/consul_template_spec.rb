describe file('/etc/consul_template.d') do
    it { should be_directory }
end

describe service('consul-template') do
    it { should be_enabled }
    it { should be_running }
end

