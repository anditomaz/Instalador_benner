<# 
.NAME
    Untitled
#>

<# 
.NAME
    Menu
#>   
Start-Process powershell -verb runas -ArgumentList "-file fullpathofthescript"


#------------------------------------- Menu Iniciar --------------------------------------------
Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form_Menu                       = New-Object system.Windows.Forms.Form
$Form_Menu.ClientSize            = New-Object System.Drawing.Point(475,329)
$Form_Menu.text                  = "Instalador benner (Menu)"
$Form_Menu.TopMost               = $false
$Form_Menu.BackColor             = [System.Drawing.ColorTranslator]::FromHtml("#9b9b9b")

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Escolha a opção desejada:"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(146,58)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$CheckBox1_InstalarServAplicacao   = New-Object system.Windows.Forms.CheckBox
$CheckBox1_InstalarServAplicacao.text  = "Instalar servidor aplicação"
$CheckBox1_InstalarServAplicacao.AutoSize  = $false
$CheckBox1_InstalarServAplicacao.width  = 190
$CheckBox1_InstalarServAplicacao.height  = 20
$CheckBox1_InstalarServAplicacao.location  = New-Object System.Drawing.Point(146,106)
$CheckBox1_InstalarServAplicacao.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Btn_MenuProximo                 = New-Object system.Windows.Forms.Button
$Btn_MenuProximo.text            = "Próximo"
$Btn_MenuProximo.width           = 128
$Btn_MenuProximo.height          = 30
$Btn_MenuProximo.location        = New-Object System.Drawing.Point(160,199)
$Btn_MenuProximo.Font            = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Form_Menu.controls.AddRange(@($Label1,$CheckBox1_InstalarServAplicacao,$Btn_MenuProximo))

$Btn_MenuProximo.Add_Click({ OpçcaoInstall })

function OpçcaoInstall {
   if ($CheckBox1_InstalarServAplicacao.Checked) {
    [void]$Form.ShowDialog()

   }
   else{
    [System.Reflection.Assembly]::LoadWithPartialName('System.Windows.Forms')
    [System.Windows.Forms.MessageBox]::Show('Marque a opção na caixa de seleção','WARNING')
   }
}

#region Logic 

#endregion

[void]$Form_Menu.ShowDialog()

#------------------------------------- Fim Menu Iniciar --------------------------------------------


#-------------------------------------- Instalar servidor aplicação -------------------------------------

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = New-Object System.Drawing.Point(356,216)
$Form.text                       = "Instalador benner (Aplicação)"
$Form.TopMost                    = $false
$Form.BackColor                  = [System.Drawing.ColorTranslator]::FromHtml("#9b9b9b")

$Label1                          = New-Object system.Windows.Forms.Label
$Label1.text                     = "Caminho Instalação dos serviços"
$Label1.AutoSize                 = $true
$Label1.width                    = 25
$Label1.height                   = 10
$Label1.location                 = New-Object System.Drawing.Point(31,54)
$Label1.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$TextBox_caminhoInstalacao       = New-Object system.Windows.Forms.TextBox
$TextBox_caminhoInstalacao.multiline  = $false
$TextBox_caminhoInstalacao.width  = 287
$TextBox_caminhoInstalacao.height  = 20
$TextBox_caminhoInstalacao.location  = New-Object System.Drawing.Point(30,75)
$TextBox_caminhoInstalacao.Font  = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$ComboBox_sistema                = New-Object system.Windows.Forms.ComboBox
$ComboBox_sistema.width          = 174
$ComboBox_sistema.height         = 20
@('RH','CORPORATIVO','JURIDICO','TURISMO') | ForEach-Object {[void] $ComboBox_sistema.Items.Add($_)}
$ComboBox_sistema.location       = New-Object System.Drawing.Point(31,125)
$ComboBox_sistema.Font           = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Label2                          = New-Object system.Windows.Forms.Label
$Label2.text                     = "Sistema"
$Label2.AutoSize                 = $true
$Label2.width                    = 25
$Label2.height                   = 10
$Label2.location                 = New-Object System.Drawing.Point(31,106)
$Label2.Font                     = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Btn_Instalar                    = New-Object system.Windows.Forms.Button
$Btn_Instalar.text               = "Instalar"
$Btn_Instalar.width              = 93
$Btn_Instalar.height             = 30
$Btn_Instalar.location           = New-Object System.Drawing.Point(221,125)
$Btn_Instalar.Font               = New-Object System.Drawing.Font('Microsoft Sans Serif',10)

$Form.controls.AddRange(@($Label1,$TextBox_caminhoInstalacao,$ComboBox_sistema,$Label2,$Btn_Instalar))

$Btn_Instalar.Add_Click({ Instalar })

function InstalaComuns {
    & '.\Instalar comuns - Seattle x64.exe' | Out-Null
}
function InstalacaoBServer {
    param(
        [string]$Caminho
    )
     Invoke-Expression $Caminho
}
function InstalacaoIntegrator {
    param(
        [string]$CaminhoIntSrv
    )
    Invoke-Expression $CaminhoIntSrv
}
function InstalaProvider {
    param (
        [string]$CaminhoProvider
    )
    Invoke-Expression $CaminhoProvider
    
}

#region Logic 
function Instalar {

   $clientFerramentas = new-object System.Net.WebClient
   $clientScript = new-object System.Net.WebClient
     
   $Escolha = $ComboBox_sistema.Text

   if ($Escolha -eq '') {
    [System.Windows.Forms.MessageBox]::Show('Favor preencher o campo SISTEMA','Erro') | Out-Null

   } 
   else {
    if ($Escolha -eq 'RH') {
    $clientFerramentas.DownloadFile("https://atualizador.benner.com.br/tec/ferramentas_instalacao.zip", "C:\Users\Public\Downloads\Ferramentas.zip")
    $clientFerramentas.DownloadFile("https://atualizador.benner.com.br/tec/Rh_CSX_cont-estru.zip", "C:\Users\Public\Downloads\Scripts.zip")     

   }
    elseif ($Escolha -eq 'CORPORATIVO') {
    $clientFerramentas.DownloadFile("https://atualizador.benner.com.br/tec/ferramentas_instalacao.zip", "C:\Users\Public\Downloads\Ferramentas.zip")
    $clientFerramentas.DownloadFile("https://atualizador.benner.com.br/tec/Corporativo_CSX_cont-estru.zip", "C:\Users\Public\Downloads\Scripts.zip") 

   } 
    elseif ($Escolha -eq 'JURIDICO') {
    $clientFerramentas.DownloadFile("https://atualizador.benner.com.br/tec/ferramentas_instalacao.zip", "C:\Users\Public\Downloads\Ferramentas.zip")
    $clientFerramentas.DownloadFile("https://atualizador.benner.com.br/tec/Juridico_CSX_cont-estru.zip", "C:\Users\Public\Downloads\Scripts.zip") 

   }
    elseif ($Escolha -eq 'TURISMO') {
    $clientFerramentas.DownloadFile("https://atualizador.benner.com.br/tec/ferramentas_instalacao.zip", "C:\Users\Public\Downloads\Ferramentas.zip")
    $clientFerramentas.DownloadFile("https://atualizador.benner.com.br/tec/Turismo_CSX_cont-estru.zip", "C:\Users\Public\Downloads\Scripts.zip") 

   }  

   $DiretorioInstall = $TextBox_caminhoInstalacao.Text

   if (Test-Path $DiretorioInstall){
       Expand-Archive -LiteralPath 'C:\Users\Public\Downloads\Ferramentas.zip' -DestinationPath $DiretorioInstall
       Expand-Archive -LiteralPath 'C:\Users\Public\Downloads\Scripts.zip' -DestinationPath $DiretorioInstall
   }
   else {
       mkdir $DiretorioInstall
       Expand-Archive -LiteralPath 'C:\Users\Public\Downloads\Ferramentas.zip' -DestinationPath $DiretorioInstall
       Expand-Archive -LiteralPath 'C:\Users\Public\Downloads\Scripts.zip' -DestinationPath $DiretorioInstall
       echo 'Download finalizado com sucesso.'
   }
}

   #Chama Função que instala os arquivos comuns
   InstalaComuns

   #Chama a função que instala o serviço do BServer
   $teste = $TextBox_caminhoInstalacao.Text
   InstalacaoBServer -Caminho "$teste\ferramentas\bserver\bserver.exe -install" | Out-Null

   #Chama a função que instala o integrator
   InstalacaoIntegrator -CaminhoIntSrv "$teste\ferramentas\integrator\intsrv.exe -install" | Out-Null
   
   #Chama a função que instala o provider
  # InstalaProvider -CaminhoProvider "$teste\ferramentas\provider\bprv230.exe -install"

}

#endregion

#-------------------------------------- Fim Instalar servidor aplicação -------------------------------------
