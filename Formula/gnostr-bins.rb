class GnostrBins < Formula
  desc "gnostr: a git+nostr workflow utility"
  homepage "https://github.com/gnostr-org/gnostr-bins"
  version "0.0.72"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gnostr-org/gnostr-bins/releases/download/v0.0.72/gnostr-bins-aarch64-apple-darwin.tar.xz"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gnostr-org/gnostr-bins/releases/download/v0.0.72/gnostr-bins-x86_64-apple-darwin.tar.xz"
      sha256 "18dc994b94ea866354f20066f9597faf97c797e6642e06be6aa631a0fad5f2a3"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/gnostr-org/gnostr-bins/releases/download/v0.0.72/gnostr-bins-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "4f6b9b46e0cd0af0e16bbe3da7437175acdab18ace4a014e5b661832fba03b68"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
      bin.install "bech32_to_any", "create_event", "create_event_raw", "create_giftwrap", "create_nevent",
"decrypt_private_key", "dump_relay", "dump_relay_with_login", "encrypt_private_key", "fetch_by_filter", "fetch_by_id", "fetch_by_id_with_login", "fetch_by_kind_and_author", "fetch_by_kind_and_author_limit", "fetch_by_kind_and_author_with_login", "fetch_giftwraps", "fetch_metadata", "fetch_nip11", "fetch_relay_list", "form_naddr", "generate_keypair", "gnostr-add", "gnostr-bech32-to-any", "gnostr-blame", "gnostr-blockhash", "gnostr-blockheight", "gnostr-cat-file", "gnostr-cli-example", "gnostr-clone", "gnostr-decrypt-private_key", "gnostr-diff", "gnostr-dump-relay", "gnostr-encrypt-private_key", "gnostr-fetch", "gnostr-fetch-by-id", "gnostr-fetch-by-kind-and-author", "gnostr-fetch-metadata", "gnostr-fetch-nip11", "gnostr-fetch-pubkey-relays", "gnostr-fetch-relay-list", "gnostr-fetch-watch-list", "gnostr-fetch-watch-list-iterator", "gnostr-form-event-addr", "gnostr-generate-keypair", "gnostr-get-relays", "gnostr-hash", "gnostr-init", "gnostr-ls-remote", "gnostr-objects", "gnostr-pi", "gnostr-post-event", "gnostr-privkey-to-bech32", "gnostr-pubkey-to-bech32", "gnostr-pull", "gnostr-reflog", "gnostr-rev-list", "gnostr-rev-parse", "gnostr-sha256", "gnostr-state", "gnostr-status", "gnostr-tag", "gnostr-verify-keypair", "gnostr-weeble", "gnostr-wobble", "gnostr-xor", "id_to_bech32", "post_event", "post_from_files", "privkey_to_bech32", "pubkey_to_bech32", "test_nip46", "test_relay", "verify_event", "verify_keypair"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "bech32_to_any", "create_event", "create_event_raw", "create_giftwrap", "create_nevent",
"decrypt_private_key", "dump_relay", "dump_relay_with_login", "encrypt_private_key", "fetch_by_filter", "fetch_by_id", "fetch_by_id_with_login", "fetch_by_kind_and_author", "fetch_by_kind_and_author_limit", "fetch_by_kind_and_author_with_login", "fetch_giftwraps", "fetch_metadata", "fetch_nip11", "fetch_relay_list", "form_naddr", "generate_keypair", "gnostr-add", "gnostr-bech32-to-any", "gnostr-blame", "gnostr-blockhash", "gnostr-blockheight", "gnostr-cat-file", "gnostr-cli-example", "gnostr-clone", "gnostr-decrypt-private_key", "gnostr-diff", "gnostr-dump-relay", "gnostr-encrypt-private_key", "gnostr-fetch", "gnostr-fetch-by-id", "gnostr-fetch-by-kind-and-author", "gnostr-fetch-metadata", "gnostr-fetch-nip11", "gnostr-fetch-pubkey-relays", "gnostr-fetch-relay-list", "gnostr-fetch-watch-list", "gnostr-fetch-watch-list-iterator", "gnostr-form-event-addr", "gnostr-generate-keypair", "gnostr-get-relays", "gnostr-hash", "gnostr-init", "gnostr-ls-remote", "gnostr-objects", "gnostr-pi", "gnostr-post-event", "gnostr-privkey-to-bech32", "gnostr-pubkey-to-bech32", "gnostr-pull", "gnostr-reflog", "gnostr-rev-list", "gnostr-rev-parse", "gnostr-sha256", "gnostr-state", "gnostr-status", "gnostr-tag", "gnostr-verify-keypair", "gnostr-weeble", "gnostr-wobble", "gnostr-xor", "id_to_bech32", "post_event", "post_from_files", "privkey_to_bech32", "pubkey_to_bech32", "test_nip46", "test_relay", "verify_event", "verify_keypair"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "bech32_to_any", "create_event", "create_event_raw", "create_giftwrap", "create_nevent",
"decrypt_private_key", "dump_relay", "dump_relay_with_login", "encrypt_private_key", "fetch_by_filter", "fetch_by_id", "fetch_by_id_with_login", "fetch_by_kind_and_author", "fetch_by_kind_and_author_limit", "fetch_by_kind_and_author_with_login", "fetch_giftwraps", "fetch_metadata", "fetch_nip11", "fetch_relay_list", "form_naddr", "generate_keypair", "gnostr-add", "gnostr-bech32-to-any", "gnostr-blame", "gnostr-blockhash", "gnostr-blockheight", "gnostr-cat-file", "gnostr-cli-example", "gnostr-clone", "gnostr-decrypt-private_key", "gnostr-diff", "gnostr-dump-relay", "gnostr-encrypt-private_key", "gnostr-fetch", "gnostr-fetch-by-id", "gnostr-fetch-by-kind-and-author", "gnostr-fetch-metadata", "gnostr-fetch-nip11", "gnostr-fetch-pubkey-relays", "gnostr-fetch-relay-list", "gnostr-fetch-watch-list", "gnostr-fetch-watch-list-iterator", "gnostr-form-event-addr", "gnostr-generate-keypair", "gnostr-get-relays", "gnostr-hash", "gnostr-init", "gnostr-ls-remote", "gnostr-objects", "gnostr-pi", "gnostr-post-event", "gnostr-privkey-to-bech32", "gnostr-pubkey-to-bech32", "gnostr-pull", "gnostr-reflog", "gnostr-rev-list", "gnostr-rev-parse", "gnostr-sha256", "gnostr-state", "gnostr-status", "gnostr-tag", "gnostr-verify-keypair", "gnostr-weeble", "gnostr-wobble", "gnostr-xor", "id_to_bech32", "post_event", "post_from_files", "privkey_to_bech32", "pubkey_to_bech32", "test_nip46", "test_relay", "verify_event", "verify_keypair"
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
