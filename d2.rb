class D2 < Formula
  desc "Modern text to diagram language and compiler"
  homepage "https://github.com/terrastruct/d2"
  version "0.0.12"
  if OS.mac?
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/d2/releases/download/v#{version}/d2-v#{version}-macos-amd64.tar.gz"
      sha256 "ce51e9f46effe01044ee4b8c79a78ee76a223d0f45decb20ba475e4e56dd66a7"
    else
      url "https://github.com/terrastruct/d2/releases/download/v#{version}/d2-v#{version}-macos-arm64.tar.gz"
      sha256 "eaa378b56d5d64c3e0f4adca028a1d3b284e27ff46d063690d77c8b68f50d4b2"
    end
  else
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/d2/releases/download/v#{version}/d2-v#{version}-linux-amd64.tar.gz"
      sha256 "5c0a626921850ba9e1a33a67ea2aaf75f02182d68c61fd521ea558deb9558da1"
    else
      url "https://github.com/terrastruct/d2/releases/download/v#{version}/d2-v#{version}-linux-arm64.tar.gz"
      sha256 "cb050ed083ea88a7661bc0b325607b82e160aa26384a62915a43d2d294989064"
    end
  end
  license "MPL-2.0"
  head "https://github.com/terrastruct/d2.git", branch: "master"

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
