Command:
gcc signal_demo.c -o signal_demo

Output:
<paste compile output (usually empty if successful)>

Explanation:
This command compiles signal_demo.c using gcc to create an executable program for testing signal handling.

Command:
./signal_demo

Output:
<paste output showing SIGTERM handled and SIGINT exit>

Explanation:
This command runs the program where one child sends SIGTERM after 5 seconds and another sends SIGINT after 10 seconds; the parent handles SIGTERM without exiting and exits gracefully on SIGINT.

