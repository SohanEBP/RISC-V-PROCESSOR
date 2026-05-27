# RISC Pipelined Processor — RISC-V Architecture Design in Verilog

A custom RISC-V processor architecture designed and implemented in Verilog featuring both sequential and 5-stage pipelined processor execution models with hazard handling support.

This project demonstrates practical understanding of computer architecture, pipelining, instruction execution, hazard resolution, and hardware design principles through modular Verilog-based processor implementation and simulation.

---

# 🚀 Project Overview

The objective of this project was to design and simulate a RISC-V based processor capable of executing core instruction types while implementing efficient pipelined execution to improve instruction throughput.

The processor supports:
- Arithmetic Instructions
- Logical Instructions
- Memory Access Instructions
- Branch Instructions

The project includes:
- Sequential Processor Design
- 5-Stage Pipelined Processor
- Pipeline Hazard Handling
- Verilog Testbench Simulation
- Modular Processor Components

---

# ⚙️ Supported RISC-V Instructions

The processor currently supports the following RISC-V ISA instructions:

```assembly
add
sub
and
or
ld
sd
beq
```

These instructions were implemented and tested across both sequential and pipelined architectures.

---

# 🏗️ Processor Architecture

The processor is divided into modular stages for improved scalability and debugging.

## Pipeline Stages

### 1️⃣ Instruction Fetch (IF)
- Program Counter (PC)
- Instruction Memory Access
- Branch Target Computation

### 2️⃣ Instruction Decode (ID)
- Register File Access
- Immediate Generation
- Control Signal Generation

### 3️⃣ Execute (EX)
- ALU Operations
- Arithmetic & Logical Execution
- Branch Comparison Logic

### 4️⃣ Memory Access (MEM)
- Load/Store Memory Operations
- Data Memory Interface

### 5️⃣ Write Back (WB)
- Register Write Back
- Result Selection

---

# 🔥 Key Features

- Custom RISC-V Processor Design
- Sequential Instruction Execution
- 5-Stage Pipeline Architecture
- Data Hazard Resolution
- Control Hazard Handling
- Forwarding Mechanism
- Modular Verilog Design
- Testbench-Based Verification
- Assembly-Level Instruction Testing

---

# 🛡️ Pipeline Hazard Handling

## Data Hazards
Implemented forwarding logic and hazard detection mechanisms to reduce pipeline stalls and improve execution efficiency.

## Control Hazards
Branch handling and pipeline control mechanisms were implemented for proper execution flow during conditional branch instructions.

---

# 🧠 Concepts Demonstrated

This project demonstrates practical understanding of:

- Computer Architecture
- RISC-V ISA
- Pipelined Processor Design
- Sequential Logic Design
- Hazard Detection & Resolution
- Register File Design
- ALU Design
- Memory Architecture
- Hardware Description Languages (HDL)
- Verilog Simulation
- Processor Datapath Design
- Control Unit Design

---

# 🧪 Design Verification

The processor was tested using:
- Independent module-level simulations
- Assembly-level instruction execution
- Integrated processor testbench validation
- Pipeline behavior verification

Verification included:
- Arithmetic operations
- Memory operations
- Branch execution
- Hazard handling validation

---

# ⚙️ Technologies Used

- Verilog HDL
- GTKWave
- Vivado / ModelSim
- RISC-V ISA
- Digital Logic Design
- Hardware Simulation Tools

---

# 📂 Project Structure

```bash
RISC-Pipelined-Processor/
│
├── Processor Modules/
├── Pipeline Stages/
├── ALU/
├── Register File/
├── Instruction Memory/
├── Data Memory/
├── Testbench/
├── Simulation Outputs/
└── README.md
```

---

# 📷 Simulation Snapshots

(Add waveform screenshots and datapath images here)

Examples:
- Pipeline execution waveform
- Hazard forwarding
- Register updates
- Branch execution
- Memory access simulation

---

# ⚡ Challenges Faced

- Implementing forwarding logic for pipeline hazards
- Managing control hazards during branch execution
- Synchronizing pipeline registers
- Debugging multi-stage instruction flow
- Verifying integrated datapath behavior

---

# 📈 Future Improvements

Potential enhancements include:
- Branch Prediction
- Cache Memory Support
- Out-of-Order Execution
- Advanced Hazard Detection
- Additional RISC-V Instructions
- Performance Optimization
- Superscalar Architecture

---

# 👨‍💻 Author

### Sohan Saha

Roll Number: 2363065  
BTech in CSE (IoT & CyberSecurity)  
Heritage Institute of Technology Kolkata  

📧 sohan.saha.iotcs27@heritageit.edu.in

GitHub: https://github.com/SohanEBP

---

# ⭐ Project Goal

This project was developed to strengthen practical understanding of:
- Processor Design
- Computer Organization
- Pipeline Architecture
- Hardware Simulation
- RISC-V Instruction Execution
- Digital System Design

through hands-on implementation of a production-style pipelined processor architecture in Verilog.

---

# 📄 License

This project is intended for academic, educational, and portfolio purposes.
