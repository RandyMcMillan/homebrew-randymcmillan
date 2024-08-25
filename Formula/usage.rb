class Usage < Formula
  desc "Example: usage of mempool_space"
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.35"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.35/usage-aarch64-apple-darwin.tar.xz"
      sha256 "cca12b504e59ee5c75ab1db6eacbc7246a9abf369c1e1f3bf8ad9a420dcc0d91"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.35/usage-x86_64-apple-darwin.tar.xz"
      sha256 "98edbff0083b786075b9d930bc5eea3ceb436e363ecb9813c8b66a9a15e8aea5"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.35/usage-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3624802f425ffbbdc21dec74a5ddee0eb1a64fbeb1dbd44cedac0a1eac1c0490"
    end
  end
  license "MPL-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "usage"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "usage"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "usage"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
