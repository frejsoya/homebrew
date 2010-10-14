require 'formula'

class Pypoppler <Formula
  url 'http://launchpad.net/poppler-python/trunk/development/+download/pypoppler-0.12.1.tar.gz'
  homepage 'https://launchpad.net/poppler-python'
  md5 '1a89e5ed3042afc81bbd4d02e0cf640a'

  depends_on 'poppler'
  depends_on 'pygtk'
  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    # system "cmake . #{std_cmake_parameters}"
    system "make install"
  end
  
  def patches
 	#Fix codegen has moved to pygobject and the backwards compatability layer is 
	#somewhat borked wrt. paths in homebrew
	DATA
  end
end

__END__
--- a/configure	2009-09-26 23:03:11.000000000 +0200
+++ b/configure	2010-09-21 00:10:19.000000000 +0200
@@ -100 +100 @@
-CODEGENDIR=`pkg-config --variable=codegendir pygtk-2.0`
+CODEGENDIR=`pkg-config --variable=codegendir pygobject-2.0`
