# How many new outputs were created by block 123,456?
block="123456"
# bitcoin-cli getblockstats "$block" '[ "utxo_increase" ]' | jq '.utxo_increase'
hash=$(bitcoin-cli getblockhash $block)
#txList=$(bitcoin-cli getblock $hash  | jq -r '.tx[]' )

# foreach transaction on the block count how many outputs there is
count=0
for tx in $(bitcoin-cli getblock $hash | jq -r '.tx[]'); do
    n=$(bitcoin-cli getrawtransaction $tx true | jq -r '.vout | length')
    ((count=count+n))
done

echo $count
