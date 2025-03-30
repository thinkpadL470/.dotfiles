humanazie_num () {
awk 'function human(size) {
        unit=" KB MB GB TB EB PB YB ZB"
        while (size>=1024 && length(unit)>1)
              {size/=1024; unit=substr(unit,4)}
        unit=substr(unit,1,3)
        unitformat=(unit=="KB")?"%5d":"%0.2f"
        return sprintf( unitformat"%s ", size, unit)
    }
    {gsub(/^[0-9]+/, human($1)); printf "%-6s%-3s%s\n", $1, $2, $3 }' 
}
