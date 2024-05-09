bright() {
    percentage=$1

    # Check if percentage is a valid number and within the range 0-100
    if ! [[ $percentage =~ ^[0-9]+$ ]] || (($percentage < 0 || $percentage > 100)); then
        echo "Invalid percentage input. Please provide a number between 0 and 100."
        return 1
    fi

    # Iterate over each backlight device folder
    for backlight_dir in /sys/class/backlight/*/; do
        max_brightness_file="$backlight_dir/max_brightness"
        brightness_file="$backlight_dir/brightness"
        # Check if max_brightness file exists
        if [ -f "$max_brightness_file" ]; then
            max_brightness=$(cat $max_brightness_file)
            # Calculate the new brightness value
            new_value=$((max_brightness * percentage / 100))
            # Set the new brightness value
            echo "$new_value" > "$brightness_file"
        else
            tput setaf 3
            echo "Warning: max_brightness file not found for $backlight_dir"
            tput sgr0
        fi
    done
}
