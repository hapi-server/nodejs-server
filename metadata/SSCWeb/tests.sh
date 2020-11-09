S1=http://localhost:8999/SSCWeb/hapi/
S2=http://hapi-server.org/servers/SSCWeb/hapi/


echo "--"
curl $S1"data?id=cluster1&parameters=&time.min=2006-07-18T00:00:30.000Z&time.max=2006-07-18T00:01:00.000Z"
echo "++"
curl $S2"data?id=cluster1&parameters=&time.min=2006-07-18T00:00:30.000Z&time.max=2006-07-18T00:01:00.000Z"
echo "--"

echo ""

exit 0

echo "--"
curl $S1"data?id=ace&parameters=&time.min=2000-07-18T00:00:00.000Z&time.max=2000-07-18T00:12:00.000Z"
echo "++"
curl $S2"data?id=ace&parameters=&time.min=2000-07-18T00:00:00.000Z&time.max=2000-07-18T00:12:00.000Z"
echo "--"

echo ""

exit 0

echo "--"
curl $S1"data?id=ace&parameters=&time.min=2000-01-01T00:11:00.000Z&time.max=2000-01-01T00:12:00.000Z"
echo "++"
curl $S2"data?id=ace&parameters=&time.min=2000-01-01T00:11:00.000Z&time.max=2000-01-01T00:12:00.000Z"
echo "--"

echo ""


echo "--"
curl $S1"data?id=ace&parameters=Time&time.min=2000-01-01T00:00:00.000Z&time.max=2000-01-01T00:23:59.999Z"
echo "++"
curl $S2"data?id=ace&parameters=Time&time.min=2000-01-01T00:00:00.000Z&time.max=2000-01-01T00:23:59.999Z"
echo "--"

echo ""

echo "--"
curl $S1"data?id=ace&parameters=Time&time.min=2000-01-01T00:00:00.000Z&time.max=2000-01-01T00:24:00.000Z"
echo "++"
curl $S2"data?id=ace&parameters=Time&time.min=2000-01-01T00:00:00.000Z&time.max=2000-01-01T00:24:00.000Z"
echo "--"

echo ""

echo "--"
curl $S1"data?id=ace&parameters=Time&time.min=2000-01-01T00:00:00.000Z&time.max=2000-01-01T00:25:00.000Z"
echo "++"
curl $S2"data?id=ace&parameters=Time&time.min=2000-01-01T00:00:00.000Z&time.max=2000-01-01T00:25:00.000Z"
echo "--"
