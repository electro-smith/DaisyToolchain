class Texinfo < Formula
  desc "Official documentation format of the GNU project"
  homepage "https://www.gnu.org/software/texinfo/"
  url "https://ftp.gnu.org/gnu/texinfo/texinfo-6.7.tar.xz"
  mirror "https://ftpmirror.gnu.org/texinfo/texinfo-6.7.tar.xz"
  sha256 "988403c1542d15ad044600b909997ba3079b10e03224c61188117f3676b02caa"
  license "GPL-3.0"

  livecheck do
    url :stable
  end

  depends_on "gettext" if MacOS.version <= :high_sierra

  keg_only :provided_by_macos

  uses_from_macos "ncurses"
  uses_from_macos "perl"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-install-warnings",
                          "--prefix=#{prefix}"
    system "make", "install"
    doc.install Dir["doc/refcard/txirefcard*"]
  end

  test do
    (testpath/"test.texinfo").write <<~EOS
      @ifnottex
      @node Top
      @top Hello World!
      @end ifnottex
      @bye
    EOS
    system "#{bin}/makeinfo", "test.texinfo"
    assert_match "Hello World!", File.read("test.info")
  end
end
