require 'formula'

class Pygobject <Formula
  url 'http://ftp.gnome.org/pub/GNOME/sources/pygobject/2.21/pygobject-2.21.2.tar.bz2'
  homepage 'http://www.pygtk.org/'
  sha256 'dc58d55818ded2d2eb20b1d54220c1c501792a2969e9bbf6149cc115d78f07e8'

  depends_on 'glib'

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end
