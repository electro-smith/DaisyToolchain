class DfuUtil < Formula
  desc "USB programmer"
  homepage "https://dfu-util.sourceforge.io/"
  url "https://downloads.sourceforge.net/project/dfu-util/dfu-util-0.10.tar.gz"
  sha256 "a03dc58dfc79c056819c0544b2a5970537566460102b3d82cfb038c60e619b42"
  license "GPL-2.0"

  livecheck do
    url :stable
  end

  head do
    url "https://git.code.sf.net/p/dfu-util/dfu-util.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libusb"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system bin/"dfu-util", "-V"
    system bin/"dfu-prefix", "-V"
    system bin/"dfu-suffix", "-V"
  end
end
