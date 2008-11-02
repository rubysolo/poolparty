module PoolParty
  class Base
    plugin :haproxy do
      
      def enable
        execute_on_master do
          package({:name => "haproxy"})

          # Restart sysklogd after we update the haproxy.log
          has_service(:name => "sysklogd") do
            ensures "running"
          end
          
          # Template variables
          has_variable(:name => "name_haproxy", :value => "#{cloud.name}")          
          has_variable(:name => "nodenames_haproxy", :value => "generate('/usr/bin/env', '/var/lib/gems/1.8/bin/server-list-active', '-c', 'name')")
          has_variable(:name => "node_ips_haproxy",  :value => "generate('/usr/bin/env', '/var/lib/gems/1.8/bin/server-list-active', '-c', 'ip')")
          
          has_variable(:name => "ports_haproxy", :value => ([(self.respond_to?(:port) ? port : Base.port)].flatten))        
          has_variable(:name => "forwarding_port", :value => (respond_to?(:forwarding_port) ? forwarding_port : Base.forwarding_port))
          has_variable(:name => "proxy_mode", :value => (respond_to?(:proxy_mode) ? proxy_mode : Base.proxy_mode))
          
          # Startup haproxy and enable it
          has_line_in_file("ENABLED=1", "/etc/default/haproxy")
          has_line_in_file("SYSLOGD=\"-r\"", "/etc/default/syslogd")
          has_line_in_file("local0.* /var/log/haproxy.log", "/etc/syslog.conf", {:notify => get_service("sysklogd")})

          # Service is required
          has_service(:name => "haproxy", :ensures => "running", :requires => get_line_in_file("/etc/default/haproxy_line"))

          # These can also be passed in via hash
          has_remotefile(:name => "/etc/haproxy.cfg") do
            mode 644
            requires get_package("haproxy")
            notify get_service("haproxy")
            template File.join(File.dirname(__FILE__), "..", "templates/haproxy.conf")
          end
        end
      end
    end  
  end
end