unit About;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TAboutForm = class(TForm)
    AboutPanel: TPanel;
    CloseBtn: TButton;
    ProgramLabel: TLabel;
    VersionLabel: TLabel;
    ProgramIcon: TImage;
    CommentLabel: TLabel;
    BuildLabel: TLabel;
    procedure CloseBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  AboutForm: TAboutForm;

implementation

uses Main;

{$R *.dfm}

procedure TAboutForm.CloseBtnClick(Sender: TObject);
begin
  Close;  // On ferme
end;

procedure TAboutForm.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;     // Doublebuffer + Affichage de l'icone
  AboutPanel.DoubleBuffered := True;
  CloseBtn.DoubleBuffered := True;
  GameForm.ImgList.GetBitmap(3, ProgramIcon.Picture.Bitmap);
end;

end.
