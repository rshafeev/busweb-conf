 
#!/usr/bin/env bash

#moc GraphTest.cpp -o moc/GraphTest.moc
#moc DijkstraPathFinderTest.cpp -o moc/DijkstraPathFinderTest.moc
#moc PgCityWaysTest.cpp -o moc/PgCityWaysTest.moc

for FILENAME in *.cpp; do
  moc_name=${FILENAME%%.cpp}.moc
  moc $FILENAME -o moc/$moc_name
  echo $moc_name
done 
