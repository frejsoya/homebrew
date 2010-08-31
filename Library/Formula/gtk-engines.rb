require 'formula'

class GtkEngines <Formula
  url 'http://ftp.gnome.org/pub/GNOME/sources/gtk-engines/2.20/gtk-engines-2.20.1.tar.bz2'
  homepage 'http://www.gnome.org/'
  md5 '666de7fcdb775cd90dd95e1b20860b5a'

  depends_on 'gettext'
  depends_on 'gtk'

  def install
    # Cairo is keg-only, so this needs to be specified.
    cairo_pkgconfig = File.join(Formula.factory("cairo").prefix, 'lib', 'pkgconfig')
    ENV['PKG_CONFIG_PATH'] = cairo_pkgconfig

    system "./configure", "--prefix=#{prefix}", "--enable-animation"
    system "make install"
  end
end
