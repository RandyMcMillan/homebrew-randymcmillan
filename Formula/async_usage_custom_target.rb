class AsyncUsageCustomTarget < Formula
  desc "Example: async usage of mempool_space with custom target"
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.9/async_usage_custom_target-aarch64-apple-darwin.tar.xz"
      sha256 "5147bbcba2ba71bcf5922c5484b5845ba05f8718a89dce8bb4507e2a31f54609"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.9/async_usage_custom_target-x86_64-apple-darwin.tar.xz"
      sha256 "7a0508a7bfe1f4df1e0ed1441f5fc4d0d9465dcd1977160e531ec0e42befcecd"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.9/async_usage_custom_target-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1b04ed9ff2f31f678a3f1349eab8ca28301b6d703807cff6e8632bca984c33c1"
    end
  end
  license "MPL-2.0"

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}, "x86_64-unknown-linux-musl-dynamic": {}, "x86_64-unknown-linux-musl-static": {}}

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
      bin.install "async_usage_custom_target"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "async_usage_custom_target"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "async_usage_custom_target"
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
