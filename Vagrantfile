Vagrant.configure(2) do |config|
  config.vm.box = "hashicorp/precise64"
  config.vm.hostname = "mirth_server"
  config.vm.define "mirth_server" do |mirth_server|

  # mirth port-forward
  config.vm.network "forwarded_port", guest: 8080, host: 8084, id:"mirth-admin"
  config.vm.network "forwarded_port", guest: 8443, host: 8444, id:"mirth"

  # mysql port
  config.vm.network "forwarded_port", guest: 3306, host: 3308, id:"mysql"

  
  config.vm.network :private_network, ip: "192.168.33.15"

  config.vm.provider "virtualbox" do |vb|
	  vb.name = "mirth_server"
	  vb.memory = "512" 
  end

  config.vm.provision "shell", path: "provision.sh"
end
end
