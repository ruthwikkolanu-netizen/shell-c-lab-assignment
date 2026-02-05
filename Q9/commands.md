Command:
gcc zombie_prevent.c -o zombie_prevent

Output:
<paste compile output (often empty if success)>

Explanation:
This command compiles zombie_prevent.c into an executable using gcc so it can be run and tested.

Command:
./zombie_prevent

Output:
<paste output showing children created and parent cleaned up PIDs>

Explanation:
This command runs the program, creates multiple child processes, and the parent uses wait() to clean up terminated children so they do not remain as zombies.
