class RatatuiRelu < Formula
  desc "Continuous, differentiable layout transitions for Ratatui"
  homepage "https://github.com/RandyMcMillan/ratatui-relu"
  version "0.11.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/ratatui-relu/releases/download/v0.11.0/ratatui-relu-aarch64-apple-darwin.tar.xz"
      sha256 "f8aa98777f8614cfc210bd2a0b6bb5027e90d9eca3784cc6299c1afc0cf5d3b2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/ratatui-relu/releases/download/v0.11.0/ratatui-relu-x86_64-apple-darwin.tar.xz"
      sha256 "b8af9b68053bd916708119d8c28bf83fe1ad03fd4e1120cd72f261448d14a420"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/ratatui-relu/releases/download/v0.11.0/ratatui-relu-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f5bc3c4510b5e08c6cf82f39360d532bf6ccea0662e552704abb3474460069ec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/ratatui-relu/releases/download/v0.11.0/ratatui-relu-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2775b27e7227e072503e24379ae337ecd5593cc7c72990d6643b711ec466061c"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
      bin.install "ratatui-relu"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "ratatui-relu"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "ratatui-relu"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "ratatui-relu"
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
