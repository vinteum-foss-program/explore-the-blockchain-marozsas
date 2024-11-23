# How many new outputs were created by block 123,456?
block="123456"
# bitcoin-cli getblockstats "$block" '[ "utxo_increase" ]' | jq '.utxo_increase'
hash=$(bitcoin-cli getblockhash $block)
bitcoin-cli getblock $hash  | jq -r '.tx[]' | wc -l


