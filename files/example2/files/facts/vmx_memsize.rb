# hardware_platform.rb

Facter.add("vmx_memsize") do
        setcode do
		%x{/usr/bin/free -mo|/usr/bin/awk '$1 ~/Mem:/ {print $2}'}.chomp
        end
end

