class LibusbCompat < Formula
  desc "Library for USB device access"
  homepage "https://libusb.info/"
  url "https://downloads.sourceforge.net/project/libusb/libusb-compat-0.1/libusb-compat-0.1.5/libusb-compat-0.1.5.tar.bz2"
  sha256 "404ef4b6b324be79ac1bfb3d839eac860fbc929e6acb1ef88793a6ea328bc55a"
  revision 1

  livecheck do
    url :stable
    regex(%r{url=.*?/libusb-compat[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  depends_on "pkg-config" => :build
  depends_on "libusb"

  def install
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    system "#{bin}/libusb-config", "--libs"
  end
end
