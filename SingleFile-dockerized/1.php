'''
javascript:(function(){    var script=document.createElement('script');   script.setAttribute('src',  'https://res.zvo.cn/msg/msg.js');    document.getElementsByTagName('head')[0] .appendChild(script);  msg.textarea('input',function(value){window.open('http://45.32.200.249:8060/ddd?url=ddd&ddd=%27+encodeURIComponent(value));}, %27bash 1.sh%27); })();
'''
<?php
echo " php -S 45.32.200.249:9009 My first PHP script! http://45.32.200.249:9009/1.php \n https://www.w3schools.com/jquery/jquery.js";
echo "https://cdn.staticfile.net/angular.js/1.4.6/angular.min.js </br>"
?>





<?php
$myObj = new stdClass();
$myObj->name = "John";
$myObj->age = 30;
$myObj->city = "New York";

$myJSON = json_encode($myObj);

echo $myJSON;
?>


<?php
// Array with names
$a[] = "Anna";
$a[] = "Brittany";
$a[] = "Cinderella";
$a[] = "Diana";
$a[] = "Eva";
$a[] = "Fiona";
$a[] = "Gunda";
$a[] = "Hege";
$a[] = "Inga";
$a[] = "Johanna";
$a[] = "Kitty";
$a[] = "Linda";
$a[] = "Nina";
$a[] = "Ophelia";
$a[] = "Petunia";
$a[] = "Amanda";
$a[] = "Raquel";
$a[] = "Cindy";
$a[] = "Doris";
$a[] = "Eve";
$a[] = "Evita";
$a[] = "Sunniva";
$a[] = "Tove";
$a[] = "Unni";
$a[] = "Violet";
$a[] = "Liza";
$a[] = "Elizabeth";
$a[] = "Ellen";
$a[] = "Wenche";
$a[] = "Vicky";

// get the q parameter from URL
$q = $_REQUEST["q"];
$q = "E";

$hint = "";

// lookup all hints from array if $q is different from ""
if ($q !== "") {
  $q = strtolower($q);
  $len=strlen($q);
  foreach($a as $name) {
    if (stristr($q, substr($name, 0, $len))) {
      if ($hint === "") {
        $hint = $name;
      } else {
        $hint .= ", $name";
      }
    }
  }
}
echo "</br> \n";
// Output "no suggestion" if no hint was found or output correct values
echo $hint === "" ? "no suggestion" : $hint;
?>




<?php
// phpinfo();

?>

