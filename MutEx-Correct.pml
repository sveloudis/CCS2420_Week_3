/*
In this solution, the process which manages to set the global var turn first is the 
one to enter the critical section first. Thereafter, the processes enter the critical 
section in alternation. In fact, this solution is a variation of Peterson's algorithm
*/


byte turn = 0; // shared variable to determine whose turn it is to enter critical section
int value = 0;

proctype process1() {
  do
  :: true -> // loop indefinitely
    // non-critical section
    printf("Process 1 in non-critical section\n");
    // request to enter critical section
    turn = 1;
    do
      // busy-wait until process 2 finishes its turn
      :: turn == 0 -> break;
      :: else -> skip;
      od
    // critical section
    printf("Process 1 in critical section\n");
    value++;value--;
    // release critical section
    //turn = 0;
  od
}

proctype process2() {
  do
  :: true -> // loop indefinitely
    // non-critical section
    printf("Process 2 in non-critical section\n");
    // request to enter critical section
    turn = 0;
    do
      // busy-wait until process 1 finishes its turn
      :: turn == 1 -> break;
      :: else -> skip;
      od
    // critical section
    printf("Process 2 in critical section\n");
    // release critical section
    value++;value--;
    //turn = 1;
  od
}

init {
  run process1();
  run process2();

 // do 
//	:: true -> assert(value >= 0 && value <= 1)
//  od
}

ltl p {[](value == 0 || value == 1)}
