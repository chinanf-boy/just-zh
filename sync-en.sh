cd source && git pull && sh ~/sh-script/git-info.sh && cd - && echo "update source"

cat './.mds-list' | while read line || [[ -n ${line} ]]
do
    testseq="zh.md"
    if [[ $line =~ $testseq || "$line" == "" ]]; then
        echo "skip $line"
    else
        lowline=`echo "$line" | awk '{print tolower($0)}'`
        # lowwer string
        zh=${line//source\//}
        dir=$(dirname $zh)
        
        source_readme="./source/readme.adoc"
        if [[ $lowline == $source_readme ]];then
        # source/[readme|REAMDE].md => en.md
        sh ./adoc_to_md.sh $line
        filename="en.md"
        echo "$line >> $dir/$filename"
        continue
        else 
        # source/other.md => ./other.md
        filename=$(basename $zh)
        fi
        echo "$line >> $dir/$filename"
        mkdir -p $dir && cp $line "$_/$filename"
    fi
done