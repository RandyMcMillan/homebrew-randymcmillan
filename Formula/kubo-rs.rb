class KuboRs < Formula
  desc "Rust bindings for Kubo (IPFS in Go) via CGO/FFI"
  homepage "https://github.com/RandyMcMillan/kubo-rs"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.5.0/kubo-rs-aarch64-apple-darwin.tar.xz"
      sha256 "800022084de15f7f743526f38dcb0388b6a667448f22f44fb0b8892987f9e45c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.5.0/kubo-rs-x86_64-apple-darwin.tar.xz"
      sha256 "e1f238b18e8ff9adc0e36a953fc846bb328f891bd884029e9a1eabbad7b73c06"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.5.0/kubo-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "179d0c4783c95aae4311ab74be5df4ef4b7cd9ed67d94331a69c88c3c319c87c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.5.0/kubo-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1d122d9455ba0ae8b7ca0c16e57cdfad3098cc40495d144249222aaefbf61089"
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
