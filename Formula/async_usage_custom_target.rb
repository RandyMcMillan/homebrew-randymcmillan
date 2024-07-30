class AsyncUsageCustomTarget < Formula
  desc "Example: async usage of mempool_space with custom target"
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.5/async_usage_custom_target-aarch64-apple-darwin.tar.xz"
      sha256 "552a8e4748717ee6d0295fac7a428884c15530230561cbde1c4e3d4cf42925a8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.5/async_usage_custom_target-x86_64-apple-darwin.tar.xz"
      sha256 "8c12e675c3734d58afa7ecc30b5282b25b28d0c917b50581f31d9ed57c1ecab1"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.5/async_usage_custom_target-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e8d928c0cf4c1aec7b461631d5284a01d76a37086778e444c4ab0c78e849ee6d"
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
