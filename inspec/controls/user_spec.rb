describe user('dotkom') do
    it { should exist }
    its('groups'){ should include 'wheel' }
    its('home') { should eq '/home/dotkom' }
    its('shell') { should eq '/bin/bash' }
end