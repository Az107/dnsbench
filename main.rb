require 'rubygems'
require 'dnsruby'
include Dnsruby

if ARGV.length != 1
    puts("not enough arguments")
    exit
end
server_ip = ARGV[0]
puts "testing #{server_ip}..."
res = Dnsruby::Resolver.new({:nameserver => server_ip})
results = []
final_result = 0
repeats = 3

repeats.times{ |t|
    init_time = Time.now.to_f
    res.query('google.com')
    final_time = Time.now.to_f
    #puts final_time - init_time
    results.append((1 - (final_time - init_time)))
    sleep(0.5)
}

final_result = results.inject(0){|sum,x| sum + x}
final_result = ((final_result / repeats) * 100000000).truncate(1)
puts final_result