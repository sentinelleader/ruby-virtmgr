require 'choice'
require './Virtmod.rb'
require 'libvirt'
Choice.options do
  header ''
  header 'Specific options:'
  
option :action do
      short '-a'
      long '--action=ACTION'
      desc 'Specify the action -- create or delete or status'
      valid %w[create delete status]
    end

option :domain do
      short '-d'
      long '--domain=DOMAIN'
      desc 'Specify the Domain/Name for the VM'
    end
option :arch do
      short '-r'
      long '--arch=ARCH'
      desc 'Specify the Domain/Name for the VM'
      valid %w[x86 x86_64]
    end
option :help do
      long '--help'
      desc 'shows this message'
    end
end



if Choice.choices[:action] == 'status'

  stat = %x(virsh list)

puts stat

end
if Choice.choices[:action] == 'create'

	name = Choice.choices[:domain]
	arch = Choice.choices[:arch]
        dom_xml = Virtmod.vm_create_xml(name,arch)
#puts dump_xml
puts "Conncting to LibVirt"
conn = Libvirt::open('qemu:///system')
dom = conn.define_domain_xml(dom_xml)
dom.create
conn.close
end	
