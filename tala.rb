class Tala < Formula
  desc "Advanced diagram layout engine for D2"
  homepage "https://github.com/terrastruct/TALA"
  version "0.3.2"

  if OS.mac?
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-macos-amd64.tar.gz"
      sha256 "1f87580b93656e847405389aef6b067b2f9a07f1d9428c298007e2ca72b85224"
    else
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-macos-arm64.tar.gz"
      sha256 "ff046b902bb6c482d9f3f20393f83b384f91249ba84db4c254c4c1cc0abfc047"
    end
  else
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-linux-amd64.tar.gz"
      sha256 "71098acdcfc4ea68f00800b9c1c9b5eb2418a90d3384adb6f8d720b97a1029be"
    else
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-linux-arm64.tar.gz"
      sha256 "2546e40ab60200524639ab665943df07676d336fb25b2dda6206ca4f60d698ee"
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
