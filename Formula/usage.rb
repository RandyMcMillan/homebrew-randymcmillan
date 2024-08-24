class Usage < Formula
  desc "Example: usage of mempool_space"
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.31"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.31/usage-aarch64-apple-darwin.tar.xz"
      sha256 "1527d2114a9c228a400c6334f899ed6408802df42180164e0007ffa3c5ca8bc7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.31/usage-x86_64-apple-darwin.tar.xz"
      sha256 "1852b0c56079fd18be7227f074da8346e4e96e67da18373f1c535d641d3fbd29"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.31/usage-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "589a5155ad4ec16996c16d945e3ac7b47b8aabbe0a32ae9faa18e87a360c0187"
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
