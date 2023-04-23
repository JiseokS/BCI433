000100200323       DCL-F SQLDSP WORKSTN;
000101200323
000102200323       DCL-S  ShipCityNull BinDec (4:0);
000103200323       DCL-S  DiscountNull BinDec (4:0);
000104200330
000105200330       DCL-S EndOfFile    IND;
000106200330
000107200330       DCL-DS CustomerRecord;
000108200330               CustId    Char(5);
000109200330               Name      Char(15);
000110200330               ShipCity  Char(15);
000111200330               Discount  Packed(2:2);
000113200330       End-Ds CustomerRecord;
000114200330
000115200330       EXSR PrepareFiles;
000116200330       EXSR GetRow;
000117200330
000118200330       DOW NOT (ENDOFFILE);
000130200323
000131200330          If ShipCityNull = -1;
000132200330             ShipCity = 'Unknown';
000133200330          EndIf;
000134200330          If DiscountNull = -1;
000135200330             *in99 = *on;
000136200330          Else;
000137200330             *in99 = *off;
000138200330          EndIf;
000139200330          Select;
000140200323           when SQLCode = 100;
000142200323             EXFMT Record3;
000143200323           when SQLCode <> 0 or SQLWN0 = 'W';
000145200323             EXFMT Record4;
000146200323           other;
000148200323             EXFMT Record2;
000149200330          ENDSL;
000150200323
000151200330          EXSR GetRow;
000152200330          If *IN03 = *ON;
000153200330             ENDOFFILE = *ON;
000154200330          ENDIF;
000155200330       ENDDO;
000156200330       EXSR WrapUp;
000157200330       *INLR = *ON;
000158200330       Return;
000159200330
000160200330        BEGSR  PrepareFiles;
000161200330        // S E T   U P   T H E   T E M P O R A R Y   R E S U L T  S T R U C T U
000162200330       EXEC SQL
000163200330              DECLARE CUSTCURSOR CURSOR
000164200330            FOR
000165200330            SELECT    CUSTID,
000166200330                      NAME,
000167200330                      SHIPCITY,
000168200330                      DISCOUNT
000169200330            FROM      BCI433LIB/CUSTOMER
000170200330            ORDER BY Discount
000181200330            FOR READ ONLY;
000182200330
000183200330        // A   T E M P O R A R Y   R E S U L T   T A B L E   I S   C R E A T E D
000184200330        EXEC SQL
000185200330             OPEN CUSTCURSOR;
000186200330
000187200330
000188200330             If SQLCODE <> 0 OR SQLWN0 = 'W';
000189200330                EndOfFile = *ON;
000190200330             EndIf;
000191200330        ENDSR;
000192200330           BEGSR     GETROW;
000193200330        EXEC SQL
000194200330             FETCH NEXT
000195200330             FROM  CUSTCURSOR
000196200330             INTO :CustID,
000197200330                  :Name,
000198200330                  :ShipCity :ShipCityNull,
000199200330                  :Discount :DiscountNull;
000200200330
000201200330
000202200330             If SQLCODE <> 0 OR SQLWN0 = 'W';
000203200330                EndOfFile = *ON;
000204200330             EndIf;
000205200330
000206200330             ENDSR;
000207200330            BEGSR WRAPUP;
000208200330        EXEC SQL
000209200330             CLOSE CUSTCURSOR;
000210200330
000211200330
000212200330             If SQLCODE <> 0 OR SQLWN0 = 'W';
000213200330                EndOfFile = *ON;
000214200330             EndIf;
000215200330             ENDSR;
000216200330
000217200330
