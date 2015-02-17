#!/usr/bin/env ruby

def run_dmz(cmd)
	puts cmd
	`#{cmd}`
end

(1..10).each do |n|
	run_dmz "make build/tests/test_shared-lib#{n}.exe"
end
