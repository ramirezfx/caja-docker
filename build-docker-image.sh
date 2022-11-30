echo "TAG (example: kmymoney:latest)"
read tag
sudo docker build -t $tag .
echo "Build finished"
