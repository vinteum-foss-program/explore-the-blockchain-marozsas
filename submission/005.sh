# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`


tx='37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517'

#alternate
#rawtx=$(bitcoin-cli getrawtransaction "$tx" )
# bitcoin-cli decoderawtransaction "$rawtx" | jq '.vin'


addr_array="["
for txwit in $(bitcoin-cli getrawtransaction "$tx" true | jq  '.vin[].txinwitness[1]' ); do
    #echo $txwit;
    addr_array="${addr_array}${txwit},"
done
addr_array="${addr_array%,} ]"
#echo $addr_array

eval bitcoin-cli createmultisig 1 "'${addr_array}'" | jq -r '.address'

