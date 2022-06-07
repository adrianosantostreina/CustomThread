unit Unit2;

interface

uses
  CustomThread,

  FMX.Controls,
  FMX.Controls.Presentation,
  FMX.Dialogs,
  FMX.Forms,
  FMX.Graphics,
  FMX.Layouts,
  FMX.Objects,
  FMX.StdCtrls,
  FMX.Types,

  System.Classes,
  System.SysUtils,
  System.Types,
  System.UITypes,
  System.Variants;

type
  TForm2 = class(TForm)
    recBack: TRectangle;
    LytProgress: TLayout;
    recProgress: TRectangle;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    private
      { Private declarations }
      StepUnit: Single;
      Step : Single;
    public
      { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}

procedure TForm2.FormCreate(Sender: TObject);
begin
  StepUnit := 0;
  Step := 0;
  recProgress.Width := 0;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
  TLib.CustomThread(
    procedure()
    begin
      StepUnit := (recBack.Width / 10);
      recProgress.Width := Step;
    end,
    procedure()
    begin
      repeat
        Step := Step + StepUnit;
        TThread.Synchronize(
          TThread.CurrentThread,
          procedure ()
          begin
            Sleep(100);
            recProgress.Width := Step;
          end
        );
      until recProgress.Width >= recBack.Width;
    end,
    procedure()
    begin
      Step := 0;
    end,
    procedure(const AException: string)
    begin

    end,
    True
  );
end;

end.
