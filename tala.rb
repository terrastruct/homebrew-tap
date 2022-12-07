class Tala < Formula
  desc "Advanced diagram layout engine for D2"
  homepage "https://github.com/terrastruct/TALA"
  version "0.2.6"
  if OS.mac?
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-macos-amd64.tar.gz"
      sha256 "4495fb46e54e552bcf879af833abd94f80dcb6c5977835fa62bffa8f037b1de3"
    else
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-macos-arm64.tar.gz"
      sha256 "fc8ff9311f3959a0566fd7092d6f6a09ef28058c045e6a74cba40e6e320133f5"
    end
  else
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-linux-amd64.tar.gz"
      sha256 "7f43b2d0ab7d473a63f52889a1568de756da8ec6e62873eed05b043422d15278"
    else
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-linux-arm64.tar.gz"
      sha256 "d593758e43ab7d0a4f5ccb9f1b26dbfc10f869412c18be952a616e786de6910a"
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
