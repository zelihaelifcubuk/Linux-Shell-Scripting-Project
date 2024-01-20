#!/bin/bash


# Function to generate Fibonacci sequence
generate_fibonacci(){
    echo "Enter the number of terms for the Fibonacci sequence:"
    read n

    #Check if the input is a positive integer
    if [[ ! $n =~ ^[0-9]+$ || $n -le 0 ]]; then
        echo "Invalid input. Please enter a positive integer."
        return
    fi
 
    #Initialize variable for the first two terms
    a=0
    b=1

    #Print the first two terms
    echo -n "$a $b"

    #Generate and print the rest of the sequence
    for ((i=0; i<n; i++)); do
        c=$((a + b))
        echo -n " $c"
        a=$b
        b=$c
    done

    echo  #Print a newline after the sequence
}


backup_directory(){
    #Prompt user for the directory path
    read -p "Enter the directory path to backup:" dir_path

    #Check if the directory exists
    if [ ! -d "$dir_path" ]; then
        echo "Error: The specified directory does not exist."  
        return 1
    fi 

    #Prompt user for backup destination
    read -p "Enter the backup destination path (including file name):" backup_dest

    #Create a compressed tarball of the directory
    tar -czvf "$backup_dest" "$dir_path"

    #Check if tar operation was successful
    if [ $? -eq 0 ]; then
        echo "Backup successful! Tarball created at: $backup_dest"
    else
        echo "Error: Backup failed."
    fi
}


find_replace_in_file(){

    #Get user input for filename, search string, and replacement string
    read -p "Enter the file name: " filename
    read -p "Enter the search string: " search_string 
    read -p "Enter the replacement string: " replacement_string

    # Perform find-and-replace operation
    if [ -f "$filename" ]; then 

        # Use sed to replace the search string with the replacement string
        sed -i "s/$search_string/$replacement_string/g" "$filename"
        echo "Find-and-replace operation completed successfully in $filename."
    else
        echo "Error: File not found."
    fi
}   


print_system_info(){
    echo "Current Date: $(date)"
    echo "Current Time: $(date +%T)"
    echo "Operating System Information:"
    uname -a
} 


count_string_in_file(){

    if [ "$#" -ne 2 ]; then
        echo "Usage: count_string_in_file <filename> <string>"
        return 1 
    fi

    filename="$1"
    search_string="$2"

    if [ ! -e "$filename" ]; then
        echo "Error: File '$filename' does not exist."
        return 1
    fi

    count=$(grep -o -c "$search_string" "$filename")

    echo "Frequency of '$search_string' in '$filename': $count"
}

count_files_with_extension(){

    # Check if the correct number of arguments is provided
    if [ "$#" -ne 2 ]; then
        echo "Usage: $0 <directory_path> <file_extension>"
        return 1
    fi

    #Assign input parameters to variables
    directory_path="$1"
    file_extension="$2"

    #Check if the specified directory exists
    if [ ! -d "$directory_path" ]; then
        echo "Error: Directory '$directory_path' not found."
        return 1
    fi

    #Count the number of files with the specified extension
    file_count=$(find "$directory_path" -maxdepth 1 -type f -name "*.$file_extension" | wc -l) 
    
    #Print the result
    echo "Number of .$file_extension files in $directory_path: $file_count"
}

 
#Main scrip
while true; do
    echo "MENU" 
    echo "a.Generate Fibonacci Sequence"
    echo "b.Directory Backup"
    echo "c.Find and Replace in a File"
    echo "d.Print System Information"
    echo "e.Count a String in a File"
    echo "f.Count Files with a Specific Extension"
    echo "g.Exit"
    echo "Select an option:"
    read choice


    case $choice in
        a)
            generate_fibonacci
            ;;
        b)
            backup_directory
            ;; 
        c)
            find_replace_in_file
            ;;
        d)
            print_system_info
            ;; 
        e)
            read -p "Enter filename: " filename
            read -p "Enter search string: " search_string 
            count_string_in_file "$filename" "$search_string" 
            ;;


        f)
            read -p "Enter directory path: " directory_path
            read -p "Enter file extension: " file_extension
            count_files_with_extension "$directory_path" "$file_extension" 
            ;;
        g)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid choice. Please select a valid option."
            ;; 

    esac
done






































        ;; 
esac    































































 
