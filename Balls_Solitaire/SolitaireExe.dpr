program SolitaireExe;

uses
  Forms,
  Main in 'Main.pas' {GameForm},
  About in 'About.pas' {AboutForm},
  Options in 'Options.pas' {OptionsForm},
  Help in 'Help.pas' {HelpForm};

{$R *.res}
{$R WindowsXP.RES}

begin
  Application.Initialize;
  Application.Title := 'Solitaire';
  Application.CreateForm(TGameForm, GameForm);
  Application.CreateForm(TAboutForm, AboutForm);
  Application.CreateForm(TOptionsForm, OptionsForm);
  Application.CreateForm(THelpForm, HelpForm);
  Application.Run;
end.
