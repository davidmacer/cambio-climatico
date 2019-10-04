hg clone https://bitbucket.org/IslasGECI/misctools
cd misctools
make install
chmod +x ./bin/geci-checkanalyses
export PATH=$PATH:${PWD}/bin
cd ..