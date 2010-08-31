require 'formula'

class Gtkmm <Formula
  url 'http://ftp.gnome.org/pub/GNOME/sources/gtkmm/2.18/gtkmm-2.18.2.tar.bz2'
  sha256 'dfc003e22ecdc046cbae731b24e077ed87efa0f9ca57a0735dfe716c560b474e'
  homepage 'http://www.gtkmm.org/'

  depends_on 'glibmm'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end