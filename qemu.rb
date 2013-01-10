require 'choice'
require 'uuid'
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
name = Choice.choices[:domain]
arch = Choice.choices[:arch]
mac = %x(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
GUEST_DISK = "/var/lib/libvirt/images/#{name}.qcow2"
`rm -f #{GUEST_DISK} ; qemu-img create -f qcow2 #{GUEST_DISK} 5G`
uuid = UUID.new
uuid_vm = uuid.generate
