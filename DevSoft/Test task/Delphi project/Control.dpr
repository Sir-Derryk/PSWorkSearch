program Control;

uses
  Vcl.Forms,
  Main in 'Main.pas' {MainForm},
  MyCustomControl in 'MyCustomControl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
