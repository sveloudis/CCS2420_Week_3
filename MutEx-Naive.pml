bit flag = 0; // shared variable to determine whose turn it is to enter critical section
int value = 0;

proctype process() {
  do
  :: true -> // loop indefinitely
    // non-critical section
    printf("Process %d in non-critical section\n", _pid);
    // request to enter critical section
    flag != 1;
    flag = 1;
    
    // critical section
    printf("Process %d in critical section\n", _pid);
    value++
    value--
    // release critical section
    flag = 0;
  od
}

init {
  run process();
  run process();

}

ltl p { [](value >= 0 && value <= 1) }
