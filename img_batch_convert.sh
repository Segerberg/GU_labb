#!/bin/sh

if [ $# -lt 3 ]; then
    echo "Ange katalog, filändelse att konvertera från och filändelse att konvertera till."
    exit 1
fi

directory="$1"
from_extension="$2"
to_extension="$3"

shift 3  # Hoppa över de tre första argumenten som är katalog och filändelserna

cd "$directory" || exit 1

for filename in *."$from_extension"; do
    if [ -f "$filename" ]; then
        new_filename="${filename%.$from_extension}.$to_extension"
        printf 'Konverterar "%s" till "%s" ...\n' "$filename" "$new_filename"

        if convert "$filename" "$new_filename"; then
            printf 'Konvertering lyckades.\n'
        else
            printf >&2 'Fel: Konvertering misslyckades för filen "%s".\n' "$filename"
            exit 1
        fi
    else
        printf >&2 'Fel: Ingen fil med filändelsen "%s" hittades.\n' "$from_extension"
        exit 1
    fi
done

printf 'Alla konverteringar lyckades.\n'
