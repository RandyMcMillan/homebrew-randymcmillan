class Usage < Formula
  desc "Example: usage of mempool_space"
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.42"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.42/usage-aarch64-apple-darwin.tar.xz"
      sha256 "38502288dce39c2f37e7ab86032c204cab5495b543c25f43076a64ca7fad26d6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.42/usage-x86_64-apple-darwin.tar.xz"
      sha256 "f6aa4125e8fd3dda063496a06939607239c031aa91e67cb98a1453ed1cf5c31d"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.42/usage-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "433ef2ffeff20f0cecb17ac453bfcb4e7dc3696d761c3a2cee838016564bc861"
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
