class KuboRs < Formula
  desc "Rust bindings for Kubo (IPFS in Go) via CGO/FFI"
  homepage "https://github.com/RandyMcMillan/kubo-rs"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.7.0/kubo-rs-aarch64-apple-darwin.tar.xz"
      sha256 "a364c45b0ac5c87aa24ca6c2c13b5cf1e361b3c0c8f6f412f1dab8d93da2f03c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.7.0/kubo-rs-x86_64-apple-darwin.tar.xz"
      sha256 "7ed03365cc374e54dd45f1249f75daf50983701387c941c0bcb023a0d010a82c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.7.0/kubo-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "db439369a0c1e68c852a0d8d890efc4eb5418e258bd163976b7748e1c851c598"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.7.0/kubo-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "248d3de17f64ac59436c951d6edd046f7a4e867a81dbb3e5c310888ff6904f6f"
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
