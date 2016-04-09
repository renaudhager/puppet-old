#!/opt/puppetlabs/puppet/bin/ruby
# Automatic remediation of hanging Puppet runs

max_runtime = 3600

pid_file = '/opt/puppetlabs/puppet/cache/state/agent_catalog_run.lock'
if File.exist?(pid_file)
	pid = File.read(pid_file).to_i
	pid_time = File.mtime(pid_file).to_i
	current_time = Time.new.to_i
    delta = current_time - pid_time
    if delta >= max_runtime
    	puts "CRITICAL : #{delta} seconds (Max:#{max_runtime})"
    	Process.kill(9,pid)
    	exec '/opt/puppetlabs/bin/puppet agent -tv'
    else
    	puts "OK : Currently running under threshold"
    end
else
	puts "OK : Not running"
end
