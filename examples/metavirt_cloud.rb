require 'rubygems'
$:.unshift File.dirname(__FILE__)+'/../lib/'
require "poolparty"

pool :multiverse do
  
  cloud :vv do
    keypair "front"
    instances 2
    has_file "/etc/motd", :content => "Welcome to your poolparty instance!"
    using :metavirt do
      server_config({:host=>"172.16.68.1", :port=>3000})
      authorized_keys 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCTppECfx7Tb0zoviRfqFaePyAek6+ZktKkHiTHu/jkhG1s4q1oHEe89no21xLxuReyJrDlNe8rLxxZzoYCaAWRdhcqMR3BNqb2w2jpF4pH+bFj0557KrwWP6HSNpRRkyYhxLqZbuH/2t3TzkPevZbcfSYa09jIzqnmTruh9l1s+n5E3cNr/RDdDn7tv3Ok7mKN7GEjkK7F83Pt9xviHevg22xqzm99nS+hg6Kl/fQUTO6pOmC5x+9V47RJz1+9WdhGJ7M83zijX9rMnAwrR5LFoL6aZyyU0G71SpoIL5e8XD/jt1WNKFJOfG8YMLb3i03UABm/Q5Q30+R7UoRxSWRX'
      using :vmrun do
        # vmx_files Dir[::File.expand_path("~/Documents/Virtual Machines.localized/metavirts/*/*.vmx")]
        vmx_files [
          "/Users/mfairchild/Documents/Virtual\ Machines.localized/Ubuntu-jaunty.vmwarevm/Ubuntu-jaunty.vmx",
          "/Users/mfairchild/Documents/Virtual\ Machines.localized/metavirts/Ubuntu32bitVM copy.vmwarevm/Ubuntu32bitVM.vmx"
          ]
      end
    end
  end
  
end

