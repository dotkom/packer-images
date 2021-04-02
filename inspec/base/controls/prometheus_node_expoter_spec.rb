
describe service('node-exporter') do 
    it {should be_enabled}
    it { should be_installed }
end