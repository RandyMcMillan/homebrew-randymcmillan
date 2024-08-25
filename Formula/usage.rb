class Usage < Formula
  desc "Example: usage of mempool_space"
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.33"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.33/usage-aarch64-apple-darwin.tar.xz"
      sha256 "6628c2957d38f06f6ad2edeb69cad594b8dc1c21883afef68b58d27563765b66"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.33/usage-x86_64-apple-darwin.tar.xz"
      sha256 "461905b62c9e0616e1556b53bb29b0fe84ee6142fc65b741a44ab66f570925d2"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.33/usage-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a8a84bdaadd1e56e0cf5c470755747bd2f87e5cba3e8c74ca710ff205e0bcdd7"
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
