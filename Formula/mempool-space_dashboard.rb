class MempoolSpaceDashboard < Formula
  desc "mempool.space api interface."
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.51"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.51/mempool-space_dashboard-aarch64-apple-darwin.tar.xz"
      sha256 "b41f90a1679a00d75d0dade5c8f48cffc035cbee0ce6ffa9dea79a73db9cea7f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.51/mempool-space_dashboard-x86_64-apple-darwin.tar.xz"
      sha256 "937b07d64e81554aae5ddeb04ea2f88a7701a8dc222b9483f80517ad417e9ba6"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.51/mempool-space_dashboard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "efd891b3d134c0c30428392623a262f8774959d6cf3817c0440fa123c1cf4b12"
    end
  end
  license "MIT"

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
      bin.install "mempool-space_dashboard"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mempool-space_dashboard"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mempool-space_dashboard"
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
