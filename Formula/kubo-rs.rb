class KuboRs < Formula
  desc "Rust bindings for Kubo (IPFS in Go) via CGO/FFI"
  homepage "https://github.com/RandyMcMillan/kubo-rs"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.8.0/kubo-rs-aarch64-apple-darwin.tar.xz"
      sha256 "ed7506a0d14c4a423df1966b2d2558b4bedf787c714c047f2a236ba9f085f487"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.8.0/kubo-rs-x86_64-apple-darwin.tar.xz"
      sha256 "f9b27ea80ccfca6072e3cfe6b3a08f116914190a281b2626401674533be81eeb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.8.0/kubo-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "96e6432a4cb3123b40fbfd193437a11eac5905fb68ff9fcb1ab58462842e9efc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.8.0/kubo-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "22880f8cd478fa95d1a13926ad2af17a709308891c13e85c9d0c032784598b28"
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
