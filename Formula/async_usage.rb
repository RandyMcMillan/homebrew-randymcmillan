class AsyncUsage < Formula
  desc "Example: async usage of mempool_space"
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.7/async_usage-aarch64-apple-darwin.tar.xz"
      sha256 "c1a95866eaef9f3e6a4206658d4b9fc2164b2892fbb92d3fd59018365195dece"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.7/async_usage-x86_64-apple-darwin.tar.xz"
      sha256 "ce6f0f76ce9e481164df639273e72f73ee4144a8b00652339445a8956a04e44e"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.7/async_usage-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "40ef6facd0742bf4cc2c8d627e343ad6cccd717e0d72d5286e91df50834e2295"
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
