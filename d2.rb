class D2 < Formula
  desc "Modern text to diagram language and compiler"
  homepage "https://github.com/terrastruct/d2"
  version "0.1.0"
  if OS.mac?
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/d2/releases/download/v#{version}/d2-v#{version}-macos-amd64.tar.gz"
      sha256 "d03e756f325e8507c1dbb1469bf2f97145d023a0d64c597a177d98a27282532c"
    else
      url "https://github.com/terrastruct/d2/releases/download/v#{version}/d2-v#{version}-macos-arm64.tar.gz"
      sha256 "c2c394aef09103ea531eb834105707603540c3e597b11b004ee71a894f525cb0"
    end
  else
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/d2/releases/download/v#{version}/d2-v#{version}-linux-amd64.tar.gz"
      sha256 "74efd14e9aa8c7f47b698e2b1d5612522e895612aac50d0b7c82ac2e15ef1477"
    else
      url "https://github.com/terrastruct/d2/releases/download/v#{version}/d2-v#{version}-linux-arm64.tar.gz"
      sha256 "dd944e2616235812bb9dd906eca820fd71234d35e847af8ca0c8cfaf90c336a1"
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
