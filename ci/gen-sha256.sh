#!/bin/sh
set -eu
cd -- "$(dirname "$0")/.."
. ./ci/sub/lib.sh

help() {
  cat <<EOF
usage: $0 [--run=regex]

Generates the url/sha256 release asset blocks for d2.rb and tala.rb
EOF
}

main() {
  while flag_parse "$@"; do
    case "$FLAG" in
      h|help)
        help
        return 0
        ;;
      run)
        flag_reqarg && shift "$FLAGSHIFT"
        JOBFILTER="$FLAGARG"
        ;;
      *)
        flag_errusage "unrecognized flag $FLAGRAW"
        ;;
    esac
  done
  shift "$FLAGSHIFT"

  REPO=tala gen_block
}

gen_block() {
  header "$REPO"
  VERSION=v$(extract_version)
  MACOS_AMD64_SHA256=$(OS=macos ARCH=amd64 gen_sha256)
  MACOS_ARM64_SHA256=$(OS=macos ARCH=arm64 gen_sha256)
  LINUX_AMD64_SHA256=$(OS=linux ARCH=amd64 gen_sha256)
  LINUX_ARM64_SHA256=$(OS=linux ARCH=arm64 gen_sha256)

  cat <<EOF
if OS.mac?
  if RUBY_PLATFORM.include?("x86_64")
    url "https://github.com/terrastruct/$REPO/releases/download/v#{version}/$REPO-v#{version}-macos-amd64.tar.gz"
    sha256 "$MACOS_AMD64_SHA256"
  else
    url "https://github.com/terrastruct/$REPO/releases/download/v#{version}/$REPO-v#{version}-macos-arm64.tar.gz"
    sha256 "$MACOS_ARM64_SHA256"
  end
else
  if RUBY_PLATFORM.include?("x86_64")
    url "https://github.com/terrastruct/$REPO/releases/download/v#{version}/$REPO-v#{version}-linux-amd64.tar.gz"
    sha256 "$LINUX_AMD64_SHA256"
  else
    url "https://github.com/terrastruct/$REPO/releases/download/v#{version}/$REPO-v#{version}-linux-arm64.tar.gz"
    sha256 "$LINUX_ARM64_SHA256"
  end
end
EOF
}

extract_version() {
  sh_c "cat '$REPO.rb' | grep 'version \"' | sed 's/^.*version \"\([^\"]*\)\"$/\1/'"
}

gen_sha256() {
  URL=https://github.com/terrastruct/$REPO/releases/download/$VERSION/$REPO-$VERSION-$OS-$ARCH.tar.gz
  sh_c "curl -fsSL# '$URL' | sha256sum | cut -f1 -d' '"
}

main "$@"
