class Make < Formula
  desc "Utility for directing compilation"
  homepage "https://www.gnu.org/software/make/"
  url "https://ftp.gnu.org/gnu/make/make-4.3.tar.lz"
  mirror "https://ftpmirror.gnu.org/make/make-4.3.tar.lz"
  sha256 "de1a441c4edf952521db30bfca80baae86a0ff1acd0a00402999344f04c45e82"
  license "GPL-3.0-only"

  livecheck do
    url :stable
  end

  conflicts_with "remake", because: "both install texinfo files for make"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --program-prefix=g
    ]

    system "./configure", *args
    system "make", "install"

    (libexec/"gnubin").install_symlink bin/"gmake" =>"make"
    (libexec/"gnuman/man1").install_symlink man1/"gmake.1" => "make.1"

    libexec.install_symlink "gnuman" => "man"
  end

  def caveats
    <<~EOS
      GNU "make" has been installed as "gmake".
      If you need to use it as "make", you can add a "gnubin" directory
      to your PATH from your bashrc like:

          PATH="#{opt_libexec}/gnubin:$PATH"
    EOS
  end

  test do
    (testpath/"Makefile").write <<~EOS
      default:
      \t@echo Homebrew
    EOS

    assert_equal "Homebrew\n", shell_output("#{bin}/gmake")
    assert_equal "Homebrew\n", shell_output("#{opt_libexec}/gnubin/make")
  end
end
