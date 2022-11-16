class Tala < Formula
  desc "Advanced diagram layout engine for D2"
  homepage "https://github.com/terrastruct/TALA"
  version "0.2.4"
  if OS.mac?
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/TALA/releases/download/v#{version}/tala-v#{version}-macos-amd64.tar.gz"
      sha256 "9c41f709181d685c55a07dd912b084aa169f91722573e502c38e8e321ed0325e"
    else
      url "https://github.com/terrastruct/TALA/releases/download/v#{version}/tala-v#{version}-macos-arm64.tar.gz"
      sha256 "690747c6557247403f5f7d718569ca465ceb70a4acc44984be835b82e9f176bc"
    end
  else
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/TALA/releases/download/v#{version}/tala-v#{version}-linux-amd64.tar.gz"
      sha256 "8e095daab1c46b3474606cf31b4cc49c34081dfdea23a92a456259ace20d87be"
    else
      url "https://github.com/terrastruct/TALA/releases/download/v#{version}/tala-v#{version}-linux-arm64.tar.gz"
      sha256 "8eeb052e8413e51d4e988faa4180d921b3ace484a320084b04deb6391e33e532"
    end
  end

  depends_on "go" => :build
  depends_on "d2"

  def install
    bin.install "bin/d2plugin-tala"
    man1.install "man/d2plugin-tala.1"
  end

  test do
    ENV["D2_LAYOUT"] = "tala"
    system "#{bin}/d2plugin-tala", "--version"
    example = testpath/"example.d2"
    example.write <<~EOS
      x -> y -> z
    EOS
    system "d2", "example.d2"
  end
end
