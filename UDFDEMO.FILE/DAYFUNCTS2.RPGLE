000100990120
000200990120
000400990120
000500181024       Ctl-Opt NoMain DatFmt(*USA) ;
000600960408
000900221029        /COPY UDFDEMO,DAYPROTO
001000181024
001100200405       Dcl-Proc DayNumName  EXPORT;
001200181024
001300181024         Dcl-Pi *n  Char(9);
001400200405           Number Packed(1:0);
001500181024         End-Pi;
001600181024
001700181024         Dcl-DS DayData;
001800181024           *n Char(9) Inz('Monday');
001900181024           *n Char(9) Inz('Tuesday');
002000181024           *n Char(9) Inz('Wednesday');
002100181024           *n Char(9) Inz('Thursday');
002200181024           *n Char(9) Inz('Friday');
002300181024           *n Char(9) Inz('Saturday');
002400181024           *n Char(9) Inz('Sunday');
002500181024
002600210407           DayArray Char(9) Dim(7) POS(1);
002800181024         End-DS;
002900181024
003000200405         Return DayArray(Number);
003100181024
003200181024       End-Proc;
003300960402
