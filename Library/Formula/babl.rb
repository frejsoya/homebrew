require 'formula'

class Babl <Formula
  url 'ftp://ftp.gimp.org/pub/babl/0.1/babl-0.1.2.tar.bz2'
  md5 '8eebd8d78d3173db7af5e3e60b1e03ea'
  homepage 'http://www.gegl.org/babl'

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-mmx"
    system "make install"
  end
end