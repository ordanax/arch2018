##############################################
# ArchLinux Fast Install v1.6 (FORK to install pure Arch Linux)
##############################################

# How to start installation

After entering the Arch Linux live environment

1) Install git:

   ```bash 
   pacman -Sy git
   ```
2) Clone the repository:
   
    ```bash
   git clone https://github.com/Noct2000/arch2018
   ```
	
3) Run the script:

   ```bash 
   cd arch2018
   ```
   
   ```bash 
   sh arch1.sh
   ```
   
    DON'T RUN SCRIPT LIKE ``` sh ./arch2018/arch1.sh ```
   
4) Restart your computer and remove the CD (or flash drive) with the Arch Linux image

# During the script execution, you will need to enter:

- hostname;
- username;
- root's password;
- user's password.

# If you need to install XFCE environment.

### Follow the steps below:

1) Install git on your new system;

2) Clone the repository;

3) Run xfce.sh:
   
   ```bash 
   sudo sh ./arch2018/xfce.sh
   ```
4) In group xorg select all (press Enter);

