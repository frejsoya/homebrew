require 'formula'

class Autoconf < Formula
  url 'http://ftp.gnu.org/gnu/autoconf/autoconf-2.68.tar.bz2'
  sha1 'b534c293b22048c022b1ff3a372b9c03f26170b4'

  keg_only :provided_by_osx

  def install
    system './configure', "--prefix=#{prefix}"
    system 'make install'
  end
end
