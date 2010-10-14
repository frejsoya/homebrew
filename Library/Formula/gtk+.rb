require 'formula'

class Gtkx <Formula
  url 'ftp://ftp.gnome.org/pub/gnome/sources/gtk+/2.20/gtk+-2.20.1.tar.bz2'
  homepage 'http://www.gtk.org/'
  sha256 '0e081731d21e34ff45c82199490c2889504fa8b3c7e117c043e82ababaec0f65'

  depends_on 'pkg-config' => :build
  depends_on 'glib'
  depends_on 'jpeg'
  depends_on 'libtiff'
  depends_on 'pango'
  depends_on 'jasper' => :optional
  depends_on 'atk' => :optional
  depends_on 'cairo'

  def install
    ENV.append 'CFLAGS', '-arch i386'

    # Cairo and libpng are keg-only, so this needs to be specified.
    cairo_pkgconfig = Formula.factory("cairo").prefix+'lib'+'pkgconfig'
    libpng_pkgconfig = Formula.factory("libpng").prefix+'lib'+'pkgconfig'
    ENV['PKG_CONFIG_PATH'] = [ cairo_pkgconfig, libpng_pkgconfig ].join(":")

    fails_with_llvm "Undefined symbols when linking", :build => "2326"
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--disable-glibtest",
                          "--with-gdktarget=quartz"
    system "make install"
  end
end
