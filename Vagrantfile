# -*- mode: ruby -*-

Vagrant.configure(2) do | config |

  config.vm.define "vagrant", primary: true, autostart: true do | vagrant |
    vagrant.vm.hostname = "vagrant"
    vagrant.vm.synced_folder ".", "/srv/app"

    vagrant.ssh.forward_agent = true

    vagrant.vm.provider "docker" do |docker|
      docker.build_dir = "."

      docker.name = "vagrant"
      docker.has_ssh = true

    end

  end

end
