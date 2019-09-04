####################
#
#	Password Encryption
#
####################


## Method 1 (Not recommanded)
$username = "antoine.morbois"
$password = "my great password"
$securePwd = $password | ConvertTo-SecureString -AsPlainText -Force 

## Method 2
$username =  Read-host "Enter your username"
$securePwd =  Read-host "Enter your password" -AsSecureString 

#On encrypt la SecureString
$secureText = $securePwd | ConvertFrom-SecureString

#Et on le stock dans un fichier pour le réutiliser plus tard
Set-Content "C:\temp\MonPwdEncrypte.txt" $secureText

#Pour le réutiliser, on le repasse en secureString
$mypassword = get-Content "C:\temp\MonPwdEncrypte.txt" | ConvertTo-SecureString 

<#  Notes
ConvertTo-SecureString (encrypt -> secureString)
	-AsPlainText permet de mettre en input un string "lisible"  (PlainText -> SecureString)
		 	 
Va de pair avec ConvertFrom-SecureString qui fait l'inverse (secureString -> encrypt)

Une secureString ne peut pas être stocker dans un fichier pour réutilisation
echo $securePwd -> System.Security.SecureString
echo $secureText -> 01000000d08c9dd.....

#> 

####################
#
#	Password Encryption with Key
#
####################

## Par rajouter de la sécurité, on peut l'encrypter avec une clé (AES)
$KeyFilePath = "<Secured Path / Key Vault / whatever>"
#On peut bien evidemment la générer aléatoirement
$Key = (3,4,2,3,56,34,254,222,1,1,2,23,42,54,33,233,1,34,2,7,6,5,35,43) 
#On la stock dans un endroit sécurisé
Set-Content $KeyFilePath $Key 

#On génère notre fichier de mdp encrypté à l'aide de la clé.
$secureText = $securePwd | ConvertFrom-SecureString - Key $Key
Set-Content "C:\temp\MonPwdEncrypte.txt" $secureText

#Et pour le réutiliser
get-Content "C:\temp\MonPwdEncrypte.txt" | ConvertTo-SecureString -Key $Key

$GetKey = Get-Content $KeyFilePath
$password = $passwordSecureString | ConvertFrom-SecureString -Key $GetKey
