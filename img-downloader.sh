#!/bin/bash/

echo "Enter session number"
read ses_num

mkdir ~/Desktop/pi3dscan/$ses_num
cd ~/Desktop/pi3dscan/$ses_num

# set up error flag and message
error = false
cameraErrors = "Unable to download from cameras: "

# for loop that will iterate over and download photos from all 38 cameras
# saves first photo without the projection as .texture
# saves third photo with projection
for i in $(seq 101 138)
    { # Try to download from camera i
        do wget -O ${i}.jpg.texture.jpg http://192.168.99.$i/${i}_${ses_num}_1.jpg;
        wget -O ${i}.jpg http://192.168.99.$i/${i}_${ses_num}_3.jpg;

    } || { # if it fails make a note then move on
        # set error flag if this is the first one
        if [$error = false]; then 
            error = true
        fi
        
        # add camera number to list for later reporting
        cameraErrors += "$i "
    }

done

if [$error = false]; then
    echo "Images from Raspberry Pi Camera have been sucessfully downloaded :)"
else
    echo $cameraErrors
fi
