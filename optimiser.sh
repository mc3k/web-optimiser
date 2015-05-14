#!/bin/bash
# Web image optimiser
# Marty Childs, 2015

function usage
{
	echo "Web image optimiser"
	echo "Marty Childs, 2015"
    echo "usage: input_file [[[-o output_file ] [-q quality] [-r resize]] | [-h]]"
}

if [ "$1" != "" ]; then
	input=$1
	output=$1
	quality='-quality '70
	shift
fi

while [ "$1" != "" ]; do
    case $1 in
        -o | --output )			shift
                                output=$1
                                ;;
        -q | --quality )		shift
								quality='-quality '$1
                                ;;

        -r | --resize )			shift
								resize='-resize '$1'x'$1
                                ;;

        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ "$input" != "" ]; then
	echo 'Optimising' $input 'as' $output $resize $quality
	convert $input $quality $resize $output && exiftool -all= $output -overwrite_original -q
else
    echo "Please specify an image file, type 'optimiser.sh --help' for help"
fi
