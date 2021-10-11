unit Help;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, ExtCtrls, StdCtrls;

type
  THelpForm = class(TForm)
    ImageList: TImageList;
    BtnPanel: TPanel;
    TopicList: TTreeView;
    CloseBtn: TButton;
    MemoList: TNotebook;
    GameLabel: TLabel;
    ProgIcon: TImage;
    InfoLabel: TLabel;
    InterfaceInfo: TMemo;
    HowToPlay: TMemo;
    TechInfo: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure CloseBtnClick(Sender: TObject);
    procedure TopicListClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  HelpForm: THelpForm;

implementation

{$R *.dfm}

procedure THelpForm.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  BtnPanel.DoubleBuffered := True;
  TopicList.DoubleBuffered := True;
  MemoList.DoubleBuffered := True;  // DoubleBuffered
  HowToPlay.DoubleBuffered := True;
  InterfaceInfo.DoubleBuffered := True;
  TechInfo.DoubleBuffered := True;
  CloseBtn.DoubleBuffered := True;
  TopicList.FullExpand; // On affiche toute la liste
end;

procedure THelpForm.CloseBtnClick(Sender: TObject);
begin
  Close;  // On ferme
end;

procedure THelpForm.TopicListClick(Sender: TObject);
begin
  MemoList.PageIndex := TopicList.Selected.AbsoluteIndex;
end;               // On affiche la bonne page

end.
