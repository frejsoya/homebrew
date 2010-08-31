require 'formula'

class Pycairo <Formula
  url 'http://cairographics.org/releases/py2cairo-1.8.10.tar.gz'
  homepage 'http://cairographics.org/pycairo/'
  md5 '87421a6a70304120555ba7ba238f3dc3'

  depends_on 'cairo'

  def install
    # Cairo is keg-only, so this needs to be specified.
    cairo_pkgconfig = File.join(Formula.factory("cairo").prefix, 'lib', 'pkgconfig')
    ENV['PKG_CONFIG_PATH'] = cairo_pkgconfig

    system "./configure", "--prefix=#{prefix}"
    system "make install"
  end
end
