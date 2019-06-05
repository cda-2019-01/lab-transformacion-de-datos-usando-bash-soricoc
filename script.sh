for file in $(find . -name '*.csv');
for file in $(find . -name '*.csv');                                      # Recorre los archivos csv de la carpeta	
do
    fn="$(basename -- ${file})";                                          # Extrae el nombre del archivo 
    i=0
    while read line || [ -n "$line" ];                                    # Lee el archivo línea por línea
    do
        if [ ${#line} -gt 1 ]                                             # Salta las líneas en blanco
        then
            ((i++))                                                       # Inicia un contador 
            cadenas=$(echo $line | tr "," "\n");                          # Separa lo que se encuentra separado por coma
            upp=$(echo $line | head -c 1);                                # Guarda en una variable la letra en mayúscula al inicio de cada línea
            for cad in $cadenas                                           # Recorre las cadenas que se separaron por coma en un paso anterior
            do
                if [[ "$cad" =~ ...:. ]]                                  # Valida si la cadena cumple con el patrón ...:.
                then
                    if [[ ${cad: -1} = $'\r' ]];                          # Valida retorno de carro
                    then
                        echo "$fn,$i,$upp,"$cad"";                        # Imprime la línea si retorno porque ya lo incluye
                    else
                        echo "$fn,$i,$upp,"$cad"" | sed -e "s/$/\r/";     # Imprime la línea con retorno de carro
                    fi
                fi
            done
        fi
    done < $fn
done

