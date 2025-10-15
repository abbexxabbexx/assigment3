# assigment3

Task1:
Here, the entire program is written in Assembly. Eight integer values are stored in the .data section, and the program calculates their average using a custom subroutine. All numbers are summed inside a loop, and the result is divided by eight using bit shifting, since the ARMv6-M processor has no hardware division instruction. The calculated average is then printed forever to the terminal using printf in an infinite loop. This task shows how to work with loops, subroutines, and parameter passing in assembly, as well as how to handle data and perform basic output through stdio.

Task2:
Here, the main focus we shifts to C programming combined with hardware control. Two LEDs are connected to GP0 and GP1, and two push buttons are connected to GP2 and GP3. When the button on GP3 is pressed, both LEDs turn on, when the button on GP2 is pressed, both LEDs turn off. If both buttons are pressed at the same time, the signal is ignored. The program uses internal pull/ups, meaning the buttons are active low (they send a signal 0 when pressed). Instead of constantly checking the buttons, the program relies on interrupts each button press triggers a callback function that updates the LED states. This approach makes the system more efficient and responsive without continuously polling the inputs.
