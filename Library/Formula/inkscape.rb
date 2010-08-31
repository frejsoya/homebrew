require 'formula'

class Inkscape <Formula
  url 'http://downloads.sourceforge.net/inkscape/inkscape-0.47.tar.bz2'
  sha1 '7c75352f3882ebf4fcaebc22413bcb79bf3b7895'
  homepage 'http://www.inkscape.org'

  depends_on 'gtkmm'
  depends_on "libpng"
  depends_on 'bdw-gc'
  depends_on 'gsl'
  depends_on 'boost'
  depends_on 'popt'
  
  def install
    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end