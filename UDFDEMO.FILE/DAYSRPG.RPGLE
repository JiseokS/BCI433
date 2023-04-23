000100200402          DCL-f DayDsp Workstn;
000201200726          Dcl-PI  Main  extPgm('DAYSRPG');
000202200726             Solution   char(15);
000203200726         End-PI;
000204200727
000300221029      /COPY UDFDEMO,DAYPROTO
000400200402
000500200402           EXFMT INPUT;
000600170918           DOW NOT(*IN03);
000700200402              DayName = DayNumName(DayIn);
000800190327              *in99 = *on;
000900200402               WRITE INPUT;
001000200402               EXFMT OUTPUT;
001100190327              *in99 = *off;
001200170918               IF *IN03 = '0';
001300200402                 DayIn = 0;
001400200402                 EXFMT INPUT ;
001500170918               ENDIF;
001600170918            ENDDO;
001700170918            *INLR = *ON;
001800170918            RETURN;
001900170918
002000170918
