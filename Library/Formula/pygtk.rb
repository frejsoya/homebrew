require 'formula'

class Pygtk <Formula
  url 'http://ftp.gnome.org/pub/GNOME/sources/pygtk/2.17/pygtk-2.17.0.tar.bz2'
  homepage 'http://www.pygtk.org/'
  sha256 '6a61817a2e765c6209c72ecdf44389ec134c1ebed1d842408bf001c9321f1400'

  depends_on 'gtk'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end
