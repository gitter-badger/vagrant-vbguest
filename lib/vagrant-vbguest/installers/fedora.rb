module VagrantVbguest
  module Installers
    class Fedora < Linux

      def self.match?(vm)
        :fedora == self.distro(vm)
      end

      # Install missing deps and yield up to regular linux installation
      def install(opts=nil, &block)
        communicate.sudo(install_dependencies_cmd, opts, &block)
        super
      end

      protected

      def install_dependencies_cmd
        "`which dnf || which yum` install -y #{dependencies}"
      end

      def dependencies
        packages = ['kernel-devel-`uname -r`', 'gcc', 'dkms', 'make', 'perl', 'bzip2']
        packages.join ' '
      end
    end
  end
end
VagrantVbguest::Installer.register(VagrantVbguest::Installers::Fedora, 5)
