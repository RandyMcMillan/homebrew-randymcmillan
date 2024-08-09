class Usage < Formula
  desc "Example: usage of mempool_space"
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.7/usage-aarch64-apple-darwin.tar.xz"
      sha256 "665e001ed28b31e7f7d4001a994d8f847966a6cf2bf9cad760c76e0974fad202"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.7/usage-x86_64-apple-darwin.tar.xz"
      sha256 "7f37fe8346062643178a36f866ae51fb3a5f536685916078c0c6a17bcfdea72b"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.7/usage-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3a11d3d82f899ad8c70bca3c5101b8efa7a9e29f860ba37e80c65ea64d76954d"
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
