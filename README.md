# RC5-Encryption-Decryption-Implementation-in-AVR-Assembly-v1.1

# 🔐 RC5 Encryption & Decryption on ATmega328P (AVR Assembly)

![License](https://img.shields.io/badge/License-MIT-blue.svg)
![Platform](https://img.shields.io/badge/Platform-ATmega328P-green.svg)
![Language](https://img.shields.io/badge/Language-AVR_Assembly-red.svg)

This project demonstrates a complete implementation of the **RC5 symmetric key encryption algorithm** in **AVR Assembly**, running on the **ATmega328P** microcontroller. The results are displayed in real time using a 16x2 LCD, and the system is fully testable via Proteus simulation.

[▶️ Watch the Project Demo on YouTube](https://www.youtube.com/@0xkimson)

---

## 📦 Overview

- ✅ Full RC5 block cipher: Encryption & decryption
- 🧠 Optimized for embedded devices with limited memory (2KB SRAM)
- 📺 LCD-based result visualization
- ⚙️ Assembly-level key expansion, S-table generation, and bitwise operations
- 🧪 Tested using Proteus simulation

---

## 📋 Technical Summary

| Component        | Details                           |
|------------------|-----------------------------------|
| MCU              | ATmega328P @ 16 MHz               |
| Language         | AVR Assembly                      |
| Display          | 16x2 LCD (Port D: Data, Port B: Control) |
| Development IDE  | Atmel Studio 7.0                  |
| Simulation       | Proteus 8.x (.pdsprj)             |
| Word Size (W)    | 16 bits                           |
| Rounds (R)       | 8                                 |
| Key Size         | 96 bits (12 bytes)                |
| Block Size       | 32 bits (2 words)                 |
| S-Array Size     | 18 words                          |
| Constants        | P = 0xB7E1, Q = 0x9E37            |

---

## 🧠 Memory Organization (SRAM Layout)

| Purpose                  | Address Range     |
|--------------------------|------------------|
| 🔑 Secret Key (12 bytes) | `0x0200 – 0x020B` |
| 🔐 S-Array (18 words)    | `0x0210 – 0x0221` |
| 🧮 L-Array               | `0x0222 – ...`    |

---

## 🔁 Key Expansion Process

1. **Initialize S[0]** with constant `P = 0xB7E1`
2. **Fill S[i]** using `S[i] = S[i-1] + Q` with `Q = 0x9E37`
3. **Mix the secret key** into S-array using a loop over `3 × max(S, L)`
   - Combines key bytes and constants using XOR, rotation, and addition
   - Ensures good key diffusion and randomness

---

## 🔐 RC5 Encryption Steps

1. Pre-round addition:
   ```
   A = A + S[0]
   B = B + S[1]
   ```
2. Repeat for 8 rounds:
   ```
   A = ((A ⊕ B) <<< (B mod 16)) + S[2i]
   B = ((B ⊕ A) <<< (A mod 16)) + S[2i + 1]
   ```

---

## 🔓 RC5 Decryption Steps

1. Repeat for 8 rounds in reverse:
   ```
   B = ((B - S[2i+1]) >>> (A mod 16)) ⊕ A
   A = ((A - S[2i]) >>> (B mod 16)) ⊕ B
   ```
2. Post-round subtraction:
   ```
   B = B - S[1]
   A = A - S[0]
   ```

---

## 🧰 Word-Level Operations

Implemented as low-level 16-bit macros in AVR Assembly:

- `ROTL_WORD`: Rotate Left
- `ROTR_WORD`: Rotate Right
- `XOR_WORD`: Bitwise XOR
- `ADD_WORD`: Word Addition
- `SUB_WORD`: Word Subtraction

---

## 🧪 Test Cases & Usage

### Test Inputs:
1. `"Kemo"` → `0x4B65`, `0x6D6F`
2. `"0080"` → `0x3030`, `0x3830`

### Process for Each Case:
- 🟢 Display original plaintext on LCD  
- 🔒 Encrypt → display ciphertext  
- 🔓 Decrypt → confirm match with original plaintext

All operations are shown in real time on the LCD.

---

## 🧪 Proteus Simulation

The included `.pdsprj` simulation file demonstrates the full system:

- ✅ ATmega328P microcontroller
- ✅ LCD wired via 4-bit interface
- ✅ Clock and power configured
- ✅ Load `.hex` file and view live encryption/decryption

📂 **File Included:**
- `Simulation.pdsprj`
- `Output.hex`

---

## 🔐 Security Notes

> ⚠️ **This project is for educational/demonstration purposes only.**

- Uses 96-bit key (default mostly zeros with one byte = `0x50`)
- Follows original RC5 spec (1994) by Rivest
- No side-channel protection
- Not suitable for production crypto systems

---

## 📚 References

- Rivest, R. (1994). *The RC5 Encryption Algorithm*
- [Wikipedia – RC5 Encryption](https://en.wikipedia.org/wiki/RC5)
- AVR Instruction Set Manual  
- Atmel ATmega328P Datasheet

---

## 📬 Contact

📥 **For full source code and advanced details:**

- Telegram: [@Kz_u4](https://t.me/Kz_u4)  
- YouTube: [@0xkimson](https://www.youtube.com/@0xkimson)

---

## 📄 License

Licensed under the [MIT License](LICENSE).

---

> ⚡ This project showcases what’s possible when cryptography, embedded systems, and low-level assembly meet. Feel free to star the repo and share!

