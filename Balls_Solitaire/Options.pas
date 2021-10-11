unit Options;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Main;

type
  TOptionsForm = class(TForm)
    FullPanel: TPanel;
    ColorOptionsGB: TGroupBox;
    ColorLabel: TLabel;
    AleaColor: TCheckBox;
    OneColor: TCheckBox;
    ColorCombo: TComboBox;
    BtnPanel: TPanel;
    ApplyBtn: TButton;
    CancelBtn: TButton;
    AboutBtn: TButton;
    SoundsOptionGB: TGroupBox;
    InfoSound: TCheckBox;
    BackSound: TCheckBox;
    HelpBtn: TButton;
    procedure AboutBtnClick(Sender: TObject);
    procedure CancelBtnClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure AleaColorClick(Sender: TObject);
    procedure OneColorClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ApplyBtnClick(Sender: TObject);
    procedure HelpBtnClick(Sender: TObject);
  private
    { Déclarations privées }
  public
    { Déclarations publiques }
  end;

var
  OptionsForm: TOptionsForm;

implementation

uses About, Help;

{$R *.dfm}

procedure TOptionsForm.AboutBtnClick(Sender: TObject);
begin
  AboutForm.ShowModal; // On affiche boite à propos
end;

procedure TOptionsForm.CancelBtnClick(Sender: TObject);
begin
  Close; // On ferme
end;

procedure TOptionsForm.FormCreate(Sender: TObject);
begin
  DoubleBuffered := True;
  FullPanel.DoubleBuffered := True;
  BtnPanel.DoubleBuffered := True;
  AboutBtn.DoubleBuffered := True;
  ApplyBtn.DoubleBuffered := True;
  HelpBtn.DoubleBuffered := True;   // On doublebuffer tout ...
  CancelBtn.DoubleBuffered := True;
  ColorOptionsGB.DoubleBuffered := True;
  AleaColor.DoubleBuffered := True;
  ColorCombo.DoubleBuffered := True;
  OneColor.DoubleBuffered := True;
  SoundsOptionGB.DoubleBuffered := True;
  BackSound.DoubleBuffered := True;
  InfoSound.DoubleBuffered := True;
end;

procedure TOptionsForm.AleaColorClick(Sender: TObject);
begin
  OneColor.Checked := not AleaColor.Checked;
  ColorCombo.Enabled := OneColor.Checked; // Permutation des 2 checkboxes
end;

procedure TOptionsForm.OneColorClick(Sender: TObject);
begin
  AleaColor.Checked := not OneColor.Checked;
  ColorCombo.Enabled := OneColor.Checked; // Idem
end;

procedure TOptionsForm.FormShow(Sender: TObject);
begin
  OptionRecord := GameForm.ReadOptions;
  if OptionRecord.RandomColors then
    begin
      AleaColor.Checked := True;
      OneColor.Checked := False;
    end
  else          // On charge options et on les retranscrit sur la fiche
    begin
      AleaColor.Checked := False;
      OneColor.Checked := True;
      ColorCombo.Enabled := True;
    end;
  ColorCombo.ItemIndex := OptionRecord.OneColorValue;

  InfoSound.Checked := OptionRecord.InfoSounds;
  BackSound.Checked := OptionRecord.BackMusic;
end;

procedure TOptionsForm.ApplyBtnClick(Sender: TObject);
begin
  OptionRecord.RandomColors := AleaColor.Checked;
  OptionRecord.OneColorValue := ColorCombo.ItemIndex;
  OptionRecord.InfoSounds := InfoSound.Checked; // On enregistre les options et on les ecrit
  OptionRecord.BackMusic := BackSound.Checked;
  GameForm.WriteOptions(OptionRecord);
  Close;
end;

procedure TOptionsForm.HelpBtnClick(Sender: TObject);
begin
  HelpForm.ShowModal;  // On affiche l'aide
end;

end.
