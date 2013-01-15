require 'uuid'
require 'erb'
module Virtmod
	def Virtmod.vm_create_xml(vm_name,vm_arch)
		vm_disk = "/var/lib/libvirt/images/#{vm_name}.qcow2"
	puts vm_name	
	`rm -f #{vm_disk} ; qemu-img create -f qcow2 #{vm_disk} 5G`
		uuid = UUID.new
		vm_uuid = uuid.generate
		vm_ram = 262144
		vm_iso = "/var/tmp/iso/debian-6.0.5-amd64-CD-1.iso"
		vm_mac = (1..6).map{"%0.2X"%rand(256)}.join(":")
		#template = ./small.erb
	#	vm_xml = ERB.new(File.read("./small.erb")).result
		template = ERB.new File.new("./small.erb").read
		vm_xml = template.result(binding)
		return vm_xml
	end
end
