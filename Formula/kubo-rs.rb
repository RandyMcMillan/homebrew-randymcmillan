class KuboRs < Formula
  desc "Rust bindings for Kubo (IPFS in Go) via CGO/FFI"
  homepage "https://github.com/RandyMcMillan/kubo-rs"
  version "0.8.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.8.1/kubo-rs-aarch64-apple-darwin.tar.xz"
      sha256 "1d5c5a2f1d5a335d2e292acf7c6afc0ddc2bba5d3fe797bf87b3f0cf278adb5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.8.1/kubo-rs-x86_64-apple-darwin.tar.xz"
      sha256 "5fa5b699daf7f2ff3ae05363d9d6fa3a17165e15445e340ac9ad626aadf97f98"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.8.1/kubo-rs-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ae14cd8255e50264f4561c1728f89606e7722a4659aeec332534cca3b69e9de5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/RandyMcMillan/kubo-rs/releases/download/v0.8.1/kubo-rs-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "771a700629f040006053d2038ee43b73a9aa46ef0634bb0ce25d14ba7278c911"
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
