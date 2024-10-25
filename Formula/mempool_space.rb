class MempoolSpace < Formula
  desc "mempool.space api interface."
  homepage "https://github.com/randymcmillan/mempool_space"
  version "0.0.58"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.58/mempool_space-aarch64-apple-darwin.tar.xz"
      sha256 "dd85e6e5c2f98a57ed1d2448cca4619f536d5c6ee6d67c133f1e0e8797a86400"
    end
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.58/mempool_space-x86_64-apple-darwin.tar.xz"
      sha256 "1ad5cdb6b7a33469153c16671c40e78efb49d2c58fb30ffa63e0108c7e28327d"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/randymcmillan/mempool_space/releases/download/v0.0.58/mempool_space-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "9f4cd7002756ff3464b6c3099980ee9b57a29e565cb046bda5ff0407c0f77ab1"
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
      bin.install "mempool-space", "mempool-space_address", "mempool-space_address_txs", "mempool-space_address_txs_chain", "mempool-space_address_txs_mempool", "mempool-space_address_utxo", "mempool-space_block", "mempool-space_block_audit_summary", "mempool-space_block_feerates", "mempool-space_block_header", "mempool-space_block_height", "mempool-space_block_predictions", "mempool-space_block_raw", "mempool-space_block_rewards", "mempool-space_block_sizes_and_weights", "mempool-space_block_status", "mempool-space_block_txid", "mempool-space_block_txids", "mempool-space_block_txs", "mempool-space_blocks", "mempool-space_blocks_audit_score", "mempool-space_blocks_audit_scores", "mempool-space_blocks_bulk", "mempool-space_blocks_timestamp", "mempool-space_blocks_tip_hash", "mempool-space_blocks_tip_height", "mempool-space_children_pay_for_parent", "mempool-space_difficulty_adjustment", "mempool-space_difficulty_adjustments", "mempool-space_fees_mempool_blocks", "mempool-space_fees_recommended", "mempool-space_historical_price", "mempool-space_lightning_channels", "mempool-space_lightning_channels_from_node_pubkey", "mempool-space_lightning_channels_from_txid", "mempool-space_lightning_channels_geo", "mempool-space_lightning_channels_geodata", "mempool-space_lightning_node_stats", "mempool-space_lightning_node_stats_per_country", "mempool-space_lightning_nodes", "mempool-space_lightning_nodes_channels", "mempool-space_lightning_nodes_in_country", "mempool-space_lightning_nodes_isp_ranking", "mempool-space_lightning_nodes_ranking", "mempool-space_lightning_nodes_ranking_age", "mempool-space_lightning_nodes_ranking_connectivity", "mempool-space_lightning_nodes_ranking_liquidity", "mempool-space_lightning_nodes_statistics", "mempool-space_lightning_nodes_stats_per_isp", "mempool-space_lightning_search", "mempool-space_lightning_statistics", "mempool-space_lightning_top_nodes_by_connectivity", "mempool-space_lightning_top_nodes_by_liquidity", "mempool-space_lightning_top_oldests_nodes", "mempool-space_mempool", "mempool-space_mempool_full_rbf_transactions", "mempool-space_mempool_rbf_transactions", "mempool-space_mempool_recent", "mempool-space_mining_blocks_timestamp", "mempool-space_mining_hashrate", "mempool-space_mining_hashrate_pools", "mempool-space_mining_pool", "mempool-space_mining_pool_blocks", "mempool-space_mining_pool_hashrate", "mempool-space_mining_pools", "mempool-space_mining_reward_stats", "mempool-space_post_transaction", "mempool-space_prices", "mempool-space_reachable", "mempool-space_transaction", "mempool-space_transaction_hex", "mempool-space_transaction_merkle_block_proof", "mempool-space_transaction_merkle_proof", "mempool-space_transaction_outspend", "mempool-space_transaction_outspends", "mempool-space_transaction_raw", "mempool-space_transaction_rbf_timeline", "mempool-space_transaction_status", "mempool-space_transaction_times", "mempool-space_validate_address"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "mempool-space", "mempool-space_address", "mempool-space_address_txs", "mempool-space_address_txs_chain", "mempool-space_address_txs_mempool", "mempool-space_address_utxo", "mempool-space_block", "mempool-space_block_audit_summary", "mempool-space_block_feerates", "mempool-space_block_header", "mempool-space_block_height", "mempool-space_block_predictions", "mempool-space_block_raw", "mempool-space_block_rewards", "mempool-space_block_sizes_and_weights", "mempool-space_block_status", "mempool-space_block_txid", "mempool-space_block_txids", "mempool-space_block_txs", "mempool-space_blocks", "mempool-space_blocks_audit_score", "mempool-space_blocks_audit_scores", "mempool-space_blocks_bulk", "mempool-space_blocks_timestamp", "mempool-space_blocks_tip_hash", "mempool-space_blocks_tip_height", "mempool-space_children_pay_for_parent", "mempool-space_difficulty_adjustment", "mempool-space_difficulty_adjustments", "mempool-space_fees_mempool_blocks", "mempool-space_fees_recommended", "mempool-space_historical_price", "mempool-space_lightning_channels", "mempool-space_lightning_channels_from_node_pubkey", "mempool-space_lightning_channels_from_txid", "mempool-space_lightning_channels_geo", "mempool-space_lightning_channels_geodata", "mempool-space_lightning_node_stats", "mempool-space_lightning_node_stats_per_country", "mempool-space_lightning_nodes", "mempool-space_lightning_nodes_channels", "mempool-space_lightning_nodes_in_country", "mempool-space_lightning_nodes_isp_ranking", "mempool-space_lightning_nodes_ranking", "mempool-space_lightning_nodes_ranking_age", "mempool-space_lightning_nodes_ranking_connectivity", "mempool-space_lightning_nodes_ranking_liquidity", "mempool-space_lightning_nodes_statistics", "mempool-space_lightning_nodes_stats_per_isp", "mempool-space_lightning_search", "mempool-space_lightning_statistics", "mempool-space_lightning_top_nodes_by_connectivity", "mempool-space_lightning_top_nodes_by_liquidity", "mempool-space_lightning_top_oldests_nodes", "mempool-space_mempool", "mempool-space_mempool_full_rbf_transactions", "mempool-space_mempool_rbf_transactions", "mempool-space_mempool_recent", "mempool-space_mining_blocks_timestamp", "mempool-space_mining_hashrate", "mempool-space_mining_hashrate_pools", "mempool-space_mining_pool", "mempool-space_mining_pool_blocks", "mempool-space_mining_pool_hashrate", "mempool-space_mining_pools", "mempool-space_mining_reward_stats", "mempool-space_post_transaction", "mempool-space_prices", "mempool-space_reachable", "mempool-space_transaction", "mempool-space_transaction_hex", "mempool-space_transaction_merkle_block_proof", "mempool-space_transaction_merkle_proof", "mempool-space_transaction_outspend", "mempool-space_transaction_outspends", "mempool-space_transaction_raw", "mempool-space_transaction_rbf_timeline", "mempool-space_transaction_status", "mempool-space_transaction_times", "mempool-space_validate_address"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "mempool-space", "mempool-space_address", "mempool-space_address_txs", "mempool-space_address_txs_chain", "mempool-space_address_txs_mempool", "mempool-space_address_utxo", "mempool-space_block", "mempool-space_block_audit_summary", "mempool-space_block_feerates", "mempool-space_block_header", "mempool-space_block_height", "mempool-space_block_predictions", "mempool-space_block_raw", "mempool-space_block_rewards", "mempool-space_block_sizes_and_weights", "mempool-space_block_status", "mempool-space_block_txid", "mempool-space_block_txids", "mempool-space_block_txs", "mempool-space_blocks", "mempool-space_blocks_audit_score", "mempool-space_blocks_audit_scores", "mempool-space_blocks_bulk", "mempool-space_blocks_timestamp", "mempool-space_blocks_tip_hash", "mempool-space_blocks_tip_height", "mempool-space_children_pay_for_parent", "mempool-space_difficulty_adjustment", "mempool-space_difficulty_adjustments", "mempool-space_fees_mempool_blocks", "mempool-space_fees_recommended", "mempool-space_historical_price", "mempool-space_lightning_channels", "mempool-space_lightning_channels_from_node_pubkey", "mempool-space_lightning_channels_from_txid", "mempool-space_lightning_channels_geo", "mempool-space_lightning_channels_geodata", "mempool-space_lightning_node_stats", "mempool-space_lightning_node_stats_per_country", "mempool-space_lightning_nodes", "mempool-space_lightning_nodes_channels", "mempool-space_lightning_nodes_in_country", "mempool-space_lightning_nodes_isp_ranking", "mempool-space_lightning_nodes_ranking", "mempool-space_lightning_nodes_ranking_age", "mempool-space_lightning_nodes_ranking_connectivity", "mempool-space_lightning_nodes_ranking_liquidity", "mempool-space_lightning_nodes_statistics", "mempool-space_lightning_nodes_stats_per_isp", "mempool-space_lightning_search", "mempool-space_lightning_statistics", "mempool-space_lightning_top_nodes_by_connectivity", "mempool-space_lightning_top_nodes_by_liquidity", "mempool-space_lightning_top_oldests_nodes", "mempool-space_mempool", "mempool-space_mempool_full_rbf_transactions", "mempool-space_mempool_rbf_transactions", "mempool-space_mempool_recent", "mempool-space_mining_blocks_timestamp", "mempool-space_mining_hashrate", "mempool-space_mining_hashrate_pools", "mempool-space_mining_pool", "mempool-space_mining_pool_blocks", "mempool-space_mining_pool_hashrate", "mempool-space_mining_pools", "mempool-space_mining_reward_stats", "mempool-space_post_transaction", "mempool-space_prices", "mempool-space_reachable", "mempool-space_transaction", "mempool-space_transaction_hex", "mempool-space_transaction_merkle_block_proof", "mempool-space_transaction_merkle_proof", "mempool-space_transaction_outspend", "mempool-space_transaction_outspends", "mempool-space_transaction_raw", "mempool-space_transaction_rbf_timeline", "mempool-space_transaction_status", "mempool-space_transaction_times", "mempool-space_validate_address"
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
