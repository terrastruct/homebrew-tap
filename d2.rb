class D2 < Formula
  desc "Modern text to diagram language and compiler"
  homepage "https://github.com/terrastruct/d2"
  version "0.0.13"
  if OS.mac?
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/d2/releases/download/v#{version}/d2-v#{version}-macos-amd64.tar.gz"
      sha256 "efe15ad95f18918e5f343116d660101b1fb46adf689e2c204f9aa5a3ba89aa44"
    else
      url "https://github.com/terrastruct/d2/releases/download/v#{version}/d2-v#{version}-macos-arm64.tar.gz"
      sha256 "807df20b20e7c15630b4b6dcf54b06d4baaab2b44e8a18f6b66f798aafcfcff4"
    end
  else
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/d2/releases/download/v#{version}/d2-v#{version}-linux-amd64.tar.gz"
      sha256 "64f1f6e969d55c5cea7e8de42bc1a90a538152e2bbc7712c7559a4e28701bb65"
    else
      url "https://github.com/terrastruct/d2/releases/download/v#{version}/d2-v#{version}-linux-arm64.tar.gz"
      sha256 "50dc94345824fa8a8f6a2c3f4f8c238a66750ffb95f97c9c55baa98840139552"
    end
  end
  license "MPL-2.0"

  conflicts_with "d2-from-src", because: "d2-from-src also ships a d2 binary"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/d2", "--version"
    example = testpath/"example.d2"
    example.write <<~EOS
      x -> y -> z
    EOS
    system "#{bin}/d2", "example.d2"
  end
end
