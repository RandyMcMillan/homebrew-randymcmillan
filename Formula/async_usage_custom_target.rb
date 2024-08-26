class AsyncUsageCustomTarget < Formula
  desc "Example: async usage of mempool_space with custom target"
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.36"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.36/async_usage_custom_target-aarch64-apple-darwin.tar.xz"
      sha256 "50ab47c6ac216f517fe1e08a9d44bdfe077dd21ad1410e9e73649ea5d6fb0739"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.36/async_usage_custom_target-x86_64-apple-darwin.tar.xz"
      sha256 "759636df09fbdf0a36aee58c76afc66cbe71861be56685ba655019044c815f75"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.36/async_usage_custom_target-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2c305dfafe6ee1bcfb2d40d031335a4c6dabd4261833ab2ab75921f37730dd63"
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
