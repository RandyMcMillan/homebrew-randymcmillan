class AsyncUsage < Formula
  desc "Example: async usage of mempool_space"
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.38"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.38/async_usage-aarch64-apple-darwin.tar.xz"
      sha256 "59815a7068b4510febd72a27430458ddcfce3853ffbf5e9790a9b4ba1101512a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.38/async_usage-x86_64-apple-darwin.tar.xz"
      sha256 "edc61bf5ade637c771091122d5bea0283689c56a34e5c00188e05e36e305328d"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.38/async_usage-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7261f222fbe0b4def370206f33ee443b5d87c837d37e84ed46a1b2037efa0736"
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
      bin.install "async_usage"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "async_usage"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "async_usage"
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
