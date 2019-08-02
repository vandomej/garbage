# COde

In order to run the RUST code type the folllowing commmands:

- mkdir test
- cd test
- cargo build
- time cargo run

In order to run the Racket code type the following commands:

- cd racket
- mkdir test
- raco exe plain.rkt
- mv plain ./test/plain
- cd test
- time ./plain

In order to run the g code type the following commands:

- cd racket
- cd g
- raco pkg install
- cd ..
- mkdir test
- raco exe main.rkt
- mv main ./test/main
- cd test
- time ./main