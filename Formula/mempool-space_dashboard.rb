class MempoolSpaceDashboard < Formula
  desc "mempool.space api interface."
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.57"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.57/mempool-space_dashboard-aarch64-apple-darwin.tar.xz"
      sha256 "49f03c6dbf056b9c90882fc41d252aa49f69649ffba59868b3e46eb16859d11e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.57/mempool-space_dashboard-x86_64-apple-darwin.tar.xz"
      sha256 "23009279a57195b2eb162fd329858687b361ae8ced8b62cb94dedd2bebfc5847"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.57/mempool-space_dashboard-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "44553dc2a90fcb98c955f57a657f5f9ba35dba7b7a53e494ef00c15f8a7e0fb3"
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
