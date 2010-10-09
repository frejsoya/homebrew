require 'formula'

class Libiconv <Formula
  url 'http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.13.1.tar.gz'
  md5 '7ab33ebd26687c744a37264a330bbe9a'
  homepage 'http://www.gnu.org/software/libiconv/'
end

def build_tests?; ARGV.include? '--test'; end

class Glib <Formula
  url 'http://ftp.gnome.org/pub/GNOME/sources/glib/2.26/glib-2.26.0.tar.bz2'
  sha256 '4c18e3aadb5b20acc7c0f7d3a77da8a2843b85a9fd73fd3aa360a7aea953e3b2'
  homepage 'http://www.gtk.org'

  depends_on 'autoconf'
  depends_on 'pkg-config'
  depends_on 'gettext'

  def patches
    mp = "http://trac.macports.org/export/69965/trunk/dports/devel/glib2/files/"
    mp = "https://svn.macports.org/repository/macports/trunk/dports/devel/glib2/files/"
    {
      :p0 => [
        mp+"patch-configure.ac.diff",
        mp+"patch-glib-2.0.pc.in.diff",
        mp+"patch-glib_gunicollate.c.diff",
        mp+"patch-gi18n.h.diff",
        mp+"patch-gio_xdgmime_xdgmime.c.diff",
        mp+"patch-child-test.c.diff"
      ]
    }
  end

  def options
    [['--test', 'Build a debug build and run tests. NOTE: Tests may hang on "unix-streams".']]
  end

  def install
    fails_with_llvm "Undefined symbol errors while linking"

    # Snow Leopard libiconv doesn't have a 64bit version of the libiconv_open
    # function, which breaks things for us, so we build our own
    # http://www.mail-archive.com/gtk-list@gnome.org/msg28747.html

    iconvd = Pathname.getwd+'iconv'
    iconvd.mkpath

    Libiconv.new.brew do
      system "./configure", "--disable-debug", "--disable-dependency-tracking",
                            "--prefix=#{iconvd}",
                            "--enable-static", "--disable-shared"
      system "make install"
    end

    # indeed, amazingly, -w causes gcc to emit spurious errors for this package!
    ENV.enable_warnings

    # Statically link to libiconv so glib doesn't use the bugged version in 10.6
    ENV['LDFLAGS'] += " #{iconvd}/lib/libiconv.a"

    args = ["--disable-dependency-tracking", "--disable-rebuilds",
            "--prefix=#{prefix}",
            "--with-libiconv=gnu"]

    args << "--disable-debug" unless build_tests?

    system Formula.factory("autoconf").bin+"autoconf"
    system "./configure", *args

    # Fix for 64-bit support, from MacPorts
    curl "http://trac.macports.org/export/69965/trunk/dports/devel/glib2/files/config.h.ed", "-O"
    system "ed - config.h < config.h.ed"

    system "make"
    # Supress a folder already exists warning during install
    # Also needed for running tests
    ENV.j1
    system "make test" if build_tests?
    system "make install"

    # This sucks; gettext is Keg only to prevent conflicts with the wider
    # system, but pkg-config or glib is not smart enough to have determined
    # that libintl.dylib isn't in the DYLIB_PATH so we have to add it
    # manually.
    gettext = Formula.factory('gettext')
    inreplace lib+'pkgconfig/glib-2.0.pc' do |s|
      s.gsub! 'Libs: -L${libdir} -lglib-2.0 -lintl',
              "Libs: -L${libdir} -lglib-2.0 -L#{gettext.lib} -lintl"

      s.gsub! 'Cflags: -I${includedir}/glib-2.0 -I${libdir}/glib-2.0/include',
              "Cflags: -I${includedir}/glib-2.0 -I${libdir}/glib-2.0/include -I#{gettext.include}"
    end

    (share+'gtk-doc').rmtree
  end
end
