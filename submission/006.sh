# Which tx in block 257,343 spends the coinbase output of block 256,128?

srcblk="256128"
#echo "DEBUG: on source block: $srcblk"
srchash=$(bitcoin-cli getblockhash $srcblk)
# get the first transaction of source block
tx=$(bitcoin-cli getblock $srchash | jq -r '.tx[0]')
# echo "DEBUG: tx: $tx"
#coinbase=$(bitcoin-cli getrawtransaction $tx true | jq -r '.vin[].coinbase')
# for the first vin in transaction, check if it is a coinbase tx and break the loop if founded
coinbase=$(bitcoin-cli getrawtransaction $tx true | jq -r '.vin[0].coinbase')
if [ "$coinbase" == "null" ]; then
    echo "error: there is no coinbase transaction on block ${srcblk}"
    exit 1
fi

# txid is the transaction we want to find on the dstblkk
txid="${tx}"
#echo "DEBUG: txid:${txid}"

#address=$(bitcoin-cli getrawtransaction $tx true | jq -r '.vout[0].scriptPubKey.address')
#value=$(bitcoin-cli getrawtransaction $tx true | jq -r '.vout[0].value')
#echo "DEBUG: address:${address}, value:${value}"

dstblk=257343
#echo "DEBUG: on dstblk: $dstblk"
dsthash=$(bitcoin-cli getblockhash $dstblk)
# iterate over all transactions on dstblk
for tx in $(bitcoin-cli getblock $dsthash | jq -r '.tx[]'); do
    #echo "DEBUG: tx:$tx"
    # on the input side of transaction, get every txid
    for txin in $(bitcoin-cli getrawtransaction $tx true | jq -r '.vin[].txid'); do
        #echo "DEBUG: txin:${txin}"
        if [ "${txid}" == "${txin}" ]; then
            #echo "Found on ${tx}"
            echo "${tx}"
            break 2 # break the 2 for-loops
        fi
    done
done
