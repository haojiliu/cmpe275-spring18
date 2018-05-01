echo "registering cluster..."
myip="$(ifconfig | grep -A 1 'en5' | tail -1 | cut -d ':' -f 2 | cut -d ' ' -f 2)"
echo "writing my IP address to registry: $myip"
url="https://cmpe275-spring-18.mybluemix.net/put/$myip"
curl $url
echo "building cluster..."
docker-compose build --no-cache
echo "bringing up all nodes..."
docker-compose up -d
