000100220628      //***********************************************************************
000200220628      //* THIS PROGRAM USES A CURSOR TO LOAD A TEMPORARY RESULT TABLE FROM 3
000300220720      //* SEPARATE TABLES, CUSTOMER2, ORDER1 AND ORDERLINE. A NUMBER IS PASSED
000400220628      //* TO THE PROGRAM TO DETERMINE WHICH RECORDS ARE INLCUDED
000500220628      //***********************************************************************
000600211111           DCL-F CUSTREPORT PRINTER OFLIND(*IN01) ;
000700211111           DCL-S OrderNumH    PACKED(5:0);
000800220628      // Declare an indicator to handle end of result set (file)
000900230404           DCL-S EndOfFile IND;
001000220628
001100220628      // All Host Variables available under a single name
001200220628
001300230404           DCL-DS OrdersRecord;
001301230404             CustName  Char(31);
001302230404             OrderNum  Packed(5:0);
001303230404             OrderDate Date;
001304230404             PartNum   Char(4);
001305230404             Quantity  Packed(3:0);
001306230404             QtPrice   Packed(6:2);
001307230404             ExtPrice  Packed(7:2);
001309230404           END-DS;
002500220628       // LimitIn is passed to the program
002600220628
002601230405           Dcl-PI Main extPgm('ORDERSSQL');
002602230405             LimitIn Packed(15:5);
002603230405           END-PI;
003300230405
003400220628
003500220627                SpendLimit = LimitIn;
003600100309                EXSR PrepareFiles;
003700211111                Write ReporTitle;
003800211104                Write ColHeading;
003900100309                EXSR GetRow;
004000221202                If NOT EndOfFile;
004100221202                  Write NextCust;
004200221202                  OrderNumH = OrderNum;
004300221202                EndIf;
004400070202                DOW NOT EndOfFile;
004500190313                    IF *IN01 = *ON;
004600211111                        Write ReporTitle;
004700211104                        Write ColHeading;
004800190313                       *IN01 = *OFF;
004900070209                    ENDIF;
005000220628                    // Handle Control Breaks on Order Number
005100220628
005200230405                    IF OrderNumH = OrderNum;
005201230404                      Write OrdDetail;
005202230404                    ELSE;
005203230405                      OrderNumH = OrderNum;
005204230404                      Write OrdTotal;
005205230404                      TotalAll = TotalAll + TotalOrd;
005206230404                      TotalOrd = 0;
005207230405                      Write NextCust;
005208230404                      Write OrdDetail;
005209230404                    ENDIF;
006600220628
006700211111                    TotalOrd = TotalOrd + ExtPrice;
006800100309                    EXSR GetRow;
006900070119                ENDDO;
007000211111                Write OrdTotal;
007100211111                TotalAll = TotalAll + TotalOrd;
007200211111                Write AllOrders;
007300070202                EXSR   WRAPUP;
007400220627                Write NotInclude;
007500070119                *INLR = *ON;
007600070119                RETURN;
007700100309        //**********************************************************************
007800100309        // O P E N F I L E S   S U B R O U T I N E
007900100309        //**********************************************************************
008000100309         BEGSR  PrepareFiles;
008100220628        // S E T   U P   T H E   T E M P O R A R Y   R E S U L T  S T R U C T U
008200230404         EXEC SQL
008201230404          DECLARE ORDERSCURSOR CURSOR
008202230404            FOR
008300230404          SELECT TRIM(FIRST_NAME) || ' ' || LAST_NAME AS CUSTOMER,
008301230404                 O.ORDER_NUMBER,
008302230404                 ORDER_DATE,
008303230404                 PART_NUMBER,
008304230404                 OL.NUMBER_ORDERED,
008305230404                 QUOTED_PRICE,
008306230404                 NUMBER_ORDERED * QUOTED_PRICE
008307230404          FROM   BCI433LIB/CUSTOMER2 C, BCI433LIB/ORDER1 O,
008308230404                 BCI433LIB/ORDERLINE  OL
008309230404          WHERE  C.CUSTOMER_NUMBER = O.CUSTOMER_NUMBER AND
008310230404                 O.ORDER_NUMBER = OL.ORDER_NUMBER      AND
008311230418                 NUMBER_ORDERED * QUOTED_PRICE > 100;
008400220628
008500230404          EXEC SQL
008501230404           OPEN ORDERSCURSOR;
008502230404          IF SQLCODE <> 0 OR SQLWN0 = 'W';
008503230404            ENDOFFILE = *ON;
008504230404          ENDIF;
008600220628
008700220628
008800220628
008900220628
009000220628
009100220628
009200220628
009300220628
009400220628
009500220628
009600220628
009700220628
009800220628
009900220628
010000220628
010100220628
010200220628
010300100309
010400100309        // A   T E M P O R A R Y   R E S U L T   T A B L E   I S   C R E A T E D
010800220628
010900220628
011000220628
011100220628
011200220628
011300220628
011400220628
011500100309
011600100309            ENDSR;
011700100309        //**********************************************************************
011800100309        //   G E T     R O W    S U B R O U T I N E
011900100309        //**********************************************************************
012000100309            BEGSR     GETROW;
012100230404              EXEC SQL
012101230404                FETCH NEXT
012102230404                  FROM ORDERSCURSOR
012103230404                  INTO :OrdersRecord;
012104230404            IF SQLCODE <> 0 OR SQLWN0 = 'W';
012105230404              ENDOFFILE = *ON;
012106230404            ENDIF;
012107230404
013300100309             ENDSR;
013400100309        //**********************************************************************
013500100309        // W R A P U P     S U B R O U T I N E
013600100309        //**********************************************************************
013700100309           BEGSR WRAPUP;
013800220627
013900230404           EXEC SQL
013901230404             CLOSE OrdersCursor;
013902230404
014000230404           IF SQLCODE <> 0 OR SQLWN0 = 'W';
014001230405             ENDOFFILE = *ON;
014002230404           ENDIF;
014100220628
014200220628
014300220628
014400220628
014500220628
014600220628
014700220628
014800220628
014900220628
015000220628
015100220628
015200220628
015300220628
015400220628
015500220628
015600220628
015700100309          ENDSR;
