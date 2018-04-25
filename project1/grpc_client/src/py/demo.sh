datadir='/Users/haojiliu/Desktop/cmpe275/mesonet/data/'
for f in $(ls $datadir); do
  echo 'uploading file: ' $datadir$f
  python3 test.py -H '169.254.134.186' -u -f $datadir$f
done
