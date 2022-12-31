class Tala < Formula
  desc "Advanced diagram layout engine for D2"
  homepage "https://github.com/terrastruct/TALA"
  version "0.2.11"

  if OS.mac?
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-macos-amd64.tar.gz"
      sha256 "8beabdfb45091b54a1a89888b5f8ffee56a4821baca5684917f87a12012c65e6"
    else
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-macos-arm64.tar.gz"
      sha256 "eccd6dbe61e300fa2394c53cbfde477a942fb1e1489c56b4d335fc834317bb81"
    end
  else
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-linux-amd64.tar.gz"
      sha256 "2ddf06c59bdb57a3c6662b106a1d7278f08cb40c8f80d1d0114f68e0c7d721a0"
    else
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-linux-arm64.tar.gz"
      sha256 "903bca25ae3d3c0566a1d03bbc3ed74b94f22d8ecdab60a6de0c6d670f9218ae"
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
