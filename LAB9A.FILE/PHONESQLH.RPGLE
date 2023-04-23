000100220628        // ********************************************************************
000200230319        //  Customer23 READ BY NATIVE LANGUAGE (ILE RPG)
000300230319        // Contacts23 ROW RETRIEVED WITH EMBEDDED SQL
000400230319        //  DETAIL REPORT LINE INCLUDES INFORMATION FROM Customer23 AND CONTACTW
000500190313        //  SUMMARRY REPORT INFORMATION RETRIEVED WITH EMBEDDED SQL STATEMENTS
000600190314
000700220628           DCL-F PHNREPORT  PRINTER OFLIND(*IN01) ;
000800230319           DCL-F Customer23 DISK(*EXT) KEYED USAGE(*INPUT)
000900230319                 RENAME(Customer23:CUSTR);
000901230319       // data structure for host variables fromContacts23
001000220628
001001220628
001002220628       // Standalone fields for indicator variables
001003220628
001004220628
001005220628
001006220628
001300190314           DCL-S Dummy  Zoned(1);
001500190314        //**********************************************************************
001600190314        //*                        ***   M A I N   R O U T I N E   ***
001700190314        //**********************************************************************
001800190314
001900070119                EXSR SummaryInfo;
002000200709                WRITE NEWPAGE;
002100230319                READ Customer23;
002200070119                DOW NOT %EOF;
002300070119                    EXSR SQLSelect;
002900190313                    IF *IN01 = *ON;
003000200709                       Write NEWPAGE;
003100190313                       *IN01 = *OFF;
003200070119                    ENDIF;
003300200709                    Write RPTLINE;
003400230319                   READ Customer23;
003500070119                ENDDO;
003600190313                Write SUMMARY;
003700070119                *INLR = *ON;
003800070119                RETURN;
003900080923        //**********************************************************************
004000080923        //   S Q L S E L E C T   S U B R O U T I N E
004100220628        //********************************************************************
004200220628                       BEGSR    SQLSelect ;
004300220628         // A row from the Contacts table that has the same customer number as t
004400230319         // record read from the Customer23 file is retrieved to find out the last
004500220628         // called, phone number, comments and the salesperson number.
004600220628
004700220628         //  The call back interval is added to the last date called to determin
004800220628         //  next date to call.  Since null values may be stored in the last dat
004900220628         // indicator variables are used.
005000220628           ErrorMsg = ' ';
005001220628
005002220628
005003220628
005004220628
005005220628
005006220628
005007220628
005008220628
005009220628
005010220628
005011220628
005012220628
005013220628
005014220628
005015220628
005016220628
005017220628
005018220628
005019220628
005020220628
005021220628
005022220628
005023220628
005024220628
005025220628
005026220628
005027220628
005028220628
005029220628
005030220628
005031220628
005032220628
005033220628
005034220628
005035220628
005036220628
005037220628
005038220628
005039220628
005040220628
005041220628
005042220628
005043220628
005044220628
009000220628           ENDSR ;
009100080923        //**********************************************************************
009200080923        // S U M M A R Y I N F O   S U B R O U T I N E
009300080923        //**********************************************************************
009400080923                         BEGSR  SummaryInfo;
009500220623
009600230319        //  D E T E R M I N E   T O T A L S   F O R  Contacts23 & Customer23
009601220628
009602220628
009603220628
009604220628
009605220628
009606220628
009607220628
009608220628
009609220628
009610220628
011300220628        // D E T E R M I N E   N U M B E R   O F   U N K N O W N   LAST DATE CAL
011301220628
011302220628
011303220628
011304220628
011305220628
011306220628
011307220628
011308220628
011309220628
011310220628
012300220628        //  D E T E R M I N E   O L D E S T   &  M O S T   R E C E N T  LAST DAT
012301220628
012302220628
012303220628
012304220628
012305220628
012306220628
012307220628
012308220628
012309220628
012310220628
013300080923
014400080923
014500220628       // D E T E R M I N E   T H E   U S E R   S E R V E R   &   T I M E S T A
014600220628       // SYSIBM/SYSDUMMY1 from System registers,Don't need check SQLCODE
014601220628
014602220628
014603220628
014604220628
014605220628
014606220628
015200220628       ENDSR;
