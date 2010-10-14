require 'formula'

class Pixman <Formula
  url 'http://www.cairographics.org/releases/pixman-0.18.2.tar.gz'
  homepage 'http://www.cairographics.org/'
  sha1 '7b2da072ceede62ac10cc84f0da7eb79e0328483'

  depends_on 'pkg-config' => :build
  depends_on 'libpng'

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking", "--disable-gtk"
    system "make install"
  end
end
