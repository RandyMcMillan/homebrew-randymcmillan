class AsyncUsageCustomTarget < Formula
  desc "Example: async usage of mempool_space with custom target"
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.33"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.33/async_usage_custom_target-aarch64-apple-darwin.tar.xz"
      sha256 "135019853ac73ffb4702ccb84669aa62fe76306f91c081e58f7259d30472a842"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.33/async_usage_custom_target-x86_64-apple-darwin.tar.xz"
      sha256 "351f8e3df53fa01bf2ce6586a7d24ca37a372c9834ac87b6f645708f6b2a9f58"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.33/async_usage_custom_target-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4c46b90b1741cec1b0f2b361089b958064a749a78c8a033d6fd8b7ec0d822052"
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
