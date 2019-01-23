#!/usr/bin/env bash

SYS_INFO_DIR_RELATIVE="sysinfo_$HOSTNAME"
SYS_INFO_DIR="./$SYS_INFO_DIR_RELATIVE"
[ -d "$SYS_INFO_DIR" ] && rm -rf "$SYS_INFO_DIR"
mkdir "$SYS_INFO_DIR"

SYS_INFO_FILE="$SYS_INFO_DIR/sysinfo_$HOSTNAME.log"

> "$SYS_INFO_FILE"

if [ -w "$SYS_INFO_FILE" ]
then

  echo -e "\n----- System Time -----\n" >> "$SYS_INFO_FILE" 2>&1
  date >> "$SYS_INFO_FILE" 2>&1

  echo -e "\n" >> "$SYS_INFO_FILE" 2>&1
  echo "##############################" >> "$SYS_INFO_FILE" 2>&1
  echo "#          Hardware          #" >> "$SYS_INFO_FILE" 2>&1
  echo "##############################" >> "$SYS_INFO_FILE" 2>&1

  # CPU

  echo -e "\n##### /proc/cpuinfo #####\n" >> "$SYS_INFO_FILE" 2>&1
  cat /proc/cpuinfo >> "$SYS_INFO_FILE" 2>&1

  if type lscpu > /dev/null 2>&1
  then
    echo -e "\n##### lscpu #####\n" >> "$SYS_INFO_FILE" 2>&1
    lscpu >> "$SYS_INFO_FILE" 2>&1
  fi

  # Memory
  echo -e "\n##### /proc/meminfo #####\n" >> "$SYS_INFO_FILE" 2>&1
  cat /proc/meminfo >> "$SYS_INFO_FILE" 2>&1

  # Disk
  if type lsblk > /dev/null 2>&1
  then
    echo -e "\n##### lsblk #####\n" >> "$SYS_INFO_FILE" 2>&1
    lsblk >> "$SYS_INFO_FILE" 2>&1
  fi
  if type mount > /dev/null 2>&1
  then
    echo -e "\n##### mount #####\n" >> "$SYS_INFO_FILE" 2>&1
    mount >> "$SYS_INFO_FILE" 2>&1
  fi

  # Network
  if type ifconfig > /dev/null 2>&1
  then
    echo -e "\n##### ifconfig #####\n" >> "$SYS_INFO_FILE" 2>&1
    ifconfig >> "$SYS_INFO_FILE" 2>&1
  else
    if type ip > /dev/null 2>&1
    then
      echo -e "\n##### ip #####\n" >> "$SYS_INFO_FILE" 2>&1
      ip addr list >> "$SYS_INFO_FILE" 2>&1
    fi
  fi

  # PCI Devices

  if type lspci > /dev/null 2>&1
  then
    echo -e "\n##### lspci #####\n" >> "$SYS_INFO_FILE" 2>&1
    lspci >> "$SYS_INFO_FILE" 2>&1
  fi  

  # USB Devices

  if type lspci > /dev/null 2>&1
  then
    echo -e "\n##### lsusb #####\n" >> "$SYS_INFO_FILE" 2>&1
    lsusb >> "$SYS_INFO_FILE" 2>&1
  fi  

  # DMI
  if type dmidecode > /dev/null 2>&1
  then
    echo -e "\n##### dmidecode #####\n" >> "$SYS_INFO_FILE" 2>&1
    if [ "$UID" -eq 0 ]
    then
      dmidecode >> "$SYS_INFO_FILE" 2>&1
    else
      sudo dmidecode >> "$SYS_INFO_FILE" 2>&1
    fi
  fi

  echo "##############################" >> "$SYS_INFO_FILE" 2>&1
  echo "#          Software          #" >> "$SYS_INFO_FILE" 2>&1
  echo "##############################" >> "$SYS_INFO_FILE" 2>&1

  echo -e "\n##### os release #####\n" >> "$SYS_INFO_FILE" 2>&1
  cat /etc/*release >> "$SYS_INFO_FILE" 2>&1

  echo -e "\n##### kernel release #####\n" >> "$SYS_INFO_FILE" 2>&1
  uname -a >> "$SYS_INFO_FILE" 2>&1
  
  echo -e "\n##### environment #####\n" >> "$SYS_INFO_FILE" 2>&1
  set >> "$SYS_INFO_FILE" 2>&1

  if type rpm > /dev/null 2>&1
  then
    echo -e "\n##### rpm #####\n" >> "$SYS_INFO_FILE" 2>&1
    rpm -qa >> "$SYS_INFO_FILE" 2>&1
  fi

  if type dpkg > /dev/null 2>&1
  then
    echo -e "\n##### dpkg #####\n" >> "$SYS_INFO_FILE" 2>&1
    dpkg -l >> "$SYS_INFO_FILE" 2>&1
  fi  
  
else
  echo "Can't save system information to $SYS_INFO_FILE"
  exit 1
fi
