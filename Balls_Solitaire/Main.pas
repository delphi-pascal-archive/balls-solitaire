// Mettre les sons
// Quand on bouge un pion
// Quand on gagne
// Quand on commence nouvelle partie
// + musique de fond

unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ImgList, Math, IniFiles;

type
        TOptionRecord=record
        RandomColors: Boolean;
        OneColorValue: Byte;
        InfoSounds: Boolean;
        BackMusic: Boolean;
        end;

type
        TCellType=(CTBille, CTEmpty, CTNil);

        TCell=record
        CellType: TCellType;
        X, Y: Byte;
        Color: Byte;
        Selected, Destination: Boolean;
        end;

type
  TGameForm = class(TForm)
    Img: TImage;
    GamePanel: TPanel;
    GameLabel: TLabel;
    NewGameLabel: TLabel;
    OptionLabel: TLabel;
    QuitLabel: TLabel;
    ImgList: TImageList;
    LeftPawnsLabel: TLabel;
    OutPawnsLabel: TLabel;
    WinLabel: TLabel;
    WinLabel2: TLabel;
    SepShape1: TShape;
    SepShape2: TShape;
    SepShape3: TShape;
    SepShape4: TShape;
    SepShape5: TShape;
    TimeLabel: TLabel;
    TimeTimer: TTimer;
    SepShape6: TShape;
    GameIcon2: TImage;
    GameIcon3: TImage;
    SepShape7: TShape;
    VersionLabel: TLabel;
    VersionLabel2: TLabel;
    procedure NewGameLabelMouseEnter(Sender: TObject);
    procedure NewGameLabelMouseLeave(Sender: TObject);
    procedure OptionLabelMouseEnter(Sender: TObject);
    procedure OptionLabelMouseLeave(Sender: TObject);
    procedure QuitLabelMouseEnter(Sender: TObject);
    procedure QuitLabelMouseLeave(Sender: TObject);
    procedure QuitLabelClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure OptionLabelClick(Sender: TObject);
    procedure NewGameLabelClick(Sender: TObject);
    procedure ImgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TimeTimerTimer(Sender: TObject);
    procedure VersionLabel2Click(Sender: TObject);
  private
    { D�clarations priv�es }
  public
    { D�clarations publiques }
    function GetLeftPawns: Byte;
    function GetOutPawns: Byte;

    procedure InitGame;
    procedure DrawGame;

    function CanGoUp(X, Y: Byte): Boolean;
    function CanGoDown(X, Y: Byte): Boolean;
    function CanGoLeft(X, Y: Byte): Boolean;
    function CanGoRight(X, Y: Byte): Boolean;

    procedure UndoSelections;

    procedure MakeDestinations(X, Y: Byte);

    function GetSelectedPawn: TPoint;

    procedure MovePawn(SelX, SelY, DestX, DestY: Byte);

    function CheckWin: Boolean;

    procedure Win;

    function ReadOptions: TOptionRecord;
    procedure WriteOptions(OptionData: TOptionRecord);
  end;

var
  GameForm: TGameForm;
  Game: array [1..9, 1..9] of TCell;
  WinText: String;
  Finished: Boolean;
  TS, TM: ShortInt;
  OptionRecord: TOptionRecord;

implementation

uses About, Options;

{$R *.dfm}

procedure TGameForm.NewGameLabelMouseEnter(Sender: TObject);
begin
  NewGameLabel.Font.Color := clRed;
  NewGameLabel.Font.Style := [fsUnderline, fsBold, fsItalic];
end;

procedure TGameForm.NewGameLabelMouseLeave(Sender: TObject);
begin
  NewGameLabel.Font.Color := clBlack;
  NewGameLabel.Font.Style := [fsBold, fsUnderline];
end;

procedure TGameForm.OptionLabelMouseEnter(Sender: TObject);
begin
  OptionLabel.Font.Color := clRed;
  OptionLabel.Font.Style := [fsUnderline, fsBold, fsItalic];
end;

procedure TGameForm.OptionLabelMouseLeave(Sender: TObject);
begin
  OptionLabel.Font.Color := clBlack;
  OptionLabel.Font.Style := [fsBold, fsUnderline];
end;

procedure TGameForm.QuitLabelMouseEnter(Sender: TObject);
begin
  QuitLabel.Font.Color := clRed;
  QuitLabel.Font.Style := [fsUnderline, fsBold, fsItalic];
end;

procedure TGameForm.QuitLabelMouseLeave(Sender: TObject);
begin
  QuitLabel.Font.Color := clBlack; 
  QuitLabel.Font.Style := [fsBold, fsUnderline];
end;

procedure TGameForm.QuitLabelClick(Sender: TObject);
begin
  Close; // On quitte avec message
end;

procedure TGameForm.FormCreate(Sender: TObject);
begin
  randomize;
  DoubleBuffered := True; // Doublebuffered
  GamePanel.DoubleBuffered := True;

  if not FileExists(ExtractFilePath(ParamStr(0)) + 'Options.ini') then
   begin       // Si il existe pas on le cr�e avec valeurs par d�faut
    OptionRecord.RandomColors := True;
    OptionRecord.OneColorValue := 0;
    OptionRecord.InfoSounds := True;
    OptionRecord.BackMusic := True;
    WriteOptions(OptionRecord);
   end;

  OptionRecord := ReadOptions;
                  // On lit options et on affiche les billes
  ImgList.GetBitmap(2, GameIcon2.Picture.Bitmap);
  ImgList.GetBitmap(3, GameIcon3.Picture.Bitmap);
end;

procedure TGameForm.OptionLabelClick(Sender: TObject);
begin
  OptionsForm.ShowModal; // On affiche les options
end;

function TGameForm.GetLeftPawns: Byte;
Var
  A, B: Byte;
begin
  Result := 0;
  for A := 1 to 9 do
    for B := 1 to 9 do   // On r�cup�re le nombre de pions restants
      if Game[A, B].CellType = CTBille then Inc(Result);
end;

function TGameForm.GetOutPawns: Byte;
begin
  Result := 44 - GetLeftPawns; // On r�cup�re les pions qui ont �t� �limin�s
end;

procedure TGameForm.InitGame;
Var
  A, B: Byte;
begin
  for A := 1 to 9 do
    for B := 1 to 9 do
      begin
       Game[A, B].CellType := CTBille;
       Game[A, B].X := A;
       Game[A, B].Y := B;
       if OptionRecord.RandomColors then Game[A, B].Color := random(6)
        else
       Game[A, B].Color := OptionRecord.OneColorValue;
                 // On initialise le jeu
       Game[A, B].Selected := False;
       Game[A, B].Destination := False;

       if (A < 4) and (B < 4) then Game[A, B].CellType := CTNil;
       if (A > 6) and (B > 6) then Game[A, B].CellType := CTNil;
       if (A < 4) and (B > 6) then Game[A, B].CellType := CTNil;
       if (A > 6) and (B < 4) then Game[A, B].CellType := CTNil;
      end;

     Game[5, 5].CellType := CTEmpty;
end;

procedure TGameForm.DrawGame;
Var
  A, B: Byte;
  Bmp: TBitmap;
begin
  Bmp := TBitmap.Create;
  for A := 1 to 9 do
    for B := 1 to 9 do
      begin
       case Game[A, B].CellType of
        CTNil: ImgList.GetBitmap(0, Bmp);  // Rien ...
        CTEmpty: if not Game[A, B].Destination then ImgList.GetBitmap(1, Bmp)
                 else ImgList.GetBitmap(8, Bmp); // Un trou, on le dessine (sauf destination, sprite
        CTBille: ImgList.GetBitmap(Game[A, B].Color + 2, Bmp);             // different)
       end;       // Une bille, on dessine selon sa couleur
                    // On dessine le plateau
      Img.Canvas.Draw((A - 1) * 60, (B - 1) * 60, Bmp);

      if Game[A, B].Selected then
        begin                      // Si il est s�lectionn� on fait une jolie bordure bleue autour
          Img.Canvas.Brush.Style := bsClear;
          Img.Canvas.Pen.Color := clBlue;
          Img.Canvas.Pen.Width := 2;
          Img.Canvas.Rectangle((A - 1) * 60, (B - 1) * 60, A * 60, B * 60);
        end;
      end;

  Bmp.Free;
                  // On affiche les pions restants/enlev�s
  LeftPawnsLabel.Caption := 'Pions restants : ' + IntToStr(GetLeftPawns);
  OutPawnsLabel.Caption := 'Pions enlev�s : ' + IntToStr(GetOutPawns);

  if (CheckWin) and (not Finished) then Win;// On v�rifie victoire
end;

procedure TGameForm.Win;
begin
  TimeTimer.Enabled := False;
  UndoSelections;
  Finished := True;
  DrawGame;
  Img.Enabled := False;

  if GetLeftPawns = 1 then WinLabel.Caption := 'Gagn� !';
  if (GetLeftPawns in [2..8]) then WinLabel.Caption := 'Bien jou� !';
  if GetLeftPawns > 8 then WinLabel.Caption := 'Jeu fini !';
                       // Quand on gagne on affiche les stats et on bloque le jeu
  WinLabel.Visible := True;

  WinLabel2.Caption := 'Vous avez termin� avec ' + IntToStr(GetLeftPawns) + ' pions restants !';
  WinLabel2.Visible := True;
end;

procedure TGameForm.UndoSelections;
Var
  A, B: Byte;
begin
  for A := 1 to 9 do
    for B := 1 to 9 do  // On brise toutes les s�lections et destinations
      begin
        if Game[A, B].Selected then Game[A, B].Selected := False;
        if Game[A, B].Destination then Game[A, B].Destination := False;
      end;
end;

procedure TGameForm.MakeDestinations(X, Y: Byte);
begin                // On d�termine les destinations du pion par X, Y possibles
  if CanGoUp(X, Y) then Game[X, Y - 2].Destination := True;
  if CanGoDown(X, Y) then Game[X, Y + 2].Destination := True;
  if CanGoLeft(X, Y) then Game[X - 2, Y].Destination := True;
  if CanGoRight(X, Y) then Game[X + 2, Y].Destination := True;
end;

function TGameForm.GetSelectedPawn: TPoint;
Var
  A, B: Byte;
begin
  for A := 1 to 9 do
    for B := 1 to 9 do
      if Game[A, B].Selected then
       begin         // On r�cup�re le pion qui est s�lectionn�
        Result.X := A;
        Result.Y := B;
       end;
end;

procedure TGameForm.MovePawn(SelX, SelY, DestX, DestY: Byte);
Var
Dir: Byte;
begin
  Dir := 0;
     
  UndoSelections;
  if SelY < DestY then Dir := 1;
  if SelY > DestY then Dir := 2;  // On d�termine dans quelle direction va le pion
  if SelX < DestX then Dir := 3;
  if SelX > DestX then Dir := 4;

   case Dir of
    1: Game[SelX, SelY + 1].CellType := CTEmpty;
    2: Game[SelX, SelY - 1].CellType := CTEmpty;  // On d�truit le pion qui sera �limin�
    3: Game[SelX + 1, SelY].CellType := CTEmpty;
    4: Game[SelX - 1, SelY].CellType := CTEmpty;
   end;

  Game[DestX, DestY].CellType := Game[SelX, SelY].CellType;
  Game[DestX, DestY].Color := Game[SelX, SelY].Color;
  Game[DestX, DestY].Selected := False;
  Game[DestX, DestY].Destination := False; // On transmet les valeurs du pion qui bouge � sa destination
  Game[SelX, SelY].Destination := False;
  Game[SelX, SelY].Selected := False;
  Game[SelX, SelY].CellType := CTEmpty;
     // On enl�ve le pion qui vient de bouger
  UndoSelections;
  DrawGame;      // On brise s�lections et on redessine
end;

function TGameForm.CheckWin: Boolean;
Var
  A, B: Byte;
begin
     // On v�rifie si des mouvements sont toujours possibles
  Result := False;
  for A := 1 to 9 do
    for B := 1 to 9 do
      if Game[A, B].CellType = CTBille then
        begin               // Si jamais un mouvement est possible chez n'importe quelle bille, on quitte
          if CanGoUp(A, B) then Exit;
          if CanGoDown(A, B) then Exit;
          if CanGoLeft(A, B) then Exit;
          if CanGoRight(A, B) then Exit;
        end;
         // Si il a pass� le test des mouvements (c.a.d. aucune bille ne peut bouger) il a gagn�
  Result := True;
end;

procedure TGameForm.NewGameLabelClick(Sender: TObject);
begin
  TS := -1;
  TM := 0;
  TimeTimer.Enabled := True;
  TimeTimerTimer(self);
  Finished := False;       // Nouvelle partie
  WinLabel.Visible := False;
  WinLabel2.Visible := False;
  InitGame;
  DrawGame;
  Img.Enabled := True;
end;

procedure TGameForm.ImgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
Var
  A, B: Byte;
begin
  if Game[1, 1].CellType <> CTNil then Exit;
  A := (X div 60) + 1;
  B := (Y div 60) + 1; // Quand on clique sur une case, elle est identifi�e

  if not Game[A, B].Destination then UndoSelections  // Si c'est pas une destination alors on brise toutes les s�lections
    else MovePawn(GetSelectedPawn.X, GetSelectedPawn.Y, A, B);
                          // Sinon on bouge le pion
  if (not Game[A, B].Selected) and (not Game[A, B].Destination) and (Game[A, B].CellType = CTBille) then
    begin              // Si c'est pas s�lectionn�, ni une destination, et est une bille alors
      UndoSelections;   // On brise les s�lections
      Game[A, B].Selected := True; // On s�lectionne cette case
      MakeDestinations(A, B);   // On d�termine ses destinations possibles
    end;

  DrawGame;
end;

function TGameForm.CanGoUp(X, Y: Byte): Boolean;
begin
  Result := False;
  if Y <= 2 then Exit;  // Si il peut aller en haut
  if (Game[X, Y - 2].CellType = CTEmpty) and (Game[X, Y - 1].CellType = CTBille) then
  Result := True;
end;

function TGameForm.CanGoDown(X, Y: Byte): Boolean;
begin
  Result := False;
  if Y >= 8 then Exit; // Si il peut aller en bas
  if (Game[X, Y + 2].CellType = CTEmpty) and (Game[X, Y + 1].CellType = CTBille) then
  Result := True;
end;

function TGameForm.CanGoLeft(X, Y: Byte): Boolean;
begin
  Result := False;
  if X <= 2 then Exit;  // Si il peut aller � gauche
  if (Game[X - 2, Y].CellType = CTEmpty) and (Game[X - 1, Y].CellType = CTBille) then
  Result := True;
end;

function TGameForm.CanGoRight(X, Y: Byte): Boolean;
begin
  Result := False;
  if X >= 8 then Exit; // Si il peut aller � droite
  if (Game[X + 2, Y].CellType = CTEmpty) and (Game[X + 1, Y].CellType = CTBille) then
  Result := True;
end;

procedure TGameForm.TimeTimerTimer(Sender: TObject);
Var
  SS, SM: String;
begin
  Inc(TS);
  if TS > 59 then
    begin
      Inc(TM);
      TS := 0;
    end;

  if TS < 10 then
    SS := '0' + IntToStr(TS)
  else
    SS := IntToStr(TS);
                     // On fait de notre mieux pour incr�menter le temps et l'afficher correctement
  if TM < 10 then
    SM := '0' + IntToStr(TM)
  else
    SM := IntToStr(TM);

  if TimeLabel.Caption[18] = ' ' then
    TimeLabel.Caption := 'Temps �coul� : ' + SM + ':' + SS
  else
    TimeLabel.Caption := 'Temps �coul� : ' + SM + ' ' + SS;
end;

function TGameForm.ReadOptions: TOptionRecord;
Var
  F: TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Options.ini');
  Result.RandomColors := F.ReadBool('Color_Options', 'Random_colors', True);
  Result.OneColorValue := F.ReadInteger('Color_Options', 'Single_Color_Value', 0);
  Result.InfoSounds := F.ReadBool('Sound_Options', 'Information_Sounds', True);
  Result.BackMusic := F.ReadBool('Sound_Options', 'Back_Music', True);
  F.UpdateFile; // On lit les options du fichier Ini
  F.Free;
end;

procedure TGameForm.WriteOptions(OptionData: TOptionRecord);
Var
  F: TIniFile;
begin
  F := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'Options.ini');
  F.WriteBool('Color_Options', 'Random_colors', OptionData.RandomColors);
  F.WriteInteger('Color_Options', 'Single_Color_Value', OptionData.OneColorValue);
  F.WriteBool('Sound_Options', 'Information_Sounds', OptionData.InfoSounds);
  F.WriteBool('Sound_Options', 'Back_Music', OptionData.BackMusic);
  F.UpdateFile;  // On �crit dans le fichier Ini les options
  F.Free;
end;

procedure TGameForm.VersionLabel2Click(Sender: TObject);
begin
  AboutForm.ShowModal; // On affiche la boite � propos
end;

end.
