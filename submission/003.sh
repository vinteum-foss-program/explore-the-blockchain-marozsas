# How many new outputs were created by block 123,456?
bitcoin-cli getblockstats 123456 '[ "utxo_increase" ]' | jq '.utxo_increase'
