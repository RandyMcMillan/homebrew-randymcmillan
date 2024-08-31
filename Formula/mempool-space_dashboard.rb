class MempoolSpaceDashboard < Formula
  desc "The mempool-space_dashboard application"
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.42"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.42/mempool-space_dashboard-aarch64-apple-darwin.tar.xz"
      sha256 "59db18524aab1246eeea52a0033bacfb4e7d85c3e3c32dc732b40e53a7dcdc06"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.42/mempool-space_dashboard-x86_64-apple-darwin.tar.xz"
      sha256 "bb695871a5122c8ad06e3dd76cf3d98832ba76c8e7e334b548b1aae1b8c547c8"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.42/mempool-space_dashboard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c7b7254a77124d43920b60979c45bb44547f9eee7d490e5c703c79f37b356e5a"
    end
  end
  license "MIT"

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
