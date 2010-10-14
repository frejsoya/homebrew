require 'formula'

class Pangomm <Formula
  url 'http://ftp.gnome.org/pub/GNOME/sources/pangomm/2.26/pangomm-2.26.2.tar.bz2'
  sha256 '0d20fd80d35f7df01138e24b2ab4a70974c6652528a905605e3173a6955fa739'
  homepage 'http://www.pango.org/'

  depends_on 'pkg-config' => :build
  depends_on 'pango'
  depends_on 'glibmm'
  depends_on 'cairomm'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end