unit Unit2;

interface

uses
  System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.OleCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls,
  Winapi.Windows, System.IniFiles, System.Types,
  SHDocVw,
  ShellAPI, System.Win.Registry,
  GMLinkedComponents, GMMarker, GMMarkerVCL, GMMap, GMGeoCode, GMClasses,
  GMMapVCL, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, IBX.IBCustomDataSet,
  IBX.IBQuery, IBX.IBDatabase;

type
  TForm2 = class(TForm)
    WebBrowser1: TWebBrowser;
    GMMap1: TGMMap;
    Panel1: TPanel;
    Button1: TButton;
    GMGeoCode1: TGMGeoCode;
    GMMarker1: TGMMarker;
    Button2: TButton;
    Panel2: TPanel;
    IBDatabase1: TIBDatabase;
    IBTransaction1: TIBTransaction;
    IBQuery1: TIBQuery;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    IBQuery1IDBAIRRO: TIntegerField;
    IBQuery1NOMEBAIRRO: TIBStringField;
    IBQuery1LAT: TFMTBCDField;
    IBQuery1LNG: TFMTBCDField;
    procedure GMMap1AfterPageLoaded(Sender: TObject; First: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure FormClick(Sender: TObject);
    procedure IBQuery1AfterOpen(DataSet: TDataSet);
  private
    procedure ControlIEVersion;
  public
    constructor Create(aOwner: TComponent); override;
  end;

const
   //ATENÇÃO
   API_KEY = 'Coloque_aqui_sua_Chave_de_API_Google';

var
  Form2: TForm2;

implementation

{$R *.dfm}

{ TForm1 }

procedure TForm2.Button1Click(Sender: TObject);
begin
   with IBQuery1 do
   begin
      Try
         Close;
         Prepare;
         Open;
      Except
      End;
      if (RecordCount > 0) then
      begin
         //Posiciona em Guaxupé para centralizar o mapa
         //Marcação 0 na lista
         GMMarker1.Add(-21.306937, -46.715619, 'GUAXUPÉ - MG - 37800-000');
         while not(Eof) do
         begin
            //GMGeoCode1.Geocode('CENTRO, GUAXUPE, MG');
            //Não consegui geocodificar o endereço pelo componente
            //GeoCode!!!
            //Adiciona as marcações por passagem de Latitude e Longitude
            GMMarker1.Add(IBQuery1LAT.AsFloat, IBQuery1LNG.AsFloat, IBQuery1NOMEBAIRRO.Value);
            Next;
         end;
         //Centraliza o mapa na marcação 0 da lista
         GMMarker1.Items[0].CenterMapTo;
         //deixa posição 0 invisível
         GMMarker1.Items[0].Visible := False;
         //aplica zoom nos pontos marcados
         GMMarker1.ZoomToPoints;
      end;
   end;
end;

procedure TForm2.Button2Click(Sender: TObject);
begin
   Close;
end;

procedure TForm2.ControlIEVersion;
var
  Tmp: string;
  L: TStringList;
  Ver: Integer;
  Reg: TRegistry;
begin
  Tmp := GMMap1.GetIEVersion;
  L := TStringList.Create;
  try
    L.Delimiter := '.';
    L.DelimitedText := Tmp;
    Ver := StrToInt(L[0]);
  finally
    FreeAndNil(L);
  end;
  if Ver < 7 then Ver := 7;
  Ver := Ver * 1000;
  Reg := TRegistry.Create;
  try
    Reg.RootKey := HKEY_CURRENT_USER;
    if Reg.OpenKey('SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_BROWSER_EMULATION', False) then
    try
      Reg.WriteInteger(ExtractFileName(ParamStr(0)), Ver);
    finally
      Reg.CloseKey;
    end;
  finally
    Reg.Free;
  end;
end;

constructor TForm2.Create(aOwner: TComponent);
begin
  inherited;
  //LEMBRE-SE DE CRIAR A CHAVE DE API
  //E ADICIONAR AS APIS QUE PRECISA UTILIZAR
  //NO LINK: https://console.cloud.google.com
  GMMap1.APIKey := API_KEY;  //PRECISA ATUALIZAR A CHAVE API NA CONSTANTE CRIADA
  GMMap1.Active := True;
  ControlIEVersion;
end;

procedure TForm2.FormClick(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   GMMap1.Active := False;
end;

procedure TForm2.GMMap1AfterPageLoaded(Sender: TObject; First: Boolean);
begin
   if (First) then GMMap1.DoMap;
end;

procedure TForm2.IBQuery1AfterOpen(DataSet: TDataSet);
begin
   IBQuery1.First;
end;

end.

