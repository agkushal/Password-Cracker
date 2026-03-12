#!/bin/bash

WORDLIST="/usr/share/wordlists/rockyou.txt"

echo "========================================"
echo "      Password Recovery Toolkit"
echo "========================================"

echo
echo "Select file type:"
echo "1) PDF"
echo "2) DOCX"
echo "3) ZIP"
echo "4) XLSX"
echo "5) RAR"

read -p "Choice: " TYPE

echo
read -p "Enter full file path: " FILE

if [ ! -f "$FILE" ]; then
echo "File not found."
exit
fi

echo
echo "[*] Extracting hash..."

case "$TYPE" in

1)
pdf2john "$FILE" > hash.txt
HASHMODE="10500"
RECOMMENDED="Hashcat"
;;

2)
office2john "$FILE" > hash.txt
HASHMODE="9600"
RECOMMENDED="Hashcat"
;;

3)
zip2john "$FILE" > hash.txt
RECOMMENDED="John"
;;

4)
office2john "$FILE" > hash.txt
HASHMODE="9600"
RECOMMENDED="Hashcat"
;;

5)
rar2john "$FILE" > hash.txt
HASHMODE="13000"
RECOMMENDED="Hashcat"
;;

*)
echo "Invalid option"
exit
;;

esac

echo "[+] Hash extracted"

echo
echo "Recommended tool: $RECOMMENDED"

echo
echo "Select tool:"
echo "1) John the Ripper"
echo "2) Hashcat"

read -p "Choice: " TOOL

# GPU check
if [ "$TOOL" = "2" ]; then

GPU=$(hashcat -I 2>/dev/null | grep "Device #" | wc -l)

if [ "$GPU" -eq 0 ]; then
echo "[!] No GPU/OpenCL detected. Falling back to John."
TOOL="1"
fi

fi

echo
echo "Select attack method:"
echo "1) Wordlist attack"
echo "2) Brute force"

read -p "Choice: " ATTACK

echo
echo "Starting password cracking..."

if [ "$TOOL" = "2" ]; then

# HASHCAT

if [ "$ATTACK" = "1" ]; then

hashcat -m $HASHMODE hash.txt $WORDLIST --status --status-timer=60

else

hashcat -m $HASHMODE hash.txt -a 3 ?a?a?a?a?a?a --status --status-timer=60

fi

echo
echo "Recovered password:"
hashcat -m $HASHMODE hash.txt --show

else

# JOHN

if [ "$ATTACK" = "1" ]; then

john hash.txt --wordlist=$WORDLIST

else

john hash.txt --incremental &
PID=$!

while kill -0 $PID 2>/dev/null
do
sleep 60
echo "----- Progress update -----"
john --status
done

fi

echo
echo "Recovered password:"
john --show hash.txt

fi

rm -f hash.txt

echo
echo "Temporary files deleted"
echo "Process completed."
