# hardware_platform.rb

Facter.add("squid_cache_disks") do
        setcode do
                %x{/bin/df|/usr/bin/awk '$0 ~/squid_cache/{print "cache_dir aufs "$NF" "int($2*0.00085)" 64 128"}'}.chomp
        end
end

