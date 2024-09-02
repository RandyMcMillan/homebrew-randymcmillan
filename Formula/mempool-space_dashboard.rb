class MempoolSpaceDashboard < Formula
  desc "mempool.space api interface."
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.50"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.50/mempool-space_dashboard-aarch64-apple-darwin.tar.xz"
      sha256 "32a7b06cd1bb77f430a7eb5a1be95447f8a4bb51a9db8ae84d8f060fcb802ab7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.50/mempool-space_dashboard-x86_64-apple-darwin.tar.xz"
      sha256 "13640c661e72fa4d4c284d20ca68967f02e55b9a549d721229b78596da24e24d"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.50/mempool-space_dashboard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "154517afaa6dd558f83eaee6888353b41e46a72c07522fef71c601b3b1183b3b"
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
