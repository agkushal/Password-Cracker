# Password-Cracker
The tool supports multiple encrypted file formats and provides a beginner-friendly workflow for performing dictionary and brute-force attacks.
This project is a Bash-based password recovery tool that automates the process of extracting password hashes from encrypted files and recovering the password using John the Ripper and Hashcat.

The script allows users to attempt password recovery using dictionary attacks or brute force attacks. It also suggests the recommended tool based on the file type and falls back to CPU cracking if GPU acceleration is not available.

# Supported File Types: 

PDF ,ZIP
,DOCX
,XLSX
,RAR

# Hash extraction is automatically performed using the following tools: 

pdf2john
,zip2john
,office2john
,rar2john

# Features:

Automatic hash extraction from encrypted files
Integration with John the Ripper and Hashcat
Dictionary attack using common wordlists
Brute force attack option
Recommended tool suggestion based on file type
GPU detection with fallback to CPU
Progress updates during password cracking
Automatic deletion of temporary hash files

# Requirements
1.Linux operating system (Kali Linux or Ubuntu recommended) 
 (Install required tools using the following command)
2. sudo apt update
3. sudo apt install john hashcat unzip rar unrar p7zip-full qpdf pdftk wordlists
4. Extract the rockyou wordlist:

sudo gzip -d /usr/share/wordlists/rockyou.txt.gz

Follow the prompts to select the file type, enter the encrypted file path, choose the cracking tool, and select the attack method.
