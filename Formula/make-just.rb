class MakeJust < Formula
  desc "The make-just application"
  homepage "https://github.com/randymcmillan/make-just"
  version "0.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.4/make-just-aarch64-apple-darwin.tar.xz"
      sha256 "3715fb96bc4342a56370a87b853af7406583fc57dd7c76d47bc3a7a3fc60a29e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.4/make-just-x86_64-apple-darwin.tar.xz"
      sha256 "945f0e5689b19a1d3244387d69118d012a495a0bb3c555fc027fd3d5b34edca5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.4/make-just-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "30ca99752f3b6bf4bb4d66e6c1bc6a8a5303d7606ac37384f61b350776c9535e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/make-just/releases/download/v0.0.4/make-just-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2d4af818eca5fc3b89d1e3b1cd7e5a61d1a4caedb681d96b546c811a34f29806"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    bin.install "make-just" if OS.mac? && Hardware::CPU.arm?
    bin.install "make-just" if OS.mac? && Hardware::CPU.intel?
    bin.install "make-just" if OS.linux? && Hardware::CPU.arm?
    bin.install "make-just" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
