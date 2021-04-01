class Confuse < Formula
  desc "Configuration file parser library written in C"
  homepage "https://github.com/martinh/libconfuse"
  url "https://github.com/martinh/libconfuse/releases/download/v3.3/confuse-3.3.tar.xz"
  sha256 "1dd50a0320e135a55025b23fcdbb3f0a81913b6d0b0a9df8cc2fdf3b3dc67010"
  license "ISC"

  depends_on "pkg-config" => :build

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<~EOS
      #include <confuse.h>
      #include <stdio.h>

      cfg_opt_t opts[] =
      {
        CFG_STR("hello", NULL, CFGF_NONE),
        CFG_END()
      };

      int main(void)
      {
        cfg_t *cfg = cfg_init(opts, CFGF_NONE);
        if (cfg_parse_buf(cfg, "hello=world") == CFG_SUCCESS)
          printf("%s\\n", cfg_getstr(cfg, "hello"));
        cfg_free(cfg);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-L#{lib}", "-lconfuse", "-o", "test"
    assert_match /world/, shell_output("./test")
  end
end
