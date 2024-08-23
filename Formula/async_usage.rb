class AsyncUsage < Formula
  desc "Example: async usage of mempool_space"
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.27"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.27/async_usage-aarch64-apple-darwin.tar.xz"
      sha256 "8e95ca03090d2276e7f5e567d8c9a04132061644e2b12ee5e32a0eda5900b0de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.27/async_usage-x86_64-apple-darwin.tar.xz"
      sha256 "3b9de759e44c91e8b94c3ea96507e943f6dd9bd3882601d426fa749441b1fe1c"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.27/async_usage-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a4279de74d964943198c27d39bb2cd958aa7c3b056b665e5a1cd2ee33c7bd6d0"
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
