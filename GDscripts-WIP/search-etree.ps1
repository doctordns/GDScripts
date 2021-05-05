$ie= new-object -com InternetExplorer.Application
$x=$ie.Navigate('C:\foo\gd scripts\TEST.HTM')
$x=$ie.Document.open()

$y = $s | out-string

$s | out-file .\temp.txt
$t = get-content .\temp.txt
$t.count

$count = 0
while ($count -lt $t.count) {
$line = $t[$count] 
if ($line -match "Grateful") {
    $count +=2
    $show = $t[$count]
    "Show = {0}" -f $show
    "  line+1   {0}" -f $t[$count+1] 
    "  line+2   {0}" -f $t[$count+2] 
    "  line+3   {0}" -f $t[$count+3] 
    "  line+4   {0}" -f $t[$count+4] 
    "  line+5   {0}" -f $t[$count+5] 
    "  line+6   {0}" -f $t[$count+6] 
    "  line+7   {0}" -f $t[$count+7] 
    "  line+8   {0}" -f $t[$count+8] 
    "  line+9   {0}" -f $t[$count+9] 
    "  line+10  {0}" -f $t[$count+10] 
    "  line+11  {0}" -f $t[$count+11] 
}
    
$count++
}