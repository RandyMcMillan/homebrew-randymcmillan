class LightningSearchDashboard < Formula
  desc "lightning-search <searchText>"
  homepage "https://github.com/randymcmillan/mempool_space.git"
  version "0.0.48"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.48/lightning-search_dashboard-aarch64-apple-darwin.tar.xz"
      sha256 "6bcaca713b9d54dd438a5f3dd9f5e8987347a8f3892adc1c2c94288dac9266ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.48/lightning-search_dashboard-x86_64-apple-darwin.tar.xz"
      sha256 "c9ff5e989d76558adb9a4d16e5cbd77814b6a9d3dcc955823bdcfb6746eafcc5"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.48/lightning-search_dashboard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e3ccf6af0bf0acf44b7ae75fa586c42d7652bf9db017228fe0f1acdd41c6bd0e"
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
      bin.install "lightning-search_dashboard"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lightning-search_dashboard"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lightning-search_dashboard"
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
