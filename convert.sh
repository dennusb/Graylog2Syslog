count=0
host="<hostnamehere>"
curl -s "http://$host:12900/search/universal/relative?query=*&range=300" -u admin:test > myjson.json
while [ $count -lt 10000 ]
        do
        fullmsg=`cat myjson.json | jq '.messages['$count'].message.full_message' | sed -e 's/^"//'  -e 's/"$//'`
        timestamp=`cat myjson.json | jq '.messages['$count'].message.timestamp' | sed -e 's/^"//'  -e 's/"$//'`
        source=`cat myjson.json | jq '.messages['$count'].message.source' | sed -e 's/^"//'  -e 's/"$//'`
        if [[ ! -s myjson.json ]] ; then
                echo "File leeg!"
                exit
        fi
        if [ "$fullmsg" == "null" ]; then
                if [ "$count" -eq 0 ]; then
                        echo "Doei"
                fi
                exit
        else
                echo $timestamp $source $fullmsg
                echo $timestamp $source $fullmsg >> test.txt
        fi
        count=$[$count+1]
done