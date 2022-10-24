cd "/Users/luanmorenomaciel/BitBucket/big-data-on-k8s/apps/ingestion-data-stores"

for i in {1..1000}
do
  echo "init"
  python3.9 cli.py 'strimzi-movies-titles-json'
  echo "end"
done
