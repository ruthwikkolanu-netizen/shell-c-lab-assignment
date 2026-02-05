Command:
./bg_move.sh testdir

Output:
<paste output>

Explanation:
This command runs bg_move.sh on testdir and moves each file into a backup/ folder in the background using &, prints each background PID using $!, and waits for completion using wait.

Command:
ls -l testdir/backup

Output:
<paste output>

Explanation:
This verifies that the files were successfully moved into the backup/ directory.
