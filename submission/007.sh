# Only one single output remains unspent from block 123,321. What address was it sent to?


blk="123321"
hash=$(bitcoin-cli getblockhash $blk)
# iterate over  the list of transactions of block
for tx in $(bitcoin-cli getblock $hash | jq -r '.tx[]'); do
    # get the number of outputs in a transaction
    ntx=$(bitcoin-cli getrawtransaction $tx true | jq -r '.vout | length')
    # echo "DEBUG "$ntx""
    ((ntx=ntx - 1))
    # for each transactiob, iterates over the outputs
    for i in $(seq 0 $ntx); do
        result=$(bitcoin-cli gettxout "$tx" $i)
        if [ "$result" != "" ]; then
            break 2
        fi
    done
done

echo "$result" | jq -r '.scriptPubKey.address'
