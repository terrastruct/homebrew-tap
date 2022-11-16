# When we're ready D2FromSrc is what we'd actually submit to homebrew-core. I didn't want
# to have to set up a bottle server for d2.rb and so I have it set to just pull our binary
# releases as though it's the source like the tala formula.
class D2FromSrc < Formula
  desc "Modern text to diagram language and compiler"
  homepage "https://github.com/terrastruct/d2"
  version "0.0.12"
  url "https://github.com/terrastruct/d2/archive/refs/tags/v#{version}.tar.gz"
  sha256 "dfb1f28f96a59cc5427f9a2b0d85ed5dbf80b4ad05d99648d81fcd76b064e6ca"
  license "MPL-2.0"
  head "https://github.com/terrastruct/d2.git", branch: "master"

  conflicts_with "d2", because: "d2 also ships a d2 binary"

  depends_on "go" => :build

  def install
    system "go", "build", *std_go_args, "-ldflags", "-s -w", "./cmd/d2"
    man1.install "ci/release/template/man/d2.1"
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
