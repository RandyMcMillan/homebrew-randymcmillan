class MempoolSpace < Formula
  desc "mempool.space api interface."
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.46"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.46/mempool_space-aarch64-apple-darwin.tar.xz"
      sha256 "5c92f3d279bec6d45d2e2b42699c643af14dd53e6d352bf0706df6e5a3dc189b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.46/mempool_space-x86_64-apple-darwin.tar.xz"
      sha256 "853709c08120ec735b5d63332bfcff9fa7a1f4c2a75c5dea37d752d3e7c0a6eb"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.46/mempool_space-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cbeaa297ad649aa9ae80b9f4faae7204e8fb842696ca6f61f5df873a61d496a4"
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
      bin.install "lightning-search", "mempool-space", "mempool-space_address", "mempool-space_address_txs", "mempool-space_address_txs_chain", "mempool-space_address_txs_mempool", "mempool-space_address_utxo", "mempool-space_block", "mempool-space_block_audit_summary", "mempool-space_block_feerates", "mempool-space_block_header", "mempool-space_block_height", "mempool-space_block_predictions", "mempool-space_block_raw", "mempool-space_block_rewards", "mempool-space_block_sizes_and_weights", "mempool-space_block_status", "mempool-space_block_txid", "mempool-space_block_txids", "mempool-space_block_txs", "mempool-space_blocks", "mempool-space_blocks_audit_score", "mempool-space_blocks_audit_scores", "mempool-space_blocks_bulk", "mempool-space_blocks_timestamp", "mempool-space_blocks_tip_hash", "mempool-space_blocks_tip_height", "mempool-space_children_pay_for_parent", "mempool-space_dashboard", "mempool-space_difficulty_adjustment", "mempool-space_difficulty_adjustments", "mempool-space_fees_mempool_blocks", "mempool-space_fees_recommended", "mempool-space_historical_price", "mempool-space_lightning_channels", "mempool-space_lightning_channels_from_node_pubkey", "mempool-space_lightning_channels_from_txid", "mempool-space_lightning_channels_geo", "mempool-space_lightning_channels_geodata", "mempool-space_lightning_node_stats", "mempool-space_lightning_node_stats_per_country", "mempool-space_lightning_nodes", "mempool-space_lightning_nodes_channels", "mempool-space_lightning_nodes_in_country", "mempool-space_lightning_nodes_isp_ranking", "mempool-space_lightning_nodes_ranking", "mempool-space_lightning_nodes_ranking_age", "mempool-space_lightning_nodes_ranking_connectivity", "mempool-space_lightning_nodes_ranking_liquidity", "mempool-space_lightning_nodes_statistics", "mempool-space_lightning_nodes_stats_per_isp", "mempool-space_lightning_search", "mempool-space_lightning_statistics", "mempool-space_lightning_top_nodes_by_connectivity", "mempool-space_lightning_top_nodes_by_liquidity", "mempool-space_lightning_top_oldests_nodes", "mempool-space_mempool", "mempool-space_mempool_full_rbf_transactions", "mempool-space_mempool_rbf_transactions", "mempool-space_mempool_recent", "mempool-space_mining_blocks_timestamp", "mempool-space_mining_hashrate", "mempool-space_mining_hashrate_pools", "mempool-space_mining_pool", "mempool-space_mining_pool_blocks", "mempool-space_mining_pool_hashrate", "mempool-space_mining_pools", "mempool-space_mining_reward_stats", "mempool-space_post_transaction", "mempool-space_prices", "mempool-space_reachable", "mempool-space_splash", "mempool-space_transaction", "mempool-space_transaction_hex", "mempool-space_transaction_merkle_block_proof", "mempool-space_transaction_merkle_proof", "mempool-space_transaction_outspend", "mempool-space_transaction_outspends", "mempool-space_transaction_raw", "mempool-space_transaction_rbf_timeline", "mempool-space_transaction_status", "mempool-space_transaction_times", "mempool-space_validate_address"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "lightning-search", "mempool-space", "mempool-space_address", "mempool-space_address_txs", "mempool-space_address_txs_chain", "mempool-space_address_txs_mempool", "mempool-space_address_utxo", "mempool-space_block", "mempool-space_block_audit_summary", "mempool-space_block_feerates", "mempool-space_block_header", "mempool-space_block_height", "mempool-space_block_predictions", "mempool-space_block_raw", "mempool-space_block_rewards", "mempool-space_block_sizes_and_weights", "mempool-space_block_status", "mempool-space_block_txid", "mempool-space_block_txids", "mempool-space_block_txs", "mempool-space_blocks", "mempool-space_blocks_audit_score", "mempool-space_blocks_audit_scores", "mempool-space_blocks_bulk", "mempool-space_blocks_timestamp", "mempool-space_blocks_tip_hash", "mempool-space_blocks_tip_height", "mempool-space_children_pay_for_parent", "mempool-space_dashboard", "mempool-space_difficulty_adjustment", "mempool-space_difficulty_adjustments", "mempool-space_fees_mempool_blocks", "mempool-space_fees_recommended", "mempool-space_historical_price", "mempool-space_lightning_channels", "mempool-space_lightning_channels_from_node_pubkey", "mempool-space_lightning_channels_from_txid", "mempool-space_lightning_channels_geo", "mempool-space_lightning_channels_geodata", "mempool-space_lightning_node_stats", "mempool-space_lightning_node_stats_per_country", "mempool-space_lightning_nodes", "mempool-space_lightning_nodes_channels", "mempool-space_lightning_nodes_in_country", "mempool-space_lightning_nodes_isp_ranking", "mempool-space_lightning_nodes_ranking", "mempool-space_lightning_nodes_ranking_age", "mempool-space_lightning_nodes_ranking_connectivity", "mempool-space_lightning_nodes_ranking_liquidity", "mempool-space_lightning_nodes_statistics", "mempool-space_lightning_nodes_stats_per_isp", "mempool-space_lightning_search", "mempool-space_lightning_statistics", "mempool-space_lightning_top_nodes_by_connectivity", "mempool-space_lightning_top_nodes_by_liquidity", "mempool-space_lightning_top_oldests_nodes", "mempool-space_mempool", "mempool-space_mempool_full_rbf_transactions", "mempool-space_mempool_rbf_transactions", "mempool-space_mempool_recent", "mempool-space_mining_blocks_timestamp", "mempool-space_mining_hashrate", "mempool-space_mining_hashrate_pools", "mempool-space_mining_pool", "mempool-space_mining_pool_blocks", "mempool-space_mining_pool_hashrate", "mempool-space_mining_pools", "mempool-space_mining_reward_stats", "mempool-space_post_transaction", "mempool-space_prices", "mempool-space_reachable", "mempool-space_splash", "mempool-space_transaction", "mempool-space_transaction_hex", "mempool-space_transaction_merkle_block_proof", "mempool-space_transaction_merkle_proof", "mempool-space_transaction_outspend", "mempool-space_transaction_outspends", "mempool-space_transaction_raw", "mempool-space_transaction_rbf_timeline", "mempool-space_transaction_status", "mempool-space_transaction_times", "mempool-space_validate_address"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "lightning-search", "mempool-space", "mempool-space_address", "mempool-space_address_txs", "mempool-space_address_txs_chain", "mempool-space_address_txs_mempool", "mempool-space_address_utxo", "mempool-space_block", "mempool-space_block_audit_summary", "mempool-space_block_feerates", "mempool-space_block_header", "mempool-space_block_height", "mempool-space_block_predictions", "mempool-space_block_raw", "mempool-space_block_rewards", "mempool-space_block_sizes_and_weights", "mempool-space_block_status", "mempool-space_block_txid", "mempool-space_block_txids", "mempool-space_block_txs", "mempool-space_blocks", "mempool-space_blocks_audit_score", "mempool-space_blocks_audit_scores", "mempool-space_blocks_bulk", "mempool-space_blocks_timestamp", "mempool-space_blocks_tip_hash", "mempool-space_blocks_tip_height", "mempool-space_children_pay_for_parent", "mempool-space_dashboard", "mempool-space_difficulty_adjustment", "mempool-space_difficulty_adjustments", "mempool-space_fees_mempool_blocks", "mempool-space_fees_recommended", "mempool-space_historical_price", "mempool-space_lightning_channels", "mempool-space_lightning_channels_from_node_pubkey", "mempool-space_lightning_channels_from_txid", "mempool-space_lightning_channels_geo", "mempool-space_lightning_channels_geodata", "mempool-space_lightning_node_stats", "mempool-space_lightning_node_stats_per_country", "mempool-space_lightning_nodes", "mempool-space_lightning_nodes_channels", "mempool-space_lightning_nodes_in_country", "mempool-space_lightning_nodes_isp_ranking", "mempool-space_lightning_nodes_ranking", "mempool-space_lightning_nodes_ranking_age", "mempool-space_lightning_nodes_ranking_connectivity", "mempool-space_lightning_nodes_ranking_liquidity", "mempool-space_lightning_nodes_statistics", "mempool-space_lightning_nodes_stats_per_isp", "mempool-space_lightning_search", "mempool-space_lightning_statistics", "mempool-space_lightning_top_nodes_by_connectivity", "mempool-space_lightning_top_nodes_by_liquidity", "mempool-space_lightning_top_oldests_nodes", "mempool-space_mempool", "mempool-space_mempool_full_rbf_transactions", "mempool-space_mempool_rbf_transactions", "mempool-space_mempool_recent", "mempool-space_mining_blocks_timestamp", "mempool-space_mining_hashrate", "mempool-space_mining_hashrate_pools", "mempool-space_mining_pool", "mempool-space_mining_pool_blocks", "mempool-space_mining_pool_hashrate", "mempool-space_mining_pools", "mempool-space_mining_reward_stats", "mempool-space_post_transaction", "mempool-space_prices", "mempool-space_reachable", "mempool-space_splash", "mempool-space_transaction", "mempool-space_transaction_hex", "mempool-space_transaction_merkle_block_proof", "mempool-space_transaction_merkle_proof", "mempool-space_transaction_outspend", "mempool-space_transaction_outspends", "mempool-space_transaction_raw", "mempool-space_transaction_rbf_timeline", "mempool-space_transaction_status", "mempool-space_transaction_times", "mempool-space_validate_address"
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
