class Tala < Formula
  desc "Advanced diagram layout engine for D2"
  homepage "https://github.com/terrastruct/TALA"
  version "0.3.9"

  if OS.mac?
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-macos-amd64.tar.gz"
      sha256 "69f3ffef1b74ac0b8a05807abcdd67a671afb15f592d002d490c2e23f5631707"
    else
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-macos-arm64.tar.gz"
      sha256 "eb5974eaf61ab4fd4c4f61ece317aa35eeba8482d069c95fec5091dc78efe7ce"
    end
  else
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-linux-amd64.tar.gz"
      sha256 "4b3b95c2a41ae098293db96e78e7eec6183c39d6c73647135bd34caa0b62c020"
    else
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-linux-arm64.tar.gz"
      sha256 "ba1777264532e3a37cb204cb00473e7eb68070f73d3e30809c9c525ae881ceb0"
    end
  end

  depends_on "d2"

  def install
    system "make", "install", "PREFIX=#{prefix}"
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
