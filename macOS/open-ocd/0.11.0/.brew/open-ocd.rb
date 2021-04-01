class OpenOcd < Formula
  desc "On-chip debugging, in-system programming and boundary-scan testing"
  homepage "http://openocd.org/"
  url "https://downloads.sourceforge.net/project/openocd/openocd/0.11.0/openocd-0.11.0.tar.bz2"
  sha256 "43a3ce734aff1d3706ad87793a9f3a5371cb0e357f0ffd0a151656b06b3d1e7d"
  license "GPL-2.0-or-later"

  livecheck do
    url :stable
    regex(%r{url=.*?/openocd[._-]v?(\d+(?:\.\d+)+)\.t}i)
  end

  head do
    url "https://github.com/ntfreak/openocd.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
    depends_on "texinfo" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "capstone"
  depends_on "hidapi"
  depends_on "libftdi"
  depends_on "libusb"
  depends_on "libusb-compat"

  def install
    ENV["CCACHE"] = "none"

    system "./bootstrap", "nosubmodule" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--enable-buspirate",
                          "--enable-stlink",
                          "--enable-dummy",
                          "--enable-jtag_vpi",
                          "--enable-remote-bitbang"
    system "make", "install"
  end
end
