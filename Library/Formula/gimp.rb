require 'formula'

class Gimp <Formula
  url 'ftp://ftp.gimp.org/pub/gimp/v2.6/gimp-2.6.8.tar.bz2'
  md5 'a4d9462c9420954824a80c9b1963f9d9'
  homepage 'http://www.gimp.org'

  depends_on 'babl'
  depends_on 'gegl'
  depends_on 'gtk'

  def install
    # Cairo is keg-only, so this needs to be specified.
    cairo_pkgconfig = File.join(Formula.factory("cairo").prefix, 'lib', 'pkgconfig')
    ENV['PKG_CONFIG_PATH'] = cairo_pkgconfig

    ENV['DYLD_LIBRARY_PATH'] = ''
    ENV['DYLD_FALLBACK_LIBRARY_PATH'] = '/usr/local/lib'

    ENV.append 'LDFLAGS', '-framework Carbon'
    system "./configure", 
           "--prefix=#{prefix}", 
           "--enable-mp",
           "--with-pdbgen",
           "--without-hal",
           "--without-alsa",
           "--without-gvfs",
           "--without-webkit",
           "--without-x",
           "--build=x86_64-apple-darwin10.0.0", 
           "--disable-mmx" # Broken on x86_64
    
    system "make install"
  end
  
  def patches
    DATA
  end
end


__END__

--- old/plug-ins/twain/tw_mac.c.orig	2009-07-20 15:20:51.000000000 -0500
+++ new/plug-ins/twain/tw_mac.c	2009-12-27 02:51:31.000000000 -0600
@@ -193,10 +193,12 @@
 
   /* Voodoo magic fix inspired by java_swt launcher */
   /* Without this the icon setting doesn't work about half the time. */
+#ifndef __LP64__
   CGrafPtr p = BeginQDContextForApplicationDockTile();
   EndQDContextForApplicationDockTile(p);
 
   SetApplicationDockTileImage (icon);
+#endif
 }
 
 int

--- old/etc/gimprc.orig	2008-10-15 15:35:04.000000000 -0700
+++ new/etc/gimprc	2008-10-15 15:39:58.000000000 -0700
@@ -619,6 +619,8 @@
 # 
 # (help-browser gimp)

+(help-browser web-browser)
+
 # Sets the external web browser to be used.  This can be an absolute path or
 # the name of an executable to search for in the user's PATH. If the command
 # contains '%s' it will be replaced with the URL, else the URL will be
@@ -633,6 +635,8 @@
 # 
 # (user-manual-online no)

+(user-manual-online yes)
+
 # The location of the online user manual. This is used if
 # 'user-manual-online' is enabled.  This is a string value.
 # 
@@ -644,12 +648,16 @@
 # 
 # (toolbox-window-hint utility)

+(toolbox-window-hint normal)
+
 # The window type hint that is set on dock windows. This may affect the way
 # your window manager decorates and handles dock windows.  Possible values
 # are normal, utility and keep-above.
 # 
 # (dock-window-hint utility)

+(dock-window-hint normal)
+
 # When enabled, dock windows (the toolbox and palettes) are set to be
 # transient to the active image window. Most window managers will keep the
 # dock windows above the image window then, but it may also have other
