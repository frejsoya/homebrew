require 'formula'

class Arm < Formula
  homepage 'http://www.atagar.com/arm/'
  url 'http://www.atagar.com/arm/resources/arm-1-3-6.tar.bz2'
  version '1.3.6'
  sha256 'e3697f349ba8e01b6302b268645bae41891b379b03ba5e6894ff4d3df3e83431'

  def install
    mkdir_p "#{share}/arm"
    system "cp -prv * #{share}/arm"

    arm_share  = share + 'arm'
    arm_script = arm_share + 'arm'

    (bin+'arm').write <<-"EOS"
#!/bin/sh
cd #{arm_share}; #{arm_script} $@
    EOS
  end

  def caveats
    arm_share  = share + 'arm'
    arm_sample = arm_share + 'armrc.sample'

    <<-"EOS"
    Install tor with `brew install tor`, or connect to an existing remote
    instance.

    You'll need to enable the Tor Control Protocol in your torrc.
    See here for details: http://www.torproject.org/tor-manual.html.en

    To configure Arm, copy the sample configuration from
    #{arm_sample}
    to ~/.armrc, adjusting as needed.
  EOS
  end
end
