require 'formula'

class Gegl <Formula
  url 'ftp://ftp.gimp.org/pub/gegl/0.1/gegl-0.1.2.tar.bz2'
  md5 'd35ffe17dc042652eca3205488ece262'
  homepage 'http://www.gegl.org/'

  depends_on 'glib'
  depends_on 'babl'

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-mmx", "--disable-docs", "--disable-dependency-tracking"
    system "make install"
  end
end
