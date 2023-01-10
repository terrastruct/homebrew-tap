class Tala < Formula
  desc "Advanced diagram layout engine for D2"
  homepage "https://github.com/terrastruct/TALA"
  version "0.2.13"

  if OS.mac?
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-macos-amd64.tar.gz"
      sha256 "c6cf0a6020bf040b9371cb25fa9cf1704f7f7f59cbf5563bac0546940204fd40"
    else
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-macos-arm64.tar.gz"
      sha256 "ce80576bdf5f2a6f1138f49d2d4dbe5981ba2d3a8353419b57612e7f1261160b"
    end
  else
    if RUBY_PLATFORM.include?("x86_64")
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-linux-amd64.tar.gz"
      sha256 "e79075dbea4dc07deaeb2f56650d7a96ab76e3fce50e77ca604b3d3fbd9e805c"
    else
      url "https://github.com/terrastruct/tala/releases/download/v#{version}/tala-v#{version}-linux-arm64.tar.gz"
      sha256 "9c781e0113797084f4829b3c78240fff4f3db2d908af65895fee57073b01062c"
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
