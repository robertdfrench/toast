#!/usr/bin/env ruby
require "json"
require "erb"

def run_dmz(cmd)
	puts cmd
	`#{cmd}`
end

def log(msg)
	puts "[TOAST BUILD] #{msg}"
end

log "load environment.json"
env = JSON.load(File.open("environment.json"))
@account = env['account']
@nodes = env['nodes']
@seconds = env['seconds']
@name = env['name']
@shared_filesystem_path = env['shared_filesystem_path']
@node_filesystem_path = env['node_filesystem_path']
@num_trials = env['num_trials']
@density = env['density']
num_executables = @num_trials * 2

log "build executables and shared libs"
(1..num_executables).each do |n|
	run_dmz "make build/tests/test_shared-lib#{n}.exe"
end

log "generate pbs script"
b = binding
erb = ERB.new(File.read("tests/script_template.erb"))
File.open(ARGV[0],"w") do |f|
	f.write erb.result b
end

log "Deploy everything to shared filesystem"
(1..num_executables).each do |n|
	`cp build/tests/test_shared-lib#{n}.exe #{@shared_filesystem_path}`
	`cp build/tests/libdummy#{n}.so #{@shared_filesystem_path}`
end
`cp toast #{@shared_filesystem_path}`

jobid = `qsub #{ARGV[0]}`
log "Submitting to queue system: #{jobid}"
