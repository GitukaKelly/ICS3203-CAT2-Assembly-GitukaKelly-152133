# Assembly Programming CAT2 Tasks

This repository contains four assembly programs demonstrating various programming concepts, including control flow, array manipulation, factorial calculations, and port-based simulations.

## Table of Contents
- [Assembly Programming CAT2 Tasks](#assembly-programming-cat2-tasks)
  - [Table of Contents](#table-of-contents)
  - [Task 1: Control Flow and Conditional Logic](#task-1-control-flow-and-conditional-logic)
    - [Key Features:](#key-features)
  - [Task 2: Array Manipulation with Looping and Reversal](#task-2-array-manipulation-with-looping-and-reversal)
    - [Key Features:](#key-features-1)
  - [Task 3: Modular Program with Subroutines for Factorial Calculation](#task-3-modular-program-with-subroutines-for-factorial-calculation)
    - [Key Features:](#key-features-2)
  - [Task 4: Data Monitoring and Control Using Port-Based Simulation](#task-4-data-monitoring-and-control-using-port-based-simulation)
    - [Key Features:](#key-features-3)
  - [Compilation and Execution](#compilation-and-execution)
  - [Insights and Challenges](#insights-and-challenges)

---

## Task 1: Control Flow and Conditional Logic
**Purpose**:  
This program prompts the user for an integer input and classifies it as "POSITIVE," "NEGATIVE," or "ZERO" using branching logic. Both conditional and unconditional jumps are used to handle the classification.

### Key Features:
- Conditional jumps (e.g., `jl`, `jg`) for flow control based on input.
- Unconditional jumps (`jmp`) to streamline program flow.

### Documentation of Task:
**Explanation of Jumps**: The `jl` and `jg` instructions are used for less than and greater than comparisons, respectively, while the `jmp` instruction unconditionally jumps to skip unnecessary checks once a condition has been met.
  

---

## Task 2: Array Manipulation with Looping and Reversal
**Purpose**:  
This program accepts an array of integers (e.g., five values) from the user, reverses the array in place, and outputs the reversed array.

### Key Features:
- No additional memory used for reversal.
- Loop-based approach to swap elements in the array.

### Documentation of Task:
**Reversal Process**: Each step of the reversal is commented, and the logic behind memory manipulation (without using extra memory) is explained in detail. Challenges included directly manipulating memory without additional storage.

---

## Task 3: Modular Program with Subroutines for Factorial Calculation
**Purpose**:  
This program calculates the factorial of a user-provided number using a modular subroutine.

### Key Features:
- Factorial calculation is handled in a subroutine.
- The stack is used to preserve and restore register values.
- The result is stored in a general-purpose register.

### Documentation of Task:
**Register Management**: The stack is used to save registers before calling the subroutine and restore them afterward, ensuring that the main program flow is not disrupted. This showcases an understanding of modular programming and stack operations.

---

## Task 4: Data Monitoring and Control Using Port-Based Simulation
**Purpose**:  
This program simulates a control system that reads a "sensor value" and performs actions such as turning a motor on or off and triggering an alarm based on the input.

### Key Features:
- Uses memory locations to simulate sensor and port-based data.
- Logical comparisons determine motor and alarm statuses.

### Documentation of Task:
**Action Logic**: The sensor value determines which action is performed (motor on/off, alarm triggered). Memory locations are manipulated directly to reflect the motor and alarm statuses, simulating port-based data control.


---

## Compilation and Execution
To compile and run any of the programs:
1. Open an Ubuntu WSL terminal in the project directory.
2. Use the **NASM assembler** to compile the `.asm` file:
   ```bash
   nasm -f elf64 program_name.asm -o program_name.o
3. Link the object file with the system linker:
   ```bash
   ld program_name.o -o program_name

4. Run the compiled program:
   ```bash
   ./program_name

NB: Replace the **program_name** with the actual name of file to each task.

5. To clone this repository to your local machine:
   ```bash
   git clone https://github.com/GitukaKelly/ICS3203-CAT2-Assembly-GitukaKelly-152133.git

## Insights and Challenges

- **Task 1**: Balancing the use of conditional and unconditional jumps required careful planning to ensure program flow remained clear and logical.
  
- **Task 2**: Avoiding additional memory for reversal was challenging, as direct memory manipulation required precise index tracking.
  
- **Task 3**: Managing the stack efficiently during the factorial subroutine was crucial to avoid corrupting register values.
  
- **Task 4**: Simulating port-based control in memory showed the importance of understanding low-level memory management for real-time systems.
