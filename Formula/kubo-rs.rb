class KuboRs < Formula
  desc "Rust bindings for Kubo (IPFS in Go) via CGO/FFI"
  homepage "https://github.com/RandyMcMillan/kubo-rs"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.3.0/kubo-rs-aarch64-apple-darwin.tar.xz"
      sha256 "c74208bddcf7e36fa199ca8ce2d95e4c3b002db6b2da62cf9aa9feff60aa400b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.3.0/kubo-rs-x86_64-apple-darwin.tar.xz"
      sha256 "e29ceef27a18fcffd508ad06e1837c5328af783e26e5be6afcbc0628a28405e8"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.3.0/kubo-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a3b25169df7fe80c8f329da18b768c37b558248833a6a702b7c2055b3463ac9d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.3.0/kubo-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "3388e39e9f035b0a3c280d36aa36a2378f24cd87eda20afd17d934aa694ab821"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
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
      bin.install "kubo-rs"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "kubo-rs"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "kubo-rs"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "kubo-rs"
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
