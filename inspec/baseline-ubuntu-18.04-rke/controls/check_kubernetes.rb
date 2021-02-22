# copyright: 2021, Urs Voegele

title "check kubernetes"

# check rke command
control "kubernetes-1.0" do                        # A unique ID for this control
  impact 1.0                                       # The criticality, if this control fails.
  title "check rke nodes"                          # A human-readable title
  desc "check kubenetes nodes"
  describe command('kubectl get nodes') do
    its('exit_status') { should eq 0 }
  end
end
