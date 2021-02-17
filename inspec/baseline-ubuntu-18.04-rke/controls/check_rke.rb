# copyright: 2021, Urs Voegele

title "check rke"

# check rke command
control "rke-1.0" do                        # A unique ID for this control
  impact 1.0                                # The criticality, if this control fails.
  title "check if rke command exists"       # A human-readable title
  desc "check rke command"
  describe command('rke --version') do
    its('exit_status') { should eq 0 }
  end
end
