*{Bench}prg-comment
* HRRCB1IF.cbl
* HRRCB1IF.cbl is generated from C:\AIFL\HRG.DIR\HRRCB1IF.Psf
*{Bench}end
 IDENTIFICATION              DIVISION.
*{Bench}prgid
 PROGRAM-ID. HRRCB1IF.
 AUTHOR. saltyfish.chang.
 DATE-WRITTEN. 2012年12月10日 上午 10:05:42.
 REMARKS.
*{Bench}end

 ENVIRONMENT                 DIVISION.
 CONFIGURATION               SECTION.
 SPECIAL-NAMES.
*{Bench}activex-def
*{Bench}end
*{Bench}decimal-point
*{Bench}end
 INPUT-OUTPUT                SECTION.
 FILE-CONTROL.
*{Bench}file-control
*{Bench}end
*{TAMIS}file-control
*COPY    "HG_NID.SEL".
*
 SELECT NID-MST
    ASSIGN       TO DISK "HG_MNID"
    WITH COMPRESSION
    COMPRESSION CONTROL VALUE  70
    ORGANIZATION IS INDEXED
    ACCESS MODE  IS DYNAMIC
    LOCK MODE    IS MANUAL
    FILE STATUS  IS NID-MST-STATUS
    RECORD KEY   IS NID-MST-KEY
    ALTERNATE RECORD KEY IS NID-ALT-KEY1 = NID-ID, NID-NAME, NID-CODE
    ALTERNATE RECORD KEY IS NID-ALT-KEY2 = NID-ID, NID-TRN, NID-CODE.
*COPY    "HH_PAT.SEL".
 SELECT PAT-MST
    ASSIGN       TO DISK "HH_MPAT"
    WITH COMPRESSION
    COMPRESSION CONTROL VALUE  70
    ORGANIZATION IS INDEXED
    ACCESS MODE  IS DYNAMIC
    LOCK MODE    IS MANUAL
    FILE STATUS  IS PAT-MST-STATUS
    RECORD KEY   IS PAT-MST-KEY = PAT-NO
    ALTERNATE RECORD KEY IS PAT-ALT-KEY1 = PAT-NAME, PAT-BIRTH-DT,
    PAT-NO
    ALTERNATE RECORD KEY IS PAT-ALT-KEY2 = PAT-IDNO, PAT-NO.
*COPY    "HI_IPD.SEL".
 SELECT IPD-MST
    ASSIGN       TO DISK "HI_MIPD"
    WITH COMPRESSION
    COMPRESSION CONTROL VALUE  70
    ORGANIZATION IS INDEXED
    ACCESS MODE  IS DYNAMIC

    LOCK MODE    IS MANUAL
    FILE STATUS  IS IPD-MST-STATUS
    RECORD KEY   IS IPD-MST-KEY = IPD-NO
    ALTERNATE RECORD KEY IS IPD-ALT-KEY1 = IPD-PAT-NO, IPD-NO
    ALTERNATE RECORD KEY IS IPD-ALT-KEY2 = IPD-LEAVE-DT, IPD-PAT-NO,
    IPD-NO
    ALTERNATE RECORD KEY IS IPD-ALT-KEY3 = IPD-LEAVE-DT, IPD-NAME,
    IPD-NO
    ALTERNATE RECORD KEY IS IPD-ALT-KEY4 = IPD-LEAVE-DT, IPD-BED, IPD-NO
    ALTERNATE RECORD KEY IS IPD-ALT-KEY5 = IPD-LEAVE-DT, IPD-DPT, IPD-NO
    ALTERNATE RECORD KEY IS IPD-ALT-KEY6 = IPD-LEAVE-DT, IPD-MJ-DR,
    IPD-NO
    ALTERNATE RECORD KEY IS IPD-ALT-KEY7 = IPD-PAT-NO, IPD-OUT-DT,
    IPD-NO
    ALTERNATE RECORD KEY IS IPD-ALT-KEY8 = IPD-OUT-DT, IPD-NO
    ALTERNATE RECORD KEY IS IPD-ALT-KEY9 = IPD-OUT-DT, IPD-PAT-NO,
    IPD-NO
    ALTERNATE RECORD KEY IS IPD-ALT-KEY10 = IPD-OUT-DT, IPD-BED, IPD-NO
    ALTERNATE RECORD KEY IS IPD-ALT-KEY11 = IPD-CASE, IPD-DPT,
    IPD-OUT-DT, IPD-NO, IPD-ASK-SEQ
    ALTERNATE RECORD KEY IS IPD-ALT-KEY12 = IPD-OUT-DT, IPD-UNIT,
    IPD-NO.
*COPY    "HI_IPX.SEL".
*---------------------------------------------------------------------*
*> 住院主檔延伸檔：HI_IPX.SEL                          檔案：HI_MIPX  *
*---------------------------------------------------------------------*
        SELECT IPX-MST  ASSIGN TO DISK "HI_MIPX"
                        WITH COMPRESSION
                        ORGANIZATION INDEXED
                        ACCESS DYNAMIC
                        LOCK MANUAL
                        STATUS IPX-MST-STATUS
                        RECORD KEY
                        IPX-MST-KEY  =  IPX-LIVE-ID IPX-NO
                        ALTERNATE KEY
                        IPX-ALT-KEY1 =  IPX-LIVE-ID IPX-DT     IPX-NO
                        ALTERNATE KEY
                        IPX-ALT-KEY2 =  IPX-LIVE-ID IPX-OUT-DT IPX-DT IPX-NO
                        ALTERNATE KEY
                        IPX-ALT-KEY3 =  IPX-LIVE-ID IPX-PAT-NO IPX-DT-V IPX-NO-V
                        ALTERNATE KEY
                        IPX-ALT-KEY4 =  IPX-LIVE-ID IPX-ALT-1  IPX-NO
                        ALTERNATE KEY
                        IPX-ALT-KEY5 =  IPX-LIVE-ID IPX-ALT-2  IPX-NO.

*---------------------------------------------------------------------*
*>      ＥＮＤ　ＯＦ　ＣＯＰＹ　ＦＩＬＥ　
*---------------------------------------------------------------------*

*COPY    "HI_ICA.SEL".
* 住院處方檔
        SELECT  ICA-MST
                ASSIGN TO "HI_MICA"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL

                RECORD KEY   ICA-KEY
                ALTERNATE RECORD KEY ICA-ODR-NO
                STATUS  ICA-MST-STATUS.
*COPY    "HI_ICB.SEL".
* 住院處方明細檔
        SELECT  ICB-MST
                ASSIGN TO "HI_MICB"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL
                RECORD KEY   ICB-KEY
                ALTERNATE KEY
                ICB-ALT-KEY1 = ICB-FEE-KEY ICB-FEE-SEQ ICB-ODR-NO
                               ICB-IPD-NO
                ALTERNATE KEY
                ICB-ALT-KEY2 = ICB-IPD-NO ICB-FEE-KEY ICB-ODR-NO ICB-FEE-SEQ
                STATUS  ICB-MST-STATUS.
*COPY    "HI_ECB.SEL".
*> 住院處方明細延伸檔
        SELECT  ECB-MST
                ASSIGN TO "HI_MECB"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL
                RECORD KEY   ECB-KEY
                ALTERNATE KEY
                ECB-ALT-KEY1 = ECB-DEL-MARK ECB-FEE-KEY ECB-ODR-NO ECB-IPD-NO ECB-FEE-SEQ
                ALTERNATE KEY
                ECB-ALT-KEY2 = ECB-DEL-MARK ECB-IPD-NO ECB-TYPE ECB-ODR-NO-V ECB-FEE-SEQ
                STATUS  ECB-MST-STATUS.

*COPY    "HI_BED.SEL".
 SELECT BED-MST  ASSIGN TO DISK "HI_MBED"
                 WITH COMPRESSION
                 ORGANIZATION INDEXED
                 ACCESS DYNAMIC
                 LOCK MANUAL
                 STATUS BED-MST-STATUS
                 RECORD KEY
                 BED-MST-KEY  =  BED-BED
                 ALTERNATE KEY
                 BED-ALT-KEY1 =  BED-GRD  BED-BED
                 ALTERNATE KEY
                 BED-ALT-KEY2 =  BED-DPT  BED-BED
                 ALTERNATE KEY
                 BED-ALT-KEY3 =  BED-DR   BED-BED
                 ALTERNATE KEY
                 BED-ALT-KEY4 =  BED-UNIT BED-BED
                 ALTERNATE KEY
                 BED-ALT-KEY5 =  BED-STATUS  BED-BED
                 ALTERNATE KEY
                 BED-ALT-KEY6 =  BED-STATUS  BED-GRD  BED-BED
                 ALTERNATE KEY
                 BED-ALT-KEY7 =  BED-STATUS  BED-DPT  BED-BED
                 ALTERNATE KEY

                 BED-ALT-KEY8 =  BED-STATUS  BED-DR   BED-BED
                 ALTERNATE KEY
                 BED-ALT-KEY9 =  BED-STATUS  BED-UNIT BED-BED.



*COPY    "HO_PRS.SEL".
 SELECT PRS-MST  ASSIGN TO DISK "HO_MPRS"
                 WITH COMPRESSION
                 ORGANIZATION INDEXED
                 ACCESS DYNAMIC
                 LOCK MANUAL
                 STATUS PRS-MST-STATUS
                 RECORD KEY
                 PRS-MST-KEY  =  PRS-MST-ID
                 ALTERNATE KEY
                 PRS-ALT-KEY1 =  PRS-INS-ID PRS-MST-ID
                 ALTERNATE KEY
                 PRS-ALT-KEY2 =  PRS-FEE-KND PRS-MST-ID
                 ALTERNATE KEY
                 PRS-ALT-KEY3 =  PRS-STK-CNT PRS-MST-ID
                 ALTERNATE KEY
                 PRS-ALT-KEY4 =  PRS-ID-NAME PRS-MST-ID
                 ALTERNATE KEY
                 PRS-ALT-KEY5 =  PRS-BRF-ID PRS-MST-ID.

*COPY    "HI_FON.SEL".
*-------------------------------------------------------------------------------
*>      住院鍵值檔　HI_FON.SEL
*-------------------------------------------------------------------------------
        SELECT FON-MST  ASSIGN TO DISK "HI_MFON"
                        WITH COMPRESSION
                        ORGANIZATION INDEXED
                        ACCESS DYNAMIC
                        LOCK MANUAL
                        STATUS FON-MST-STATUS
                        RECORD KEY FON-MST-KEY
                        ALTERNATE KEY
                        FON-ALT-KEY1 =  FON-ID FON-TRN FON-CODE.
*-------------------------------------------------------------------------------
*>      ＥＮＤ　ＯＦ　ＣＯＰＹ　ＦＩＬＥ　
*-------------------------------------------------------------------------------
*COPY    "HI_DTE.SEL".
*
        SELECT DTE-MST  ASSIGN TO DISK "HI_MDTE"
                        WITH COMPRESSION
                        ORGANIZATION INDEXED
                        ACCESS DYNAMIC
                        LOCK MANUAL
                        STATUS DTE-MST-STATUS
                        RECORD KEY DTE-MST-KEY.
*COPY    "HI_GCA.SEL".
*-------------------------------------------------------------------------------
*>      住院處方異動記錄檔　HI_GCA.SEL
*-------------------------------------------------------------------------------
        SELECT HIGCA-MST  ASSIGN TO DISK "HI_MGCA"
                        WITH COMPRESSION

                        ORGANIZATION INDEXED
                        ACCESS DYNAMIC
                        LOCK MANUAL
                        STATUS HIGCA-MST-STATUS
                        RECORD KEY      HIGCA-KEY
                        ALTERNATE KEY
                        GCA-ALT-KEY1 =  HIGCA-DTI HIGCA-IPD-NO HIGCA-ODR-NO
                        ALTERNATE KEY
                        GCA-ALT-KEY2 =  HIGCA-IPD-NO HIGCA-DTI HIGCA-ODR-NO.
*-------------------------------------------------------------------------------
*>      ＥＮＤ　ＯＦ　ＣＯＰＹ　ＦＩＬＥ　
*-------------------------------------------------------------------------------
*COPY    "HI_GCB.SEL".
*-------------------------------------------------------------------------------
*>      住院處方明細異動記錄檔　HI_GCB.SEL      (含HI_ICB.MST, HI_ECB.MST)
*-------------------------------------------------------------------------------
        SELECT  HIGCB-MST
                ASSIGN TO "HI_MGCB"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL
                RECORD KEY   HIGCB-KEY
                ALTERNATE KEY
                HIGCB-ALT-KEY1 = HIGCB-IPD-NO HIGCB-FEE-KEY HIGCB-DTI HIGCB-ODR-NO HIGCB-FEE-SEQ
                STATUS  HIGCB-MST-STATUS.
*-------------------------------------------------------------------------------
*>      ＥＮＤ　ＯＦ　ＣＯＰＹ　ＦＩＬＥ　
*-------------------------------------------------------------------------------
*COPY    "HO_PEF.SEL".
 SELECT PEF-MST  ASSIGN TO DISK "HO_MPEF"
                 WITH COMPRESSION
                 ORGANIZATION INDEXED
                 ACCESS DYNAMIC
                 LOCK MANUAL
                 STATUS PEF-MST-STATUS
                 RECORD KEY
                 PEF-MST-KEY  =  PEF-CODE.
*COPY    "HR_ELC.SEL".
*
        SELECT ELC-TRN  ASSIGN TO DISK "HR_TELC"
                        WITH COMPRESSION
                        ORGANIZATION INDEXED
                        ACCESS DYNAMIC
                        LOCK MANUAL
                        STATUS ELC-TRN-STATUS
                        RECORD KEY
                        ELC-TRN-KEY = ELC-SYS ELC-KEY
                        ALTERNATE KEY
                        ELC-TRN-KEY1 = ELC-SYS ELC-UPD ELC-KEY.
*
*COPY    "HR_IBG.SEL".
*
        SELECT IBG-MST  ASSIGN TO DISK "HR_MIBG"
                        WITH COMPRESSION
                        ORGANIZATION INDEXED
                        ACCESS DYNAMIC

                        LOCK MANUAL
                        STATUS IBG-MST-STATUS
                        RECORD KEY
                        IBG-MST-KEY  =  IBG-UNIT-NO IBG-DT IBG-SEQ
                        ALTERNATE KEY
                        IBG-ALT-KEY1 =  IBG-UNIT-NO IBG-DT IBG-PRINT-MARK
                                        IBG-SEQ.
*
*COPY    "HR_RNU.SEL".
*
        SELECT RNU-MST  ASSIGN TO DISK "HR_MRNU"
                        WITH COMPRESSION
                        ORGANIZATION INDEXED
                        ACCESS DYNAMIC
                        LOCK MANUAL
                        STATUS RNU-MST-STATUS
                        RECORD KEY
                        RNU-MST-KEY  =  RNU-KEY.
*
*COPY    "HR_FNS.SEL".
*
        SELECT FNS-MST  ASSIGN TO DISK "HR_MFNS"
                        WITH COMPRESSION
                        ORGANIZATION INDEXED
                        ACCESS DYNAMIC
                        LOCK MANUAL
                        STATUS FNS-MST-STATUS
                        RECORD KEY
                        FNS-MST-KEY  = FNS-ID FNS-P-KEY
                        ALTERNATE KEY
                        FNS-ALT-KEY1 = FNS-ID FNS-A-KEY FNS-P-KEY
                        ALTERNATE KEY
                        FNS-ALT-KEY2 = FNS-ID FNS-B-KEY FNS-P-KEY.
*
*COPY    "HR_DTA.SEL".
*---------------------------------------------------------------------*
* 檢驗取消處方檔：HR_DTA.SEL                          檔案：HR_MDTA   *
*---------------------------------------------------------------------*
* 主：HRDTA-MST-KEY  = HRDTA-KEY                                      *
*---------------------------------------------------------------------*
        SELECT  HRDTA-MST
                ASSIGN TO "HR_MDTA"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL
                RECORD KEY
                HRDTA-MST-KEY = HRDTA-KEY
                STATUS  HRDTA-MST-STATUS.
***********************************************************************
* END *
***********************************************************************
*COPY    "HR_DTB.SEL".
*---------------------------------------------------------------------*
* 檢驗取消細項檔：HR_DTB.MST                          檔案：HR_MDTB   *
*---------------------------------------------------------------------*
* 主：HRDTB-MST-KEY  = HRDTB-KEY + HRDTB-FEE-SEQ                      *

*---------------------------------------------------------------------*
        SELECT  HRDTB-MST
                ASSIGN TO "HR_MDTB"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL
                RECORD KEY
                HRDTB-MST-KEY = HRDTB-KEY HRDTB-FEE-SEQ
                STATUS  HRDTB-MST-STATUS.
***********************************************************************
* END *
***********************************************************************
*------->檢驗檢查放射線檔!
*COPY    "HT_SYS.SEL".
 SELECT  HTSYS-SON
         ASSIGN TO DISK "HT_SSYS"
         WITH COMPRESSION
         ORGANIZATION INDEXED
         ACCESS DYNAMIC
         LOCK MANUAL
         STATUS HTSYS-SON-STATUS
         RECORD KEY
         HTSYS-KEY.
*COPY    "HT_DPT.SEL".
**
*

 SELECT HTDPT-MST
    ASSIGN       TO  "HT_MDPT"
    WITH COMPRESSION
    COMPRESSION CONTROL VALUE  70
    ORGANIZATION IS INDEXED
    ACCESS MODE  IS DYNAMIC
    LOCK MODE    IS MANUAL
    FILE STATUS  IS HTDPT-MST-STATUS
    RECORD KEY   IS HTDPT-KEY
    ALTERNATE RECORD KEY IS HTDPT-ALT-KEY = HTDPT-DPT-NO.
*COPY    "HT_CHK.SEL".
 SELECT  HTCHK-MST
         ASSIGN TO DISK "HT_MCHK"
         WITH COMPRESSION
         ORGANIZATION INDEXED
         ACCESS DYNAMIC
         LOCK MANUAL
         STATUS HTCHK-MST-STATUS
         RECORD KEY
         HTCHK-KEY
         ALTERNATE KEY
         HTCHK-ALT-KEY6 = HTCHK-IP-GPSW  HTCHK-RP-DATE
                          HTCHK-RP-ST    HTCHK-CLS-NO
                          HTCHK-P-KEY
         ALTERNATE KEY
         HTCHK-ALT-KEYA = HTCHK-IP-GPID  HTCHK-CLS-NO
                          HTCHK-IP-DATE  HTCHK-WK-SW
                          HTCHK-PR-SEQ
         ALTERNATE KEY

         HTCHK-ALT-KEYE = HTCHK-IP-GPSW  HTCHK-DPT-CD
                          HTCHK-PT-NO    HTCHK-P-KEY
         ALTERNATE KEY
         HTCHK-ALT-KEYM = HTCHK-IP-NO    HTCHK-P-KEY.
*COPY    "HT_RPT.SEL".
 SELECT HTRPT-MST
    ASSIGN       TO  "HT_MRPT"
    WITH COMPRESSION
    COMPRESSION CONTROL VALUE  70
    ORGANIZATION IS INDEXED
    ACCESS MODE  IS DYNAMIC
    LOCK MODE    IS MANUAL
    FILE STATUS  IS HTRPT-MST-STATUS
    RECORD KEY   IS HTRPT-KEY
    ALTERNATE RECORD KEY IS HTRPT-ALT-KEY = HTRPT-USR-NO, HTRPT-RPT-TY,
    HTRPT-RPT-NO1, HTRPT-RPT-CNT.
*COPY    "HT_CLS.SEL".
 SELECT  HTCLS-MST
         ASSIGN TO               "HT_MCLS" WITH COMPRESSION
         ORGANIZATION IS         INDEXED
         ACCESS MODE IS          DYNAMIC
         LOCK MANUAL
         RECORD KEY IS           HTCLS-KEY
         ALTERNATE RECORD KEY IS HTCLS-ALT-KEY1 = HTCLS-CLS-CD
                                                  HTCLS-DPT-CD
         ALTERNATE RECORD KEY IS HTCLS-ALT-KEY2 = HTCLS-DPT-CD
                                                  HTCLS-SEQ-MN
         FILE STATUS IS          HTCLS-MST-STATUS.
*COPY    "HT_CTM.SEL".
 SELECT  HTCTM-MST
         ASSIGN TO DISK "HT_MCTM"
         WITH COMPRESSION
         ORGANIZATION INDEXED
         ACCESS DYNAMIC
         LOCK MANUAL
         STATUS HTCTM-MST-STATUS
         RECORD KEY IS HTCTM-KEY
         ALTERNATE KEY
         HTCTM-ALT-KEY1 = HTCTM-WRP-NO  HTCTM-IO-SW
                          HTCTM-P-KEY
         ALTERNATE KEY
         HTCTM-ALT-KEY2 = HTCTM-MC-NOA  HTCTM-MC-NOP
                          HTCTM-P-KEY
         ALTERNATE KEY
         HTCTM-ALT-KEY3 = HTCTM-LNK-SW  HTCTM-RP-DATE
                          HTCTM-WRP-NO  HTCTM-P-KEY
         ALTERNATE KEY
         HTCTM-ALT-KEY4 = HTCTM-CHK-NO  HTCTM-IP-DATE
                          HTCTM-SPB-CD  HTCTM-ITM-CD
         ALTERNATE KEY
         HTCTM-ALT-KEY6 = HTCTM-CLS-NO  HTCTM-ITM-CD
                          HTCTM-RP-DATE HTCTM-P-KEY
         ALTERNATE KEY
         HTCTM-ALT-KEY7 = HTCTM-RP-ST   HTCTM-CLS-NO
                          HTCTM-RP-DATE HTCTM-ITM-CD
                          HTCTM-P-KEY
         ALTERNATE KEY

         HTCTM-ALT-KEY8 = HTCTM-IP-PRS  HTCTM-P-KEY.
*COPY    "HT_CTR.SEL".
 SELECT  HTCTR-MST
         ASSIGN TO   "HT_MCTR"
         WITH COMPRESSION
         ORGANIZATION INDEXED
         ACCESS MODE DYNAMIC
         LOCK MANUAL
         FILE STATUS IS HTCTR-MST-STATUS
         RECORD KEY  IS HTCTR-KEY.
*COPY    "HT_ITM.SEL".
*
        SELECT  HTITM-MST
                ASSIGN TO   "HT_MITM"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS MODE DYNAMIC
                LOCK MANUAL
                FILE STATUS IS HTITM-MST-STATUS
                RECORD KEY
                HTITM-KEY      = HTITM-ITM-NO
                ALTERNATE KEY
                HTITM-ALT-KEY1 = HTITM-FEE-CD1 HTITM-CLS-CD
                                 HTITM-DPT-CD  HTITM-ITM-CD
                ALTERNATE KEY
                HTITM-ALT-KEY2 = HTITM-MCH-CD  HTITM-ITM-NO
                ALTERNATE KEY
                HTITM-ALT-KEY3 = HTITM-SYS-CD  HTITM-ITM-NO
                ALTERNATE KEY
                HTITM-ALT-KEY4 = HTITM-CLS-NO
                                 HTITM-SEQ-MN  HTITM-ITM-CD
                ALTERNATE KEY
                HTITM-ALT-KEY5 = HTITM-SL-SW   HTITM-ITM-NO
                ALTERNATE KEY
                HTITM-ALT-KEY6 = HTITM-FEE-CD2 HTITM-CLS-CD
                                 HTITM-DPT-CD  HTITM-ITM-CD
                ALTERNATE KEY
                HTITM-ALT-KEY7 = HTITM-ITM-RF  HTITM-ITM-NO
                ALTERNATE KEY
                HTITM-ALT-KEY8 = HTITM-CLS-CD
                                 HTITM-ITM-CD  HTITM-DPT-CD
                ALTERNATE KEY
                HTITM-ALT-KEY9 = HTITM-CLS-NO
                                 HTITM-GRP-SW  HTITM-ITM-CD.
*
*COPY    "HT_REF.SEL".
 SELECT HTREF-MST
       ASSIGN TO "HT_MREF" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE IS DYNAMIC
       LOCK MODE IS MANUAL
       RECORD KEY IS HTREF-KEY
       FILE STATUS IS HTREF-MST-STATUS.
*COPY    "HT_SPL.SEL".

 SELECT  HTSPL-MST
         ASSIGN TO "HT_MSPL"

         ORGANIZATION IS INDEXED
         ACCESS MODE IS DYNAMIC
         LOCK MANUAL
         RECORD KEY
         HTSPL-KEY = HTSPL-SPL-NO
         ALTERNATE KEY
         HTSPL-KEY-ALT = HTSPL-SPL-CD HTSPL-DPT-CD
         FILE STATUS IS HTSPL-MST-STATUS.
*COPY    "HT_BTL.SEL".
 SELECT  HTBTL-MST
         ASSIGN TO "HT_MBTL" WITH COMPRESSION
         ORGANIZATION IS INDEXED
         ACCESS MODE IS DYNAMIC
         LOCK MANUAL
         RECORD KEY
         HTBTL-KEY
         ALTERNATE KEY
         HTBTL-ALT-KEY = HTBTL-BTL-CD HTBTL-DPT-CD
         FILE STATUS IS HTBTL-MST-STATUS.
*
*COPY "HT_V03.SEL" REPLACING ==HTV03-MST-STATUS== BY ==W-FS-HTV03==.
 SELECT  HTV03-MST
         ASSIGN TO   "HT_MV03"
         WITH COMPRESSION
         ORGANIZATION INDEXED
         ACCESS MODE DYNAMIC
         LOCK MANUAL
         FILE STATUS IS HTV03-MST-STATUS
         RECORD KEY IS HTV03-KEY
         ALTERNATE KEY
         HTV03-ALT-KEY1 = HTV03-CLS-CD  HTV03-KEY.

*COPY "HT_V02.SEL" REPLACING ==HTV02-MST-STATUS== BY ==W-FS-HTV02==.
 SELECT  HTV02-MST
         ASSIGN TO   "HT_MV02"
         WITH COMPRESSION
         ORGANIZATION INDEXED
         ACCESS MODE DYNAMIC
         LOCK MANUAL
         FILE STATUS IS HTV02-MST-STATUS
         RECORD KEY IS HTV02-KEY
         ALTERNATE KEY
         HTV02-ALT-KEY1 = HTV02-DPT-CD HTV02-V02-CD
                          HTV02-SEQ-NM HTV02-PHR-CD.

*COPY "HT_V05.SEL" REPLACING ==HTV05-MST-STATUS== BY ==W-FS-HTV05==.
 SELECT  HTV05-MST
         ASSIGN TO   "HT_MV05"
         WITH COMPRESSION
         ORGANIZATION INDEXED
         ACCESS MODE DYNAMIC
         LOCK MANUAL
         FILE STATUS IS HTV05-MST-STATUS
         RECORD KEY IS HTV05-KEY
         ALTERNATE KEY
         HTV05-ALT-KEY1 = HTV05-SEQ-NM HTV05-ANT-NO.


*COPY "HT_VNO.SEL" REPLACING ==HTVNO-MST-STATUS== BY ==W-FS-HTVNO==.
 SELECT HTVNO-MST
       ASSIGN TO "HT_MVNO" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE  IS DYNAMIC
       LOCK MODE    IS MANUAL
       FILE STATUS  IS HTVNO-MST-STATUS
       RECORD KEY   IS HTVNO-KEY
       ALTERNATE KEY
       HTVNO-ALT-KEY1 = HTVNO-VNO-ID  HTVNO-VNO-ON
       ALTERNATE KEY
       HTVNO-ALT-KEY2 = HTVNO-VNO-ID  HTVNO-AC-DATE
                        HTVNO-VNO-NO.

*
*COPY "HT_VVV.SEL" REPLACING ==HTVVV-MST-STATUS== BY ==W-FS-HTVVV==.
 SELECT  HTVVV-MST
         ASSIGN TO   "HT_MVVV"
         WITH COMPRESSION
         ORGANIZATION INDEXED
         ACCESS MODE DYNAMIC
         LOCK MANUAL
         FILE STATUS IS HTVVV-MST-STATUS
         RECORD KEY IS HTVVV-KEY.

*COPY "HT_VK1.SEL" REPLACING ==HTVK1-MST-STATUS== BY ==W-FS-HTVK1==.
 SELECT HTVK1-MST
       ASSIGN TO "HT_MVK1" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE  IS DYNAMIC
       LOCK MODE    IS MANUAL
       FILE STATUS  IS HTVK1-MST-STATUS
       RECORD KEY   IS HTVK1-KEY
       ALTERNATE KEY
       HTVK1-ALT-KEY1 = HTVK1-IP-DATE  HTVK1-CHK-NO
       ALTERNATE KEY
       HTVK1-ALT-KEY2 = HTVK1-AC-DATE  HTVK1-KEY
       ALTERNATE KEY
       HTVK1-ALT-KEY3 = HTVK1-RP-DATE  HTVK1-KEY
       ALTERNATE KEY
       HTVK1-ALT-KEY4 = HTVK1-OK-DATE  HTVK1-KEY
       ALTERNATE KEY
       HTVK1-ALT-KEY5 = HTVK1-VNO-NO   HTVK1-KEY
       ALTERNATE KEY
       HTVK1-ALT-KEY6 = HTVK1-IP-NO    HTVK1-VPL-CD
                        HTVK1-VNO-NO   HTVK1-KEY
       ALTERNATE KEY
       HTVK1-ALT-KEY7 = HTVK1-PT-NO    HTVK1-IP-DATE1
                        HTVK1-KEY.

*COPY "HT_VK2.SEL" REPLACING ==HTVK2-MST-STATUS== BY ==W-FS-HTVK2==.
 SELECT HTVK2-MST
       ASSIGN TO "HT_MVK2" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE  IS DYNAMIC
       LOCK MODE    IS MANUAL
       FILE STATUS  IS HTVK2-MST-STATUS

       RECORD KEY   IS HTVK2-KEY
       ALTERNATE KEY
       HTVK2-ALT-KEY1 = HTVK2-VR-VIRNO HTVK2-AC-DATE
                        HTVK2-CHK-NO   HTVK2-IP-DATE
                        HTVK2-VR-NUM
       ALTERNATE KEY
       HTVK2-ALT-KEY2 = HTVK2-BED-ROOM HTVK2-VR-VIRNO
                        HTVK2-AC-DATE  HTVK2-CHK-NO
                        HTVK2-IP-DATE  HTVK2-VR-NUM
       ALTERNATE KEY
       HTVK2-ALT-KEY3 = HTVK2-VPL-CD   HTVK2-VR-VIRNO
                        HTVK2-AC-DATE  HTVK2-CHK-NO
                        HTVK2-IP-DATE  HTVK2-VR-NUM
       ALTERNATE KEY
       HTVK2-ALT-KEY4 = HTVK2-AC-DATE  HTVK2-CHK-NO
                        HTVK2-IP-DATE  HTVK2-VR-VIRNO
                        HTVK2-VR-NUM.

*COPY "HT_VK3.SEL" REPLACING ==HTVK3-MST-STATUS== BY ==W-FS-HTVK3==.
 SELECT HTVK3-MST
       ASSIGN TO "HT_MVK3" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE  IS DYNAMIC
       LOCK MODE    IS MANUAL
       FILE STATUS  IS HTVK3-MST-STATUS
       RECORD KEY   IS HTVK3-KEY
       ALTERNATE KEY
       HTVK3-ALT-KEY1 = HTVK3-VR-VIRNO  HTVK3-VR-ANTNO
                        HTVK3-AC-DATE   HTVK3-CHK-KEY
                        HTVK3-VR-NUM    HTVK3-VR-ANTNUM.

*COPY "HT_VK4.SEL" REPLACING ==HTVK4-MST-STATUS== BY ==W-FS-HTVK4==.
 SELECT HTVK4-MST
       ASSIGN TO "HT_MVK4" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE  IS DYNAMIC
       LOCK MODE    IS MANUAL
       FILE STATUS  IS HTVK4-MST-STATUS
       RECORD KEY   IS HTVK4-KEY
       ALTERNATE KEY
       HTVK4-ALT-KEY1 = HTVK4-RP-CD    HTVK4-AC-DATE
                        HTVK4-CHK-NO   HTVK4-IP-DATE
                        HTVK4-SEQ-NM.

*COPY "HM_SIDX.SEL".
********************
* SIDTEM-ID NUMBER *
********************
 SELECT HMSID-MST
       ASSIGN       TO "HM_MSID" WITH COMPRESSION ENCRYPTION
       ORGANIZATION IS INDEXED
       ACCESS MODE  IS DYNAMIC
       RECORD KEY   IS HMSID-KEY
       ALTERNATE KEY   HMSID-KEY-ALT1 = HMSID-USER-NO HMSID-USER-PASS
                                        HMSID-KEY
       LOCK MODE    IS MANUAL
       FILE STATUS  IS W-FS-HMSID.


*
*COPY "HT_VHK.SEL".
******************
* 微生物單據主檔 *
******************
 SELECT HTVHK-MST
       ASSIGN        TO "HT_MVHK" WITH COMPRESSION
       ORGANIZATION  IS INDEXED
       ACCESS MODE   IS DYNAMIC
       RECORD KEY    IS HTVHK-KEY
       ALTERNATE KEY    HTVHK-KEY-ALT1 = HTVHK-NO      HTVHK-CK-DATE
       ALTERNATE KEY    HTVHK-KEY-ALT2 = HTVHK-KEY-SW  HTVHK-PATNO
                                         HTVHK-KEY
       ALTERNATE KEY    HTVHK-KEY-ALT3 = HTVHK-KEY-SW  HTVHK-PATNO
                                         HTVHK-NO      HTVHK-CK-DATE
       ALTERNATE KEY    HTVHK-KEY-ALT4 = HTVHK-CCODE   HTVHK-KEY
       ALTERNATE KEY    HTVHK-KEY-ALT5 = HTVHK-NOPRINT HTVHK-KEY
       ALTERNATE KEY    HTVHK-KEY-ALT6 = HTVHK-ADATE   HTVHK-SEQ
                                         HTVHK-KEY
       LOCK MODE     IS MANUAL
       FILE STATUS   IS W-FS-HTVHK.



*COPY "HT_VHR.SEL".
*****************************
* 微生物單據/處方序號記錄檔 *
*****************************
 SELECT HTVHR-MST
       ASSIGN        TO "HT_MVHR" WITH COMPRESSION
       ORGANIZATION  IS INDEXED
       ACCESS MODE   IS DYNAMIC
       RECORD KEY    IS HTVHR-KEY
       ALTERNATE KEY    HTVHR-KEY-ALT1 = HTVHR-VHK-KEY HTVHR-KEY
       ALTERNATE KEY    HTVHR-KEY-ALT2 = HTVHR-SPN-KEY HTVHR-IOW-KEY
       LOCK MODE     IS MANUAL
       FILE STATUS   IS W-FS-HTVHR.

*COPY "HT_VH1.SEL".
********************************************************************************
* 微生物單據 -- KEY值 排序方式與 HT_MVHK 相反                                  *
*   單據號碼 = HTVH1-NO2 = 99999 - HTVHK-NO2                                   *
********************************************************************************
*   >用於 HTRE10KF, HTRE11KF
 SELECT HTVH1-MST
       ASSIGN        TO "HT_MVH1" WITH COMPRESSION
       ORGANIZATION  IS INDEXED
       ACCESS MODE   IS DYNAMIC
       RECORD KEY    IS HTVH1-KEY
       ALTERNATE KEY IS HTVH1-KEY-ALT1 = HTVH1-IDNO  HTVH1-NO
                                         HTVH1-CK-DATE
       ALTERNATE KEY IS HTVH1-KEY-ALT2 = HTVH1-IDNO  HTVH1-KEY
       LOCK MODE     IS MANUAL
       FILE STATUS   IS W-FS-HTVH1.




*COPY "HT_VPL.SEL".
********************************************************************************
* 微生物檢體檔                                                                 *
********************************************************************************
*   >用於 HTRE10KF, HTRE11KF
 SELECT HTVPL-MST
       ASSIGN       TO "HT_MVPL" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE  IS DYNAMIC
       RECORD KEY   IS HTVPL-KEY
       LOCK MODE    IS MANUAL
       FILE STATUS  IS W-FS-HTVPL.

*COPY "HT_ANT.SEL".
 SELECT HTANT-MST
       ASSIGN TO "HT_MANT" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE IS DYNAMIC
       RECORD KEY IS HTANT-KEY
       LOCK MODE IS MANUAL
       FILE STATUS IS W-FS-HTANT.
*COPY "HT_ATE.SEL".
 SELECT HTATE-MST
       ASSIGN TO "HT_MATE" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE IS DYNAMIC
       RECORD KEY IS HTATE-KEY
       LOCK MODE IS MANUAL
       FILE STATUS IS W-FS-HTATE.
*COPY "HT_ATC.SEL".
 SELECT HTATC-MST
       ASSIGN TO "HT_MATC" WITH COMPRESSION
       ORGANIZATION   IS INDEXED
       ACCESS    MODE IS DYNAMIC
       RECORD    KEY HTATC-KEY
       ALTERNATE KEY HTATC-KEY-ALT1 = ATC-TENO ATC-ANTNO ATC-NO
       LOCK MODE      IS MANUAL
       FILE STATUS    IS W-FS-HTATC.

*COPY "HT_VIR.SEL".
 SELECT HTVIR-MST
       ASSIGN TO "HT_MVIR" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE IS DYNAMIC
       RECORD KEY IS HTVIR-KEY
       ALTERNATE KEY HTVIR-KEY-ALT1 = VIR-CODE VIR-VIRNO
       ALTERNATE KEY HTVIR-KEY-ALT2 = VIR-GP VIR-GENUS
                                      VIR-SPECIES VIR-VIRNO
       LOCK MODE IS MANUAL
       FILE STATUS IS W-FS-HTVIR.


*COPY "HT_MIC.SEL".
 SELECT HTMIC-MST
       ASSIGN TO "HT_MMIC" WITH COMPRESSION
       ORGANIZATION IS INDEXED

       ACCESS MODE IS DYNAMIC
       RECORD KEY IS HTMIC-KEY
       LOCK MODE IS MANUAL
       FILE STATUS IS W-FS-HTMIC.
*COPY "HT_DDM.SEL".
 SELECT HTDDM-MST
       ASSIGN TO "HT_MDDM" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE IS DYNAMIC
       RECORD KEY IS HTDDM-KEY
       LOCK MODE IS MANUAL
       FILE STATUS IS W-FS-HTDDM.
*COPY "HT_VRT.SEL".
*------------------------------------------------------------------------------*
*   檔名: 微生物室檢驗結果主檔                                                 *
*------------------------------------------------------------------------------*
 SELECT HTVRT-MST
       ASSIGN        TO "HT_MVRT" WITH COMPRESSION
       ORGANIZATION  IS INDEXED
       ACCESS MODE   IS DYNAMIC
       RECORD KEY    IS HTVRT-KEY
       ALTERNATE KEY IS HTVRT-KEY-ALT1 = VRT-NO    VRT-CK-DATE
                                         VRT-VNO
       ALTERNATE KEY IS HTVRT-KEY-ALT2 = VRT-TDATE HTVRT-KEY
       LOCK MODE     IS MANUAL
       FILE STATUS   IS W-FS-HTVRT.


*COPY "HT_VR1.SEL".
*------------------------------------------------------------------------------*
*   檔名: 微生物室抗生素敏感試驗檔                                             *
*------------------------------------------------------------------------------*
 SELECT HTVR1-MST
       ASSIGN TO    "HT_MVR1" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE  IS DYNAMIC
       RECORD KEY   IS HTVR1-KEY
       LOCK MODE    IS MANUAL
       FILE STATUS  IS W-FS-HTVR1.

*COPY "HT_WRK.SEL".
 SELECT HTWRK-MST
       ASSIGN TO "HT_MWRK" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE  IS DYNAMIC
       LOCK MODE    IS MANUAL
       FILE STATUS  IS HTWRK-MST-STATUS
       RECORD KEY   IS HTWRK-KEY
       ALTERNATE KEY
       HTWRK-ALT-KEY1 = HTWRK-DATA-SPN HTWRK-DPT-NO.
*COPY "HT_CSP.SEL".
 SELECT  HTCSP-MST
         ASSIGN TO DISK "HT_MCSP"
         WITH COMPRESSION
         ORGANIZATION INDEXED
         ACCESS DYNAMIC
         LOCK MANUAL

         STATUS HTCSP-MST-STATUS
         RECORD KEY
         HTCSP-KEY
         ALTERNATE KEY
         HTCSP-ALT-KEY  = HTCSP-IP-PT    HTCSP-KEY
         ALTERNATE KEY
         HTCSP-ALT-KEY1 = HTCSP-DATA-SPN HTCSP-KEY.
*> 排程相關檔案
*COPY    "HX_SRM.SEL".
*C-PY 'HX_SRM.SEL'.

 SELECT HXSRM-MST
    ASSIGN       TO  "HX_MSRM"    WITH COMPRESSION
    ORGANIZATION IS INDEXED
    ACCESS MODE  IS DYNAMIC
    LOCK MODE    IS MANUAL
    RECORD KEY   IS HXSRM-ROM-NO
    ALTERNATE KEY
                HXSRM-ALT-KEY = HXSRM-SRL-NO  HXSRM-ROM-NO
    FILE STATUS  IS HXSRM-MST-STATUS.

*COPY    "HX_SCT.SEL".
*C-PY 'HX_SCT.SEL'.

 SELECT HXSCT-MST
    ASSIGN       TO  "HX_MSCT"    WITH COMPRESSION
    ORGANIZATION IS INDEXED
    ACCESS MODE  IS DYNAMIC
    LOCK MODE    IS MANUAL
    RECORD KEY   IS HXSCT-KEY
    FILE STATUS  IS HXSCT-MST-STATUS.

*COPY    "HX_SCD.SEL".
*C-PY 'HX_SCD.SEL'.

 SELECT HXSCD-MST
    ASSIGN       TO  "HX_MSCD"    WITH COMPRESSION
    ORGANIZATION IS INDEXED
    ACCESS MODE  IS DYNAMIC
    LOCK MODE    IS MANUAL
    RECORD KEY   IS HXSCD-KEY
    ALTERNATE KEY
                HXSCD-ALT-KEY1 = HXSCD-DCT-NCD  HXSCD-KEY
    ALTERNATE KEY
                HXSCD-ALT-KEY2 = HXSCD-DCT-OCD  HXSCD-KEY
    ALTERNATE KEY
                HXSCD-ALT-KEY3 = HXSCD-KEY3     HXSCD-KEY
    ALTERNATE KEY
                HXSCD-ALT-KEYA = HXSCD-KEYA     HXSCD-KEY
    FILE STATUS  IS HXSCD-MST-STATUS.

*COPY    "HX_SCC.SEL".
*C-PY 'HX_SCC.SEL'.

 SELECT HXSCC-MST
    ASSIGN       TO  "HX_MSCC"    WITH COMPRESSION
    ORGANIZATION IS INDEXED

    ACCESS MODE  IS DYNAMIC
    LOCK MODE    IS MANUAL
    RECORD KEY   IS HXSCC-KEY
    FILE STATUS  IS HXSCC-MST-STATUS.

*COPY    "HX_SCM.SEL".
*C-PY 'HX_SCM.SEL'.

 SELECT HXSCM-MST
    ASSIGN       TO  "HX_MSCM"    WITH COMPRESSION
    ORGANIZATION IS INDEXED
    ACCESS MODE  IS DYNAMIC
    LOCK MODE    IS MANUAL
    RECORD KEY   IS HXSCM-KEY
    ALTERNATE KEY
                HXSCM-ALT-KEY1 = HXSCM-KEY1  HXSCM-KEY
    FILE STATUS  IS HXSCM-MST-STATUS.
*COPY    "HX_SCH.SEL".
*C-PY 'HX_SCH.SEL'.

 SELECT HXSCH-MST
    ASSIGN       TO  "HX_MSCH"    WITH COMPRESSION
    ORGANIZATION IS INDEXED
    ACCESS MODE  IS DYNAMIC
    LOCK MODE    IS MANUAL
    RECORD KEY   IS HXSCH-KEY
    ALTERNATE KEY
                HXSCH-ALT-KEY1 = HXSCH-IP-NO    HXSCH-CRE-SEQ    HXSCH-KEY
    ALTERNATE KEY
                HXSCH-ALT-KEY2 = HXSCH-PT-NO    HXSCH-SCH-DATE   HXSCH-KEY-TIM   HXSCH-KEY-SRM   HXSCH-CLS-NO
    ALTERNATE KEY
                HXSCH-ALT-KEY3 = HXSCH-PT-ID    HXSCH-SCH-DATE   HXSCH-KEY-TIM   HXSCH-KEY-SRM   HXSCH-CLS-NO
    ALTERNATE KEY
                HXSCH-ALT-KEY4 = HXSCH-DCT-CD   HXSCH-SCH-DATE   HXSCH-KEY-TIM   HXSCH-KEY-SRM   HXSCH-CLS-NO
    ALTERNATE KEY
                HXSCH-ALT-KEY5 = HXSCH-SCH-DATE HXSCH-KEY-SRM    HXSCH-KEY-TIM   HXSCH-CLS-NO
    ALTERNATE KEY
                HXSCH-ALT-KEY6 = HXSCH-KEY-SRM  HXSCH-SCH-DATE   HXSCH-KEY-TIM   HXSCH-CLS-NO
    ALTERNATE KEY
                HXSCH-ALT-KEY7 = HXSCH-SCH-DATE HXSCH-CLS-NO     HXSCH-KEY-SRM   HXSCH-KEY-TIM

    ALTERNATE KEY
                HXSCH-ALT-KEYA = HXSCH-KEYA     HXSCH-KEY
    ALTERNATE KEY
                HXSCH-ALT-KEYB = HXSCH-KEYB     HXSCH-KEY
    FILE STATUS  IS HXSCH-MST-STATUS.

*COPY    "HX_ANN.SEL".
 SELECT HXANN-MST
       ASSIGN TO "HX_MANN" WITH COMPRESSION
       ORGANIZATION IS INDEXED
       ACCESS MODE IS DYNAMIC
       LOCK MODE IS MANUAL
       RECORD KEY IS HXANN-KEY
       ALTERNATE KEY
       HXANN-ALT-KEY1 = HXANN-TRN-SW   HXANN-KEY
       ALTERNATE KEY

       HXANN-ALT-KEY2 = HXANN-CTM-KEY  HXANN-KEY
       ALTERNATE KEY
       HXANN-ALT-KEY3 = HXANN-CHK-DATE HXANN-KEY
       ALTERNATE KEY
       HXANN-ALT-KEY4 = HXANN-ANN-DATE HXANN-KEY
       ALTERNATE KEY
       HXANN-ALT-KEY5 = HXANN-DEL-DATE HXANN-KEY
       ALTERNATE KEY
       HXANN-ALT-KEY6 = HXANN-EXE-KEY  HXANN-KEY
       ALTERNATE KEY
       HXANN-ALT-KEY7 = HXANN-TRN-SW   HXANN-EXE-KEY
                        HXANN-KEY
       ALTERNATE KEY
       HXANN-ALT-KEY8 = HXANN-TRN-SW   HXANN-IP-NO
                        HXANN-REV-KEY  HXANN-IP-SEQ
       FILE STATUS IS HXANN-MST-STATUS.
*> 97.7.23 金額重結
*COPY    "HI_ENB.SEL".
*
        SELECT  ENB-MST
                ASSIGN TO "HI_MENB"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL
                RECORD KEY   ENB-KEY
                STATUS  IS ENB-MST-STATUS.
*COPY    "HI_KEY.SEL".
 SELECT IKEY-TMP  ASSIGN TO DISK "HI_TKEY"
                 WITH COMPRESSION
                 ORGANIZATION INDEXED
                 ACCESS DYNAMIC
                 LOCK MANUAL
                 STATUS IKEY-TMP-STATUS
                 RECORD KEY IKEY-TMP-KEY.
*COPY    "HI_ICC.SEL".
 SELECT  ICC-MST
         ASSIGN TO "HI_MICC"
         WITH COMPRESSION
         ORGANIZATION INDEXED
         ACCESS DYNAMIC
         LOCK MANUAL
         RECORD KEY   ICC-KEY
         STATUS  IS ICC-MST-STATUS.

*COPY    "HI_ENA.SEL".
*
        SELECT  ENA-MST
                ASSIGN TO "HI_MENA"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL
                RECORD KEY   ENA-KEY
                STATUS  IS ENA-MST-STATUS.
*COPY    "HI_ENC.SEL".
*>      ENC-MST 住院ENA-MST 延伸檔

        SELECT  ENC-MST
                ASSIGN TO "HI_MENC"
                WITH    COMPRESSION
                ORGANIZATION INDEXED
                ACCESS  DYNAMIC
                LOCK    MANUAL
                RECORD KEY      ENC-KEY
                ALTERNATE KEY
*>              出院結帳查詢使用
                ENC-ALT-KEY1 = ENC-IPD-NO ENC-SEG-SEQ-V
                ALTERNATE KEY
*>              每月列印請款單/整批結帳使用
                ENC-ALT-KEY2 = ENC-END-DT ENC-IPD-NO ENC-SEG-SEQ
                STATUS  IS      ENC-MST-STATUS.
*>
*COPY    "HI_END.SEL".
* 住院結帳延伸檔(ENB延伸檔)
        SELECT  HIEND-MST
                ASSIGN TO "HI_MEND"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL
                RECORD KEY   HIEND-KEY
                STATUS  IS HIEND-MST-STATUS.
*> 103.06.27 (書伶) 修改實際退藥量欄位讀取來源，改讀RTA及RTB。
*COPY    "HI_RTA.SEL".
* 退藥材處方檔
        SELECT  RTA-MST
                ASSIGN TO "HI_MRTA"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL
                RECORD KEY   RTA-KEY
                STATUS  RTA-MST-STATUS.
*COPY    "HI_RTB.SEL".
* 退藥處方明細檔
        SELECT  RTB-MST
                ASSIGN TO "HI_MRTB"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL
                RECORD KEY   RTB-KEY
                STATUS  RTB-MST-STATUS.
*> 103.06.27 END
*>2019/12/24 耀瑄NIS
*>刪除時加寫HR_UDL3
*COPY    "HR_UDL3.SEL".
*
* 住院醫令[檢驗檢查放射]異動記錄檔：HR_UDL3.MST
*
        SELECT HRUDL3-MST  ASSIGN TO DISK "HR_MUDL3"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC

                LOCK MANUAL
                STATUS HRUDL3-MST-STATUS
                RECORD KEY
                HRUDL3-MST-KEY
                ALTERNATE KEY
                HRUDL3-ALT-KEY1 = HRUDL3-UPD-DTI HRUDL3-MST-KEY
                ALTERNATE KEY
                HRUDL3-ALT-KEY2 = HRUDL3-STATUS HRUDL3-MST-KEY.
*>記錄ICA寫檔錯誤碼[7]
*COPY    "HR_LOG2.SEL".
*
        SELECT LOG2-MST  ASSIGN TO DISK "HR_MLOG2"
                        WITH COMPRESSION
                        ORGANIZATION INDEXED
                        ACCESS DYNAMIC
                        LOCK MANUAL
                        STATUS LOG2-MST-STATUS
                        RECORD KEY
                        LOG2-MST-KEY = LOG2-RO-KEY LOG2-CRE-DATE LOG2-UPD-MRK
                                       LOG2-FEE-NO
                        ALTERNATE KEY
                        LOG2-ALT-KEY1 = LOG2-RO-KEY LOG2-UPD-CNT LOG2-CRE-DATE
                                        LOG2-UPD-MRK LOG2-FEE-NO
                        ALTERNATE KEY
                        LOG2-ALT-KEY2 = LOG2-RO-KEY LOG2-DCRE-DATE LOG2-UPD-MRK
                                        LOG2-FEE-NO.
*
*{TAMIS}end
 DATA                        DIVISION.
 FILE                        SECTION.
*{Bench}file
*{Bench}end
*{TAMIS}file
*COPY    "HG_NID.MST".
***********************************************************
***  HG SYSTEM MASTF C-PY FILE NAME : HG_NID.MST ....
***  < HG_MNID > FILE RECORDS LENGTH ARE 300 CHARS.
***  代號編碼檔
***********************************************************
***  NID-MST-KEY  = NID-ID + NID-CODE
***  NID-ALT-KEY1 = NID-ID + NID-NAME + NID-CODE
***  NID-ALT-KEY2 = NID-ID + NID-TRN  + NID-CODE
***********************************************************
 FD  NID-MST EXTERNAL .
 01 NID-MST-REC.
 02 NID-MST-KEY.
* 代號識別
*
 03 NID-ID           PIC  X(04).
* 代號編碼
*
 03 NID-CODE         PIC  X(20).
* 對應代號
*
 02 NID-TRN          PIC  X(20).
* 代號名稱
*

 02 NID-NAME         PIC  X(24).
*XFD USE GROUP , VAR-LENGTH
* 參數設定
*
 02 NID-REC          PIC  X(232).
***********************************************************
*COPY    "HH_PAT.MST".
*---------------------------------------------------------------------*
* 病患基本資料檔 : HH_PAT.MST   SIZE = 520            檔案：HH_MPAT   *
*---------------------------------------------------------------------*
* 主：PAT-NO                                                          *
* 副：PAT-ALT-KEY1 = PAT-NAME + PAT-BIRTH-DT + PAT-NO                 *
* 副：PAT-ALT-KEY2 = PAT-IDNO + PAT-NO                                *
*---------------------------------------------------------------------*
*
 FD      PAT-MST         EXTERNAL.
 01      PAT-MST-REC.
* 病歷號碼
        02      PAT-NO                                  PIC 9(08).
* 身份証號
        02      PAT-IDNO                                PIC X(10).
* 姓名
        02      PAT-NAME                                PIC X(12).
* 出生日
        02      PAT-BIRTH-DT                            PIC S9(07).
* PAT-MST GROUP 1 ... 250 BYTE...
*$XFD USE GROUP
        02      PAT-DATA-1.
*> 性別 [1]男 [2]女                             (01:01)
                03      PAT-SEX                         PIC X(01).
*> 血型                                         (02:02)
                03      PAT-BLO                         PIC X(02).
*> RH型                                         (04:01)
                03      PAT-RH                          PIC X(01).
*> 身份代碼                                     (05:04)
                03      PAT-CLA                         PIC X(04).
*> 保險醫療證號                                 (09:12)
                03      PAT-INS-NO                      PIC X(12).
*> 要保機關單位號                               (21:10)
                03      PAT-INS-CD                      PIC X(10).
*> 爽約次數                                     (31:02)
                03      PAT-BRK-TIS                     PIC 9(02).
*> 爽約開始日                                   (33:07)
                03      PAT-BRK-BDT                     PIC 9(07).
*> 爽約或欠款處罰終止日期                       (40:07)
                03      PAT-BRK-EDT                     PIC 9(07).
*> 欠款金額                                     (47:07)
                03      PAT-UNR-AMT                     PIC 9(07).
*> 登錄者代碼                                   (54:08)
                03      PAT-USR-ID                      PIC X(08).
*> 參考身份代碼                                 (62:04)
                03      PAT-PT-MRGE                     PIC X(04).
*> 婚姻代碼                                     (66:01)
                03      PAT-MARITAL                     PIC X(01).
*> 危急通知人                                   (67:08)
                03      PAT-TUH-NM                      PIC X(08).
*> 危急通知人與病人關係                         (75:04)

                03      PAT-TUH-RE                      PIC X(04).
*> 危急通知人連絡電話(家)                       (79:10)
                03      PAT-TUH-TEL                     PIC X(10).
*> 職業代碼                                     (89:03)
                03      PAT-JOB                         PIC X(03).
*> 教育程度代碼                                 (92:02)
                03      PAT-EDU                         PIC X(02).
*> 郵遞區號                                     (94:05)
                03      PAT-MAIL                        PIC X(05).
*> 籍貫代碼                                     (99:03)
                03      PAT-NATIVE                      PIC X(03).
*> 電話(家) (一)                                (102:10)
                03      PAT-TEL1                        PIC X(10).
*> 電話(公) (二)                                (112:10)
                03      PAT-TEL2                        PIC X(10).
*> 居住地區代碼                                 (122:07)
                03      PAT-LIVE                        PIC X(07).
*> 通知地址                                     (129:40)
                03      PAT-ADDR                        PIC X(40).
*> 家長姓名                                     (169:08)
                03      PAT-PA-NAME                     PIC X(08).
*> 家長單位代碼                                 (177:05)
                03      PAT-PA-UNIT                     PIC X(05).
*> 加保日期 (投保生效日)                        (182:07)
                03      PAT-INSU-DT                     PIC 9(07).
*> 初診日                                       (189:07)
                03      PAT-ODT-IST                     PIC 9(07).
*> 初診科別代碼                                 (196:04)
                03      PAT-ODPT-IST                    PIC X(04).
*> 最近就診日期                                 (200:07)
                03      PAT-ODT-LST                     PIC 9(07).
*> 最近就診科別代碼                             (207:04)
                03      PAT-ODPT-LST                    PIC X(04).
*> 初次住院日                                   (211:07)
                03      PAT-IDT-IST                     PIC 9(07).
*> 最近出院日                                   (218:07)
                03      PAT-IOUT-LST                    PIC 9(07).
*> 最近住院科別代碼                             (225:04)
                03      PAT-IDPT-LST                    PIC X(04).
*----------------------------------------------------------------------*
* 住院主檔：最近 xxxx  ，當住院主檔刪除時 ，此欄位要將舊資料寫回欄位中 *
*----------------------------------------------------------------------*
                03      PAT-IKEY-LST.
*>     住院主檔：最近住院日                     (229:07)
                        04      PAT-IDT-LST             PIC 9(07).
*>     住院主檔：最近住院日住院序號             (236:04)
                        04      PAT-ISEQ-LST            PIC 9(04).
*----------------------------------------------------------------------*
* 入院作業：最近 xxxx  ，當住院主檔刪除時 ，此欄位不作任何更新動作     *
*----------------------------------------------------------------------*
                03      PAT-EKEY-LST.
*>     入院作業：最近住院日                     (240:07)
                        04      PAT-EDT-LST             PIC 9(07).
*>     入院作業：最近住院日住院序號             (247:04)
                        04      PAT-ESEQ-LST            PIC 9(04).
* PAT-MST GROUP 2 ... 233 BYTE...
*$XFD USE GROUP , VAR-LENGTH

        02      PAT-DATA-2.
*> 最近不活動病歷                               (01:05)
                03      PAT-NON-YYMM                    PIC 9(05).
*> 病歷位置 - OCCURS 1：前次位置 / OCCURS 2：目前位置   (06:100)
                03      PAT-CHG-STA.
                        04      PAT-CHG-POS OCCURS 2 TIMES.
*     異動碼 [1]借閱 [2]門診 [3]住院
                                05      PAT-CHG-CODE    PIC X(01).
*     異動日
                                05      PAT-CHG-DT      PIC 9(07).
*     異動時間
                                05      PAT-CHG-TI      PIC 9(06).
*     異動人代碼
                                05      PAT-CHG-EMP     PIC X(08).
*     異動單位代碼 (9991-分類，9992-未完成, 9993-疾病)
                                05      PAT-CHG-DPT     PIC X(05).
*     看診日期
                                05      PAT-CHG-CDT     PIC 9(07).
*     病房床號
                                05      PAT-CHG-WARD    PIC X(06).
*     午別代碼
                                05      PAT-CHG-TURN    PIC X(01).
*     診間代碼
                                05      PAT-CHG-ROOM    PIC X(02).
*     歸還日
                                05      PAT-CHG-ACDT    PIC 9(07).
*> 出院病歷流程位置 [2]分類 [3]未完 [4]疾病     (106:01)
                03      PAT-FLO-ID                      PIC X(01).
*> 出院病歷流程單位代碼                         (107:06)
                03      PAT-FLO-CODE                    PIC X(06).
*> 未完病歷出院日                               (113:07)
                03      PAT-FLO-DT                      PIC 9(07).
*> 建檔日                                       (120:07)
                03      PAT-CRE-DT                      PIC 9(07).
*> 備註                                         (127:34)
                03      PAT-REMARK                      PIC X(34).
*> 初診未批:[Y]                                 (161:01)
                03      PAT-FST-REG                     PIC X(01).
*> 新病歷號碼                                   (162:08)
                03      PAT-NEW-NO                      PIC 9(08).
*> 限制原因1                                    (170:02)
                03      PAT-STOP-RN                     PIC X(02).
*> 員眷                                         (172:12)
                03      PAT-STAF-NM                     PIC X(12).
*> 是否死亡:[Y]                                 (184:01)
                03      PAT-DIE                         PIC X(01).
*> 最近就診健保序號                             (185:04)
                03      PAT-INS-CAR                     PIC X(04).
*> 最近就診同一療程健保序號                     (189:04)
                03      PAT-INS-PRC                     PIC X(04).
*> 同一療程最近就診日期                         (193:07)
                03      PAT-PRC-LST                     PIC X(07).
*> 是否檢查、檢驗                               (200:01)
                03      PAT-X-CHK                       PIC X(01).
*> 階級代碼                                     (201:02)
                03      PAT-LEVEL                       PIC X(02).
*> 其它證號                                     (203:08)

                03      PAT-OTHER-ID                    PIC X(08).
*> 退伍日期                                     (211:07)
                03      PAT-RETIRED                     PIC 9(07).
*> 軍種 86/12/8                                 (218:01)
                03      PAT-ADD                         PIC X(01).
                03      PAT-A-ADD       REDEFINES PAT-ADD.
                        04      PAT-A-KIND              PIC X(01).
*> 用葯過敏檔                                   (219:01)
                03      PAT-SEN                         PIC X(01).
*> 分冊記錄                                     (220:01)
                03      PAT-ANO-YN                      PIC X(01).
*> 就診方式 [1]門診 [2]急診                     (221:02)
                03      PAT-CHG-WAY     OCCURS 2 TIMES.
                        04      PAT-OPD-WAY             PIC X(01).
*> 測試病歷 [Y]                                 (223:01)
                03      PAT-TEST-YN                     PIC X(01).
*> 國別 [1]本國 [2]外國                         (224:01)
                03      PAT-ORIG                        PIC X(01).
*> 初診就診方式 [1]門 [2]急                     (225:01)
                03      PAT-FIS-WAY                     PIC X(01).
*> 病歷院區碼                                   (226:1)
                03      PAT-HID                         PIC X(01).
*> 病歷位置備註                                 (227:01)
                03      PAT-PS                          PIC X(01).
*> 異常病歷備註 (Y)異常                         (228:01)
                03      PAT-UNNOR                       PIC X(01).
*> 限制原因2                                    (229:02)
                03      PAT-STOP-RN2                    PIC X(02).
*> 北市-[舊病歷已銷毀]註記-95/07/17             (231:01)
                03      PAT-OBD-YN                      PIC X(01).
*> 衛生署醫院病患個人院際病歷查詢同意書列印註記-98/05/14(232:01)
                03      PAT-HROWN1PF-YN                 PIC X(01).
*
                03      PAT-FILLER                      PIC X(01).

***     [920730]
*****   THE     END
*COPY    "HI_IPD.MST".
*---------------------------------------------------------------------*
* 住院主檔：HI_IPD.MST             SIZE 465           檔案：HI_MIPD   *
*---------------------------------------------------------------------*
* 主：IPD-MST-KEY  = IPD-NO                                           *
* 副：IPD-ALT-KEY1 = IPD-PAT-NO IPD-NO                                *
* 副：IPD-ALT-KEY2 = IPD-LEAVE-DT + IPD-PAT-NO + IPD-NO               *
* 副：IPD-ALT-KEY3 = IPD-LEAVE-DT + IPD-NAME   + IPD-NO               *
* 副：IPD-ALT-KEY4 = IPD-LEAVE-DT + IPD-BED    + IPD-NO               *
* 副：IPD-ALT-KEY5 = IPD-LEAVE-DT + IPD-DPT    + IPD-NO               *
* 副：IPD-ALT-KEY6 = IPD-LEAVE-DT + IPD-MJ-DR  + IPD-NO               *
* 副：IPD-ALT-KEY7 = IPD-PAT-NO + IPD-OUT-DT + IPD-NO                 *
* 副：IPD-ALT-KEY8 = IPD-OUT-DT + IPD-NO                              *
* 副：IPD-ALT-KEY9 = IPD-OUT-DT + IPD-PAT-NO + IPD-NO                 *
* 副：IPD-ALT-KEY10= IPD-OUT-DT + IPD-BED    + IPD-NO                 *
* 副：IPD-ALT-KEY11= IPD-CASE + IPD-DPT + IPD-OUT-DT                  *
*                    IPD-NO + IPD-ASK-SEQ                             *
* 副：IPD-ALT-KEY12= IPD-OUT-DT + IPD-UNIT + IPD-NO                   *
*---------------------------------------------------------------------*
**** ＮＯＴＥ！

*
* 若要確定病人是否還在醫院？請用 IPD-LEAVE-DT 來判別，因為 IPD-OUT-DT
* 有可能預先輸入, 例如：星期天要出院的病人，星期六先辦出院手續 (此時
* IPD-OUT-DT  就輸入值了)
*
***********************************************************************
 FD      IPD-MST         EXTERNAL.
 01      IPD-MST-REC.
*$XFD USE GROUP
* 住院序號
        02      IPD-NO.
*     住院日期
                03      IPD-DT                          PIC 9(07).
*     住院流水號
                03      IPD-SEQ                         PIC 9(04).
* 病歷號碼
        02      IPD-PAT-NO                              PIC 9(08).
* 姓名
        02      IPD-NAME                                PIC X(12).
* 住院時間
        02      IPD-TIME                                PIC 9(06).
*$XFD USE GROUP , VAR-LENGTH
* 病房床號
        02      IPD-BED.
*     病房
                03      IPD-BED-ROOM                    PIC X(04).
*     床號
                03      IPD-BED-NO                      PIC X(02).
* 科別代碼
        02      IPD-DPT                                 PIC X(04).
* 主治醫師代碼
        02      IPD-MJ-DR                               PIC X(04).
* 單位代碼 (護理站)
        02      IPD-UNIT                                PIC X(05).
* 案件分類代碼
        02      IPD-CASE                                PIC X(01).
* 實際出院日期
        02      IPD-OUT-DT                              PIC 9(07).
* 實際離院日期
        02      IPD-LEAVE-DT                            PIC 9(07).
* 申報流水編號 UPDATE 84.10.04
        02      IPD-ASK-SEQ                             PIC 9(06).
*
*$XFD USE GROUP , VAR-LENGTH
        02      IPD-GROUP1.
*
* 住院醫師代碼  (1:4)
                03      IPD-RD-DR                       PIC X(04).
* 隔離代碼      (5:4)
                03      IPD-DIV                         PIC X(04).
* 身份代碼      (9:4)
                03      IPD-A-CLA                       PIC X(04).
* 參考身份代碼  (13:4)
                03      IPD-B-CLA                       PIC X(04).
* 病患年齡      (17:3)
                03      IPD-AGE                         PIC 9(03).
*==================*

* 全民健保新增資料 *
*==================*
* 給付類別代碼  (20:1)
                03      IPD-DZS-CHR                     PIC X(01).
* DRG碼         (21:5)
                03      IPD-DRG                         PIC X(05).
* 部分負擔代碼  (26:3)
                03      IPD-PART                        PIC X(03).
* 病患來源代碼  (29:1)
                03      IPD-FROM                        PIC X(01).
* 轉診醫院代碼  (30:10)
                03      IPD-FRM-HOSP                    PIC X(10).
* 健保卡號 ( REPL-CE BY 住院通知表傳送日期 + 傳送時 87.05.29)   (40:10)
                03      IPD-LB-NO                       PIC X(10).
                03      IPD-LB-NO-R REDEFINES IPD-LB-NO.
*>                      傳送日、時
                        04      IPD-SEND-DT             PIC 9(07).
                        04      IPD-SEND-HR             PIC 9(02).
*>                      Y 表設定不顯示於住院查詢表
                        04      IPD-HIDDEN-YN           PIC X(01).
* 健保卡就醫序號 (50:4)
                03      IPD-INS-NO                      PIC X(04).
* 交通事故 [N]  (54:1)
                03      IPD-TRAFFIC                     PIC X(01).
* 出院轉歸代碼  (55:1)
                03      IPD-OUT-RES                     PIC X(01).
* 保險醫療證號  ( REPL-CE BY 合併之住院序號 87.05.29)   (56:12)
                03      IPD-INS-NUM                     PIC X(12).
                03      IPD-INS-NUM-R REDEFINES IPD-INS-NUM.
*>                      合併之住院序號
                        04      IPD-COM-NO.
                                05      IPD-COM-DT      PIC 9(07).
                                05      IPD-COM-SEQ     PIC 9(04).
*>                      生產是否輸入申報起迄區間 ..UPDATED BY 翠萍 88.10.18
                        04      IPD-BIR-APP             PIC X(01).
* 要保機關單位號 (68:10)
                03      IPD-INS-CD                      PIC X(10).
*------------------------------------------------------------------*
* 住院診斷代碼 1 (78:7)
                03      IPD-IDZS1                       PIC X(07).
* 住院診斷代碼 2 (85:7)
                03      IPD-IDZS2                       PIC X(07).
* 住院診斷代碼 3 (92:7)
                03      IPD-IDZS3                       PIC X(07).
* 住院診斷代碼 4 (99:7)
                03      IPD-IDZS4                       PIC X(07).
* 住院診斷代碼 5 (106:7)
                03      IPD-IDZS5                       PIC X(07).
* 外傷原因代碼 1 (113:7)
                03      IPD-PH-DZS1                     PIC X(07).
* 外傷原因代碼 2 (120:7)
                03      IPD-PH-DZS2                     PIC X(07).
* 出院診斷代碼 1 (127:7)
                03      IPD-ODZS1                       PIC X(07).
* 出院診斷代碼 2 (134:7)
                03      IPD-ODZS2                       PIC X(07).
* 出院診斷代碼 3 (141:7)

                03      IPD-ODZS3                       PIC X(07).
* 出院診斷代碼 4 (148:7)
                03      IPD-ODZS4                       PIC X(07).
* 出院診斷代碼 5 (155:7)
                03      IPD-ODZS5                       PIC X(07).
* 前次住院序號   (162:11)
                03      IPD-NO-L.
                        04      IPD-DT-L                PIC 9(07).
                        04      IPD-SEQ-L               PIC 9(04).
* 手術代碼 ( ICD-9-CM)  (173:35)
                03      IPD-OPP-GRP.
                        04      IPD-OPP-ICDM            PIC X(07).
                        04      IPD-OPP-ICD1            PIC X(07).
                        04      IPD-OPP-ICD2            PIC X(07).
                        04      IPD-OPP-ICD3            PIC X(07).
                        04      IPD-OPP-ICD4            PIC X(07).
                03      IPD-OPP-TBL REDEFINES IPD-OPP-GRP.
                        04     IPD-ICD  OCCURS 5  TIMES PIC X(07).
*
*$XFD USE GROUP , VAR-LENGTH
        02      IPD-GROUP2.
*
* 合併住院天數
                03      IPD-TOTAL-DAY.
*         累計急性病房天數 (1:3)
                        04      IPD-ACUTE-TOTAL         PIC 9(03).
*         累計慢性病房天數 (4:3)
                        04      IPD-CHRO-TOTAL          PIC 9(03).
*         累計部份負擔金額  .. UPDATE 84.10.23  (7:9)
                        04      IPD-TOT-PART-AMT        PIC S9(07)V99.
* 當次住院天數
                03      IPD-CURRENT-DAY.
*         當次住院急性病房天數 (16:3)
                        04      IPD-ACUTE-DAY           PIC 9(03).
*         當次住院慢性病房天數 (19:3)
                        04      IPD-CHRO-DAY            PIC 9(03).
*         當次住院部份負擔金額 .. UPDATE 84.10.23  (22:9)
                        04      IPD-CUR-PART-AMT        PIC S9(07)V99.
* 過帳否( 住院批價資料 ==> 已結住院批價資料 ) UPDATE 84.10.04  (31:3)
                03      IPD-TRN-MARK                    PIC X.
                03      IPD-F01-AMT-YN                  PIC X.
                03      IPD-OC-END-YN                   PIC X.
* 最近日結日期  (34:7)
                03      IPD-DAY-DT                      PIC 9(07).
* 實際出院時間  (41:6)
                03      IPD-OUT-TI                      PIC 9(06).
*> 實際離院時間
*>              03      IPD-LEAVE-TI                    PIC 9(06).
* 住院識別  (A.因病住院 B.護理之家 C.日間照護 X.不可使用) (47,1)
                03      IPD-LIVE-ID                     PIC X(01).
* 前次轉歸代碼  (48:1)
                03      IPD-EX-OUT-RES                  PIC X(01).
* 住院合併方式 ( 1. 一般合併 2.器官合併 )(49:1)
                03      IPD-COM-WAY                     PIC X(01).
* 住院合併順序 ( 空白表以 IPD-NO 申報 , R 以合併住院序號申報 ) (50:1)
                03      IPD-COM-ORDER                   PIC X(01).
* 是否作金額重結(於出院結帳審核) <住院醫令刪除住院處置> (51:1)

                03      IPD-AMV-YN                      PIC X(01).
* 是否作身份試算(於出院結帳審核) <住院醫令修改住院診斷> (52:1)
                03      IPD-DEN-YN                      PIC X(01).
* 標準住院日 (53:6)
                03      IPD-STD-DAYS                    PIC 9(06).
* 應出院日期 (59:7)
                03      IPD-STD-DT                      PIC 9(07).
* 實際住院日 (66:7)
                03      IPD-UD-DT                       PIC 9(07).
* 最後伙食費用日 (73:7)
                03      IPD-UD-DATE                     PIC 9(07).
* 疾病登錄碼 (80:1)
                03      IPD-MARK                        PIC X(01).
* 床位異動日期 (81:7)
                03      IPD-BED-DT                      PIC 9(07).
*> 床位異動時間 UPDATE BY SMHTP 880910
*>              03      IPD-BED-TIME                    PIC 9(06).
*> 住院通知表申報流水號(取代IPD-BED-TIME) (88:6)
                03      IPD-NOT-SEQ                     PIC 9(06).
* 異動人代碼 (94:5)
                03      IPD-UID                         PIC X(05).
* 建檔日期 (99:7)
                03      IPD-CRE-DT                      PIC 9(07).
* 建檔時間 (106:6)
                03      IPD-CRE-TIME                    PIC 9(06).
* 備註
                03      IPD-FILLER                      PIC X(70).
                03      IPD-REF-DATA            REDEFINES IPD-FILLER.
*特定CASE : 1.自然生產(雙胞胎)  2.剖腹生產(雙胞胎)  3.核實申報
*           A.精神科日間留院    B.急性腦血管疾病,C.身份變更免部份負擔期間 X.切帳  (112:1)
                        04 IPD-CASE-MARK                PIC X.
*申報開始日 (113:7)
                        04 IPD-APY-STRDT-R                          PIC X(7).
                        04 IPD-APY-STRDT REDEFINES IPD-APY-STRDT-R  PIC 9(7).
*申報結束日 (120:7)
                        04 IPD-APY-ENDDT-R                          PIC X(7).
                        04 IPD-APY-ENDDT REDEFINES IPD-APY-ENDDT-R  PIC 9(7).
*免部份負擔指定開始日  (127:7)
                        04 IPD-CHS-STRDT-R                          PIC X(7).
                        04 IPD-CHS-STRDT REDEFINES IPD-CHS-STRDT-R  PIC 9(7).
*免部份負擔指定結束日 (134:7)
                        04 IPD-CHS-ENDDT-R                          PIC X(7).
                        04 IPD-CHS-ENDDT REDEFINES IPD-CHS-ENDDT-R  PIC 9(7).
*免部份負擔代碼 (141:3)
                        04 IPD-CHS-PART                             PIC X(3).
*原始住院日 (144:7)
                        04 IPD-ORG-DT-R                             PIC X(7).
                        04 IPD-ORIGINAL-DT REDEFINES IPD-ORG-DT-R   PIC 9(7).
*批價退藥先用先退 Y (151:13)
                        04 IPD-RTB-DRAG                             PIC X.
                        04 IPD-APP-DATA-R                           PIC X(12).
*申報月份,版本,流水號
                        04 IPD-APP-DATA   REDEFINES IPD-APP-DATA-R.
                             06 IPD-APP-DTE                         PIC 9(5).
                             06 IPD-APP-VER                         PIC 9(3).
                             06 IPD-APP-SEQ                         PIC 9(4).
*批價使用分次結帳Y (164:1)

                        04 IPD-NEW-SEG                              PIC X.
*>      89/10/27        IPD-APY-LOCK 取代 IPD-APP-UNLOCK
*>      IPD-APY-LOCK ( Y 表已作申報轉檔 N 表不申報)  (165:1)
*>                      04 IPD-APP-UNLOCK                           PIC X.
                        04 IPD-APY-LOCK                             PIC X.
*門診轉住院之門診序號 (166:11)
                        04 IPD-REG-NO                               PIC X(11).
*是否使用IPD-UD-DT為實際住院日 (177:1)
                        04 IPD-REAL-YN                              PIC X(1).
*是否使用新的結帳序號(178:1)
                        04 IPD-NEW-IPP                              PIC X(1).
*次專科(179:2)
                        04 IPD-SUB-DPT                              PIC X(2).

*>      90/02/19 IPD-TRN-TYPE 改成 IPD-NEWBORN-YN
*>      原定義：門診轉住院方式 (1.健保 轉 健保 2.自費 轉 健保)
*>      新定義：新生兒註記 (181:1)
*>                      04 IPD-TRN-TYPE                             PIC X(1).
                        04 IPD-NEWBORN-YN                           PIC X(1).



*****
***** THE END

*COPY    "HI_IPX.MST".
*---------------------------------------------------------------------*
*> 住院主檔延伸檔：HI_IPX.MST         SIZE   652       檔案：HI_MIPX  *
*---------------------------------------------------------------------*
*> 主：IPX-MST-KEY  = IPX-LIVE-ID + IPX-NO
*      目的：和IPD-MST 作連結之鍵值
*> 副：IPX-ALT-KEY1 = IPX-LIVE-ID + IPX-DT + IPX-NO
*      目的：以住院日期統計
*> 副：IPX-ALT-KEY2 = IPX-LIVE-ID + IPX-OUT-DT + IPX-DT   + IPX-NO
*      目的：以出院日期統計
*> 副：IPX-ALT-KEY3 = IPX-LIVE-ID + IPX-PAT-NO + IPX-DT-V + IPX-NO-V
*      目的：某病患最近之住院資料
*> 副：IPX-ALT-KEY4 = IPX-LIVE-ID + IPX-ALT-1  + IPX-NO
*      目的：第一個備用KEY
*> 副：IPX-ALT-KEY5 = IPX-LIVE-ID + IPX-ALT-2  + IPX-NO
*      目的：第二個備用KEY
*---------------------------------------------------------------------*
*>      911218          最後定期結帳日期
*>      2003/6/2        離院方式(交通工具)
*>      2003/11/26      異動資料
*>      2003/12/18      例外就醫
*>      2005/3/2        介紹人
*>      2005/7/6        IC卡-七日內回診
*>      2005/10/29      跨院區轉床通知單 - 轉出院區代碼
*>      2006/12/13      住院案件分類(原來的IPD-CASE)
*>      2007/9/7        實作醫師
*>      2007/9/20       DRG註記
*>      0961115         台大動物醫院
*>      2008/3/27       DRG識別
*>      2008/6/12       病患是否為跨院區轉床 北市需求 - 向榮
*>      2009/1/12       增加中西醫聯合住院欄位 - 向榮
*>      2009/5/12       (J0900683)增加儲存IC卡身分欄位，聖母需求 - 智勛

*>      2009/6/24       (J0900969)動物醫院住院申請，增加限制價輸入欄位 - 智勛
*>      2009/7/13       新增記錄原案件分類代碼 - 向榮
*>      2009/8/3        增加預計出院時間欄位 - 智勛
*>      2009/10/14      (0902064)增加1.病患自備藥物是否歸還2.病患冰箱冷藏藥是否交還欄位 - 智勛
*>      2009/11/19      "A"增加DRG ECMO的註記 - 向榮
*>      2009/12/30      "A"修改掉 IPX-CASE-ORI ，目前無使用，未來可再次使用 - 智勛
*>      2010/1/13       (IPX-GROUP-2-IPD)增加入院切帳來源的識別欄位 - 智勛
*>      2010/3/5        改 ECMO欄位為 NO-DRG-MARK 改存 "F" 或 "G"  - 智勛
*>      2010/4/2        (台南)院區(成大)醫院病患轉入識別註記
*>      2012/06/14      增加請款單位(北市醫) - 瑋育
*>      2012/06/14      轉出服務機構代碼 - 瑋育
*>      2013/10/23      (胸腔)慢開結核病患識別 - 書伶
*>      2013/12/03      (金門)出院轉歸為6時，增加轉院機種識別(1.軍機、2.直昇機、3.民航機) - 書伶
*>      2014/01/10      配合103年1月申報媒體改版，增加「醫療服務計畫」代碼 - 書伶
*>      2016/11/22      增加NIS專用住院序號 上智
*>      2021/06/21      彥廷 增加無健保註記
*---------------------------------------------------------------------*
 FD IPX-MST EXTERNAL.
 01 IPX-MST-REC.
*> 住院識別 【 A.因病住院 B.護理之家 C.日間照護 X.聯繫未收案 】
*>          【 a.刪除因病住院 b.刪除護理之家 c.刪除日間照護  】
        02 IPX-LIVE-ID                                  PIC X(01).

*$XFD USE GROUP
*>      住院序號
        02 IPX-NO.
                03 IPX-SYS-DT                           PIC 9(07).
                03 IPX-SYS-SEQ                          PIC 9(04).
*>      病歷號碼
        02 IPX-PAT-NO                                   PIC 9(08).
*>      住院日
        02 IPX-DT                                       PIC 9(07).
*>      出院日期
        02 IPX-OUT-DT                                   PIC 9(07).

*$XFD USE GROUP , VAR-LENGTH
*>      第一備用鍵值
        02 IPX-ALT-1                                    PIC X(50).
*>      IPD-LIVE-ID = "X" 【(護理之家)聯繫未收案】
        02 IPX-ALT-REG REDEFINES IPX-ALT-1.
*>      姓名
        03 IPX-TOUCH-NAME                               PIC X(12).
*>      出生日期
        03 IPX-TOUCH-BIRTH-DT                           PIC S9(07).
        03 IPX-TOUCH-REC                                PIC X(31).

*$XFD USE GROUP , VAR-LENGTH
*>      第二備用鍵值
        02 IPX-ALT-2                                    PIC X(50).

*$XFD USE GROUP
*>      以最大值與【住院序號】、【實際住院日】相減之值, 為使資料從最近一筆開始排列
*>      住院序號倒序KEY
        02 IPX-NO-V.
                03 IPX-SYS-DT-V                         PIC 9(07).
                03 IPX-SYS-SEQ-V                        PIC 9(04).
*>      實際住院日倒序KEY

        02 IPX-DT-V                                     PIC 9(07).

*$XFD USE GROUP , VAR-LENGTH
        02 IPX-GROUP-1                                  PIC X(250).

*>      IPD-LIVE-ID = "A" 【因病住院】
        02 IPX-GROUP-1-A        REDEFINES IPX-GROUP-1.
*>              身高 (cm)                               (1:4)
                03 IPX-HEIGHT                           PIC 9(03)V9.
*>              體重 (kg)                               (5:4)
                03 IPX-WEIGHT                           PIC 9(03)V9.
*>              出院準備服務收案(1.糖尿病 2.慢性病)     (9:1)
                03 IPX-OUT-SRV                          PIC X(01).
*>              母親病歷號(取消,改以PA2-PA-NO)          (10:8)
                03 IPX-MOM-PAT-NO                       PIC 9(08).
*>              新生兒否(取消,改以IPD-NEWBORN-YN為主)   (18:1)
                03 IPX-NEWBORN-YN                       PIC X(01).
*>              Case Mix Index 之 DRG                   (19:5)
                03 IPX-CMI-DRG                          PIC X(05).
*>              CMI-DRG 權重別                          (24:1)
                03 IPX-CMI-WGT                          PIC X(01).
*>              計畫性入院                              (25:1)
                03 IPX-RE-IN                            PIC X(01).
*>              合併住院序號所屬院區，[  ]表原院區      (26:2)
                03 IPX-COM-THID                         PIC X(02).
*>              患者採用之臨床路徑                      (28:5)
                03 IPX-DRG-SET                          PIC X(05).
*>              是否跳脫此臨床路徑，[Y]表已跳脫         (33:1)
                03 IPX-DRG-SET-OFF                      PIC X(01).
*>              Case Mix Index(住院病例組合) 之 DRG 所屬的 MDC          (34:2)
                03 IPX-DRG-MDC                          PIC X(02).
*>              DRGs 權重值 - RW (Relative weight) 病例組合相對值       (36:6)
                03 IPX-DRG-RW                           PIC 9(02)V9(04).
*>              住院診斷代碼 6                          (42:7)
                03 IPX-IDZS6                            PIC X(07).
*>              住院診斷代碼 7                          (49:7)
                03 IPX-IDZS7                            PIC X(07).
*>              住院診斷代碼 8                          (56:7)
                03 IPX-IDZS8                            PIC X(07).
*>              住院診斷代碼 9                          (63:7)
                03 IPX-IDZS9                            PIC X(07).
*>              住院診斷代碼 10                         (70:7)
                03 IPX-IDZS10                           PIC X(07).

*>              手術代碼 ( ICD-9-CM)                    (77:35)
                03 IPX-OPP-GRP.
                        04 IPX-OPP-ICD6                 PIC X(07).
                        04 IPX-OPP-ICD7                 PIC X(07).
                        04 IPX-OPP-ICD8                 PIC X(07).
                        04 IPX-OPP-ICD9                 PIC X(07).
                        04 IPX-OPP-ICD10                PIC X(07).
                03 IPX-OPP-TBL  REDEFINES IPX-OPP-GRP.
                        04 IPX-ICD      OCCURS 5  TIMES PIC X(07).

*>              2005/10/29 跨院區轉床通知單
*>              轉出院區代碼(病患要轉到那一個院區)      (112:2)
                03 IPX-OUT-HOP                          PIC X(02).

*>              DRGs 排除天數設定：[ ]30天  [1]60天     (114:1)
                03 IPX-DRG-30-60                        PIC X(01).
*>              2007/9/20 DRG 是否有 CC                 (115:1)
                03 IPX-DRG-CC                           PIC X(01).
*>              2007/9/20 DRG 是否有 OR                 (116:1)
                03 IPX-DRG-OR                           PIC X(01).
*>              2007/9/20 DRG 註記                      (117:1)
                03 IPX-DRG-MARK                         PIC X(01).

*>              0961115 新增台大動物醫院診斷IPX-ANI-IDZ (118:60)
                03 IPX-ANI-IDZ                          PIC X(60).
*>              2008/6/12 從IPX-ANI-IDZ中切X(01)存病患是否為跨院區轉床 北市需求 - 向榮
                03 IPX-HOSP-IN  REDEFINES IPX-ANI-IDZ.
*>                      病患是否為跨院區轉床 北市需求 - 向榮
                        04 IPX-HOSP-IN-YN               PIC X(01).
*>                      2011/6/18 新竹切帳前後註記(改醫事機構代碼專用 D.切帳前筆 E.切帳後筆)
                        04 IPX-CUT-HOP-MARK             PIC X(01).
*>                      TW-DRG是否排除另行申報,以下各項 X.表排除
                        04 IPX-OUTOF-EX.
*>                              是否排除 X.排除
                                05 IPX-OUTOF-EX-APP     PIC X(01).
*>                              排除多胞胎新生兒費另行申報
                                05 IPX-OUTOF-NEWBABY    PIC X(01).
*>                              排除IABP另行申報
                                05 IPX-OUTOF-IABP       PIC X(01).
*>                              排除化療費另行申報
                                05 IPX-OUTOF-CAN-H      PIC X(01).
*>                              排除放療費另行申報
                                05 IPX-OUTOF-CAN-F      PIC X(01).
*>                              排除化療藥費另行申報
                                05 IPX-OUTOF-CAN-M      PIC X(01).
*>                              排除呼吸器另行申報
                                05 IPX-OUTOF-BRT        PIC X(01).
*>                              排除洗腎費另行申報
                                05 IPX-OUTOF-DLS        PIC X(01).
*>                              2014/7/28  配合103年7月TW-DRG改版增加[排除生物製劑另行申報]
                                05 IPX-OUTOF-BIO        PIC X(01).
*>                      2011/6/18 X(59) => X(50)
*>                      2014/7/28 X(50) => X(49)
                        04 IPX-HOSP-IN-FIL              PIC X(49).

*>              0961115 新增台大動物醫院起始檢疫日      (178:7)
                03 IPX-ANI-CHK-DATE                     PIC 9(7).
*>              0961115 新增台大動物醫院動物體重(kg)    (185:5)
                03 IPX-ANI-WEIGHT                       PIC 9(03)V9(2).
*>              2007/12/1 大同DRG-罕病註記-NID[1627]    (190:3)
                03 IPX-DRG-1627                         PIC 9(03).
*>              2008/3/27 聯凱WEB版DRG-罕病註記         (193:1)
                03 IPX-RSD-FLAG                         PIC X(01).
*>              2008/3/27 DRG編審資料來源
*>              (L:聯凱 T:大同 S:單機作業)              (194:1)
                03 IPX-DRG-DATA-FROM                    PIC X(01).
*>              2009/1/12 主治醫師代碼(中醫)            (195:4)
                03 IPX-MJ-DR-CHINMED                    PIC X(04).
*>              2009/1/12 住院醫師代碼(中醫)            (199:4)
                03 IPX-RD-DR-CHINMED                    PIC X(04).
*>              2009/1/12 科別代碼(中醫)                (203:4)

                03 IPX-DPT-CHINMED                      PIC X(04).
*>              2009/5/12 IC卡身分欄位(1.福保 2.榮民)   (207:1)
                03 IPX-HIC-CLA                          PIC X(01).
*>              2009/6/24 動物醫院住院申請，增加限制價輸入欄位 (208:1)
                03 IPX-LIMIT-ICA-INPUT                  PIC X(01).
*>              2009/11/19 DRG ECMO註記                 (209:1)
                03 IPX-DRG-ECMO                         PIC X(01).
*>              2010/3/5        改 ECMO欄位為 NO-DRG-MARK 改存 "F" 或 "G"
*>                              REDEFINES IPX-DRG-ECMO 使用
                03 IPX-NO-DRG-MARK      REDEFINES IPX-DRG-ECMO  PIC X(01).
*>              2012/06/14 增加請款單位(北市醫)
                03 IPX-UNIT-GROUP.
*>                      請款單位一
                        04 IPX-UNIT-CODE1               PIC X(04).
*>                      請款單位二
                        04 IPX-UNIT-CODE2               PIC X(04).
*>                      請款單位三
                        04 IPX-UNIT-CODE3               PIC X(04).
*>              2012/11/29 玉里應收帳
                03 IPX-UNIT-GROUP1      REDEFINES IPX-UNIT-GROUP.
*>                      身障等級代碼
                        04 IPX-HIDER-LEVEL-CODE         PIC X(01).
*>                      請款單位
                        04 IPX-UNIT-CODE                PIC X(04).
*>                      補助額度代碼
                        04 IPX-SUBSIDY-CODE             PIC X(02).
*>                      FILLER
                        04 IPX-UNIT-GROUP-FILLER        PIC X(05).
*>              2012/06/14 增加轉出服務機構代碼
*>              轉出服務機構代碼
                03 IPX-OUT-SER-CODE                     PIC X(10).
*>              2012/11/30 合約床最後日結日
                03 IPX-LAST-DAY-DT                      PIC 9(07).
*>              2016/11/22 NIS專用住院序號
                03 IPX-NIS-NO.
                        04 IPX-NIS-DT                   PIC 9(7).
                        04 IPX-NIS-SEQ                  PIC 9(4).
*>              2005/12/7 X(137) -> X(136)
*>              2007/9/20 X(136) -> X(133)
*>              X(133) -> X(73)  -> X(66) -> X(61) => X(58)
*>              2008/3/27 X(58)  -> X(56)
*>              2009/1/12 X(56)  -> X(44)
*>              2009/5/12 X(44)  -> X(43)
*>              2009/6/24 X(43)  -> X(42)
*>              2009/11/19 X(42) -> X(41)
*>              2012/06/14 X(41) -> X(19)
*>              2012/11/30 X(19) -> X(12)
*>              2016/11/22 X(12) -> x(1)
                03 IPX-A-REC                            PIC X(1).

*>
*>      IPD-LIVE-ID = "B" 【護理之家】
*>      IPD-LIVE-ID = "C" 【日間照護】
        02 IPX-GROUP-1-B REDEFINES IPX-GROUP-1.
*>              托別                                    (1:1)
                03 IPX-B-CARE                           PIC X(01).
*>              收案別                                  (2:1)

                03 IPX-B-CASE                           PIC X(01).
*>              個案來源                                (3:1)
                03 IPX-B-FROM                           PIC X(01).
*>              來源說明                                (4:40)
                03 IPX-B-FROM-DOC                       PIC X(40).
*>              主護護士                                (44:5)
                03 IPX-B-NURSE                          PIC X(05).
*>              依賴程度                                (49:1)
                03 IPX-B-DEGREE                         PIC X(01).
*>              轉介人                                  (50:10)
                03 IPX-B-TRN-NAME                       PIC X(10).
*>              最後月結日                              (60:7)
                03 IPX-DB-DT                            PIC 9(07).
*>              護理字號                                (67:10)
                03 IPX-B-NUR-NO                         PIC X(10).
*>              柯氏量表                                (77:1)
                03 IPX-B-KAM-DEGREE                     PIC X(01).
*>              巴氏量表                                (78:3)
                03 IPX-B-BARTH-SCORE                    PIC 9(03).
*>              緊急聯絡人姓名,電話1                    (81:12)
                03 IPX-B-TUH-NAME1                      PIC X(12).
*>                                                      (93:12)
                03 IPX-B-TUH-TEL1                       PIC X(12).
*>              緊急聯絡人姓名,電話2                    (105:12)
                03 IPX-B-TUH-NAME2                      PIC X(12).
*>                                                      (117:12)
                03 IPX-B-TUH-TEL2                       PIC X(12).
*>              緊急聯絡人姓名,電話3                    (129:12)
                03 IPX-B-TUH-NAME3                      PIC X(12).
*>                                                      (141:12)
                03 IPX-B-TUH-TEL3                       PIC X(12).

                03 IPX-B-REC                            PIC X(98).


*>      IPD-LIVE-ID = "X" 【(護理之家)聯繫未收案】
*>      IPD-LIVE-ID = "Y" 【(日間照護)聯繫未收案】
        02 IPX-GROUP-1-X REDEFINES IPX-GROUP-1.
*>              性別                                    (1:1)
                03 IPX-X-SEX                            PIC X(01).
*>              轉介來源                                (2:1)
                03 IPX-X-FROM                           PIC X(01).
*>              來源說明                                (3:40)
                03 IPX-X-FROM-DOC                       PIC X(40).
*>              消案原因                                (43:1)
                03 IPX-X-CANCEL                         PIC X(01).
*>              評估結果                                (44:1)
                03 IPX-X-RESULT                         PIC X(01).
*>              評估護士                                (45:5)
                03 IPX-X-NURSE                          PIC X(05).
                03 IPX-X-REC-1                          PIC X(201).


*$XFD USE GROUP , VAR-LENGTH
        02 IPX-GROUP-2                                  PIC X(250).

*>      IPD-LIVE-ID = "A", "B", "C" 【住院主檔(IPD-MST)之延伸資料】

        02 IPX-GROUP-2-IPD REDEFINES IPX-GROUP-2.
*>              ４８小時以上死亡                        (1:1)
                03 IPX-OVER-48                          PIC X(01).
*>              優免身份２                              (2:4)
                03 IPX-B-CLA2                           PIC X(04).
*>              優免身份３                              (6:4)
                03 IPX-B-CLA3                           PIC X(04).
*>              優免身份４                              (10:4)
                03 IPX-B-CLA4                           PIC X(04).
*>              優免身份５                              (14:4)
                03 IPX-B-CLA5                           PIC X(04).
*>              不計入院人數(由住院申請作業更新)        (18:1)
                03 IPX-DISCOUNT-IN                      PIC X(01).
*>              不計出院人數(由出院結帳作業更新)        (19:1)
                03 IPX-DISCOUNT-OUT                     PIC X(01).
*>              住院日結,第一天不滾住院診察費           (20:1)
                03 IPX-COM-REG                          PIC X(01).
*>              預計出院日                              (21:7)
                03 IPX-EXPECT-OUT-DT                    PIC 9(07).
*>              最後轉介轉檔日                          (28:7)
                03 IPX-CHA-DT                           PIC 9(07).
*>              母親住院序號
                03 IPX-MOM-IPD-NO.
*>                                                      (35:7)
                        04 IPX-MOM-IPD-DT               PIC 9(07).
*>                                                      (42:4)
                        04 IPX-MOM-IPD-SEQ              PIC 9(04).
*>              出院結帳方式([ ]一般出院,[1]安胎轉生產,[2]身份變更,[3]長期切帳) (46:1)
                03 IPX-CUT-ID                           PIC X(01).
*>              體檢類別                                (47:2)
                03 IPX-BODY                             PIC X(02).
*>              五個出院診斷註記                        (49:5)
                03 IPX-ODZS-MARK-TBL.
                        04 IPX-ODZS-MARK        OCCURS 5 TIMES  PIC X(01).
*>              支付代碼 ( 1.現金 2.支票 3.刷卡 4.社福補助 5.記帳補繳)  (54:1)
                03 IPX-PAY-MARK                         PIC X(01).
*>              帶藥狀態(90/12/13 忠孝上線新增 )        (55:1)
                03 IPX-TAKE-ID                          PIC X(01).
*>              剩藥狀態(90/12/13 忠孝上線新增 )        (56:1)
                03 IPX-EXTRA-ID                         PIC X(01).
*>              退藥狀態(90/12/13 忠孝上線新增 )        (57:1)
                03 IPX-RET-ID                           PIC X(01).
*>              藥局關帳日期(90/12/13 忠孝上線新增 )    (58:7)
                03 IPX-DRUG-CLOSE-DT                    PIC 9(07).
*>              藥局關帳人員代碼(90/12/13 忠孝上線新增) (65:5)
                03 IPX-DRUG-CLOSE-USER                  PIC X(05).
*>              整批結帳日期(請款日期)--910107 忠孝上線新增     (70:7)
                03 IPX-LAST-DT                          PIC 9(07).
*>              五個出院診斷(第６～１０個)              (77:35)
                03 IPX-ODZS6-TBL.
                        04 IPX-ODZS6            OCCURS 5 TIMES  PIC X(07).
*>              五個出院診斷註記(第６～１０個)          (112:5)
                03 IPX-ODZS6-MARK-TBL.
                        04 IPX-ODZS6-MARK       OCCURS 5 TIMES  PIC X(01).
*>              是否以IC卡辦住院(Y表以IC卡辦住院)       (117:1)
                03 IPX-IC-YN                            PIC X(01).
*>              就醫類別(IC卡)                          (118:2)

                03 IPX-IC-KND                           PIC X(02).
*>              就醫序號(IC卡)                          (120:4)
                03 IPX-IC-SEQ                           PIC X(04).
*>              補卡註記(IC卡) (1.正常 2.補卡)          (124:1)
                03 IPX-DEN-MARK                         PIC X(01).
*>              入院就診日期和時間
                03 IPX-IC-IN-DT.
*>                                                      (125:7)
                        04 IPX-IC-IN-DATE               PIC 9(07).
*>                                                      (132:6)
                        04 IPX-IC-IN-TIME               PIC 9(06).
*>              出院就診日期和時間
                03 IPX-IC-OUT-DT.
*>                                                      (138:7)
                        04 IPX-IC-OUT-DATE              PIC 9(07).
*>                                                      (145:6)
                        04 IPX-IC-OUT-TIME              PIC 9(06).
*>              新生兒依附之就醫註記(第N胎)             (151:1)
*>              99/07/01之前是用數字1~9，99/07/01之後是以英文大寫(男)和小寫(女)A~J
                03 IPX-IC-BABY-MARK                     PIC X(01).
*>              911218  最後定期結帳日期 (smhkj)        (152:7)
                03 IPX-APL-DT                           PIC 9(7).
*>              2003/6/2 離院方式(交通工具)[NID-0739]   (159:2)
                03 IPX-OUT-TRF                          PIC X(2).
*>              廿四小時內曾發燒38度Ｃ以上(Y/N)         (161:1)
                03 IPX-OVER-38                          PIC X(01).
*>              住院前三天曾有發燒病史                  (162:1)
                03 IPX-FEVER                            PIC X(01).
*>              最近兩週內有疫區之旅遊史                (163:1)
                03 IPX-2-WEEK                           PIC X(01).
*>              是否為肺炎                              (164:1)
                03 IPX-PNEUMONIA                        PIC X(01).
*>              是否有呼吸窘迫                          (165:1)
                03 IPX-SOFFOCATE                        PIC X(01).
*>              是否有急性神經神經症狀                  (166:1)
                03 IPX-NERVE                            PIC X(01).
*>              是否有急性腹瀉                          (167:1)
                03 IPX-RUN                              PIC X(01).
*>              是否有急性黃疸                          (168:1)
                03 IPX-ICTERUS                          PIC X(01).
*>              2003/11/26 新增異動者                   (169:5)
                03 IPX-SARS-MOD-USER                    PIC X(05).
*>              2003/11/26 異動日期                     (174:7)
                03 IPX-SARS-MOD-DT                      PIC 9(07).
*>              2003/11/26 異動時間                     (181:6)
                03 IPX-SARS-MOD-TIME                    PIC 9(06).
*>              2003/12/18 例外就醫 [ ]非例外就醫 [1]已加保未領卡 [2]IC卡遺失毀損換發期間       (187:1)
                03 IPX-IC-C001-MRK                      PIC X(01).
*>              2005/3/2   介紹人                       (188:12)
                03 IPX-INTR-NM                          PIC X(12).
*>              2005/3/2   介紹人是否為院內員工         (200:1)
                03 IPX-INTR-WORKER-YN                   PIC X(01).
*>              2005/7/6 IC卡-七日內回診                (201:1)
                03 IPX-IC-7-DAY                         PIC X(01).
*>              2006/12/13 住院案件分類(原來的IPD-CASE) (202:2)
                03 IPX-CASE                             PIC X(02).
*>              2007/9/7 實作醫師1代碼                  (204:4)

                03 IPX-OPR-DR1                          PIC X(04).
*>              2007/9/7 實作醫師2代碼                  (208:4)
                03 IPX-OPR-DR2                          PIC X(04).
*>              2009/7/13 DRG編審前案件分類代碼         (212:2)
*>              2009/12/30 修改掉，目前無使用，未來可再次使用
                03 IPX-CASE-ORI                         PIC X(02).
*>              2009/8/3  增加預計出院時間欄位 ( 時時:分分 )    (214:4)
                03 IPX-EXPECT-OUT-TI.
                        04      IPX-EXPECT-OUT-TI-HH    PIC 9(02).
                        04      IPX-EXPECT-OUT-TI-MM    PIC 9(02).
*>              2009/10/14 增加1.病患自備藥物是否交還(X(1))2.病患冰箱冷藏藥是否交還欄位(X(1))   (218:2)
                03 IPX-PAT-DRUG-BACK-YN                 PIC X(01).
                03 IPX-COLD-DRUG-BACK-YN                PIC X(01).
*>              2010/1/13       增加入院切帳來源的識別欄位，用來儲存此筆住院資料如為切帳來的，是哪一種的切帳方式 (220:1)
*>                              "1". 安胎轉生產
*>                              "2". 身分變更
*>                              "3". 長期切帳
                03      IPX-CUT-FROM-MARK               PIC X(01).
*>              2010/4/2        (台南)醫院[成大]轉入代碼        (221:10)
                03 IPX-FRM-HOSP-NCKU                    PIC X(10).
*>              2010/9/23       電子病歷調閱 VIP/特殊人士或特殊醫療註記 (231:2)
                03 IPX-SP-MARK                          PIC X(02).
*>              2013/10/23      (胸腔)慢開結核病患識別  (233:1)
                03 IPX-TB-MARK                          PIC X(01).
*>              2013/12/03      (金門)出院轉歸為6時，增加轉院機種識別(1.軍機、2.直昇機、3.民航機)       (234:2)
                03 IPX-TRANS-WAY                        PIC X(02).
*>              2014/01/10      配合103年1月申報媒體改版，增加「醫療服務計畫」代碼      (236:1)
                03 IPX-MED-SERVICE-PLAN                 PIC X(01).
*>              2014/01/10      配合103年1月申報媒體改版，增加「實際提供醫療服務之醫事服務機構代碼」代碼(237:10)
                03 IPX-MED-INSTITUTION                  PIC X(10).
*>              2014/01/10      配合103年1月申報媒體改版，增加「試辦計畫」代碼  (247:1)
                03 IPX-PAC-PLAN                         PIC X(01).
*>              2021/06/21      彥廷 增加無健保註記
                03 IPX-NOHI-MARK                        PIC X(01).
*>              2022/05/30      彥廷 法傳費用註記
                03 IPX-NOTIDIS-MARK                     PIC X(01).
*>              預留
*>              2010/4/2        X(30) -> X(20)
*>              2010/9/23       X(20) -> X(18)
*>              2013/10/23      X(18) -> X(17)
*>              2013/12/03      X(17) -> X(15)
*>              2014/01/10      X(15) -> X(3)
*>              2021/06/21      X(3)  -> X(2)
*>              2022/05/30      X(2)  -> X(1)
                03 IPX-GROUP2-REC                       PIC X(1).


*>      IPD-LIVE-ID = "X" 【(護理之家)聯繫未收案】
*>      IPD-LIVE-ID = "Y" 【(日間照護)聯繫未收案】
        02 IPX-GROUP-2-X REDEFINES IPX-GROUP-2.
*>              聯絡人  １～３ (姓名、電話、地址)       (1:192)
                03 IPX-X-CON-TBL.
                        04 IPX-X-CON-TBL1 OCCURS 3 TIMES.
                                05 IPX-X-CON-NAME       PIC X(12).
                                05 IPX-X-CON-TEL        PIC X(12).
                                05 IPX-X-CON-ADR        PIC X(40).
*>              建檔者                                  (193:5)

                03 IPX-X-CRE-USER                       PIC X(05).
                03 IPX-X-REC-2                          PIC X(53).
*---------------------------------------------------------------------*
*>      ＥＮＤ　ＯＦ　ＣＯＰＹ　ＦＩＬＥ　
*---------------------------------------------------------------------*


*COPY    "HI_ICA.MST".
*******************************************************************************
*> 住院處方檔 RECORD = 272 BYTES
*> 890630 增加 ICA-ANN-YN
*> 890803 增加 ICA-OPD-YN
*> 890828 將ICA-EXT-SERV 改為 ICA-RMK-YN
*> 891009 REDEFINES ICA-SERG-NO, 增加ADDRESS
*> 891117 增加ICA-EXP-YN [是否展開對應處方]
*> 900514 增加ICA-OLD-PILL-NO
*> 910527 增加門診轉住院藥品交付調劑識別碼（配合藥庫不扣庫用）  (JAY)
*> 910621 使用PDA產生處方識別碼(配合PDA專案)    (JAY)
*> 990420 增加健保特殊折扣項次  (Frank)
*> 2012/10/11 (J1201427)急診品質提昇方案收案註記(重大外傷) - 昱志
*> 2012/11/9  (J1201427)急診品質提昇方案收案註記(急性腦中風、心肌梗塞) - 昱志
*******************************************************************************
 FD      ICA-MST         EXTERNAL.
 01      ICA-MST-REC.
*> KEY 值 = 住院序號+處方序號
        10 ICA-KEY.
*> 住院序號(由住院申請作業產生,為病人住院唯一序號)
*$XFD USE GROUP
           20 ICA-IPD-NO.
              30 ICA-IPD-DATE           PIC 9(7).
              30 ICA-IPD-SEQ            PIC 9(4).
*> 處方序號(處方日期+處方流水號)
*$XFD USE GROUP
           20 ICA-ODR-NO.
*> 處方日期(下處方之日期,DEFAULT 為系統日,為可修改之欄位=>因為可能補打)
              30 ICA-INS-DATE           PIC 9(7).
*> 處方流水號(為第幾張之處方)
              30 ICA-ODR-SEQ            PIC 9(4).
*$XFD USE GROUP,VAR-LENGTH
        10 ICA-GROUP-DATA1.
*> 結帳序號(此筆處方須歸類到那一筆結帳序號)             (1, 3)
                20 ICA-SEG-SEQ                  PIC 9(3).
*> 處方科別代碼                                         (4, 4)
                20 ICA-DEPT-NO                  PIC X(4).
*> 處方醫師代碼                                         (8, 4)
                20 ICA-DR-NO                    PIC X(4).
*> 處方身份代碼                                         (12, 4)
                20 ICA-IDNT-NO                  PIC X(4).
*> 處方參考身份                                         (16, 4)
                20 ICA-IDNT-REF                 PIC X(4).
*> 處方床號                                             (20, 6)
                20 ICA-WARD.
                        30 ICA-BED-ROOM         PIC X(4).
                        30 ICA-BED-NO           PIC X(2).
*> 手術種類                                             (26, 1)
                20 ICA-SERG-KND                 PIC X.
*> 手術代碼(取消不用)                                   (27, 7)

                20 ICA-SERG-NO                  PIC X(7).
*> 891009 SMSTL UPDATE :
                20 ICA-SERG-NO1 REDEFINES ICA-SERG-NO.
*> 處方時間(住院醫令使用、搭配ICA-INS-DATE使用)         (27, 4)
                        30 ICA-ODR-TIME         PIC 9(4).
*> 預留                                                 (31, 3)
                        30 ICA-SERG-FILLER      PIC X(3).
*> 附刀一                                               (34, 4)
                20 ICA-OP1                      PIC X(4).
*> 附刀二                                               (38, 4)
                20 ICA-OP2                      PIC X(4).
*> 附刀三                                               (42, 4)
                20 ICA-OP3                      PIC X(4).
*> 最大用藥天數                                         (46, 3)
                20 ICA-RX-DAYS                  PIC 9(3).
*> 最大序號(列印) ==> 藥品部份 ...                      (49, 3)
                20 ICA-MAX-SEQ                  PIC 9(3).
*> 藥袋號碼                                             (52, 4)
                20 ICA-PILL-NO                  PIC 9(4).
*> 應收總額                                             (56, 9)
                20 ICA-NOM-AMT                  PIC S9(7)V9(2).
*> 優免金額                                             (65, 9)
                20 ICA-DIS-AMT                  PIC S9(7)V9(2).
*> 部份負擔金額                                         (74, 9)
                20 ICA-PART-AMT                 PIC S9(7)V9(2).
*> 自付金額                                             (83, 9)
                20 ICA-SP-AMT                   PIC S9(7)V9(2).
*> 申報金額                                             (92, 9)
                20 ICA-APP-AMT                  PIC S9(7)V9(2).
*> 參考身份申報金額                                     (101, 9)
                20 ICA-REF-AMT                  PIC S9(7)V9(2).
*> 已收金額                                             (110, 9)
                20 ICA-RCV-AMT                  PIC S9(7)V9(2).
*> 處方登錄者代號  X(4) ==> X(5)                        (119, 5)
                20 ICA-USR-ID                   PIC X(5).
*> 處方時間(搭配ICA-CRE-DT使用)                         (124, 4)
                20 ICA-INS-TIME                 PIC 9(4).
                20 ICA-UDP-DATA.
*> 處方異動人代號  X(4) ==> X(5)                        (128, 5)
                        30 ICA-UPD-USR-ID       PIC X(5).
*> 處方異動日期                                         (133, 7)
                        30 ICA-UPD-DATE         PIC 9(7).
*> 處方異動時間                                         (140, 4)
                        30 ICA-UPD-TIME         PIC 9(4).
*> 處方異動碼                                           (144, 1)
                        30 ICA-UPD-MARK         PIC X.
*> 發藥單位                                             (145, 4)
                20 ICA-PILL-DEPT                PIC X(4).
*> 床位等級                                             (149, 2)
                20 ICA-CLASS                    PIC X(2).
*> 處方註記       A, a->固定費用 B->首日量   C->緊急檢驗  F->伙食  G->長期照護,
*>                H->呼吸照護    J->治療處置 L.血庫 O->門診轉住院 Q->轉介  U->UD   (151, 1)
                20 ICA-UD-MARK                  PIC X.
*> 超等病房( Y - 超等付費 )                             (152, 1)
*               20 ICA-EXT-SERV                 PIC X.
*> 890828 取消ICA-EXT-SERV, 改為【是否為補登】(住院醫令使用)
                20 ICA-RMK-YN                   PIC X.

*> 病房類別(Y-急性病房, N-慢性病房)                     (153, 1)
                20 ICA-BED-ID                   PIC X.
*> 累積天數(84.09.20)                                   (154, 3)
                20 ICA-COM-DAYS                 PIC 9(3).
*> 部份負擔代碼(000:應部份負擔,001,002,003,004,005:免部份負擔,111:自費)
*>             B01:其他機關 ...                         (157, 3)
                20 ICA-IPD-PART                 PIC X(3).
*> 負擔%(因為住院是一段區間,可能某期間需要部份負擔,某期間不需部份負擔)
*>        ( 0:免部份負擔, 1:急性病房部份負擔 10%, 2:急性病房 20%, 3:急性
*>            病房 30%, 4:慢性病房 5%, 5:慢性病房 10%, 6:慢性病房 20%,
*>          7:慢性病房 30%  A:自費 100%  B:其他機關 100%        (160, 1)
                20 ICA-RESPOND                  PIC X.
*> 緊急處方( Y - On line 列印,N - Batch 列印 S:強制住院)        (161, 1)
                20 ICA-EMG-CD                   PIC X.
*> 優免項次(單一處方箋中共有幾項需優免打折之檢驗項次)           (162, 3)
                20 ICA-LB-CNT                   PIC 9(3).
*> 優免項次申報金額( UPDATE 84.09.29)                           (165, 9)
                20 ICA-LB-APP-AMT               PIC 9(7)V9(2).
*> [T] 過帳資料 [D] 刪除備註                                    (174, 1)
                20 ICA-DEL-MARK                 PIC X.
*> 保留欄位
                20 ICA-FILLER                   PIC X(76).
                20 ICA-REF-DATA         REDEFINES ICA-FILLER.
*>                                                              (175, 9)
                   30 ICA-LB-PART-AMT           PIC S9(7)V9(2).
*> Y-> 為 ICU 病床                                              (184, 1)
                   30 ICA-BED-ICU               PIC X.
*> 備註 [ ]一般用藥 [1]帶藥 [2]退藥 [3]常規用藥                 (185, 1)
                   30 ICA-PR-MRK                PIC X.
*> 轉檢 MARK ....                                               (186, 1)
                   30 ICA-CD00-MARK             PIC X.
*> 慢性部份負擔金額                                             (187, 8)
                   30 ICA-SLOW-PART-DEF         PIC X(8).
                   30 ICA-SLOW-PART REDEFINES  ICA-SLOW-PART-DEF  PIC S9(6)V99.
*> 急性部份負擔金額                                             (195, 8)
                   30 ICA-QUICK-PART-DEF        PIC X(8).
                   30 ICA-QUICK-PART REDEFINES ICA-QUICK-PART-DEF PIC S9(6)V99.
*>                                                              (203, 3)
                   30 ICA-QUICK-DAYS-DEF        PIC X(3).
                   30 ICA-QUICK-DAYS REDEFINES ICA-QUICK-DAYS-DEF PIC 9(3).
*>                                                              (206, 3)
                   30 ICA-SLOW-DAYS-DEF         PIC X(3).
                   30 ICA-SLOW-DAYS REDEFINES ICA-SLOW-DAYS-DEF   PIC 9(3).
*> 結帳異動日期                                                 (209, 7)
                   30 ICA-SEG-DATE              PIC 9(7).
*> 結帳異動時間                                                 (216, 4)
                   30 ICA-SEG-TIME              PIC 9(4).
*> 定期結帳編號                                                 (220, 3)
                   30 ICA-SEG-NO                PIC 9(3).
*> 處方建檔日                                                   (223, 7)
                   30 ICA-CRE-DT                PIC 9(7).
*> 出院批價申報修改者                                           (230, 5)
                   30 ICA-APY-USR               PIC X(5).
*> 醫令識別 Y->醫令系統產生之處方                               (235, 1)
                   30 ICA-DR-YN                 PIC X(01).
*> Y->處方明細含即時報備重要醫令 890630 增加                    (236, 1)
                   30 ICA-ANN-YN                PIC X(01).

*> １ 庫房別預設先帶門診庫房; ２ 庫房別預設先帶急診庫房;        (237, 1)
                   30 ICA-OPD-YN                PIC X(01).
*> Y->表示需展開對應處方(讀ICR-SON)                             (238, 1)
                   30 ICA-EXP-YN                PIC X(01).
*> 舊領藥號                                                     (239, 4)
*> 欲使用此欄位時, 請先判別是否為NUMERIC, 否則會有NON-NUMERIC 之問題
                   30 ICA-OLD-PILL-NO           PIC 9(04).
*> 門診轉住院藥品交付調劑識別碼(910527)                         (243, 1)
                   30 ICA-PHA-WAY               PIC X(01).
*> 使用PDA產生處方識別碼(910621)                                (244, 1)
                   30 ICA-PDA-YN                PIC X(01).
*> 特殊註記(Y.包藥)(911205)                                     (245, 1)
                   30 ICA-SPEC-MARK             PIC X(01).
*> 健保特殊折扣項次 (990420)                                    (246, 2)
                   30 ICA-NHI-SPC-CNT           PIC 9(02).
*>2012/10/11 急診品質提昇方案收案註記(重大外傷)                 (248, 1)
                   30 ICA-EMQ-MARK              PIC X(01).
*>2012/11/9 急診品質提昇方案收案註記(急性腦中風)                (249, 1)
                   30 ICA-EMQ-A-MARK            PIC X(01).
*>2012/11/9 急診品質提昇方案收案註記(急性心肌梗塞)              (250, 1)
                   30 ICA-EMQ-B-MARK            PIC X(01).
*> *******************************************************************************
*>      END     OF      FILE
*> *******************************************************************************
*COPY    "HI_ICB.MST".
*********************************
*住院處方明細檔 RECORD LENGTH = 284 BYTES
*> 11/01 增加ADDRESS 說明
*> 2007/11/17 增加[磨粉]欄位之定義 - 增加動物醫院專用之定義-[組別]
*> 97/09/26 Frank-優免金額重新定義，ICB欄位修改
*>                [優免金額]-->[健保不給付額]/[其他金額]
*********************************
 FD      ICB-MST         EXTERNAL.
 01      ICB-MST-REC.
* KEY 值 = 住院序號+處方序號+處置流水號
        10 ICB-KEY.
*住院序號
*$XFD USE GROUP
           20 ICB-IPD-NO.
              30 ICB-IPD-DATE                   PIC 9(7).
              30 ICB-IPD-SEQ                    PIC 9(4).
*處方序號
*$XFD USE GROUP
           20 ICB-ODR-NO.
*處方日期
              30 ICB-INS-DATE                   PIC 9(7).
*處方流水號
              30 ICB-ODR-SEQ                    PIC 9(4).
*處置流水號
           20 ICB-FEE-SEQ                       PIC 9(3).
*處置代碼
        10 ICB-FEE-KEY                          PIC X(9).
*$XFD USE GROUP,VAR-LENGTH
        10 ICB-GROUP-DATA1.
*標準費用別                                                     (1, 3)
                20 ICB-STD-FNO                  PIC X(3).
*費用歸屬科別(成本中心)                                         (4, 5)

                20 ICB-FEE-DEPT                 PIC X(5).
*庫別                                                           (9, 4)
                20 ICB-STO-DEPT                 PIC X(4).
*數量
                20 ICB-RX-QTY.
*數量分子                                                       (13, 4)
                        30 ICB-RX-QTY1          PIC 9(4).
*數量分母                                                       (17, 2)
                        30 ICB-RX-QTY2          PIC 9(2).
*次劑量
                20 ICB-RX-UQTY.
*次劑量分子                                                     (19, 2)
                        30 ICB-RX-UQTY1         PIC 9(2).
*次劑量分母                                                     (21, 2)
                        30 ICB-RX-UQTY2         PIC 9(2).
*計價單位(88.7 已改為新次劑量之分子)                            (23, 6)
                20 ICB-UNIT                     PIC X(6).
*服用單位(88.7 已改為新次劑量之分母)                            (29, 6)
                20 ICB-RX-UNIT                  PIC X(6).
*小兒加成( A: < 2 歲 30%,B: 2-6 歲 20%, N 不加成 [C:手術材料 50 % => ICB-PRS-ADD] ) UPDATE 84.10.03
*改成小兒兩段加成( A: < 2 歲 30%,B: 2-6 歲 20%, N 不加成)(930701生效)(35, 1)
                20 ICB-BBY-RANK                 PIC X.
*給付等級(Y-急診加成)                                           (36, 1)
                20 ICB-PAY-RANK                 PIC X.
*單價                                                           (37, 8)
                20 ICB-PRICE                    PIC 9(6)V9(2).
*使用方法
                20 ICB-RX-WAY.
*服用方法                                                       (45, 2)
                        30 ICB-RX-WAY1          PIC X(2).
*服用途徑                                                       (47, 2)
                        30 ICB-RX-WAY2          PIC X(2).
*> 磨粉(Y-須磨粉)                                               (49, 1)
*> 若為〔動物醫院〕：此欄位定義為[組別]，僅[A.藥品]與[B.衛材]時可供輸入；有輸入[組別]才可以輸入FON-26的[調劑方式]
                20 ICB-POWDER                   PIC X.
*用藥天數                                                       (50, 2)
                20 ICB-RX-DAYS                  PIC 9(2).
*收費碼(Y-收費,N-不計價)                                        (52, 1)
                20 ICB-CHG-FLAG                 PIC X.
*健保給付否 (84.09.25) (Y-不給付,自費)                          (53, 1)
                20 ICB-ASU-PAY                  PIC X.
*處置類別(第一碼 A-藥品, B-衛材, C-檢驗, D-檢查, E-放射, F-處置)(54, 3)
*
                20 ICB-DG-FLAG                  PIC X(3).
*應收金額(不含健保差額, 但含優免額)                             (57, 9)
                20 ICB-NOM-AMT                  PIC S9(7)V9(2).
*> 97/09/26 Frank-修改[優免金額]為[健保不給付額]/[其他金額]
*健保不給付額/其他金額                                          (66, 9)
***
                20 ICB-DIS-AMT                  PIC S9(7)V9(2).
*部份負擔金額                                                   (75, 9)
                20 ICB-PART-AMT                 PIC S9(7)V9(2).
*實收金額一般金額                                               (84, 9)
                20 ICB-RE-AMT1                  PIC S9(7)V9(2).
*實收金額代收金額                                               (93, 9)
                20 ICB-RE-AMT2                  PIC S9(7)V9(2).
*實收金額特約提撥額                                             (102, 9)

                20 ICB-RE-AMT3                  PIC S9(7)V9(2).
*自付額                                                         (111, 9)
                20 ICB-SP-AMT                   PIC S9(7)V9(2).
*申報額                                                         (120, 9)
                20 ICB-APP-AMT                  PIC S9(7)V9(2).
*次要身份申報額                                                 (129, 9)
                20 ICB-REF-AMT                  PIC S9(7)V9(2).
*優免項次標註(此項處置是否屬於優免項次)                         (138, 1)
                20 ICB-LB-DIS                   PIC X.
*手術開始日期(檢驗、檢查)                                       (139, 7)
                20 ICB-OP-BDATE.
                        30 ICB-OP-BD-YY         PIC 9(3).
                        30 ICB-OP-BD-MM         PIC 9(2).
                        30 ICB-OP-BD-DT         PIC 9(2).
*手術開始時間                                                   (146, 4)
                20 ICB-OP-BTIME.
                        30 ICB-OP-BT-HH         PIC 9(2).
                        30 ICB-OP-BT-MM         PIC 9(2).
*手術結束日期(檢驗、檢查)                                       (150, 7)
                20 ICB-OP-EDATE.
                        30 ICB-OP-ED-YY         PIC 9(3).
                        30 ICB-OP-ED-MM         PIC 9(2).
                        30 ICB-OP-ED-DT         PIC 9(2).
*手術結束時間                                                   (157, 4)
                20 ICB-OP-ETIME.
                        30 ICB-OP-ET-HH         PIC 9(2).
                        30 ICB-OP-ET-MM         PIC 9(2).
*[T] 過帳資料 [D]刪除備註                                       (161, 1)
                20 ICB-DEL-MARK                 PIC X.
*已退數量                                                       (162, 6)
                20 ICB-RTN-QTY.
*已退數量分子
                        30 ICB-RTN-QTY1         PIC 9(4).
*已退數量分母
                        30 ICB-RTN-QTY2         PIC 9(2).
**********************************************
*20 ICB-FILLER                  PIC X(13).
*20 ICB-OP-COUNTER      REDEFINES ICB-FILLER.
*********************************************
* Y->手術 ..                                                    (168, 1)
                20 ICB-OPP-ID                   PIC X(1).
* 手術流水號 ..                                                 (169, 2)
                20 ICB-II-OP-COUNTER            PIC 9(2).
* 自付差價                                                      (171, 8)
                20 ICB-INS-CHG                  PIC 9(6)V99.
* 附加材料加成 ....                                             (179, 1)
                20 ICB-PRS-ADD                  PIC X.
                20 ICB-FILLER                   PIC X(71).
                20 ICB-ANT-DATA         REDEFINES ICB-FILLER.
*>                                                              (180, 1)
                        30 ICB-ANT-YN           PIC X.
*>                                                              (181, 1)
                        30 ICB-STL-YN           PIC X.
*> Y->使用申報量, 數量抓 ICB-APY-QTY, 否則抓 ICB-RX-QTY
                        30 ICB-APY-TYPE REDEFINES ICB-STL-YN PIC X.
**處置類別(PRS-FEE-KND)=C.檢驗 D.檢查 E.Ｘ光
                        30 ICB-PAS-DATA.

                           35   ICB-PAS-FRONT.
**檢驗檢查科室(PRS-PAS-DPT)                                     (182, 1)
                                40 ICB-PAS-DPT  PIC X(1).
**單據類別(PRS-PAS-TAB)                                         (183, 2)
                                40 ICB-PAS-TAB  PIC X(2).
**傳送對象(PRS-PAS-RCV),A>檢驗檢查,B>部位檢查,C>細菌檢驗,D>血庫檢驗 (185, 1)
                                40 ICB-PAS-RCV  PIC X(1).
**檢驗檢查細項代碼(PRS-PAS-ITM)                                 (186, 6)
                                40 ICB-PAS-ITM  PIC X(6).
**處置細項對映項次(PRS-PAS-SEQ)                                 (192, 1)
                                40 ICB-PAS-SEQ  PIC 9(1).
                           35   ICB-PAS-BACK.
**檢驗檢查單號(HTCHK-CHK-NO)                                    (193, 8)
                                40 ICB-CHK-NO.
**檢驗檢查類別代號(HTCHK-CLS-NO)
                                   45 ICB-CLS-NO PIC X(3).
**開單流水碼(HTCHK-PR-SEQ)
                                   45 ICB-PR-SEQ PIC 9(5).
**檢驗檢查項目代碼(HTCHK-ITM-CD)                                (201, 6)
                                40 ICB-ITM-CD   PIC X(6).
*> 加成百分比
                        30 ICB-PER-RATE         PIC X(3).
* 單一劑量處方 [開始日]
                        30 ICB-UD-BDT           PIC 9(07).
* 單一劑量處方 [開始別]
                        30 ICB-UD-BMTH          PIC X(01).
* 單一劑量處方 [結束日]
                        30 ICB-UD-EDT           PIC 9(07).
* 單一劑量處方 [結束別]
                        30 ICB-UD-EMTH          PIC X(01).
*檢體
                        30 ICB-PAS-SMP          PIC X(01).
**傳送模式  PASS WAY, B>批價後批次簽收,N>批價後人工補登,R>批價後立即傳送
                        30 ICB-PAS-WAY          PIC X(01).
                        30 ICB-RTB-ODR          PIC 9(10).
                        30 ICB-RTB-SEQ          PIC 9(3).
                        30 ICB-RTB-MRK          PIC X.
* 容器
                        30 ICB-PAS-BTL          PIC X(1).
**檢驗檢查組合/備註項目 Y:呼叫 HTODRICF
                        30 ICB-PAS-RMK          PIC X(1).
*87/07/28增加:
*起迄日期&時間不合併(費用清單)
                        30 ICB-SEP-ID           PIC X(1).
*強制自費(Y)
                        30 ICB-SP-YN            PIC X(1).
*> 申報數量(ICB-APY-TYPE = "Y" 才有效)
                        30 ICB-APY-QTY          PIC 9(4)V9.
*********************************
*>      END OF FILE
*********************************
*COPY    "HI_ECB.MST".
*******************************************************************************
*> 住院處方明細延伸檔    HI_ECB.MST              (HI_MECB)
*> RECORD LENGTH = 650 BYTES
*> RECORD KEY   ECB-KEY
*> ALTERNATE KEY1: ECB-ALT-KEY1 = ECB-DEL-MARK ECB-FEE-KEY ECB-ODR-NO ECB-IPD-NO

*                                ECB-FEE-SEQ
*> ALTERNATE KEY2: ECB-ALT-KEY2 = ECB-DEL-MARK ECB-IPD-NO ECB-TYPE ECB-ODR-NO-V
*                                ECB-FEE-SEQ
*> 890531  增加腦部麻醉加成
*> 890622  增加重要醫令報備
*> 890629  增加庫房對照碼
*> 890717  GROUP-DATA 增加VAR-LENGTH
*> 900220  增加會診科別
*> 900604  增加手術年齡加成及百分比
*> 900721  增加實作治療師代碼(ECB-THE-NO)
*> 900928  增加檢驗開立不執行(ECB-HT-UNDO)      (JAY)
*> 910131  增加改門診申報之註記(STL)
*> 910312  增加給藥餐數(首日量磨粉專用)(醫令)   (JAY)
*> 910312  增加麻醉細項(不可異動識別碼)         (JAY)
*> 930210  增加氣喘0-6加成                      (JAY)
*> 930617  增加責任醫院加成、夜間假日加成       (JAY)
*> 940412  增加申報補登識別                     (TCC)
*> 940419  增加申報補登應收、優免、自付、申報、負擔     (TCC)
*> 950918  增加依處置設定輸入部位欄位   (TCC)
*> 2006/10/31 增加UDL起迄時間(UD真正的,不含首日量之時間,為配合旭仁藥包機新格式)
*> 97/04/25 Frank-台大雲林-增加化療針劑備註說明(ECB-CANCER-REMARK)
*> 97/05/07 Frank-增加特殊加成
*> 97/10/07 Frank-增加手術折扣：健保不給付額、手術折扣：其他金額(自費)
*> 98/07/09 Frank-增加替代處置
*> 98/07/29 Frank-增加疫苗種類、疫苗批號
*> 98/07/29 Frank-增加醫令預開處置
*> 98/09/22 Frank-增加台中RFID化療針劑用藥起迄日期
*> 98/12/19 Frank-增加台大雲林檢體取樣註記
*> 98/12/24 Frank-增加疫苗上傳註記
*> 99/07/13 Frank-增加健保特殊折扣組別
*> 2011/2/8  增加健保折扣率 - 向榮
*> 2011/2/19 增加連帶項是否列入PPF計算
*> 2011/3/18 (J1100431)4歲. 科別加成 - 向榮
*> 2011/4/8  桃醫座談會, 增加屬於CHEMO用藥欄位 - 向榮
*> 2011/6/21 增加CHEMO相關欄位 - 向榮
*> 2012/3/19 (J1200483)媒體改版, 增加執行人員. 影像來源欄位 - 向榮
*> 2012/6/13 (J1201066)新增是否為清淨手術前(中)抗生素醫令 - 昱志
*> 2012/6/25 (J1201098)新增執行日期時間、執行人員寫入識別 - 昱志
*> 2012/8/24 (J1201271)新增20碼疫苗批號 - 昱志
*> 2013/1/10 (J1201966)自費特材替代群組 - 昱志
*> 2013/8/30 (J1301047)新增20碼疫苗種類 - 昱志
*> 2014/4/18 (J1400397)新增預定用血日期、預定用血時間 - 王婕
*> 2015/11/14 (J1500842)全日平均護病比加成3.5% - 淑儀
*> 2015/11/30 聖母－新增次劑量 - 淑儀
*> 2017/01/09 醫管會-未列項 - 瑋育
*> 2017/11/06 醫管會-C肝用藥開立審核 - 瑋育
*> 2019/01/22 增加代檢醫事機構代碼 - 瑋育
*>2020/07/24 健保規範「直線加速器放射診療項目」之「診療之部位」改為2長 - 佳御
*******************************************************************************
*> 有修改LAYOUT，HI_ECB.WRK, HI_OLDICB.WRK, HI_CANCERI.WRK也要同步修改
*******************************************************************************
 FD      ECB-MST         EXTERNAL.
 01      ECB-MST-REC.
* KEY 值 = 住院序號+處方序號+處置流水號
        10      ECB-KEY.
* 住院序號
*$XFD USE GROUP

           20   ECB-IPD-NO.
                30      ECB-IPD-DATE                    PIC 9(7).
                30      ECB-IPD-SEQ                     PIC 9(4).
* 處方序號
*$XFD USE GROUP
           20   ECB-ODR-NO.
* 處方日期
                30      ECB-INS-DATE                    PIC 9(7).
* 處方流水號
                30      ECB-ODR-SEQ                     PIC 9(4).
* 處置流水號
           20   ECB-FEE-SEQ                             PIC 9(3).
*>
* 刪除MARK
        10      ECB-DEL-MARK                            PIC X(1).
* 處置代碼
        10      ECB-FEE-KEY                             PIC X(9).
* 檔案序號
        10      ECB-FILE-NO                             PIC 9(3).
* 類別 1:藥品,  2:檢驗檢查放射線, 3:F 處置類(890525 增加)
        10      ECB-TYPE                                PIC X(1).
* 處方序號倒序
*$XFD USE GROUP
        10      ECB-ODR-NO-V.
                30      ECB-INS-DATE-V                  PIC 9(7).
                30      ECB-ODR-SEQ-V                   PIC 9(4).
*> 備用key 1
        10      ECB-ALT1                                PIC X(50).
*> 備用key 2
        10      ECB-ALT2                                PIC X(50).
*>
*$XFD USE GROUP
*$XFD USE GROUP, VAR-LENGTH
        10      ECB-GROUP-DATA1                         PIC X(250).
        10      ECB-GROUP-DATA11 REDEFINES ECB-GROUP-DATA1.
*> 備註                                                                 (1,50)
                30      ECB-REMARK                      PIC X(50).
*> Y-> 腦部麻醉加成                                                     (51,1)
                30      ECB-BRAIN-YN                    PIC X(01).
*> 腦部手術之麻醉加成                                                   (52,3)
                30      ECB-BRAIN-RATE                  PIC 9(03).
*> 連帶指標父項(*-->連帶指標、#-->麻醉切割)                             (55,1)
                30      ECB-LNK-POINT-HEAD              PIC X(01).
*> 連帶指標項次(連帶指標、麻醉首項)                                     (56,9)
                30      ECB-LNK-POINT                   PIC X(09).
*> 連帶指標、麻醉切割展開時間                                           (65,6)
                30      ECB-LNK-TIME.
                        40      ECB-LNK-HH              PIC 9(02).
                        40      ECB-LNK-MM              PIC 9(02).
                        40      ECB-LNK-SS              PIC 9(02).
*> Y-> 重要醫令報備     890622 INSERT                                   (71,1)
                30      ECB-ANN-YN                      PIC X(01).
*> 庫房對照碼           890629 INSERT                                   (72,13)
                30      ECB-STK-CNT                     PIC X(13).
*> 開單醫師                                                             (85,4)
                30      ECB-APY-DR                      PIC X(04).
*> 實作醫師１                                                           (89,4)

                30      ECB-OPR-DR1                     PIC X(04).
*> 實作醫師２                                                           (93,4)
                30      ECB-OPR-DR2                     PIC X(04).
*> 報告醫師                                                             (97,4)
                30      ECB-RPT-DR                      PIC X(04).
*> 會診之科別(限會診費使用)-F02                                         (101,4)
                30      ECB-DEPT-NO                     PIC X(04).
*> 手術年齡加成('1'->0-0.5, 'A'->0.5-2, 'B'->2-6)                       (105,1)
*> 改成小兒三段加成('1'->0-0.5, 'A'->0.5-2, 'B'->2-6)(930701生效)       (105,1)
                30      ECB-OPP-RANK                    PIC X(01).
*> 手術年齡加成百分比                                                   (106,3)
*> 改成小兒三段加成百分比(930701生效)                                   (106,3)
                30      ECB-OPP-RATE                    PIC 9(03).
*> 實作治療師                900721 INSERT                              (109,5)
                30      ECB-THE-NO                      PIC X(05).
*> UDL 處置序號                (UD 傳送使用, 藥箋列印)                  (114,3)
                30      ECB-UDL-FEE-SEQ                 PIC 9(03).
*> 檢驗開立未執行('Y'未執行、餘執行)(900928)                            (117,1)
                30      ECB-HT-UNDO                     PIC X(01).
*> Y-> 改為門診申報(910131)                                             (118,1)
                30      ECB-OPD-APY                     PIC X(01).
*> 給藥餐數(首日量磨粉專用)(醫令)(910312)                               (119,4)
                30      ECB-MED-PACKET                  PIC 9(04).
*> 麻醉細項(不可異動識別碼)(910312)                                     (123,1)
                30      ECB-LNK-SON                     PIC X(01).
*> 氣喘0-6加成(930210)                                                  (124,1)
                30      ECB-PANT-YN                     PIC X(01).
*> 責任醫院加成(930617)                                                 (125,1)
                30      ECB-DUTY-YN                     PIC X(01).
*> 急診夜間假日加成(930617)                                             (126,1)
                30      ECB-NIGHT-YN                    PIC X(01).
*> 處置特殊識別(比對處置代碼)(D.子宮頸)(930820)                         (127,1)
                30      ECB-SPEC-MARK                   PIC X(01).
*> 事前審查項目(940105)                                                 (128,1)
                30      ECB-PRD-YN                      PIC X(01).
*> 申報補登識別( Y : 申報補帳)                                          (129,1)
                30      ECB-APY-MARK                    PIC X(01).
*> 應收額                                                               (130,9)
                30      ECB-NOM-AMT                     PIC S9(7)V9(2).
*> 優免額                                                               (139,9)
                30      ECB-DIS-AMT                     PIC S9(7)V9(2).
*> 自付額                                                               (148,9)
                30      ECB-SP-AMT                      PIC S9(7)V9(2).
*> 部份負擔額                                                           (157,9)
                30      ECB-PART-AMT                    PIC S9(7)V9(2).
*> 申報額                                                               (166,9)
                30      ECB-APP-AMT                     PIC S9(7)V9(2).
*> 0-4歲兒童齲齒加成(Y:加成)                                            (175,1)
                30      ECB-TEETH-YN                    PIC X(01).
*> 950918  增加依處置設定輸入部位欄位                                   (176,1)
                30      ECB-LRB-FIELD                   PIC X(01).
**> 2006/10/31 增加UDL起迄時間(UD真正的,不含首日量之時間,為配合旭仁藥包機新格式)(177,7)
                30      ECB-UDL-BDT                     PIC 9(7).
*>                                                                      (184,2)
                30      ECB-UDL-BTI                     PIC 9(2).
*>                                                                      (186,7)
                30      ECB-UDL-EDT                     PIC 9(7).

*>                                                                      (193,2)
                30      ECB-UDL-ETI                     PIC 9(2).
*> 970430 台大化療-增加醫令開立UDL實際時間                              (195,4)
                30      ECB-HRUDL-BTI                   PIC 9(2).
                30      ECB-HRUDL-ETI                   PIC 9(2).
*> 97.10.07 手術折扣：健保不給付額(健保)                                (199,9)
                30      ECB-NHI-DIS-AMT                 PIC S9(7)V9(2).
*> 97.10.07 手術折扣：其他金額(自費)                                    (208,9)
                30      ECB-SP-DIS-AMT                  PIC S9(7)V9(2).
*> 98/07/09 替代處置 (如A處置停用，替換為B處置，此欄位存A處置代碼)      (217,9)
                30      ECB-REPLACE-FEE-KEY             PIC X(9).
*> 98/07/29 預防接種-疫苗種類                                           (226,6)
                30      ECB-INJ-KIND                    PIC X(6).
*> 98/07/29 預防接種-疫苗批號                                           (232,12)
                30      ECB-INJ-BATCH-NO                PIC X(12).
*> 98/07/29 醫令預開處置 (Y:預開處置)                                   (244,1)
                30      ECB-HRPRN-YN                    PIC X(1).
*> 98/09/22 台中RFID自備藥識別 (K：自備藥)                              (245,1)
                30      ECB-SELF-DRUG                   PIC X(1).
*> 98/12/19 台大雲林檢體取樣註記 (Y：已取樣)                            (246,1)
                30      ECB-HT-SAMPLE                   PIC X(1).
*> 98/12/24 預防接種-疫苗上傳註記 (Y：已上傳)                           (247,1)
                30      ECB-INJ-ICS-YN                  PIC X(1).
*> 99/07/13 健保特殊折扣組別 (NID-062A)                                 (248,2)
                30      ECB-SPC-DIS-GRP                 PIC X(2).
*> 2011/4/8 識別屬於CHEMO用藥 (C/T用藥識別) (Y: 該項屬於C/T用藥)        (250:1)
                30      ECB-CHEMO-CT                    PIC X(1).
*$XFD USE GROUP
*$XFD USE GROUP, VAR-LENGTH
        10      ECB-GROUP-DATA2                         PIC X(250).
        10      ECB-GROUP-DATA21 REDEFINES ECB-GROUP-DATA2.
*> 化療備註(97/04/25)                                                   (1,80)
                30      ECB-CANCER-REMARK               PIC X(80).
*> 特殊加成(97/05/07)                                                   (81,3)
                30      ECB-SPC-RATE                    PIC 9(3).
*> 98/09/22 台中RFID化療針劑用藥起始日期 (住醫寫入)                     (84,7)
                30      ECB-HRUDL-BDT                   PIC 9(7).
*> 98/09/22 台中RFID化療針劑用藥結束日期 (住醫寫入)                     (91,7)
                30      ECB-HRUDL-EDT                   PIC 9(7).
*> 98/09/22 台中RFID化療針劑劑量 (住醫寫入)                             (98,8)
                30      ECB-HRUDL-RX-QTY                PIC 9(6)V9(2).
*> 99/07/26 健保特殊折扣率                                              (106,3)
                30      ECB-SPC-DIS-RATE                PIC 9(1)V9(2).
*> 2011/2/8 健保折扣率                                                  (109,5)
                30      ECB-NHI-DIS-RATE                PIC 9(3)V9(2).
*> 2011/2/19 連帶項是否列入PPF計算                                      (114:1)
                30      ECB-PPF-YN                      PIC X(1).
*> 2011/3/18 4歲兒童門診診察費加成                                      (115:1)
                30      ECB-DIAG-RANK                   PIC X(1).
*>                                                                      (116:3)
                30      ECB-DIAG-RATE                   PIC 9(3).
*> 2011/3/18 科別門診診察費加成                                         (119:1)
                30      ECB-DPT-RANK                    PIC X(1).
*>                                                                      (120:3)
                30      ECB-DPT-RATE                    PIC 9(3).
*> 2011/6/21 CHEMO流水號                                                (123:4)
                30      ECB-HYGUDL-SN-NO                PIC 9(4).

*> 2011/6/21 CHEMO識別 (C:送CHEMO, U:送UD, S:送護理站)                  (127:1)
                30      ECB-HYGUDL-CHEMO-ID             PIC X(1).
*> 2011/6/21 CHEMO序號                                                  (128:2)
                30      ECB-HYGUDL-SEQ-NO               PIC 9(2).
*> 2012/3/19 執行人員                                                   (130:5)
                30      ECB-EXECUTE-USR                 PIC X(5).
*> 2012/3/19 影像來源                                                   (135:1)
                30      ECB-IMAGE-SW                    PIC X(1).
*> 2012/6/13 是否為清淨手術前(中)抗生素醫令(Y:是 , 空白:否)             (136:1)
                30      ECB-CLEAN-OPP-ANT-YN            PIC X(1).
*> 2012/6/25 執行日期時間、執行人員寫入識別                             (137:1)
*>           (1.批價  2.補登  3.檢驗  4.手術  5.轉介  6.檢轉補洞  7.手術補洞)
                30      ECB-OP-DATE-USR-ID              PIC X(1).
*> 2012/8/24 20碼疫苗批號                                               (138:20)
                30      ECB-NEW-INJ-BATCH-NO            PIC X(20).
*> 2013/1/10 自費特材替代群組                                           (158:3)
                30      ECB-REPLACE-GROUP               PIC X(03).
*> 2013/8/30 20碼疫苗種類                                               (161,20)
                30      ECB-NEW-INJ-KIND                PIC X(20).
*
*> 2014/4/18 預定用血日期(血庫)                                         (181,7)
                30      ECB-BLOOD-DATE                  PIC 9(07).
*> 2014/4/18 預定用血時間(血庫)                                         (188,4)
                30      ECB-BLOOD-TIME                  PIC 9(04).
*> 2015/11/14 全日平均護病比加成3.5%                                    (192,5)
                30      ECB-PRE-RATE                    PIC 9(05).
*> 2015/11/30 聖母-新增次劑量                                           (197,10)
                30      ECB-RX-N-UQTY.
                        40      ECB-RX-N-UQTY1          PIC 9(05).
                        40      ECB-RX-N-UQTY2          PIC 9(05).
*> 2017/01/09 醫管會-未列項
*>              未列項註記                                              (207,1)
                30      ECB-NLI-MARK                    PIC X(01).
*>              未列項健保代碼                                          (208,16)
                30      ECB-NLI-INS-ID                  PIC X(16).
*>              未列項健保代碼流水號                                    (224,2)
                30      ECB-NSI-INS-ID-SEQ              PIC 9(02).
*> 2017/11/06 醫管會-C肝用藥開立審核
*>              C肝用藥申請日期                                         (226,7)
                30      ECB-CHE-STR-DATE                PIC 9(07).
*> 2017/11/09 加成數3碼改6碼
*>              新加成數                                                (233,5)
                30      ECB-PRE-RATE-NEW                PIC 9(05).
*> 2019/01/22 增加代檢醫事機構代碼                                      (238,10)
                30      ECB-INSPECT-HOSP-ID             PIC X(10).
*>      2020/07/24 健保規範「直線加速器放射診療項目」之「診療之部位」改為2長
                30      ECB-LRB-FIELD-NEW       PIC X(02).
                30      ECB-FILLER2                     PIC X(01).
*******************************************************************************
*>      END     OF      FILE
*******************************************************************************
*COPY    "HI_BED.MST".
*---------------------------------------------------------------------*
* 病床基本資料檔 : HI_BED.MST                         檔案：HI_MBED   *
*---------------------------------------------------------------------*
* 主：BED-BED                                                         *
* 副：BED-ALT-KEY1 = BED-GRD    + BED-BED                             *

* 副：BED-ALT-KEY2 = BED-DPT    + BED-BED                             *
* 副：BED-ALT-KEY3 = BED-DR     + BED-BED                             *
* 副：BED-ALT-KEY4 = BED-UNIT   + BED-BED                             *
* 副：BED-ALT-KEY5 = BED-STATUS + BED-BED                             *
* 副：BED-ALT-KEY6 = BED-STATUS + BED-GRD  + BED-BED                  *
* 副：BED-ALT-KEY7 = BED-STATUS + BED-DPT  + BED-BED                  *
* 副：BED-ALT-KEY8 = BED-STATUS + BED-DR   + BED-BED                  *
* 副：BED-ALT-KEY9 = BED-STATUS + BED-UNIT + BED-BED                  *
*---------------------------------------------------------------------*
*
 FD      BED-MST         EXTERNAL.
 01      BED-MST-REC.
*--------------*
*   基本資料   *
*--------------*
* 病房床號
*$XFD USE GROUP
        02      BED-BED.
*     病房
                03      BED-ROOM                        PIC X(04).
*     床號
                03      BED-NO                          PIC X(02).
* 病床等級
        02      BED-GRD                                 PIC X(02).
* 科別代碼
        02      BED-DPT                                 PIC X(04).
* 醫師代碼
        02      BED-DR                                  PIC X(04).
* 單位代碼 (護理站)
        02      BED-UNIT                                PIC X(05).
*$XFD USE GROUP , VAR-LENGTH
        02      BED-GROUP1.
* UD病房 [Y]
                03      BED-UD                          PIC X(01).
* 走廊床 [Y]
                03      BED-ROAD                        PIC X(01).
* 健保床 [Y]
                03      BED-INSU                        PIC X(01).
* 恢復室 [Y]
                03      BED-RECOVER                     PIC X(01).
* 佔床否 (算不算佔床率) [Y]
                03      BED-CNT                         PIC X(01).
* 性別檢查 [Y]
                03      BED-SEX                         PIC X(01).
* 床位種類代碼
                03      BED-CODE                        PIC X(01).
* 急性床否 [N]
                03      BED-ACUTE                       PIC X(01).
* 保護隔離病房 [Y]
                03      BED-ISO                         PIC X(01).
* 病床屬性 [Y-ICU病床 1-精神病床 2-日間留院 3-安寧病床]
                03      BED-ICU                         PIC X(01).

* 加成收費百分比
                03      BED-ADD-PCT                     PIC 9(03).
* 床位停止使用 [Y]
*>2003/1/28     停止[Y],包床註記[S]

                03      BED-STOP                        PIC X(01).
* 健保對應床號
                03      BED-TRAN                        PIC X(28).
*--------------*
*   異動資料   *
*--------------*
* 目前狀況 (" "空床, "1"待床 , "2"佔床)
        02      BED-STATUS                              PIC X(01).
*
*$XFD USE GROUP , VAR-LENGTH
        02      BED-GROUP2.
                03      BED-PATIENT.
* 患者病歷號碼
                        04      BED-PAT-NO              PIC 9(08).
* 住院患者住院序號
                        04      BED-IPD-NO.
*     住院患者住院日
                                05      BED-IPD-DT      PIC 9(07).
*     住院患者住院流水號
                                05      BED-IPD-SEQ     PIC 9(04).
* 待床截止日期
                        04      BED-END-DT              PIC 9(07).
* 待床截止時間
                        04      BED-END-TI              PIC 9(06).
* 異動者代碼
                        04      BED-CHG-UID             PIC X(05).
* 電話分機 102
                03      BED-PHONE                       PIC X(04).
* ＵＤ生效日 106
                03      BED-UD-DATE                     PIC 9(07).
*> 待床病歷號 nid-mst-rec(113:8) ; substring(bed_group2,49,8)
                03      BED-WAT-PAT-R                   PIC X(08).
                03      BED-WAT-PAT REDEFINES BED-WAT-PAT-R PIC 9(8).
*> 是否有氧氣 121
                03      BED-OXYGEN                      PIC X(01).
*> 生效日(UPDATE BY 翠萍  88/09/13) 122
                03      BED-VALID-DATE                  PIC 9(07).
*> 截止日(UPDATE BY 翠萍  88/09/13) 129
                03      BED-EXP-DATE                    PIC 9(07).
*> 病床備註(900306) nid-mst-rec(136:3)
                03      BED-REMARK                      PIC X(03).
*> 配合住院醫令參數,醫令開立處方時，允許輸入此病床 nid-mst-rec(139:1)
                03      BED-ALLOW-MOD                   PIC X(01).
*> 健保對應床號生效日
                03      BED-TRAN-VALID-DT               PIC 9(07).
* FILLER
                03      BED-REC                         PIC X(05).
*****
***** THE END
*COPY    "HO_PRS.MST".
*
**處置代碼檔 -- PRESCRIPTION CODE FILE  長度(LENGTH) 300
**外部檔名  HO_PRS.MST --> 檔名  HO_MPRS
************************************************************
*主:PRS-MST-KEY  = PRS-MST-ID.
*副:PRS-ALT-KEY1 = PRS-INS-ID PRS-MST-ID.
*副:PRS-ALT-KEY2 = PRS-FEE-KND PRS-MST-ID.

*副:PRS-ALT-KEY3 = PRS-STK-CNT PRS-MST-ID.
*副:PRS-ALT-KEY4 = PRS-ID-NAME PRS-MST-ID.
*副:PRS-ALT-KEY5 = PRS-BRF-ID PRS-MST-ID.
************************************************************
**處方明細資料
 FD      PRS-MST         EXTERNAL.
 01      PRS-MST-REC.
**處置代碼  PRESCRIPTION  CODE
*$XFD USE GROUP
        10 PRS-MST-ID.
**      處置主代碼 PRESCRIPTION  MAJOR  CODE
           20 PRS-MAJ-ID                PIC     X(08).
**      處置附屬碼 PRESCRIPTION  AUXILIARY  CODE
           20 PRS-AUX-ID                PIC     X(01).
**健保代碼  INSURANCE  CODE
*$XFD USE GROUP
        10 PRS-INS-ID.
**      健保主代碼 INSURANCE  MAJOR  CODE
           20 PRS-INS-MAJ                   PIC     X(09).
**      健保衛材延伸碼 INSURANCE  EXTEND  CODE
           20 PRS-INS-EXT                   PIC     X(07).
**庫房對照碼  STOCK  CONTRASTIVE  CODE
        10  PRS-STK-CNT                     PIC     X(13).
**處置名稱
        10  PRS-ID-NAME                     PIC     X(40).
**簡碼  PRESCRIPTION  BRIEF  CODE
        10 PRS-BRF-ID                       PIC     X(04).
*$XFD USE GROUP
        10 PRS-DATA1.
**標準費用別  STANDARD  FEE  KIND [0605]
            12  PRS-STD-FNO                 PIC     X(03).
**計價單位
            12  PRS-PRC-UNIT                PIC     X(08).
**服用單位
            12  PRS-SRV-UNIT                PIC     X(08).
**管制 C/N
            12  PRS-CTL-ID                  PIC     X(01).
**先繳費  Y/N (91.10.19 此欄位不使用,要使用請先申請)
            12  PRS-PAY-ID                  PIC     X(01).
***********************
**自費身份參數  OWN  EXPENSE  PARAMETER
            12  PRS-OWN-PAR.
**限制類別  LIMITED  ID  Y/W/N  Y:限制開立
                20 PRS-OWN-LTD              PIC     X(01).
**單價  UNIT  PRICE
                20 PRS-OWN-UPC              PIC     9(06)V9(02).
**連帶指標  LINKING  POINTER [0602]
                20 PRS-OWN-LNK              PIC     X(09).
**展開識別  LINKING  POINTER  UNFOLD  ID  Y/N
                20 PRS-OWN-LNK-ID           PIC     X(01).
**急診加成屬性  EMERGENCY  RAISE  PRICE  ID  Y/N
                20 PRS-OWN-EMG              PIC     X(01).
**附加材料識別  ADDITIONAL  SUPPLIES  ID  Y/N  Y:需付費
                20 PRS-OWN-ADD              PIC     X(01).
**給付(計價)識別  PAYMENT ID  Y/N
                20 PRS-OWN-PAY              PIC     X(01).
**病房加成屬性  SICKROOM  RAISE  PRICE  ID  Y/N

                20 PRS-OWN-SCK              PIC     X(01).
***********************
**健保身份參數  INSURENCE  EXPENSE  PARAMETER
            12  PRS-INS-PAR.
**限制類別  LIMITED  ID  Y/W/N  Y:限制開立
                20 PRS-INS-LTD              PIC     X(01).
**單價  UNIT  PRICE
                20 PRS-INS-UPC              PIC     9(06)V9(02).
**連帶指標  LINKING  POINTER  [0602]
                20 PRS-INS-LNK              PIC     X(09).
**展開識別  LINKING  POINTER  UNFOLD  ID  Y/N
                20 PRS-INS-LNK-ID           PIC     X(01).
**急診加成屬性  EMERGENCY  RAISE  PRICE  ID  Y/N
                20 PRS-INS-EMG              PIC     X(01).
**附加材料識別  ADDITIONAL  SUPPLIES  ID  Y/N
                20 PRS-INS-ADD              PIC     X(01).
**給付(計價)識別  PAYMENT  ID  Y/N  Y:需計價及申報
                20 PRS-INS-PAY              PIC     X(01).
**病房加成屬性  SICKROOM  RAISE  PRICE  ID  Y/N
                20 PRS-INS-SCK              PIC     X(01).
**健保自付差額金額  FEE  CHARGE
                20 PRS-INS-CHG              PIC     9(06)V9(02).
**附帶報告識別  REPORT  ATTACHED  ID  Y/N  Y:申報時附報告
                20 PRS-INS-RPT              PIC     X(01).
**給藥天數限制  DAYS  LIMITED
                20 PRS-INS-DAY              PIC     9(02).
***********************
**預留身份參數  SPARE  FOR  EXPENSE  PARAMETER
            12  PRS-SPR-PAR.
**限制類別  LIMITED  ID  Y/W/N
                20 PRS-SPR-LTD              PIC     X(01).
**單價  UNIT  PRICE
                20 PRS-SPR-UPC              PIC     9(06)V9(02).
**連帶指標  LINKING  POINTER  [0602]
                20 PRS-SPR-LNK              PIC     X(09).
**展開識別  LINKING  POINTER  UNFOLD  ID  Y/N
                20 PRS-SPR-LNK-ID           PIC     X(01).
**急診加成屬性  EMERGENCY  RAISE  PRICE  ID  Y/N
                20 PRS-SPR-EMG              PIC     X(01).
**附加材料識別  ADDITIONAL  SUPPLIES  ID  Y/N
                20 PRS-SPR-ADD              PIC     X(01).
**給付(計價)識別  PAYMENT  ID  Y/N
                20 PRS-SPR-PAY              PIC     X(01).
**病房加成屬性  SICKROOM  RAISE  PRICE  ID  Y/N
                20 PRS-SPR-SCK              PIC     X(01).
**自付差額金額  FEE  CHARGE
                20 PRS-SPR-CHG              PIC     9(06)V9(02).
**附帶報告識別  REPORT  ATTACHED  ID  Y/N
                20 PRS-SPR-RPT              PIC     X(01).
**給藥天數限制  DAYS  LIMITED
                20 PRS-SPR-DAY              PIC     9(02).
***********************
**處置類別 A.藥品 B.衛材 C.檢驗 D.檢查 E.Ｘ光 F.診療明細 L.連帶指標
        10  PRS-FEE-KND                 PIC     X(03).
*$XFD USE GROUP
        10  PRS-DATA2.
**代收款屬性  COLLECTION  ID  Y/N  Y:代收                               1:1

            12  PRS-COL-ID                  PIC     X(01).
**提撥屬性  SHARE  ID  Y/N  Y:提撥                                      2:1
            12  PRS-SHA-ID                  PIC     X(01).
**提撥比率  SHARE  RATE                                                 3:3
            12  PRS-SHA-RAT                 PIC     9(03).
**抗生素  ANTIBIOTIC  ID  Y/N                                           6:1
            12  PRS-ANT-ID                  PIC     X(01).
**小兒加成屬性  CHILDREN  RAISE  PRICE  ID  Y/N                         7:1
            12  PRS-CHL-ID                  PIC     X(01).
**附加屬性加成成數 UPD ON 85.08.24                                      8:3
            12  PRS-INS-CON                 PIC     9(03).
**特殊處置  SPECIAL  PRESCRIPTION  ID  Y/N                             11:1
            12  PRS-SPC-ID                  PIC     X(01).
**輸入方式識別  1.日期  2.時間  3.次劑量  4.時間及床號  5.不輸入       12:1
            12  PRS-KIN-ID                  PIC     X(01).
**警告訊息  WARNING  CODE  [0603]                                      13:10
            12  PRS-WRN   OCCURS  5  TIMES.
                20  PRS-WRN-COD             PIC     X(02).
**成本屬性  COST  ID  1.預設值  2.科別  3.醫師別                       23:1
            12  PRS-CST-ID                  PIC     X(01).
**成本中心  COST CENTER                                                24:5
            12  PRS-CST-CTR                 PIC     X(05).
**線上控制碼  ON-LINE  CONTROL  ID  Y/N  Y:無庫存,限制開立             29:1
            12  PRS-LIN-CON                 PIC     X(01).
**庫房轉換率  STOCK  EXCHANGE  RATE                                    30:7
            12  PRS-STK-CHG                 PIC     9(04)V9(03).
**門診庫房                                                             37:4
            12  PRS-DGN-STK                 PIC     X(04).
**急診庫房                                                             41:4
            12  PRS-EMG-STK                 PIC     X(04).
**住診庫房                                                             45:4
            12  PRS-RES-STK                 PIC     X(04).
**檢體  TEST  SAMPLE                                                   49:1
            12  PRS-TST-SMP                 PIC     X(01).
**科室  DEPARTMENT                                                     50:1
            12  PRS-PAS-DPT                 PIC     X(01).
**單據類別  TABLE  ID                                                  51:2
            12  PRS-PAS-TAB                 PIC     X(02).
**容器                                                                 53:1
            12  PRS-PAS-WAY                 PIC     X(01).
**傳送對象  PASS RECEIVER, A>檢驗檢查,B>部位檢查,C>細菌檢驗,D>血庫檢驗 54:1
            12  PRS-PAS-RCV                 PIC     X(01).
**會計科目  ACCOUNTING  SUBJECT                                        55:6
            12  PRS-ACC-SUB                 PIC     X(06).
**特定治療  SPECIAL  CURE  ID  [1101](需加醫別)                        61:2
            12  PRS-SPC-CUR                 PIC     X(02).
**優免項次 ( UPDATE 84.09.29 )  Y/N                                    63:1
            12  PRS-DIS-YN                  PIC     X(01).
**備用欄位
            12  PRS-FILLER                  PIC     X(40).
            12  PRS-FILLER1  REDEFINES PRS-FILLER.
**手術識別  Y/N                                                        64:1
               20  PRS-OPP-ID               PIC     X(01).
**服法預設值(一)                                                       65:2
               20  PRS-SRV-NO1              PIC     X(02).
**服法預設值(二)                                                       67:2
               20  PRS-SRV-NO2              PIC     X(02).

**服法預設值(三)                                                       69:2
               20  PRS-SRV-NO3              PIC     X(02).
**檢驗檢查細項代碼                                                     71:6
               20  PRS-PAS-ITM              PIC     X(06).
**處置細項對映項次                                                     77:1
               20  PRS-PAS-SEQ              PIC     9(01).
**健保單價生效日(PRS_INS_UPC)                                          78:7
               20  PRS-INS-DATE             PIC     9(07).
**健保單價生效日之前舊單價                                             85:8
               20  PRS-OLD-UPC              PIC     9(6)V99.
**線上控制生效日 UPD ON 85.08.24.                                      93:7
               20  PRS-CON-DATE             PIC     9(07).
**自動包藥識別 86.09.03. Y:自動包藥  N:人工包藥                       100:1
               20  PRS-BAG-ID               PIC     X(01).
**檢驗檢查組合/備註項目 Y:呼叫 HTODRICF                               101:2
               20  PRS-PAS-RMK              PIC     X(01).
               20  PRS-PAS-QTY-MRK          PIC     X(01).
*> 91.10.19 藥品劑型                                                  103:1
               20  PRS-MED-TYPE             PIC     X(01).
**************************
** PRS-PAS-RCV CREATE FROM HTITM-IP-RP  OF HT_ITM.MST
** PRS-TST-SMP CREATE FROM HTITM-SPL-CD OF HT_ITM.MST
** PRS-PAS-WAY CREATE FROM HTITM-BTL-CD OF HT_ITM.MST
** PRS-PAS-DPT CREATE FROM HTITM-DPT-CD OF HT_ITM.MST
** PRS-PAS-TAB CREATE FROM HTITM-CLS-CD OF HT_ITM.MST
** PRS-PAS-ITM CREATE FROM HTITM-ITM-CD OF HT_ITM.MST
** PRS-PAS-SEQ CREATE FROM HTITM-FEE-CD1 & HTITM-FEE-CD2 OF HT_ITM.MST
**************************

*COPY    "HI_FON.MST".
*---------------------------------------------------------------------*
*>      住院鍵值檔　HI_FON.MST  -- RECORD LENGTH = 352 BYTES          *
*---------------------------------------------------------------------*
*> 主  ：FON-ID FON-CODE
*> 副１：FON-ID FON-TRN FON-CODE
*---------------------------------------------------------------------*
*>      2009/1/12       中西醫聯合住院增加欄位 - 向榮
*>      0980225         新增首日量處方序號(05.UDL延伸資料)
*>      2009/5/27       【６６】門診轉住院-檢驗檢查更新失敗紀錄(J0901074.J0901229) - 智勛
*>      2009/7/16       【０５】新增替代處置(搭配ECB.MST)(J0901262) - 智勛
*>      2009/10/22      幫(台中)化療針劑加識別與欄位 - 智勛
*>      2009/11/3       幫退藥相關作業加資料欄位存 HR_SBA,HI_RTB KEY - 智勛
*>      2009/12/15      檢傷分類改為5級，加上第5級的欄位 - 智勛
*>      2010/2/23       新增器官捐贈相關資料輸入(增加ID:29使用) - 智勛
*>      2010/3/15       新增寫 rfid 資料 log (增加ID:30使用) - 智勛
*>      2010/4/7        新增 rfid 資料異動紀錄(修改 ID:30 使用) - 智勛
*>      2010/4/8        新增 轉床作業 清床的LOG紀錄(修改 ID:31 使用) - 智勛
*>      2010/4/27       配合署北版化療輸注液加印體表面積(修改 ID:67 使用) - 智勛
*>      2010/4/29       修改 HIRFD log 寫檔資料(修改 ID:30 使用) - 智勛
*>      2010/5/7        (J1001046)因為新竹的申報主機跟HIS WIC資料DUPLICATE因此增加LOG追蹤(增加ID:32使用) - 智勛
*>      2010/6/11       幫加醫囑劑量及肝功能數據 (ID:67) - 智勛
*>      2010/11/24      (J1003562)"新增"功能時才讀病歷檔資本資料 - 鴻益
*>      2010/12/13      (J1003678)【３１】增加HHIPDCF呼叫結果及錯誤訊息 - 鴻益
*>      2010/12/20      (J1003302)【６９】增加住院醫令預開出院名單開立時間 - 鴻益
*>      2010/12/30      【０５】UDL項次流水號不可重覆 - 鴻益
*>      2011/01/26      (J1100144)【０５】增加抗生素刪除註記 D表示刪除 - 鴻益
*>      2011/02/09      (J1100363)【０５】連帶子項PPF折扣比率 - 鴻益

*>      2011/02/18      【０５】連帶項是否列入PPF計算 - 鴻益
*>      2011/02/18      【６９】增加預計出院日異動日期(key)及當時預計出院日 - 鴻益
*>      2011/02/18      【７０】增加二代HIS住院序號對照檔 - 鴻益
*>      2011/6/14       【Ｃ５】等同【０５】的LAYOUT, 只是FON-ID 不同, 但DATA 相同
*>                      是CHEMO醫令處方明細延伸檔 - 萃綸
*>      2011/6/14       【Ｃ７】等同【０７】的LAYOUT, 只是FON-ID 不同, 但DATA 相同
*>                      是CHEMO 醫令明細過期資料刪除檔 - 萃綸
*>      2011/6/14       【Ｃ８】等同【０８】的LAYOUT, 只是FON-ID 不同, 但DATA 相同
*>                      是CHEMO 傳送過濾臨時註記記錄 - 萃綸
*>      2011/11/16      (J1102489) FON-31-WRI-FUN增加住院申請、刪除住院申請 - 瑋育
*>      2012/03/26      台南-預約待床備註欄位開放可以輸入，儲存備註相關資料 - 瑋育
*>      2013/10/14      (J1201427)【ＥＭ】急診品質提昇方案收案識別 - 昱志
*>      2013/01/30      自費特材替代群組 - 瑋育
*>      2013/04/19      新版死亡證明書，微調報表格式、移除"婚姻情況"、新增"懷孕情形"
*>      2015/01/27      【７１】TQIP住院資料轉檔作業的轉檔LOG(J1500160) - 淑儀
*>      2015/02/09      【７２】聖母-出院補登診斷碼鎖檔參數設定(J1500091) - 淑儀
*>      2015/03/02      【７３】聖母-出院補登作業是否存檔(J1500091) - 淑儀
*>      2015/03/10      【７３】新增聖母-出院補登人員存檔LOG及【７４】出院補登鎖檔異動LOG
*>      2016/12/19      【９３】新生兒依附就醫申報資料紀錄(2016/12/19)-鴻益
*>      2014/11/06 35.藥品圖文-事後補異常紀錄(台南)(2014/11/06) - 瑋育
*>      2017/06/20 36.住院簡訊通知(新北市) - 上智
*>      2017/08/22 37.聖母-困難插管存檔欄位增修 - 上智
*>      2017/09/15 5.新增首日量時之檔案序號 - 上智
*---------------------------------------------------------------------*
 FD FON-MST EXTERNAL.
 01 FON-MST-REC.
        02 FON-MST-KEY.
*>      識別碼
*>              (01.欲切帳病人  02.批次作首日量病人 03.托別異動         04.聯繫未收案
*>              05.UDL延伸資料 06.門診轉住院       07.UDL過期資料刪除  08.UD傳送過濾臨時註記記錄
*>              09.外宿登錄    10.處方筆數月報資料 11.預約住院延伸資料 12.手術帳單鎖檔
*>      13.設定申報註記<特定個案作業>      14.修改最近住院序號之異動記錄
*>      15.住院日結記錄<IPD-MST寫檔99之記錄> 16.修改門急診轉住院之註記
*>      17.出院退藥確認<同12> 18.修改出院診斷和手術碼之異動記錄
*>      19.住院日控制記錄
*>      20.轉介資料回寫錯誤之記錄(CNT-MST REWRITE ERROR之記錄)
*>      21.出院結帳清床失敗之記錄(BED-MST REWRITE ERROR之記錄)
*>      22.切帳還原紀錄(切帳還原作廢之住院序號)
*>      23.死亡證明書                   2002/12/21 (23和24為同一筆死亡記錄)
*>      24.死亡證明書之死亡原因         2002/12/21 ,2004/8/17 增加其他對於死亡有影響之疾病或身體狀況
*>      25.證件未齊                     2003/1/10
*>      26.住院批價[組別]對應之調劑方式＆相關說明 - 動物醫院專用欄位：[調劑方式]-NID06A1 (2007/11/17)
*>              0970428,yung,新增台大化療備註欄位
*>      27.北市 跨院區轉床病患,存前一院區基本資料 - (97022501)(J0800594)(2008/6/10) - 向榮
*>      28.聖母 住管系統加住院備註(J0802247)(2008/10/31) - 向榮
*>      29.新增器官捐贈相關資料輸入(2010/2/23) - 智勛
*>      30.新增寫 rfid 資料 log(2010/3/15) - 智勛
*>      31.新增 轉床作業 清床的LOG紀錄(2010/4/8) - 智勛
*>      32.新增 HIWICWCF 寫 WIC 資料 LOG 紀錄(2010/5/7) - 智勛
*>      33.預約待床備註欄位開放可以輸入，儲存備註相關資料(2012/03/26) - 瑋育
*>      34.自費特材替代群組 - 瑋育
*>      35.藥品圖文-事後補異常紀錄(台南)(2014/11/06) - 瑋育
*>      36.住院簡訊通知(新北市) - 上智
*>      37.聖母-困難插管存檔欄位增修 - 上智
*>      66.門診轉住院-檢驗檢查更新失敗紀錄(J0901074.J0901229)(2009/5/27) - 智勛
*>      65.幫退藥相關作業加資料欄位存 HR_SBA,HI_RTB KEY (2009/11/3) - 智勛
*>      67.(台中)化療針劑加識別與欄位(2009/10/22) - 智勛

*>      68.(北市)死亡證明書病患基本資料識別別與欄位(2010/11/24) - 鴻益
*>      69.(彰化)增加住院醫令預開出院名單開立時間(2010/12/20) - 鴻益
*>      70.(北市二代HIS)增加二代HIS住院序號對照檔(2011/02/18) - 鴻益
*>      71.TQIP住院資料轉檔作業的轉檔LOG(2015/01/27)(J1500160) - 淑儀
*>      72.聖母-出院補登診斷碼鎖檔參數設定(2015/02/09)(J1500091) - 淑儀
*>      73.聖母-出院補登作業是否存檔(2015/03/02)(J1500091) - 淑儀
*>      74.聖母-出院補登診斷碼鎖檔參數異動LOG檔(2015/03/10)(J1500091) - 淑儀
*>      93.新生兒依附就醫申報資料紀錄(2016/12/19)-鴻益
*>      LK.申報鎖/解檔異動紀錄(2019/7/11)-鴻益
*>      94.桃園-領藥號紀錄(2019/08/29)-彥廷
*>      95.桃園-病人床位所在紀錄(2020/01/09)-彥廷
*>      96.桃園-即將到期UD用藥清單(2020/02/25)-彥廷
*>      80.牙科牙位(2022/12/23)-彥廷
*>      AA.急診月報檔)
*>      C5.CHEMO 醫令明細延伸資料 C7.CHEMO 醫令明細過期資料刪除  C8.CHEMO 傳送過濾臨時註記記錄 - 萃綸
*>                      是CHEMO 傳送過濾臨時註記記錄 - 萃綸
                03 FON-ID PIC X(02).
                03 FON-CODE PIC X(50).

*>              【０１．欲切帳病人】
                03 FON-01-CODE-KEY REDEFINES FON-CODE.
*>              住院序號
                        04 FON-01-IPD-NO                PIC X(11).
                        04 FON-01-CODE-REC              PIC X(39).

*>              【０３．托別異動】
                03 FON-03-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-03-IPD-NO                PIC X(11).
*>                      轉換日期
                        04 FON-03-DATE                  PIC 9(07).
*>                      轉換時間
                        04 FON-03-TIME                  PIC 9(06).
                        04 FON-03-CODE-REC              PIC X(26).

*>              【０４．聯繫未收案】
                03 FON-04-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-04-CASE-NO               PIC X(11).
*>                      項目
                        04 FON-04-ITEM                  PIC X(03).
*>                      代碼
                        04 FON-04-CODE                  PIC 9(03).
                        04 FON-04-CODE-REC              PIC X(33).

*>              【０５．ＵＤＬ延伸資料】
                03 FON-05-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-05-IPD-NO                PIC X(11).
*>                      項目序號
                        04 FON-05-FEE-SEQ               PIC 9(03).

                        04 FON-05-CODE-REC              PIC X(36).

*>              【０６．門診轉住院】
                03 FON-06-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號

                        04 FON-06-IPD-NO                PIC X(11).
*>                      門診序號
                        04 FON-06-RO-NO                 PIC X(11).
                        04 FON-06-CODE-REC              PIC X(28).

*>              【０７．ＵＤＬ延伸資料過期資料刪除】
                03 FON-07-CODE-KEY REDEFINES FON-CODE.
*>                      藥局別
                        04 FON-07-ID                    PIC X(02).
*>                      傳送日
                        04 FON-07-SEND-DT               PIC 9(07).
*>                      傳送別 [0.全日/1.早/2.午/3.晚]
                        04 FON-07-SEND-METH             PIC X(01).
*>                      床號
                        04 FON-07-BED.
                                05 FON-07-BED-ROOM      PIC X(04).
                                05 FON-07-BED-NO        PIC X(02).
*>                      項目
                        04 FON-07-FEE-SEQ               PIC 9(03).
*>                      處置代碼
                        04 FON-07-FEE-KEY               PIC X(09).
                        04 FON-07-CODE-REC              PIC X(22).

*>              【０８．UD傳送過濾臨時註記記錄】
                03 FON-08-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-08-IPD-NO                PIC X(11).
*>                      傳日日期、時間
                        04 FON-08-SEND-DT               PIC 9(07).
                        04 FON-08-SEND-TIME             PIC 9(06).
                        04 FON-08-CODE-REC              PIC X(26).

*>              【０９．外宿登錄】
                03 FON-09-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號(須同時維護 FON-09-TRN-IPD-NO)
                        04 FON-09-IPD-NO                PIC X(11).
*>                      外宿次數倒序 (EX . 999999 - 1)
                        04 FON-09-SEQ-V                 PIC 9(06).
                        04 FON-09-CODE-REC              PIC X(33).

*>              【１０．處方筆數月報資料】
                03 FON-10-CODE-KEY REDEFINES FON-CODE.
*>                      年月
                        04 FON-10-YM                    PIC 9(05).
*>                      護理站
                        04 FON-10-UNIT                  PIC X(05).
*>                      1.ＵＤ留院人數  2.非ＵＤ留院人數 3.ＵＤ藥品筆數 4.臨時藥品筆數 5.退藥筆數
                        04 FON-10-DATA-ID               PIC 9(01).
                        04 FON-10-CODE-REC              PIC X(39).

*>              【１１．預約住院延伸資料】
                03 FON-11-CODE-KEY REDEFINES FON-CODE.
*>                      病歷號碼
                        04 FON-11-PAT-NO                PIC 9(08).
                        04 FON-11-PRE-SAVE              PIC X(01).
*>                      登錄日期時間
                        04 FON-11-PRE-DT                PIC 9(07).

                        04 FON-11-PRE-TIME              PIC 9(06).
                        04 FON-11-CODE-REC              PIC X(28).

*>              【１２．手術鎖檔病人】
                03 FON-12-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-12-IPD-NO                PIC X(11).
                        04 FON-12-CODE-REC              PIC X(39).

*>              【１３．設定申報註記】
                03 FON-13-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-13-IPD-NO                PIC X(11).
*>                      異動日期、時間
                        04 FON-13-UPD-DT                PIC 9(07).
                        04 FON-13-UPD-TIME              PIC 9(06).
                        04 FON-13-CODE-REC              PIC X(26).

*>              【１４．修改最近住院序號之異動記錄】
                03 FON-14-CODE-KEY REDEFINES FON-CODE.
*>                      病歷號碼
                        04 FON-14-PAT-NO                PIC 9(08).
*>                      異動日期、時間
                        04 FON-14-UPD-DT                PIC 9(07).
                        04 FON-14-UPD-TIME              PIC 9(06).
                        04 FON-14-CODE-REC              PIC X(29).

*>              【１５．住院日結記錄】
                03 FON-15-CODE-KEY REDEFINES FON-CODE.
*>                      執行日期、時間
                        04 FON-15-DT               PIC 9(07).
                        04 FON-15-TIME             PIC 9(06).
*>                      住院序號
                        04 FON-15-IPD-NO           PIC X(11).
                        04 FON-15-CODE-REC         PIC X(26).

*>              【１６．修改門急診轉住院之註記】
                03 FON-16-CODE-KEY REDEFINES FON-CODE.
*>                      門診序號
                        04 FON-16-RO-NO            PIC X(11).
*>                      修改日期、時間
                        04 FON-16-DT               PIC 9(07).
                        04 FON-16-TIME             PIC 9(06).

                        04 FON-16-CODE-REC         PIC X(26).

*>              【１８．修改出院診斷和手術碼之異動記錄】
                03 FON-18-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-18-IPD-NO           PIC X(11).
*>                      修改日期、時間
                        04 FON-18-UPD-DT           PIC 9(07).
                        04 FON-18-UPD-TIME         PIC 9(06).

                        04 FON-18-CODE-REC         PIC X(26).

*>              【１９．住院日控制記錄】

                03 FON-19-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-19-IPD-NO PIC X(11).
*>                      修改第N次之倒KEY (999999 - 第N次)
                        04 FON-19-SEQ-V            PIC 9(06).

                        04 FON-19-CODE-REC         PIC X(33).

*>              【２０．轉介回寫錯誤之記錄】
                03 FON-20-CODE-KEY REDEFINES FON-CODE.
*>                      CNT-KEY 值
                        04 FON-20-CNT-KEY          PIC X(50).

*>              【２１．出院結帳清床失敗之記錄】
                03 FON-21-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-21-IPD-NO           PIC X(11).
*>                      處理日期
                        04 FON-21-DATE             PIC 9(07).
*>                      處理時間
                        04 FON-21-TIME             PIC 9(06).
                        04 FON-21-CODE-REC         PIC X(26).

*>              【２２．切帳還原記錄】
                03 FON-22-CODE-KEY REDEFINES FON-CODE.
*>                      切帳還原作廢之住院序號
                        04 FON-22-IPD-NO           PIC X(11).
                        04 FON-22-CODE-REC         PIC X(39).

*>              2002/12/21 04:13下午
*>              【２３．死亡證明書】
                03 FON-23-CODE-KEY REDEFINES FON-CODE.
*>                      病歷號碼
                        04 FON-23-PAT-NO           PIC 9(08).
                        04 FON-23-CODE-REC         PIC X(42).

*>              【２４．死亡證明書之死亡原因】
                03 FON-24-CODE-KEY REDEFINES FON-CODE.
*>                      病歷號碼
                        04 FON-24-PAT-NO           PIC 9(08).
                        04 FON-24-CODE-REC         PIC X(42).

*>              2003/1/10 11:11AM
*>              【２５．證件未齊】
                03 FON-25-CODE-KEY REDEFINES FON-CODE.
*>                      切帳還原作廢之住院序號
                        04 FON-25-IPD-NO           PIC X(11).
                        04 FON-25-CODE-REC         PIC X(39).

*>              2007/11/19
*>              【２６．動物醫院批價處方之[調劑方式]】
                03 FON-26-CODE-KEY REDEFINES FON-CODE.
*>                      批價處方之住院序號
                        04 FON-26-IPD-NO                PIC X(11).
*>                      批價處方之處方序號
                        04 FON-26-ODR-NO                PIC X(11).
*>                      組別

                        04 FON-26-POWDER                PIC X(01).
                        04 FON-26-CODE-REC              PIC X(27).

*>              2008/6/10
*>              【２７．跨院區轉床,前一院區基本資料】
                03 FON-27-CODE-KEY REDEFINES FON-CODE.
*>                      轉床後院區住院序號
                        04 FON-27-IPD-NO                PIC X(11).
                        04 FON-27-CODE-REC              PIC X(39).

*>              2008/10/31
*>              【２８．住院備註】
                03 FON-28-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-28-IPD-NO                PIC X(11).
                        04 FON-28-CODE-REC              PIC X(39).

*>              2010/2/23 新增器官捐贈相關資料輸入
*>              【２９．器官捐贈相關資料輸入】
                03 FON-29-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-29-IPD-NO                PIC X(11).
                        04 FON-29-CODE-REC              PIC X(39).

*>               2010/3/15 新增寫 rfid 資料 log
*>              【３０．寫 rfid 資料 log紀錄】   (50長)
                03 FON-30-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號                                (1:11)
                        04 FON-30-IPD-NO                PIC X(11).
*>                      寫LOG的系統 (0.病歷資料轉檔 1.住院申請 2.轉床 3.出院 5.退床 6.切帳 7.出院轉入院 8.退床作業 9.處理異常
*>                                                              (12:1)
                        04 FON-30-WRI-SYS               PIC X(01).
*>                      2010/4/7 加上異動時間點當key區別        (13:16)
                        04 FON-30-DTTI.
                                05 FON-30-DATE          PIC 9(08).
                                05 FON-30-TIME          PIC 9(08).
*>                      預留                                    (29:22)
*>                              2010/4/7 (38) → (22)
                        04 FON-30-CODE-REC              PIC X(22).

*>               2010/4/8 新增 轉床作業 清床的LOG紀錄
*>              【３１．轉床作業 清床的LOG紀錄】   (50長)
                03 FON-31-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號                                (1:11)
                        04 FON-31-IPD-NO                PIC X(11).
*>                      轉床作業會清床的功能點 (1.轉床 2.刪除轉床資料 3.對轉 4.整批轉 8.住院申請 9.刪除住院申請)
*>                                                              (12:1)
                        04 FON-31-WRI-FUN               PIC X(01).
*>                      作業執行時間點                          (13:16)
                        04 FON-31-DTTI.
                                05 FON-31-DATE  PIC 9(08).
                                05 FON-31-TIME  PIC 9(08).
*>                      預留                                    (29:22)
                        04      FON-31-CODE-REC         PIC X(22).

*>              2010/5/7 新增 HIWICWCF 寫 WIC 資料 LOG 紀錄
*>              【３２．HIWICWCF 寫 WIC 資料 LOG 紀錄】   (50長)

                03 FON-32-CODE-KEY REDEFINES FON-CODE.
*>                      證明識別 1.重大 2.福保 3.北市兒童 4.殘障 (01:01)
                        04 FON-32-WIC-ID                PIC X(01).
*>                      證明編號                                (02:15)
                        04 FON-32-WIC-NO                PIC X(15).
*>                      建檔系統                                (17:03)
                        04 FON-32-WIC-CRE-SYS   PIC X(03).
*>                      作業執行時間點                  (20:16)
                        04 FON-32-DTTI.
                                05 FON-32-DATE          PIC 9(08).
                                05 FON-32-TIME          PIC 9(08).
*>                      預留                                    (36:15)
                        04 FON-32-CODE-REC              PIC X(15).

*>              2012/03/26 預約待床備註欄位開放可以輸入，儲存備註相關資料
*>              【３３．預約待床】   (50長)
                03 FON-33-CODE-KEY REDEFINES FON-CODE.
*>                      病床床號
                        04 FON-33-BED.
*>                              病房                            (01:04)
                                05 FON-33-BED-ROOM      PIC X(04).
*>                              床號                            (05:02)
                                05 FON-33-BED-NO        PIC X(02).
*>                      預留                                    (07:44)
                        04 FON-32-CODE-REC              PIC X(44).

*>              2013/01/30 自費特材替代群組
*>              【３４．自費特材資料】
                03 FON-34-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-34-IPD-NO           PIC X(11).
*>                      項目序號
                        04 FON-34-FEE-SEQ          PIC 9(03).
                        04 FON-34-CODE-REC         PIC X(36).

*>              2014/11/06 藥品圖文-事後補異常紀錄(台南)
*>              【３５．事後補異常紀錄】
                03 FON-35-CODE-KEY REDEFINES FON-CODE.
*>                      藥師 (1:5)
                        04 FON-35-DR-NO PIC X(05).
*>                      資料識別(01.審核 02.核藥 03.給藥) (6:2)
                        04 FON-35-ID PIC X(02).
*>                      住院序號 (8:11)
                        04 FON-35-IPD-NO PIC X(11).
*>                      處置代碼 (19:9)
                        04 FON-35-PRS-ID PIC X(09).
*>                      預留 (28:23)
                        04 FON-35-CODE-REC PIC X(23).

*>              【３６．住院簡訊通知】
                03 FON-36-CODE-KEY REDEFINES FON-CODE.
*>                      病歷號 (1:8)
                        04 FON-36-PAT-NO PIC 9(8).
*>                      住院序號 (9:11)
                        04 FON-36-IPD-NO PIC X(11).
*>                      預留 (20:31)
                        04 FON-36-CODE-REC PIC X(31).


*>              【３７．聖母-困難插管存檔欄位】
                03 FON-37-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號 (1:11)
                        04 FON-37-IPD-NO PIC X(11).
*>                      病歷號 (12:8)
                        04 FON-37-PAT-NO PIC 9(8).
*>                      預留 (20:31)
                        04 FON-37-CODE-REC PIC X(31).

*>              2009/5/27
*>              【６６．門診轉住院-檢驗檢查更新失敗紀錄】(50長)
                03 FON-66-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號                (01:11)
                        04 FON-66-IPD-NO                PIC X(11).
*>                      門診序號                (12:11)
                        04 FON-66-RO-NO         PIC X(11).
*>                      醫令單號                (23:08)
                        04 FON-66-HTCHK-CHK-NO  PIC X(08).
*>                      寫紀錄位置 1.REWRITE錯誤時寫紀錄。 2.讀取不到檢驗檔時寫紀錄。
*>                                 3.跑完寫檔那段後位置，用來判斷是否有來執行更新檢驗檔程式。   (31:01)
                        04 FON-66-WRITE-POSITION        PIC X(01).
*>                      寫紀錄日期, 時間        (32:16)
                        04 FON-66-WRI-DTTI.
                                05 FON-66-WRI-DATE      PIC 9(08).
                                05 FON-66-WRI-TIME      PIC 9(08).
*>                      預留                    (48:03)
                        04 FON-66-CODE-REC              PIC X(03).


*>       65. 幫退藥相關作業加資料欄位存 HR_SBA,HI_RTB KEY (2009/11/3) - 智勛
*>              【６５． HI_RTB KEY】(50長)
                03 FON-65-CODE-KEY REDEFINES FON-CODE.
                        04 FON-65-RTB-KEY.
*>                              住院序號
                                05      FON-65-RTB-IPD-NO.
*>                                      住院日期
                                        06      FON-65-RTB-IPD-DATE     PIC 9(7).
*>                                      住院流水號
                                        06      FON-65-RTB-IPD-SEQ      PIC 9(4).
                                05      FON-65-RTB-ODR-NO.
*>                                      退藥 處方日期
                                        06      FON-65-RTB-INS-DATE     PIC 9(7).
*>                                      退藥 流水號
                                        06      FON-65-RTB-ODR-SEQ      PIC 9(3).
*>                              處置流水號
                                05      FON-65-RTB-FEE-SEQ              PIC 9(3).
                        04 FON-65-CODE-REC                      PIC X(26).


*>       67.(台中)化療針劑加識別與欄位(2009/10/22) - 智勛
*>              【６７．化療針劑加識別與欄位】(50長)
                03 FON-67-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-67-IPD-NO PIC X(11).
*>                      處方序號
                        04 FON-67-ODR-NO PIC X(11).

*>                      處置流水號
                        04 FON-67-FEE-SEQ               PIC 9(03).
*>                      預留
                        04 FON-67-CODE-REC              PIC X(25).

*>              【ＡＡ．急診月報檔】
                03 FON-AA-CODE-KEY REDEFINES FON-CODE.
*>                      年月
                        04 FON-AA-YM               PIC 9(05).
*>                      科別
                        04 FON-AA-DPT              PIC X(04).
                        04 FON-AA-CODE-REC         PIC X(41).
*>              【ＢＢ．急診日報檔】
                03 FON-BB-CODE-KEY REDEFINES FON-CODE.
*>                      日期
                        04 FON-BB-DT               PIC 9(07).
*>                      科別
                        04 FON-BB-DPT              PIC X(04).
                        04 FON-BB-CODE-REC         PIC X(39).
*>              【６８．死亡證明書之死者基本資料】
                03 FON-68-CODE-KEY REDEFINES FON-CODE.
*>                      病歷號碼
                        04 FON-68-PAT-NO           PIC 9(08).
                        04 FON-68-CODE-REC         PIC X(42).
*>              【６９．住院醫令預開出院名單】
                03 FON-69-CODE-KEY REDEFINES FON-CODE.
*>                      病歷號碼
                        04 FON-69-PAT-NO           PIC 9(08).
                        04 FON-69-IPD-NO           PIC X(11).
*>                      2011/02/18 記錄歷次開立內容
*>                      開立日期
                        04 FON-69-OPEN-DT               PIC 9(07).
                        04 FON-69-OPEN-TI.
                                05 FON-69-OPEN-HH       PIC 9(02).
                                05 FON-69-OPEN-MN       PIC 9(02).
                                05 FON-69-OPEN-SS       PIC 9(02).
                        04 FON-69-CODE-REC         PIC X(18).
*>              【７０．北市二代HIS住院序號對照檔】
                03 FON-70-CODE-KEY REDEFINES FON-CODE.
*>                      北市二代病歷號碼
                        04 FON-70-PAT-NO                PIC 9(08).
*>                      北市二代病患序號(院區(2)+該病患來院次序(4))
                        04 FON-70-PAT-SEQ          PIC X(06).
                        04 FON-70-CODE-REC         PIC X(36).

*>               2015/01/27 TQIP住院資料轉檔作業的轉檔LOG
*>              【７１．TQIP住院資料轉檔紀錄】
                03 FON-71-CODE-KEY REDEFINES FON-CODE.
*>                      轉檔年月
                        04 FON-71-TURN-DATE             PIC 9(05).
*>                      執行日期/時間(起)
                        04 FON-71-DTTI.
                                05 FON-71-UPD-DT                PIC 9(07).
                                05 FON-71-UPD-TIME              PIC 9(06).
*>                      預留32長
                        04 FON-71-CODE-REC         PIC X(32).


*>               2015/02/09     聖母-出院補登診斷碼鎖檔參數
*>              【７２．聖母-出院補登診斷碼鎖檔設定】
                03 FON-72-CODE-KEY REDEFINES FON-CODE.
*>                              出院補登代碼：0
                        04 FON-72-ID                    PIC 9(1).
*>                              預留49長
                        04 FON-72-CODE-REC              PIC X(49).

*>               2015/03/02     聖母-出院補登作業是否存檔
*>              【７３．聖母-出院補登作業是否存檔(出院補登紀錄)】
                03 FON-73-CODE-KEY     REDEFINES   FON-CODE.
*>              住院識別 【 A.因病住院 B.護理之家 C.日間照護 X.聯繫未收案 】
*>                              【 a.刪除因病住院 b.刪除護理之家 c.刪除日間照護  】
                        04 FON-73-LIVE-ID               PIC X(01).
*>                      住院序號
                        04 FON-73-IPD-NO.
                                05 FON-73-IPD-DT        PIC 9(07).
                                05 FON-73-IPD-SEQ       PIC 9(04).
*>                              預留38長
                        04 FON-73-CODE-REC     PIC X(38).

*>              2015/03/10      【７４】出院補登鎖檔異動LOG
                03 FON-74-CODE-KEY REDEFINES FON-CODE.
*>                      執行日期/時間
                        04 FON-74-DTTI.
                                05 FON-74-UPD-DT                PIC 9(07).
                                05 FON-74-UPD-TIME              PIC 9(06).
*>                      預留37長
                        04 FON-74-CODE-REC                      PIC X(37).

*>              2016/12/19
*>              【９３．新生兒依附就醫申報資料紀錄】
                03      FON-93-CODE-KEY     REDEFINES   FON-CODE.
*>                      病歷號碼
                        04      FON-93-PAT-NO           PIC 9(08).
*>                      1.門診/2.住院
                        04      FON-93-ID               PIC X(01).
*>                      費用年月
                        04      FON-93-APY-YM           PIC 9(05).
*>                      申報類別   1:送核 2:補報
                        04      FON-93-APY-PART         PIC X(01).
*>                      補報次數
                        04      FON-93-APP-CNT          PIC 9(01).
*>                      案件
                        04      FON-93-CASE-ID          PIC X(02).
*>                      流水號
                        04      FON-93-SEQ-NO           PIC 9(06).
*>                      預留
                        04      FON-93-CODE-REC         PIC X(26).

*>              【ＥＭ．急診品質提昇方案收案識別】
                03 FON-EM-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號
                        04 FON-EM-IPD-NO.
                                05 FON-EM-IPD-DT        PIC 9(07).
                                05 FON-EM-IPD-SEQ       PIC 9(04).
*>                      病歷號碼

                        04 FON-EM-PAT-NO                PIC 9(08).
                        04 FON-EM-CODE-REC              PIC X(31).

*>              【ＬＫ．申報鎖檔/解鎖異動記錄】-2019/7/11
                03      FON-LK-CODE-KEY     REDEFINES   FON-CODE.
*>                      門住識別(I:住院;O:門診)
                        04      FON-LK-IO               PIC X(01).
*>                      費用年月
                        04      FON-LK-YM               PIC 9(05).
*>                      修改日期、時間
                        04      FON-LK-DT               PIC 9(07).
                        04      FON-LK-TIME             PIC 9(06).
                        04      FON-LK-CODE-REC         PIC X(31).
*>              【９４．領藥號紀錄】
                03 FON-94-CODE-KEY REDEFINES FON-CODE.
*>                      病歷號 (1:8)
                        04 FON-94-PAT-NO                PIC 9(8).
*>                      住院序號 (9:11)
                        04 FON-94-IPD-NO                PIC X(11).
*>                      日期(20:7)
                        04 FON-94-DATE                  PIC 9(07).
*>                      預留 (27:24)
                        04 FON-94-CODE-REC              PIC X(24).
*>              【９５．病人床位所在紀錄】
                03 FON-95-CODE-KEY REDEFINES FON-CODE.
*>                      病歷號 (1:8)
                        04 FON-95-PAT-NO                PIC 9(08).
*>                      待床登錄日期 (9:7)
                        04 FON-95-WAT-DT                PIC 9(07).
*>                      待床登錄時間 (16:6)
                        04 FON-95-WAT-TIME              PIC 9(06).
*>                      預留 (22:29)
                        04 FON-95-CODE-REC              PIC X(29).
*>              【９６．即將到期UD用藥清單】
                03 FON-96-CODE-KEY REDEFINES FON-CODE.
*>                      病歷號 (1:7)
                        04 FON-96-DATE                  PIC 9(07).
*>                      護理站 (8:5)
                        04 FON-96-UNIT                  PIC X(05).
*>                      預留 (13:38)
                        04 FON-96-CODE-REC              PIC X(38).
*>              【８０．牙科牙位】
                03 FON-80-CODE-KEY REDEFINES FON-CODE.
*>                      住院序號(1:11)
                        04 FON-80-IPD-NO                PIC 9(11).
*>                      處方序號(12:11)
                        04 FON-80-ODR-NO                PIC 9(11).
*>                      流水號(23:3)
                        04 FON-80-SEQ                   PIC 9(03).
*>                      預留(26:25)
                        04 FON-80-CODE-REC              PIC X(25).
*>      副 KEY
*$XFD USE GROUP , VAR-LENGTH
        02 FON-TRN                                 PIC X(50).

*>      【０１．欲切帳病人】
        02 FON-01-TRN REDEFINES FON-TRN.

*>              出院日期
                03 FON-01-OUT-DT                        PIC 9(07).
                03 FON-01-TRN-REC                       PIC X(43).
*>      【０５．ＵＤＬ延伸資料】
        02 FON-05-TRN REDEFINES FON-TRN.
*>              10碼檔案序號(HRLOG4-G1-UDL-SEQ)
                03 FON-05-G1-UDL-SEQ            PIC 9(10).
*>              2017/09/15 新增首日量時之檔案序號
*>              新增首日量時之檔案序號
                03 FON-05-ECB-FILE-NO           PIC 9(03).
                03 FON-05-TRN-REC               PIC X(37).

*>      【０６．門診轉住院】
        02 FON-06-TRN REDEFINES FON-TRN.
*>              門診序號
                03 FON-06-TRN-RO-NO PIC X(11).
                03 FON-06-TRN-REC PIC X(39).

*>      【０８．UD傳送過濾臨時註記記錄】
        02 FON-08-TRN REDEFINES FON-TRN.
*>              傳日日期、時間
                03 FON-08-TRN-SEND-DT              PIC 9(07).
                03 FON-08-TRN-SEND-TIME            PIC 9(06).
                03 FON-08-TRN-REC                  PIC X(37).

*>      【０９．外宿登錄】
        02 FON-09-TRN REDEFINES FON-TRN.
*>              住院序號
                03 FON-09-TRN-IPD-NO               PIC X(11).
*>              實際轉回日期、時間
                03 FON-09-BACK-DTTI.
                        04 FON-09-BACK-DT          PIC 9(07).
                        04 FON-09-BACK-TIME        PIC 9(06).
                03 FON-09-TRN-REC                  PIC X(26).

*>      【１１．預約住院延伸資料】
        02 FON-11-TRN REDEFINES FON-TRN.
*>              住院序號
                03 FON-11-IPD-NO.
                        04 FON-11-IPD-DATE              PIC 9(07).
                        04 FON-11-IPD-SEQ               PIC 9(04).
*>              登錄科別
                03 FON-11-PRE-DPT               PIC X(04).
                03 FON-11-TRN-REC               PIC X(35).

*>      【１５．住院日結記錄】
        02 FON-15-TRN REDEFINES   FON-TRN.
*>              日結日
                03 FON-15-DAY-DT                        PIC 9(07).
                03 FON-15-TRN-REC                  PIC X(43).

*>      【１９．住院日控制記錄】
        02 FON-19-TRN REDEFINES FON-TRN.
*>              住院序號
                03 FON-19-TRN-IPD-NO            PIC X(11).
*>              修改第N次
                03 FON-19-SEQ                   PIC 9(06).

                03 FON-19-TRN-REC                  PIC X(33).

*>      2002/12/21 04:16下午
*>      【２３．死亡證明書】
        02 FON-23-TRN REDEFINES FON-TRN.
*>              死亡日期
                03 FON-23-DIE-DT PIC 9(07).
                03 FON-23-DIE-TIME.
                        04 FON-23-DIE-HH PIC 9(02).
                        04 FON-23-DIE-MN PIC 9(02).
                03 FON-23-TRN-REC PIC X(39).

*>      2014/11/06 藥品圖文-事後補異常紀錄(台南)
*>      【３５．事後補異常紀錄】
        02 FON-35-TRN REDEFINES FON-TRN.
*>              藥師
                03 FON-35-TRN-DR-NO PIC X(05).
*>              給藥日期
                03 FON-35-TRN-SEND-DT PIC 9(07).
*>              是否已修改異常紀錄註記(Y:表示已經修改過異動紀錄)
                03 FON-35-TRN-MOD-MARK PIC X(01).
*>              預留
                03 FON-35-TRN-REC PIC X(37).

*>      【３７．聖母-困難插管存檔欄位】
        02 FON-37-TRN REDEFINES FON-TRN.
*>              困難插管異動日期 (1:7)
                03 FON-37-MOD-DATE PIC 9(7).
*>              困難插管異動時間 (8:6)
                03 FON-37-MOD-TIME PIC 9(6).
*>              預留 (14:37)
                03 FON-37-TRN-REC PIC X(37).

*>       65. 幫退藥相關作業加資料欄位存 HR_SBA,HI_RTB KEY (2009/11/3) - 智勛
*>      【６５．HR_SBA KEY】(50長)
        02 FON-65-TRN REDEFINES FON-TRN.
                03      FON-65-SBA-KEY.
*>                      住院序號
                        04      FON-65-SBA-IPD-NO.
*>                              住院日期
                                05      FON-65-SBA-IPD-DATE         PIC 9(07).
*>                              住院流水號
                                05      FON-65-SBA-IPD-SEQ          PIC 9(04).
                        04      FON-65-SBA-ODR-NO.
*>                              退藥申請日期
                                05      FON-65-SBA-INS-DATE         PIC 9(07).
*>                              退藥申請流水號
                                05      FON-65-SBA-ODR-SEQ          PIC 9(04).
                03      FON-65-TRN-REC          PIC X(28).

*>      【ＡＡ．急診月報檔】
        02 FON-AA-TRN REDEFINES FON-TRN.
*>              科別
                03      FON-AA-TRN-DPT                  PIC X(11).
                03      FON-AA-TRN-REC                  PIC X(39).
*>      【BB．急診日報檔】
        02 FON-BB-TRN REDEFINES FON-TRN.

*>              科別
                03 FON-BB-TRN-DPT                       PIC X(11).
                03 FON-BB-TRN-REC                  PIC X(39).

*>               2015/01/27 TQIP住院資料轉檔作業的轉檔LOG
*>              【７１．TQIP住院資料轉檔紀錄】
        02              FON-71-TRN     REDEFINES               FON-TRN.
*>                      執行人員代碼
                        03      FON-71-UPD-UID           PIC X(05).
*>                      預留45長
                        03      FON-71-TRN-REC           PIC X(45).

*>              2015/03/10 出院補登鎖檔異動LOG
*>              【７４．出院補登鎖檔異動LOG】
        02              FON-74-TRN REDEFINES FON-TRN.
*>                      執行人員代碼
                        03      FON-74-UPD-UID PIC X(05).
*>                      預留45長
                        03      FON-74-TRN-REC PIC X(45).

*>              2016/12/19
*>              【９３．新生兒依附就醫申報資料紀錄】
        02      FON-93-TRN     REDEFINES               FON-TRN.
*>                      1.門診/2.住院
                        03      FON-93-ID-TRN            PIC X(01).
*>                      費用年月
                        03      FON-93-APY-YM-TRN        PIC 9(05).
*>                      申報類別   1:送核 2:補報
                        03      FON-93-APY-PART-TRN      PIC X(01).
*>                      補報次數
                        03      FON-93-APP-CNT-TRN       PIC 9(01).
*>                      預留45長
                        03      FON-93-TRN-REC           PIC X(42).
*>              【９５．病人床位所在紀錄】
        02      FON-95-TRN REDEFINES FON-TRN.
*>                      病人目前所在位置 (1:1)
                        03 FON-95-FROM                  PIC 9(1).
*>                      住院序號 (2:11)
                        03 FON-95-IPD-NO.
*>                              住院日期
                                04      FON-95-IPD-DATE PIC 9(07).
*>                              住院流水號
                                04      FON-95-IPD-SEQ  PIC 9(04).
                        03 FON-95-TRN-REC               PIC X(38).

*$XFD USE GROUP , VAR-LENGTH
*>      資料值
        02 FON-DATA                                PIC X(250).
*
*>      【０３．托別異動】
        02 FON-03-DATA     REDEFINES               FON-DATA.
*>              新托別代碼
                03 FON-03-NEW-CARE                 PIC X(01).
*>              原托別代碼
                03 FON-03-OLD-CARE                 PIC X(01).
*>              異動碼  [1] 入院 [2] 轉換托別
                03 FON-03-UPD-CODE                 PIC X(01).

*>              異動日期
                03 FON-03-UPD-DATE                 PIC 9(07).
*>              異動時間
                03 FON-03-UPD-TIME                 PIC 9(06).
*>              異動人代碼
                03 FON-03-UPD-UID                  PIC X(05).
*>              新巴氏量表
                03 FON-03-NEW-BARTH-SCORE          PIC 9(03).
*>              新依賴程度
                03 FON-03-NEW-DEGREE               PIC X(01).
*>              原巴氏量表
                03 FON-03-OLD-BARTH-SCORE          PIC 9(03).
*>              原依賴程度
                03 FON-03-OLD-DEGREE               PIC X(01).
                03 FON-03-DATA-REC                 PIC X(221).


*>      【０５．ＵＤＬ延伸資料】
*>      【０７．ＵＤＬ延伸資料過期資料刪除】
        02 FON-05-DATA REDEFINES FON-DATA.
*>              備註 (1:50)
                03 FON-05-REMARK                PIC X(50).
*>              UD剩餘數量分子 (51:04)
                03 FON-05-QTY1                  PIC 9(04).
*>              UD剩餘數量分母 (55:04)
                03 FON-05-QTY2                  PIC 9(04).
*>              ST (59:01)
                03 FON-05-ST                    PIC X(01).
*>              是否要做UD傳送控制 (60:01)
                03 FON-05-UD-CHK-YN             PIC X(01).
*>              藥品磨粉欄位 (61:01)
                03 FON-05-POWDER-YN             PIC X(01).
*>              藥品會診結果（只有）"Y"或"N") (62:01)
                03 FON-05-SENDING-YN    PIC X(01).
*>              緩衝到期日或續用到期日及時間 (63:09)
                03 FON-05-BUFFER-DATA.
*>                      日期
                        04 FON-05-BUFFER-DT PIC 9(07).
*>                      小時
                        04 FON-05-BUFFER-TI PIC 9(02).
*>      92/04/22 新增感管抗生素申請單號(感管系統用)             (72:11)
                03 FON-05-CAN1-NO.
                        04 FON-05-CAN1-DT               PIC 9(07).
                        04 FON-05-CAN1-SEQ              PIC 9(04).
*>      95/07/13 新增感管抗生素停用日限制(住醫系統用)(北市需求95042001) (83:09)
                03 FON-05-HC-LAST-DT            PIC 9(07).
                03 FON-05-HC-LAST-TI            PIC 9(02).
*>      2006/9/30 新竹投藥記錄維護作業 MATCH UDL-MST用          (92:16)
                03 FON-05-SYS-DTTI.
                        04 FON-05-SYS-DATE              PIC 9(8).
                        04 FON-05-SYS-TIME              PIC 9(8).
*>              0970428,yung,新增台大化療備註欄位80長                   (108:80)
                03 FON-05-HICMI-NOTE            PIC X(80).
*>              0980225 新增首日量處方序號                              (188:11)
                03 FON-05-ICA-ODR-NO.
                        04 FON-05-ICA-INS-DATE PIC 9(7).
                        04 FON-05-ICA-ODR-SEQ PIC 9(4).

*>              2009/7/16 05.新增替代處置(J0901262)             (199:9)
                03 FON-05-REPLACE-FEE-KEY               PIC X(9).
*>              2010/7/6 醫令原始結束日期、原始結束時間(時)     (208:9)
                03 FON-05-ORI-END-DT            PIC 9(07).
                03 FON-05-ORI-END-TI            PIC 9(02).
*>              2009/7/16       X(52) -> X(43)
*>              2010/7/6        X(43) -> X(34)
*>              2010/11/9 自備藥識別"K" (217:1)
                03 FON-05-SELF-DRUG                     PIC X(01).
*>      2010/12/30      UDL項次流水號不可重覆 (218:5)
                03 FON-05-UDL-SEQ                       PIC 9(05).
*>      2011/01/26 抗生素刪除註記 D表示刪除 (223:1)
                03 FON-05-ANT-DEL                       PIC X(01).
*>      2011/02/09 連帶子項PPF折扣比率 (224:5)
                03 FON-05-PPF-DIS-RATE          PIC 9(3)V9(2).
*>              2011/02/18 連帶項是否列入PPF計算 (229:1)
                03 FON-05-PPF-YN                        PIC X(1).
*>              預留 (230:21)
                03 FON-05-DATA-REC                      PIC X(21).
*>      2015/11/27      因有關CHEMO藥欄位已無使用，所以用REDEFINES
                03 FON-05-CHEMO-REC REDEFINES FON-05-DATA-REC.
*>      2011/04/20 chemo傳送時，chemo新次劑量
                        04 FON-05-HYGUDL-RX-UQTY.
                                05 FON-05-HYGUDL-RX-UQTY1               PIC 9(06).
                                05 FON-05-HYGUDL-RX-UQTY2               PIC 9(06).
*>      2011/6/14 M:表示CHEMO UD & 護理站用藥識別
                                05 FON-05-HYGUDL-CHEMO-MARK             PIC X(01).
*>      2011/6/14 CHEMO 流水號
                                05 FON-05-HYGUDL-SN-NO                  PIC 9(04).
*>      2011/6/14 CHEMO 識別(C:送CHEMO, U:送UD, S:送護理站)
                                05 FON-05-HYGUDL-CHEMO-ID               PIC X(01).
*>      2011/6/14 CHEMO 序號
                                05 FON-05-HYGUDL-SEQ-NO                 PIC 9(02).
                                05 FON-05-CHEMO-FILLER                  PIC X(01).
                03 FON-05-MED-REC REDEFINES FON-05-DATA-REC.
*>      2015/12/25 新次劑量
                        04 FON-05-RX-N-UQTY.
                                05 FON-05-RX-N-UQTY1            PIC 9(05).
                                05 FON-05-RX-N-UQTY2            PIC 9(05).
*>              2018/06/13 增加抗生素審核完成是否加開首日量
                        04 FON-05-ANT-B                         PIC X(01).
*>              2019/05/20 yan 增加註記紀錄水劑UD給藥
                        04 FON-05-UD-GIVE                       PIC X(01).
                        04 FON-05-MED-FILLER                    PIC X(09).

*>      【０６．門診轉住院】
        02 FON-06-DATA REDEFINES FON-DATA.
*>              對應之住院處方序號(第一張)
                03 FON-06-ODR-NO PIC X(11).
*>              門轉住日期、時間、操作者(住院申請 HI_WRI.PRC)
                03 FON-06-CRE-DATE PIC 9(07).
                03 FON-06-CRE-TIME PIC 9(06).
                03 FON-06-CRE-USER PIC X(05).
*>              門轉住產生住院處方箋之日期、時間、操作者(門診轉住院 HITRNBF.CBL)
                03 FON-06-ODR-DATE PIC 9(07).
                03 FON-06-ODR-TIME PIC 9(06).
                03 FON-06-ODR-USER PIC X(05).

*>              對應之住院處方序號(第二張)
                03 FON-06-ODR-NO2 PIC X(11).
*>              門診修改身份註記(Y); 修改門轉住之註記須重轉
                03 FON-06-CHG-CLA PIC X(01).
*>              門診序號記錄產生識別([B] HITRNPF 批次產生)
                03 FON-06-CRE-ID PIC X(01).
*>              2004/12/25 院區別
                03 FON-06-FROM-THID PIC X(02).
*>              2004/12/25 X(190)→X(188)
                03 FON-06-DATA-REC PIC X(188).

*>      【０８．UD傳送過濾臨時註記記錄】
        02 FON-08-DATA REDEFINES FON-DATA.
*>              藥局別
                03 FON-08-ID PIC X(02).
                03 FON-08-DATA-REC PIC X(248).

*>      【０９．外宿登錄】
        02 FON-09-DATA REDEFINES FON-DATA.
*>              (1.外宿、2.外出 3.擅自離院)
                03 FON-09-ID PIC X(01).
*>              外宿日期、時間
                03 FON-09-OFF-DTTI.
                        04 FON-09-OFF-DT PIC 9(07).
                        04 FON-09-OFF-TIME PIC 9(06).
*>              預定轉回日期、時間
                03 FON-09-PRE-DTTI.
                        04 FON-09-PRE-DT PIC 9(07).
                        04 FON-09-PRE-TIME PIC 9(06).
                03 FON-09-DATA-REC PIC X(223).

*>      【１０．處方筆數月報資料】
        02 FON-10-DATA REDEFINES FON-DATA.
                03 FON-10-CNT-TBL.
*>                      １～３１天
                        04 FON-10-CNT-TBL1 OCCURS 31 TIMES.
                                05 FON-10-CNT PIC 9(05).
*>                      合計
                        04 FON-10-MON-CNT PIC 9(06).

                03 FON-10-DATA-REC PIC X(89).

*>      【１１．預約住院延伸資料】
        02 FON-11-DATA REDEFINES FON-DATA.
*>              備註
                03      FON-11-REMARK                   PIC X(40).
*>              診斷
                03      FON-11-IDZS-TBL.
                        04      FON-11-IDZS OCCURS 5 TIMES PIC X(07).
*>              預報到日期,時間
                03      FON-11-ARRIVE-DT                PIC 9(07).
                03      FON-11-ARRIVE-TIME              PIC 9(04).
*>              預排開刀日期,說明
                03      FON-11-OPE-DT                   PIC 9(07).
                03      FON-11-OPE-DOC                  PIC X(10).
*>              廿四小時內曾發燒38度Ｃ以上(Y/N)
                03      FON-11-OVER-38                  PIC X(01).

*>              住院前三天曾有發燒病史
                03      FON-11-FEVER                    PIC X(01).
*>              最近兩週內有疫區之旅遊史
                03      FON-11-2-WEEK                   PIC X(01).
*>              是否為肺炎
                03      FON-11-PNEUMONIA                PIC X(01).
*>              是否有呼吸窘迫
                03      FON-11-SOFFOCATE                PIC X(01).
*>              是否有急性神經神經症狀
                03      FON-11-NERVE                    PIC X(01).
*>              是否有急性腹瀉
                03      FON-11-RUN                              PIC X(01).
*>              是否有急性黃疸
                03      FON-11-ICTERUS                  PIC X(01).
*>              預約登錄者
                03      FON-11-USER-ID                  PIC X(05).
*>              異動日
                03      FON-11-DATE                     PIC 9(07).
*>              異動時間
                03      FON-11-TIME                     PIC 9(06).
*>              身份
                03      FON-11-CLA                      PIC X(04).
*>              病房床號
                03      FON-11-BED-BED          PIC X(06).
*>              2009/1/12 預約醫師代碼(中醫)
                03      FON-11-MJ-DR-CHINMED    PIC X(04).
*>              2009/1/12 預約科別代碼(中醫)
                03      FON-11-DPT                      PIC X(04).
*>              2016/1/1  ICD-10診斷 (配合HI_PREKF.LNK 每欄位只開X(8))
                03      FON-11-ICD10-TBL.
                        04      FON-11-ICD10 OCCURS 5  TIMES    PIC X(08).
*>              2016/03/31  (J1600157)新增病床種類 1.一般病房 2.加護病房
                03      FON-11-BED-KIND                 PIC 9(01).
*>              2016/03/31  (J1600157)新增識別 1.住醫 2.門醫3.急診
                03      FON-11-ID                       PIC X(01).
*>              2019/10/23 新增病患來源 1.無 2.門診 3.急診
                03      FON-11-FROM-SEL              PIC 9(01).
*>              2019/10/23 新增急診掛號日期時間
                03      FON-11-EREG-DT               PIC 9(07).
                03      FON-11-EREG-TIME.
                        04      FON-11-EREG-HH       PIC 9(02).
                        04      FON-11-EREG-MM       PIC 9(02).
*>              2022/07/27 彥廷 增加床位順序
                03      FON-11-BED-ORDER.
                        04      FON-11-BED-ORDER1       PIC X(01).
                        04      FON-11-BED-ORDER2       PIC X(01).
                        04      FON-11-BED-ORDER3       PIC X(01).
                        04      FON-11-BED-ORDER4       PIC X(01).
                        04      FON-11-BED-ORDER5       PIC X(01).
*>              2022/07/27 彥廷 預訂檢查日期
                03      FON-11-CHK-DT                   PIC 9(07).
*>              2022/07/27 彥廷 化學治療日期
                03      FON-11-CHEM-DT                  PIC 9(07).
*>              2004/1/27 X(147) -> X(121)
*>              2009/1/12 X(111) -> X(103)
*>              2016/1/1  X(103) -> X(63) ICD-10診斷
*>              2016/03/31  X(63) -> X(61) 病床種類

*>              2019/10/23  X(61) -> X(60) 病患來源
*>              2019/10/23  X(60) -> X(49) 急診掛號日期時間
*>              2022/07/27      X(49) -> X(30) 屏東排床增加欄位
                03 FON-11-DATA-REC PIC X(30).

*>      【１２．手術鎖檔病人】
        02      FON-12-DATA     REDEFINES               FON-DATA.
*>              鎖檔之使用者代號
                03      FON-12-USR-ID                   PIC X(05).
*>              上鎖之日期
                03      FON-12-BLD-DT                   PIC 9(07).
                03      FON-12-DATA-REC                 PIC X(238).

*>      【１３．設定申報註記】
        02      FON-13-DATA     REDEFINES               FON-DATA.
*>              異動之使用者代號
                03      FON-13-USER-ID                  PIC X(05).
*>              異動後之申報註記
                03      FON-13-NEW-APY-LOCK             PIC X(01).
*>              異動前之申報註記
                03      FON-13-OLD-APY-LOCK             PIC X(01).

                03      FON-13-DATA-REC                 PIC X(243).

*>      【１４．修改最近住院序號之異動記錄】
        02      FON-14-DATA     REDEFINES               FON-DATA.
*>              異動之使用者代號
                03      FON-14-USER-ID                  PIC X(05).
*>              異動前之最近住院序號
                03      FON-14-OLD-IKEY-LST             PIC X(11).
*>              異動後之最近住院序號
                03      FON-14-NEW-IKEY-LST             PIC X(11).
*>              異動最近住院序號之功能( 1.單筆維護 2.整批異動 3.日結異動)
                03      FON-14-UPD-FUN                  PIC X(01).

                03      FON-14-DATA-REC                 PIC X(222).

*>      【１５．住院日結記錄】
        02      FON-15-DATA     REDEFINES               FON-DATA.
*>              IPD-MST STATUS
                03      FON-15-STATUS                   PIC X(02).

                03      FON-15-DATA-REC                 PIC X(248).

*>      【１６．修改門急診轉住院之註記】
        02      FON-16-DATA     REDEFINES               FON-DATA.
*>              檔案識別(1.HO_MREG  2.HO_MDG1)
                03      FON-16-FILE-ID                  PIC X(01).
*>              異動之使用者代號
                03      FON-16-USER-ID                  PIC X(05).
*>              原門轉住註記
                03      FON-16-OLD-MARK                 PIC X(01).
*>              新門轉住註記
                03      FON-16-NEW-MARK                 PIC X(01).

                03      FON-16-DATA-REC                 PIC X(242).


*>      【１８．修改出院診斷和手術碼之異動記錄】
        02      FON-18-DATA     REDEFINES               FON-DATA.
*>              更新功能識別(1.出院補登作業 2.特定案件作業 3.手術 4.疾病分析)
                03      FON-18-FUN-ID                   PIC X(01).
*>              異動之使用者代號(名稱)
                03      FON-18-USER-ID                  PIC X(10).
*>              更新前之出院診斷(1～5)
                03      FON-18-BEFORE-ODZS-TBL.
                        04     FON-18-BEFORE-ODZS OCCURS 5  TIMES       PIC X(07).
*>              更新後之出院診斷(1～5)
                03      FON-18-AFTER-ODZS-TBL.
                        04     FON-18-AFTER-ODZS  OCCURS 5  TIMES       PIC X(07).
*>              更新前之手術碼
                03      FON-18-BEFORE-OPP-TBL.
                        04     FON-18-BEFORE-OPP OCCURS 5  TIMES        PIC X(07).
*>              更新後之手術碼
                03      FON-18-AFTER-OPP-TBL.
                        04     FON-18-AFTER-OPP  OCCURS 5  TIMES        PIC X(07).
*>              更新前之出院診斷(6 ～10)
                03      FON-18-BEFORE-ODZS6-TBL.
                        04     FON-18-BEFORE-ODZS6 OCCURS 5  TIMES      PIC X(07).
*>              更新後之出院診斷(6 ～10)
                03      FON-18-AFTER-ODZS6-TBL.
                        04     FON-18-AFTER-ODZS6  OCCURS 5  TIMES      PIC X(07).

                03      FON-18-DATA-REC                 PIC X(29).

*>      【１９．住院日控制記錄】
        02      FON-19-DATA     REDEFINES               FON-DATA.
*>              預計延長住院天數
                03      FON-19-EXTEND-DAYS              PIC 9(04).
*>              預計延長住院日期
                03      FON-19-EXTEND-DATE              PIC 9(07).
*>              登錄者
                03      FON-19-USER-ID                  PIC X(05).
*>              登錄日期
                03      FON-19-UPD-DATE                 PIC 9(07).
*>              登錄時間
                03      FON-19-UPD-TIME                 PIC 9(06).
*>              延長住院原因
                03      FON-19-REASON-TBL.
                        04     FON-19-REASON-TBL1  OCCURS 5  TIMES.
                                05      FON-19-REASON-ID        PIC X(03).
                                05      FON-19-REASON-DOC       PIC X(30).

                03      FON-19-DATA-REC                 PIC X(56).

*>      【２０．轉介資料回寫錯誤之記錄】
        02      FON-20-DATA     REDEFINES               FON-DATA.
*>              回寫CNT-MST-R 之STATUS
                03      FON-20-CNT-STATUS               PIC X(02).
*>              整筆CNT-MST-R 之記錄
                03      FON-20-CNT-DATA                 PIC X(248).

*>      【２１.出院結帳清床失敗之記錄(BED-MST REWRITE ERROR之記錄)      】
        02      FON-21-DATA     REDEFINES               FON-DATA.
*>              欲清床之床號

                03      FON-21-BED.
                        05      FON-21-BED-BED          PIC X(04).
                        05      FON-21-BED-NO           PIC X(02).
*>              1->READ ERROR, 2->READ OK 但IPD-NO 不同, 3-> READ OK, 且IPD-NO相同
                03      FON-21-ERR-ID                   PIC X(01).
*>              READ BED-MST 狀態碼
                03      FON-21-READ-STATUS              PIC X(02).
*>              REWRITE BED-MST 狀態碼(FON-21-ERR-ID = "3" 才會有)
                03      FON-21-UPDATE-STATUS            PIC X(02).
*>              目前佔床之住院序號
                03      FON-21-BED-IPD-NO               PIC X(11).
*>              預留
                03      FON-21-DATA-REC                 PIC X(228).

*>      【２２．切帳還原記錄】
        02      FON-22-DATA     REDEFINES               FON-DATA.
*>              病歷號
                03      FON-22-PAT-NO                   PIC 9(08).
*>              醫師
                03      FON-22-DR-NO                    PIC X(04).
*>              科別
                03      FON-22-DEPT-NO                  PIC X(04).
*>              身分
                03      FON-22-A-CLA                    PIC X(04).
*>              預留
                03      FON-22-DATA-REC                 PIC X(230).

*>      2002/12/21 04:16下午
*>      【２３．死亡證明書】
        02      FON-23-DATA     REDEFINES               FON-DATA.
*>              死亡地點 [1]醫院[2]診所[3]助產所[4]自宅[5]其它
                03      FON-23-DIE-POS                  PIC X(01).
*>              死亡住址
                03      FON-23-DIE-ADDR                 PIC X(50).
*>              死亡種類 [1]病死或自然死[2]意外死[3]自殺[4]他殺[5]不詳
                03      FON-23-DIE-GP                   PIC X(01).
*>              發病至死亡概略時間
                03      FON-23-DIE-TIME1                PIC X(08).
                03      FON-23-DIE-TIME2                PIC X(08).
                03      FON-23-DIE-TIME3                PIC X(08).
                03      FON-23-DIE-TIME4                PIC X(08).
*>              出生時間
                03      FON-23-BIR-TIME.
                        04      FON-23-BIR-HH           PIC 9(02).
                        04      FON-23-BIR-MT           PIC 9(02).
*>              職業
                03      FON-23-JOB1                     PIC X(20).
*>              職務
                03      FON-23-JOB2                     PIC X(20).
*>              婚姻
                03      FON-23-MAR                      PIC X(01).
*>              醫師
                03      FON-23-DIE-DR                   PIC X(04).
*>              建檔日
                03      FON-23-DIE-CRE-DT               PIC 9(07).
*>              建檔員
                03      FON-23-DIE-DUTY-ID              PIC X(05).

*>              新增懷孕情形 [1]於過去一年未懷孕  [2]懷孕中死亡  [3]懷孕終止或結束之42天內死亡
*>                           [4]懷孕終止或結束後43天至一年內死亡 [5]不清楚過去一年是否懷孕
                03      FON-23-PREG                     PIC X(01).
*>              2019/11/21 YAN 紀錄RCD程式名
                03      FON-23-RCD-PROG                 PIC X(10).
*>              2019/11/21 YAN 紀錄RCD KEY
                03      FON-23-RCD-KEY.
                        04      FON-23-RCD-ID           PIC X(01).
                        04      FON-23-RCD-DATE         PIC 9(08).
                        04      FON-23-RCD-TIME         PIC 9(08).
                        04      FON-23-RCD-NETNO        PIC X(20).
*>              預留
                03      FON-23-DATA-REC                 PIC X(57).

*>      2002/12/22
*>      【２４．死亡證明書之死亡原因】
        02      FON-24-DATA     REDEFINES               FON-DATA.
*>              直接死亡原因,間接死亡原因
                03      FON-24-DIE-MRES.
                        04      FON-24-DIE-MRES1        PIC X(50).
                        04      FON-24-DIE-MRES2        PIC X(50).
                        04      FON-24-DIE-DRES1        PIC X(50).
                        04      FON-24-DIE-DRES2        PIC X(50).
*>              2004/8/17 其他對於死亡有影響之疾病或身體狀況
                        04      FON-24-DIE-DRES3        PIC X(50).

*>      2003/1/10
*>      【２５．證件未齊】
        02      FON-25-DATA     REDEFINES               FON-DATA.
*>              預留
                03      FON-25-DATA-REC                 PIC X(250).

*>      2007/11/19
*>      【２６．動物醫院批價處方之[調劑方式]】
        02      FON-26-DATA     REDEFINES               FON-DATA.
*>              調劑方式
                03      FON-26-PREPARE                  PIC X(01).
*>              給藥局說明
                03      FON-26-MED-DES                  PIC X(60).
*>              給畜主說明一
                03      FON-26-WONER-DES1               PIC X(30).
*>              給畜主說明二
                03      FON-26-WONER-DES2               PIC X(30).
*>              給畜主說明三
                03      FON-26-WONER-DES3               PIC X(30).
*>              2008/3/5
*>              組別次劑量(每次服用 包/顆)
                03    FON-26-SRV-QTY                    PIC 9(3).
*>              預留
                03      FON-26-DATA-REC                 PIC X(96).

*>      2008/6/10
*>      【２７．跨院區轉床,前一院區基本資料】
        02      FON-27-DATA     REDEFINES               FON-DATA.
*>              前一院區碼
                03      FON-27-HOSP             PIC X(01).
*>              前一院區床號

                03      FON-27-BED.
                        04      FON-27-BED-ROOM PIC X(04).
                        04      FON-27-BED-NO   PIC X(02).
*>              科別
                03      FON-27-DPT                      PIC X(04).
*>              身份別
                03      FON-27-CLA                      PIC X(04).
*>              醫生(代碼)
                03      FON-27-MJ-DR                    PIC X(04).
                03      FON-27-DATA-REC                 PIC X(231).

*>      2008/10/31
*>      【２８．住院備註】
        02      FON-28-DATA     REDEFINES               FON-DATA.
*>              備註內容
                03      FON-28-IPD-NOTE                 PIC X(100).
*>              預留
                03      FON-28-DATA-REC                 PIC X(150).

*>      2010/2/23 新增器官捐贈相關資料輸入
*>      【２９．器官捐贈相關資料輸入】
        02      FON-29-DATA     REDEFINES               FON-DATA.
*>              境內捐贈或境外捐贈 (0:境內捐贈;1:境外捐贈)      (1:1)
                03      FON-29-APPARATUS-TYPE           PIC X(01).
*>              境內捐贈的捐贈院所代碼 [0507]                   (2:10)
                03      FON-29-APPARATUS-HOSP           PIC X(10).
*>              境內捐贈日期                                    (12:7)
                03      FON-29-APPARATUS-DATE           PIC 9(07).
*>              境內捐贈者ID                                    (19:10)
                03      FON-29-APPARATUS-IDNO           PIC X(10).
*>              預留                                            (29:222)
                03      FON-29-DATA-REC                 PIC X(222).

*>      2010/3/15 新增寫 rfid 資料 log
*>      【３０．寫 rfid 資料 log紀錄】
        02      FON-30-DATA     REDEFINES               FON-DATA.
*>              住院申請時寫檔前 W-SAVE-PROCEDURE-OK 的狀態(Y/ )        (01:01)
                03      FON-30-300KF-SAVE-P-OK          PIC X(01).
*>              LOG1 紀錄時間                                   (02:13)
                03      FON-30-LOG1-DTTI.
                        04      FON-30-LOG1-DATE        PIC 9(07).
                        04      FON-30-LOG1-TIME        PIC 9(06).
*>              "HIRFD1CF"內寫-05-檔之前的LOG紀錄識別 A:有到寫RFD檔之前 (15:01)
                03      FON-30-RFD1CF-BEFORE-SAVE-05    PIC X(01).
*>              LOG2 紀錄時間                                   (16:13)
                03      FON-30-LOG2-DTTI.
                        04      FON-30-LOG2-DATE        PIC 9(07).
                        04      FON-30-LOG2-TIME        PIC 9(06).
*>              "HIRFD1CF"內寫-05-檔後的 STATUS 紀錄            (29:02)
                03      FON-30-RFD1CF-SAVE-STATUS       PIC X(02).
*>              LOG3 紀錄時間                                   (31:13)
                03      FON-30-LOG3-DTTI.
                        04      FON-30-LOG3-DATE        PIC 9(07).
                        04      FON-30-LOG3-TIME        PIC 9(06).
*>              紀錄一進FRD1CF開HIRFD檔狀態                     (44:02)
                03      FON-30-LOG-HIRFD-OPEN-STATUS    PIC X(02).
*>              紀錄一進FRD1CF開SEN檔狀態                       (46:02)

                03      FON-30-LOG-SEN-OPEN-STATUS      PIC X(02).
*>      2010/4/7 紀錄 HIRFD 內容 **************************************************************
*>              姓名                                            (48:12)
                03      FON-30-PAT-NAME                 PIC X(12).
*>              出生日期                                        (60:7)
                03      FON-30-BIRTH-DT                 PIC S9(07).
*>              床號                                            (67:6)
                03      FON-30-BED.
                        04      FON-30-BED-ROOM         PIC X(04).
                        04      FON-30-BED-NO           PIC X(02).
*>              護理站                                          (73:5)
                03      FON-30-UNIT                     PIC X(05).
*>              住院日期                                        (78:7)
                03      FON-30-DT                       PIC X(07).
*>              出院日期                                        (85:7)
                03      FON-30-OUT-DT                   PIC X(07).
*>              最後一次修改原因(1.住院申請 2.轉床 3.出院 5.退床 D.刪除) (92:1)
                03      FON-30-ORI                      PIC X(01).
*>              身分證號                                        (93:10)
                03      FON-30-IDNO                     PIC X(10).
*>              過敏註記                                        (103:1)(Y/ )
                03      FON-30-SEN-YN                   PIC X(01).
*>              血型                                            (104:2)
                03      FON-30-BLOOD                    PIC X(02).
*>              前次住院序號                                    (106:11)
                03      FON-30-IPD-NO-L.
                        04      FON-30-IPD-DT-L         PIC 9(07).
                        04      FON-30-IPD-SEQ-L        PIC 9(04).
*>              原始住院日                                      (117:7)
                03      FON-30-ORG-DT                   PIC 9(07).
*>      2010/4/7 紀錄 HIRFD 內容 **********************************************************
*>      2010/4/12       補上在一進程式之後就馬上寫一個log紀錄
*>              是否有進入HIRFD1CF      Y:有進入HIRFD1CF        (124:01)
                03      FON-30-INTO-HIRFD1CF-YN         PIC X(01).
*>      2010/4/29       增加在300KF寫FON時可能會有STATUS錯誤，
*>                      這邊只紀錄"47"."48"."49"，"22"."00"都紀錄"OK"，
*>                      而如果是這些之外就可能無法記錄到了      (125:02)
                03      FON-30-300KF-WRITE-FON-STATUS   PIC X(02).
*>      2010/4/29       紀錄一進FRD1CF開HIDNR檔狀態             (127:02)
                03      FON-30-LOG-HIDNR-OPEN-STATUS    PIC X(02).

*>              預留                                            (129:122)
*>                      2010/4/7        (203) → (127)
*>                      2010/4/12       (127) → (126)
*>                      2010/4/29       (126) → (124) → (122)
                03      FON-30-DATA-REC                 PIC X(122).

*>               2010/4/8 新增 轉床作業 清床的LOG紀錄
*>      【３１．轉床作業 清床的LOG紀錄】 (250長)
        02      FON-31-DATA     REDEFINES               FON-DATA.
*>              F-WRI-NEW 更新新床病歷號等資料的狀態            (01:02)
                03      FON-31-AFTER-WRINEW-STATUS      PIC X(02).
*>              F-WRI-OLD 讀取舊床資料的狀態                    (03:02)
                03      FON-31-READ-OLDBED-STATUS       PIC X(02).
*>              舊床資料清空前的狀況 (" "空床, "1"待床 , "2"佔床) (05:01)
                03      FON-31-OLDBEDB-BED-STATUS       PIC X(01).
*>              舊床資料清空前的患者病歷號碼                    (06:08)

                03      FON-31-OLDBEDB-BED-PAT-NO       PIC 9(08).
*>              舊床資料清空前的住院患者住院序號                (14:11)
                03      FON-31-OLDBEDB-BED-IPD-NO       PIC X(11).
*>              舊床資料清空後(寫檔後)的狀況 (" "空床, "1"待床 , "2"佔床) (25:01)
                03      FON-31-OLDBEDA-BED-STATUS       PIC X(01).
*>              舊床資料清空後(寫檔後)的患者病歷號碼            (26:08)
                03      FON-31-OLDBEDA-BED-PAT-NO       PIC 9(08).
*>              舊床資料清空後(寫檔後)的住院患者住院序號        (34:11)
                03      FON-31-OLDBEDA-BED-IPD-NO       PIC X(11).
*>              舊床資料清空後(寫檔後)的寫檔狀態                (45:02)
                03      FON-31-OLDBEDA-WRI-STATUS       PIC X(02).
*>2010/12/13    HHIPDCF成功否 ( W-LNK-YN NOT = "Y" W-LNK-NOTE 才有值)  (47:51)
                03      FON-31-HHIPD-LNK-YN             PIC     X(01).
                03      FON-31-HHIPD-LNK-NOTE           PIC     X(50).
*>              預留                                            (98:153)
                03      FON-31-DATA-REC                 PIC X(153).

*>              2010/5/7 新增 HIWICWCF 寫 WIC 資料 LOG 紀錄
*>      【３２．HIWICWCF 寫 WIC 資料 LOG 紀錄】 (250長)
        02      FON-32-DATA     REDEFINES               FON-DATA.
*>              建檔來源是否是由患者IC卡中轉出資料的 [Y/ ]      (01:01)
                03      FON-32-WIC-FROM-IC              PIC X(01).
*>              病歷號碼                                        (02:08)
                03      FON-32-WIC-PAT-NO               PIC 9(08).
*>              最後異動者                                      (10:05)
                03      FON-32-WIC-UPD-USID             PIC X(05).
*>              作業編碼系統別 + 作業編碼識別                   (15:23)
                03 FON-32-RUN-PSG.
                        04 FON-32-RUN-PSID              PIC X(03).
                        04 FON-32-RUN-PSNO              PIC X(20).
*>              預留                                            (38:213)
                03      FON-32-DATA-REC                 PIC X(213).

*>              2012/03/26 預約待床備註欄位開放可以輸入，儲存備註相關資料
*>      【３３．預約待床】 (250長)
        02      FON-33-DATA     REDEFINES               FON-DATA.
*>              預約待床備註資料                                (01:50)
                03      FON-33-MEMO-DATA                PIC X(50).
*>              預留                                            (51:250)
                03      FON-33-DATA-REC                 PIC X(200).

*>              2013/01/30 自費特材替代群組
*>      【３４．自費特材】 (250長)
        02      FON-34-DATA     REDEFINES               FON-DATA.
*>              自費特材替代群組                                (01:03)
                03      FON-34-REPLACE-GROUP            PIC X(03).
*>              預留                                            (04:247)
                03      FON-34-DATA-REC                 PIC X(247).

*>      2014/11/06 藥品圖文-事後補異常紀錄(台南)
*>      【３５．事後補異常紀錄】
        02      FON-35-DATA REDEFINES FON-DATA.
*>              病歷號 (01:08)
                03 FON-35-PAT-NO PIC 9(09).
*>              處方序號 (09:11)
                03 FON-35-ODR-NO PIC X(11).
*>              序號 (20:03)

                03 FON-35-SEQ PIC 9(03).
*>              藥袋序號 (23:20)
                03 FON-35-BAG-NO PIC X(20).
*>              預留 (43:207)
                03 FON-35-DATA-REC PIC X(207).

*>      【３６．住院簡訊通知】
        02 FON-36-DATA REDEFINES FON-DATA.
*>              預留 (1:250)
                03 FON-36-DATA-REC PIC X(250).

*>      【３７．聖母-困難插管存檔欄位】
        02 FON-37-DATA REDEFINES FON-DATA.
*>              困難插管建檔日期 (1:7)
                03 FON-37-DATE PIC 9(7).
*>              困難插管建檔時間 (8:6)
                03 FON-37-TIME PIC 9(6).
*>              困難插管時之護理站 (14:5)
                03 FON-37-UNIT PIC X(5).
*>              困難插管時之床位 (19:6)
                03 FON-37-BED PIC X(6).
*>              預留 (25:226)
                03 FON-37-DATA-REC PIC X(226).

*>       65. 幫退藥相關作業加資料欄位存 HR_SBA,HI_RTB KEY (2009/11/3) - 智勛
*>      【６５．退藥相關作業加資料】(250長)
        02      FON-65-DATA     REDEFINES               FON-DATA.
*>              備註內容 (150長)
                03      FON-65-LOG-NOTE.
*>                      刪除註記 D.表刪除                       (1:1)
                        04      FON-65-DEL-MARK                 PIC X.
*>                      FILLER                                  (2:149)
                        04      FON-65-LOG-NOTE-FILLER          PIC X(149).
*>              預留 (100長)
                03      FON-65-DATA-REC.
                        04      FON-65-DATA-REC-FILLER          PIC X(100).

*>      2009/5/27
*>      【６６．門診轉住院-檢驗檢查更新失敗紀錄】 (250長)
        02      FON-66-DATA     REDEFINES               FON-DATA.
*>              備註內容 (100長)
                03      FON-66-LOG-NOTE.
*>                      病歷號                  (01:08)
                        04      FON-66-PAT-NO           PIC 9(08).
*>                      寫紀錄者 (員工編號)     (09:05)
                        04      FON-66-WRI-USER         PIC X(05).
*>                      線路編號                (14:05)
                        04      FON-66-WRI-LINE-NO      PIC X(05).
*>                      處方序號                (19:11)
                        04      FON-66-ODR-NO           PIC 9(11).
*>                      存取狀態紀錄            (30:02)
                        04      FON-66-HTCHK-STATUS     PIC X(02).
*>                      醫令日期                (32:08)
                        04      FON-66-HTCHK-IP-DATE    PIC 9(08).
*>                      FILLER                  (40:61)
                        04      FON-66-LOG-NOTE-FILLER  PIC X(61).
*>              預留 (150長)

                03      FON-66-DATA-REC                 PIC X(150).

*>       67.(台中)化療針劑加識別與欄位(2009/10/22) - 智勛
*>              【６７．化療針劑加識別與欄位】(250長)
        02      FON-67-DATA     REDEFINES               FON-DATA.
*>              備註內容 (150長)
                03      FON-67-LOG-NOTE.
*>                      開始日期                                (1:7)
                        04      FON-67-DATE-START               PIC 9(7).
*>                      結束日期                                (8:7)
                        04      FON-67-DATE-END                 PIC 9(7).
*>                      劑量                                    (15:6)
                        04      FON-67-QTY1                     PIC 9(4)V9(2).
*>                      溶劑處置代碼                            (21:9)
                        04      FON-67-SOLVENT-PRS              PIC X(09).
*>                      溶劑體積                                (30:6)
                        04      FON-67-VOLUME                   PIC 9(04)V9(2).
*>                      注射方式(代碼)                          (36:2)
                        04      FON-67-INJECT-WAY               PIC X(02).
*>                      施打時間                                (38:3)
                        04      FON-67-INJECT-HOURS             PIC 9(02)V9.
*>                      身高                                    (41:4)
                        04      FON-67-HEIGHT                   PIC 9(03)V9.
*>                      體重                                    (45:4)
                        04      FON-67-WEIGHT                   PIC 9(03)V9.
*>                      刪除註記 D.表刪除                       (49:1)
                        04      FON-67-DEL-MARK                 PIC X.
*>                      2010/4/27 配合署北版化療輸注液加印體表面積 (50:3)
                        04      FON-67-BSA                      PIC 9V9(2).
*>                      2010/4/28 加腎功能數據                  (53:10)
                        04      FON-67-RENAL-DATA               PIC X(10).
*>                      2010/6/11 幫加醫囑劑量                  (63:7)
                        04      FON-67-ODR-QTY1                 PIC 9(5)V9(2).
*>                      2010/6/11 幫加肝功能數據                (70:40)
                        04      FON-67-LIVER-FUNCTION-DATA      PIC X(40).
*>                      FILLER                                  (110:41)
*>                      2010/4/27 (101) → (98)
*>                      2010/4/28  (98) → (88)
*>                      2010/6/11  (88) → (41)
                        04      FON-67-LOG-NOTE-FILLER          PIC X(41).
*>              預留 (100長)
                03      FON-67-DATA-REC.
                        04      FON-67-DATA-REC-FILLER          PIC X(100).

*>      【ＡＡ．急診月報檔】
        02      FON-AA-DATA     REDEFINES               FON-DATA.
*>              急診人數(白班,小夜,大夜)
                03      FON-AA-EME1-TBL.
                        04      FON-AA-EME1-NUM OCCURS 3 TIMES  PIC 9(04).

*>              [急診人數 = 平常日 + 假日]
*>              平常日(白班,小夜,大夜)
                03      FON-AA-EME21-TBL.
                        04      FON-AA-EME21-NUM OCCURS 3 TIMES PIC 9(04).

*>              假日(白班,小夜,大夜)
                03      FON-AA-EME22-TBL.

                        04      FON-AA-EME22-NUM OCCURS 3 TIMES PIC 9(04).

*>              處理方式(１～３０, 只用到１～１０, ３０表其他 )
                03      FON-AA-EME3-TBL.
                        04      FON-AA-EME3-NUM OCCURS 30 TIMES PIC 9(04).


*>              三班之檢傷分類 ( 白班,小夜,大夜  ; １～４)
                03      FON-AA-EME4-TBL.
                        04      FON-AA-EME4-TBL1 OCCURS 3 TIMES.
                                05      FON-AA-EME4-NUM OCCURS 4 TIMES  PIC 9(04).

*>              119  EME-119 人數205(護理站)
                03      FON-AA-EME5-NUM                 PIC 9(4).

*>              2009/12/15      檢傷分類改為5級，加上第5級的欄位
*>              第5級的三班之檢傷分類 ( 白班,小夜,大夜  ; 5)
                03      FON-AA-EME4-5-TBL.
                        04      FON-AA-EME4-5-NUM OCCURS 3 TIMES        PIC 9(04).

*>              2004/5/10 03      FON-AA-DATA-REC                 PIC X(46).
*>              2004/5/10       X(46) -> X(42)
*>              2009/12/15      X(42) -> X(30)
                03      FON-AA-DATA-REC                 PIC X(30).

*>      【６８．死亡證明書】
        02      FON-68-DATA     REDEFINES               FON-DATA.
*>              死者姓名
                03      FON-68-DIE-NAME                 PIC X(12).
*>              死者身份證
                03      FON-68-DIE-IDNO                 PIC X(10).
*>              死者出生日期
                03      FON-68-DIE-BIRTH-DT             PIC S9(07).
*>              死者性別
                03      FON-68-DIE-SEX                  PIC X(01).
*>              死者戶籍地址
                03      FON-68-DIE-ADDR                 PIC X(40).
                03      FON-68-DIE-ADDR1                PIC X(40).
*>              死者國籍
                03      FON-68-DIE-ORIG                 PIC X(01).
*>              預留
                03      FON-68-DATA-REC                 PIC X(139).
*>      【６９．住院醫令預開出院名單】
        02      FON-69-DATA     REDEFINES               FON-DATA.
*>              姓名
                03      FON-69-PAT-NAME                 PIC X(12).
*>              預計出院日
                03      FON-69-EXPECT-OUT-DT            PIC 9(07).
*>              開立醫師
                03      FON-69-OPEN-DR                  PIC X(05).
*>              預留
                03      FON-69-DATA-REC                 PIC X(226).

*>      【７０．北市二代HIS住院序號對照檔】
        02      FON-70-DATA     REDEFINES               FON-DATA.
*>              大同住院序號(請將此欄位同步存到FON-TRN)
                03      FON-70-IPD-NO.

                        05      FON-70-IPD-DT           PIC 9(07).
                        05      FON-70-IPD-SEQ          PIC 9(04).
*>              更新日期
                03      FON-70-UPD-DT                   PIC 9(07).
                03      FON-70-UPD-TI.
                        04      FON-70-UPD-HH           PIC 9(02).
                        04      FON-70-UPD-MN           PIC 9(02).
*>              PAT寫檔失敗狀態
                03      FON-70-PAT-STATUS               PIC X(02).
*>              預留
                03      FON-70-DATA-REC                 PIC X(226).
*>      2015/01/27 TQIP住院資料轉檔作業的轉檔LOG
*>      【７１．TQIP住院資料轉檔紀錄】
        02      FON-71-DATA     REDEFINES               FON-DATA.
*>              線路
                03      FON-71-LINE-NUMBER              PIC 9(04).
*>              執行日期/時間(迄)
                03      FON-71-DTTI-END.
                        04      FON-71-UPD-DT-END       PIC 9(07).
                        04      FON-71-UPD-TIME-END     PIC 9(06).
*>              預留233長
                03      FON-71-DATA-REC                 PIC X(233).


*>       2015/02/09     聖母-出院補登診斷碼鎖檔參數設定
*>      【７２．聖母-出院補登診斷碼鎖檔設定】
        02      FON-72-DATA     REDEFINES               FON-DATA.
*>              疾分登錄-診斷/手術維護功能參數：限制(Y)，警告(W)，空白(不限制)
                03      FON-72-HDDISKF                  PIC X(01).
*>              特定案件-診斷/手術維護功能參數：限制(Y)，警告(W)，空白(不限制)
                03      FON-72-HICUTKF                  PIC X(01).
*>              住院醫令-診斷/手術維護功能參數：限制(Y)，警告(W)，空白(不限制)
                03      FON-72-HRODAKF                  PIC X(01).
*>              手術登錄-診斷/手術維護功能參數：限制(Y)，警告(W)，空白(不限制)
                03      FON-72-HKRECKF                  PIC X(01).
*>              TW-DRG編審-診斷/手術維護功能參數：限制(Y)，警告(W)，空白(不限制)
                03      FON-72-HDDRGNMF                 PIC X(01).
*>              處理異常作業-診斷/手術維護功能參數：限制(Y)，警告(W)，空白(不限制)
                03      FON-72-HI300DF                  PIC X(01).
*>              預留244長
                03      FON-72-TRN-REC                  PIC X(244).

*>      2015/03/02      聖母-出院補登作業是否存檔
*>      2015/03/10      出院補登人員存檔LOG
*>      【７３．聖母-出院補登作業是否存檔(出院補登紀錄)】
        02      FON-73-DATA     REDEFINES               FON-DATA.
*>              聖母出院補登存檔識別用，[Y]表存檔
                03  FON-73-HIIPOMF-SAVE         PIC X(01).
*>              出院補登：存檔人員
                03  FON-73-USER                 PIC X(05).
*>              出院補登存檔執行日期、時間
                03  FON-73-UPD-DT.
                        04 FON-73-UPD-DATE      PIC 9(07).
                        04 FON-73-UPD-TIME      PIC 9(06).
*>              預留231長
                03      FON-73-DATA-REC         PIC X(231).


*>      2015/03/10 出院補登鎖檔異動LOG
*>      【７４．出院補登鎖檔異動LOG】
        02      FON-74-DATA     REDEFINES               FON-DATA.
*>              疾分登錄-診斷/手術維護功能參數：限制(Y)，警告(W)，空白(不限制)
                03      FON-74-HDDISKF                  PIC X(01).
*>              特定案件-診斷/手術維護功能參數：限制(Y)，警告(W)，空白(不限制)
                03      FON-74-HICUTKF                  PIC X(01).
*>              住院醫令-診斷/手術維護功能參數：限制(Y)，警告(W)，空白(不限制)
                03      FON-74-HRODAKF                  PIC X(01).
*>              手術登錄-診斷/手術維護功能參數：限制(Y)，警告(W)，空白(不限制)
                03      FON-74-HKRECKF                  PIC X(01).
*>              TW-DRG編審-診斷/手術維護功能參數：限制(Y)，警告(W)，空白(不限制)
                03      FON-74-HDDRGNMF                 PIC X(01).
*>              處理異常作業-診斷/手術維護功能參數：限制(Y)，警告(W)，空白(不限制)
                03      FON-74-HI300DF                  PIC X(01).
*>              預留244長
                03      FON-74-DATA-REC                 PIC X(244).

*>      2016/12/19
*>      【９３．新生兒依附就醫申報資料紀錄】
        02      FON-93-DATA     REDEFINES               FON-DATA.
*>              申報日期(總表APY-DATE)
                03      FON-93-APY-DATE                 PIC 9(07).
*>              住院序號
                03      FON-93-IPD-NO.
                        04      FON-93-IPD-DT           PIC 9(07).
                        04      FON-93-IPD-SEQ          PIC 9(04).
*>              作業別(申報:HOAPY1BF)
                03      FON-93-PROGRAM                  PIC X(08).
*>              [902]申報資料(轉檔時寫入)
                03      FON-93-APY-902-DATA.
*>                      住院序號
                        04      FON-93-IPD-NO-902       PIC 9(11).
*>                      費用年月
                        04      FON-93-APY-YM-902       PIC 9(05).
*>                      申報類別   1:送核 2:補報
                        04      FON-93-APY-PART-902     PIC X(01).
*>                      案件
                        04      FON-93-CASE-ID-902      PIC X(02).
*>                      流水號
                        04      FON-93-SEQ-NO-902       PIC 9(06).
*>              預留
                03      FON-93-DATA-REC                 PIC X(199).

*>      【ＥＭ．急診品質提昇方案收案識別】
        02      FON-EM-DATA     REDEFINES               FON-DATA.
*>              更新日期、時間
                03      FON-EM-UPD-DT.
                        04      FON-EM-UPD-DATE         PIC 9(07).
                        04      FON-EM-UPD-TIME         PIC 9(06).
*>              是否已收案(Y：已收案  空白：未收案)
                03      FON-EM-MARK                     PIC X(01).
*>              預留
                03      FON-EM-DATA-REC                 PIC X(236).

*>      【ＬＫ．申報鎖檔/解鎖異動記錄】-2019/7/11
        02      FON-LK-DATA     REDEFINES               FON-DATA.

*>              異動之使用者代號
                03      FON-LK-USR-ID                   PIC X(05).
*>              鎖檔(Y)/解鎖(N)
                03      FON-LK-MODE                     PIC X(01).
*>              程式段
                03      FON-LK-PROG                     PIC X(20).
                03      FON-LK-DATA-REC                 PIC X(224).
*>      【９４．領藥號紀錄】
        02      FON-94-DATA     REDEFINES               FON-DATA.
*>              領藥號
                03      FON-94-PILL-NO                  PIC 9(04).

                03      FON-94-DATA-REC                 PIC X(246).
*>      【９５．病人床位所在紀錄】
        02      FON-95-DATA     REDEFINES               FON-DATA.
*>              轉入新病房床號
                03      FON-95-BED.
                        04      FON-95-BED-ROOM         PIC X(04).
                        04      FON-95-BED-NO           PIC X(02).
*>              交班分機
                03      FON-95-PHONE                    PIC X(05).
*>              醫師代碼
                03      FON-95-DR-NO                    PIC X(04).
*>              日期
                03      FON-95-DATE                     PIC 9(07).
*>              時間
                03      FON-95-TIME                     PIC 9(06).
*>              異動者
                03      FON-95-USID                     PIC X(05).
*>              目前所在床號(僅ICU紀錄)
                03      FON-95-NOW-BED                  PIC X(03).
                03      FON-95-DATA-REC                 PIC X(214).
*>      【９６．即將到期UD用藥清單】
        02      FON-96-DATA     REDEFINES               FON-DATA.
*>              列印日期
                03      FON-96-PRINT-DATE               PIC 9(07).
*>              列印時間
                03      FON-96-PRINT-TIME               PIC 9(04).
                03      FON-96-DATA-REC                 PIC X(239).
*>      【８０．牙科牙位】
        02      FON-80-DATA     REDEFINES               FON-DATA.
*>              牙位
                03 FON-80-TEETH-TBL1 OCCURS 9 TIMES.
                        05 FON-80-TEETH-CNT PIC X(02).
                03 FON-80-DATA-REC                      PIC X(232).

*---------------------------------------------------------------------*
*>      ＥＮＤ　ＯＦ　ＣＯＰＹ　ＦＩＬＥ　                            *
*---------------------------------------------------------------------*

*COPY    "HI_DTE.MST".
 FD      DTE-MST IS EXTERNAL.
 01      DTE-MST-REC.
        10  DTE-MST-KEY.
**              門診序號
                20 DTE-VRY-YM           PIC    9(5).
        10  DTE-CRE-DATE.

            12  DTE-VRY-DATE             PIC    9(07).
            12  DTE-VRY-TIME             PIC    9(06).
            12  DTE-VRY-VER              PIC    9(03).
*$XFD USE GROUP
            12  DTE-VRY-FILL.
*上鎖註記 Y:全月上鎖   DTE-CRE-DATE DTE-CRE-TIME   DTE-VRY-VER
*上鎖註記 M:上半月上鎖 DTE-CRE-DATE2 DTE-CRE-TIME2 DTE-VRY-VER2 ( 1日 - 15日)
*上鎖註記 N:解鎖
*           補報       DTE-CRE-DATE1 DTE-CRE-TIME1 DTE-VRY-VER1
                20 DTE-VRY-LOCK         PIC     X.
                20 DTE-VRY-DATE2        PIC     9(7).
                20 DTE-VRY-TIME2        PIC     9(6).
                20  DTE-CRE-DATE1.
                   30 DTE-VRY-DATE1     PIC    9(7).
                   30 DTE-VRY-TIME1     PIC    9(06).
                   30 DTE-VRY-VER1R     PIC    X(03).
                   30 DTE-VRY-VER1 REDEFINES DTE-VRY-VER1R  PIC   9(03).
                20 DTE-VRY-VER2R        PIC    X(03).
                20 DTE-VRY-VER2 REDEFINES DTE-VRY-VER2R  PIC   9(03).
                20 DTE-VRY-FILL1        PIC    X(4).

*COPY    "HI_GCA.MST".
*---------------------------------------------------------------------*
*>      住院處方異動記錄檔　HI_GCA.MST
*---------------------------------------------------------------------*
*> 主  ：HIGCA-IPD-NO HIGCA-ODR-NO HIGCA-DTI  (單張處方異動狀況)
*> 副1 ：HIGCA-DTI HIGCA-IPD-NO HIGCA-ODR-NO  (藥品系統使用)
*> 副2 ：HIGCA-IPD-NO HIGCA-DTI HIGCA-ODR-NO  (住院處方異動狀況)
*> SIZE : 605 BYTES
* 910306  增加HIGCA-APY-ID判斷由申報系統進入異動識別(JAY)
*>97/10/11 Frank-優免定義
*>2014/4/10 增加異動作業點 - 昱志
*---------------------------------------------------------------------*
 FD      HIGCA-MST         IS      EXTERNAL.
 01      HIGCA-MST-REC.
        02      HIGCA-KEY.
*$XFD USE GROUP
*>      住院序號
                03      HIGCA-IPD-NO.
                        05      HIGCA-IPD-DT            PIC 9(07).
                        05      HIGCA-IPD-SEQ           PIC 9(04).
*$XFD USE GROUP
*>      處方序號
                03      HIGCA-ODR-NO.
                        05      HIGCA-INS-DATE          PIC 9(07).
                        05      HIGCA-ODR-SEQ           PIC 9(04).
*$XFD USE GROUP
*>      異動日期,異動時間
                03      HIGCA-DTI.
                        05      HIGCA-DATE              PIC 9(07).
                        05      HIGCA-TIME              PIC 9(06).
*$XFD USE GROUP, VAR-LENGTH
        02      HIGCA-CODE.
*>      異動代號                "I "=>INSERT, "MD"=>MODIFY前
*>                                    "MI"=>MODIFY後,
*>                                    "M "=>MODIFY
*>                                    "D "=>DELETE

                03      HIGCA-UPD-ID                    PIC X(02).
*>      異動者
                03      HIGCA-UPD-USR                   PIC X(05).
*>      異動識別碼
                03      HIGCA-JOB-ID                    PIC X(03).
*>      申報系統異動識別碼(Y)(910306)
                03      HIGCA-APY-ID                    PIC X(01).
*>      2014/4/10 異動作業點
                03      HIGCA-MOD-PROG                  PIC X(10).
*>      2014/4/10 異動作業名稱
                03      HIGCA-MOD-PG-NAME               PIC X(20).
*>      2014/4/10 X(59) --> X(29)
                03      HIGCA-CODE-FILLER               PIC X(29).
*>
*$XFD USE GROUP , VAR-LENGTH
*>      [HIGCA-DATA1]   mapping [ICA-DATA1]
        02      HIGCA-DATA1                             PIC X(250).
*>      預留
*$XFD USE GROUP , VAR-LENGTH
*>97/10/11 [HIGCA-DATA2]        mapping [ICAE-DATA1]
        02      HIGCA-DATA2                             PIC X(250).
*---------------------------------------------------------------------*
*>      異動識別碼:
*>      新增[I]:
*>              I01: 批價新增,
*>              I02: 住院日結
*>              I03: 護理之家整批結帳
*>              I04: 呼吸照護處方
*>              I05: 轉介處方產生
*>              I06: 出院結帳
*>              I07: 門急診轉住院
*>              I08: UD傳送
*>              I09: 伙食結算
*---------------------------------------------------------------------*
*>      ＥＮＤ　ＯＦ　ＣＯＰＹ　ＦＩＬＥ　                            *
*---------------------------------------------------------------------*









*COPY    "HI_GCB.MST".
*********************************
*> 住院處方明細異動檔 RECORD LENGTH = 957 BYTES
*********************************
 FD      HIGCB-MST         EXTERNAL.
 01      HIGCB-MST-REC.
        02      HIGCB-KEY.
            03  HIGCB-GCA-KEY.
*$XFD USE GROUP
*>      住院序號
                20      HIGCB-IPD-NO.
                        30      HIGCB-IPD-DATE          PIC 9(7).

                        30      HIGCB-IPD-SEQ             PIC 9(4).
*$XFD USE GROUP
*>      處方序號
                20      HIGCB-ODR-NO.
                        30      HIGCB-INS-DATE            PIC 9(7).
                        30      HIGCB-ODR-SEQ             PIC 9(4).
*$XFD USE GROUP
*>      異動日期, 時間
                20      HIGCB-DTI.
                        30      HIGCB-DATE              PIC 9(7).
                        30      HIGCB-TIME              PIC 9(6).
*>      處置流水號
            03  HIGCB-FEE-SEQ                           PIC 9(3).
*>      處置代碼
            03  HIGCB-FEE-KEY                           PIC X(9).
*>
*> 預留
*$XFD USE GROUP, VAR-LENGTH
        02      HIGCB-CODE.
*>      異動代號
                20      HIGCB-UPD-ID                    PIC X(2).
*>      檔案序號
                20      HIGCB-FILE-NO                   PIC 9(3).
*>      類別
                20      HIGCB-TYPE                      PIC X(1).
                20      HIGCB-CODE-FILLER               PIC X(54).
*>      [HIGCB-ECB-ALT1]        mapping [ECB-ALT1]
                20      HIGCB-ECB-ALT1                  PIC X(50).
*>      [HIGCB-ECB-ALT2]        mapping [ECB-ALT2]
                20      HIGCB-ECB-ALT2                  PIC X(50).
*>      [HIGCB-DATA1]   mapping [ICB-GROUP-DATA1]
*$XFD USE GROUP, VAR-LENGTH
        02      HIGCB-DATA1                             PIC X(250).
*>
*$XFD USE GROUP, VAR-LENGTH
*>      [HIGCB-ECB-DATA1]       mapping [ECB-GROUP-DATA1]
*$XFD USE GROUP, VAR-LENGTH
        02      HIGCB-ECB-DATA1                         PIC X(250).
*>      [HIGCB-ECB-DATA2]       mapping [ECB-GROUP-DATA2]
*$XFD USE GROUP, VAR-LENGTH
        02      HIGCB-ECB-DATA2                         PIC X(250).
*********************************
*>      END OF FILE
*********************************
*COPY    "HO_PEF.MST".
***********************************************************
***  HO SYSTEM MASTF C-PY FILE NAME : HO_PEF.MST ....
***  < HO_MPEF > FILE RECORDS LENGTH ARE 800 CHARS.
***  處置延伸檔
***********************************************************
***  PEF-MST-KEY  = PEF-CODE
***********************************************************
 FD      PEF-MST IS EXTERNAL.
 01      PEF-MST-REC.
*       原 [1173] 處置延伸設定(001:300)
        02 PEF-1173.
                03 PEF-ID                       PIC X(04).

                03 PEF-CODE                     PIC X(20).
                03 PEF-TRN                      PIC X(20).
                03 PEF-NAME                     PIC X(24).
*$XFD USE GROUP , VAR-LENGTH
                03 PEF-REC                      PIC X(232).
*       新處置延伸設定(301:500)
        02 PEF-RECE.
*$XFD USE GROUP , VAR-LENGTH
                03 PEF-REC1                     PIC X(200).
*$XFD USE GROUP , VAR-LENGTH
                03 PEF-REC2                     PIC X(200).
*$XFD USE GROUP , VAR-LENGTH
                03 PEF-REC3                     PIC X(100).
*
*COPY    "HR_ELC.TRN".
*----------------------------------------------------------------------*
* 電子病歷日結檔：HR_ELC.TRN                          檔案：HR_TELC    *
*----------------------------------------------------------------------*
* 主：ELC-TRN-KEY = ELC-SYS + ELC-KEY                                  *
* 副：ELC-ALT-KEY1 = ELC-SYS + ELC-UPD + ELC-KEY                       *
*----------------------------------------------------------------------*
*
 FD ELC-TRN              EXTERNAL.
 01 ELC-TRN-REC.
*> 處理系統 [A]門診 [B]住院基本資料 [C]住院批價處方 [D] 住院退藥處方
*>                  [E]申報主機住院批價處方
*>                  [F]申報主機住院退藥處方
        02 ELC-SYS                                      PIC X(01).
*> 處方序號
        02 ELC-KEY                                      PIC X(50).
        02 ELC-A-KEY REDEFINES ELC-KEY.
                03 ELC-A-RO-NO.
                        04 ELC-A-RO-DT                  PIC 9(07).
                        04 ELC-A-RO-SEQ                 PIC 9(04).
                03 ELC-A-FILLER                         PIC X(39).
*> 住院基本資料
        02 ELC-B-KEY REDEFINES ELC-KEY.
                03 ELC-B-DATE                           PIC 9(07).
                03 ELC-B-TIME                           PIC 9(08).
                03 ELC-B-IPD-NO.
                        04 ELC-B-IPD-DT                 PIC 9(07).
                        04 ELC-B-IPD-SEQ                PIC 9(04).
                03 ELC-B-FILLER                         PIC X(24).
*> 住院批價處方
        02 ELC-C-KEY REDEFINES ELC-KEY.
                03 ELC-C-DATE                           PIC 9(07).
                03 ELC-C-TIME                           PIC 9(08).
                03 ELC-C-IPD-NO.
                        04 ELC-C-IPD-DATE               PIC 9(07).
                        04 ELC-C-IPD-SEQ                PIC 9(04).
                03 ELC-C-ODR-NO.
                        04 ELC-C-INS-DATE               PIC 9(07).
                        04 ELC-C-ODR-SEQ                PIC 9(04).
                03 ELC-C-FILLER                         PIC X(13).
*>
*> 住院退藥處方
        02 ELC-D-KEY REDEFINES ELC-KEY.

                03 ELC-D-DATE                           PIC 9(07).
                03 ELC-D-TIME                           PIC 9(08).
*>              住院序號
                03 ELC-D-IPD-NO.
                        04 ELC-D-IPD-DATE               PIC 9(07).
                        04 ELC-D-IPD-SEQ                PIC 9(04).
                03 ELC-D-RTA-NO.
                        04 ELC-D-RTA-DATE               PIC 9(07).
                        04 ELC-D-RTA-SEQ                PIC 9(03).
                03 ELC-D-FILLER                         PIC X(14).
*> 申報主機住院批價處方 900912 INSERT
        02 ELC-E-KEY REDEFINES ELC-KEY.
                03 ELC-E-IPD-NO.
                        04 ELC-E-IPD-DATE               PIC 9(07).
                        04 ELC-E-IPD-SEQ                PIC 9(04).
                03 ELC-E-ODR-NO.
                        04 ELC-E-INS-DATE               PIC 9(07).
                        04 ELC-E-ODR-SEQ                PIC 9(04).
                03 ELC-E-FILLER                         PIC X(28).
*>
*> 申報主機住院退藥處方 900912 INSERT
        02 ELC-F-KEY REDEFINES ELC-KEY.
*>              住院序號
                03 ELC-F-IPD-NO.
                        04 ELC-F-IPD-DATE               PIC 9(07).
                        04 ELC-F-IPD-SEQ                PIC 9(04).
*>              退藥序號
                03 ELC-F-RTA-NO.
                        04 ELC-F-RTA-DATE               PIC 9(07).
                        04 ELC-F-RTA-SEQ                PIC 9(03).
                03 ELC-F-FILLER                         PIC X(29).

*> 最新處理 [Y]
        02 ELC-UPD                                      PIC X(01).
*>
        02 ELC-DATA.
*> 處理 [C]新增 [M]修改 [D]刪除
                03 ELC-DO                               PIC X(01).
                03 ELC-FILLER                           PIC X(100).
*
*COPY    "HR_IBG.MST".
*--------------------------------------------------------------------------*
*> 住院醫令表單控制檔：HR_IBG.MST                             檔案：HR_MIBG*
*--------------------------------------------------------------------------*
*>主：IBG-MST-KEY = IBG-UNIT-NO + IBG-DT + IBG-SEQ                         *
*>副：IBG-ALT-KEY1 = IBG-UNIT-NO + IBG-DT + IBG-PRINT-MARK + IBG-SEQ       *
*--------------------------------------------------------------------------*
 FD      IBG-MST         EXTERNAL.
 01      IBG-MST-REC.
*>   護理站代號 <GUI 改版此欄位為列印單位代碼>
        02      IBG-UNIT-NO                     PIC X(05).
*>   日期
        02      IBG-DT                          PIC 9(07).
*>   表單序號(流水號)
        02      IBG-SEQ                         PIC 9(10).
*>   表單種類
*>      [A]ＵＤ憑證                     [B]臨時處方,出院帶藥,首日量     [C]會診單

*>      [D]護理治療憑證                 [E]檢驗放射線憑證               [F]檢驗放射單
*>      [G]預開處方憑證(含預開治療)     [H]X光片借閱單                  [I]出院帶藥憑證(預開)
*>      [J]預掛單                       [K]退藥申請單                   [L]手術通知單
*>      [M]即時檢驗報告                 [N]出院通知單                   [O]領血備血單
*>      [P]管制抗生素處方箋             [Q]取消處方箋                   [R]退藥憑證
*>      [S]自費意願書                   [T]特殊藥品使用申請單           [U]排程單
*>      [V]感管藥品申請單               [W]治療處置單(復健)             [X]轉介復健通知單
*>      [Y]復健治療單(手持單)           [Z]中醫住院護理站藥單
*>      [a]抗流感表單                   [b]CHEMO 標籤                   [c]CHEMO 標籤(緊急處方)
*>      [d]醫囑單(DC)                   [e]醫囑單                       [f]檢驗放射單(逐項)
*>      [h]血庫退件單                   [i]防護須知單                   [j]泛藥菌隔離單
*>      [m]檢驗退件通知單               [n]感管藥品審查單
*>      [q]取消處方箋(檢驗刪除)         [o]領血備血單(新版)             [v]非管制性感管藥品申請單
*>      [w]領血通知單
*>      [z]護理人員治療處置單(豐原)
*>      [1]批價憑證(刪除)               [2]旭仁版UD憑證                 [3]化療藥品領用單
*>      [4]護理退藥申請單               [5]RFID照會單                   [6]特殊用藥照會單
*>      [7]藥袋品項錯誤照會單           [8]長期醫囑單（樹林仁愛）       [9]臨時醫囑單（樹林仁愛）

        02      IBG-PAPER-ID                    PIC X(01).
*>   列印狀況("Y"表該表已印出," "表尚未列印)
        02      IBG-PRINT-MARK                  PIC X(01).
*>   傳遞變數(為了要印出各種表單,使用此欄位儲存KEY值)
*$XFD USE GROUP , VAR-LENGTH
        02      IBG-REC                         PIC X(200).
        02      IBG-REC-DATA REDEFINES IBG-REC.
*>                                              (1:50)
                03      IBG-PRINT-DATA          PIC X(50).
*>              傳送表單時間                    (51:6)
                03      IBG-SEND-TIME.
                        04      IBG-SEND-HH     PIC 9(02).
                        04      IBG-SEND-MT     PIC 9(02).
                        04      IBG-SEND-SS     PIC 9(02).
*>              印表時間(第一次)                (57:6)
                03      IBG-PRINT-TIME.
                        04      IBG-PRINT-HH    PIC 9(02).
                        04      IBG-PRINT-MT    PIC 9(02).
                        04      IBG-PRINT-SS    PIC 9(02).
*>              印表時間(最後一次)              (63:6)
                03      IBG-PRINT-E-TIME.
                        04      IBG-PRINT-E-HH  PIC 9(02).
                        04      IBG-PRINT-E-MT  PIC 9(02).
                        04      IBG-PRINT-E-SS  PIC 9(02).
*>              固定只印某一聯(不論參數是否有上Y)
*>              [A] 表藥局聯 [B] 表會診通知聯   (69:1)
                03      IBG-SP-PAPER            PIC X(01).
*>              床位號                          (70:6)
                03      IBG-BED.
                        04      IBG-BED-ROOM    PIC X(04).
                        04      IBG-BED-NO      PIC X(02).
*>              HTCHK-MST-STATUS狀態
*>                                              (76:2)
                03      IBG-HTCHK-STATUS        PIC X(02).
*>                                              (78:123)
                03      IBG-FILLER              PIC X(123).




*>102.09.06 (FISH) 因RD14藥袋品項錯誤照會單有問題，故需新增欄位，以傳遞資料
*>              (04)                            (76:4)
*>              03      IBG-ERR-CODE            PIC X(04).
*>              (40)                            (80:40)
*>              03      IBG-ERR-NOTE            PIC X(40).
*>              (40)                            (120:40)
*>              03      IBG-ERR-WAY             PIC X(40).
*>              (41)                            (160:41)
*>              03      IBG-FILLER              PIC X(41).
*>102.09.06 END


*>
*> update hr_mibg set ibg_print_mark = "Y"
*> where ibg_dt = 0940623 and ibg_unit_no = "UD6A" and ibg_seq = 250

*>102.09.06 (FISH) 因RD14藥袋品項錯誤照會單有問題，故需新增欄位，以傳遞資料
***********************************************************************
*> END OF "HR_IBG.MST"
***********************************************************************
*COPY    "HR_RNU.MST".
*>---------------------------------------------------------------------*
*> 醫令號碼檔：HR_RNU.MST                              檔案：HR_MRNU   *
*> 2019/05/08 台中-增加藥師訪視記錄(R) - 瑋育                          *
*>---------------------------------------------------------------------*
*> 主 KEY : RNU-KEY                                                    *
*>---------------------------------------------------------------------*
 FD RNU-MST              EXTERNAL.
 01      RNU-MST-REC.
        02      RNU-KEY                         PIC X(40).
*> A. 護理站QUE單序號
        02      RNU-A-KEY REDEFINES RNU-KEY.
                03      RNU-A-ID                PIC X(01).
                03      RNU-A-DT                PIC 9(07).
                03      RNU-A-UNIT              PIC X(05).
                03      RNU-A-KFIL              PIC X(27).
*> B. 會診通知序號
        02      RNU-B-KEY REDEFINES RNU-KEY.
                03      RNU-B-ID                PIC X(01).
                03      RNU-B-DT                PIC 9(07).
                03      RNU-B-KFIL              PIC X(32).
*> C. 診間QUE單序號
        02      RNU-C-KEY REDEFINES RNU-KEY.
                03      RNU-C-ID                PIC X(01).
                03      RNU-C-DT                PIC 9(07).
                03      RNU-C-UNIT              PIC X(05).
                03      RNU-C-KFIL              PIC X(27).
*> D. 入院病歷建檔序號
        02      RNU-D-KEY REDEFINES RNU-KEY.
                03      RNU-D-ID                PIC X(01).
                03      RNU-D-IPD-NO.
                        04      RUN-D-IPD-DT    PIC 9(07).
                        04      RUN-D-IPD-SEQ   PIC 9(04).
                03      RNU-D-KFIL              PIC X(28).
*> E. 退藥申請單序號
        02      RNU-E-KEY REDEFINES RNU-KEY.

                03      RNU-E-ID                PIC X(01).
                03      RNU-E-DT                PIC 9(07).
                03      RNU-E-KFIL              PIC X(32).
*> F. 診斷書,甲種病歷摘要,轉診回覆單開立序號
        02      RNU-F-KEY REDEFINES RNU-KEY.
                03      RNU-F-ID                PIC X(01).
                03      RNU-F-DT                PIC 9(07).
                03      RNU-F-KFIL              PIC X(32).
*> G. 急診檢流水號
        02      RNU-G-KEY REDEFINES RNU-KEY.
                03      RNU-G-ID                PIC X(01).
                03      RNU-G-DT                PIC 9(07).
                03      RNU-F-KFIL              PIC X(32).
*> H. 急診退藥單序號
        02      RNU-H-KEY REDEFINES RNU-KEY.
                03      RNU-H-ID                PIC X(01).
                03      RNU-H-DT                PIC 9(07).
                03      RNU-H-UNIT              PIC X(05).
                03      RNU-H-KFIL              PIC X(27).
*> I. 疫苗批號之接種序號(VAC-ID = "1" HBIG免疫球蛋白 "2"BCG卡介苗 "3"HBVＢ肝疫苗 )
        02      RNU-I-KEY REDEFINES RNU-KEY.
                03      RNU-I-ID                PIC X(01).
                03      RNU-I-VAC-ID            PIC X(01).
                03      RNU-I-VAC-NO            PIC X(15).
                03      RNU-I-KFIL              PIC X(23).
*> J. 檢驗取消處方單序號
        02      RNU-J-KEY REDEFINES RNU-KEY.
                03      RNU-J-ID                PIC X(01).
                03      RNU-J-DT                PIC 9(07).
                03      RNU-J-KFIL              PIC X(32).
*> K. 主治醫師手寫醫囑單序號(HR_MMJA)
        02      RNU-K-KEY REDEFINES RNU-KEY.
                03      RNU-K-ID                PIC X(01).
                03      RNU-K-IPD-NO            PIC X(11).
                03      RNU-K-KFIL              PIC X(28).
*> 2009/11/4 01:52下午 selina
*> L. 急診五級檢傷常用主訴建檔自動編號
        02      RNU-L-KEY REDEFINES RNU-KEY.
                03      RNU-L-ID                PIC X(01).
*> 科別 [1]非外傷 [2]外傷 [3]兒科(非外傷)
                03      RNU-L-DPT               PIC X(01).
                03      RNU-L-KFIL              PIC X(38).
*> 2010.10.14 19:15 (P)
*> M. 照會單序號
        02      RNU-M-KEY REDEFINES RNU-KEY.
                03      RNU-M-ID                PIC X(01).
*>              [O]門診 [I]住院
                03      RNU-M-IO                PIC X(01).
*> .............(門診->門診序號) , (住院->處方序號)
                03      RNU-M-ODR-NO.
                        04      RNU-M-ODR-DT    PIC 9(07).
                        04      RNU-M-ODR-SEQ   PIC 9(04).
*> .............住院序號 (住院才有)
                03      RNU-M-IPD-NO.
                        04      RNU-M-IPD-DT    PIC 9(07).
                        04      RNU-M-IPD-SEQ   PIC 9(04).
*>              修改次數

                03      RNU-M-MOD-CNT           PIC 9(02).
                03      RNU-M-KFIL              PIC X(14).
*> 2010.10.22 (AICE)
*> N. 照會單序號(住醫取號用)
        02      RNU-N-KEY REDEFINES RNU-KEY.
                03      RUN-N-ID                PIC X(01).
                03      RUN-N-IPD-NO.
                        04      RUN-N-IPD-DT    PIC 9(07).
                        04      RUN-N-IPD-SEQ   PIC 9(04).
                03      RUN-N-DATE              PIC 9(07).
                03      RUN-N-KFIL              PIC X(21).
*> O. 家庭檔號號碼檔(門診)
        02      RNU-O-KEY REDEFINES RNU-KEY.
                03      RUN-O-ID                PIC X(01).
                03      RUN-O-KFIL              PIC X(39).
*> 2015.03.17 (SU) E-4339 藥師臨床疑義照會功能
*> P. 醫師與藥師照會記錄檔(HR_MMEP)序號
        02      RNU-P-KEY REDEFINES RNU-KEY.
                03      RNU-P-ID                PIC X(01).
                03      RNU-P-DT                PIC 9(07).
                03      RNU-P-KFIL              PIC X(32).
*> 2015.04.27 (SU) 豐原-住院醫令交班單
*> Q. 住院醫令交班單記錄檔(HR_MSOV)序號
        02      RNU-Q-KEY REDEFINES RNU-KEY.
                03      RNU-Q-ID                PIC X(01).
                03      RNU-Q-DT                PIC 9(07).
                03      RNU-Q-KFIL              PIC X(32).
*> 2019/05/08 台中-增加藥師訪視記錄
*> R. 藥師訪視建檔序號
        02      RNU-R-KEY REDEFINES RNU-KEY.
                03      RNU-R-ID                PIC X(01).
*>                      I:住院 O:門診
                03      RNU-R-IO                PIC X(01).
*>                      門住序號
                03      RNU-R-NO.
                        04      RUN-R-DT        PIC 9(07).
                        04      RUN-R-SEQ       PIC 9(04).
                03      RNU-R-KFIL              PIC X(27).
*> ------------------------------------------------------------------------ *<
        02      RNU-DATA                        PIC X(40).
*> A. 護理站QUE單序號
        02      RNU-A-DATA REDEFINES RNU-DATA.
                03      RNU-A-NO                PIC 9(05).
                03      RNU-A-DFIL              PIC X(35).
*> B. 會診通知序號
        02      RNU-B-DATA REDEFINES RNU-DATA.
                03      RNU-B-NO                PIC 9(04).
                03      RNU-B-DFIL              PIC X(36).
*> C. 診間QUE單序號
        02      RNU-C-DATA REDEFINES RNU-DATA.
                03      RNU-C-NO                PIC 9(06).
                03      RNU-C-DFIL              PIC X(34).
*> D. 入院病歷建檔序號
        02      RNU-D-DATA REDEFINES RNU-DATA.
                03      RNU-D-NO                PIC 9(10).
                03      RNU-D-DFIL              PIC X(30).
*> E. 退藥申請單序號

        02      RNU-E-DATA REDEFINES RNU-DATA.
                03      RNU-E-NO                PIC 9(04).
                03      RNU-E-DFIL              PIC X(36).
*> F. 診斷書,甲種病歷摘要,轉診回覆單開立序號
        02      RNU-F-DATA REDEFINES RNU-DATA.
                03      RNU-F-NO                PIC 9(05).
                03      RNU-F-DFIL              PIC X(35).
*> G. 急診檢傷流水號
        02      RNU-G-DATA REDEFINES RNU-DATA.
                03      RNU-G-NO                PIC 9(04).
                03      RNU-G-DFIL              PIC X(36).
*> H. 急診退藥單序號
        02      RNU-H-DATA REDEFINES RNU-DATA.
                03      RNU-H-NO                PIC 9(06).
                03      RNU-H-DFIL              PIC X(34).
*> I. 疫苗批號之接種序號
        02      RNU-I-DATA REDEFINES RNU-DATA.
                03      RNU-I-NO                PIC 9(04).
                03      RNU-I-DFIL              PIC X(36).
*> J. 檢驗取消處方單序號
        02      RNU-J-DATA REDEFINES RNU-DATA.
                03      RNU-J-NO                PIC 9(06).
                03      RNU-J-DFIL              PIC X(34).
*> K. 主治醫師手寫醫囑單序號(HR_MMJA)
        02      RNU-K-DATA REDEFINES RNU-DATA.
                03      RNU-K-NO                PIC 9(07).
                03      RNU-K-DFIL              PIC X(33).
*> 2009/11/4 01:52下午 selina
*> L. 急診五級檢傷常用主訴建檔自動編號
        02      RNU-L-DATA REDEFINES RNU-DATA.
                03      RNU-L-NO                PIC 9(03).
                03      RNU-L-DFIL              PIC X(37).
*> 2010.10.14 19:15 (P)
*> M. 照會單序號
        02      RNU-M-DATA REDEFINES RNU-DATA.
                03      RNU-M-NO                PIC 9(03).
                03      RNU-M-DFIL              PIC X(37).
*> 2010.10.22 (AICE)
*> N. 照會單序號(住醫取號用)
        02      RNU-N-DATA REDEFINES RNU-DATA.
                03      RNU-N-NO                PIC 9(04).
                03      RNU-N-DFIL              PIC X(36).
*> O. 家庭檔號號碼檔(門診)
        02      RNU-O-DATA REDEFINES RNU-DATA.
                03      RNU-O-NO                PIC 9(10).
                03      RNU-O-DFIL              PIC X(30).
*> 2015.03.17 (SU) E-4339 藥師臨床疑義照會功能
*> P. 醫師與藥師照會記錄檔(HR_MMEP)序號
        02      RNU-P-DATA REDEFINES RNU-DATA.
                03      RNU-P-NO                PIC 9(04).
                03      RNU-P-DFIL              PIC X(36).
*> 2015.04.27 (SU) 豐原-住院醫令交班單
*> Q. 住院醫令交班單記錄檔(HR_MSOV)序號
        02      RNU-Q-DATA REDEFINES RNU-DATA.
                03      RNU-Q-NO                PIC 9(04).
                03      RNU-Q-DFIL              PIC X(36).
*> 2019/05/08 台中-增加藥師訪視記錄

*> R. 藥師訪視建檔序號
        02      RNU-R-DATA REDEFINES RNU-DATA.
                03      RNU-R-NO                PIC 9(10).
                03      RNU-R-DFIL              PIC X(30).
***********************************************************************
*> END OF "HR_RNU.MST".
***********************************************************************
*COPY    "HR_FNS.MST".
*>----------------------------------------------------------------------*
*> 鍵值檔：HR_FNS.MST         271 Bytes                檔案：HR_MFNS    *
*>----------------------------------------------------------------------*
*> 主：FNS-MST-KEY  = FNS-ID + FNS-P-KEY                                *
*> 副：FNS-ALT-KEY1 = FNS-ID + FNS-A-KEY + FNS-P-KEY                    *
*> 副：FNS-ALT-KEY2 = FNS-ID + FNS-B-KEY + FNS-P-KEY                    *
*>----------------------------------------------------------------------*
*
 FD      FNS-MST         EXTERNAL.
 01      FNS-MST-REC.
*>**********>
*> 識 別 碼 *
*>**********>
        02      FNS-ID                                  PIC X(01).
*>********************************************************************
*>                          主  KEY
*>********************************************************************
        02      FNS-P-KEY                               PIC X(40).
*> [A] [B] [E] [O] [P] [R] [S] [T] [a] [d] [j] [l] [x]
        02      FNS-PA-KEY REDEFINES FNS-P-KEY.
*> .............門診序號
                03      FNS-PA-NO.
                        04      FNS-PA-DT               PIC 9(07).
                        04      FNS-PA-SEQ              PIC 9(04).
                03      FNS-PA-FILLER                   PIC X(29).
*> [C]
        02      FNS-PC-KEY REDEFINES FNS-P-KEY.
*> .............門診序號
                03      FNS-PC-NO.
                        04      FNS-PC-DT               PIC 9(07).
                        04      FNS-PC-SEQ              PIC 9(04).
*> .............變更日期
                03      FNS-PC-CDATE                    PIC 9(07).
*> .............變更時間
                03      FNS-PC-CTIME.
                        04      FNS-PC-CHH              PIC 9(02).
                        04      FNS-PC-CMM              PIC 9(02).
                        04      FNS-PC-CSS              PIC 9(02).
                03      FNS-PC-FILLER                   PIC X(16).
*> [D]
        02      FNS-PD-KEY REDEFINES FNS-P-KEY.
*> .............門診序號
                03      FNS-PD-NO.
                        04      FNS-PD-DT               PIC 9(07).
                        04      FNS-PD-SEQ              PIC 9(04).
*> .............處方序號
                03      FNS-ODR-SEQ                     PIC 9(02).
*> .............處置序號
                03      FNS-FEE-NO                      PIC 9(02).

                03      FNS-PD-FILLER                   PIC X(25).
*> [F]
        02      FNS-PF-KEY REDEFINES FNS-P-KEY.
*> .............病歷號碼
                03      FNS-PF-PAT-NO                   PIC 9(08).
*> .............行序
                03      FNS-PF-SEQ                      PIC 9(01).
                03      FNS-PF-FILLER                   PIC X(31).
*> [G]
        02      FNS-PG-KEY REDEFINES FNS-P-KEY.
*> .............住院序號
                03      FNS-PG-IPD-NO.
                        04      FNS-PG-IPD-DATE         PIC 9(07).
                        04      FNS-PG-IPD-SEQ          PIC 9(04).
*> .............處方序號
                03      FNS-PG-ODR-NO.
                        04      FNS-PG-INS-DATE         PIC 9(07).
                        04      FNS-PG-ODR-SEQ          PIC 9(04).
                03      FNS-PG-FILLER                   PIC X(18).
*> [H][Z]
        02      FNS-PH-KEY REDEFINES FNS-P-KEY.
*> .............門診序號
                03      FNS-PH-NO.
                        04      FNS-PH-DT               PIC 9(07).
                        04      FNS-PH-SEQ              PIC 9(04).
*> .............[1]職能 [2]語言 [3]物理
                03      FNS-PH-DEPT                     PIC X(01).
                03      FNS-PH-FILLER                   PIC X(28).
*> [I]
        02      FNS-PI-KEY REDEFINES FNS-P-KEY.
*> .............門診序號
                03      FNS-PI-NO.
                        04      FNS-PI-DT               PIC 9(07).
                        04      FNS-PI-SEQ              PIC 9(04).
*> .............[1]職能 [2]語言 [3]物理
                03      FNS-PI-DEPT                     PIC X(01).
*> .............行序
                03      FNS-PI-SEQ1                     PIC 9(02).
                03      FNS-PI-FILLER                   PIC X(26).
*> [J]
        02      FNS-PJ-KEY REDEFINES FNS-P-KEY.
*> .............住院序號
                03      FNS-PJ-IPD-NO.
                        04      FNS-PJ-IPD-DATE         PIC 9(07).
                        04      FNS-PJ-IPD-SEQ          PIC 9(04).
*> .............[1]職能 [2]語言 [3]物理
                03      FNS-PJ-DEPT                     PIC X(01).
                03      FNS-PJ-FILLER                   PIC X(28).
*> [K]
        02      FNS-PK-KEY REDEFINES FNS-P-KEY.
*> .............住院序號
                03      FNS-PK-IPD-NO.
                        04      FNS-PK-IPD-DATE         PIC 9(07).
                        04      FNS-PK-IPD-SEQ          PIC 9(04).
*> .............[1]職能 [2]語言 [3]物理
                03      FNS-PK-DEPT                     PIC X(01).
*> .............行序

                03      FNS-PK-SEQ1                     PIC 9(02).
                03      FNS-PK-FILLER                   PIC X(26).
*> [L]
        02      FNS-PL-KEY REDEFINES FNS-P-KEY.
*> .............住院序號
                03      FNS-PL-IPD-NO.
                        04      FNS-PL-IPD-DATE         PIC 9(07).
                        04      FNS-PL-IPD-SEQ          PIC 9(04).
*> .............類別(A~F)
                03      FNS-PL-ID                       PIC X(01).
                03      FNS-PL-FILLER                   PIC X(28).
*> [M]
        02      FNS-PM-KEY REDEFINES FNS-P-KEY.
                03      FNS-PM-PAT-NO                   PIC 9(08).
                03      FNS-PM-SEQ                      PIC 9(04).
                03      FNS-PM-FILLER                   PIC X(28).
*> [N]
        02      FNS-PN-KEY REDEFINES FNS-P-KEY.
*> .............日期
                03      FNS-PN-DT                       PIC 9(07).
*> .............科別
                03      FNS-PN-DPT                      PIC X(04).
*> .............午別
                03      FNS-PN-TURN                     PIC X(01).
*> .............診間
                03      FNS-PN-ROOM                     PIC X(02).
                03      FNS-PN-FILLER                   PIC X(26).
*> [N]
        02      FNS-PN2-KEY REDEFINES FNS-P-KEY.
                03      FNS-PN-UNIT-NO                  PIC X(05).
                03      FNS-PN-DATE                     PIC 9(07).
                03      FNS-PN-LNO-LID                  PIC X(05).
                03      FNS-PN-TIME                     PIC 9(06).
                03      FNS-PN-PAPER-ID                 PIC X(01).
                03      FNS-PN-ST                       PIC X(02).
                03      FNS-PN2-FILLER                  PIC X(14).
*> [Q] --- 院內檢查
*> [V] --- 戒煙提示記錄
        02      FNS-PQ-KEY REDEFINES FNS-P-KEY.
*> .............(門診->門診序號) , (住院->處方序號)
                03      FNS-PQ-ODR-NO.
                        04      FNS-PQ-ODR-DATE         PIC 9(07).
                        04      FNS-PQ-ODR-SEQ          PIC 9(04).
*> .............住院序號 (住院才有)
                03      FNS-PQ-IPD-NO.
                        04      FNS-PQ-IPD-DATE         PIC 9(07).
                        04      FNS-PQ-IPD-SEQ          PIC 9(04).
                03      FNS-PQ-FILLER                   PIC X(18).
*>     --- 外院檢查
        02      FNS-PQ2-KEY REDEFINES FNS-P-KEY.
                03      FNS-PQ2-ODR-DATE                PIC 9(07).
                03      FNS-PQ2-PAT-NO                  PIC 9(08).
                03      FNS-PQ2-FILLER                  PIC X(25).

*> [T] --- 轉診流水號 <O> REF 轉出  <I> RRI轉入
        02      FNS-PT-KEY REDEFINES FNS-P-KEY.
                03      FNS-PT-ID                       PIC X(01).

                03      FNS-PT-DT                       PIC 9(07).
                03      FNS-PT-FILLER                   PIC X(32).
*> [U] --- 患者就診健保科別
        02      FNS-PU-KEY REDEFINES FNS-P-KEY.
                03      FNS-PU-PAT-NO                   PIC 9(08).
                03      FNS-PU-INS-DPT                  PIC X(04).
                03      FNS-PU-FILLER                   PIC X(28).
*> [W] --- 住院醫令子宮頸提示
        02      FNS-PW-KEY REDEFINES FNS-P-KEY.
*> .............住院序號
                03      FNS-PW-IPD-NO.
                        04      FNS-PW-IPD-DATE         PIC 9(07).
                        04      FNS-PW-IPD-SEQ          PIC 9(04).
*> .............[A] 表示為肺炎雙球菌疫苗提示用
                03      FNS-PW-TYPE                     PIC X(01).
                03      FNS-PW-FILLER                   PIC X(28).
*> [X] --- 肺炎雙球菌疫苗
*> 只要處方中有一項, 就會有記錄, 因為處置碼可能會有好幾個, 但只要有開過任一,
*> 就算是開過! 所以修改時, 最好是先刪除, 然後判斷是否要寫檔 !
        02      FNS-PX-KEY REDEFINES FNS-P-KEY.
*> [O]門診 [I]住院
                03      FNS-PX-IO                       PIC X(01).
                03      FNS-PX-KEY-1                    PIC X(25).
*> .............門診處方
                03      FNS-PX-O-KEY REDEFINES FNS-PX-KEY-1.
                        04      FNS-PX-O-RO-KEY.
                                05 FNS-PX-O-RO-NO.
                                        06 FNS-PX-O-RO-DATE     PIC 9(07).
                                        06 FNS-PX-O-RO-SEQ      PIC 9(04).
                                05 FNS-PX-O-ODR-SEQ     PIC 9(02).
                        04      FNS-PX-O-FILER          PIC X(12).
*> .............住院處方
                03      FNS-PX-I-KEY REDEFINES FNS-PX-KEY-1.
                        04      FNS-PX-I-IPD-NO.
                                05 FNS-PX-I-IPD-DATE    PIC 9(7).
                                05 FNS-PX-I-IPD-SEQ     PIC 9(4).
                        04      FNS-PX-I-ODR-NO.
                                05 FNS-PX-I-INS-DATE    PIC 9(7).
                                05 FNS-PX-I-ODR-SEQ     PIC 9(4).
                        04      FNS-PX-I-FILLER         PIC X(03).
                03      FNS-PX-FILLER                   PIC X(14).
*> [Y] --- 手繪圖記錄
        02      FNS-PY-KEY REDEFINES FNS-P-KEY.
                03      FNS-PY-IO                       PIC X(01).
                03      FNS-PY-KEY-1                    PIC X(22).
*> .............門診處方
                03      FNS-PY-O-KEY REDEFINES FNS-PY-KEY-1.
                        04      FNS-PY-O-RO-KEY.
                                05 FNS-PY-O-RO-NO.
                                        06 FNS-PY-O-RO-DATE     PIC 9(07).
                                        06 FNS-PY-O-RO-SEQ      PIC 9(04).
                                05 FNS-PY-O-ODR-SEQ     PIC 9(02).
                        04      FNS-PY-O-FILER          PIC X(09).
*> .............住院處方
                03      FNS-PY-I-KEY REDEFINES FNS-PY-KEY-1.
                        04      FNS-PY-I-IPD-NO.
                                05 FNS-PY-I-IPD-DATE    PIC 9(7).

                                05 FNS-PY-I-IPD-SEQ     PIC 9(4).
                        04      FNS-PY-I-ODR-NO.
                                05 FNS-PY-I-INS-DATE    PIC 9(7).
                                05 FNS-PY-I-ODR-SEQ     PIC 9(4).
*> .............建檔日期時間
                03      FNS-PY-CDATE                    PIC 9(7).
                03      FNS-PY-CTIME                    PIC 9(6).
                03      FNS-PY-FILLER                   PIC X(4).
*> [b] --- 會診簡訊通知、回覆
        02      FNS-B1-KEY REDEFINES FNS-P-KEY.
                03      FNS-B1-KEY-1.
*> .............會診簡訊通知 [A]、會診簡訊回覆 [B]、會診簡訊通知取消 [C]、會診簡訊回覆取消 [D]
                        04      FNS-B1-CLS-ID           PIC X(01).
*> .............會診簡訊待處理 [N]、會診簡訊已處理 [Y]
                        04      FNS-B1-TRN-SW           PIC X(01).
*> .............會診簡訊寫入時點
                        04      FNS-B1-CRE-DATE         PIC 9(07).
                        04      FNS-B1-CRE-TIME         PIC 9(06).
*> .............[O]門診、[I]住院
                        04      FNS-B1-IP-CLSW          PIC X(01).
*> .............會診病患醫令序號
                        04      FNS-B1-IP-NO            PIC X(11).
                        04      FNS-B1-FILLER           PIC X(13).
*> [c] --- 住院醫令表傳送寫檔錯誤記錄
        02      FNS-C1-KEY REDEFINES FNS-P-KEY.
                03      FNS-C1-KEY-1.
*> .............護理站代號
                        04      FNS-C1-IBG-UNIT-NO      PIC X(05).
*> .............日期
                        04      FNS-C1-IBG-DT           PIC 9(07).
*> .............表單序號(流水號)
                        04      FNS-C1-IBG-SEQ          PIC 9(10).
                        04      FNS-C1-FILLER           PIC X(18).
*> [f] --- 患者藥品成份過敏記錄
        02      FNS-F1-KEY REDEFINES FNS-P-KEY.
*> .............病歷號碼
                03      FNS-F1-PAT-NO                   PIC 9(08).
*> .............藥品成份名(前32字)
                03      FNS-F1-FACTOR                   PIC X(32).
*> [g] --- 過敏用藥異動記錄
        02      FNS-G1-KEY REDEFINES FNS-P-KEY.
*> .............異動日期
                03      FNS-G1-UPD-DT-DEC               PIC 9(07).
*> .............異動時間
                03      FNS-G1-UPD-TI-DEC               PIC 9(06).
*> .............病歷號碼
                03      FNS-G1-PAT-NO                   PIC 9(08).
*>..............NKA
                03      FNS-G1-NKA                      PIC X(01).
                03      FNS-G1-FILLER                   PIC X(18).

*> [h] --- 子抹提示註記
        02      FNS-H1-KEY REDEFINES FNS-P-KEY.
*> .............門住序號
                03      FNS-H1-NO.
                        04      FNS-H1-DT               PIC 9(07).
                        04      FNS-H1-SEQ              PIC 9(04).

*> .............流水號
                03      FNS-H1-NO-SEQ                   PIC 9(03).
*> .............門住識別 [O]門診 [I]住院
                03      FNS-H1-IO                       PIC X(01).
                03      FNS-H1-FILLER                   PIC X(25).
*> [i] 98.07.10 整合照護醫師
        02      FNS-PI1-KEY REDEFINES FNS-P-KEY.
*> .............住院序號
                03      FNS-PI1-IPD-NO.
                        04      FNS-PI1-IPD-DATE        PIC 9(07).
                        04      FNS-PI1-IPD-SEQ         PIC 9(04).
*> .............整合照護醫師1-4
                03      FNS-PI1-SEQ                     PIC 9(01).
                03      FNS-PI1-FILLER                  PIC X(28).
*> [k] 99.03.24
        02      FNS-KI1-KEY REDEFINES FNS-P-KEY.
*> .............病患號碼
                03      FNS-PK1-PAT-NO                  PIC 9(08).
*>..............[1].高風險 [2].規則就醫
                03      FNS-PK1-PAT-ID                  PIC X(01).
*
                03      FNS-PK1-FILLER                  PIC X(31).
*> [m] --- 理學檢查 99.10.08
        02      FNS-M1-KEY REDEFINES FNS-P-KEY.
                03      FNS-PM1-PAT-NO                  PIC 9(08).
                03      FNS-PM1-REG-RO-NO.
                        04      FNS-PM1-REG-RO-DT       PIC 9(07).
                        04      FNS-PM1-REG-RO-SEQ      PIC 9(04).
                03      FNS-PM1-SEQ                     PIC 9(03).
                03      FNS-PM1-FILLER                  PIC X(18).

*> [n] 99.10.29 新生兒胞胎註記
        02      FNS-N1-KEY REDEFINES FNS-P-KEY.
                03      FNS-PN1-PAT-NO                  PIC 9(08).
                03      PNS-PN1-FILLER                  PIC X(32).

*> [o] 104.03.13.GD4-EVENT段落
        02      FNS-O1-KEY REDEFINES FNS-P-KEY.
*> .............病歷號碼
                03      FNS-PO1-PAT-NO                   PIC 9(08).
*> .............行序
                03      FNS-PO1-SEQ                      PIC 9(02).
                03      FNS-PO1-FILLER                   PIC X(30).
*> [p][r] 104.06.08聖母-[p]過敏處置過敏反應及嚴重度 [r]顯影劑過敏記錄(已停用)
        02      FNS-P1-KEY REDEFINES FNS-P-KEY.
*> .............病歷號
                03      FNS-PP1-PAT-NO                  PIC 9(08).
*> .............處置代碼
                03      FNS-PP1-PRS-ID                  PIC X(09).
                03      FNS-PP1-FILLER                  PIC X(23).
*> [q] 104.06.08聖母-過敏藥物開立原因
        02      FNS-Q1-KEY REDEFINES FNS-P-KEY.
*> .............門診序號
                03      FNS-PQ1-RO-NO.
*> .....................門診日期
                        04      FNS-PQ1-RO-DT           PIC 9(07).
*> .....................門診流水號

                        04      FNS-PQ1-RO-SEQ          PIC 9(04).
*> .............建檔序號(整張處方中的原始項次)(ODR1-CRE-NO)
                03      FNS-PQ1-CRE-NO                  PIC 9(5).
                03      FNS-PQ1-FILLER                  PIC X(24).
*> [s] 105.05.10 ATC CODE過敏記錄(聖母、茂盛醫院使用)
        02      FNS-S1-KEY REDEFINES FNS-P-KEY.
*> .............病歷號
                03      FNS-PS1-PAT-NO                  PIC 9(08).
*> .............ATC CODE
                03      FNS-PS1-ATC-CODE                PIC X(07).
*> .............預留
                03      FNS-PS1-FILLER                  PIC X(25).
*> [t] 105.10.05 ATC CODE過敏記錄異動(聖母、茂盛醫院使用)
        02      FNS-T1-KEY REDEFINES FNS-P-KEY.
*> .............病歷號碼
                03      FNS-PT1-PAT-NO                  PIC 9(08).
*> .............異動日期(倒序)
                03      FNS-PT1-DT                      PIC 9(07).
*> .............異動時間(倒序)
                03      FNS-PT1-TIME                    PIC 9(06).
*> .............ATC CODE
                03      FNS-PT1-ATC-CODE                PIC X(07).
*> .............預留
                03      FNS-PT1-FILLER                  PIC X(12).
*> [u] 聖母-過敏用藥刪除原因
        02      FNS-U1-KEY REDEFINES FNS-P-KEY.
*> .............病歷號碼
                03      FNS-PU1-PAT-NO                  PIC 9(08).
*> .............異動日期(倒序)
                03      FNS-PU1-DT-DEC                  PIC 9(07).
*> .............異動時間(倒序)
                03      FNS-PU1-TIME-DEC                PIC 9(06).
*> .............識別(1.過敏藥物 3.ATC CODE 5.其他記錄)
                03      FNS-PU1-ID                      PIC X(01).
*> .............預留
                03      FNS-PU1-FILLER                  PIC X(18).
*> [v] 過敏用藥提示日期
        02      FNS-V1-KEY REDEFINES FNS-P-KEY.
*> .............病歷號碼
                03      FNS-PV1-PAT-NO                  PIC 9(08).
*> .............預留
                03      FNS-PV1-FILLER                  PIC X(32).
*> [w] 住院醫令護理站表單傳送log 107.01.05
        02      FNS-W1-KEY REDEFINES FNS-P-KEY.
*> .............護理站代號
                        04      FNS-PW1-UNIT-NO         PIC X(05).
*> .............開單日期
                        04      FNS-PW1-IBG-DT          PIC 9(07).
*> .............護理站表單種類
                03      FNS-PW1-PAPER-ID                PIC X(01).
*> .............建檔時間
                03      FNS-PW1-CRE-TM                  PIC 9(06).
*> .............程式段落
                03      FNS-AW1-FUNC                    PIC X(02).
*> .............預留
                03      FNS-PW1-FILLER                  PIC X(16).
*> [y] 桃園-癌症外科手術副作用提示紀錄檔

        02      FNS-Y1-KEY REDEFINES FNS-P-KEY.
*> .............住院序號
                03      FNS-PY1-IPD-NO.
*> .............住院日期
                        04      FNS-PY1-IPD-DT          PIC 9(07).
*> .............住院流水號
                        04      FNS-PY1-IPD-SEQ         PIC 9(04).
*> .............預留
                03      FNS-PY1-FILLER                  PIC X(29).
*> [z] 桃園-處方醫令孕安警示增修 (107.08.27) (業107012902) (DM1801-J1800319)
*> 同門/急/住序號, 同醫師一天只要通知過藥局某孕安藥, 藥局解鎖後, 當天就都可以開立
*> 所以以下這些欄位當KEY記錄 , 醫令開立可以先讀看看是否成解鎖過 , 有就可開立 ,
*> 沒就寫一筆資料通知藥局解鎖
        02      FNS-Z1-KEY REDEFINES FNS-P-KEY.
*> .............門O/急E/住I 識別
                03              FNS-PZ1-IOE                             PIC X(01).
*> .............門診/急診/住院序號
        03      FNS-PZ1-NO.
                04      FNS-PZ1-DT                      PIC 9(07).
                04      FNS-PZ1-SEQ                     PIC 9(04).
*> .............開立日期 (系統日期)
                03              FNS-PZ1-CRE-DATE                PIC 9(07).
*> .............開立醫師
                03              FNS-PZ1-DR                              PIC X(04).
*> .............處置代碼
                03              FNS-PZ1-FEE-PRS                 PIC X(09).
                03              FNS-PZ1-FILLER                  PIC X(08).
*> [1] 2021/03/19 配合emr調整傳送識別(配合哲緯) - 瑋育
        02      FNS-P11-KEY REDEFINES FNS-P-KEY.
*> .........識別(1:住院病摘 2:出院病摘)
                03  FNS-P11-ID                          PIC X(01).
*> .........住院序號
                03  FNS-P11-IPD-NO.
                        04      FNS-P11-IPD-DATE        PIC 9(07).
                        04      FNS-P11-IPD-SEQ         PIC 9(04).
*> .........資料日期
                03  FNS-P11-DAT-NO.
                       04      FNS-P11-DAT-DT           PIC 9(07).
*> .........建檔序號
                       04      FNS-P11-CRE-SEQ          PIC 9(10).
*> .........預留
                03      FNS-P11-FILLER                  PIC X(11).
*>
*> [3] 新冠病毒檢驗試劑專案製造/輸入核准【核酸試劑】之「健保碼」
*>     內容同 HO_DGM.SON , HODGM-SON-ID = C19 之HODGM-SON-SKEY
        02      FNS-P2-KEY REDEFINES FNS-P-KEY.
*>      .............門:O 住:I
                        03      FNS-P2-IO                                                               PIC X(01).
*>  .............處方序號 : 若是門診REG-RO-NO , 若是住院 ICA-ODR-NO
                        03      FNS-P2-C19-NO                                   PIC X(11).
*>      .............檢驗項目:
*>        PCR 核酸檢驗 (目前只會有這值)
*>        FST 快速檢驗 ,        SPI 抗體檢測  (這2項是預留, 目前不會有資料)
                        03      FNS-P2-C19-ITEM                                 PIC     X(03).
*>      .............身分證號 (快篩整批匯入才有)
                        03      FNS-P2-IDNO                                                     PIC X(10).
*>      .............預留

                        03      FNS-P2-FILLER                                           PIC X(15).
*>********************************************************************
*>                          副  KEY1
*>********************************************************************
        02      FNS-A-KEY                               PIC X(40).
*> [A] [S]
        02      FNS-AA-KEY REDEFINES FNS-A-KEY.
*> .............病歷號碼
                03      FNS-AA-PAT                      PIC 9(08).
*> .............健保科別
                03      FNS-AA-BDPT                     PIC X(04).
*> .............門診序號(倒序)
                03      FNS-AA-DNO.
                        04      FNS-AA-DDT              PIC 9(07).
                        04      FNS-AA-DSEQ             PIC 9(04).
                03      FNS-AA-FILLER                   PIC X(17).
*> [C] [O] [Q] [R] [V] [g] [j]
        02      FNS-AC-KEY REDEFINES FNS-A-KEY.
*> .............病歷號碼
                03      FNS-AC-PAT                      PIC 9(08).
                03      FNS-AC-FILLER                   PIC X(32).
*> [E]
        02      FNS-AE-KEY REDEFINES FNS-A-KEY.
*> .............看診狀況
                03      FNS-AE-OK                       PIC X(01).
*> .............完成時間(倒序)
                03      FNS-AE-Y-DEC-DATE.
                        04      FNS-AE-Y-DEC-DT         PIC 9(07).
                        04      FNS-AE-Y-DEC-TIME       PIC 9(04).
*> .............門診序後(倒序)
                03      FNS-AE-DEC-RO-NO.
                        04      FNS-AE-DEC-RO-DT        PIC 9(07).
                        04      FNS-AE-DEC-RO-SEQ       PIC 9(04).
                03      FNS-AE-FILLER                   PIC X(17).
*> [G]
        02      FNS-AG-KEY REDEFINES FNS-A-KEY.
*> .............處方序號
                03      FNS-AG-ODR-NO.
                        04      FNS-AG-INS-DATE         PIC 9(07).
                        04      FNS-AG-ODR-SEQ          PIC 9(04).
*> .............住院序號
                03      FNS-AG-IPD-NO.
                        04      FNS-AG-IPD-DATE         PIC 9(07).
                        04      FNS-AG-IPD-SEQ          PIC 9(04).
                03      FNS-AG-FILLER                   PIC X(18).
*>
*> NOTE : [H]及[J]KEY的排列及長度要一樣, 因患者點選查詢程式是共用的！
*>
*> [H][Z]
        02      FNS-AH-KEY REDEFINES FNS-A-KEY.
*> .............[1]職能 [2]語言 [3]物理
                03      FNS-AH-DEPT                     PIC X(01).
*> .............[H]已開立治療項目 [ /Y]
*> .............[Z]已執行治療 [ /Y]
                03      FNS-AH-OK                       PIC X(01).
                03      FNS-AH-FILLER                   PIC X(38).
*> [J]

        02      FNS-AJ-KEY REDEFINES FNS-A-KEY.
*> .............[1]職能 [2]語言 [3]物理
                03      FNS-AJ-DEPT                     PIC X(01).
*> .............已開立治療項目 [ /Y]
                03      FNS-AJ-OK                       PIC X(01).
                03      FNS-AJ-FILLER                   PIC X(38).
*> [N]
        02      FNS-AN-KEY REDEFINES FNS-A-KEY.
                03      FNS-AN-DATE                     PIC 9(07).
                03      FNS-AN-FILLER                   PIC X(33).
*> [P]
        02      FNS-AP-KEY REDEFINES FNS-A-KEY.
                03      FNS-AP-UPD-DATE                 PIC 9(07).
                03      FNS-AP-RO-NO.
                        04      FNS-AP-RO-DT            PIC 9(07).
                        04      FNS-AP-RO-SEQ           PIC 9(04).
                03      FNS-AP-UPD-TIME                 PIC 9(06).
                03      FNS-AP-FILLER                   PIC X(16).
*> [X]
        02      FNS-AX-KEY REDEFINES FNS-A-KEY.
                03      FNS-AX-PAT                      PIC 9(08).
*> 處方日 (倒序)
                03      FNS-AX-DEC-ODR-DT               PIC 9(07).
                03      FNS-AX-FILLER                   PIC X(25).
*> [Y]
        02      FNS-AY-KEY REDEFINES FNS-A-KEY.
*> .............病歷號碼
                03      FNS-AY-PAT                      PIC 9(08).
*> .............科別
                03      FNS-AY-DPT                      PIC X(04).
*> .............建檔日
                03      FNS-AY-CDATE                    PIC 9(07).
*> .............建檔時間
                03      FNS-AY-CTIME                    PIC 9(06).
                03      FNS-AY-FILLER                   PIC X(15).
*> [a]
        02      FNS-AA1-KEY REDEFINES FNS-A-KEY.
*> .............病歷號碼
                03      FNS-AA1-PAT                     PIC 9(08).
*> .............疫苗種類
                03      FNS-AA1-INJ-KIND                PIC X(06).
                03      FNS-AA1-FILLER                  PIC X(26).
*> [b] --- 會診簡訊通知、回覆
        02      FNS-AB1-KEY REDEFINES FNS-A-KEY.
                03      FNS-AB1-KEY-1.
*> .............會診簡訊處理時點
                        04      FNS-AB1-TRN-DATE        PIC 9(07).
                        04      FNS-AB1-TRN-TIME        PIC 9(06).
*> .............會診簡訊通知 [A]、會診簡訊回覆 [B]、會診簡訊通知取消 [C]、會診簡訊回覆取消 [D]
                        04      FNS-AB1-CLS-ID          PIC X(01).
                        04      FNS-AB1-FILLER          PIC X(26).
*> [d] 山地離島同療 (副KEY1 病歷號碼 + 卡序 + 當次門診序號倒序)
        02      FNS-DD-KEY REDEFINES FNS-A-KEY.
*> .............病歷號碼
                03      FNS-DD-PAT-NO                   PIC 9(08).
*> .............同療卡號
                03      FNS-DD-INS-NO                   PIC X(04).

*> .............當次門診序號(倒序)
                03      FNS-DD-DNO.
                        04      FNS-DD-DDT              PIC 9(07).
                        04      FNS-DD-DSEQ             PIC 9(04).
                03      FNS-DD-FILLER                   PIC X(17).
*> [f] --- 患者藥品成份過敏記錄
        02      FNS-AF1-KEY REDEFINES FNS-A-KEY.
*> .............藥品成份名(前40字)
                03      FNS-AF1-FACTOR                  PIC X(40).
*> [h] --- 子抹提示註記
        02      FNS-AH1-KEY REDEFINES FNS-A-KEY.
*> .............病歷號碼
                03      FNS-AH1-PAT                     PIC 9(08).
*> .............門診日期
                03      FNS-AH1-DT                      PIC 9(07).
                03      FNS-AH1-FILLER                  PIC X(25).
*> [i] 98.07.10 整合照護醫師
        02      FNS-AI1-KEY REDEFINES FNS-A-KEY.
*> .............整合照護醫師代碼
                03      FNS-AI1-DR-NO                   PIC X(04).
                03      FNS-AI1-FILLER                  PIC X(36).
*> [l] 台大雲林-急診轉待床時間統計記錄 (99.06.15)
        02      FNS-AL1-KEY REDEFINES FNS-A-KEY.
                03      FNS-AL1-DPT                     PIC X(04).
                03      FNS-AL1-FILLER                  PIC X(36).
*> [u] 聖母-過敏用藥刪除原因
        02      FNS-AU1-KEY REDEFINES FNS-A-KEY.
*> .............異動者
                03      FNS-AU1-USER-ID                 PIC X(05).
*> .............異動日期(倒序)
                03      FNS-AU1-DT-DEC                  PIC 9(07).
*> .............異動時間(倒序)
                03      FNS-AU1-TIME-DEC                PIC 9(06).
*> .............預留
                03      FNS-AU1-FILLER                  PIC X(22).
*> [w] 住院醫令護理站表單傳送log 107.01.05
        02      FNS-AW1-KEY REDEFINES FNS-A-KEY.
*> .............RNU取號or QUE表序號(流水號)
                03      FNS-PW1-IBG-SEQ                 PIC 9(10).

                03      FNS-PW1-FILLER                  PIC X(30).
*> [y] 桃園-癌症外科手術副作用提示紀錄檔
        02      FNS-AY1-KEY REDEFINES FNS-A-KEY.
*> .............病歷號
                03      FNS-AY1-PAT-NO                  PIC 9(08).
*> .............實際離院日
                03      FNS-AY1-IPD-LEAVE-DT            PIC 9(07).
*> .............預留
                03      FNS-AY1-FILLER                  PIC X(25).
*> [z] 桃園-處方醫令孕安警示增修 (107.08.27) (業107012902) (DM1801-J1800319)
        02      FNS-AZ1-KEY REDEFINES FNS-A-KEY.
*> .........病歷號碼
                03  FNS-AZ1-PAT-NO                      PIC 9(08).
*> .........藥局 : 處理回覆日期
                03      FNS-AZ1-UNLOCK-DATE             PIC 9(07).
*> .........預留
                03      FNS-AZ1-FILLER                  PIC X(25).

*>********************************************************************
*>                          副  KEY2
*>********************************************************************
        02      FNS-B-KEY                               PIC X(40).
*> [E] [R]
        02      FNS-BE-KEY REDEFINES FNS-B-KEY.
*> .............病歷號碼
                03      FNS-BE-PAT-NO                   PIC 9(08).
*> .............門診序後(倒序)
                03      FNS-BE-DEC-RO-NO.
                        04      FNS-BE-DEC-RO-DT        PIC 9(07).
                        04      FNS-BE-DEC-RO-SEQ       PIC 9(04).
                03      FNS-BE-FILLER                   PIC X(21).
*> [H] 門診及住院醫令皆使用此代碼
*> [Z]
*> NOTE : 復健治療師開立治療項時, 就將以下資料搬入;
*>        否則醫師開立轉介時, 資料尚空白的
        02      FNS-BH-KEY REDEFINES FNS-B-KEY.
*> .............[1]職能 [2]語言 [3]物理
                03      FNS-BH-DEPT                     PIC X(01).
*> .............[H]治療處置開立日期倒序
*> .............[Z]治療處置執行日期倒序
                03      FNS-BH-OT-DT-DEC                PIC 9(07).
                03      FNS-BH-FILLER                   PIC X(32).
*> [Q] [V]
        02      FNS-BQ-KEY REDEFINES FNS-B-KEY.
*> .............病歷號碼
                03      FNS-BQ-PAT-NO                   PIC 9(08).
*> .............(倒序)(門診->門診序號) , (住院->處方序號)
                03      FNS-BQ-DEC-ODR-NO.
                        04      FNS-BQ-DEC-ODR-DATE     PIC 9(07).
                        04      FNS-BQ-DEC-ODR-SEQ      PIC 9(04).
                03      FNS-BQ-FILLER                   PIC X(21).
*> [S]
        02      FNS-BS-KEY REDEFINES FNS-B-KEY.
*> .............病歷號碼
                03      FNS-BS-PAT                      PIC 9(08).
*> .............健保科別
                03      FNS-BS-DPT                      PIC X(04).
*> .............處方結束日(倒序)
                03      FNS-BS-END-DT-DEC               PIC 9(07).
                03      FNS-BS-FILLER                   PIC X(21).
*> [X]
        02      FNS-BX-KEY REDEFINES FNS-B-KEY.
                03      FNS-BX-IDNO                     PIC X(10).
*> 處方日 (倒序)
                03      FNS-BX-DEC-ODR-DT               PIC 9(07).
                03      FNS-BX-FILLER                   PIC X(23).
*> [Y]
        02      FNS-BY-KEY REDEFINES FNS-B-KEY.
*> .............病歷號碼
                03      FNS-BY-PAT                      PIC 9(08).
*> .............建檔日期
                03      FNS-BY-CDATE                    PIC 9(07).
*> .............建檔時間
                03      FNS-BY-CTIME                    PIC 9(06).
                03      FNS-BY-FILLER                   PIC X(19).

*> [a]
        02      FNS-BA1-KEY REDEFINES FNS-B-KEY.
*> .............病歷號碼
                03      FNS-BA1-PAT                     PIC 9(08).
*> .............執行回次
                03      FNS-BA1-RUN                     PIC X(01).
                03      FNS-BA1-FILLER                  PIC X(31).
*> [b] --- 會診簡訊通知、回覆
        02      FNS-BB1-KEY REDEFINES FNS-B-KEY.
                03      FNS-BB1-KEY-1.
*> .............會診主檔主KEY (MET-SYS-KEY)
                        04      FNS-BB1-SYS-KEY         PIC X(21).
*> .............會診主檔主KEY (MET-NOT-NO)
                        04      FNS-BB1-NOT-NO          PIC X(11).
                        04      FNS-BB1-FILLER          PIC X(08).
*> [d] 山地離島同一療程 (副KEY2 第一次門診序號 + 當次門診序號)
        02      FNS-DE-KEY REDEFINES FNS-B-KEY.
*> .............同療第一次門診序號
                03      FNS-DE-1ST-RO-NO.
                        04      FNS-DE-1ST-RO-DT        PIC 9(07).
                        04      FNS-DE-1ST-RO-SEQ       PIC 9(04).
                03      FNS-DE-FILLER                   PIC X(29).
*> [g] --- 過敏用藥異動記錄
        02      FNS-BG1-KEY REDEFINES FNS-B-KEY.
*> .............異動者員工編號
                03      FNS-BG1-UPD-USR-ID              PIC X(05).
                03      FNS-BG1-FILLER                  PIC X(35).
*> [i] --- 98.12.30 整合照護 ---
        02      FNS-BI1-KEY REDEFINES FNS-B-KEY.
*>              整合照護日期
                03      FNS-BI1-CRE-DT                  PIC 9(07).
                03      FNS-BI1-DATA-FILLER             PIC X(33).
*> [u] 聖母-過敏用藥刪除原因
        02      FNS-BU1-KEY REDEFINES FNS-B-KEY.
*> .............異動日期(倒序)
                03      FNS-BU1-DT-DEC                  PIC 9(07).
*> .............異動時間(倒序)
                03      FNS-BU1-TIME-DEC                PIC 9(06).
*> .............預留
                03      FNS-BU1-FILLER                  PIC X(27).
*> =====================================================================
*>              資                              料
*> =====================================================================
*$XFD USE GROUP, VAR-LENGTH
        02      FNS-DATA                        PIC X(150).
*> .... [A]
        02      FNS-A-DATA REDEFINES FNS-DATA.
*> 科別
                03      FNS-A-DPT               PIC X(04).
                03      FNS-A-FILLER            PIC X(146).
*> .... [B]
        02      FNS-B-DATA REDEFINES FNS-DATA.
*> 體重
                03      FNS-B-WEI               PIC 9(03)V9.
*> 血壓
                03      FNS-B-BLD-PRE-1         PIC 9(03)V9.
                03      FNS-B-BLD-PRE-2         PIC 9(03)V9.

*> 體溫
                03      FNS-B-TEM               PIC 9(02)V9.
*> 特別門診 [1]初診 [2]複診
                03      FNS-B-ID                PIC X(01).
                03      FNS-B-FILLER            PIC X(134).
*> .... [C]
        02      FNS-C-DATA REDEFINES FNS-DATA.
*> 變更之醫師
                03      FNS-C-DR                PIC X(04).
*> 舊屬性
                03      FNS-C-OTYPE             PIC X(04).
*> 新屬性
                03      FNS-C-NTYPE             PIC X(04).
                03      FNS-C-FILLER            PIC X(138).
*> .... [D][F][I][M]
        02      FNS-D-DATA REDEFINES FNS-DATA.
                03      FNS-D-RMK               PIC X(70).
                03      FNS-D-FILLER            PIC X(80).
*> .... [G]
        02      FNS-G-DATA REDEFINES FNS-DATA.
*> 是否需產生領藥號 [Y] [N]
                03      FNS-G-PILL-CHK          PIC X(01).
*> ICA-EMG-CD
                03      FNS-G-ICA-EMG-CD        PIC X(01).
*> ICA-DR-YN
                03      FNS-G-ICA-DR-YN         PIC X(01).
*> W-MED-CHK
                03      FNS-G-W-MED-CHK         PIC X(01).
*> 呼叫 HIPILLCF 回傳值1
                03      FNS-G-W-PILLCF-YN1      PIC X(01).
*> 處方檔回寫狀態1
                03      FNS-G-ICA-MST-STATUS1   PIC X(02).
                03      FNS-G-QUE-PILL-NO1      PIC X(04).
*> 呼叫 HIPILLCF 回傳值2
                03      FNS-G-W-PILLCF-YN2      PIC X(01).
*> 處方檔回寫狀態2
                03      FNS-G-ICA-MST-STATUS2   PIC X(02).
                03      FNS-G-QUE-PILL-NO2      PIC X(04).
*> PRS-FEE-KND
                03      FNS-G-PRS-FEE-KND-TBL.
                        04      FNS-G-PRS-FEE-KND OCCURS 60 TIMES PIC X(01).
*> W-FEE-KND
                03      FNS-G-FEE-KND-TBL.
                        04      FNS-G-FEE-KND OCCURS 60 TIMES PIC X(01).
                03      FNS-G-FILLER            PIC X(12).
*>
*> NOTE : [H]及[J]的排列及長度要一樣, 因患者點選查詢程式是共用的！
*>
*> .....[H]
        02      FNS-H-DATA REDEFINES FNS-DATA.
*> (DR.)轉介日期
                03      FNS-H-REF-DT            PIC 9(07).
*> (DR.)轉介時間
                03      FNS-H-REF-TIME          PIC 9(06).
*> 轉介醫師
                03      FNS-H-DR                PIC X(04).
*> 病歷號碼

                03      FNS-H-PAT-NO            PIC 9(08).
*> 治療師開立處置日期
                03      FNS-H-OT-DT             PIC 9(07).
                03      FNS-H-FILLER            PIC X(118).
*> .....[J]
        02      FNS-J-DATA REDEFINES FNS-DATA.
*> (DR.)轉介日期
                03      FNS-J-REF-DT            PIC 9(07).
*> (DR.)轉介時間
                03      FNS-J-REF-TIME          PIC 9(06).
*> 轉介醫師
                03      FNS-J-DR                PIC X(04).
*> 病歷號碼
                03      FNS-J-PAT-NO            PIC 9(08).
*> 治療師開立處置日期
                03      FNS-J-OT-DT             PIC 9(07).
                03      FNS-J-FILLER            PIC X(118).
*>......[L]
        02      FNS-L-DATA REDEFINES FNS-DATA.
*> 類別代號
                03      FNS-L-6119-TBL.
                        04      FNS-L-6119-ID OCCURS 50 TIMES PIC X(02).
                03      FNS-L-FILLER            PIC X(50).
*> .....[N]
        02      FNS-N-DATA REDEFINES FNS-DATA.
*> 線路編號
                03      FNS-N-PC-NO             PIC 9(03).
*> 鎖檔發生日期 (系統日期)
                03      FNS-N-LOCK-DT           PIC 9(07).
*> 鎖檔發生時間 (系統時間)
                03      FNS-N-LOCK-TIME.
                        04  FNS-N-LOCK-HH       PIC 99.
                        04  FNS-N-LOCK-MT       PIC 99.
                        04  FNS-N-LOCK-SS       PIC 99.
                03      FNS-N-FILLER            PIC X(134).
*>......[N]
        02      FNS-N2-DATA REDEFINES FNS-DATA.
*> 來源程式
                03      FNS-N-CALL-FROM         PIC X(10).
*> 表單序號
                03      FNS-N-NUM               PIC 9(10).
*> 狀況碼說明
                03      FNS-N-ERR.
                        04      FNS-N-ERR-FS    PIC X(08).
                        04      FNS-N-ERR-TEXT  PIC X(40).
                03      FNS-N2-FILLER           PIC X(82).
*> .....[O]
        02      FNS-O-DATA REDEFINES FNS-DATA.
*> 錯誤資料
                03      FNS-O-REC               PIC X(150).
*> .....[P]
        02      FNS-P-DATA REDEFINES FNS-DATA.
*> [1]新增 [2]修改 [3]刪除
                03      FNS-P-ID                PIC X(01).
                03      FNS-P-FILLER            PIC X(149).
*> .....[Q]
        02      FNS-Q-DATA REDEFINES FNS-DATA.

*> [Y]外院檢查
                03      FNS-Q-OUT               PIC X(01).
*> 處置代碼
                03      FNS-Q-MST-ID            PIC X(09).
*> 健保代碼
                03      FNS-Q-INS-ID            PIC X(16).
*> 建檔者
                03      FNS-Q-CRE-USER          PIC X(05).
                03      FNS-Q-FILLER            PIC X(119).
*> .....[S]
        02      FNS-S-DATA REDEFINES FNS-DATA.
                03      FNS-S-PHA-DAY           PIC 9(02).
                03      FNS-S-TIMES             PIC 9.
                03      FNS-S-END-DT            PIC 9(07).
                03      FNS-S-FILLER            PIC X(140).
*> .....[T]
        02      FNS-T-DATA REDEFINES FNS-DATA.
                03      FNS-T-SEQ               PIC 9(06).
                03      FNS-T-FILLER            PIC X(144).
*> .....[U]
        02      FNS-U-DATA REDEFINES FNS-DATA.
                03      FNS-U-RO-NO.
                        04      FNS-U-RO-DT     PIC 9(07).
                        04      FNS-U-RO-SEQ    PIC 9(04).
                03      FNS-U-FILLER            PIC X(139).
*> .....[V]
        02      FNS-V-DATA REDEFINES FNS-DATA.
*> 吸菸否 [Y/N]
                03      FNS-V-SMK               PIC X(01).
*> 戒菸成功否 [Y/ ] (提示後四個月再詢問時所回答)
                03      FNS-V-SUCE              PIC X(01).
*> 戒菸未返診通知方式 (電子郵件為'1',電話外撥為'2',手機簡訊為'3')
                03      FNS-V-TEL-WAY           PIC X(01).
*> 戒菸未返診通知日期
                03      FNS-V-TEL-DATE          PIC 9(07).
*> 戒菸未返診通知時間
                03      FNS-V-TEL-TIME          PIC 9(04).
                03      FNS-V-FILLER            PIC X(136).
*> .....[X] --- 肺炎雙球菌疫苗
        02      FNS-X-DATA REDEFINES FNS-DATA.
                03      FNS-Q1-YN               PIC X(01).
                03      FNS-Q2-YN               PIC X(01).
                03      FNS-Q3-YN               PIC X(01).
                03      FNS-Q4-YN               PIC X(01).
                03      FNS-Q5-YN               PIC X(01).
                03      FNS-Q6-YN               PIC X(01).
                03      FNS-Q7-YN               PIC X(01).
                03      FNS-Q8-YN               PIC X(01).
                03      FNS-Y-FILLER            PIC X(142).
*> .....[Y]
        02      FNS-Y-DATA REDEFINES FNS-DATA.
                03      FNS-Y-DR                PIC X(04).
                03      FNS-Y-FILLER            PIC X(146).
*> .....[Z]
        02      FNS-Z-DATA REDEFINES FNS-DATA.
*> 病歷號碼
                03      FNS-Z-PAT-NO            PIC 9(08).

*> 治療師執行日期
                03      FNS-Z-OT-DT             PIC 9(07).
*> 治療師代碼
                03      FNS-Z-OT-USER           PIC X(05).
                03      FNS-Z-FILLER            PIC X(130).
*> .....[a]
        02      FNS-A1-DATA REDEFINES FNS-DATA.
*> 大便卡篩檢結果 (N:正常 , A:不正常 , U:不知道或不確定)
                03      FNS-A1-STL-RST          PIC X(01).
*> 就診日期時間
                03      FNS-A1-DT-TM            PIC 9(13).
*> 處置序號
                03      FNS-A1-FEE-NO           PIC 9(03).
                03      FNS-A1-FILLER           PIC X(133).
*> [b] --- 會診簡訊通知、回覆、會診簡訊通知取消、回覆取消
        02      FNS-B1-DATA REDEFINES FNS-DATA.
*> .............會診病患病歷號碼 1:8
                03      FNS-B1-PAT-NO           PIC 9(08).
*> .............發出通知的醫師、發出回覆的醫師、發出通知取消的醫師、發出回覆取消的醫師 9:4
                03      FNS-B1-SEND-DR-NO       PIC X(04).
*> .............接收通知的科別、接收回覆的科別、接收通知取消的科別、接收回覆取消的科別 13:4
                03      FNS-B1-RECV-IP-DPT      PIC X(04).
*> .............接收通知的醫師、接收回覆的醫師、接收通知取消的醫師、接收回覆取消的醫師 17:4
                03      FNS-B1-RECV-DR-NO       PIC X(04).
*> .............會診簡訊傳送錯誤碼 21:1
                03      FNS-B1-ERR-ID           PIC X(01).
*> .............會診種類 [1]急會診 [2]一般會診
                03      FNS-B1-MET-ID           PIC X(01).
*> .............病患姓名 107.01.03 (23:12)
                03      FNS-B1-PAT-NM           PIC X(12).
*> .............病床號 107.01.03   (35:6)
                03      FNS-B1-BED              PIC X(06).
                03      FNS-B1-DATA-FILLER      PIC X(110).
*> [c] --- 住院醫令表傳送寫檔錯誤記錄
        02      FNS-C1-DATA REDEFINES FNS-DATA.
*> .............寫檔狀態
                03      FNS-C1-STATUS           PIC X(60).
                03      FNS-C1-DATA-FILLER      PIC X(90).
*> [d] --- 山地離島同一療程DATA
        02      FNS-D1-DATA REDEFINES FNS-DATA.
*> .............原始科別
                03      FNS-D1-DPT-NO           PIC X(04).
*> .............同療序號
                03      FNS-D1-INS-SEQ          PIC 9(02).

                03      FNS-D1-DATA-FILLER      PIC X(144).
*> [f] --- 患者藥品成份過敏記錄
        02      FNS-F1-DATA REDEFINES FNS-DATA.
*> .............成份名(全長)
                03      FNS-F1-FACTOR-NAME      PIC X(50).
                03      FNS-F1-DATA-FILLER      PIC X(100).
*> [h] --- 子抹提示註記
        02      FNS-H1-DATA REDEFINES FNS-DATA.
                03      FNS-H1-DIS-MRK          PIC X(01).
                03      FNS-H1-DATA-FILLER      PIC X(149).
*> [i] --- 整合照護醫師
        02      FNS-I1-DATA REDEFINES FNS-DATA.

*>              結束日
                03      FNS-I1-END-DT           PIC 9(07).
*>              建檔者
                03      FNS-I1-CRE-USER         PIC X(05).
*>              建檔日
                03      FNS-I1-CRE-DT           PIC 9(07).
*>              建檔時間
                03      FNS-I1-CRE-TI           PIC 9(04).
*>              異動者
                03      FNS-I1-MOD-USER         PIC X(05).
*>              異動日
                03      FNS-I1-MOD-DT           PIC 9(07).
*>              異動時間
                03      FNS-I1-MOD-TI           PIC 9(04).
                03      FNS-I1-DATA-FILLER      PIC X(111).
*> [l] 台大雲林-急診轉待床時間統計記錄 (99.06.15)
        02      FNS-L1-DATA REDEFINES FNS-DATA.
                03      FNS-L1-WAIT-DT.
                        05 FNS-L1-WAIT-DATE             PIC 9(07).
                        05 FNS-L1-WAIT-TIME             PIC 9(06).
                03      FNS-L1-TRNS-DT.
                        05 FNS-L1-TRNS-DATE             PIC 9(07).
                        05 FNS-L1-TRNS-TIME             PIC 9(06).
                03      FNS-L1-FILLER                   PIC X(124).
*> [m] emr加tag
        02      FNS-M1-DATA REDEFINES FNS-DATA.
                03      FNS-M1-RESULT                   PIC X(60).
                03      FNS-M1-FILLER                   PIC X(90).
*> [n] 99.10.29 新生兒胞胎註記
        02      FNS-N1-DATA REDEFINES FNS-DATA.
*--------------->性別
                03      FNS-N1-PAT-SEX                  PIC 9(01).
*--------------->新生兒胞胎註記
                03      FNS-N1-MUTI-BN-MRK              PIC 9(01).
*--------------->新生兒就醫註記
                03      FNS-N1-BN-CUR-MRK               PIC X(01).
                03      FNS-N1-FILLER                   PIC X(147).

*> [o] 過敏用藥特殊註記改GRID-104.03.13.GD4-EVENT段落
        02      FNS-O1-DATA REDEFINES FNS-DATA.
*>              過敏用藥特殊註記
                03  FNS-O1-RMK                          PIC X(60).
                03  FNS-O1-FILLER                       PIC X(90).
*> [p] 104.06.08聖母-過敏處置過敏反應及嚴重度
        02      FNS-P1-DATA REDEFINES FNS-DATA.
*>              嚴重度
                03      FNS-P1-LEVEL                    PIC X(01).
*>              過敏反應
                03      FNS-P1-ADR                      PIC X(60).
*>              相關性
                03      FNS-P1-CORRELATION              PIC X(01).
*>              預留
                03      FNS-P1-FILLER                   PIC X(88).
*> [q] 104.06.08聖母-過敏藥物開立原因
        02      FNS-Q1-DATA REDEFINES FNS-DATA.
*>              原因代碼
                03      FNS-Q1-REA-NO                   PIC X(05).

*>              自述原因
                03      FNS-Q1-REA-DATA                 PIC X(60).
                03      FNS-Q1-FILLER                   PIC X(85).
*> [r] 104.06.08聖母-顯影劑過敏記錄(已停用)
        02      FNS-R1-DATA REDEFINES FNS-DATA.
*>              處置代碼
                03      FNS-R1-PRS-ID                   PIC X(09).
                03      FNS-R1-FILLER                   PIC X(141).
*> [s] 105.05.10 ATC CODE過敏記錄(聖母、茂盛醫院使用)
        02      FNS-S1-DATA REDEFINES FNS-DATA.
*> 建檔日期
                03      FNS-S1-CRE-DATE                 PIC 9(07).
*> 建檔人員
                03      FNS-S1-CRE-USER-ID              PIC X(05).
*> 過敏藥品名稱
                03      FNS-S1-PRS-NAME                 PIC X(40).
*> 預留
                03      FNS-S1-FILLER                   PIC X(98).
*> [t] 105.10.05 ATC CODE過敏記錄異動(聖母、茂盛醫院使用)
        02      FNS-T1-DATA REDEFINES FNS-DATA.
*> 異動人員
                03      FNS-T1-USID                     PIC X(05).
*> [M]異動 [D]刪除
                03      FNS-T1-ID                       PIC X(01).
*> NKA
                03      FNS-T1-NKA                      PIC X(01).
*> 建檔時間
                03      FNS-T1-CRE-DATE                 PIC 9(07).
*> 建檔人員
                03      FNS-T1-CRE-USER-ID              PIC X(05).
*> 過敏藥品名稱
                03      FNS-T1-PRS-NAME                 PIC X(40).
*> 預留
                03      FNS-T1-FILLER                   PIC X(91).
*> [u] 聖母-過敏用藥刪除原因
        02      FNS-U1-DATA REDEFINES FNS-DATA.
*> 刪除內容
                03      FNS-U1-DEL-DETAIL               PIC X(60).
*> 原因代碼
                03      FNS-U1-REA-NO                   PIC X(05).
*> 自述原因
                03      FNS-U1-REA-DETAIL               PIC X(60).
*> 預留
                03      FNS-U1-FILLER                   PIC X(25).
*> [v] 過敏用藥提示日期
        02      FNS-V1-DATA REDEFINES FNS-DATA.
*> 勾選 [A]NKA [B]不知
                03      FNS-V1-REA-NO                   PIC X(01).
*> 提示日期
                03      FNS-V1-DATE                     PIC 9(07).
*> 預留
                03      FNS-V1-FILLER                   PIC X(142).
*> [w] 住院醫令護理站表單傳送log 107.01.05
        02      FNS-W1-DATA REDEFINES FNS-DATA.
*>              程式段落說明
                03      FNS-W1-FUNC-NM                  PIC X(40).
*>              狀態

                03      FNS-W1-FILE-ST                  PIC 9(02).
                03      FNS-W1-FILLER                   PIC X(108).
*> [x] 豐原-自助繳費機列印條碼紀錄檔
        02      FNS-X1-DATA REDEFINES FNS-DATA.
*> 科別
                03      FNS-X1-DPT                      PIC X(04).
*> 身分
                03      FNS-X1-CLA                      PIC X(04).
*> 存檔日期
                03      FNS-X1-UPD-DATE                 PIC 9(07).
*> 存檔時間
                03      FNS-X1-UPD-TIME                 PIC 9(08).
*> 預留
                03      FNS-X1-FILLER                   PIC X(127).
*> [y] 桃園-癌症外科手術副作用提示紀錄檔
        02      FNS-Y1-DATA REDEFINES FNS-DATA.
*> .............診斷代碼
                03      FNS-Y1-ODZ-TBL.
                        04      FNS-Y1-ODZ-GPR OCCURS 3 TIMES.
                                05 FNS-Y1-ICD10-CODE    PIC X(12).
*> .............處置代碼
                03      FNS-Y1-FEE-PRS                  PIC X(09).
*> .............提示次數
                03      FNS-Y1-PROMPT-TIMES             PIC 9(02).
*> .............科別
                03      FNS-Y1-DPT                      PIC X(04).
*> .............主治醫師
                03      FNS-Y1-DR-NO                    PIC X(04).
*> .............癌別
                03      FNS-Y1-CANCER-ID                PIC X(04).
*> .............預留
                03      FNS-Y1-FILLER                   PIC X(91).
*> .... [z] 桃園-處方醫令孕安警示增修 (107.08.27) (業107012902) (DM1801-J1800319)
        02      FNS-Z1-DATA REDEFINES FNS-DATA.
*> .........醫令 : 開立時間
                03              FNS-PZ1-CRE-TIME.
                                04      FNS-PZ1-CRE-TIME-HH     PIC 9(02).
                                04      FNS-PZ1-CRE-TIME-MM     PIC 9(02).
                                04      FNS-PZ1-CRE-TIME-SS     PIC 9(02).
*>      ........藥局 : 處理回覆藥師員工代碼
                03      FNS-Z1-UNLOCK-PHA               PIC X(05).
*>      ........藥局 : 處理回覆時間
                03      FNZ-Z1-UNLOCK-TIME.
                        04      FNS-Z1-UNLOCK-HH        PIC 9(02).
                        04      FNS-Z1-UNLOCK-MM        PIC 9(02).
                        04      FNS-Z1-UNLOCK-SS        PIC 9(02).
*>  ........藥局 : 處理回覆結果 [Y/同意開立] [N/不同意開立]
                        04      FNS-Z1-CRE-YN           PIC X(01).
*>  預留
                03      FNS-Z1-FILLER                   PIC X(132).
*> [1] 2021/03/19 配合emr調整傳送識別(配合哲緯) - 瑋育
        02      FNS-11-DATA REDEFINES FNS-DATA.
*>              完成註記
                03      FNS-11-MARK                     PIC X(01).
*>              異動日期
                03      FNS-11-MOD-DATE                 PIC 9(07).
*>              異動時間

                03      FNS-11-MOD-TIME.
                        04      FNS-11-MOD-HH           PIC 9(02).
                        04      FNS-11-MOD-MM           PIC 9(02).
                        04      FNS-11-MOD-SS           PIC 9(02).
*>  預留
                03      FNS-11-FILLER                   PIC X(136).
*>  [3] 新冠病毒檢驗試劑專案製造/輸入核准【核酸試劑】之「健保碼」
        02      FNS-3-DATA REDEFINES FNS-DATA.
*>  ........建檔來源 [T]檢驗報告登錄 [C]IC卡轉檔
                        03      FNS-3-CRE-FROM                                          PIC X(01).
*>      ........核酸試劑健保碼
                        03      FNS-3-A91-SUPPLEMENT                    PIC X(100).
                        03      FNS-3-DATA-FILLER                                       PIC X(49).
*> ======================================================================== <
*> [A] 患者歷次醫令 (依健保科)                          　.....執行醫令切檔
*> [B] 特殊門診記錄 (性防所使用)
*> [C] 變更屬性轉會診記錄                               　.....執行醫令切檔
*> [D] 處方備註(線上目前不使用)                         　.....執行醫令切檔
*> [E] 患者歷次急診                                     　.....執行醫令切檔
*> [F] 患者特殊標註 (特註)                                .....不可刪除不需切檔
*> [G] 住院醫令使用-處方領藥號異常LOG                   　.....執行醫令日結時刪除
*> [H] 門診轉介復健                                       .....執行醫令切檔
*> [I] 門診轉介復健 (注意事項)                          　.....執行醫令切檔
*> [J] 住院轉介復健                                     　.....執行醫令切檔
*> [K] 住院轉介復健 (注意事項)                          　.....執行醫令切檔
*> [L] 出院病歷摘要細項記錄檔(93.1.19)
*> [M] 永久病史                                           .....不可刪除不需切檔
*> [N] 醫師排班檔使用中線路                               .....GUI已不會再產生
*> [N] 住院醫令使用-護理站表單傳送取號LOG               　.....執行醫令日結時刪除
*> [O] 急診病例通報錯誤資料記錄(93.5.5)
*> [P] 電子病歷批次處理記錄
*> [Q] 子宮頸抹片記錄檔 (93.08.13)
*> [R] 成人預防保健記錄檔 (94.02.24)
*> [S] 慢性病連續處方箋開立記錄 (94.03.12)　              .....執行醫令日結時刪除
*> [T] 轉診XML單位流水號(94.3.28)
*> [U] 患者歷次看診健保科別 (一個健保科別僅留一筆) (2005/4/23 04:18下午) .....不可刪除不需切檔
*> [V] 戒煙提示記錄 (94.05.04)
*> [W] 住院醫令子宮頸提示記錄 (住院序號為主)
*> [X] 肺炎雙球菌開立記錄 (資料保留五年, 暫不寫切檔程式) (2005/9/12 03:42下午)
*> [Y] 手繪圖記錄 (2005/10/5 02:12下午)                   .....作廢！ 不會產生資料
*> [Z] 門診復健執行確認名單 (S401-94041301)
*> [a] 新生兒大便卡篩檢記錄
*> [b] 會診簡訊通知、回覆、會診簡訊通知取消、回覆取消 (96.03.05)
*> [c] 住院醫令表傳送寫檔錯誤記錄 (97.8.27)-基隆
*> [d] 山地離島同一療程需求(98.01.20)
*      主KEY : 當次門診序號
*      副KEY1: 病歷號碼 + 卡序 + 當次門診序號倒序
*      副KEY2: 第一次門診序號  + 當次門診序號
*> [f] 患者藥品成份過敏記錄 (98.04.16)
*> [g] 過敏用藥異動記錄
*> [h] 子抹提示註記(北市-計算子抹提示次數(目前僅門診)
*> [i] 台中整合照護醫師(暫存)
*> [j] IC卡欠卡記錄 (扣完卡即刪除)
*> [k] (北市)精神科病患名單
*> [l] 台大雲林-急診轉待床時間統計記錄 (99.06.15)
*> [m] 理學檢查結果(99.09.23)                           ......不可刪除不需切檔
*> [n] 新生兒胞胎註記 99.10.29

*> [o] 過敏用藥特殊註記改GRID-104.03.13.GD4-EVENT段落
*> [p] 聖母-過敏處置過敏反應及嚴重度(104.06.08)
*> [q] 聖母-過敏藥物開立原因(104.06.08)
*> [r] 聖母-顯影劑過敏記錄(104.06.08)(已停用)
*> [s] ATC CODE過敏記錄(聖母、茂盛醫院使用)(105.05.10)
*> [t] ATC CODE過敏記錄異動(聖母、茂盛醫院使用)(105.10.05)
*> [u] 聖母-過敏用藥刪除原因(106.07.11)
*> [v] 過敏用藥醫令提示日期(106.10.27)(E005286)
*> [w] 豐原-住院醫令護理站表單傳送log(107.01.05)
*> [x] 豐原-自助繳費機列印條碼紀錄檔(107.01.25)(業106062202)
*> [y] 桃園-癌症外科手術副作用提示紀錄檔(107.04.10)(業106101801)
*> [z] 桃園-處方醫令孕安警示增修 (107.08.27) (業107012902) (DM1801-J1800319)
*> [1] 配合emr調整傳送識別 - 瑋育 (110.03.19)
*> [2] 配合emr調整傳送識別 - 瑋育 (110.03.19)
*> [3] 新冠病毒檢驗試劑專案製造/輸入核准【核酸試劑】之「健保碼」  (110.08.02)
*> ======================================================================== <
*COPY    "HR_DTA.MST".
*---------------------------------------------------------------------*
* 檢驗取消處方檔：HR_DTA.MST                          檔案：HR_MDTA   *
*---------------------------------------------------------------------*
* 主：HRDTA-MST-KEY  = HRDTA-KEY                                      *
*---------------------------------------------------------------------*
 FD      HRDTA-MST       EXTERNAL.
 01      HRDTA-MST-REC.
* KEY 值 = 住院序號 + 檢驗取消日期 + 檢驗取消流水號
*$XFD USE GROUP
        02 HRDTA-KEY.
*住院序號
                03 HRDTA-IPD-NO.
*住院日期
                        04 HRDTA-IPD-DATE       PIC 9(07).
*住院流水號
                        04 HRDTA-IPD-SEQ        PIC 9(04).
                03 HRDTA-ODR-NO.
*檢驗取消日期
                        04 HRDTA-INS-DATE       PIC 9(07).
*檢驗取消流水號
                        04 HRDTA-ODR-SEQ        PIC 9(06).
*$XFD USE GROUP,VAR-LENGTH
        02 HRDTA-GROUP-DATA1.
*檢驗取消登錄醫師
                03 HRDTA-DR-NO                  PIC X(04).
*檢驗取消登錄者
                03 HRDTA-USR-ID                 PIC X(05).
*處方建檔日
                03 HRDTA-CRE-DT                 PIC 9(07).
                03 HRDTA-CRE-TIME.
                        04 HRDTA-CRE-HH         PIC 9(02).
                        04 HRDTA-CRE-MM         PIC 9(02).
                        04 HRDTA-CRE-SS         PIC 9(02).
*>由此開始共１５０長
                03 HRDTA-FILLER                 PIC X(150).
***********************************************************************
* END *
***********************************************************************
*COPY    "HR_DTB.MST".
*---------------------------------------------------------------------*

* 檢驗取消細項檔：HR_DTB.MST                          檔案：HR_MDTB   *
*---------------------------------------------------------------------*
* 主：HRDTB-MST-KEY  = HRDTB-KEY + HRDTB-FEE-SEQ                      *
*---------------------------------------------------------------------*
 FD      HRDTB-MST       EXTERNAL.
 01      HRDTB-MST-REC.
* KEY 值 = 住院序號 + 檢驗取消日期 + 檢驗取消流水號 + 處置流水號
*$XFD USE GROUP
        02 HRDTB-KEY.
*住院序號
                03 HRDTB-IPD-NO.
*住院日期
                        04 HRDTB-IPD-DATE       PIC 9(07).
*住院流水號
                        04 HRDTB-IPD-SEQ        PIC 9(04).
                03 HRDTB-ODR-NO.
*檢驗取消日期
                        04 HRDTB-INS-DATE       PIC 9(07).
*檢驗取消流水號
                        04 HRDTB-ODR-SEQ        PIC 9(06).
*處置流水號
        02 HRDTB-FEE-SEQ                        PIC 9(03).
*$XFD USE GROUP,VAR-LENGTH
        02 HRDTB-GROUP-DATA1.
*處置代碼
                03 HRDTB-FEE-KEY                PIC X(09).
*總量
                03 HRDTB-RX-QTY.
*總量分子
                        04 HRDTB-RX-QTY1        PIC 9(04).
*總量分母
                        04 HRDTB-RX-QTY2        PIC 9(02).
*檢驗單號
                03 HRDTB-CHK-NO.
*檢驗檢查類別代號
                        04 HRDTB-CLS-NO.
*檢驗檢查科室簡碼
                                05 HRDTB-DPT-CD PIC X(1).
*檢驗檢查類別碼
                                05 HRDTB-CLS-CD PIC X(2).
*開單流水碼
                        04 HRDTB-PR-SEQ         PIC 9(5).
*醫令日期
                03 HRDTB-IP-DATE                PIC 9(7).
*由此開始共１５０長
*處方序號
                03 HRDTB-ICA-ODR-NO             PIC X(11).
*檢驗檢查項目代碼(HTCHK-ITM-CD)
                03 HRDTB-ICB-ITM-CD             PIC X(6).
*
                03 HRDTB-FILLER                 PIC X(133).
***********************************************************************
* END *
***********************************************************************

*------->檢驗檢查放射線檔!
*COPY    "HT_SYS.SON".

*************
* C-PY FILE : HT_SYS.SON    85/12/17    作者：謝枝財
* HT_SSYS LENGTH 100 BYTES  86/02/13    檢驗檢查系統鍵值檔
*************
 FD HTSYS-SON IS EXTERNAL.
 01 HTSYS-SON-REC.
*$XFD USE GROUP, VAR-LENGTH
   02 HTSYS-KEY.
      03 HTSYS-FIL-SW                   PIC X(1).
**       主檔識別碼
      03 HTSYS-KEY-SW                   PIC X(1).
**       鍵值識別碼
      03 HTSYS-KEY-DATA                 PIC X(98).
**       鍵值內容
*COPY    "HT_DPT.MST".
* ==SCL== 2004.03.09 START ----- 報告字型大小設定 ---------------------------- *

* ==SCL== 2004.03.08 START ----- 報告列印CTRL + Y 門診、住院列印張數設定 ----- *
* >

* ==SCL== 2004.01.13 START ----- 報告列印時左列空白格數 ---------------------- *
* ==SCL== 2002.11.09 START ----- 醫令單備註是否放大 -------------------------- *
* 現在只開放細項備註 設定
* 程式已完成，只需開放設定就可以選擇細項備註(I),類別備註(C),兩者皆放大(A)
* ==SCL== 2002.10.30 START ----- PACS整合，醫令單印PACS工作序號 -------------- *
* ==SCL== 2002.07.28 START ----- 借片預定借閱天數設定  ----------------------- *
*************
* C-PY FILE : HT_DPT.MST    84/03/23    作者：謝枝財
* HT_MDPT LENGTH 100 BYTES  90/01/05    檢驗檢查科室定義檔
*************
 FD HTDPT-MST IS EXTERNAL.
 01 HTDPT-REC.
   02 HTDPT-KEY.
      03 HTDPT-DPT-CD                   PIC X(1).
**       檢驗檢查科室簡碼
   02 HTDPT-DATA.
      03 HTDPT-DPT-NO                   PIC X(5).
**       檢驗檢查科室代號               -- ALT-KEY
*$XFD USE GROUP, VAR-LENGTH
      03 HTDPT-DATA-1.
         04 HTDPT-DPT-NN                PIC X(8).
**          檢驗檢查科室簡稱                            HTDPT-DATA-1  1:8
**       04 HTDPT-RPT-LN                PIC 9(2).
**          醫令單每頁行數                              HTDPT-DATA-1  9:2
         04 HTDPT-PRT-ODR-1             PIC X(1).
**          醫令單不印處置代碼                          HTDPT-DATA-1  9:1
         04 HTDPT-PRT-ODR-2             PIC X(1).
**          檢驗檢查系統重印醫令單的長度比照報告單長度  HTDPT-DATA-1 10:1
         04 HTDPT-SPN-CD                PIC X(1).
**          檢體編號編碼規則            -- 860526       HTDPT-DATA-1 11:1
         04 HTDPT-CPM-SW                PIC X(1).
**          部位匹配作業碼              -- 860304       HTDPT-DATA-1 12:1
         04 HTDPT-EMG-SW                PIC X(1).
**          急診檢驗室存在碼            -- 860701       HTDPT-DATA-1 13:1
         04 HTDPT-DATA-CLS.
**          類別設定資料
            05 HTDPT-OK-RP              PIC X(1).

**             審核通過碼                               HTDPT-DATA-1 14:1
            05 HTDPT-TY-SW1             PIC X(1).
**             檢驗檢查碼                               HTDPT-DATA-1 15:1
            05 HTDPT-TY-SW2             PIC X(1).
**             結果報告碼                               HTDPT-DATA-1 16:1
            05 HTDPT-FE-OP              PIC X(1).
**             先檢後批碼                               HTDPT-DATA-1 17:1
            05 HTDPT-ML-OP              PIC X(1).
**             耗材作業碼                               HTDPT-DATA-1 18:1
            05 HTDPT-ML-SP              PIC X(1).
**             耗材範例碼                               HTDPT-DATA-1 19:1
            05 HTDPT-IP-SP              PIC X(1).
**             醫令圈選檢體容器碼                       HTDPT-DATA-1 20:1
            05 HTDPT-IP-TR              PIC X(1).
**             醫令不可異動階段碼                       HTDPT-DATA-1 21:1
            05 HTDPT-IP-PST             PIC X(1).
**             曾經Ｘ光檢查判定碼                       HTDPT-DATA-1 22:1
            05 HTDPT-IP-RP              PIC X(1).
**             醫令報告碼                               HTDPT-DATA-1 23:1
            05 HTDPT-RP-CS              PIC X(1).
**             報告類別碼                               HTDPT-DATA-1 24:1
            05 HTDPT-PRS-CS             PIC X(1).
**             處置類別碼               -- PRS-FEE-KND  HTDPT-DATA-1 25:1
            05 HTDPT-SPN-SW             PIC X(1).
**             檢驗科取樣檢體編號作業碼 -- 860312       HTDPT-DATA-1 26:1
            05 HTDPT-SPN-SW1            PIC X(1).
**             護理站取樣檢體編號作業碼 -- 860503       HTDPT-DATA-1 27:1
            05 HTDPT-SPN-SW2            PIC X(1).
**             家醫科取樣檢體編號作業碼 -- 860526       HTDPT-DATA-1 28:1
            05 HTDPT-PST-TY             PIC X(1).
**             Ｘ光片標籤格式碼  　     -- 860507       HTDPT-DATA-1 29:1
            05 HTDPT-LNK-SW             PIC X(1).
**             雙主機作業碼                             HTDPT-DATA-1 30:1 --> LIS OR RIS OR PACS 系統整合碼 (901205)
            05 HTDPT-ML-SW              PIC X(1).
**             耗材方式碼               -- 870124       HTDPT-DATA-1 31:1
            05 HTDPT-IP-EMG             PIC X(1).
**             急件分單碼               -- 890502       HTDPT-DATA-1 32:1
            05 HTDPT-PNO-RPT-SW         PIC X(1).
**             病理報告查詢識別碼       -- 910324       HTDPT-DATA-1 33:1
            05 HTDPT-RPTD-NO-GRP        PIC X(1).
**             檢驗登記簿, 組合項不列入 -- 910411       HTDPT-DATA-1 34:1

* ==SCL== 2002.07.28 START ----- 借片預定借閱天數設定  ----------------------- *
            05 HTDPT-LND-DATE-CNT       PIC X(01).
*              預定借閱天數(以借閱日期 加 HTDPT-LND-DATE-CNT 為 預定歸還日期)
*                                                       HTDPT-DATA-1 35:1
* ==SCL== 2002.07.28 END   ----- 借片預定借閱天數設定  ----------------------- *
* ==SCL== 2002.10.30 START ----- PACS整合，醫令單印PACS工作序號 -------------- *
            05 HTDPT-BAR-IP-PACS        PIC X(1).
**             醫令單印PACS工作序號條碼 -- 911030       HTDPT-DATA-1 36:1
* ==SCL== 2002.10.30 END   ----- PACS整合，醫令單印PACS工作序號 -------------- *
* ==SCL== 2002.11.09 START ----- 醫令單備註是否放大 -------------------------- *
            05 HTDPT-IP-RK-FONT         PIC X(1).
*              醫令備註字型放大(~W2)                    HTDPT-DATA-1 37:1
* ==SCL== 2002.11.09 END   ----- 醫令單備註是否放大 -------------------------- *

            05 HTDPT-PAGE-RPT           PIC X(1).

*              儀器連線報告查詢列印採整頁格式           HTDPT-DATA-1 38:1
* ==SCL== 2004.01.13 START ----- 報告列印時左列空白格數 ---------------------- *
            05 HTDPT-RPT-SPACE          PIC 9(2).
**             報告列印時左列空白格數                   HTDPT-DATA-1 39:2
* ==SCL== 2004.01.13 END   ----- 報告列印時左列空白格數 ---------------------- *

* ==SCL== 2004.03.08 START ----- 報告列印CTRL + Y 門診、住院列印張數設定 ----- *
            05 HTDPT-RPT-ODR            PIC 9(1).
**             報告列印時CTRL + Y 門診列印張數設定      HTDPT-DATA-1 41:1
            05 HTDPT-RPT-ICB            PIC 9(1).
**             報告列印時CTRL + Y 住院列印張數設定      HTDPT-DATA-1 42:1
* ==SCL== 2004.03.08 END   ----- 報告列印CTRL + Y 門診、住院列印張數設定 ----- *
* ==SCL== 2004.03.09 START ----- 報告字型大小設定 ---------------------------- *
            05 HTDPT-RPT-FONT           PIC 9(2).
*              報告字型大小設定
* ==SCL== 2004.03.09 END   ----- 報告字型大小設定 ---------------------------- *

            05 HTDPT-CLS-FILLER         PIC X(12).
**             空白項                                   HTDPT-DATA-1 43:14

         04 HTDPT-PRT-ODR-3             PIC X(1).
**          醫令單印表機                                HTDPT-DATA-1 57:1
         04 HTDPT-RPT-LN1               PIC X(1).
**          報告單每頁行數碼            -- 900320       HTDPT-DATA-1 58:1
         04 HTDPT-AC-SW                 PIC X(1).
**          自動簽收作業碼              -- 860805       HTDPT-DATA-1 59:1
         04 HTDPT-REJ-SW                PIC X(1).
**          檢體退回原因碼              -- 860901       HTDPT-DATA-1 60:1
         04 HTDPT-AS-SW                 PIC X(1).
**          住院檢體自動取樣指示碼      -- 861013       HTDPT-DATA-1 61:1
         04 HTDPT-IO-SPT                PIC X(1).
**          外送細項分開列印碼          -- 861106       HTDPT-DATA-1 62:1
         04 HTDPT-IS-SW                 PIC X(1).
**          門急診檢體開立時自動編號碼  -- 870202       HTDPT-DATA-1 63:1
         04 HTDPT-NO-ONE                PIC X(1).
**          無單筆傳輸作業碼            -- 870410       HTDPT-DATA-1 64:1
         04 HTDPT-BAT-SEC               PIC 9(2).
**          批次傳輸暫停秒數            -- 870525       HTDPT-DATA-1 65:2
         04 HTDPT-RPT-SW                PIC X(1).
**          報告登錄模式                -- 870525       HTDPT-DATA-1 67:1
         04 HTDPT-LCHK-MO               PIC 9(1).
**          醫令保留月數                -- 870604       HTDPT-DATA-1 68:1
         04 HTDPT-LRST-MO               PIC 9(1).
**          報告保留月數                -- 870604       HTDPT-DATA-1 69:1
         04 HTDPT-IDZ-SW                PIC X(1).
**          是否列印病歷摘要碼          -- 870604       HTDPT-DATA-1 70:1
         04 HTDPT-ODC-SW                PIC X(1).
**          產生門診處置檢核碼          -- 871119       HTDPT-DATA-1 71:1
         04 HTDPT-WRK-SW                PIC X(1).
**          檢體工作序號碼              -- 871119       HTDPT-DATA-1 72:1
         04 HTDPT-WRK-ST                PIC X(1).
**          工作序號顯示碼              -- 871119       HTDPT-DATA-1 73:1
         04 HTDPT-PHR-NEXT              PIC X(1).
**          片語換行碼                                  HTDPT-DATA-1 74:1
         04 HTDPT-OPPR-SW               PIC X(1).
**          醫令開立時是否列印病歷摘要                  HTDPT-DATA-1 75:1
         04 HTDPT-ACMN-SW               PIC X(1).

**          作業人員自行簽收碼          -- 880514       HTDPT-DATA-1 76:1
**       04 HTDPT-SEE-CTM               PIC X(1).
**          簽收上下移動可看細項        -- 880624       HTDPT-DATA-1
         04 HTDPT-ODR-IPD               PIC X(1).
**          住院醫令列印醫令單碼        -- 900209       HTDPT-DATA-1 77:1
         04 HTDPT-BAR-TY                PIC X(1).
**          BARCODE TYPE                --880707/900209 HTDPT-DATA-1 78:1
         04 HTDPT-RPST-AM               PIC X(1).
**          細項報告判定作業碼          -- 880806       HTDPT-DATA-1 79:1
         04 HTDPT-DNG-SW                PIC X(1).
**          危險值報告通報碼            -- 890817       HTDPT-DATA-1 80:1
**       04 HTDPT-MRG-SW                PIC X(1).
**          檢驗放射系統合併            -- 890825       HTDPT-DATA-1
         04 HTDPT-ODR-BAR               PIC X(1).
**          醫令單與標籤同步列印碼      -- 900209       HTDPT-DATA-1 81:1
         04 HTDPT-BAR-IP                PIC X(1).
**          醫令單列印條碼              -- 900105       HTDPT-DATA-1 82:1
         04 HTDPT-PPF-SET                PIC X(1).
**          PPF人員設定值位置 ( /L)                     HTDPT-DATA-1 83:1
         04 HTDPT-OLD-RPT               PIC X(1).
**          使用舊版放射線報告登錄      -- 900410       HTDPT-DATA-1 84:1
         04 HTDPT-SHOW-ONE              PIC X(1).
**          醫令單細項改為一項一行顯示  -- 900413       HTDPT-DATA-1 85:1
         04 HTDPT-ODR-TYP               PIC X(1).
**          申請單格式                  -- 900728       HTDPT-DATA-1 86:1
         04 HTDPT-RPT-BLO-MARK          PIC X(1).
**          血型測定報告帶備註          -- 900728       HTDPT-DATA-1 87:1
         04 HTDPT-ODR-BLO-CHK           PIC X(1).
**          血型測定重複開立,帶警告訊息 -- 900728       HTDPT-DATA-1 88:1
         04 HTDPT-MUT-STA               PIC X(1).
**          各科室件數合併統計          -- 900728       HTDPT-DATA-1 89:1
         04 HTDPT-PNO-HSP-CD            PIC X(2).
**          病理編號醫院識別碼          -- 900817       HTDPT-DATA-1 90:2
         04 HTDPT-RPTD-IPDPT-YN         PIC X(1).
**          檢驗登記簿(屬門診部份)加選科別 -- 900817    HTDPT-DATA-1 92:1
         04 HTDPT-REWRITE-ICB           PIC X(1).
**          住院開立檢驗檢查項目簽收時才計價 -- 901010  HTDPT-DATA-1 93:1

** HTDPT-ALT-KEY = HTDPT-DPT-NO

** HTDPT-DPT-CD  : 不可為 'I' & 'O'
** HTDPT-DPT-NO  : 必須已存在於 單位主檔
** HTDPT-TY-SW1  : A> 檢驗項,   B> 檢查項
** HTDPT-TY-SW2  : A> 結果項,   B> 報告項
** HTDPT-RPT-SW  : A> 依醫令日期, 其它> 依病歷號碼
** HTDPT-NO-ONE  : Y> 無單筆傳輸作業
** HTDPT-IP-SP   : Y> 醫令開立時僅能圈選一種檢體容器,
**                 M> 多種檢體容器, N> 無檢體容器
** HTDPT-IP-TR   : A> 醫令已開立者, B> 檢體已指示者, C> 檢體已取樣者,
**                 D> 檢體已送檢者, E> 醫令已簽收者, F> 醫令已排程者,
**                 G> 醫令已外送者, H> 醫令已檢查者, I> 醫令已耗材者,
**                 J> 結果已報告者, K> 報告已審核者
** HTDPT-PRS-CS  : C> 檢驗, D> 檢查, E> Ｘ光
** HTDPT-RPT-LN1 : 1> 全頁, 2> 1/2 頁, 3> 2/3 頁, 4> 1/3 頁
** HTDPT-SPN-CD  :  > HTSPN-SPN-NO1, 0> HTSPN-SPN-NO1,
**                 1> HTSPN-SPN-NO1, 2> HTSPN-SPN-NO2
** HTDPT-SPN-SW  : A> 檢驗科取樣檢體自動編號且列印標籤,

**                 B> 檢驗科取樣檢體人工給號且列印標籤,
**                 C> 檢驗科取樣檢體不予編號且列印標籤
**                 Y> 檢驗科取樣檢體自動編號但不列印標籤,
**                 M> 檢驗科取樣檢體人工給號但不列印標籤,
**                 N> 檢驗科取樣檢體不予編號但不列印標籤
** HTDPT-SPN-SW1 : A> 護理站取樣檢體自動編號且列印標籤,
**                 B> 護理站取樣檢體人工給號且列印標籤,
**                 C> 護理站取樣檢體不予編號且列印標籤
**                 Y> 護理站取樣檢體自動編號但不列印標籤,
**                 M> 護理站取樣檢體人工給號但不列印標籤,
**                 N> 護理站取樣檢體不予編號但不列印標籤
** HTDPT-SPN-SW2 : A> 家醫科取樣檢體自動編號且列印標籤,
**                 B> 家醫科取樣檢體人工給號且列印標籤,
**                 C> 家醫科取樣檢體不予編號且列印標籤
**                 Y> 家醫科取樣檢體自動編號但不列印標籤,
**                 M> 家醫科取樣檢體人工給號但不列印標籤,
**                 N> 家醫科取樣檢體不予編號但不列印標籤
**                 IF HTDPT-IP-SP NOT = 'N'
**                      ACCEPT HTDPT-SPN-SW & HTDPT-SPN-SW1 & HTDPT-SPN-SW2.
** HTDPT-IS-SW   : Y> 門急診檢體開立時自動編號,
**                    HTDPT-LNK-SW MUST = 'Y' & HTDPT-SPN-SW  MUST = 'A' OR 'Y'
** HTDPT-AS-SW   : Y> 住院檢體自動取樣指示,
**                    HTDPT-LNK-SW MUST = 'Y' & HTDPT-SPN-SW1 MUST = 'A' OR 'Y'
** HTDPT-AC-SW   : A> 全部自動簽收,          B> 除住院外全部自動簽收,
**                 C> 除團檢外全部自動簽收,  D> 僅自動簽收門急診醫令單
** HTDPT-ML-OP   : A> 類別耗材, B> 細項耗材
** HTDPT-RP-CS   : A> 細項報告, B> 綜合報告, C> 細項報告 & 綜合報告
** HTDPT-ML-SP   : A> 類別範例, B> 部位範例, C> 細部範例, D> 細項範例
** HTDPT-IP-RP   : A> 檢驗檢查, B> 部位檢查, C> 細菌檢驗, D> 血庫檢驗
**                 IF HTDPT-IP-RP = "B"    HTDPT-ML-SP = "A", "B", "C", "D" ELSE
**                                         HTDPT-ML-SP = "A", "D".
**                 IF HTDPT-IP-RP = "B"    ACCEPT HTDPT-PST-TY & HTDPT-CPM-SW &
**                                                HTDPT-IP-PST              ELSE
**                                         ACCEPT HTDPT-EMG-SW & HTDPT-LNK-SW &
**                                                HTDPT-SPN-CD
** HTDPT-ML-SW   : A> 人工耗材項, B> 自動耗材項, C> 批次耗材項
** HTDPT-REJ-SW  : Y> 檢體退回原因備註作業 -- CANCEL
**                 A> 檢驗科列印重送通知單, B> 護理站列印重送通知單, C> 送檢單位列印重送通知單 -- 90/09/27
** HTDPT-EMG-SW  : Y> 有急診檢驗室(署立雲林醫院), M> 區分急診檢驗室(署立新竹醫院--90/5/2)
** HTDPT-LNK-SW  : Y> 有檢驗儀器連線主機, ACCEPT HTDPT-LCHK-MO & HTDPT-LRST-MO
** HTDPT-LNK-SW  : Y> 大同版LIS, M> 名碩版LIS, E> 宜蘭版PACS
**                 EVALUATE HTDPT-DPT-CD
**                     WHEN 'T'
**                          MOVE ' ' OR 'Y' OR 'M' TO HTDPT-LNK-SW
**                     WHEN OTHER
**                          MOVE ' ' OR 'P' TO HTDPT-LNK-SW
**                 END-EVALUATE

** PACS........
** HTDPT-LNK-SW  : A> 艾克發版 台北放射線使用  ， A 有 S 的功能，因台北醫院兩者皆有
**                 S> 商之器
**                 s> 台腦
**                 s> 富士通-->宇宏  2004.03.20

** HTDPT-CPM-SW  : Y> 補登醫令時採用「部位-細部-微部」三段選單方式
** HTDPT-IP-PST  : Y> 開立醫令時須輸入「是否曾經過Ｘ光檢查之判定碼」
** HTDPT-OK-RP   : Y> 表該科室之檢驗檢查報告須經審核通過方可開放查詢印表

** HTDPT-FE-OP   : Y> 僅門急診允許先檢後批, A> 全部允許先檢後批
**                    CHECK 身份別 -- HT_SYS01.SON
** HTDPT-IO-SPT  : Y> 一張檢驗(查)單若有外送項則外送項分開印一張, N> 全部印在一起
** HTDPT-IDZ-SW  : Y> 列印報告時列印病歷摘要, N OR SPACE>不印
** HTDPT-WRK-SW  : M> 名碩公司編碼規則
** HTDPT-WRK-ST  : Y> 簽收後顯示工作序號
** HTDPT-PHR-NEXT: Y> 片語輸入後換行
** HTDPT-ACMN-SW : N> 簽收時預設為全選;
**                 Y> 簽收時預設為全不選;
**                 P> 若簽收人員之密碼設定有指定作業類別時,
**                    則簽收時畫面僅會出現指定類別之單據且預設為全選;
**                 C> 簽收時可指定作業類別,
**                    有指定時預設為全選, 無指定時預設為全不選
** HTDPT-SEE-CTM : Y> 簽收上下筆移動, 即可看細項
** HTDPT-BAR-TY  : SPACE/0 > 放射線橫字, 1> 放射線立字, 條碼較大                --放射線單獨「條碼」列印時使用
**                 2>       > 條碼較小，由WIN-PRINT印出，與醫令單條碼相同！     --放射線單獨「條碼」列印時使用
**                 G> ->基隆 200條碼機             病歷號
**                 H>                              身份證字號
**                 I> ->忠孝、K花蓮 CX208條碼機    病歷號
**                 J>                              身份證字號
**                 F> 婦幼醫院檢體標籤
**
**
** HTDPT-RPST-AM : A> 細項報告僅做自動判定, P> 細項報告不做判定,
**                 M> 細項報告僅做人工判定, 其餘> 細項報告全部人工判定
** HTDPT-IP-EMG  : Y> 急件分單
** HTDPT-DNG-SW  : Y> 危險值報告通報, create ht_mdng
** HTDPT-MRG-SW  : Y> 檢驗放射系統合併
** HTDPT-BAR-IP  : Y> 醫令單列印條碼
** HTDPT-ODR-IPD : E> 住院醫令不列印急件醫令單, N> 住院醫令不列印普件醫令單, A> 住院醫令不列印醫令單
** HTDPT-ODR-BAR : 1> 住院醫令單與標籤同步列印, 2> 門診醫令單與標籤同步列印, 3> 急診醫令單與標籤同步列印,
**                 4> 住院＋門診, 5> 住院＋急診, 6> 門診＋急診, 7> 住院＋門診＋急診
** HTDPT-PPF-SET :' '> IF HTCLS-CKM-SW = P 則使用 HTCLS-PPF-DATA 做為簽收存檔的 PPF人員設定值位置
** PPF人員設定值位置 : L > 把 PPF人員設定值位置 放在 LOCAL 端，C:\HMISA\ZTN.DIR\HT_PPF4，
**                     HTSI31IF, 開檔時開新檔，結束時關刪檔！
**                     HT_PPF4， 開新檔時，以HTCLS-PPF-DATA 做為帶入之預設值，再行修改
**                     簽收存檔時，以LOCAL 端的蚵T_PPF4]定為主，(可避免他台主機修改時造成資料不正確！)
**HTDPT-IP-RK-FONT: I>細項備註，字型放寬為兩偣。(~W2)
**                  C>類別備註，
**                  A>兩者皆放大
**HTDPT-LND-DATE-CNT:   不為0 或 SPACE 時，可以看見借片作業中<F3>整袋借片！

**HTDPT-RPT-FONT:       報告字型大小設定
*                       不設：  預設為24字型
*
*                       字距為 X0 時            80字長度        18.0CM          1/3     1/2     2/3     全張
*                       24    ->為T24字型，     14.0CM          80字元          22      33      47      66
*                       26    ->為T26字型，     15.2CM          80字元          20      30      40      60
*                       28    ->為T28字型，     16.5CM          80字元          19      28      37      56
*                       30    ->為T30字型，     17.5CM          80字元          18      26      35      53
*                       32    ->為T32字型，     18.5CM          78字元          16      24      32      48
*                       34    ->為T34字型，     20.0CM          73字元          16      23      31      47
*                       36    ->為T36字型，     21.0CM          69字元          15      22      29      44

*COPY    "HT_CHK.MST".
*************
* C-PY FILE : HT_CHK.MST   84/03/29     作者：謝枝財

* HT_MCHK LENGTH 400 BYTES 86/02/04     醫令單主檔
*************
 FD HTCHK-MST IS EXTERNAL.
 01 HTCHK-REC.
   02 HTCHK-KEY.
      03 HTCHK-CHK-NO.
**       醫令單號
         04 HTCHK-CLS-NO.
**          檢驗檢查類別代號            -- ALT-KEY6
            05 HTCHK-DPT-CD             PIC X(1).
**             檢驗檢查科室簡碼         -- ALT-KEYE
            05 HTCHK-CLS-CD             PIC X(2).
**             檢驗檢查類別碼           -- ALT-KEYL
         04 HTCHK-PR-SEQ                PIC 9(5).
**          開單流水碼                  -- ALT-KEYA
      03 HTCHK-IP-DATE                  PIC 9(7).
**       醫令日期
   02 HTCHK-DATA.
**    單據資料
      03 HTCHK-DATA-FOR.
**       前端資料
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-P-KEY.
            05 HTCHK-IP-DATE1           PIC 9(7).
**             醫令日期                 -- ALT-KEY6
            05 HTCHK-CHK-NO1            PIC X(8).
**             醫令單號                 -- ALT-KEY6
         04 HTCHK-IP-CLSW               PIC X(1).
**          醫令來源碼
         04 HTCHK-IP-HC.
**          健檢資料
            05 HTCHK-IP-HCID            PIC X(9).
**             健檢種類代碼
            05 HTCHK-IP-GPID            PIC X(8).
**             健檢團體代號             -- ALT-KEYL
            05 HTCHK-IP-GPSW            PIC X(1).
**             健檢碼                   -- ALT-KEYE
         04 HTCHK-DATA-PT.
**          病患資料
            05 HTCHK-PT-NO              PIC 9(8).
**             病歷號碼                 -- ALT-KEYE
*$XFD USE GROUP, VAR-LENGTH
            05 HTCHK-PT-DATA.
               06 HTCHK-PT-ID           PIC X(10).
**                身份字號
               06 HTCHK-PT-IDSW         PIC X(1).
**                身份異動碼
               06 HTCHK-PT-NAME         PIC X(12).
**                姓名
               06 HTCHK-PT-DATE         PIC S9(7).
**                出生日
               06 HTCHK-PT-SEX          PIC X(1).
**                性別
               06 HTCHK-PT-IDNT         PIC X(4).
**                身份別
         04 HTCHK-DATA-IP.
**          醫令資料

*$XFD USE GROUP, VAR-LENGTH
            05 HTCHK-IP-NO              PIC X(22).
**             醫令序號                 -- ALT-KEYM
            05 HTCHK-IP-NO1 REDEFINES HTCHK-IP-NO.
**             門診醫令序號
               06 HTCHK-RO-NO           PIC 9(11).
**                門診序號
               06 HTCHK-OR-NO           PIC 9(2).
**                處方序號
               06 HTCHK-RO-FL           PIC X(9).
**                空白項
            05 HTCHK-IP-NO2 REDEFINES HTCHK-IP-NO.
**             住院醫令序號
               06 HTCHK-PD-NO           PIC 9(11).
**                住院序號
               06 HTCHK-OD-NO           PIC 9(11).
**                處方序號
*$XFD USE GROUP, VAR-LENGTH
            05 HTCHK-IP-DATA.
               06 HTCHK-CR-TIME         PIC 9(6).
**                醫令登錄時間
               06 HTCHK-CR-MAN          PIC X(5).
**                醫令登錄人員
               06 HTCHK-IP-TIME         PIC 9(6).
**                醫令時間
               06 HTCHK-IP-MAN          PIC X(4).
**                醫令醫師
               06 HTCHK-IP-WAY          PIC X(1).
**                就診方式
               06 HTCHK-IP-DPT          PIC X(4).
**                科別
               06 HTCHK-IP-DZS1         PIC X(7).
**                診斷１
               06 HTCHK-IP-DZS2         PIC X(7).
**                診斷２
               06 HTCHK-IP-DZS3         PIC X(7).
**                診斷３
               06 HTCHK-IP-DZS4         PIC X(7).
**                診斷４
               06 HTCHK-IP-EMG          PIC X(1).
**                急件碼
               06 HTCHK-IP-PAST         PIC X(1).
**                三年內曾經檢查碼
               06 HTCHK-IP-SPL          PIC X(1).
**                檢體容器碼
               06 HTCHK-PER-ST          PIC X(1).
**                荷爾蒙狀況
               06 HTCHK-PRE-NO          PIC 9(2).
**                懷孕週數
               06 HTCHK-DRG-NO.
                  07 HTCHK-DRG-NO1      PIC X(5).
**                   抗生素代號１
                  07 HTCHK-DRG-NO2      PIC X(5).
**                   抗生素代號２
                  07 HTCHK-DRG-NO3      PIC X(5).
**                   抗生素代號３
               06 HTCHK-TP-DATE         PIC 9(7).

**                預定檢驗日期
               06 HTCHK-AP-DATE         PIC 9(7).
**                預定送檢日期
               06 HTCHK-IP-RKNO         PIC X(10).
**                類別醫令備註編號
      03 HTCHK-DATA-BACK.
**       後端資料
         04 HTCHK-WK-SW                 PIC X(1).
**          作業流程碼                  -- ALT-KEYA
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-DATA-AC.
**          簽收資料
            05 HTCHK-AC-MAN             PIC X(5).
**             簽收人員
            05 HTCHK-AC-DATE            PIC 9(7).
**             簽收日期
            05 HTCHK-AC-TIME            PIC 9(6).
**             簽收時間
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-DATA-SC.
**          排程資料
            05 HTCHK-SC-ITM             PIC X(1).
**             細項排程時段碼
            05 HTCHK-SC-DATE            PIC 9(7).
**             最後排程日期
            05 HTCHK-SC-MAN             PIC X(5).
**             最後排程人員
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-DATA-IO.
**          外送資料
            05 HTCHK-IO-ITM             PIC X(1).
**             細項外送時段碼
            05 HTCHK-IO-DATE            PIC 9(7).
**             最後外送日期
            05 HTCHK-IO-MAN             PIC X(5).
**             最後外送人員
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-DATA-CK.
**          檢查資料
            05 HTCHK-CK-ITM             PIC X(1).
**             細項檢查時段碼
            05 HTCHK-ML-ITM             PIC X(1).
**             細項耗材碼
            05 HTCHK-CK-DATE            PIC 9(7).
**             最後檢查日期
            05 HTCHK-CK-TIME            PIC 9(6).
**             最後檢查時間
            05 HTCHK-CK-MAN             PIC X(5).
**             最後檢查人員
            05 HTCHK-US-DPT             PIC X(5).
**             耗用中心代號 -   - HTCLS-US-DPT
         04 HTCHK-DATA-RP.
**          綜合報告資料
            05 HTCHK-RP-SV              PIC X(1).
**             教學範例碼
            05 HTCHK-RP-ST              PIC X(1).
**             報告狀態碼               -- ALT-KEY6

            05 HTCHK-RP-DATE            PIC 9(7).
**             報告日期                 -- ALT-KEY6
*$XFD USE GROUP, VAR-LENGTH
            05 HTCHK-RP-DATA.
               06 HTCHK-RP-TIME         PIC 9(6).
**                報告時間
               06 HTCHK-RP-F-MAN        PIC X(5).
**                最初報告人員
               06 HTCHK-RP-L-MAN        PIC X(5).
**                最終報告人員
               06 HTCHK-RP-NO           PIC X(10).
**                綜合報告文件編號
               06 HTCHK-CS-DPT          PIC X(5).
**                成本中心代號 -- HTCLS-CS-DPT
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-DATA-OK.
**          綜合審核資料
            05 HTCHK-OK-ST              PIC X(1).
**             審核狀態碼
            05 HTCHK-OK-DATE            PIC 9(7).
**             審核日期
            05 HTCHK-OK-TIME            PIC 9(6).
**             審核時間
            05 HTCHK-OK-MAN             PIC X(5).
**             審核人員
            05 HTCHK-OK-RKNO            PIC X(10).
**             類別審核備註編號
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-DATA-OTH.
**          其它資料
            05 HTCHK-FILLER             PIC X(48).
**             空白項

** HTCHK-ALT-KEY6 = HTCHK-IP-GPSW  + HTCHK-RP-DATE +
**                  HTCHK-RP-ST    + HTCHK-CLS-NO  + HTCHK-P-KEY
** HTCHK-ALT-KEYA = HTCHK-IP-GPID  + HTCHK-CLS-NO  +
**                  HTCHK-IP-DATE  + HTCHK-WK-SW   + HTCHK-PR-SEQ
** HTCHK-ALT-KEYE = HTCHK-IP-GPSW  + HTCHK-DPT-CD  +
**                  HTCHK-PT-NO    + HTCHK-P-KEY
** HTCHK-ALT-KEYM = HTCHK-IP-NO    + HTCHK-P-KEY

** MOVE HTCHK-CHK-NO  TO HTCHK-CHK-NO1  AND
** MOVE HTCHK-IP-DATE TO HTCHK-IP-DATE1 BEFORE READ & WRITE HT_CHK.MST
** HTCHK-PR-SEQ1 = 100000 - HTCHK-PR-SEQ
** HTCHK-IP-MAN  : READ 醫師代碼主檔 HG_NID.MST (NID-ID = "0503")
** HTCHK-IP-WAY  : READ 就診方式主檔 HG_NID.MST (NID-ID = "0505")
**                 IF HTCHK-IP-WAY = " "        表「住院」
**                 IF HTCHK-IP-WAY = "@"        表「個人健檢」  -- 851107
**                 IF HTCHK-IP-WAY = "$"        表「團體健檢」  -- 851107
** HTCHK-IP-BED  : 病房床號, READ 住院主檔 HI_IPD.MST -- IPD-BED
** HTCHK-IP-EMG  : Y> 急件, N> 非急件
** HTCHK-PT-IDSW : Y> 身份異動
** HTCHK-IP-CLSW : A> 批價系統, B> 醫令系統, C> 住院系統,
**                 D> 個人健檢, E> 團體健檢, F> 醫令補登
** IF HTCHK-IP-CLSW = "D"                    MOVE "********" TO HTCHK-IP-GPID.
** IF HTCHK-IP-CLSW = "D" OR "E"             MOVE "Y"        TO HTCHK-IP-GPSW.
** HTCHK-IP-GPID : IF HTCHK-IP-CLSW = "E"    READ 健檢客戶主檔 HG_VDN.MST.

** HTCHK-IP-GPSW : Y> 健檢醫令
** HTCHK-WK-SW   : A> 醫令開立作業, B> 檢體指示作業, C> 檢體取樣作業,
**                 D> 檢體送檢作業, E> 醫令簽收作業, F> 醫令排程作業,
**                 G> 醫令外送作業, H> 醫令檢查作業, I> 醫令耗材作業,
**                 J> 結果報告作業,
**                    IF HTCHK-RP-ST = "Y" MOVE "正常報告" TO 醫令流程
**                    IF HTCHK-RP-ST = "N" MOVE "異常報告" TO 醫令流程
**                 K> 報告審核作業,
**                    IF HTCHK-OK-ST = "Y" MOVE "審核通過" TO 醫令流程
**                    IF HTCHK-OK-ST = "N" MOVE "審核批退" TO 醫令流程
** HTCHK-RP-SV   : Y> 教學範例, CREATE HT_DZS.MST
** HTCHK-RP-ST   : Y> 正常報告, N> 異常報告
** HTCHK-OK-ST   : Y> 核准,     N> 批退
** HTCHK-PR-SW   : Y> 已列印過完整報告
** HTCHK-SC-ITM  : Y> 表該醫令單之各檢驗檢查細項有不同之排程日期
** HTCHK-IO-ITM  : Y> 表該醫令單之各檢驗檢查細項有不同之外送日期
** HTCHK-CK-ITM  : Y> 表該醫令單之各檢驗檢查細項有不同之檢查日期
** HTCHK-IP-RKNO : MOVE "A1"          TO W-EDT-RPT-TY
**                 MOVE "2"           TO W-EDT-CPY-SW
**                 MOVE "C,M,D,I"     TO W-EDT-FUN-SW
**                 MOVE HTCHK-IP-MAN  TO W-EDT-USR-NO
**                 MOVE HTCHK-CLS-NO  TO W-EDT-CPY-KY
**                 MOVE HTCHK-IP-RKNO TO W-EDT-RPT-NO
**                 LINK HZ_EDT.LNK &  CALL "HZEDTCF" USING W-EDT-TABLE
** HTCHK-OK-RKNO : MOVE "A2"          TO W-EDT-RPT-TY
**                 MOVE "2"           TO W-EDT-CPY-SW
**                 MOVE "C,M,D,I"     TO W-EDT-FUN-SW
**                 MOVE HTCHK-OK-MAN  TO W-EDT-USR-NO
**                 MOVE HTCHK-CLS-NO  TO W-EDT-CPY-KY
**                 MOVE HTCHK-OK-RKNO TO W-EDT-RPT-NO
**                 LINK HZ_EDT.LNK &  CALL "HZEDTCF" USING W-EDT-TABLE
** HTCHK-RP-NO   : MOVE "12"           TO W-EDT-RPT-TY
**                 MOVE "2"            TO W-EDT-CPY-SW
**                 MOVE "C,M,D,I"      TO W-EDT-FUN-SW
**                 MOVE HTCHK-RP-L-MAN TO W-EDT-USR-NO
**                 MOVE HTCHK-CLS-NO   TO W-EDT-CPY-KY
**                 MOVE HTCHK-RP-NO    TO W-EDT-RPT-NO
**                 LINK HZ_EDT.LNK &  CALL "HZEDTCF" USING W-EDT-TABLE
** 醫令補登作業  : 用 HTCHK-PT-NO READ 病歷主檔(HH_PAT.MST)
**                 -- 病患姓名,性別,出生日,身份別
**                 IF PAT-IDT-LST > PAT-IOUT-LST THEN
**                      用 HTCHK-PT-NO READ 住院主檔(HI_IPD.MST)
**                      -- 住院序號,身份,科別,醫令醫師,病房床號
**                 ELSE 用 HTCHK-PT-NO READ 掛號主檔(HO_REG.MST)
**                      -- 門診序號,身份,科別,醫令醫師,就診方式
** IF HTCHK-OK-ST = "N" & 進行單據審核非細項審核    INITIALIZE ALLHTCTM-DATA-SC.
** IF HTCHK-RP-SW NOT = " " AND
**    HTCLS-OK-RP NOT = "Y"     MOVE HTCHK-RP-L-MAN TO HTCHK-OK-MAN
**                              MOVE HTCHK-RP-DATE  TO HTCHK-OK-DATE
**                              MOVE HTCHK-RP-TIME  TO HTCHK-OK-TIME
**                              MOVE "Y"            TO HTCHK-OK-SW

** 作業說明：
**              ================ ================ ======================
**               資 料 項 目      作 業 階 段      資 料 來 源
**              ================ ================ ======================
**               HTCHK-IP-CLSW    醫令開立或補登   健檢,醫令,批價系統

**               HTCHK-DATA-PT    醫令開立或補登   健檢,醫令,批價系統
**               HTCHK-DATA-IP    醫令開立或補登   健檢,醫令,批價系統
**               HTCHK-AP-DATE    醫令開立或補登   HTCHK-TP-DATE
**               HTCHK-AP-DATE    檢體取樣結果     護理站系統
**               HTCHK-DATA-AC    醫令簽收         檢驗檢查系統
**               HTCHK-DATA-RP    結果報告         檢驗檢查系統
**               HTCHK-DATA-OK    報告審核         檢驗檢查系統
**               HTCHK-DATA-SC    醫令排程         檢驗檢查系統
**               HTCHK-DATA-IO    醫令外送         檢驗檢查系統
**               HTCHK-DATA-CK    檢驗檢查與耗材   檢驗檢查系統
**               HTCHK-DATA-PR    報告列印         檢驗檢查系統
*COPY    "HT_RPT.MST".
*************
* C-PY FILE : HT_RPT.MST   84/04/03     作者：謝枝財
* HT_MRPT LENGTH 791 BYTES 85/07/06     報告備註文件檔
*************
*
 FD  HTRPT-MST EXTERNAL .
 01 HTRPT-REC.
     02 HTRPT-KEY.
         03 HTRPT-USR-NO     PIC  X(5).
**       使用者代號                     -- ALT-KEY
         03 HTRPT-RPT-TY     PIC  X(2).
**       文件型態碼                     -- ALT-KEY
         03 HTRPT-RPT-NO     PIC  X(10).
**       報告備註文件編號
         03 HTRPT-RPT-CNT    PIC  9(2).
**       報告備註文件頁數               -- ALT-KEY
     02 HTRPT-DATA.
         03 HTRPT-RPT-NO1    PIC  X(10).
**       文件對應編號                   -- ALT-KEY
         03 HTRPT-ROW        PIC  9(2).
**       本頁實際編輯行數
         03 HTRPT-TXT.
**       文件單頁內容 (76 COL * 10 ROW)
*XFD VAR-LENGTH
             04 HTRPT-TXT1       PIC  X(228).
**          文件單頁內容 (ROW 1-3)
*XFD VAR-LENGTH
             04 HTRPT-TXT2       PIC  X(228).
**          文件單頁內容 (ROW 4-6)
*XFD VAR-LENGTH
             04 HTRPT-TXT3       PIC  X(152).
**          文件單頁內容 (ROW 7-8)
*XFD VAR-LENGTH
             04 HTRPT-TXT4       PIC  X(152).
**          文件單頁內容 (ROW 9-10)
*COPY    "HT_CLS.MST".
*************
* C-PY FILE : HT_CLS.MST   84/03/23     作者：謝枝財
* HT_MCLS LENGTH 200 BYTES 89/10/31     檢驗檢查類別定義檔
*************
 FD HTCLS-MST IS EXTERNAL.
 01 HTCLS-REC.
   02 HTCLS-KEY.
      03 HTCLS-CLS-NO.
**       檢驗檢查類別代號

         04 HTCLS-DPT-CD                PIC X(1).
**          檢驗檢查科室簡碼
         04 HTCLS-CLS-CD                PIC X(2).
**          檢驗檢查類別碼
   02 HTCLS-DATA.
      03 HTCLS-SEQ-MN                   PIC 9(2).
**       畫面選項序號                   -- ALT-KEY2
*$XFD USE GROUP, VAR-LENGTH
      03 HTCLS-DATA-1.
         04 HTCLS-CLS-NM                PIC X(20).
**          檢驗檢查類別名稱
         04 HTCLS-CLS-NN                PIC X(8).
**          檢驗檢查類別簡稱
         04 HTCLS-DATA-RK.
**          類別備註範例資料
            05 HTCLS-IP-RKAT            PIC X(1).
**             類別醫令備註自動碼
            05 HTCLS-IP-RKNO            PIC X(10).
**             類別醫令備註範例編號
            05 HTCLS-RP-NO              PIC X(10).
**             綜合報告文件範例編號
            05 HTCLS-OK-RKAT            PIC X(1).
**             類別審核備註自動碼
            05 HTCLS-OK-RKNO            PIC X(10).
**             類別審核備註範例編號
         04 HTCLS-DATA-CLS.
**          類別設定資料
            05 HTCLS-OK-RP              PIC X(1).
**             審核通過碼
            05 HTCLS-TY-SW1             PIC X(1).
**             檢驗檢查碼
            05 HTCLS-TY-SW2             PIC X(1).
**             結果報告碼
            05 HTCLS-FE-OP              PIC X(1).
**             先檢後批碼
            05 HTCLS-ML-OP              PIC X(1).
**             耗材作業碼
            05 HTCLS-ML-SP              PIC X(1).
**             耗材範例碼
            05 HTCLS-IP-SP              PIC X(1).
**             醫令圈選檢體容器碼
            05 HTCLS-IP-TR              PIC X(1).
**             醫令不可異動階段碼
            05 HTCLS-IP-PST             PIC X(1).
**             曾經Ｘ光檢查判定碼
            05 HTCLS-IP-RP              PIC X(1).
**             醫令報告碼
            05 HTCLS-RP-CS              PIC X(1).
**             報告類別碼
            05 HTCLS-PRS-CS             PIC X(1).
**             處置類別碼               -- PRS-FEE-KND
            05 HTCLS-SPN-SW             PIC X(1).
**             檢驗科取樣檢體編號作業碼 -- 860312
            05 HTCLS-SPN-SW1            PIC X(1).
**             護理站取樣檢體編號作業碼 -- 860503
            05 HTCLS-SPN-SW2            PIC X(1).
**             家醫科取樣檢體編號作業碼 -- 860526

            05 HTCLS-PST-TY             PIC X(1).
**             Ｘ光片標籤格式碼  　     -- 860507
            05 HTCLS-LNK-SW             PIC X(1).
**             雙主機作業碼             -- 860522
            05 HTCLS-ML-SW              PIC X(1).
**             耗材方式碼               -- 870124
            05 HTCLS-IP-EMG             PIC X(1).
**             急件或單項分單碼         -- 890502
            05 HTCLS-CLS-FILLER         PIC X(2).
**             空白項
         04 HTCLS-PPF-DATA.
**          ＰＰＦ資料                  -- 890619
            05 HTCLS-PPF-DATE           PIC 9(7).
**             ＰＰＦ設定日期
            05 HTCLS-EXE-MAN1           PIC X(5).
**             實作人員代號一
            05 HTCLS-EXE-MAN2           PIC X(5).
**             實作人員代號二
            05 HTCLS-RPT-MAN            PIC X(5).
**             報告人員代號
         04 HTCLS-DATA-ITM.
**          細項設定資料
            05 HTCLS-SL-SW              PIC X(1).
**             特殊檢查碼
            05 HTCLS-IO-FEE             PIC 9(6).
**             細項外送費用
            05 HTCLS-IO-HSP             PIC X(12).
**             外送醫院代號
            05 HTCLS-IO-SW              PIC X(1).
**             排程對象碼
            05 HTCLS-SC-SW              PIC X(1).
**             排程方式碼
            05 HTCLS-RP-SW              PIC X(1).
**             細項報告型態碼
            05 HTCLS-SG-SW              PIC X(1).
**             單一細項報告碼
            05 HTCLS-MC-SW              PIC X(1).
**             簽收後排程碼
            05 HTCLS-CS-DPT             PIC X(5).
**             成本中心代號
            05 HTCLS-US-DPT             PIC X(5).
**             耗用中心代號
            05 HTCLS-VP-DA.
**             預定交件資料
               06 HTCLS-VP-TU           PIC X(1).
**                預定交件時間單位碼
               06 HTCLS-VP-TQ           PIC 9(3).
**                預定交件時間數量
         04 HTCLS-DATA-MCW.
**          儀器排程型態資料
            05 HTCLS-MCW-TYPE OCCURS 21 TIMES.
               06 HTCLS-MCW-TY          PIC X(1).
**                儀器排程型態碼
         04 HTCLS-RPT-RK                PIC X(1).
**          報告列印類別醫令備註碼      -- 860531
         04 HTCLS-DRG-SW                PIC X(1).
**          抗生素醫令輸入碼            -- 861015

         04 HTCLS-IDUP-SW               PIC X(1).
**          細項重複選擇碼
         04 HTCLS-IPR-ROW               PIC 9(2).
**          醫令備註起始row位置
         04 HTCLS-IPR-COL               PIC 9(2).
**          醫令備註起始col位置
         04 HTCLS-SC-TM                 PIC X(1).
**          排程時間輸入碼
**       04 HTCLS-DATA-DPT.
**          排檢部門設定資料            -- 871118
**          05 HTCLS-EMG-DPT            PIC X(2).
**             急件排檢部門代號
**          05 HTCLS-NMG-DPT            PIC X(2).
**             非急件排檢部門代號
         04 HTCLS-LBL-QTY               PIC 9(1).
**          檢體標籤列印張數  　        -- 880326
         04 HTCLS-EMG-AC                PIC X(1).
**          急診醫令開立且簽收碼        -- 880705
         04 HTCLS-AC-IP                 PIC X(1).
**          加印醫令單碼                -- 881130
         04 HTCLS-RPT-LN1               PIC 9(2).
**          報告單每頁行數              -- 890203
         04 HTCLS-CKM-SW                PIC X(1).
**          簽收時輸入檢查或PPF人員     -- 890424
         04 HTCLS-RPTD-SW               PIC X(1).
**          報告列印報告日期            -- 890614
         04 HTCLS-IRPT-SW               PIC X(1).
**          重要醫令即時報備            -- 890614
         04 HTCLS-INQ-SW                PIC X(1).
**          限醫師方可查報告            -- 890808
         04 HTCLS-WAB-SW                PIC X(1).
**          檢體取樣單加印檢驗細項      -- 890825
         04 HTCLS-ODR-SRT               PIC X(1).
**          醫令單列印順序碼            -- 891031
         04 HTCLS-FILLER                PIC X(14).
**          空白項

** HTCLS-ALT-KEY1 = HTCLS-CLS-CD + HTCLS-DPT-CD
** HTCLS-ALT-KEY2 = HTCLS-DPT-CD + HTCLS-SEQ-MN

** HTCLS-TY-SW1  : A> 檢驗項,   B> 檢查項
** HTCLS-TY-SW2  : A> 結果項,   B> 報告項
** HTCLS-IP-PST  : Y> 開立醫令時須輸入「是否曾經過Ｘ光檢查之判定碼」
** HTCLS-IP-SP   : Y> 醫令開立時僅能圈選一種檢體容器,
**                 M> 多種檢體容器, N> 無檢體容器
** HTCLS-IP-TR   : A> 醫令已開立者, B> 檢體已指示者, C> 檢體已取樣者,
**                 D> 檢體已送檢者, E> 醫令已簽收者, F> 醫令已排程者,
**                 G> 醫令已外送者, H> 醫令已檢查者, I> 醫令已耗材者,
**                 J> 結果已報告者, K> 報告已審核者
** HTCLS-PRS-CS  : C> 檢驗, D> 檢查, E> Ｘ光
** HTCLS-LNK-SW  : Y> 有檢驗儀器連線主機
** HTCLS-SPN-SW  : A> 檢驗科取樣檢體自動編號且列印標籤,
**                 B> 檢驗科取樣檢體人工給號且列印標籤,
**                 C> 檢驗科取樣檢體不予編號且列印標籤
**                 Y> 檢驗科取樣檢體自動編號但不列印標籤,
**                 M> 檢驗科取樣檢體人工給號但不列印標籤,
**                 N> 檢驗科取樣檢體不予編號但不列印標籤

** HTCLS-SPN-SW1 : A> 護理站取樣檢體自動編號且列印標籤,
**                 B> 護理站取樣檢體人工給號且列印標籤,
**                 C> 護理站取樣檢體不予編號且列印標籤
**                 Y> 護理站取樣檢體自動編號但不列印標籤,
**                 M> 護理站取樣檢體人工給號但不列印標籤,
**                 N> 護理站取樣檢體不予編號但不列印標籤
** HTCLS-SPN-SW2 : A> 家醫科取樣檢體自動編號且列印標籤,
**                 B> 家醫科取樣檢體人工給號且列印標籤,
**                 C> 家醫科取樣檢體不予編號且列印標籤
**                 Y> 家醫科取樣檢體自動編號但不列印標籤,
**                 M> 家醫科取樣檢體人工給號但不列印標籤,
**                 N> 家醫科取樣檢體不予編號但不列印標籤
**                 IF HTCLS-IP-SP NOT = 'N'
**                      ACCEPT HTCLS-SPN-SW & HTCLS-SPN-SW1 & HTCLS-SPN-SW2.
** HTCLS-DRG-SW  : Y> 細菌檢驗醫令須輸入抗生素, HTCLS-IP-RP MUST = 'C'
** HTCLS-OK-RP   : Y> 表該類別之檢驗檢查報告須經審核通過方可開放查詢印表
** HTCLS-FE-OP   : Y> 僅門急診允許先檢後批, A> 全部允許先檢後批
**                    CHECK 身份別 -- HT_SYS01.SON
** HTCLS-ML-OP   : A> 類別耗材, B> 細項耗材
** HTCLS-IP-RP   : A> 檢驗檢查, B> 部位檢查, C> 細菌檢驗, D> 血庫檢驗
**                 IF HTCLS-IP-RP = "B"        ACCEPT HTCLS-PST-TY.
** HTCLS-ML-SP   : A> 類別範例, B> 部位範例, C> 細部範例, D> 細項範例
**                 IF HTCLS-IP-RP = "B"    HTCLS-ML-SP = "A", "B", "C", "D" ELSE
**                                         HTCLS-ML-SP = "A", "D"
** HTCLS-ML-SW   : A> 人工耗材項, B> 自動耗材項, C> 批次耗材項
** HTCLS-RP-CS   : A> 細項報告, B> 綜合報告, C> 細項報告 & 綜合報告
** HTCLS-RP-SW   : 1> 數值型,   2> 代碼型,   3> 文字型,   4> 文件型
**                 IF HTCLS-RP-CS = "B"        MOVE SPACE TO HTCLS-RP-SW
** HTCLS-IO-SW   : Y> 外送排程項, S> 內部排程項, N> 非排程項,   A> 以上皆是
** HTCLS-SC-SW   : A> 人工排程項, B> 自動排程項, C> 批次排程項, N> 非排程項
**                 IF HTCLS-IO-SW = "N"        MOVE "N" TO HTCLS-SC-SW ELSE
**                 IF HTCLS-IO-SW = "Y"        MOVE "C" TO HTCLS-SC-SW ELSE
**                 IF HTCLS-IO-SW = "A" OR "S" ACCEPT HTCLS-SC-SW.
**                 IF HTCLS-SC-SW = "A" OR "B" 門急診簽收作業須CALL細項排程作業.
** HTCLS-SC-TM   : Y> 輸入排程時間 & HTCLS-IO-SW MUST = 'S' & HTCLS-SC-SW = 'A'
** HTCLS-MC-SW   : Y> 簽收後方可排程, N> 不經簽收即可排程, S> 排程後方可簽收
**                 IF HTCLS-IO-SW NOT = "N"    ACCEPT HTITM-MC-SW.
** HTCLS-MCW-TY  : 0> 非批次, 1> 門診, 　2> 急診, 　3> 住院,   4> 健檢,
**               　5> 其它,   6> 全部,   A> 非門診, B> 非急診, C> 非住院,
**                 D> 非健檢, E> 非其它, F> 門急住, G> 門急健, H> 門住健,
**                 I> 急住健, J> 門急,   K> 門住,   L> 門健,   M> 急住,
**                 N> 急健,   O> 住健
**                 IF HTCLS-MC-SW = "Y" AND HTCLS-SC-SW = "A" OR "B" THEN
**                      MOVE    "0" TO HTCLS-DATA-MCW                ELSE
**                 IF HTCLS-MC-SW = "Y" AND HTCLS-SC-SW = "C"        THEN
**                      ACCEPT  HTCLS-DATA-MCW.
** HTCLS-SG-SW   : Y> 單一細項報告, HTCLS-RP-SW = "2" IS REQUIRED
** HTCLS-SL-SW   : Y> 特殊檢查項
** HTCLS-RPT-RK  : Y> 報告列印類別醫令備註
** HTCLS-IP-RKAT : Y> 類別醫令自動備註
** HTCLS-OK-RKAT : Y> 類別審核自動備註
** HTCLS-IP-RKNO : MOVE "A1"          TO W-EDT-RPT-TY
**                 MOVE "2"           TO W-EDT-CPY-SW
**                 MOVE "C,M,D,I"     TO W-EDT-FUN-SW
**                 MOVE SPACES        TO W-EDT-USR-NO
**                 MOVE HTCLS-CLS-NO  TO W-EDT-CPY-KY
**                 MOVE HTCLS-IP-RKNO TO W-EDT-RPT-NO

**                 LINK HT_EDT.LNK &  CALL "HTEDTCF" USING W-EDT-TABLE
** HTCLS-OK-RKNO : MOVE "A2"          TO W-EDT-RPT-TY
**                 MOVE "2"           TO W-EDT-CPY-SW
**                 MOVE "C,M,D,I"     TO W-EDT-FUN-SW
**                 MOVE SPACES        TO W-EDT-USR-NO
**                 MOVE HTCLS-CLS-NO  TO W-EDT-CPY-KY
**                 MOVE HTCLS-OK-RKNO TO W-EDT-RPT-NO
**                 LINK HT_EDT.LNK &  CALL "HTEDTCF" USING W-EDT-TABLE
** HTCLS-RP-NO   : MOVE "12"          TO W-EDT-RPT-TY
**                 MOVE "2"           TO W-EDT-CPY-SW
**                 MOVE "C,M,D,I"     TO W-EDT-FUN-SW
**                 MOVE SPACES        TO W-EDT-USR-NO
**                 MOVE HTCLS-CLS-NO  TO W-EDT-CPY-KY
**                 MOVE HTCLS-RP-NO   TO W-EDT-RPT-NO
**                 LINK HT_EDT.LNK &  CALL "HTEDTCF" USING W-EDT-TABLE
** HTCLS-IDUP-SW : Y> 當檢驗(查)單即時傳輸細項數量>2時, 要作處理選擇, N>直接合併
** HTCLS-EMG-AC  : Y> 急診醫令開立且簽收
** HTCLS-AC-IP   : Y> 簽收時加印醫令單, R> 開立時加印醫令單
** HTCLS-CKM-SW  : Y> 簽收時輸入檢查人員, P> 簽收時輸入ＰＰＦ人員
** HTCLS-IP-EMG  : Y> 急件分單, M> 單項分單
** HTCLS-RPTD-SW : N> 報告不列印報告日期
** HTCLS-IRPT-SW : Y> 重要醫令即時報備
** HTCLS-INQ-SW  : Y> 限醫師方可查報告(報告查詢權限管制)
** HTCLS-WAB-SW  : Y> 檢體取樣單加印檢驗細項
*COPY    "HT_CTM.MST".
*************
* C-PY FILE : HT_CTM.MST    84/03/29    作者：謝枝財
* HT_MCTM LENGTH 250 BYTES  86/02/28    醫令單細項檔
*************
 FD HTCTM-MST IS EXTERNAL.
 01 HTCTM-REC.
   02 HTCTM-KEY.
      03 HTCTM-CHK-NO.
**       醫令單號
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-CLS-NO.
**          檢驗檢查類別代號
            05 HTCTM-DPT-CD             PIC X(1).
**             檢驗檢查科室簡碼
            05 HTCTM-CLS-CD             PIC X(2).
**             檢驗檢查類別碼
         04 HTCTM-PR-SEQ                PIC 9(5).
**          開單流水碼
      03 HTCTM-IP-DATE                  PIC 9(7).
**       醫令日期
      03 HTCTM-ITM-CD                   PIC X(6).
**       檢驗檢查細項流水號
   02 HTCTM-DATA.
      03 HTCTM-DATA-IP.
**       醫令資料
         04 HTCTM-P-KEY                 PIC X(21).
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-IP-PRS.
**          醫令處置資料                -- ALT-KEY8
            05 HTCTM-IP-NO              PIC X(22).
**             醫令序號
            05 HTCTM-PRS-NO             PIC X(9).

**             批價處置代碼
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-SPB-CD.
**          檢體容器代碼                -- ALT-KEY4
            05 HTCTM-SPL-CD             PIC X(1).
**             檢體代碼
            05 HTCTM-BTL-CD             PIC X(1).
**             容器代碼
         04 HTCTM-IO-SW                 PIC X(1).
**          排程對象碼 -- HTITM-IO-SW   -- ALT-KEY1
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-IP-DATA.
            05 HTCTM-GRP-SW             PIC X(1).
**             組合細項碼 -- HTITM-GRP-SW
            05 HTCTM-IP-MCSW            PIC X(1).
**             醫令儀器碼
            05 HTCTM-IP-QTY             PIC 9(2).
**             Ｘ光片張數或檢查次數
            05 HTCTM-IP-RKNO            PIC X(10).
**             細項醫令備註編號
      03 HTCTM-DATA-SC.
**       排程外送資料
         04 HTCTM-LNK-SW                PIC X(1).
**          雙主機排程碼                -- ALT-KEY3
         04 HTCTM-MC-NOP                PIC X(3).
**          指定檢查儀器代號 -- HTMCW-DPT-CD + HTMCW-MCH-CD
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-MC-SEQP               PIC 9(3).
**          指定儀器作業流水號 -- HTMCH-SEQ-NO
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-WRP-NO.
**          醫令排程外送單編號 -- HTWRP-WRP-NO  -- ALT-KEY1
            05 HTCTM-WRP-SW             PIC X(1).
**             單據識別碼
            05 HTCTM-WRP-DPT            PIC X(1).
**             印單單位簡碼
            05 HTCTM-WRP-DAT            PIC 9(7).
**             排程外送日期
            05 HTCTM-WRP-SEQ            PIC 9(2).
**             排程外送單流水號
      03 HTCTM-DATA-CK.
**       檢查資料
         04 HTCTM-MC-NOA                PIC X(3).
**          實際檢查儀器簡碼            -- ALT-KEY2
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-CK-DATA.
            05 HTCTM-MC-SEQA            PIC 9(3).
**             實際儀器作業流水號 -- HTMCH-SEQ-NO
            05 HTCTM-MC-TMA             PIC 9(7).
**             儀器作業實際耗時 (秒)
            05 HTCTM-CK-DATE            PIC 9(7).
**             檢查日期
            05 HTCTM-CK-TIME            PIC 9(6).
**             檢查時間
            05 HTCTM-CK-MAN             PIC X(5).
**             檢查人員
            05 HTCTM-US-DPT             PIC X(5).

**             耗用中心代號 -- HTITM-US-DPT
      03 HTCTM-DATA-RP.
**       細項報告資料
         04 HTCTM-RP-ST                 PIC X(1).
**          報告狀態碼                  -- ALT-KEY7
         04 HTCTM-RP-DATE               PIC 9(7).
**          報告日期                    -- ALT-KEY6
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-DATA-RP1.
            05 HTCTM-RP-TIME            PIC 9(6).
**             報告時間
            05 HTCTM-RP-MAN             PIC X(5).
**             報告人員
            05 HTCTM-RP-SW              PIC X(1).
**             報告型態碼 -- HTITM-RP-SW
            05 HTCTM-RP-DATA            PIC X(10).
**             細項報告內容或文件編號
            05 HTCTM-RP-NUMB REDEFINES HTCTM-RP-DATA PIC S9(7)V9(3).
**              數值型細項報告
            05 HTCTM-RP-CODE REDEFINES HTCTM-RP-DATA.
               06 HTCTM-RP-CD OCCURS 10 TIMES PIC X(1).
**                代碼型細項報告
            05 HTCTM-CS-DPT             PIC X(5).
**             成本中心代號 -- HTITM-CS-DPT
*$XFD USE GROUP, VAR-LENGTH
      03 HTCTM-DATA-OTH.
         04 HTCTM-DATA-OK.
**          細項審核資料
            05 HTCTM-OK-ST              PIC X(1).
**             審核狀態碼
            05 HTCTM-OK-DATE            PIC 9(7).
**             審核日期
            05 HTCTM-OK-TIME            PIC 9(6).
**             審核時間
            05 HTCTM-OK-MAN             PIC X(5).
**             審核人員
            05 HTCTM-OK-RKNO            PIC X(10).
**             細項審核備註編號
         04 HTCTM-RP-RKNO               PIC X(10).
**          報告備註片語編號 -- HTREF-?P-RKNO (86/02/21)
         04 HTCTM-SPL-SV                PIC 9(7).
**          檢體存放時間 (秒)           -- 86/02/28
         04 HTCTM-FILLER                PIC X(30).
**          空白項

** HTCTM-ALT-KEY1 = HTCTM-WRP-NO  + HTCTM-IO-SW   + HTCTM-P-KEY
**                  --> CREATE HT_WRC.TMP
** HTCTM-ALT-KEY2 = HTCTM-MC-NOA  + HTCTM-MC-NOP  + HTCTM-P-KEY
** HTCTM-ALT-KEY3 = HTCTM-LNK-SW  + HTCTM-RP-DATE +
**                  HTCTM-WRP-NO  + HTCTM-P-KEY
** HTCTM-ALT-KEY4 = HTCTM-CHK-NO  + HTCTM-IP-DATE +
**                  HTCTM-SPB-CD  + HTCTM-ITM-CD
** HTCTM-ALT-KEY6 = HTCTM-CLS-NO  + HTCTM-ITM-CD  +
**  (84/10/13)      HTCTM-RP-DATE + HTCTM-P-KEY
** HTCTM-ALT-KEY7 = HTCTM-RP-ST   + HTCTM-CLS-NO  +
**  (85/02/16)      HTCTM-RP-DATE + HTCTM-ITM-CD  + HTCTM-P-KEY
** HTCTM-ALT-KEY8 = HTCTM-IP-PRS  + HTCTM-P-KEY

**  (85/03/08)

** MOVE HTCTM-KEY TO HTCTM-P-KEY BEFORE READ & WRITE HT_CTM.MST
** HTCTM-ITM-NO (檢驗檢查項目代號) = HTCTM-CLS-NO + HTCTM-ITM-CD
** HTCTM-GRP-SW  : G> 全組合項,   P> 部份組合項, D> 單一細項, T> 展開細項
** HTCTM-WRP-SW  : C> 醫令排程單, D> 醫令外送單
** HTCTM-IP-MCSW : A> 醫令項,     B> 儀器項
** HTCTM-IO-SW   : Y> 外送排程項, S> 內部排程項, N> 非排程項
** HTCTM-LNK-SW  : Y> 雙主機已排程
** HTCTM-RP-SW   : 1> 數值型, HTCTM-RP-DA2  = SPACES
**                 2> 代碼型,
**                 3> 文字型,
**                 4> 文件型, HTCTM-RP-DATA = 細項報告文件編號
** HTCTM-RP-ST   : IF HTCTM-RP-SW = "1"
**                 H> 偏高值, L> 偏低值, D> 危險值, N> 正常值
**                 IF HTCTM-RP-SW = "2" OR "3"
**                 A> 異常報告, N> 正常報告
** HTCTM-OK-ST   : Y> 核准,     N> 批退, INITIALIZE HTCTM-DATA-SC
** HTCTM-IP-RKNO : MOVE "C1"          TO W-EDT-RPT-TY
**                 MOVE "M,D,I"       TO W-EDT-FUN-SW
**                 MOVE HTCHK-IP-MAN  TO W-EDT-USR-NO
**                 MOVE HTCTM-ITM-NO  TO W-EDT-CPY-KY
**                 MOVE HTCTM-IP-RKNO TO W-EDT-RPT-NO
**                 IF HTCTM-SEQ-SP = SPACES     THEN
**                      MOVE "3"      TO W-EDT-CPY-SW
**                 ELSE MOVE "4"      TO W-EDT-CPY-SW END-IF
**                 LINK HZ_EDT.LNK &  CALL "HZEDTCF" USING W-EDT-TABLE
** HTCTM-OK-RKNO : MOVE "C2"          TO W-EDT-RPT-TY
**                 MOVE "M,D,I"       TO W-EDT-FUN-SW
**                 MOVE HTCTM-RP-MAN  TO W-EDT-USR-NO
**                 MOVE HTCTM-ITM-NO  TO W-EDT-CPY-KY
**                 MOVE HTCTM-OK-RKNO TO W-EDT-RPT-NO
**                 IF HTCTM-SEQ-SP = SPACES     THEN
**                      MOVE "3"      TO W-EDT-CPY-SW
**                 ELSE MOVE "4"      TO W-EDT-CPY-SW END-IF
**                 LINK HZ_EDT.LNK &  CALL "HZEDTCF" USING W-EDT-TABLE
** HTCTM-RP-DATA : IF HTCTM-RP-SW = "4"  THEN
**                 MOVE "11"          TO W-EDT-RPT-TY
**                 MOVE "M,D,I"       TO W-EDT-FUN-SW
**                 MOVE HTCTM-RP-MAN  TO W-EDT-USR-NO
**                 MOVE HTCTM-ITM-NO  TO W-EDT-CPY-KY
**                 MOVE HTCTM-RP-DATA TO W-EDT-RPT-NO
**                 IF HTCTM-SEQ-SP = SPACES     THEN
**                      MOVE "3"      TO W-EDT-CPY-SW
**                 ELSE MOVE "4"      TO W-EDT-CPY-SW END-IF
**                 LINK HZ_EDT.LNK &  CALL "HZEDTCF" USING W-EDT-TABLE
** IF HTCTM-DATA-CK = SPACES    READ HTCHK-DATA-CK
** IF HTCTM-RP-SW = "1" OR "2"
**                 MOVE HTCTM-RP-DATA TO WTCTM-RP-DATA OF HT_CTM.WRK

** 作業說明：
**              =============== ================ =======================
**               資 料 項 目     作 業 階 段      資 料 來 源
**              =============== ================ =======================
**               HTCTM-GRP-SW    健檢,醫令,批價   HTITM-GRP-SW
**               HTCTM-DATA-IP   健檢,醫令,批價   健檢,醫令,批價系統
**               HTCTM-DATA-SC   細項排程外送     檢驗檢查系統

**               HTCTM-CK-MCP    醫令排程         HTITM- OR HTCLS-MC-DA
**               HTCTM-DATA-CK   檢驗檢查         檢驗檢查系統
**               HTCTM-DATA-RP   結果報告         檢驗檢查系統
**               HTCTM-DATA-OK   報告審核         檢驗檢查系統
*COPY    "HT_CTR.MST".
*************
* C-PY FILE : HT_CTR.MST    90/03/05    作者：謝枝財
* HT_MCTR LENGTH 101 BYTES  90/03/05    醫令單細項長文字報告檔
*************
 FD HTCTR-MST IS EXTERNAL.
 01 HTCTR-REC.
   02 HTCTR-KEY                         PIC X(21).
**    醫令單細項檔鍵值                  --HTCTR-KEY
*$XFD VAR-LENGTH
   02 HTCTR-DATA                        PIC X(80).
**    醫令單細項長文字報告內容

** 作業階段 : 報告登錄&查詢列印, 切檔, 回復
*COPY    "HT_ITM.MST".
* ==SCL== 2004.08.17 START ----- 加入MDLT儀器代碼設定 -------------------------*

*************
* C-PY FILE : HT_ITM.MST   84/03/27     作者：謝枝財
* HT_MITM LENGTH 300 BYTES 90/11/23     檢驗檢查項目定義檔
*************
 FD HTITM-MST IS EXTERNAL.
 01 HTITM-REC.
   02 HTITM-KEY.
      03 HTITM-ITM-NO.
**    檢驗檢查項目代號           (1:9)
        04 HTITM-CLS-NO.
**         檢驗檢查類別代號
           05 HTITM-DPT-CD              PIC X(1).
**            檢驗檢查科室簡碼   (1:1)
           05 HTITM-CLS-CD              PIC X(2).
**            檢驗檢查類別碼     (2:2)
*$XFD USE GROUP, VAR-LENGTH
        04 HTITM-ITM-CD                 PIC X(6).
**         檢驗檢查項目代碼      (4:6)
        04 HTITM-SEQ-NO REDEFINES HTITM-ITM-CD.
**         檢驗檢查流水號
           05 HTITM-SEQ-CD              PIC X(3).
**            檢驗檢查流水碼     (4:3)
           05 HTITM-SEQ-SP              PIC X(3).
**            空白項             (7:3)
        04 HTITM-PST-NO REDEFINES HTITM-ITM-CD.
**         部位檢查組合碼        (4:6)
           05 HTITM-PST-CD1             PIC X(2).
**            部位檢查部位碼     (4:2)
           05 HTITM-PST-CD2             PIC X(2).
**            部位檢查細部碼     (6:2)
           05 HTITM-PST-CD3             PIC X(2).
**            部位檢查微部碼     (8:2)
   02 HTITM-DATA.
      03 HTITM-ITM-NM                   PIC X(40).
**       檢驗檢查項目名稱 (10:40)
      03 HTITM-SEQ-MN                   PIC 9(3).

**       畫面選項序號     (50:3)        -- ALT-KEY4
      03 HTITM-FEE-CD1                  PIC X(12).
**       批價處置代號     (53:12)       -- ALT-KEY1
      03 HTITM-FEE-CD2                  PIC X(12).
**       批價處置代號     (65:12)       -- ALT-KEY6
      03 HTITM-MCH-CD                   PIC X(12).
**       儀器處置代號     (77:12)       -- ALT-KEY2
      03 HTITM-SYS-CD                   PIC X(12).
**       它系統處置代號   (89:12)       -- ALT-KEY3
      03 HTITM-GRP-SW                   PIC X(1).
**       組合識別碼      (101:1)        -- ALT-KEY9
      03 HTITM-GRP-SL                   PIC X(1).
**       組合選項碼      (102:1)
      03 HTITM-DATA-NGROUP.
**       非組合資料
         04 HTITM-REF-UT                PIC X(10).
**          檢驗值單位   (103:10)
*$XFD USE GROUP, VAR-LENGTH
         04 HTITM-DATA-SPL.
**          檢體容器資料 (113:10)
            05 HTITM-SPB-CD1.
**             檢體容器代碼１
               06 HTITM-SPL-CD1         PIC X(1).
**                檢體代碼１
               06 HTITM-BTL-CD1         PIC X(1).
**                容器代碼１
            05 HTITM-SPB-CD2.
**             檢體容器代碼２
               06 HTITM-SPL-CD2         PIC X(1).
**                檢體代碼２
               06 HTITM-BTL-CD2         PIC X(1).
**                容器代碼２
            05 HTITM-SPB-CD3.
**             檢體容器代碼３
               06 HTITM-SPL-CD3         PIC X(1).
**                檢體代碼３
               06 HTITM-BTL-CD3         PIC X(1).
**                容器代碼３
            05 HTITM-SPB-CD4.
**             檢體容器代碼４
               06 HTITM-SPL-CD4         PIC X(1).
**                檢體代碼４
               06 HTITM-BTL-CD4         PIC X(1).
**                容器代碼４
            05 HTITM-SPB-CD5.
**             檢體容器代碼５
               06 HTITM-SPL-CD5         PIC X(1).
**                檢體代碼５
               06 HTITM-BTL-CD5         PIC X(1).
**                容器代碼５
         04 HTITM-DATA-REF.
**          參考值資料
*$XFD USE GROUP, VAR-LENGTH
            05 HTITM-REF-DA.
               06 HTITM-EX-REF          PIC X(1).
**                存在參考碼  (123:1)
               06 HTITM-AG-REF          PIC X(1).

**                年齡參考碼
               06 HTITM-SX-REF          PIC X(1).
**                性別參考碼
               06 HTITM-SP-REF          PIC X(1).
**                檢體參考碼
               06 HTITM-TM-REF          PIC X(1).
**                時間參考碼
               06 HTITM-PR-REF          PIC X(1).
**                懷孕參考碼
               06 HTITM-PE-REF          PIC X(1).
**                荷爾蒙參考碼
            05 HTITM-ITM-RF             PIC X(9).
**             檢驗檢查項目參考代號     -- ALT-KEY7 (130:9)
*$XFD USE GROUP, VAR-LENGTH
         04 HTITM-DATA-RK.
**          細項備註範例資料  (139:33)
            05 HTITM-IP-RKAT            PIC X(1).
**             細項醫令備註自動碼
            05 HTITM-IP-RKNO            PIC X(10).
**             細項醫令備註範例編號
            05 HTITM-RP-RKAT            PIC X(1).
**             細項報告自動碼
            05 HTITM-RP-NO              PIC X(10).
**             細項報告文件範例編號
            05 HTITM-OK-RKAT            PIC X(1).
**             細項審核備註自動碼
            05 HTITM-OK-RKNO            PIC X(10).
**             細項審核備註範例編號
**-YMN- 981022
            05 HTITM-RP-CLS REDEFINES HTITM-OK-RKNO.
               06 HTITM-RPT-CLS         PIC X(1).
**                   乳房超音波報告評估分類是否啟用 (Y>啟用 #空白>不啟用)
               06 HTITM-RPT-EN          PIC X(1).
**                   報告列印方式呈現               (1.中文 2.英文 #空白>中英文)
               06 HTITM-RP-CLS-FILLER   PIC X(8).
**-YMN- 981022

         04 HTITM-DATA-ITM.
**          細項設定資料      (172:1)
            05 HTITM-SL-SW              PIC X(1).
**             特殊檢查碼               -- ALT-KEY5
*$XFD USE GROUP, VAR-LENGTH
            05 HTITM-ITM-DA.
**                            (173:37)
               06 HTITM-IO-FEE          PIC 9(6).
**                細項外送費用
               06 HTITM-IO-HSP          PIC X(12).
**                外送醫院代號
               06 HTITM-IO-SW           PIC X(1).
**                排程對象碼
               06 HTITM-SC-SW           PIC X(1).
**                排程方式碼
               06 HTITM-RP-SW           PIC X(1).
**                細項報告型態碼
               06 HTITM-SG-SW           PIC X(1).
**                單一細項報告碼
               06 HTITM-MC-SW           PIC X(1).

**                簽收後排程碼
**               06 HTITM-CS-DPT          PIC X(5).
**                成本中心代號
**               06 HTITM-US-DPT          PIC X(5).
**                耗用中心代號
               06 HTITM-EMG-PSW         PIC X.
**                急件檢驗時段設定碼    -- 90/01/30
               06 HTITM-EMG-PRD.
**                急件檢驗時段          -- 90/01/30
                  07 HTITM-EMG-B.
**                   開始時間
                     08 HTITM-EMG-BHH   PIC X.
**                      開始小時
                     08 HTITM-EMG-BMN   PIC X.
**                      開始分鐘
                  07 HTITM-EMG-EN.
**                   非假日結束時間
                     08 HTITM-EMG-ENHH  PIC X.
**                      非假日結束小時
                     08 HTITM-EMG-ENMN  PIC X.
**                      非假日結束分鐘
                  07 HTITM-EMG-EH.
**                   假日結束時間
                     08 HTITM-EMG-EHHH  PIC X.
**                      假日結束小時
                     08 HTITM-EMG-EHMN  PIC X.
**                      假日結束分鐘
                  07 HTITM-EMG-ES.
**                   週末結束時間
                     08 HTITM-EMG-ESHH  PIC X.
**                      週末結束小時
                     08 HTITM-EMG-ESMN  PIC X.
**                      週末結束分鐘
               06 HTITM-IPC-SW          PIC X(1).
**                同類別報告合併碼      -- 900309
               06 HTITM-VP-DA.
**                預定交件資料
                  07 HTITM-VP-TU        PIC X(1).
**                   預定交件時間單位碼
                  07 HTITM-ONLY-SEX     PIC X(1) REDEFINES HTITM-VP-TU.
**                   限定性別開立(1>男, 2>女)
                  07 HTITM-VP-TQ        PIC 9(3).
**                   預定交件時間數量
                  07 HTITM-HDG-ITM REDEFINES HTITM-VP-TQ.
                     08 HTITM-HDG-YN        PIC X(1).
*                       高風險檢查項目設定
                     08 HTITM-HDG-FILLER    PIC X(2).
*                       空白項
*980824
                     08 HTITM-HDG-FILLER1 REDEFINES HTITM-HDG-FILLER.
*980824 報告未發警示
                        09  HTITM-WARN-SW      PIC X(1).
                        09  HTITM-ITM-PART     PIC X(1).
*                           IC卡部位(新)        --YMN(98.9.30)


*$XFD USE GROUP, VAR-LENGTH

      03 HTITM-FILLER.
**                              (210:??)
         04 HTITM-ITM-NN                PIC X(10).
**          檢驗檢查項目簡稱    (210:10)
         04 HTITM-DEL-SW                PIC X(1).
**          刪除限制碼          (220:1)
         04 HTITM-RP-DATE               PIC 9(7).
**          最近報告日          (221:7)
         04 HTITM-DATA-UT.
**          檢驗值單位資料      (228:??)
            05 HTITM-REF-UT1            PIC X(10).
**             檢驗值單位１     (228:10) (當板橋院區單位不同於三重時設定)
            05 HTITM-REF-UT2            PIC X(10).
**             檢驗值單位２     (238:10)
* ==SCL== 2004.08.17 START ----- 加入MDLT儀器代碼設定 -------------------------*
            05 HTITM-MDLT-DA  REDEFINES HTITM-REF-UT2.
                06 HTITM-MDLT-DATA      PIC X(10).
*                  PACS 儀器下傳代碼設定 (EX . CT CR MR ANGIO ...)
* ==SCL== 2004.08.17 END   ----- 加入MDLT儀器代碼設定 -------------------------*
            05 HTITM-REF-UT3            PIC X(10).
**             檢驗值單位３     (248:10)
            05 HTITM-RPT-FIL3 REDEFINES HTITM-REF-UT3.
               06 HTITM-DATA-DPT-PC.
**                板橋排檢部門設定資料
                  07 HTITM-EMG-DPT-PC   PIC X(2).
**                   板橋急件排檢部門代號
                  07 HTITM-NMG-DPT-PC   PIC X(2).
**                   板橋非急件排檢部門代號
               06 HTITM-OLD-TRN-ITM-CD  PIC X(6).
**                北市舊碼轉新碼後存入舊碼的ITM-CD 做比對(暫存)…北市轉完後三個月刪除！

            05 HTITM-REF-UT4            PIC X(10).
**             檢驗值單位４     (258:10)
            05 HTITM-RPT-FIL4 REDEFINES HTITM-REF-UT4.
               06 HTITM-PRT-BIG-RPT     PIC X(1).
**                檢驗檢查結果列印放大
               06 HTITM-GRR-YN          PIC X(1).
**                檢驗檢查結果作門診陽性申報
               06 HTITM-CPU-YN          PIC X(1).
**                檢驗檢查結果有計算值
               06 HTITM-LBL-QTY         PIC 9(1).
**                標籤列印張數          -- 90/11/15
               06 HTITM-PRS-QTY         PIC X(1).
**                處置量>1不分單碼(Y/N) -- 90/11/23 --> PRS-PAS-QTY-MRK
               06 HTITM-NUM-FLOAT       PIC X(1).
**                數值型報告顯示小數後幾位 -- 910427
               06 HTITM-RF-PRT-YN       PIC X(1).
**                參考備註顯示(Y/E/N)   -- 930111
               06 HTITM-GRP-CNT-YN      PIC X(1).
**                組合細項亦作件數計算  -- 930525
               06 HTITM-ANN-CD          PIC X(1).
**                實施部位代碼(A、B、C、D、E)-- 931214
               06 HTITM-DNG-SW          PIC X(1).
**                危險值通報項目屬性
            05 HTITM-REF-UT5            PIC X(10).
**             檢驗值單位５     (268:10)
            05 HTITM-RPT-FIL5 REDEFINES HTITM-REF-UT5.

               06 HTITM-RPT-NO-REF      PIC X(1).
**                檢驗報告不印參考值
               06 HTITM-CHG-ITM-NO      PIC X(9).
**                檢驗報告替換的檢驗代碼
         04 HTITM-BRH-SW                PIC X(1).
**          血型RH檢查項        (278:1)
         04 HTITM-MSV-SW                PIC X(1).
**          非醫令項檢驗結果存檔碼  (279:1)
         04 HTITM-URG-SW                PIC X(1).
**          急診加成批價指定項  (280:1) -- 860618
**       04 HTITM-DATA-WK.
**          檢驗排程週資料      (281:7)
**          05 HTITM-SCH-WK OCCURS 7 TIMES PIC X(1).
**             週次排程指定碼           -- 860701
         04 HTITM-DATA-DPT.
**          排檢部門設定資料    (281:4) -- 871130       -- APPEND
            05 HTITM-EMG-DPT            PIC X(2).
**             急件排檢部門代號
            05 HTITM-NMG-DPT            PIC X(2).
**             非急件排檢部門代號
         04 HTITM-PPAT-SW               PIC X.
**          醫令單尾加印病患資料(285:1) -- 900314
         04 HTITM-DRS-SW                PIC X(1).
**          藥品管制碼          (286:1) -- 900412
         04 HTITM-ODR-HW                PIC X(1).
**          健檢指定項(Y/N)     (287:1) -- 900417
         04 HTITM-SCRP-SW               PIC X.
**          排程通知單設定碼    (288:1)
         04 HTITM-IRPT-SW               PIC X.
**          重要醫令即時報備    (289:1) -- 890614

** HTITM-ALT-KEY1 = HTITM-FEE-CD1 + HTITM-CLS-CD
**                  HTITM-DPT-CD  + HTITM-ITM-CD
** HTITM-ALT-KEY2 = HTITM-MCH-CD  + HTITM-ITM-NO
** HTITM-ALT-KEY3 = HTITM-SYS-CD  + HTITM-ITM-NO
** HTITM-ALT-KEY4 = HTITM-CLS-NO  + HTITM-SEQ-MN
** HTITM-ALT-KEY5 = HTITM-SL-SW   + HTITM-ITM-NO  (84/10/13)
** HTITM-ALT-KEY6 = HTITM-FEE-CD2 + HTITM-CLS-CD  (84/11/10)
**                  HTITM-DPT-CD  + HTITM-ITM-CD
** HTITM-ALT-KEY7 = HTITM-ITM-RF  + HTITM-ITM-NO  (84/12/15)
** HTITM-ALT-KEY8 = HTITM-CLS-CD  +
**                  HTITM-ITM-CD  + HTITM-DPT-CD  (85/03/04)
** HTITM-ALT-KEY9 = HTITM-CLS-NO  +
**                  HTITM-GRP-SW  + HTITM-ITM-CD  (85/02/08)

** HTITM-DEL-SW  : Y> 此細項不可刪除
** HTITM-GRP-SW  : Y> 醫令組合項, R> 報告組合項, N> 基本項
**                 IF HTITM-GRP-SW NOT = 'N'    ACCEPT HTITM-GRP-SL.
** HTITM-GRP-SL  : Y> 組合細項可進行單一選項
** HTITM-VP-TU   : D> 日, H> 時, M> 分, S> 秒, W> 週(星期幾)
** HTITM-RP-SW   : 1> 數值型, 2> 代碼型, 3> 文字型(10 BYTE), 4> 文件型, 5> 長文字型(57 BYTE--900305-->HT_CTR.MST)
** HTITM-IO-SW   : Y> 外送排程項, S> 內部排程項, N> 非排程項
**                 IF HTITM-GRP-SW = "Y"                    THEN
**                      MOVE "N" TO HTITM-SC-SW HTITM-IO-SW ELSE
**                 IF HTCLS-IO-SW  > "A"                    THEN
**                      MOVE HTCLS-IO-SW TO HTITM-IO-SW     ELSE
**                      ACCEPT HTITM-IO-SW (HTITM-IO-SW MUST = "S" OR "Y").

** HTITM-SC-SW   : A> 人工排程項, B> 自動排程項, C> 批次排程項, N> 非排程項
**                 IF HTITM-IO-SW = "N"      MOVE "N" TO HTITM-SC-SW ELSE
**                 IF HTITM-IO-SW = "Y"      MOVE "C" TO HTITM-SC-SW ELSE
**                                           MOVE HTCLS-SC-SW TO HTITM-SC-SW
**                                           ACCEPT HTITM-SC-SW.
** HTITM-MC-SW   : Y> 簽收後方可排程, N> 不經簽收即可排程
**                 IF HTITM-IO-SW NOT = "N"  ACCEPT HTITM-MC-SW.
** HTITM-SG-SW   : Y> 單一細項報告, HTITM-RP-SW = "2" IS REQUIRED
** HTITM-SL-SW   : Y> 特殊檢查項
** HTITM-URG-SW  : Y> 急診加成批價指定項, U> 急件指定項, M> 非急件指定項
** HTITM-MSV-SW  : N> 非醫令項之檢驗結果不存檔, 其餘表須存檔
** HTITM-BRH-SW  : B> 血型測定項, R> RH(D)型檢查項
** HTITM-SCH-WK  : Y> 有指定排程, N> 無指定排程, Q> 未指定排程
**                 IF HTITM-DATA-WK = SPACES                      THEN
**                    HTITM-SCH-WK(1)-(6) = 'Y' & HTITM-SCH-WK(7) = 'N'
** HTITM-EX-REF  : Y> 有「參考值」, CREATE HT_REF.MST
**                    IF HTITM-ITM-RF = SPACES
**                         MOVE HTITM-ITM-NO TO HTREF-ITM-NO
**                    ELSE MOVE HTITM-ITM-RF TO HTREF-ITM-NO
** HTITM-AG-REF  : Y> 參考值「年齡」變數
** HTITM-SX-REF  : Y> 參考值「性別」變數
** HTITM-SP-REF  : Y> 參考值「檢體」變數
** HTITM-TM-REF  : Y> 參考值「時間」變數
** HTITM-PR-REF  : Y> 參考值「懷孕」變數
** HTITM-PE-REF  : Y> 參考值「荷爾蒙」變數
** HTITM-IRPT-SW : Y> 重要醫令即時報備, MOVE 'Y' TO PRS-IRPT-RMK
** HTITM-RP-RKAT : Y> 細項自動報告
** HTITM-IP-RKAT : Y> 細項醫令自動備註
** HTITM-OK-RKAT : Y> 細項審核自動備註
** HTITM-SCRP-SW : Y> 排程通知單設定
**                 MOVE "CZ"          TO W-EDT-RPT-TY
**                 MOVE "2"           TO W-EDT-CPY-SW
**                 MOVE "C,M,D,I"     TO W-EDT-FUN-SW
**                 MOVE SPACES        TO W-EDT-USR-NO
**                 MOVE HTITM-CLS-NO  TO W-EDT-CPY-KY
**                 MOVE HTITM-ITM-NO  TO W-EDT-RPT-NO
**                 LINK HT_EDT.LNK &  CALL "HTEDTCF" USING W-EDT-TABLE
** HTITM-IP-RKNO : MOVE "C1"          TO W-EDT-RPT-TY
**                 MOVE "C,M,D,I"     TO W-EDT-FUN-SW
**                 MOVE SPACES        TO W-EDT-USR-NO
**                 MOVE HTITM-ITM-NO  TO W-EDT-CPY-KY
**                 MOVE HTITM-IP-RKNO TO W-EDT-RPT-NO
**                 IF HTITM-SEQ-SP = SPACES     THEN
**                      MOVE "3"      TO W-EDT-CPY-SW
**                 ELSE MOVE "4"      TO W-EDT-CPY-SW END-IF
**                 LINK HT_EDT.LNK &  CALL "HTEDTCF" USING W-EDT-TABLE
** HTITM-OK-RKNO : MOVE "C2"          TO W-EDT-RPT-TY
**                 MOVE "C,M,D,I"     TO W-EDT-FUN-SW
**                 MOVE SPACES        TO W-EDT-USR-NO
**                 MOVE HTITM-ITM-NO  TO W-EDT-CPY-KY
**                 MOVE HTITM-OK-RKNO TO W-EDT-RPT-NO
**                 IF HTITM-SEQ-SP = SPACES     THEN
**                      MOVE "3"      TO W-EDT-CPY-SW
**                 ELSE MOVE "4"      TO W-EDT-CPY-SW END-IF
**                 LINK HT_EDT.LNK &  CALL "HTEDTCF" USING W-EDT-TABLE
** HTITM-RP-NO   : MOVE "11"          TO W-EDT-RPT-TY
**                 MOVE "C,M,D,I"     TO W-EDT-FUN-SW

**                 MOVE SPACES        TO W-EDT-USR-NO
**                 MOVE HTITM-ITM-NO  TO W-EDT-CPY-KY
**                 MOVE HTITM-RP-NO   TO W-EDT-RPT-NO
**                 IF HTITM-SEQ-SP = SPACES     THEN
**                      MOVE "3"      TO W-EDT-CPY-SW
**                 ELSE MOVE "4"      TO W-EDT-CPY-SW END-IF
**                 LINK HT_EDT.LNK &  CALL "HTEDTCF" USING W-EDT-TABLE
** IF HTITM-ITM-NO IS ONE BY ONE TO HTITM-FEE-CD1 & HTITM-FEE-CD2 THEN
**         MOVE SPACES       TO HTITM-FEE-CD
**    ELSE MOVE HTITM-ITM-CD TO HTITM-FEE-CD.
** IF HTITM-DPT-CD = SPACES     HTITM-ITM-NO = 不分科室檢驗檢查項目代號.
** IF HTITM-GRP-SW = "Y" OR "R" MOVE   SPACE TO HTITM-DATA-NGROUP.
** IF HTCLS-RP-CS  = "B"        MOVE   SPACE TO HTITM-RP-SW.
** IF HTCLS-IP-RP  = "B"        ACCEPT HTITM-PST-NO
**    ELSE                      ACCEPT HTITM-SEQ-CD.
** HTITM-PPAT-SW : Y> 醫令單尾加印病患資料
** HTITM-DRS-SW  : F> 簽收時產生藥品管制資料, MUST HTCLS-DRS-SW = 'F' OR 'T'
**                 J> 報告時產生藥品管制資料, MUST HTCLS-DRS-SW = 'J' OR 'T'

** HTITM-ANN-CD  : A>頸部-->頭部  B>胸部 C>腹部 D>脊椎 E>上下肢
**                 現行於IC卡重要醫令上傳時使用，以區分大類。
**                 文件雖寫 頸部 ， 但是…大家覺得頸部 是 脊椎 的一部份，
**                 沒有頭部的設定，所以 A 改為 頭部
** -YAC- 2009.01.22 (北區醫院適用)
** 部位可輸入A~T
*>除原本A(頸部)、B(胸部)、C(全腹部)、D(全脊椎)、E(上下肢) 外。
*>需可設定：F(頭部)、G（頭+頸）、H（頸椎）、I（胸椎）、J（腰椎）、
*>K（薦椎）、L（尾椎）、M（上腹部）、N（下腹部）、O（骨盆腔）、
*>P（上肢）、Q（下肢）、R（全身）、S（心臟）、T（其他）。

** HTITM-DNG-SW  : A>重要且危急  B>重要但不危急(個管) C>重要但不危急(院感)

** HTITM-HDG-YN  : Y>高風險檢查項目  空白>非高風險檢查項目
*COPY    "HT_REF.MST".
*************
* C-PY FILE : HT_REF.MST    84/04/24    作者：謝枝財
* HT_MREF LENGTH 200 BYTES  86/02/28    檢驗檢查細項參考值檔
*************
 FD HTREF-MST IS EXTERNAL.
 01 HTREF-REC.
*$XFD USE GROUP, VAR-LENGTH
   02 HTREF-KEY.
      03 HTREF-ITM-NO                   PIC X(9).
**       檢驗檢查細項代號
      03 HTREF-SEX-CD                   PIC X(1).
**       性別代號
      03 HTREF-SPL-CD                   PIC X(1).
**       檢體代號
      03 HTREF-PER-ST                   PIC X(1).
**       荷爾蒙狀況
      03 HTREF-PRE-H                    PIC 9(2).
**       懷孕週數下限
      03 HTREF-AGE-H                    PIC 9(3).
**       年齡下限
      03 HTREF-TME-H                    PIC 9(7).
**       檢體存放時間下限 (秒)
      03 HTREF-TY-ID                    PIC X(1).

**       代碼文字型報告代碼
      03 HTREF-FILLER1                  PIC X(15).
**       空白項
*$XFD USE GROUP, VAR-LENGTH
   02 HTREF-DATA.
      03 HTREF-PRE-L                    PIC 9(2).
**       懷孕週數上限
      03 HTREF-AGE-L                    PIC 9(3).
**       年齡上限
      03 HTREF-TME-L                    PIC 9(7).
**       檢體存放時間上限 (秒)
      03 HTREF-DATA1.
**       數值型資料
         04 HTREF-REF-VLL               PIC S9(7)V9(3).
**          參考值上限
         04 HTREF-REF-VLH               PIC S9(7)V9(3).
**          參考值下限
         04 HTREF-DNG-VLL               PIC S9(7)V9(3).
**          危險值上限
         04 HTREF-DNG-VLH               PIC S9(7)V9(3).
**          危險值下限
      03 HTREF-DATA2 REDEFINES  HTREF-DATA1.
**       代碼文字型資料
         04 HTREF-TXT-SW                PIC X(1).
**          正異常識別碼 -- N> 正常, A> 異常
         04 HTREF-CDE-RF.
**          代碼型參考項
            05 HTREF-TXT-RF             PIC X(10).
**             文字型參考項
            05 HTREF-TXT-SP             PIC X(29).
**             空白項
      03 HTREF-DATA3.
**       數值型備註資料
         04 HTREF-HP-RKNO               PIC X(10).
**          偏高值備註片語編號
         04 HTREF-LP-RKNO               PIC X(10).
**          偏低值備註片語編號
         04 HTREF-DP-RKNO               PIC X(10).
**          危險值備註片語編號
      03 HTREF-DATA4 REDEFINES  HTREF-DATA3.
**       代碼文字型備註資料
         04 HTREF-AP-RKNO               PIC X(10).
**          異常備註片語編號
         04 HTREF-NP-RKNO               PIC X(10).
**          正常備註片語編號
         04 HTREF-SP-RKNO               PIC X(10).
**          空白項
      03 HTREF-FILLER2                  PIC X(78).
**       空白項

** HTREF-PER-ST  : M> Males
**                    Normally Menstruating Females
**                 F>  Follicular Phase
**                 C>  Mid-Cycle Pick
**                 L>  Luteal Phase
**                 P> Post-Menopausal Females
** HTREF-HP-RKNO : MOVE "CA" TO HTPHR-PHR-TY

** HTREF-LP-RKNO : MOVE "CB" TO HTPHR-PHR-TY
** HTREF-DP-RKNO : MOVE "CC" TO HTPHR-PHR-TY
** HTREF-AP-RKNO : MOVE "CD" TO HTPHR-PHR-TY
** HTREF-NP-RKNO : MOVE "CE" TO HTPHR-PHR-TY
** IF HTITM-RP-SW NOT = "2" AND "3"     MOVE SPACES TO HTREF-TY-ID
*COPY    "HT_SPL.MST".
*************
* C-PY FILE : HT_SPL.MST   84/03/23     作者：謝枝財
* HT_MSPL LENGTH 50 BYTES  85/03/04     檢體種類定義檔
*************
 FD HTSPL-MST IS EXTERNAL.
 01 HTSPL-REC.
   02 HTSPL-KEY.
      03 HTSPL-SPL-NO.
**        檢體代號
          04 HTSPL-DPT-CD               PIC X(1).
**           檢驗檢查科室簡碼
          04 HTSPL-SPL-CD               PIC X(1).
**           檢體代碼
*$XFD USE GROUP, VAR-LENGTH
   02 HTSPL-DATA.
      03 HTSPL-SPL-NM                   PIC X(20).
**       檢體名稱
      03 HTSPL-SPL-NN                   PIC X(6).
**       檢體簡稱
      03 HTSPL-IP-RKAT                  PIC X(1).
**       檢體醫令備註自動碼
      03 HTSPL-IP-RKNO                  PIC X(10).
**       檢體醫令備註範例編號
      03 HTSPL-FILLER                   PIC X(11).
**       空白項

** HTSPL-ALT-KEY = HTSPL-SPL-CD + HTSPL-DPT-CD

** HTSPL-IP-RKAT : Y> 檢體醫令自動備註
** HTSPL-IP-RKNO : MOVE "B1"          TO W-EDT-RPT-TY
**                 MOVE "1"           TO W-EDT-CPY-SW
**                 MOVE "C,M,D,I"     TO W-EDT-FUN-SW
**                 MOVE SPACES        TO W-EDT-USR-NO
**                 MOVE HTSPL-DPT-CD  TO W-EDT-CPY-KY
**                 MOVE HTSPL-IP-RKNO TO W-EDT-RPT-NO
**                 LINK HZ_EDT.LNK &  CALL "HZEDTCF" USING W-EDT-TABLE
** IF HTSPL-DPT-CD = SPACES     HTSPL-SPL-NO = 不分科室檢體代號
*COPY    "HT_BTL.MST".
*************
* C-PY FILE : HT_BTL.MST   84/03/08     作者：謝枝財
* HT_MBTL LENGTH 50 BYTES  85/03/02     容器種類定義檔
*************
 FD HTBTL-MST IS EXTERNAL.
 01 HTBTL-REC.
   02 HTBTL-KEY.
      03 HTBTL-BTL-NO.
**       容器代號
         04 HTBTL-DPT-CD                PIC X(1).
**          檢驗檢查科室簡碼
         04 HTBTL-BTL-CD                PIC X(1).
**          容器代碼

*$XFD USE GROUP, VAR-LENGTH
   02 HTBTL-DATA.
      03 HTBTL-BTL-NM                   PIC X(20).
**       容器名稱
      03 HTBTL-BTL-NN                   PIC X(6).
**       容器簡稱
      03 HTBTL-FILLER                   PIC X(22).
**       空白項

** HTBTL-ALT-KEY = HTBTL-BTL-CD + HTBTL-DPT-CD

** IF HTBTL-DPT-CD = SPACES     HTBTL-BTL-NO = 不分科室容器代號
*
*COPY "HT_V03.MST".
*************
* C-PY FILE : HT_V03.MST   88/07/15     作者：陳志彥
* HT_MV03 LENGTH  80 BYTES 88/07/15     細菌室 -> 報告敘述類型定義檔
*************
 FD HTV03-MST IS EXTERNAL.
 01 HTV03-REC.
   02 HTV03-KEY.
      03 HTV03-DPT-CD                   PIC X(2).
      03 HTV03-V03-CD.
         04 HTV03-V03-CD1               PIC X(1).
         04 HTV03-V03-CD2               PIC X(1).
   02 HTV03-CLS-CD                      PIC X(2).
   02 HTV03-DATA.
      03 HTV03-SEL-MULTI                PIC X(1).
      03 HTV03-SEL-NN                   PIC X(1).
      03 HTV03-NM                       PIC X(20).
   02 HTV03-FILLER                      PIC X(54).

** HTV03-ALT-KEY1 = HTV03-CLS-CD + HTV03-KEY

** HTV04-V04-CD1 : A>No growth  B>Blood culture  C>一般抗藥性試驗
**                 D>細菌染色  E>結核菌  F>黴菌染色  G>黴菌培養
**                 Y>檢體  0>備註

*COPY "HT_V02.MST".
*************
* C-PY FILE : HT_V02.MST   88/07/20     作者：陳志彥
* HT_MV02 LENGTH 120 BYTES 88/07/20     細菌室 -> 報告敘述設定檔
*************
 FD HTV02-MST IS EXTERNAL.
 01 HTV02-REC.
   02 HTV02-KEY.
      03 HTV02-DPT-CD                   PIC X(2).
      03 HTV02-V02-CD.
         04 HTV02-V02-CD1               PIC X(1).
         04 HTV02-V02-CD2               PIC X(1).
      03 HTV02-PHR-CD                   PIC X(2).
   02 HTV02-SEQ-NM                      PIC 9(2).
** 畫面選項序號                         -- ALT-KEY1
*$XFD USE GROUP, VAR-LENGTH
   02 HTV02-DATA.
      03 HTV02-NN                       PIC X(16).
      03 HTV02-NM                       PIC X(60).

      03 HTV02-VIRNO                    PIC X(07).
      03 HTV02-SHOW-HEAD                PIC X(01).
      03 HTV02-POSITIVE-YN              PIC X(01).
      03 HTV02-APL-CLS                  PIC X(01).
      03 HTV02-FILLER                   PIC X(26).

** HTV02-ALT-KEY1 = HTV02-DPT-CD  + HTV02-V02-CD + HTV02-SEQ-NM + HTV02-PHR-CD

** HTV02-V02-CD1 : A>No growth  B>Blood culture  C>一般抗藥性試驗
**                 D>細菌染色  E>結核菌  F>黴菌染色  G>黴菌培養  Y>檢體  0>備註

** HTV02-SHOW-HEAD : SHOW 標頭用

*COPY "HT_V05.MST".
*************
* C-PY FILE : HT_V05.MST   88/08/19     作者：陳志彥
* HT_MV05 LENGTH 100 BYTES 88/08/19     細菌室 -> 抗生素菌數設定作業
*************
 FD HTV05-MST IS EXTERNAL.
 01 HTV05-REC.
   02 HTV05-KEY.
      03 HTV05-ANT-NO                   PIC X(5).
   02 HTV05-SEQ-NM                      PIC 9(2).
** 畫面選項序號                         -- ALT-KEY1
*$XFD USE GROUP
   02 HTV05-DATA1.
      03 HTV05-DRUG-NO                  PIC X(6).
      03 HTV05-DRUG-NN                  PIC X(20).
      03 HTV05-DRUG-NM                  PIC X(40).
*$XFD USE GROUP, VAR-LENGTH
   02 HTV05-DATA2.
      03 HTV05-FILLER                   PIC X(27).

** HTV05-ALT-KEY1 = HTV05-SEQ-NM + HTV05-ANT-NO

*COPY "HT_VNO.MST".
*************
* C-PY FILE : HT_VNO.MST   88/07/22     作者：陳志彥
* HT_MVNO LENGTH 200 BYTES 88/07/25     細菌室受檢檢體編號檔
*************
 FD HTVNO-MST IS EXTERNAL.
 01 HTVNO-REC.
   02 HTVNO-KEY.
*$XFD USE GROUP
      03 HTVNO-VNO-ID                   PIC X(1).
**       檢體編號規則
      03 HTVNO-VNO-NO                   PIC X(15).
**       受檢檢體編號
      03 HTVNO-VNO-NO1 REDEFINES HTVNO-VNO-NO.
         04 HTVNO-V01-CD1               PIC X(1).
**          檢體編號編碼型態
         04 HTVNO-YEAR-CD1              PIC X(2).
**          西元紀年後兩碼
         04 HTVNO-SEQ-NO1               PIC 9(5).
**          受檢檢體流水號
         04 HTVNO-NO-FIL1               PIC X(7).
**          空白項

      03 HTVNO-VNO-NO2 REDEFINES HTVNO-VNO-NO.
         04 HTVNO-V01-CD2               PIC X(1).
**          檢體編號編碼型態
         04 HTVNO-MON-CD2               PIC X(4).
**          國曆年月
         04 HTVNO-SEQ-NO2               PIC 9(4).
**          受檢檢體流水號
         04 HTVNO-NO-FIL2               PIC X(6).
**          空白項
      03 HTVNO-VNO-NO3 REDEFINES HTVNO-VNO-NO.
         04 HTVNO-V01-CD3               PIC X(1).
**          檢體編號編碼型態
         04 HTVNO-DAT-CD3               PIC X(6).
**          國曆年月日
         04 HTVNO-SEQ-NO3               PIC 9(3).
**          受檢檢體流水號
         04 HTVNO-NO-FIL3               PIC X(5).
**          空白項
   02 HTVNO-DATA.
*$XFD USE GROUP
      03 HTVNO-VNO-ON                   PIC X(15).
**       受檢檢體對應編號
      03 HTVNO-VNO-ON1 REDEFINES HTVNO-VNO-ON.
         04 HTVNO-VON-V01-CD1           PIC X(1).
**          檢體編號編碼型態
         04 HTVNO-VON-YEAR-CD1          PIC X(2).
**          西元紀年後兩碼
         04 HTVNO-VON-SEQ-NO1           PIC 9(5).
**          受檢檢體對應流水號 = 100000 - HTVNO-SEQ-NO1
         04 HTVNO-VON-NO-FIL1           PIC X(7).
**          空白項
      03 HTVNO-VNO-ON2 REDEFINES HTVNO-VNO-ON.
         04 HTVNO-VON-V01-CD2           PIC X(1).
**          檢體編號編碼型態
         04 HTVNO-VON-MON-CD2           PIC X(4).
**          國曆年月
         04 HTVNO-VON-SEQ-NO2           PIC 9(4).
**          受檢檢體對應流水號 = 10000  - HTVNO-SEQ-NO2
         04 HTVNO-VON-NO-FIL2           PIC X(6).
**          空白項
      03 HTVNO-VNO-ON3 REDEFINES HTVNO-VNO-ON.
         04 HTVNO-VON-V01-CD3           PIC X(1).
**          檢體編號編碼型態
         04 HTVNO-VON-DAT-CD3           PIC X(6).
**          國曆年月日
         04 HTVNO-VON-SEQ-NO3           PIC 9(3).
**          受檢檢體對應流水號 = 1000   - HTVNO-SEQ-NO3
         04 HTVNO-VON-NO-FIL3           PIC X(5).
**          空白項
      03 HTVNO-VPL-CD                   PIC X(1).
**       檢體代碼
*$XFD USE GROUP
   02 HTVNO-CHK-TABLE.
      03 HTVNO-CHK-REC OCCURS 9 TIMES.
         04 HTVNO-CHK-NO                PIC X(8).
         04 HTVNO-IP-DATE               PIC 9(7).
**       醫令日期

   02 HTVNO-AC-DATE                     PIC 9(7).
**    收件日期
   02 HTVNO-FILLER                      PIC X(26).
**    空白項


** HTVNO-ALT-KEY1 = HTVNO-VNO-ID  HTVNO-VNO-ON
** HTVNO-ALT-KEY2 = HTVNO-VNO-ID  HTVNO-AC-DATE  HTVNO-VNO-NO

** HTVNO-VNO-ID  : 1> 年  2> 年月  3> 年月日


*
*COPY "HT_VVV.MST".
*************
* C-PY FILE : HT_VVV.MST   88/11/04     作者：陳志彥
* HT_MVVV LENGTH 302 BYTES 88/11/04     細菌室 -> 系統參數設定檔
*************
 FD HTVVV-MST IS EXTERNAL.
 01 HTVVV-REC.
   02 HTVVV-KEY.
      03 HTVVV-DPT-CD.
         04 HTVVV-DPT-CD1               PIC X(1).
         04 HTVVV-DPT-CD2               PIC X(1).
   02 HTVVV-DATA1                       PIC X(100).
   02 HTVVV-DATA2                       PIC X(100).
   02 HTVVV-DATA3                       PIC X(100).

** HTVVV-DPT-CD1 : T> 檢驗科
** HTVVV-DPT-CD2 : V> 細菌室


*COPY "HT_VK1.MST".
*************
* C-PY FILE : HT_VK1.MST   88/07/25     作者：陳志彥
* HT_MVK1 LENGTH 300 BYTES 89/03/28     細菌室檢驗結果主檔
*************
 FD HTVK1-MST IS EXTERNAL.
 01 HTVK1-REC.
   02 HTVK1-KEY.
      03 HTVK1-CHK-NO.
         04 HTVK1-CLS-NO                PIC X(3).
         04 HTVK1-PR-SEQ                PIC 9(5).
      03 HTVK1-IP-DATE                  PIC 9(7).
**       醫令日期
   02 HTVK1-IP-DATE1                    PIC 9(7).
**    醫令日期 9999999 - HTVK1-IP-DATE
*$XFD USE GROUP
   02 HTVK1-PT-NO                       PIC 9(8).
**    病歷號碼
   02 HTVK1-IP-DATA.
**    醫令資料
*$XFD USE GROUP, VAR-LENGTH
      03 HTVK1-IP-NO                    PIC X(22).
**       醫令序號
      03 HTVK1-IP-NO1 REDEFINES HTVK1-IP-NO.
**       門診醫令序號

         04 HTVK1-RO-NO                 PIC 9(11).
**          門診序號
         04 HTVK1-OR-NO                 PIC 9(2).
**          處方序號
         04 HTVK1-RO-FL                 PIC X(9).
**          空白項
      03 HTVK1-IP-NO2 REDEFINES HTVK1-IP-NO.
**       住院醫令序號
         04 HTVK1-PD-NO                 PIC 9(11).
**          住院序號
         04 HTVK1-OD-NO                 PIC 9(11).
**          處方序號
      03 HTVK1-DATA-IP.
         04 HTVK1-PT-SEX                PIC X(1).
**          性別
         04 HTVK1-PT-ID                 PIC X(10).
**          身份證號
         04 HTVK1-PT-NAME               PIC X(12).
**          姓名
         04 HTVK1-IP-BED                PIC X(6).
**          病床床號
         04 HTVK1-IP-CLSW               PIC X(1).
**          醫令來源碼
         04 HTVK1-PT-IDNT               PIC X(4).
**          病患身份
   02 HTVK1-VPL-DATA.
**    檢體資料
*$XFD USE GROUP
      03 HTVK1-VNO-NO                   PIC X(15).
**       受檢檢體編號
      03 HTVK1-VNO-NO1 REDEFINES HTVK1-VNO-NO.
         04 HTVK1-V01-CD1               PIC X(1).
**          檢體編號編碼型態
         04 HTVK1-YEAR-CD1              PIC X(2).
**          西元紀年後兩碼
         04 HTVK1-SEQ-NO1               PIC 9(5).
**          受檢檢體流水號
         04 HTVK1-NO-FIL1               PIC X(7).
**          空白項
      03 HTVK1-VNO-NO2 REDEFINES HTVK1-VNO-NO.
         04 HTVK1-V01-CD2               PIC X(1).
**          檢體編號編碼型態
         04 HTVK1-MON-CD2               PIC X(4).
**          國曆年月
         04 HTVK1-SEQ-NO2               PIC 9(4).
**          受檢檢體流水號
         04 HTVK1-NO-FIL2               PIC X(6).
**          空白項
      03 HTVK1-VNO-NO3 REDEFINES HTVK1-VNO-NO.
         04 HTVK1-V01-CD3               PIC X(1).
**          檢體編號編碼型態
         04 HTVK1-DAT-CD3               PIC X(6).
**          國曆年月日
         04 HTVK1-SEQ-NO3               PIC 9(3).
**          受檢檢體流水號
         04 HTVK1-NO-FIL3               PIC X(5).
**          空白項

      03 HTVK1-VPL-CD                   PIC X(1).
**       檢體代碼
      03 HTVK1-VPL-NM                   PIC X(40).
**       檢體來源
   02 HTVK1-AC-DATE                     PIC 9(7).
**    簽收日期
   02 HTVK1-RP-DATE                     PIC 9(7).
**    報告日期
   02 HTVK1-OK-DATE                     PIC 9(7).
**    審核日期
*$XFD USE GROUP
   02 HTVK1-VR-DATA.
      03 HTVK1-VR-CD                    PIC X(1).
**       報告序述類型
      03 HTVK1-BC-SW                    PIC X(1).
**       是否為 BLOOD CULTURE
      03 HTVK1-WK-SW                    PIC X(1).
**       作業階段
      03 HTVK1-VRNO                     PIC 9(1).
**       菌數
      03 HTVK1-VR-DATE                  PIC 9(7).
**       檢驗日期
      03 HTVK1-AC-TIME                  PIC 9(6).
**       簽收時間
      03 HTVK1-AC-MAN                   PIC X(5).
**       簽收人員
      03 HTVK1-RP-TIME                  PIC 9(6).
**       報告時間
      03 HTVK1-RP-MAN                   PIC X(5).
**       報告人員
      03 HTVK1-OK-TIME                  PIC 9(6).
**       審核時間
      03 HTVK1-OK-MAN                   PIC X(5).
**       審核人員
      03 HTVK1-FIRST-YN                 PIC X(1).
**       初次報告
      03 HTVK1-FINAL-YN                 PIC X(1).
**       二次報告
      03 HTVK1-APL-YN                   PIC X(1).
**       是否申報
      03 HTVK1-APL-DATE                 PIC 9(7).
**       申報日期
*$XFD USE GROUP, VAR-LENGTH
   02 HTVK1-FILL                        PIC X(83).
**    空白項

** HTVK1-ALT-KEY1  = HTVK1-IP-DATE  + HTVK1-CHK-NO
** HTVK1-ALT-KEY2  = HTVK1-AC-DATE  + HTVK1-KEY
** HTVK1-ALT-KEY3  = HTVK1-RP-DATE  + HTVK1-KEY
** HTVK1-ALT-KEY4  = HTVK1-OK-DATE  + HTVK1-KEY
** HTVK1-ALT-KEY5  = HTVK1-VNO-NO   + HTVK1-KEY
** HTVK1-ALT-KEY6  = HTVK1-IP-NO    + HTVK1-VPL-CD   + HTVK1-VNO-NO +
**                   HTVK1-KEY
** HTVK1-ALT-KEY7  = HTVK1-PT-NO    + HTVK1-IP-DATE1 + HTVK1-KEY

** HTVK1-IP-CLSW : A> 批價系統, B> 醫令系統, C> 住院系統, D> 個人健檢,
**                 E> 團體健檢, F> 醫令補登, G> 單筆傳輸, H> 下傳補開


** HTVK1-WK-SW   : A> 醫令開立作業, E> 醫令簽收作業, H> 初次報告作業,
**                 J> 結果報告作業,
**                    IF HTCHK-RP-ST = "Y" MOVE "正常報告" TO 醫令流程
**                    IF HTCHK-RP-ST = "N" MOVE "異常報告" TO 醫令流程
**                 K> 報告審核作業,
**                    IF HTCHK-OK-ST = "Y" MOVE "審核通過" TO 醫令流程
**                    IF HTCHK-OK-ST = "N" MOVE "審核批退" TO 醫令流程

** HTVK1-FINAL-YN: Y> 最終報告

** HTVK1-APL-YN  : Y> 已申報  N> 未申報

** HTVK1-APL-DATE: 申報日期

*COPY "HT_VK2.MST".
*************
* C-PY FILE : HT_VK2.MST   88/10/22     作者：陳志彥
* HT_MVK2 LENGTH 180 BYTES 88/10/22     細菌室檢驗結果明細檔(適用 → 抗藥性試驗)
*************
 FD HTVK2-MST IS EXTERNAL.
 01 HTVK2-REC.
   02 HTVK2-KEY.
*$XFD USE GROUP
      03 HTVK2-CHK-NO.
**       檢驗單號
         04 HTVK2-DPT-CD                PIC X(1).
         04 HTVK2-CLS-CD                PIC X(2).
         04 HTVK2-PR-SEQ                PIC 9(5).
      03 HTVK2-IP-DATE                  PIC 9(7).
**       醫令日期
      03 HTVK2-VR-NUM                   PIC 9(1).
**       菌落編號
   02 HTVK2-VR-VIRNO                    PIC X(7).
**    病原菌代號
*$XFD USE GROUP, VAR-LENGTH
   02 HTVK2-VR-DATA.
      03 HTVK2-ANT-YN                   PIC X(1).
**       是否作敏感性試驗
      03 HTVK2-VR-ATE                   PIC X(1).
**       抗生素組合代號
      03 HTVK2-VR-WAY                   PIC X(1).
**       敏感試驗方法
      03 HTVK2-VR-LEVEL                 PIC X(1).
**       程度碼
      03 HTVK2-VR-COUNT.
**       數量單位
         04 HTVK2-VR-COUNT1             PIC X(1).
**          ( > < = 無 )
         04 HTVK2-VR-COUNT2             PIC 9(6).
**          數量單位
      03 HTVK2-VR-FILLER                PIC X(10).
**       空白項
*$XFD USE GROUP, VAR-LENGTH
   02 HTVK2-RP-DATA.
**    報告資料
      03 HTVK2-RP-DOC                   PIC X(60).

**       抗藥性報告敘述
      03 HTVK2-RP-FILLER                PIC X(10).
**       空白項
   02 HTVK2-AC-DATE                     PIC 9(7).
**    簽收日期
   02 HTVK2-IP-BED.
**    病房床號
      03 HTVK2-BED-ROOM                 PIC X(04).
**       病房
      03 HTVK2-BED-NO                   PIC X(02).
**       床號
   02 HTVK2-VPL-CD                      PIC X(01).
**    檢體代號
*$XFD USE GROUP, VAR-LENGTH
   02 HTVK2-FILLER.
**       其他資料
      03 HTVK2-IP-CLSW                  PIC X(1).
**       醫令來源碼
      03 HTVK2-PT-IDNT                  PIC X(4).
**       病患身份
      03 HTVK2-FILLER1                  PIC X(54).
**       空白項


** HTVK2-ALT-KEY1 = HTVK2-VR-VIRNO + HTVK2-AC-DATE  + HTVK2-CHK-NO   +
**                  HTVK2-IP-DATE  + HTVK2-VR-NUM

** HTVK2-ALT-KEY2 = HTVK2-BED-ROOM + HTVK2-VR-VIRNO + HTVK2-AC-DATE  +
**                  HTVK2-CHK-NO   + HTVK2-IP-DATE  + HTVK2-VR-NUM

** HTVK2-ALT-KEY3 = HTVK2-VPL-CD   + HTVK2-VR-VIRNO + HTVK2-AC-DATE  +
**                  HTVK2-CHK-NO   + HTVK2-IP-DATE  + HTVK2-VR-NUM

** HTVK2-ALT-KEY4 = HTVK2-AC-DATE  + HTVK2-CHK-NO   + HTVK2-IP-DATE  +
**                  HTVK2-VR-VIRNO + HTVK2-VR-NUM

** HTVK2-VR-WAY    : 1> DDM 法 2> MIC 法
** HTVK2-VR-LEVEL  : 1> 正常 2> 少 3> 中 4> 多
** HTVK2-VR-COUNT1 : 1> 無   2> >  3> <
** HTVK2-IP-CLSW : A> 批價系統, B> 醫令系統, C> 住院系統, D> 個人健檢,
**                 E> 團體健檢, F> 醫令補登, G> 單筆傳輸, H> 下傳補開

*COPY "HT_VK3.MST".
*************
* C-PY FILE : HT_VK3.MST   88/10/22     作者：陳志彥
* HT_MVK3 LENGTH 100 BYTES 88/10/22     細菌室檢驗結果明細檔(適用 → 抗藥性試驗)
*************
 FD HTVK3-MST IS EXTERNAL.
 01 HTVK3-REC.
   02 HTVK3-KEY.
*$XFD USE GROUP
      03 HTVK3-CHK-KEY.
         04 HTVK3-CHK-NO.
            05 HTVK3-DPT-CD             PIC X(1).
            05 HTVK3-CLS-CD             PIC X(2).
            05 HTVK3-PR-SEQ             PIC 9(5).
         04 HTVK3-IP-DATE               PIC 9(7).

**          醫令日期
      03 HTVK3-VR-NUM                   PIC 9(1).
*        >菌落編號
      03 HTVK3-VR-ANTNUM                PIC 9(2).
*        >敏感試驗編號
   02 HTVK3-VR-VIRNO                    PIC X(7).
*     >菌名
   02 HTVK3-VR-DATA1.
      03 HTVK3-VR-ANTNO                 PIC X(5).
*        >抗生素代號
*$XFD USE GROUP, VAR-LENGTH
   02 HTVK3-VR-DATA2.
      03 HTVK3-VR-MIC.
*        >MIC 稀釋倍數序號
         04 HTVK3-VR-MIC1               PIC X.
         04 HTVK3-VR-MIC2               PIC 9(2).
*        >MIC 抗生素濃度
         04 HTVK3-VR-MIC3               PIC X(6).
      03 HTVK3-VR-DDM                   PIC X(2).
*        >DDM無菌落區
      03 HTVK3-SUSNO                    PIC X.
*        >敏感代號
      03 HTVK3-VR-FILLER                PIC X(6).
**       空白項
   02 HTVK3-AC-DATE                     PIC 9(7).
**    簽收日期
*$XFD USE GROUP, VAR-LENGTH
   02 HTVK3-FILLER.
**       其他資料
      03 HTVK3-IP-CLSW                  PIC X(1).
**       醫令來源碼
      03 HTVK3-PT-IDNT                  PIC X(4).
**       病患身份
      03 HTVK3-FILLER1                  PIC X(40).
**       空白項

** HTVK3-ALT-KEY1  = HTVK3-VR-VIRNO + HTVK3-VR-ANTNO + HTVK3-AC-DATE  +
**                   HTVK3-CHK-KEY  + HTVK3-VR-NUM   + HTVK3-VR-ANTNUM

** HTVK3-VR-MIC1  : 1> 無   2> >  3> <
** HTVK3-SUSNO    : S> Susceptible  M> Moderately  I> Intermediate  R> Risistant


*COPY "HT_VK4.MST".
*************
* C-PY FILE : HT_VK4.MST   88/07/25     作者：陳志彥
* HT_MVK4 LENGTH 805 BYTES 89/04/11     細菌室檢驗結果明細檔(適用 → 所有試驗)
*************
 FD HTVK4-MST IS EXTERNAL.
 01 HTVK4-REC.
   02 HTVK4-KEY.
*$XFD USE GROUP
      03 HTVK4-CHK-NO.
         04 HTVK4-DPT-CD                PIC X(1).
         04 HTVK4-CLS-CD                PIC X(2).
         04 HTVK4-PR-SEQ                PIC 9(5).
      03 HTVK4-IP-DATE                  PIC 9(7).

**       醫令日期
*$XFD USE GROUP
      03 HTVK4-RP-CD.
         04 HTVK4-V03-CD                PIC X(2).
**          報告類型
      03 HTVK4-SEQ-NM                   PIC 9(1).
**       備註序號
   02 HTVK4-AC-DATE                     PIC 9(7).
**    簽收日期
   02 HTVK4-RESULT                      PIC X(1).
**    檢驗結果
   02 HTVK4-RP-DATA.
**    報告資料
*$XFD USE GROUP, VAR-LENGTH
      03 HTVK4-RP-DATA1.
         04 HTVK4-RP-DOC1               PIC X(60).
         04 HTVK4-RP-DOC2               PIC X(60).
         04 HTVK4-RP-DOC3               PIC X(60).
*$XFD USE GROUP, VAR-LENGTH
      03 HTVK4-RP-DATA2.
         04 HTVK4-RP-DOC4               PIC X(60).
         04 HTVK4-RP-DOC5               PIC X(60).
         04 HTVK4-RP-DOC6               PIC X(60).
*$XFD USE GROUP, VAR-LENGTH
      03 HTVK4-RP-DATA3.
         04 HTVK4-RP-DOC7               PIC X(60).
         04 HTVK4-RP-DOC8               PIC X(60).
         04 HTVK4-RP-DOC9               PIC X(60).
*$XFD USE GROUP, VAR-LENGTH
      03 HTVK4-RP-DATA4.
         04 HTVK4-RP-DOCA               PIC X(60).
         04 HTVK4-RP-DOCB               PIC X(60).
         04 HTVK4-RP-DOCC               PIC X(60).
*$XFD USE GROUP, VAR-LENGTH
   02 HTVK4-FILLER.
**       其他資料
      03 HTVK4-IP-CLSW                  PIC X(1).
**       醫令來源碼
      03 HTVK4-PT-IDNT                  PIC X(4).
**       病患身份
      03 HTVK4-FIRST-YN                 PIC X(1).
**       血液培養初次報告
      03 HTVK4-FILLER1                  PIC X(53).
**       空白項

** HTVK4-ALT-KEY1 = HTVK4-RP-CD    HTVK4-AC-DATE
**                  HTVK4-CHK-NO   HTVK4-IP-DATE.

** HTVK4-RESULT：Y> 陽性反應  N> 陰性反應


*
*COPY "HM_SIDX.MST" REPLACING ==HMSID-MST.== BY ==HMSID-MST IS EXTERNAL.==.
*<< BOF OF HM_SIDX.MST >>*******************************************************
*------------------------------------------------------------------------------*
*   檔名: 系統管理參數定義檔                                                   *
*   型別: SYBASE                                                               *

*   建檔日: 1996/11/01   修改日: 1996/11/01      長度: 212      作者: 陳世勇   *
*------------------------------------------------------------------------------*
*------------------------------------------------------------------------------*
* FILE NAME     IS HM_MSID                                                     *
* FILE STATUS   IS W-FS-HMSID                                                  *
* RECORD    KEY IS HMSID-KEY                                                   *
* ALTERNATE KEY IS HMSID-KEY-ALT1 = HMSID-USER-NO HMSID-USER-PASS HMSID-KEY    *
*------------------------------------------------------------------------------*
 FD  HMSID-MST.
 01  HMSID-REC.
*((XFD USE GROUP))
    02  HMSID-KEY.
*       系統代號 (ex. "HM":醫學研究統計, "TV": 'T'檢驗科, 'V'微生物室)
        03  HMSID-SYS-CODE.
*           >部/局
            04  HMSID-SYS-CODE1                       PIC X.
*           >課/區
            04  HMSID-SYS-CODE2                       PIC X.
    02  HMSID-DATA.
*       >系統名稱 (ex. 醫學研究檔案篩選管理系統)
        03  HMSID-SYS-NAME                            PIC X(40).
*       >系統管理者代號
        03  HMSID-USER-NO                             PIC X(10).
*       >系統管理者密碼
        03  HMSID-USER-PASS                           PIC X(10).
*((XFD USE GROUP, VAR-LENGTH))
        03  HMSID-REMARK.
*       >資料內容 (格式均由程式中重新再定義)
            04  HMSID-REMARK1                         PIC X(60).
            04  HMSID-REMARK2                         PIC X(60).
            04  HMSID-REMARK3                         PIC X(60).
*<< BOF OF HM_SIDX.MST >>*******************************************************






*
*COPY "HT_VHK.MST" REPLACING ==HTVHK-MST.== BY ==HTVHK-MST IS EXTERNAL.==.
******************
* 微生物單據主檔 *
******************
*------------------------------------------------------------------------------*
* RECORD    KEY   HTVHK-KEY                                                    *
* ALTERNATE KEY   HTVHK-KEY-ALT1 = HTVHK-NO      HTVHK-CK-DATE                 *
* ALTERNATE KEY   HTVHK-KEY-ALT2 = HTVHK-KEY-SW  HTVHK-PATNO                   *
*                                  HTVHK-KEY                                   *
* ALTERNATE KEY   HTVHK-KEY-ALT3 = HTVHK-KEY-SW  HTVHK-PATNO                   *
*                                  HTVHK-NO      HTVHK-CK-DATE                 *
* ALTERNATE KEY   HTVHK-KEY-ALT4 = HTVHK-CCODE   HTVHK-KEY                     *
* ALTERNATE KEY   HTVHK-KEY-ALT5 = HTVHK-NOPRINT HTVHK-KEY                     *
* ALTERNATE KEY   HTVHK-KEY-ALT6 = HTVHK-ADATE   HTVHK-SEQ                     *
*                                  HTVHK-KEY                                   *
*------------------------------------------------------------------------------*
 FD  HTVHK-MST.
 01  HTVHK-REC.

    02  HTVHK-KEY.
*       檢驗日期
        03  HTVHK-CK-DATE                         PIC 9(07).
*((XFD USE GROUP))
*       單據號碼
        03  HTVHK-NO.
            04  HTVHK-NO1                         PIC X(03).
            04  HTVHK-NO2                         PIC 9(05).
    02  HTVHK-DATA.
*       資料來源 (I:住院, O:門診, W:健檢)
        03  HTVHK-KEY-SW                          PIC X.
*       (住院|門診)日期
        03  HTVHK-ADATE                           PIC 9(07).
*       (住院|門診)序號
        03  HTVHK-SEQ                             PIC 9(04).
*       處方序號
        03  HTVHK-SEQNO                           PIC 9(11).
*       病歷號碼
        03  HTVHK-PATNO                           PIC 9(08).
*       病房單位 (護理站)
        03  HTVHK-BEDUNIT                         PIC X(05).
*       檢驗完成碼
        03  HTVHK-CCODE                           PIC X(1).
*       已完成未列印 (Y:已列印)
        03  HTVHK-NOPRINT                         PIC X(1).
*((XFD USE GROUP, VAR-LENGTH))
    02  HTVHK-MEMO.
*       敘述文件內容
        03  HTVHK-MEMO1                           PIC X(76).
        03  HTVHK-MEMO2                           PIC X(76).
        03  HTVHK-MEMO3                           PIC X(76).

*------------------------------------------------------------------------------*
* P.S.  1> EVALUATE HTVHK-KEY-SW                                               *
*                   WHEN 'I'                                                   *
*                        ICB-IPD-NO  (住院序號) = HTVHK-ADATE + HTVHK-SEQ      *
*                        ICB-ODR-NO  (處方序號) = HTVHK-SEQNO                  *
*                   WHEN 'O'                                                   *
*                        ODR-NO      (門診序號) = HTVHK-ADATE + HTVHK-SEQ      *
*                        ODR-ODR-SEQ (處方序號) = HTVHK-SEQNO = "01"           *
*          END-EVALUATE.                                                       *
*------------------------------------------------------------------------------*

*COPY "HT_VHR.MST" REPLACING ==HTVHR-MST.== BY ==HTVHR-MST IS EXTERNAL.==.
**************************************
* 微生物單據/處方序號/檢體編號記錄檔 *
**************************************
*------------------------------------------------------------------------------*
* RECORD    KEY   HTVHR-KEY                                                    *
* ALTERNATE KEY   HTVHR-KEY-ALT1 = HTVHR-VHK-KEY HTVHR-KEY                     *
* ALTERNATE KEY   HTVHR-KEY-ALT2 = HTVHR-SPN-KEY HTVHR-IOW-KEY                 *
*------------------------------------------------------------------------------*
 FD  HTVHR-MST.
 01  HTVHR-REC.
    02  HTVHR-KEY.
        03  HTVHR-IOW-KEY.
*           資料來源 (I:住院, O:門診, W:健檢)

            04  HTVHR-KEY-SW                      PIC X.
*           (住院|門診)日期
            04  HTVHR-ADATE                       PIC 9(07).
*           (住院|門診)序號
            04  HTVHR-SEQ                         PIC 9(04).
*           處方序號
            04  HTVHR-SEQNO                       PIC 9(11).
*       檢體編號(儀器連線用)
        03  HTVHR-SPN-KEY                         PIC X(15).
    02  HTVHR-DATA.
*((XFD USE GROUP))
        03  HTVHR-VHK-KEY.
*           檢驗日期
            04  HTVHR-CK-DATE                     PIC 9(07).
*           單據號碼
            04  HTVHR-NO.
                05  HTVHR-NO1                     PIC X(03).
                05  HTVHR-NO2                     PIC 9(05).
*((XFD USE GROUP, VAR-LENGTH))
*   預留空白項
    02 HTVHR-FILLER                               PIC X(100).

*COPY "HT_VH1.MST" REPLACING ==HTVH1-MST.== BY ==HTVH1-MST IS EXTERNAL.==.
********************************************************************************
* 微生物單據附屬檔 -- KEY值 排序方式與 HT_MVHK 相反                            *
*   單據號碼 = HTVH1-NO2 = 99999 - HTVHK-NO2                                   *
*------------------------------------------------------------------------------*
* RECORD KEY IS HTVH1-KEY (用於產生新單號, 單日檢驗報表)                       *
* ALTERNATE KEY IS HTVH1-KEY-ALT1 = HTVH1-IDNO  HTVH1-NO                       *
*                                               HTVH1-CK-DATE (用於健檢)       *
* ALTERNATE KEY IS HTVH1-KEY-ALT2 = HTVH1-IDNO  HTVH1-KEY     (用於健檢)       *
********************************************************************************
*   >用於 HTRE10KF, HTRE11KF
 FD  HTVH1-MST.
 01  HTVH1-REC.
    02  HTVH1-KEY.
*       >檢驗日期
        03  HTVH1-CK-DATE                         PIC 9(07).
*((XFD USE GROUP))
*       >單據號碼 => HTVH1-NO2 = 99999 - HTVHK-NO2
        03  HTVH1-NO.
            04  HTVH1-NO1                         PIC X(03).
            04  HTVH1-NO2                         PIC 9(05).
    02  HTVH1-DATA1.
*       >病患身份字號/外送醫院號碼
        03  HTVH1-IDNO                            PIC X(10).
    02  HTVH1-DATA2.
*       >檢驗時間
        03  HTVH1-CK-TIME                         PIC 9(06).
*       >檢體代碼
        03  HTVH1-VPL-CD                          PIC X.
*       >檢驗人員
        03  HTVH1-CK-MAN                          PIC X(05).


*COPY "HT_VPL.MST" REPLACING ==HTVPL-MST.== BY ==HTVPL-MST IS EXTERNAL.==.
*------------------------------------------------------------------------------*

*   檔名: 微生物室檢驗檢體檔                                                   *
*   型別: SYBASE                                                               *
*   建檔日:              修改日:                 長度: 22       作者: 陳世勇   *
*------------------------------------------------------------------------------*
*   RECORD KEY   IS HTVPL-KEY                                                  *
*   FILE STATUS  IS W-FS-HTVPL                                                 *
*------------------------------------------------------------------------------*
*   系統: 微生物室管理作業                                                     *
*   程式: HTRE10KF                                                             *
*------------------------------------------------------------------------------*
 FD  HTVPL-MST.
 01  HTVPL-REC.
    02  HTVPL-KEY.
*((XFD USE GROUP))
*       >檢體代號
        03  HTVPL-NO.
*          >檢驗檢查科室簡碼
           04  HTVPL-DPT                PIC X(1).
*          >檢體代碼
           04  HTVPL-CD                 PIC X(1).
    02  HTVPL-DATA.
*       >檢體名稱
        03  HTVPL-NAME                  PIC X(20).









*COPY "HT_ANT.MST".
*******************
*微生物室抗生素檔 *
*******************
*-->用於HTBAFKF3, HTBAFKF4, HTBAFKF5,
 FD  HTANT-MST IS EXTERNAL.
 01  HTANT-REC.
    02  HTANT-KEY.
*           抗生素代號
        03  ANT-ANTNO            PIC X(5).
*((XFD USE GROUP, VAR-LENGTH))
    02  HTANT-DATA.
*           藥品代號
        03  ANT-DRUGNO           PIC X(6).
*           抗生素名稱
        03  ANT-DRUGNAME         PIC X(40).
*COPY "HT_ATE.MST".
*------------------------------------------------------------------------------*
*   檔名: 微生物室抗生素樣板檔                                                 *
*   型別: SYBASE                                                               *
*   建檔日:              修改日:                 長度: 51       作者: 陳世勇   *
*------------------------------------------------------------------------------*
*   RECORD KEY   IS HTATE-KEY                                                  *
*   FILE STATUS  IS W-FS-HTATE                                                 *
*------------------------------------------------------------------------------*

*   系統: 微生物室管理作業                                                     *
*   程式: HTBA40KF, HTRE10KF                                                   *
*------------------------------------------------------------------------------*
 FD  HTATE-MST IS EXTERNAL.
 01  HTATE-REC.
    02  HTATE-KEY.
*       組合代號
        03  ATE-TENO             PIC X(1).
*((VAR-LENGTH))
    02  HTATE-DATA.
*       組合名稱
        03  ATE-NAME             PIC X(20).

*COPY "HT_ATC.MST".
*------------------------------------------------------------------------------*
*   檔名: 微生物室抗生素樣板組合檔                                             *
*   型別: SYBASE                                                               *
*   建檔日:              修改日:                 長度: 8        作者: 陳世勇   *
*------------------------------------------------------------------------------*
*   RECORD KEY   IS HTATC-KEY                                                  *
*   FILE STATUS  IS W-FS-HTATC                                                 *
*------------------------------------------------------------------------------*
*   系統: 微生物室管理作業                                                     *
*   程式: HTBA40KF, HTRE10KF                                                   *
*------------------------------------------------------------------------------*
 FD  HTATC-MST IS EXTERNAL.
 01  HTATC-REC.
    02  HTATC-KEY.
*       組合代號
        03  ATC-TENO             PIC X(1).
*       抗生素編號(流水號)
        03  ATC-NO               PIC 9(2).
    02  HTATC-DATA.
*       抗生素代號
        03  ATC-ANTNO            PIC X(5).

*COPY "HT_VIR.MST".
*------------------------------------------------------------------------------*
*   微生物室病原菌檔                                                           *
*   建檔日: 1995/09/01           修改日: 1996/10/07                            *
*------------------------------------------------------------------------------*
*   系統: 微生物, 院內感染                                                     *
*   程式: HTBA20KF, HTBA20IF, HTBA50KF, HTRE20KF, HTIP10KF                     *
*------------------------------------------------------------------------------*
*   RECORD    KEY IS HTVIR-KEY                                                 *
*   ALTERNATE KEY IS HTVIR-KEY-ALT1 = VIR-CODE VIR-VIRNO                       *
*   ALTERNATE KEY IS HTVIR-KEY-ALT2 = VIR-GP VIR-GENUS VIR-SPECIES VIR-VIRNO   *
*   FILE STATUS   IS W-FS-HTVIR                                                *
*------------------------------------------------------------------------------*
 FD  HTVIR-MST IS EXTERNAL.
 01  HTVIR-REC.
    02  HTVIR-KEY.
*       菌種代號
        03  VIR-VIRNO            PIC X(7).
    02  HTVIR-DATA.
*       菌種簡碼
        03  VIR-CODE             PIC X(4).

*       菌種屬名
        03  VIR-GENUS            PIC X(20).
*       菌種種號名
        03  VIR-SPECIES          PIC X(20).
*       菌種簡稱
        03  VIR-NAME             PIC X(30).
*       菌種類別
        03  VIR-GP               PIC X(3).

*COPY "HT_MIC.MST".
***********************
*微生物室MIC稀釋倍數檔*
***********************
*-->用於HTBAFKF6,
 FD  HTMIC-MST IS EXTERNAL.
 01  HTMIC-REC.
    02  HTMIC-KEY.
*       稀釋序號
        03  MIC-NO               PIC 9(2).
    02  HTMIC-DATA.
*       稀釋倍數值
        03  MIC-TIMES            PIC 999V99.
*COPY "HT_DDM.MST".
*------------------------------------------------------------------------------*
*   檔名: DDM敏感代號對照檔                                                    *
*   型別: SYBASE                                                               *
*   建檔日:              修改日:                 長度: 24       作者: 陳世勇   *
*------------------------------------------------------------------------------*
*   RECORD KEY   IS HTDDM-KEY                                                  *
*   FILE STATUS  IS W-FS-HTDDM                                                 *
*------------------------------------------------------------------------------*
*   系統: 微生物室管理作業                                                     *
*   程式: HTBA50KF, HTRE10KF                                                   *
*------------------------------------------------------------------------------*
 FD  HTDDM-MST IS EXTERNAL.
 01  HTDDM-REC.
*((XFD USE GROUP))
    02  HTDDM-KEY.
*       抗生素代號
        03  DDM-ANTNO            PIC X(5).
*       病原菌代號
        03  DDM-VIRNO            PIC X(7).
        03  DDM-VGP REDEFINES DDM-VIRNO.
            04  DDM-VGP-NO       PIC X(3).
            04  DDM-VGP-FILL     PIC X(4).
*       無菌落直徑1～6
*((XFD USE GROUP))
    02  HTDDM-DATA.
        03  DDM-DIA1             PIC 9(2).
        03  DDM-DIA2             PIC 9(2).
        03  DDM-DIA3             PIC 9(2).
        03  DDM-DIA4             PIC 9(2).
        03  DDM-DIA5             PIC 9(2).
        03  DDM-DIA6             PIC 9(2).

*COPY "HT_VRT.MST".
*------------------------------------------------------------------------------*

*   檔名: 微生物室檢驗結果主檔                                                 *
*   型別: SYBASE                                                               *
*   建檔日:              修改日:                 長度: 40       作者: 陳世勇   *
*------------------------------------------------------------------------------*
*   RECORD KEY   IS HTVRT-KEY                                                  *
*   FILE STATUS  IS W-FS-HTVRT                                                 *
*------------------------------------------------------------------------------*
*   系統: 微生物室管理作業                                                     *
*   程式: HTRE10KF                                                             *
*------------------------------------------------------------------------------*
 FD  HTVRT-MST IS EXTERNAL.
 01  HTVRT-REC.
    02  HTVRT-KEY.
*       檢驗日期
        03  VRT-CK-DATE          PIC 9(7).
*((XFD USE GROUP))
*       檢驗單號
        03  VRT-NO.
            04  VRT-NO1          PIC X(3).
            04  VRT-NO2          PIC 9(5).
*       菌落編號
        03  VRT-VNO              PIC 9.
    02  HTVRT-DATA.
*       報告日期
        03  VRT-TDATE            PIC 9(7).
*((XFD USE GROUP))
    02  HTVRT-DATA1.
*       抗生素組合代號
        03  VRT-ANTTE            PIC X(1).
*       敏感試驗方法
        03  VRT-TMETHOD          PIC X(1).
*       病原菌代號
        03  VRT-VIRNO            PIC X(7).
*       程度碼
        03  VRT-LEVEL            PIC X(1).
*       數量單位
        03  VRT-COUNT.
            04  VRT-COUNT1       PIC X(1).
            04  VRT-COUNT2       PIC 9(6).


*COPY "HT_VR1.MST".
*------------------------------------------------------------------------------*
*   檔名: 微生物室抗生素敏感試驗檔                                             *
*   型別: SYBASE                                                               *
*   建檔日:              修改日:                 長度: 30       作者: 陳世勇   *
*------------------------------------------------------------------------------*
*   RECORD KEY   IS HTVR1-KEY                                                  *
*   FILE STATUS  IS W-FS-HTVR1                                                 *
*------------------------------------------------------------------------------*
*   系統: 微生物室管理作業                                                     *
*   程式: HTRE10KF                                                             *
*------------------------------------------------------------------------------*
 FD  HTVR1-MST EXTERNAL.
 01  HTVR1-REC.
*((XFD USE GROUP))
    02  HTVR1-KEY.

*       >檢驗日期
        03  VR1-CK-DATE                             PIC 9(7).
*       >檢驗單號
        03  VR1-NO.
            04  VR1-NO1                             PIC X(3).
            04  VR1-NO2                             PIC 9(5).
*       >菌落編號
        03  VR1-VNO                                 PIC 9.
*       >敏感試驗編號
        03  VR1-TNO                                 PIC 99.
    02  HTVR1-DATA.
*       >抗生素代號
        03  VR1-ANTNO                               PIC X(5).
*       >MIC稀釋倍數序號
        03  VR1-MICT                                PIC X99.
        03  VR1-ZONES REDEFINES VR1-MICT.
*           >DDM無菌落區
            04  VR1-ZONE                            PIC X(2).
*           >空白項; 不用
            04  VR1-ZONE-FIL                        PIC X(1).
*       >敏感代號
        03  VR1-SUSNO                               PIC X.


*COPY "HT_WRK.MST".
*************
* C-PY FILE : HT_WRK.MST 871202-871207  作者：謝枝財
* HT_MWRK LENGTH 100 BYTES -- RDB       部門工作序號檔(FOR 名碩公司)
*************
 FD HTWRK-MST IS EXTERNAL.
 01 HTWRK-REC.
   02 HTWRK-KEY.
      03 HTWRK-WRK-NO.
**       部門工作序號
         04 HTWRK-DPT-NO                PIC X(2).
**          排檢部門代號
         04 HTWRK-CRE-DATE              PIC 9(8).
**          產生日期(西曆)
         04 HTWRK-CRE-SEQ               PIC 9(4).
**          工作序號流水號
   02 HTWRK-DATA.
*$XFD USE GROUP
      03 HTWRK-DATA-SPN.
**       最新檢體編號資料
         04 HTWRK-SPN-NO                PIC X(15).
**          受檢檢體編號
         04 HTWRK-SPN-DATE              PIC 9(7).
**          編號相對產生日期 = 10000000 - 編號實際產生日期
*$XFD USE GROUP, VAR-LENGTH
      03 HTWRK-DATA-OTH.
         04 HTWRK-CRE-TIME              PIC 9(6).
**          產生時間
         04 HTWRK-OBSERVE1              PIC X(10).
**          觀測情形一
         04 HTWRK-OBSERVE2              PIC X(10).
**          觀測情形二
         04 HTWRK-OBSERVE3              PIC X(10).

**          觀測情形三
         04 HTWRK-FILLER                PIC X(28).

** HTWRK-ALT-KEY1 = HTWRK-DATA-SPN + HTWRK-DPT-NO
*COPY "HT_CSP.MST".
*************
* C-PY FILE : HT_CSP.MST   84/04/18     作者：謝枝財
* HT_MCSP LENGTH 100 BYTES 86/10/10     醫令單檢體檔
*************
 FD HTCSP-MST IS EXTERNAL.
 01 HTCSP-REC.
*$XFD USE GROUP
   02 HTCSP-KEY.
      03 HTCSP-CHK-NO.
**       醫令單號
         04 HTCSP-CLS-NO.
**          檢驗檢查類別代號
            05 HTCSP-DPT-CD             PIC X(1).
**             檢驗檢查科室簡碼
            05 HTCSP-CLS-CD             PIC X(2).
**             檢驗檢查類別碼
         04 HTCSP-PR-SEQ                PIC 9(5).
**          開單流水碼
      03 HTCSP-IP-DATE                  PIC 9(7).
**       醫令日期
      03 HTCSP-SPB-CD.
         04 HTCSP-SPL-CD                PIC X(1).
**          檢體代碼
         04 HTCSP-BTL-CD                PIC X(1).
**          容器代碼
   02 HTCSP-DATA.
**    單據資料
      03 HTCSP-DATA-IP.
**       醫令資料
*$XFD USE GROUP, VAR-LENGTH
         04 HTCSP-IP-PT.
**          病患資料                    -- ALT-KEY
            05 HTCSP-SPN-SW             PIC X(1).
**             檢體狀態碼
            05 HTCSP-PT-ID              PIC X(10).
**             身份字號
            05 HTCSP-PT-ND REDEFINES HTCSP-PT-ID.
               06 HTCSP-PT-NO           PIC 9(8).
**                病歷號碼
               06 HTCSP-PT-SP           PIC X(2).
**                空白項
*$XFD USE GROUP, VAR-LENGTH
         04 HTCSP-IP-DATA.
            05 HTCSP-TP-DATE            PIC 9(7).
**             預定檢驗日期
            05 HTCSP-RP-DATE            PIC 9(7).
**             預定送檢日期
            05 HTCSP-IP-RKNO            PIC X(10).
**             檢體醫令備註編號
*$XFD USE GROUP
      03 HTCSP-DATA-SPN.
**       最新檢體編號資料

         04 HTCSP-SPN-NO                PIC X(15).
**          受檢檢體編號
         04 HTCSP-SPN-DATE              PIC 9(7).
**          編號相對產生日期 = 10000000 - 編號實際產生日期
*$XFD USE GROUP, VAR-LENGTH
      03 HTCSP-DATA-OTH.
         04 HTCSP-REJ-SW                PIC X(1).
**          檢體退回碼
         04 HTCSP-DATA-AC.
**          簽收資料                    -- 86/03/27
            05 HTCSP-AC-DATE            PIC 9(7).
**             簽收日期
            05 HTCSP-AC-TIME            PIC 9(6).
**             簽收時間
            05 HTCSP-AC-MAN             PIC X(5).
**             簽收人員
         04 HTCSP-AC-DATA REDEFINES  HTCSP-DATA-AC.
            05 HTCSP-AC-FILL            PIC X(1).
**             空白項
            05 HTCSP-REJ-DATE           PIC 9(7).
**             退回日期                 -- 86/10/10
            05 HTCSP-AC-RKNO            PIC X(10).
**             檢體退回備註片語編號
         04 HTCSP-SRC-SW                PIC X(1).
**          檢體編號來源碼
         04 HTCSP-FILLER                PIC X(8).

** HTCSP-ALT-KEY  = HTCSP-IP-PT    + HTCSP-KEY
** HTCSP-ALT-KEY1 = HTCSP-DATA-SPN + HTCSP-KEY

** HTCSP-SPN-SW  : Y> 檢體已指示取樣
** HTCSP-REJ-SW  : Y> 檢體退回, INITIALIZE HTCSP-SPN-SW & HTCSP-DATA-AC
** HTCSP-IP-RKNO : MOVE "B1"          TO W-EDT-RPT-TY
**                 MOVE "1"           TO W-EDT-CPY-SW
**                 MOVE "C,M,D,I"     TO W-EDT-FUN-SW
**                 MOVE HTCSP-IP-MAN  TO W-EDT-USR-NO
**                 MOVE HTCSP-DPT-CD  TO W-EDT-CPY-KY
**                 MOVE HTCSP-IP-RKNO TO W-EDT-RPT-NO
**                 LINK HT_EDT.LNK &  CALL "HTEDTCF" USING W-EDT-TABLE

** 作業說明：
**              =============== ================ =====================
**               資 料 項 目     作 業 階 段      資 料 來 源
**              =============== ================ =====================
**               HTCSP-DATA-IP   健檢,醫令,批價   健檢,醫令,批價系統
**               HTCSP-RP-DATE   健檢,醫令,批價   HTCSP-TP-DATE
**               HTCSP-DATA-SPN  檢體取樣指示     護理站,檢驗系統
**               HTCSP-RP-DATE   檢體取樣結果     護理站系統

*> 排程相關檔案
*COPY    "HX_SRM.MST".
*************
* C-PY FILE : HX_SRM.MST    90/10/10    作者：謝枝財
* HX_MSRM LENGTH 250 BYTES  90/11/01    檢查室代號定義檔
*************
 FD HXSRM-MST IS EXTERNAL.
 01 HXSRM-REC.

*$XFD USE GROUP
   02 HXSRM-ROM-NO.
**    檢查室代號
      03 HXSRM-DPT-CD                   PIC X(1).
**       檢查科室簡碼
      03 HXSRM-ROM-CD                   PIC X(2).
**       檢查室簡碼
   02 HXSRM-DATA.
      03 HXSRM-SRL-NO                   PIC X(4).
**       檢查室位置代號                 -- HXSRL-SRL-NO
*$XFD USE GROUP, VAR-LENGTH
      03 HXSRM-DATA-OTH.
         04 HXSRM-ROM-NM                PIC X(20).
**          檢查室簡稱
         04 HXSRM-SMH-NO                PIC X(8).
**          使用儀器代號                -- HXSMH-SMH-NO (90/11/01)
         04 HXSRM-FILLER                PIC X(215).
**          空白項

** HXSRM-ALT-KEY = HXSRM-SRL-NO + HXSRM-ROM-NO
*COPY    "HX_SCT.MST".
*************
* C-PY FILE : HX_SCT.MST    90/10/10    作者：謝枝財
* HX_MSCT LENGTH 250 BYTES  90/10/31    檢查項目標準工時設定檔
*************
 FD HXSCT-MST IS EXTERNAL.
 01 HXSCT-REC.
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCT-KEY.
      03 HXSCT-ITM-NO.
**       檢查細項或組合代號
         04 HXSCT-CLS-NO                PIC X(3).
**          檢查類別代號
         04 HXSCT-ITM-GRP               PIC X(6).
**          檢查項目代碼
      03 HXSCT-SMH-NO                   PIC X(8).
**       儀器代號
      03 HXSCT-DCT-NO                   PIC X(5).
**       檢查醫師員工代碼
      03 HXSCT-KEY-FIL                  PIC X(17).
**       空白項
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCT-DATA.
      04 HXSCT-STD-TIM                  PIC 9(3).
**       標準工時(分)
      04 HXSCT-FILLER                   PIC X(208).
**       空白項

** HXSCT-ITM-GRP REFER TO HTCLS-MCW-TY (a,d) OF HT_CLS.MST
** HXSCT-SMH-NO  REFER TO HTCLS-MCW-TY (b)   OF HT_CLS.MST
** HXSCT-DCT-NO  REFER TO HTCLS-MCW-TY (c)   OF HT_CLS.MST
*COPY    "HX_SCD.MST".
*************
* C-PY FILE : HX_SCD.MST    90/11/01    作者：謝枝財
* HX_MSCD LENGTH 250 BYTES  90/11/01    檢查類別檢查醫師日排班檔
*************
 FD HXSCD-MST IS EXTERNAL.

 01 HXSCD-REC.
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCD-KEY.
      03 HXSCD-CLS-NO                   PIC X(3).
**       檢查類別代號                   -- HTCLS-CLS-NO
      03 HXSCD-SCH-DATE                 PIC 9(7).
**       排檢日期                       -- HXSCW-WEEK-CD
      03 HXSCD-TURN-CD                  PIC X(1).
**       午別代碼                       -- HXSCW-TURN-CD
      03 HXSCD-SRM-CD                   PIC X(2).
**       檢查室簡碼                     -- HXSCW-SRM-CD
      03 HXSCD-SRM-SEQ                  PIC 9(1).
**       檢查室共用碼                   -- HXSCW-SRM-SEQ
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCD-KEY3.
      03 HXSCD-SCH-DATE1                PIC 9(7).
**       排檢日期
      03 HXSCD-TURN-CD1                 PIC X(1).
**       午別代碼                       -- NID-CODE (NID-ID = '0506')
      03 HXSCW-KEY3-FILLER              PIC X(22).
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCD-KEYA.
      03 HXSCW-KEYA-FILLER              PIC X(30).

   02 HXSCD-DATA.
      03 HXSCD-DCT-NCD                  PIC X(5).
**       檢查醫師員工代碼               -- HXSCW-DCT-CD1 OR HXSCW-DCT-CD2
      03 HXSCD-DCT-OCD                  PIC X(5).
**       原排檢醫師員工代碼             -- HXSCD-DCT-NCD
*$XFD USE GROUP, VAR-LENGTH
      03 HXSCD-DATA-OTH.
         04 HXSCD-BGN-TIM               PIC 9(4).
**          檢查開始時分                -- HXSCW-BGN-TIM1 OR HXSCW-BGN-TIM2
         04 HXSCD-END-TIM               PIC 9(4).
**          檢查結束時分                -- HXSCW-END-TIM1 OR HXSCW-END-TIM2
         04 HXSCD-MAX-QTY               PIC 9(3).
**          檢查最大量                  -- HXSCW-MAX-QTY1 OR HXSCW-MAX-QTY2
         04 HXSCD-SMH-NO                PIC X(8).
**          使用儀器代號                -- HXSRM-SMH-NO
         04 HXSCD-CNT-QTY               PIC 9(3).
**          檢查已排量
         04 HXSCD-FILLER                PIC X(204).
**          空白項

** HXSCD-ALT-KEY1 = HXSCD-DCT-NCD + HXSCD-KEY
** HXSCD-ALT-KEY2 = HXSCD-DCT-OCD + HXSCD-KEY
** HXSCD-ALT-KEY3 = HXSCD-KEY3    + HXSCD-KEY
** HXSCD-ALT-KEYA = HXSCD-KEYA    + HXSCD-KEY


*COPY    "HX_SCC.MST".
*************
* C-PY FILE : HX_SCC.MST    90/11/02    作者：謝枝財
* HX_MSCC LENGTH 73 BYTES   90/11/02    檢查醫師跨類別日排班檔
*************
 FD HXSCC-MST IS EXTERNAL.
 01 HXSCC-REC.

*$XFD USE GROUP
   02 HXSCC-KEY.
      03 HXSCC-DCT-NCD                  PIC X(5).
**       檢查醫師員工代碼               -- HXSCD-DCT-NCD
      03 HXSCC-SCH-DATE                 PIC 9(7).
**       排檢日期                       -- HXSCD-SCH-DATE
      03 HXSCC-TURN-CD                  PIC X(1).
**       午別代碼                       -- HXSCD-TURN-CD
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCC-DATA.
      03 HXSCC-DATA-CLS OCCURS 10 TIMES.
         04 HXSCC-CLS-NO                PIC X(3).
**          檢查類別代號                -- HTCLS-CLS-NO
         04 HXSCC-SRM-CD                PIC X(2).
**          檢查室簡碼                  -- HXSCD-SRM-CD
         04 HXSCC-SRM-SEQ               PIC 9(1).
**          檢查室共用碼                -- HXSCD-SRM-SEQ
*COPY    "HX_SCM.MST".
*************
* C-PY FILE : HX_SCM.MST    90/11/01    作者：謝枝財
* HX_MSCM LENGTH 26 BYTES   90/11/02    病患日排檢最新異動記錄檔
*************
 FD HXSCM-MST IS EXTERNAL.
 01 HXSCM-REC.
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCM-KEY.
      03 HXSCM-SCC-SW                   PIC X(1).
**       檢查醫師跨類別日排班碼(Y/N)
      03 HXSCM-SCC-KEY.
         04 HXSCM-SCC-DATE              PIC 9(7).
**          排檢日期                    -- HXSCC-SCM-DATE
         04 HXSCM-SCC-TURN              PIC X(1).
**          午別代碼                    -- HXSCC-TURN-CD
         04 HXSCM-SCC-DCT               PIC X(5).
**          檢查醫師員工代碼            -- HXSCC-DCT-NCD
      03 HXSCM-SCD-KEY REDEFINES HXSCM-SCC-KEY.
         04 HXSCM-SCD-DATE              PIC 9(7).
**          排檢日期                    -- HXSCD-SCM-DATE
         04 HXSCM-SCD-TURN              PIC X(1).
**          午別代碼                    -- HXSCD-TURN-CD
         04 HXSCM-SCD-SRM               PIC X(2).
**          檢查室簡碼                  -- HXSCD-SRM-CD
         04 HXSCM-SCD-CLS               PIC X(3).
**          檢查類別代號                -- HTSCD-CLS-NO

*$XFD USE GROUP, VAR-LENGTH
   02 HXSCM-KEY1.
      03 HXSCM-KEY1-FILLER              PIC X(20).

*$XFD USE GROUP, VAR-LENGTH
   02 HXSCM-DATA.
      03 HXSCM-CRE-DATE                 PIC 9(7).
**       異動日期
      03 HXSCM-CRE-TIME                 PIC 9(6).
**       異動時間
      03 HXSCM-CRE-FILLER               PIC X(60).


** HXSCM-ALT-KEY1 = HXSCM-KEY1  + HXSCM-KEY
*COPY    "HX_SCH.MST".
*************
* C-PY FILE : HX_SCH.MST    90/11/01    作者：謝枝財
* HX_MSCH LENGTH 360 BYTES  90/11/13    檢查類別病患日排檢檔
*************
 FD HXSCH-MST IS EXTERNAL.
 01 HXSCH-REC.
   02 HXSCH-KEY.
      03 HXSCH-CLS-NO                   PIC X(3).
**       檢查類別代號                   -- HTCLS-CLS-NO
      03 HXSCH-SCH-DATE                 PIC 9(7).
**       排檢日期                       -- HXSCD-SCH-DATE
*$XFD USE GROUP, VAR-LENGTH
      03 HXSCH-KEY-SRM.
         04 HXSCH-TURN-CD               PIC X(1).
**          午別代碼                    -- HXSCD-TURN-CD
         04 HXSCH-SRM-CD                PIC X(2).
**          檢查室簡碼                  -- HXSCD-SRM-CD
*$XFD USE GROUP, VAR-LENGTH
      03 HXSCH-KEY-TIM.
         04 HXSCH-SCH-TIM1              PIC 9(4).
**          檢查預定開始時分
         04 HXSCH-SCH-INT               PIC X(1).
**          插入順序碼
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCH-KEYA.
         04 HXSCH-KEY-A-FILLER          PIC X(25).
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCH-KEYB.
         04 HXSCH-KEY-B-FILLER          PIC X(30).
   02 HXSCH-DATA.
      03 HXSCH-PT-NO                    PIC 9(8).
**       病歷號碼
      03 HXSCH-PT-ID                    PIC X(10).
**       身份字號
      03 HXSCH-IP-DR-CD                 PIC X(5).
**       開單醫師員工代碼
      03 HXSCH-DCT-CD                   PIC X(5).
**       檢查醫師員工代碼               -- HXSCD-DCT-NCD OR HXSCD-DCT-OCD
      03 HXSCH-IP-NO                    PIC X(22).
**       醫令序號
      03 HXSCH-IP-NO1 REDEFINES HXSCH-IP-NO.
**       門診醫令序號
         04 HXSCH-RO-NO                 PIC 9(11).
**          門診序號
         04 HXSCH-OR-NO                 PIC 9(2).
**          處方序號
         04 HXSCH-RO-FL                 PIC X(9).
**          空白項
      03 HXSCH-IP-NO2 REDEFINES HXSCH-IP-NO.
**       住院醫令序號
         04 HXSCH-PD-NO                 PIC 9(11).
**          住院序號
         04 HXSCH-OD-NO                 PIC 9(11).
**          處方序號
      03 HXSCH-CRE-SEQ                  PIC 9(4).

**       處置建檔號(住醫不變)           -- ICB-FEE-SEQ OR ODR1-CRE-NO
*$XFD USE GROUP, VAR-LENGTH
      03 HXSCH-DATA-OTH.
         04 HXSCH-SCH-TIM2              PIC 9(4).
**          檢查預定結束時分
         04 HXSCH-STD-TIM               PIC 9(4).
**          檢查標準工時(分)            -- W-SCT-STD-TIM OF HX_SCT.LNK
         04 HXSCH-CHK-TIM1              PIC 9(4).
**          檢查實際開始時分
         04 HXSCH-CHK-TIM2              PIC 9(4).
**          檢查實際結束時分
         04 HXSCH-CHK-TIM               PIC 9(4).
**          檢查實際工時(分)            -- (HXSCH-CHK-TIM2 - HXSCH-CHK-TIM1) OR ACCEPT
         04 HXSCH-SRM-SEQ               PIC 9(1).
**          檢查室共用碼                -- HXSCD-SRM-SEQ
         04 HXSCH-ITM-CD OCCURS 9 TIMES PIC X(6).
**          檢查項目                    -- HTITM-ITM-CD
         04 HXSCH-FILLER                PIC X(170).
**          空白項





**      HXSCH-ALT-KEY1 = HXSCH-IP-NO    HXSCH-KEY
*       (醫令使用)       開單序號
**      HXSCH-ALT-KEY2 = HXSCH-PT-NO    HXSCH-SCH-DATE  HXSCH-KEY-TIM   HXSCH-KEY-SRM   HXSCH-CLS-NO
*       查詢病患已排     病歷號         排程日期        排程時間        午別、檢查室    檢查類別(項目)
**      HXSCH-ALT-KEY3 = HXSCH-PT-ID    HXSCH-SCH-DATE  HXSCH-KEY-TIM   HXSCH-KEY-SRM   HXSCH-CLS-NO
*       查詢病患已排     病身份證號     排程日期        排程時間        午別、檢查室    檢查類別(項目)
**      HXSCH-ALT-KEY4 = HXSCH-DCT-CD   HXSCH-SCH-DATE  HXSCH-KEY-TIM   HXSCH-KEY-SRM   HXSCH-CLS-NO
*       查詢檢查醫師已排 病身份證號     排程日期        排程時間        午別、檢查室    檢查類別(項目)
**      HXSCH-ALT-KEY5 = HXSCH-SCH-DATE HXSCH-KEY-SRM   HXSCH-KEY-TIM   HXSCH-CLS-NO
*       列印當日排程資料 排程日期       午別、檢查室    排程時間        檢查類別(項目)
**      HXSCH-ALT-KEY6 = HXSCH-KEY-SRM  HXSCH-SCH-DATE  HXSCH-KEY-TIM   HXSCH-CLS-NO
*       尋找檢查室已排程 午別、檢查室   排程日期        排程時間        檢查類別(項目)
**      HXSCH-ALT-KEY7 = HXSCH-SCH-DATE HXSCH-CLS-NO    HXSCH-KEY-SRM   HXSCH-KEY-TIM
*       多類別排程資料   排程日期       檢查類別(項目)  午別、檢查室    排程時間
**      HXSCH-ALT-KEYA = HXSCH-KEYA     HXSCH-KEY
**      HXSCH-ALT-KEYB = HXSCH-KEYB     HXSCH-KEY
*>
*COPY    "HX_ANN.MST".
*************
* C-PY FILE : HX_ANN.MST    89/06/09    作者：謝枝財
* HX_MANN LENGTH 250 BYTES  89/09/20    重要醫令準報備檔
*************
 FD HXANN-MST IS EXTERNAL.
 01 HXANN-REC.
   02 HXANN-KEY.
      03 HXANN-IP-NO                    PIC X(22).
**       醫令序號
      03 HXANN-IP-NO1 REDEFINES HXANN-IP-NO.
**       門診醫令序號
         04 HXANN-RO-NO                 PIC 9(11).
**          門診序號                    -- ODR-RO-NO
         04 HXANN-OR-NO                 PIC 9(2).
**          處方序號                    -- ODR-ODR-SEQ

         04 HXANN-RO-FL                 PIC X(9).
**          空白項
      03 HXANN-IP-NO2 REDEFINES HXANN-IP-NO.
**       住院醫令序號
         04 HXANN-OD-NO                 PIC 9(11).
**          處方序號                    -- ICB-ODR-NO
         04 HXANN-PD-NO                 PIC 9(11).
**          住院序號                    -- ICB-IPD-NO
      03 HXANN-IP-SEQ                   PIC 9(3).
**       醫令處置序號                   -- ODR-ANN-SEQ OR ICB-ANN-SEQ
   02 HXANN-DATA.
      03 HXANN-TRN-SW                   PIC X(1).
**       異動識別碼
      03 HXANN-CHK-DATE                 PIC 9(7).
**       檢查日期
      03 HXANN-ANN-DATE                 PIC 9(7).
**       報備日期
      03 HXANN-DEL-DATE                 PIC 9(7).
**       刪除日期
*$XFD USE GROUP
      03 HXANN-REV-KEY.
         04 HXANN-PRS-NO                PIC X(9).
**          批價處置代碼                -- ODR-FEE-PRS OR ICB-FEE-KEY
         04 HXANN-REV-SEQ               PIC 9(3).
**          醫令處置倒序號 = 999 - HXANN-IP-SEQ
*$XFD USE GROUP
      03 HXANN-CTM-KEY.
         04 HXANN-CHK-NO                PIC X(8).
**          醫令單號                    -- ODR-CHK-NO  OR ICB-CHK-NO
         04 HXANN-IP-DATE               PIC 9(7).
**          醫令日期                    -- ODR-RO-DATE OR ICB-INS-DATE
         04 HXANN-ITM-CD                PIC X(6).
**          檢查代碼                    -- ODR-ITM-CD  OR ICB-ITM-CD
*$XFD USE GROUP
      03 HXANN-EXE-KEY.
**       報備實施資料
         04 HXANN-PAT-ID                PIC X(10).
**          病患身份字號
         04 HXANN-EXE-DATE              PIC 9(7).
**          實施日期
         04 HXANN-INS-ID                PIC X(12).
**          健保代碼
         04 HXANN-DCT-ID                PIC X(10).
**          醫師身份字號
*$XFD USE GROUP, VAR-LENGTH
      03 HXANN-DATA-ANN.
         04 HXANN-CHK-DATA.
            05 HXANN-CHK-TIME           PIC 9(6).
**             檢查時間
            05 HXANN-CHK-MAN            PIC X(5).
**             檢查人員
         04 HXANN-ANN-DATA.
            05 HXANN-ANN-TIME           PIC 9(6).
**             報備時間
            05 HXANN-ANN-MAN            PIC X(5).
**             報備人員
         04 HXANN-DEL-DATA.

            05 HXANN-DEL-TIME           PIC 9(6).
**             刪除時間
            05 HXANN-DEL-MAN            PIC X(5).
**             刪除人員
            05 HXANN-DEL-SW             PIC X(1).
**             刪除識別碼
         04 HXANN-ACC-NO                PIC X(13).
**          核備號碼
*$XFD USE GROUP, VAR-LENGTH
      03 HXANN-DATA-OTH.
         04 HXANN-ANF-DATA.
            05 HXANN-ANF-DATE           PIC 9(7).
**             首次報備日期
            05 HXANN-ANF-TIME           PIC 9(6).
**             首次報備時間
            05 HXANN-ANF-MAN            PIC X(5).
**             首次報備人員
         04 HXANN-CHG-ID                PIC X(1).
**          收費項目別                  -- ODR-CHG-ID OR ICB-ASU-PAY
         04 HXANN-CHF-DATA.
            05 HXANN-CHF-DATE           PIC 9(7).
**             首次報備時之檢查日期
            05 HXANN-CHF-TIME           PIC 9(6).
**             首次報備時之檢查時間
            05 HXANN-CHF-MAN            PIC X(5).
**             首次報備時之檢查人員
         04 HXANN-OTM-SW                PIC X(2).
**          逾時報備原因代碼            -- 890920
         04 HXANN-FILLER                PIC X(195).
**          空白項

** HXANN-ALT-KEY1 = HXANN-TRN-SW   + HXANN-KEY
** HXANN-ALT-KEY2 = HXANN-CTM-KEY  + HXANN-KEY
** HXANN-ALT-KEY3 = HXANN-CHK-DATE + HXANN-KEY
** HXANN-ALT-KEY4 = HXANN-ANN-DATE + HXANN-KEY
** HXANN-ALT-KEY5 = HXANN-DEL-DATE + HXANN-KEY
** HXANN-ALT-KEY6 = HXANN-EXE-KEY  + HXANN-KEY
** HXANN-ALT-KEY7 = HXANN-TRN-SW   + HXANN-EXE-KEY + HXANN-KEY
** HXANN-ALT-KEY8 = HXANN-TRN-SW   + HXANN-IP-NO   +
**                  HXANN-REV-KEY  + HXANN-IP-SEQ

** HXANN-EXE-DATE = HXANN-CHK-DATE OR HXANN-IP-NO(1:7)

** HXANN-OTM-SW : MOVE '1521' TO NID-ID & MOVE HXANN-OTM-SW TO NID-CODE & READ HG_MNID
** HXANN-TRN-SW : A> 開立, create HXANN-PAT-ID,   HXANN-CTM-KEY,  HXANN-PRS-NO
**                B> 檢查, create HXANN-CHK-DATE, HXANN-CHK-DATA
**                C> 報備, create HXANN-ANN-DATE, HXANN-ANN-DATA, HXANN-EXE-KEY,
**                                HXANN-ANF-DATA, HXANN-CHF-DATA, HXANN-CHG-ID
**                D> 核准, create HXANN-ACC-NO
**                E> 刪除, create HXANN-DEL-DATE, HXANN-DEL-DATA
** HXANN-CHG-ID : 1> 健保項目  2> 自費項目
** HXANN-DEL-SW : A> 批價刪除, B> 人工刪除
**                當取消刪除時須進行下述 PROCEDURE :
**                1. MOVE HXANN-IP-SEQ      TO ODR-ANN-SEQ OR ICB-ANN-SEQ
**                   MOVE HXANN-CHK-NO      TO ODR-CHK-NO  OR ICB-CHK-NO
**                   MOVE HXANN-ITM-CD      TO ODR-ITM-CD  OR ICB-ITM-CD
**                   MOVE HXANN-CHK-NO(1:1) TO ODR-PAS-DPT OR ICB-PAS-DPT

**                   MOVE HXANN-CHK-NO(2:2) TO ODR-PAS-TAB OR ICB-PAS-TAB
**                   MOVE HXANN-ITM-CD      TO ODR-PAS-ITM OR ICB-PAS-ITM
**                2. DO'NT CALL 'HTODRICF'
**                3. MOVE 'N'                      TO W-ODR-TRN-SW(W-COUNT)
**                   MOVE ODR-CHK-NO OR ICB-CHK-NO TO W-ODR-CHK-NO(W-COUNT)
**                   MOVE ODR-ITM-CD OR ICB-ITM-CD TO W-ODR-ITM-CD(W-COUNT)
**                   ....
**                   CALL 'HTODRCF' USING W-ODR-TABLE
**                4. INITIALIZE HXANN-DEL-DATE, HXANN-DEL-DATA
**                   EVALUATE TRUE
**                       WHEN HXANN-ACC-NO NOT = SPACES
**                            MOVE 'D' TO HXANN-TRN-SW
**                       WHEN HXANN-ANN-DATE > 0
**                            MOVE 'C' TO HXANN-TRN-SW
**                       WHEN HXANN-CHK-DATE > 0
**                            MOVE 'B' TO HXANN-TRN-SW
**                       WHEN OTHER
**                            MOVE 'A' TO HXANN-TRN-SW
**                   END-EVALUATE
**                   REWITE HXANN-REC

** HXANN-IP-NO : IF HXANN-IP-NO(14:9) = SPACES OR LOW-VALUE
**                    --> '門診'
**               ELSE
**                    --> '住院'
**               END-IF
*> 97.7.23 金額重結
*COPY    "HI_ENB.MST".
*********************************
*>住院結帳延伸檔  RECORD LENGTH = 267 BYTES
*********************************
 FD      ENB-MST         EXTERNAL.
 01      ENB-MST-REC.
*$XFD USE GROUP
        10 ENB-KEY.
*住院序號
           20 ENB-IPD-NO.
*住院日期
              30 ENB-IPD-DATE                   PIC 9(7).
*住院流水號
              30 ENB-IPD-SEQ                    PIC 9(4).
*結帳流水號
           20 ENB-SEG-SEQ                       PIC 9(3).
*標準費用別
           20 ENB-STD-FNO                       PIC X(3).
*$XFD USE GROUP,VAR-LENGTH
        10 ENB-GROUP-DATA1.
*>應收金額                                              (1, 9)
                20 ENB-3NO-AMT                          PIC S9(7)V99.
*>優免金額(檢驗優免)                                    (10, 9)
                20 ENB-3DI-AMT                          PIC S9(7)V99.
*>部份負擔金額                                          (19, 9)
                20 ENB-PART-AMT                         PIC S9(7)V99.
*>實收金額一般金額                                      (28, 9)
                20 ENB-3R-AMT1                          PIC S9(7)V99.
*>實收金額代收金額                                      (37, 9)
                20 ENB-3R-AMT2                          PIC S9(7)V99.

*>實收金額特約提撥額                                    (46, 9)
                20 ENB-3R-AMT3                          PIC S9(7)V99.
*>自付金額                                              (55, 9)
                20 ENB-3SP-AMT                          PIC S9(7)V99.
*>申報金額                                              (64, 9)
                20 ENB-3AP-AMT                          PIC S9(7)V99.
*>次要身份申報金額                                      (73, 9)
                20 ENB-3RE-AMT                          PIC S9(7)V99.
*>已收金額                                              (82, 9)
                20 ENB-3RCV-AMT                         PIC S9(7)V99.
*>退藥退材 ( UPDATE 84.10.22 ) ...
*>退藥應收金額                                          (91, 9)
                20 ENB-RTB-3NO-AMT                      PIC S9(7)V99.
*>退藥優免金額                                          (100, 9)
                20 ENB-RTB-3DI-AMT                      PIC S9(7)V99.
*>退藥部份負擔金額                                      (109, 9)
                20 ENB-RTB-PART-AMT                     PIC S9(7)V99.
*>退藥實收金額一般金額                                  (118, 9)
                20 ENB-RTB-3R-AMT1                      PIC S9(7)V99.
*>退藥實收金額代收金額                                  (127, 9)
                20 ENB-RTB-3R-AMT2                      PIC S9(7)V99.
*>退藥實收金額特約提撥額                                        (136, 9)
                20 ENB-RTB-3R-AMT3                      PIC S9(7)V99.
*>退藥自付金額                                          (145, 9)
                20 ENB-RTB-3SP-AMT                      PIC S9(7)V99.
*>退藥申報金額                                          (154, 9)
                20 ENB-RTB-3AP-AMT                      PIC S9(7)V99.
*>退藥次要身份申報金額                                  (163, 9)
                20 ENB-RTB-3RE-AMT                      PIC S9(7)V99.
                20 ENB-FILLER                           PIC X(79).
                20 ENB-REF-DATA         REDEFINES ENB-FILLER.
*>是否為優免項目 (85.5.10)                              (172, 1)
                      30 ENB-LB-YN                    PIC X.
*>優免總金額(85.5.10)                                   (173, 9)
                      30 ENB-LB-APP-AMT               PIC S9(7)V99.
*>優免金額申報差額 -->加到 優免金額 (85.5.10)           (182, 9)
                      30 ENB-DEF-LB-APP-AMT           PIC S9(7)V99.
*>                                                      (191, 9)
                      30 ENB-LB-PART-AMT              PIC S9(7)V99.
*>                                                      (200, 9)
                      30 ENB-DEF-LB-PART-AMT          PIC S9(7)V99.
*> 超出 15000 之金額 ..                                 (209, 9)
                      30 ENB-D1-AMT                   PIC S9(7)V99.
*>                                                      (218, 9)
                      30 ENB-REF-DEF                  PIC X(9).
                      30 ENB-REF-AMT REDEFINES ENB-REF-DEF PIC S9(7)V99.
*>                                                      (227, 8)
                      30 ENB-SLOW-PART-DEF            PIC X(8).
                      30 ENB-SLOW-PART REDEFINES ENB-SLOW-PART-DEF PIC S9(6)V99.
*>                                                      (235, 8)
                      30 ENB-QUICK-PART-DEF            PIC X(8).
                      30 ENB-QUICK-PART REDEFINES ENB-QUICK-PART-DEF PIC S9(6)V99.
*>使用參考身份生效區間折扣 Y , ENB-3RE-AMT -->生效區間自付金額  (243, 1)
                      30 ENB-REF-RANG                 PIC X.
*>                                                              (244, 7)
                      30 ENB-FILLER1                  PIC X(7).
*> **************************************************************************

*>      END     OF      FILE
*> **************************************************************************
*COPY    "HI_KEY.TMP".
*********************************************************************************
*       鍵值檢查檔                                                              *
*       外部檔名  HI_KEY.TMP  -->  檔名  HI_TKEY                                *
*       主:IKEY-TMP-KEY                                                         *
* 920812  配合GUI改版、外部檔名由HI_PKEY-->HI_TKEY      (JAY)                   *
*> 97/04/29 Frank-台大化療需求-增加識別B、C                                     *
*********************************************************************************
*>      住院暫存資料
 FD      IKEY-TMP         EXTERNAL.
 01      IKEY-TMP-REC.
*$XFD USE GROUP
        02      IKEY-TMP-KEY.
*>              識別(A.住院病歷暫存 B.化療針劑藥袋流水號 C.化療針劑藥袋領藥號)
                10  IKEY-TMP-ID                         PIC X(01).
                10  IKEY-TMP-DATA1                      PIC X(50).
                10  IKEY-ENA-DATA1      REDEFINES       IKEY-TMP-DATA1.
*>                      病歷號
                        20  IKEY-ENA-PAT-NO             PIC 9(8).
                        20  IKEY-ENA-FILLER             PIC X(42).

        02      IKEY-TMP-DATA2                          PIC X(250).
*>              A.住院病歷暫存
        02      IKEY-ENA-DATA2  REDEFINES       IKEY-TMP-DATA2.
*>              線路編號
                10  IKEY-SLNO                           PIC 9(4).
*>              使用者
                10  IKEY-USER                           PIC X(5).
*>              執行作業
                10  IKEY-JOB                            PIC X(8).
*>              存取日期
                10  IKEY-DATE                           PIC 9(8).
*>              存取時間
                10  IKEY-TIME                           PIC 9(6).
*>              預留
                10  IKEY-FILLER                         PIC X(219).
***********************************************************************************
*COPY    "HI_ICC.MST".
****************************
*住院處方延伸檔(將單張處方費用歸類為院內標準費用別)
*               RECORD LENGTH = 179 BYTES
****************************
 FD      ICC-MST         EXTERNAL.
 01      ICC-MST-REC.
*$XFD USE GROUP
        10 ICC-KEY.
*住院序號
           20 ICC-IPD-NO.
              30 ICC-IPD-DATE           PIC 9(7).
              30 ICC-IPD-SEQ            PIC 9(4).
*處方序號
           20 ICC-ODR-NO.
*處方日期
              30 ICC-INS-DATE           PIC 9(7).
*處方流水號

              30 ICC-ODR-SEQ            PIC 9(4).
*標準費用別
           20 ICC-STD-FNO               PIC X(3).
*$XFD USE GROUP,VAR-LENGTH
        10 ICC-GROUP-DATA1.
*結帳序號(此筆處方須歸類到那一筆結帳序號)
                20 ICC-SEG-SEQ                  PIC 9(3).
*應收金額
                20 ICC-3NO-AMT                  PIC S9(7)V99.
*優免金額
                20 ICC-3DI-AMT                  PIC S9(7)V99.
*部份負擔金額
                20 ICC-PART-AMT                 PIC S9(7)V99.
*實收金額一般金額
                20 ICC-3R-AMT1                  PIC S9(7)V99.
*實收金額代收金額
                20 ICC-3R-AMT2                  PIC S9(7)V99.
*實收金額特約提撥額
                20 ICC-3R-AMT3                  PIC S9(7)V99.
*自付額
                20 ICC-3SP-AMT                  PIC S9(7)V99.
*申報額
                20 ICC-3AP-AMT                  PIC S9(7)V99.
*參考身份申報額
                20 ICC-3RE-AMT                  PIC S9(7)V99.
*已收額
                20 ICC-3RCV-AMT                 PIC S9(7)V99.
*[T] 過帳資料 [D] 刪除備註
                20 ICC-DEL-MARK                 PIC X.
*
                20 ICC-FILLER                   PIC X(60).
                20 ICC-REF-DATA         REDEFINES ICC-FILLER.
*是否為優免項目 (85.5.10)
                        30 ICC-LB-YN                    PIC X.
*優免總金額 (85.5.10)
                        30 ICC-LB-APP-AMT               PIC S9(7)V99.
*優免金額申報差額 ---> 加到 優免金額 (85.5.10)
                        30 ICC-DEF-LB-APP-AMT           PIC S9(7)V99.
*
                        30 ICC-LB-PART-AMT              PIC S9(7)V99.
*
                        30 ICC-DEF-LB-PART-AMT          PIC S9(7)V99.
                        30 ICC-FILLER1                  PIC X(23).
*COPY    "HI_ENA.MST".
****************************
*住院結帳檔 RECORD LENGTH = 264 BYTES
****************************
 FD      ENA-MST         EXTERNAL.
 01      ENA-MST-REC.
* KEY 值 = 住院序號 + 結帳流水號
*$XFD USE GROUP
        10 ENA-KEY.
*住院序號
           20 ENA-IPD-NO.
*住院日期
              30 ENA-IPD-DATE           PIC 9(7).
*住院流水號

              30 ENA-IPD-SEQ            PIC 9(4).
*結帳流水號
           20 ENA-SEG-SEQ               PIC 9(3).
*$XFD USE GROUP,VAR-LENGTH
        10 ENA-GROUP-DATA1.
*>結帳日期      (1,7)
                20 ENA-SEG-DATE                 PIC 9(7).
*>應收總額      (8, 9)
                20 ENA-NOM-AMT                  PIC S9(7)V99.
*>優免金額(檢驗優免)    (17, 9)
                20 ENA-DIS-AMT                  PIC S9(7)V99.
*>部份負擔金額  (26, 9)
                20 ENA-PART-AMT                 PIC S9(7)V99.
*>自付金額      (35, 9)
                20 ENA-SP-AMT                   PIC S9(7)V99.
*>申報金額      (44, 9)
                20 ENA-APP-AMT                  PIC S9(7)V99.
*>次要身份申報金額      (53, 9)
                20 ENA-REF-AMT                  PIC S9(7)V99.
*>已收金額              (62, 9)
                20 ENA-RCV-AMT                  PIC S9(7)V99.
*>欠款金額 (UPDATE 84.09.21 )   (71, 9)
                20 ENA-URCV-AMT                 PIC S9(7)V99.
*>固定費用處方序號              (80, 11)
                20 ENA-ODR-NO.
*>固定費用處方日期
                        30 ENA-ODR-DATE         PIC 9(7).
*>固定費用處方流水號(UPDATE 84.09.21 .. 9(3) => 9(4) )
                        30 ENA-ODR-SEQ          PIC 9(4).
*>收據號碼                      (91, 8)
                20 ENA-ACC-NO                   PIC 9(8).
*>超出 最高上限 之金額 15000 (84.09.14) (99, 1)
                20 ENA-OVER-15000               PIC X.
*>優免總項次(84.09.29)                  (100, 3)
                20 ENA-LB-CNT                   PIC 9(3).
*>優免總項次,申報總額 (84.09.29)                (103, 9)
                20 ENA-LB-APP-AMT               PIC S9(7)V9(2).
*>是否優免(84.10.01)                    (112, 1)
                20 ENA-LB-YN                    PIC X.
*>優免金額申報差額(84.10.01) --> 加到 優免金額去 .      (113, 9)
                20 ENA-DEF-LB-APP-AMT           PIC S9(7)V9(2).
** UPDATE 84.10.22
*>退藥退材 MARK                                         (122, 1)
                20 ENA-RTA-MARK                 PIC X.
*>退藥退材處方箋數 ...                                  (123, 3)
                20 ENA-RTA-NUMS                 PIC 9(3).
*>退藥應收總額                                          (126, 9)
                20 ENA-RTA-NOM-AMT              PIC S9(7)V99.
*>退藥優免金額                                          (135, 9)
                20 ENA-RTA-DIS-AMT              PIC S9(7)V99.
*>退藥部份負擔金額                                      (144, 9)
                20 ENA-RTA-PART-AMT             PIC S9(7)V99.
*>退藥自付金額                                          (153, 9)
                20 ENA-RTA-SP-AMT               PIC S9(7)V99.
*>退藥申報金額                                          (162, 9)
                20 ENA-RTA-APP-AMT              PIC S9(7)V99.
*>次要身份申報金額                                      (171, 9)

                20 ENA-RTA-REF-AMT              PIC S9(7)V99.
                20 ENA-FILLER                   PIC X(71).
                20 ENA-REF-DATA         REDEFINES ENA-FILLER.
*>有檢驗優免之部份負擔金額                              (180, 9)
                   30 ENA-LB-PART-AMT           PIC S9(7)V99.
*>                                                      (189, 9)
                   30 ENA-DEF-LB-PART-AMT       PIC S9(7)V9(2).
*>註銷欠款碼                                            (198, 1)
                   30 ENA-RCV-AMT-MARK          PIC X.
*>超出 15000 之金額                                     (199, 9)
                   30 ENA-D1-AMT                PIC S9(7)V9(2).
*>住院結帳 Y                                            (208, 1)
                   30 ENA-SEG-MARK              PIC X.
*>住院結帳日期                                          (209, 7)
                   30 ENA-SEG-UPDDT             PIC 9(7).
*>住院結帳時間                                          (216, 6)
                   30 ENA-SEG-UPDTI             PIC 9(6).
*>住院結帳者                                            (222, 5)
                   30 ENA-SEG-USER              PIC X(5).
*>慢性部份負擔                                          (227, 8)
                   30 ENA-SLOW-PART-DEF         PIC X(8).
                   30 ENA-SLOW-PART REDEFINES ENA-SLOW-PART-DEF PIC S9(6)V99.
*>急性部份負擔                                          (235, 8)
                   30 ENA-QUICK-PART-DEF        PIC X(8).
                   30 ENA-QUICK-PART REDEFINES ENA-QUICK-PART-DEF PIC S9(6)V99.
*>P:收款額為零, Y:有欠款                                        (243, 1)
                   30 ENA-URA-MARK              PIC X.
*>                                                      (244, 1)
                   30 ENA-RCI-ADD               PIC X.
*>                                                      (245, 1)
                   30 ENA-REF-RANG              PIC X.
*>                                                      (246, 5)
                   30 ENA-FILLER1               PIC X(5).
******************************************************************************
*>      END     OF      FILE
******************************************************************************
*COPY    "HI_ENC.MST".
*****************************************************************************
*> 住院結帳延伸檔 RECORD LENGTH = 381 BYTES
*> 主:ENC-KEY
*> 出院結帳查詢使用
*> ENC-ALT-KEY1 =  ENC-IPD-NO  ENC-SEG-SEQ-V
*> 每月列印請款單/整批結帳使用
*> ENC-ALT-KEY2 =  ENC-END-DT  ENC-IPD-NO  ENC-SEG-SEQ
*> 97/10/07 Frank-增加手術/檢驗檢查折扣：健保不給付額、手術檢驗檢查折扣：其他金額(自費)
*****************************************************************************
 FD      ENC-MST         EXTERNAL.
 01      ENC-MST-REC.
*> 主KEY 值 = 住院序號 + 結帳流水號
        10 ENC-KEY.
*$XFD USE GROUP
*> 住院序號
                20 ENC-IPD-NO.
*>              住院日期
                        30 ENC-IPD-DATE         PIC 9(7).
*>              住院流水號
                        30 ENC-IPD-SEQ          PIC 9(4).

*> 結帳流水號
                20 ENC-SEG-SEQ                  PIC 9(3).
*>
        10 ENC-DATA1.
*> 結帳截止日(前五碼表示結帳年月)
                20 ENC-END-DT                   PIC 9(7).
*> 結帳截止日(9999999 - ENC-END-DT)
                20 ENC-END-DT-V                 PIC 9(7).
*> 結帳流水號(倒KEY: 999 - ENC-SEG-SEQ)
                20 ENC-SEG-SEQ-V                PIC 9(3).
*>
*$XFD USE GROUP,VAR-LENGTH
        10 ENC-GROUP-DATA1.
*> 結帳起始日                                           (1,7)
                20 ENC-BEG-DT                   PIC 9(7).
*> 異動日期                                             (8,7)
                20 ENC-UPD-DT                   PIC 9(7).
*> 異動者                                               (15,5)
                20 ENC-UPD-USER                 PIC X(5).
*>96.11.15 新版住院收據新增欄位
*>(急性)住院部分負擔  1~30日(10%)                       (20,9)
                20 ENC-QUICK-PART10-AMT         PIC S9(7)V99.
*>(急性)住院部分負擔 31~60日(20%)                       (29,9)
                20 ENC-QUICK-PART20-AMT         PIC S9(7)V99.
*>(急性)住院部分負擔 61日以上(30%)                      (38,9)
                20 ENC-QUICK-PART30-AMT         PIC S9(7)V99.
*>(慢性)住院部分負擔 30日以下(5%)                       (47,9)
                20 ENC-SLOW-PART5-AMT           PIC S9(7)V99.
*>(慢性)住院部分負擔 31~90日(10%)                       (56,9)
                20 ENC-SLOW-PART10-AMT          PIC S9(7)V99.
*>(慢性)住院部分負擔 91~180日(20%)                      (65,9)
                20 ENC-SLOW-PART20-AMT          PIC S9(7)V99.
*>(慢性)住院部分負擔 181日以上(30%)                     (74,9)
                20 ENC-SLOW-PART30-AMT          PIC S9(7)V99.
*>(急性)退藥部份負擔金額  1~30日(10%)                   (83,9)
                20 ENC-RTA-QUICK-PART10-AMT     PIC S9(7)V99.
*>(急性)退藥部份負擔金額 31~60日(20%)                   (92,9)
                20 ENC-RTA-QUICK-PART20-AMT     PIC S9(7)V99.
*>(急性)退藥部份負擔金額 61日以上(30%)                  (101,9)
                20 ENC-RTA-QUICK-PART30-AMT     PIC S9(7)V99.
*>(慢性)退藥部份負擔金額 30日以下(5%)                   (110,9)
                20 ENC-RTA-SLOW-PART5-AMT       PIC S9(7)V99.
*>(慢性)退藥部份負擔金額 31~90日(10%)                   (119,9)
                20 ENC-RTA-SLOW-PART10-AMT      PIC S9(7)V99.
*>(慢性)退藥部份負擔金額 91~180日(20%)                  (128,9)
                20 ENC-RTA-SLOW-PART20-AMT      PIC S9(7)V99.
*>(慢性)退藥部份負擔金額 181日以上(30%)                 (137,9)
                20 ENC-RTA-SLOW-PART30-AMT      PIC S9(7)V99.
*> 97.10.07 手術/檢驗檢查折扣：健保不給付額(健保)       (146,9)
                20 ENC-NHI-DIS-AMT              PIC S9(7)V9(2).
*> 97.10.07 手術/檢驗檢查折扣：其他金額(自費)           (155,9)
                20 ENC-SP-DIS-AMT               PIC S9(7)V9(2).
*> 預留
                20 ENC-FILLER                   PIC X(87).
*$XFD USE GROUP,VAR-LENGTH
        10 ENC-GROUP-DATA2                      PIC X(100).
******************************************************************************

*>      END     OF      FILE
******************************************************************************
*COPY    "HI_END.MST".
*********************************
*>96.11.15 新版住院收據新增此ENB延伸檔-->END
*>住院結帳延伸檔  RECORD LENGTH = 417 BYTES
*> 97/10/07 Frank-增加手術/檢驗檢查折扣：健保不給付額、手術檢驗檢查折扣：其他金額(自費)
*********************************
 FD      HIEND-MST         EXTERNAL.
 01      HIEND-MST-REC.
*$XFD USE GROUP
        10 HIEND-KEY.
*住院序號
           20 HIEND-IPD-NO.
*住院日期
              30 HIEND-IPD-DATE                   PIC 9(7).
*住院流水號
              30 HIEND-IPD-SEQ                    PIC 9(4).
*結帳流水號
           20 HIEND-SEG-SEQ                       PIC 9(3).
*標準費用別
           20 HIEND-STD-FNO                       PIC X(3).
*$XFD USE GROUP,VAR-LENGTH
        10 HIEND-GROUP-DATA1.
*>(急性)住院部分負擔  1~30日(10%)                       (1,9)
                20 HIEND-QUICK-PART10-AMT         PIC S9(7)V99.
*>(急性)住院部分負擔 31~60日(20%)                       (10,9)
                20 HIEND-QUICK-PART20-AMT         PIC S9(7)V99.
*>(急性)住院部分負擔 61日以上(30%)                      (19,9)
                20 HIEND-QUICK-PART30-AMT         PIC S9(7)V99.
*>(慢性)住院部分負擔 30日以下(5%)                       (28,9)
                20 HIEND-SLOW-PART5-AMT           PIC S9(7)V99.
*>(慢性)住院部分負擔 31~90日(10%)                       (37,9)
                20 HIEND-SLOW-PART10-AMT          PIC S9(7)V99.
*>(慢性)住院部分負擔 91~180日(20%)                      (46,9)
                20 HIEND-SLOW-PART20-AMT          PIC S9(7)V99.
*>(慢性)住院部分負擔 181日以上(30%)                     (55,9)
                20 HIEND-SLOW-PART30-AMT          PIC S9(7)V99.
*>(急性)退藥部份負擔金額  1~30日(10%)                   (64,9)
                20 HIEND-RTA-QUICK-PART10-AMT     PIC S9(7)V99.
*>(急性)退藥部份負擔金額 31~60日(20%)                   (73,9)
                20 HIEND-RTA-QUICK-PART20-AMT     PIC S9(7)V99.
*>(急性)退藥部份負擔金額 61日以上(30%)                  (82,9)
                20 HIEND-RTA-QUICK-PART30-AMT     PIC S9(7)V99.
*>(慢性)退藥部份負擔金額 30日以下(5%)                   (91,9)
                20 HIEND-RTA-SLOW-PART5-AMT       PIC S9(7)V99.
*>(慢性)退藥部份負擔金額 31~90日(10%)                   (100,9)
                20 HIEND-RTA-SLOW-PART10-AMT      PIC S9(7)V99.
*>(慢性)退藥部份負擔金額 91~180日(20%)                  (109,9)
                20 HIEND-RTA-SLOW-PART20-AMT      PIC S9(7)V99.
*>(慢性)退藥部份負擔金額 181日以上(30%)                 (118,9)
                20 HIEND-RTA-SLOW-PART30-AMT      PIC S9(7)V99.
*>住院病房天數                                          (127,4)
                20 HIEND-ROOM-DAYS                PIC 9(4).
*> 97.10.07 手術/檢驗檢查折扣：健保不給付額(健保)       (131,9)
                20 HIEND-NHI-DIS-AMT            PIC S9(7)V9(2).
*> 97.10.07 手術/檢驗檢查折扣：其他金額(自費)           (140,9)

                20 HIEND-SP-DIS-AMT             PIC S9(7)V9(2).
*> 預留
                20 HIEND-FILLER                 PIC X(102).
*$XFD USE GROUP,VAR-LENGTH
        10 HIEND-GROUP-DATA2                    PIC X(150).
*> **************************************************************************
*>      END     OF      FILE
*> **************************************************************************
*> 103.06.27 (書伶) 修改實際退藥量欄位讀取來源，改讀RTA及RTB。
*COPY    "HI_RTA.MST".
**************************
*退藥材處方檔  RECORD LENGTH = 179 BYTES
*> 901114 insert: RTA-BATCH-YN : Y 表示由退藥確認產生的
**************************
 FD      RTA-MST         EXTERNAL.
 01      RTA-MST-REC.
* KEY 值 = 住院序號 + UD 起始日期 + UD 流水號
*$XFD USE GROUP
        10 RTA-KEY.
*住院序號
           20 RTA-IPD-NO.
*住院日期
              30 RTA-IPD-DATE           PIC 9(7).
*住院流水號
              30 RTA-IPD-SEQ            PIC 9(4).
           20 RTA-ODR-NO.
*退藥處方日期
              30 RTA-INS-DATE           PIC 9(7).
*退藥處方流水號
              30 RTA-ODR-SEQ            PIC 9(3).
*$XFD USE GROUP,VAR-LENGTH
        10 RTA-GROUP-DATA1.
*結帳序號(此筆處方須歸類到那一筆結帳序號)                       (1, 3)
                20 RTA-SEG-SEQ                  PIC 9(3).
*退藥 科別代碼                                                  (4, 4)
                20 RTA-DEPT-NO                  PIC X(4).
*退藥 醫師代碼                                                  (8, 4)
                20 RTA-DR-NO                    PIC X(4).
*退藥 身份代碼                                                  (12, 4)
                20 RTA-IDNT-NO                  PIC X(4).
*退藥 處方床號                                                  (16, 6)
                20 RTA-WARD.
                        30 RTA-BED-ROOM         PIC X(4).
                        30 RTA-BED-NO                   PIC X(2).
*退藥處方登錄者 ....UPDATE 84.10.31                             (22, 5)
                20 RTA-USR-ID                   PIC X(5).
*應收總額                                                       (27, 9)
                20 RTA-NOM-AMT                  PIC S9(7)V9(2).
*優免金額                                                       (36, 9)
                20 RTA-DIS-AMT                  PIC S9(7)V9(2).
*部份負擔金額                                                   (45, 9)
                20 RTA-PART-AMT                 PIC S9(7)V9(2).
*自付金額                                                       (54, 9)
                20 RTA-SP-AMT                   PIC S9(7)V9(2).
*申報金額                                                       (63, 9)
                20 RTA-APP-AMT                  PIC S9(7)V9(2).
*參考身份申報金額                                               (72, 9)

                20 RTA-REF-AMT                  PIC S9(7)V9(2).
*已收金額                                                       (81, 9)
                20 RTA-RCV-AMT                  PIC S9(7)V9(2).
*病房類別(Y-急性病房, N-慢性病房) UPDATE 84.10.16               (90, 1)
                20 RTA-BED-ID                   PIC X.
*負擔百分比 (84.10.16)                                          (91, 3)
                20 RTA-COM-RATE                 PIC 9(3).
*部份負擔代碼(000:應部份負擔,001,002,003,004,005:免部份負擔,111:自費)　(94, 3)
                20 RTA-IPD-PART                 PIC X(3).
*負擔%(因為住院是一段區間,可能某期間需要部份負擔,某期間不需部份負擔)
*        ( 0:免部份負擔, 1:急性病房部份負擔 10%, 2:急性病房 20%, 3:急性
*            病房 30%, 4:慢性病房 5%, 5:慢性病房 10%, 6:慢性病房 20%,
*          7:慢性病房 30%  A:自費 100%                                  (97, 1)
                20 RTA-RESPOND                  PIC X.
*[T] 過帳資料 [D] 刪除備註 84.10.16                                     (98, 1)
                20 RTA-DEL-MARK                 PIC X.
*>                                                                      (99, 8)
                20 RTA-SLOW-PART-DEF            PIC X(8).
                20 RTA-SLOW-PART  REDEFINES RTA-SLOW-PART-DEF  PIC S9(6)V99.
*>                                                                      (107, 8)
                20 RTA-QUICK-PART-DEF           PIC X(8).
                20 RTA-QUICK-PART REDEFINES RTA-QUICK-PART-DEF PIC S9(6)V99.
*>                                                                      (115, 3)
                20 RTA-COM-DAYS                 PIC 9(3).
*緊急(Y->送藥袋) 87/08/20增加                                           (118, 1)
                20 RTA-EMG-CD                   PIC X(1).
*藥袋號碼       87/08/24增加                                            (119, 4)
                20 RTA-PILL-NO                  PIC 9(4).
*退藥修改者                                                             (123, 5)
                20 RTA-UPD-USR                  PIC X(5).
*處方建檔日                                                             (128, 7)
                20 RTA-CRE-DT                   PIC 9(7).
*Y ->為退藥確認作業 產生
                20 RTA-BATCH-YN                 PIC X(1).
                20 RTA-FILLER                   PIC X(23).
**************************
*>      END     OF      FILE
**************************
*COPY    "HI_RTB.MST".
****************************
*退藥處方明細檔 RECORD LENGTH = 225 BYTES
*> 900216 INSERT :RTB-ECB-FILE-NO
*> 900301 INSERT :RTB-STK-CNT
****************************
 FD      RTB-MST         EXTERNAL.
 01      RTB-MST-REC.
* KEY 值 = 住院序號 + UD 起始日期 + UD 流水號 + 處置流水號
*$XFD USE GROUP
        10 RTB-KEY.
*住院序號
           20 RTB-IPD-NO.
*住院日期
              30 RTB-IPD-DATE           PIC 9(7).
*住院流水號
              30 RTB-IPD-SEQ            PIC 9(4).
           20 RTB-ODR-NO.
*退藥 處方日期

              30 RTB-INS-DATE           PIC 9(7).
*退藥 流水號
              30 RTB-ODR-SEQ            PIC 9(3).
*處置流水號
           20 RTB-FEE-SEQ               PIC 9(3).
*$XFD USE GROUP,VAR-LENGTH
        10 RTB-GROUP-DATA1.
*處置代碼(必為藥品、衛材)                               (1,9)
                20 RTB-FEE-KEY                  PIC X(9).
*標準費用別                                             (10,3)
                20 RTB-STD-FNO                  PIC X(3).
*費用歸屬科別(成本中心)                                 (13,5)
                20 RTB-FEE-DEPT                 PIC X(5).
*庫別                                                   (18,4)
                20 RTB-STO-DEPT                 PIC X(4).
*退藥身份                                               (22,4)
                20 RTB-IDNT-NO                  PIC X(4).
*急診加成                                               (26,1)
                20 RTB-EXTRA                    PIC X.
*退藥理由                                               (27,1)
                20 RTB-RESN                     PIC X.
*退藥種類                                               (28,1)
                20 RTB-KIND                     PIC X.
*退藥 總量
                20 RTB-RX-QTY.
*退藥總量分子                                           (29,4)
                        30 RTB-RX-QTY1          PIC 9(4).
*退藥 總量分母                                          (33,2)
                        30 RTB-RX-QTY2          PIC 9(2).
*單價                                                   (35,8)
                20 RTB-PRICE                    PIC 9(6)V9(2).
*應收金額                                               (43,9)
                20 RTB-NOM-AMT                  PIC S9(7)V9(2).
*優免金額                                               (52,9)
                20 RTB-DIS-AMT                  PIC S9(7)V9(2).
*部份負擔金額                                           (61,9)
                20 RTB-PART-AMT                 PIC S9(7)V9(2).
*實收金額一般金額                                       (70,9)
                20 RTB-RE-AMT1                  PIC S9(7)V9(2).
*實收金額代收金額                                       (79,9)
                20 RTB-RE-AMT2                  PIC S9(7)V9(2).
*實收金額特約提撥額                                     (88,9)
                20 RTB-RE-AMT3                  PIC S9(7)V9(2).
*自付額                                                 (97,9)
                20 RTB-SP-AMT                   PIC S9(7)V9(2).
*申報額                                                 (106,9)
                20 RTB-APP-AMT                  PIC S9(7)V9(2).
*次要身份申報額                                         (115,9)
                20 RTB-REF-AMT                  PIC S9(7)V9(2).
*異動人代碼                                             (124,4)
                20 RTB-UPD-UID                  PIC X(4).
*異動日期                                               (128,7)
                20 RTB-UPD-DATE                 PIC 9(7).
*異動時間                                               (135,6)
                20 RTB-UPD-TIME                 PIC 9(6).
*異動碼                                                 (141,1)
                20 RTB-UPD-MARK                 PIC X.

                20 RTB-FILLER                   PIC X(60).
                20 RTB-REF-DATA         REDEFINES RTB-FILLER.
*>                                                      (142,3)
                        30 RTB-DG-FLAG          PIC X(3).
*> 退藥對應批價之處方序號                               (145,11)
                        30 RTB-ICB-ODR          PIC X(11).
*> 退藥對應批價之處置序號                               (156,3)
                        30 RTB-ICB-ODR-SEQ      PIC 9(3).
                        30 RTB-ICB-ODR-MRK      PIC X.
*付費否
                        30 RTB-CHG-FLAG         PIC X(1).
*自費否 (暫時未用 880830 加)
                        30 RTB-ASU-PAY          PIC X(1).
                        30 RTB-APY-TYPE         PIC X.
                        30 RTB-APY-QTY          PIC 9(5)V9.
*> Y->該處置為指定退藥
                        30 RTB-APT-YN           PIC X.
*> 900216 INSERT:
*> 退藥對應批價之檔案序號(ECB-FILE-NO)
                        30 RTB-ECB-FILE-NOX     PIC X(3).
                        30 RTB-ECB-FILE-NO REDEFINES RTB-ECB-FILE-NOX   PIC 9(3).
*> 900301 INSERT: 庫存對照碼
                        30 RTB-STK-CNT          PIC X(13).
*> 事前審查項目(940105)
                        30 RTB-PRD-YN           PIC X(1).
                        30 RTB-FILLER1          PIC X(15).
*> ****************************************************************************
*>      END     OF      FILE
*> ****************************************************************************
*> 103.06.27 END
*>2019/12/24 耀瑄NIS
*>刪除時加寫HR_UDL3
*COPY    "HR_UDL3.MST".
*>--------------------------------------------------------------------------------------*
*>              住院醫令[檢驗檢查放射]異動記錄檔：HR_UDL3.MST           檔案：HR_UDL3   *
*>--------------------------------------------------------------------------------------*
*>              主：HRUDL3-MST-KEY                                                      *
*>              副：HRUDL3-ALT-KEY1 = HRUDL3-UPD-DTI HRUDL3-MST-KEY                     *
*>              副：HRUDL3-ALT-KEY2 = HRUDL3-STATUS HRUDL3-MST-KEY                      *
*>--------------------------------------------------------------------------------------*
 FD      HRUDL3-MST         EXTERNAL.
 01      HRUDL3-MST-REC.
*$XFD USE GROUP
*57
        02      HRUDL3-MST-KEY.
*>              新增日期(1:8)
                03      HRUDL3-C-DATE                           PIC X(08).
*>              新增時間(9:6)
                03      HRUDL3-C-TIME                           PIC X(06).
*>              住院序號(15:20)
                03      HRUDL3-PATIENT-SEQ                      PIC X(20).
*>              流水序(35:3)
                03      HRUDL3-ORDER-SEQ                        PIC 9(03).
*>              KEY-FILLER(38:20)
                03      HRUDL3-KEY-FILLER                       PIC X(20).
*24
*$XFD USE GROUP

*>      異動日時
        02      HRUDL3-UPD-DTI.
*>              異動日期(1:7)
                03      HRUDL3-UPD-DT                           PIC 9(07).
*>              異動時間(8:8)
                03      HRUDL3-UPD-TIME                         PIC 9(08).
*>              更新狀態(空白或N:未更新或未抓取/Y:更新或抓取)(16:1)
        02      HRUDL3-STATUS                                   PIC X(01).
*>      病歷號
        02      HRUDL3-PAT-NO                                   PIC 9(08).
*250
*$XFD USE GROUP , VAR-LENGTH
    02  HRUDL3-DATA-1.
*>              檔案序號(1:10)
                03      HRUDL3-FILE-NO                          PIC 9(10).
*>              開立狀態(11:1)
                03      HRUDL3-STATUS-FLAG                      PIC X(01).
*>              處置代碼(12:12)
                03      HRUDL3-ODR-CODE                         PIC X(12).
*>              次劑量-分子(24:7)
                03      HRUDL3-DOSE-MOLE                        PIC 9(05)V9(02).
*>              次劑量-分母(31:5)
                03      HRUDL3-DOSE-DENO                        PIC 9(05).
*>              途徑(36:10)
                03      HRUDL3-METHOD-CODE                      PIC X(10).
*>              開立天數(46:4)
                03      HRUDL3-DAYS                             PIC 9(04).
*>              開始日(50:8)
                03      HRUDL3-B-DATE                           PIC X(08).
*>              開始時分(58:4)
                03      HRUDL3-B-TIME                           PIC X(04).
*>              結束日(62:8)
                03      HRUDL3-E-DATE                           PIC X(08).
*>              結束時分(70:4)
                03      HRUDL3-E-TIME                           PIC X(04).
*>              總量-分子(74:7)
                03      HRUDL3-NUM-MOLE                         PIC 9(05)V9(02).
*>              總量-分母(81:5)
                03      HRUDL3-NUM-DENO                         PIC 9(05).
*>              急作註記(86:1)
                03      HRUDL3-ER-FLAG                          PIC X(01).
*>              自費識別(87:1)
                03      HRUDL3-OWN-FLAG                         PIC X(01).
*>              計價方式(88:1)
                03      HRUDL3-VAL-SWITCH                       PIC X(01).
*>              腦部加成(89:1)
                03      HRUDL3-BRAIN-FLAG                       PIC X(01).
*>              部位(90:1)
                03      HRUDL3-POSITION-FLAG                    PIC X(01).
*>              開立醫師(91:10)
                03      HRUDL3-DR-CODE                          PIC X(10).
*>              實作醫師一(101:10)
                03      HRUDL3-CARRY1-CODE                      PIC X(10).
*>              實作醫師二(111:10)
                03      HRUDL3-CARRY2-CODE                      PIC X(10).
*>              報告醫師(121:10)
                03      HRUDL3-REPORT-DR-CODE                   PIC X(10).

*>              連帶指標(父項)(131:1)
                03      HRUDL3-LNK-POINT-HEAD                   PIC X(01).
*>              連帶指標(子項)(132:9)
                03      HRUDL3-LNK-POINT                        PIC X(09).
*>              連帶指標時間(141:6)
                03      HRUDL3-LNK-TIME                         PIC X(06).
*>              科室代碼(147:1)
                03      HRUDL3-DPT-CODE                         PIC X(01).
*>              類別代碼(148:2)
                03      HRUDL3-CLS-CODE                         PIC X(02).
*>              流水序(150:6)
                03      HRUDL3-SERIAL-NO                        PIC X(06).
*>              醫令項目代碼(156:6)
                03      HRUDL3-ITM-CODE                         PIC X(06).
*>              院內費用項目代碼(162:4)
                03      HRUDL3-STD-CODE                         PIC X(04).
*>              庫存代碼(166:10)
                03      HRUDL3-STORE-CODE                       PIC X(10).
*>              2019/12/24 處方床號(176:6)
                03      HRUDL3-CHG-BED                          PIC X(06).
*>              2019/12/24 目前住院序號(182:11)
                03      HRUDL3-NOW-IPD-NO.
                        04      HRUDL3-NOW-IPD-DATE             PIC 9(07).
                        04      HRUDL3-NOW-IPD-SEQ              PIC 9(04).
*>              2020/08/07 直線加速器放射診療項目之新部位碼(194:2)
                03      HRUDL3-NEW-POSITION-FLAG        PIC X(02).
*>              預留(196:56)
                03      HRUDL3-FILLER                           PIC X(56).
*$XFD USE GROUP , VAR-LENGTH
        02      HRUDL3-DATA-2.
*>              備註(1:80)
                03      HRUDL3-ODR-NOTE                         PIC X(80).
*>              預留(81:170)
                03      HRUDL3-DATA-2-FILLER                    PIC X(170).
*>記錄ICA寫檔錯誤碼[7]
*COPY    "HR_LOG2.MST".
*-------------------------------------------------------------------------*
* 急診處方新增記錄檔：HR_LOG2.MST                     檔案：HR_MLOG2      *
*-------------------------------------------------------------------------*
* 主：LOG2-MST-KEY = LOG2-RO-KEY LOG2-CRE-DATE LOG2-UPD-MRK LOG2-FEE-NO   *
* 副：LOG2-ALT-KEY1 = LOG2-RO-KEY LOG2-UPD-CNT LOG2-CRE-DATE LOG2-UPD-MRK *
*                     LOG2-FEE-NO                                         *
* 副：LOG2-ALT-KEY2 = LOG2-RO-KEY LOG2-DCRE-DATE LOG2-UPD-MRK LOG2-FEE-NO *
*-------------------------------------------------------------------------*
 FD      LOG2-MST                EXTERNAL.
 01      LOG2-MST-REC.
*> 處方序號
*$XFD USE GROUP, VAR-LENGTH
        02      LOG2-RO-KEY.
                03      LOG2-RO-NO.
                        04      LOG2-RO-DATE    PIC 9(07).
                        04      LOG2-RO-SEQ     PIC 9(04).
                03      LOG2-ODR-SEQ            PIC 9(02).
        02      LOG2-ID-KEY REDEFINES LOG2-RO-KEY.
*> 記錄住院醫令相關錯誤─[A]ICA寫檔不成功 [B]檢驗傳輸記錄
                03      LOG2-ID                 PIC X(01).
                03      LOG2-ID-SEQ             PIC 9(02).

                03      LOG2-ID-FILLER          PIC X(10).
*> 異動日、時、分 (正序)
*$XFD USE GROUP, VAR-LENGTH
        02      LOG2-CRE-DATE.
                03      LOG2-CRE-DT             PIC 9(07).
                03      LOG2-CRE-TI.
                        04      LOG2-CRE-HH     PIC 9(02).
                        04      LOG2-CRE-MM     PIC 9(02).
                        04      LOG2-CRE-SS     PIC 9(02).
*> 異動日、時、分 (倒序)
*$XFD USE GROUP, VAR-LENGTH
        02      LOG2-DCRE-DATE.
                03      LOG2-DCRE-DT            PIC 9(07).
                03      LOG2-DCRE-TI.
                        04      LOG2-DCRE-HH    PIC 9(02).
                        04      LOG2-DCRE-MM    PIC 9(02).
                        04      LOG2-DCRE-SS    PIC 9(02).
*> 異動次數
        02      LOG2-UPD-CNT                    PIC 9(04).
*> 異動碼 (C:新增)
        02      LOG2-UPD-MRK                    PIC X(01).
*> 序號
        02      LOG2-FEE-NO                     PIC 9(02).
*>
        02      LOG2-FEE-PRS                    PIC X(09).
        02      LOG2-FEE-KND                    PIC X(03).
        02      LOG2-STD-FID                    PIC X(03).
        02      LOG2-DATA1                      PIC X(210).
        02      LOG2-ALT4                       PIC X(20).
        02      LOG2-ALT5                       PIC X(20).
*>
        02      LOG2-PRS-NM                     PIC X(40).
        02      LOG2-PRS-INS-ID                 PIC X(16).
        02      LOG2-PRC-ITM                    PIC X(01).
        02      LOG2-LOC-ID                     PIC X(01).
        02      LOG2-AQTY-NUM                   PIC 9(05).
        02      LOG2-AQTY-DEN                   PIC 9(03).
*$XFD USE GROUP, VAR-LENGTH
        02      LOG2-DATA                       PIC X(100).
*
*{TAMIS}END
 WORKING-STORAGE             SECTION.
*{Bench}acu-def
*COPY "acugui.def".
*ACUGUI.DEF - useful definitions for graphical systems.
*Last modified: 25-Apr-2002 - TDC.

*Copyright (c) 1992-2003 by Acucorp, Inc.  Users of ACUCOBOL
*may freely include this file in their COBOL source code.

*Mouse handling variables
*Structure and opcodes for W$MOUSE system routine

 78  TEST-MOUSE-PRESENCE                 VALUE 0.
 78  GET-MOUSE-STATUS                    VALUE 1.
 78  GET-MOUSE-SCREEN-STATUS             VALUE 2.
 78  SET-MOUSE-POSITION                  VALUE 3.

 78  SET-MOUSE-SCREEN-POSITION           VALUE 4.
 78  SET-MOUSE-SHAPE                     VALUE 5.
 78  SET-DELAYED-MOUSE-SHAPE             VALUE 6.
 78  GET-MOUSE-SHAPE                     VALUE 7.
 78  CAPTURE-MOUSE                       VALUE 8.
 78  RELEASE-MOUSE                       VALUE 9.
 78  ENABLE-MOUSE                        VALUE 10.
 78  SET-MOUSE-HELP                      VALUE 19.

 01  MOUSE-INFO.
    03  MOUSE-ROW                       PIC 9(4) COMP-1.
        88  MOUSE-OFF-SCREEN            VALUE ZERO.
    03  MOUSE-COL                       PIC 9(4) COMP-1.
    03  LBUTTON-STATUS                  PIC 9.
        88  LBUTTON-DOWN                VALUE 1.
    03  MBUTTON-STATUS                  PIC 9.
        88  MBUTTON-DOWN                VALUE 1.
    03  RBUTTON-STATUS                  PIC 9.
        88  RBUTTON-DOWN                VALUE 1.

 78  ARROW-POINTER                       VALUE 1.
 78  BAR-POINTER                         VALUE 2.
 78  CROSS-POINTER                       VALUE 3.
 78  WAIT-POINTER                        VALUE 4.
 78  HELP-POINTER                        VALUE 5.

*MOUSE-FLAGS settings

 78  AUTO-MOUSE-HANDLING                 VALUE 1.
 78  ALLOW-LEFT-DOWN                     VALUE 2.
 78  ALLOW-LEFT-UP                       VALUE 4.
 78  ALLOW-LEFT-DOUBLE                   VALUE 8.
 78  ALLOW-MIDDLE-DOWN                   VALUE 16.
 78  ALLOW-MIDDLE-UP                     VALUE 32.
 78  ALLOW-MIDDLE-DOUBLE                 VALUE 64.
 78  ALLOW-RIGHT-DOWN                    VALUE 128.
 78  ALLOW-RIGHT-UP                      VALUE 256.
 78  ALLOW-RIGHT-DOUBLE                  VALUE 512.
 78  ALLOW-MOUSE-MOVE                    VALUE 1024.
 78  ALWAYS-ARROW-CURSOR                 VALUE 2048.
 78  ALLOW-ALL-SCREEN-ACTIONS            VALUE 16384.


*Menu handling variables
*W$MENU opcodes

 78  WMENU-NEW                           VALUE 1.
 78  WMENU-DESTROY                       VALUE 2.
 78  WMENU-ADD                           VALUE 3.
 78  WMENU-CHANGE                        VALUE 4.
 78  WMENU-DELETE                        VALUE 5.
 78  WMENU-CHECK                         VALUE 6.
 78  WMENU-UNCHECK                       VALUE 7.
 78  WMENU-ENABLE                        VALUE 8.
 78  WMENU-DISABLE                       VALUE 9.
 78  WMENU-SHOW                          VALUE 10.
 78  WMENU-GET-MENU                      VALUE 11.

 78  WMENU-INPUT                         VALUE 12.
 78  WMENU-BLOCK                         VALUE 13.
 78  WMENU-UNBLOCK                       VALUE 14.
 78  WMENU-GET-BLOCK                     VALUE 15.
 78  WMENU-SET-BLOCK                     VALUE 16.
 78  WMENU-RELEASE                       VALUE 17.
 78  WMENU-GET-CONFIGURATION             VALUE 18.
 78  WMENU-SET-CONFIGURATION             VALUE 19.
 78  WMENU-REFRESH                       VALUE 20.
 78  WMENU-DESTROY-DELAYED               VALUE 21.
 78  WMENU-GET-DELAYED-FLAG              VALUE 22.
 78  WMENU-SET-DELAYED-FLAG              VALUE 23.
 78  WMENU-NEW-POPUP                     VALUE 26.
 78  WMENU-POPUP                         VALUE 27.

*W$MENU flags

 78  W-UNCHECKED                         VALUE 0.
 78  W-CHECKED                           VALUE 1.
 78  W-ENABLED                           VALUE 0.
 78  W-DISABLED                          VALUE 16.
 78  W-SEPARATOR                         VALUE 256.

 01  MENU-CONFIGURATION.
    03  MENU-STYLE                         PIC 9 COMP-X.
        88  MENU-IS-STATIC                 VALUE 0.
        88  MENU-IS-POPUP                  VALUE 1.
    03  MENU-CHECK-MARK                    PIC X.
    03  MENU-SUBMENU-MARK                  PIC X.
    03  MENU-COLOR-ATTRIBUTES.
        05  MENU-NORMAL-COLOR-ATTRIBUTES.
            07  MENU-NORMAL-COLOR          PIC 9(4) COMP-X.
            07  MENU-NORMAL-COLOR-KEY-1    PIC 9(4) COMP-X.
            07  MENU-NORMAL-COLOR-KEY-2    PIC 9(4) COMP-X.
        05  MENU-SELECTED-COLOR-ATTRIBUTES.
            07  MENU-SELECTED-COLOR        PIC 9(4) COMP-X.
            07  MENU-SELECTED-COLOR-KEY-1  PIC 9(4) COMP-X.
            07  MENU-SELECTED-COLOR-KEY-2  PIC 9(4) COMP-X.
        05  MENU-DISABLED-COLOR-ATTRIBUTES.
            07  MENU-DISABLED-COLOR        PIC 9(4) COMP-X.
            07  MENU-DISABLED-COLOR-KEY-1  PIC 9(4) COMP-X.
            07  MENU-DISABLED-COLOR-KEY-2  PIC 9(4) COMP-X.
    03  MENU-MONO-ATTRIBUTES.
        05  MENU-NORMAL-MONO-ATTRIBUTES.
            07  MENU-NORMAL-MONO           PIC 9(4) COMP-X.
            07  MENU-NORMAL-MONO-KEY-1     PIC 9(4) COMP-X.
            07  MENU-NORMAL-MONO-KEY-2     PIC 9(4) COMP-X.
        05  MENU-SELECTED-MONO-ATTRIBUTES.
            07  MENU-SELECTED-MONO         PIC 9(4) COMP-X.
            07  MENU-SELECTED-MONO-KEY-1   PIC 9(4) COMP-X.
            07  MENU-SELECTED-MONO-KEY-2   PIC 9(4) COMP-X.
        05  MENU-DISABLED-MONO-ATTRIBUTES.
            07  MENU-DISABLED-MONO         PIC 9(4) COMP-X.
            07  MENU-DISABLED-MONO-KEY-1   PIC 9(4) COMP-X.
            07  MENU-DISABLED-MONO-KEY-2   PIC 9(4) COMP-X.

*Variables used by menu code created by GENMENU.


 77  MENU-HANDLE                         PIC S9(9) COMP-4.
 77  SUB-HANDLE-1                        PIC S9(9) COMP-4.
 77  SUB-HANDLE-2                        PIC S9(9) COMP-4.
 77  SUB-HANDLE-3                        PIC S9(9) COMP-4.
 77  SUB-HANDLE-4                        PIC S9(9) COMP-4.

*MESSAGE BOX types

 78  MB-OK                               VALUE 1.
 78  MB-YES-NO                           VALUE 2.
 78  MB-OK-CANCEL                        VALUE 3.
 78  MB-YES-NO-CANCEL                    VALUE 4.

*MESSAGE BOX responses (MB-OK is both a type and a response)

 78  MB-YES                              VALUE 1.
 78  MB-NO                               VALUE 2.
 78  MB-CANCEL                           VALUE 3.

*MESSAGE BOX icons

 78  MB-DEFAULT-ICON                     VALUE 1.
 78  MB-WARNING-ICON                     VALUE 2.
 78  MB-ERROR-ICON                       VALUE 3.

*W$BITMAP opcodes

 78  WBITMAP-DISPLAY                     VALUE 1.
 78  WBITMAP-DESTROY                     VALUE 2.
 78  WBITMAP-LOAD                        VALUE 3.
 78  WBITMAP-LOAD-IMAGELIST              VALUE 5.
 78  WBITMAP-DESTROY-IMAGELIST           VALUE 6.

*W$BITMAP option flags

 78  WBITMAP-NO-FILL                     VALUE 1.
 78  WBITMAP-NO-DOWNLOAD                 VALUE 2.

*W$BITMAP error values

 78  WBERR-UNSUPPORTED                   VALUE 0.
 78  WBERR-FILE-ERROR                    VALUE -1.
 78  WBERR-NO-MEMORY                     VALUE -2.
 78  WBERR-NOT-BITMAP                    VALUE -3.
 78  WBERR-FORMAT-UNSUPPORTED            VALUE -4.
 78  WBERR-MISSING-DLL                   VALUE -5.

*W$TEXTSIZE library routine

 01  TEXTSIZE-DATA.
    03  TEXTSIZE-FONT                   HANDLE OF FONT,
                                        VALUE NULL.
    03  TEXTSIZE-WINDOW                 HANDLE OF WINDOW
                                        VALUE NULL.
    03  TEXTSIZE-SIZE-X                 PIC 9(7)V99 COMP-4.
    03  TEXTSIZE-CELLS-X                PIC 9(7)V99 COMP-4.

    03  TEXTSIZE-BASE-X                 PIC 9(9) COMP-4.
    03  TEXTSIZE-SIZE-Y                 PIC 99V99 COMP-4.
    03  TEXTSIZE-CELLS-Y                PIC 99V99 COMP-4.
    03  TEXTSIZE-BASE-Y                 PIC 9(4) COMP-4.
    03  TEXTSIZE-FLAGS                  PIC X COMP-X, VALUE ZERO.
        88  TEXTSIZE-STRIP-SPACES       VALUE 1, FALSE ZERO.

*EVENT-ACTION values

 78  EVENT-ACTION-NORMAL                 VALUE ZERO.
 78  EVENT-ACTION-TERMINATE              VALUE 1.
 78  EVENT-ACTION-CONTINUE               VALUE 2.
 78  EVENT-ACTION-IGNORE                 VALUE 3.
 78  EVENT-ACTION-FAIL                   VALUE 4.
 78  EVENT-ACTION-COMPLETE               VALUE 5.
 78  EVENT-ACTION-FAIL-TERMINATE         VALUE 7.


*Standard exception values from the windowing system

 78  W-TIMEOUT                           VALUE 99.
 78  W-CONVERSION-ERROR                  VALUE 98.
 78  W-NO-FIELDS                         VALUE 97.
 78  W-EVENT                             VALUE 96.
 78  W-MESSAGE                           VALUE 95.

*Command events

 78  CMD-CLOSE                           VALUE 1.
 78  CMD-GOTO                            VALUE 3.
 78  CMD-CLICKED                         VALUE 4.
 78  CMD-DBLCLICK                        VALUE 5.
 78  CMD-ACTIVATE                        VALUE 6.
 78  CMD-TABCHANGED                      VALUE 7.
 78  CMD-HELP                            VALUE 8.

*Notification events

 78  NTF-SELCHANGE                       VALUE 4099.
 78  NTF-CHANGED                         VALUE 4100.
*The next 7 apply to paged list-boxes only
 78  NTF-PL-NEXT                         VALUE 4101.
 78  NTF-PL-PREV                         VALUE 4102.
 78  NTF-PL-NEXTPAGE                     VALUE 4103.
 78  NTF-PL-PREVPAGE                     VALUE 4104.
 78  NTF-PL-FIRST                        VALUE 4105.
 78  NTF-PL-LAST                         VALUE 4106.
 78  NTF-PL-SEARCH                       VALUE 4107.
 78  NTF-RESIZED                         VALUE 4114.

*Message-style events

 78  MSG-SB-NEXT                         VALUE 16385.
 78  MSG-SB-PREV                         VALUE 16386.
 78  MSG-SB-NEXTPAGE                     VALUE 16387.
 78  MSG-SB-PREVPAGE                     VALUE 16388.
 78  MSG-SB-THUMB                        VALUE 16389.

 78  MSG-SB-THUMBTRACK                   VALUE 16390.
 78  MSG-VALIDATE                        VALUE 16391.
 78  MSG-BEGIN-ENTRY                     VALUE 16392.
 78  MSG-FINISH-ENTRY                    VALUE 16393.
 78  MSG-CANCEL-ENTRY                    VALUE 16394.
 78  MSG-GOTO-CELL                       VALUE 16395.
 78  MSG-GOTO-CELL-MOUSE                 VALUE 16396.
 78  MSG-MENU-INPUT                      VALUE 16397.
 78  MSG-INIT-MENU                       VALUE 16398.
 78  MSG-END-MENU                        VALUE 16399.
 78  MSG-BITMAP-CLICKED                  VALUE 16400.
 78  MSG-BITMAP-DBLCLICK                 VALUE 16401.
 78  MSG-HEADING-CLICKED                 VALUE 16402.
 78  MSG-HEADING-DBLCLICK                VALUE 16403.
 78  MSG-GOTO-CELL-DRAG                  VALUE 16404.
 78  MSG-HEADING-DRAGGED                 VALUE 16405.
 78  MSG-BEGIN-DRAG                      VALUE 16406.
 78  MSG-END-DRAG                        VALUE 16407.
 78  MSG-BEGIN-HEADING-DRAG              VALUE 16408.
 78  MSG-END-HEADING-DRAG                VALUE 16409.
 78  MSG-COL-WIDTH-CHANGED               VALUE 16410.
 78  MSG-TV-SELCHANGING                  VALUE 16411.
 78  MSG-TV-SELCHANGE                    VALUE 16412.
 78  MSG-TV-EXPANDING                    VALUE 16413.
 78  MSG-TV-EXPANDED                     VALUE 16414.
 78  MSG-CLOSE                           VALUE 16415.
 78  MSG-SPIN-UP                         VALUE 16416.
 78  MSG-SPIN-DOWN                       VALUE 16417.
 78  MSG-PAGED-NEXT                      VALUE 16419.
 78  MSG-PAGED-PREV                      VALUE 16420.
 78  MSG-PAGED-NEXTPAGE                  VALUE 16421.
 78  MSG-PAGED-PREVPAGE                  VALUE 16422.
 78  MSG-PAGED-FIRST                     VALUE 16423.
 78  MSG-PAGED-LAST                      VALUE 16424.
 78  MSG-GRID-RBUTTON-DOWN               VALUE 16426.
 78  MSG-GRID-RBUTTON-UP                 VALUE 16427.
 78  MSG-TV-DBLCLICK                     VALUE 16428.
 78  MSG-WB-BEFORE-NAVIGATE              VALUE 16429.
 78  MSG-WB-NAVIGATE-COMPLETE            VALUE 16430.
 78  MSG-WB-DOWNLOAD-BEGIN               VALUE 16431.
 78  MSG-WB-DOWNLOAD-COMPLETE            VALUE 16432.
 78  MSG-WB-PROGRESS-CHANGE              VALUE 16433.
 78  MSG-WB-STATUS-TEXT-CHANGE           VALUE 16434.
 78  MSG-WB-TITLE-CHANGE                 VALUE 16435.
 78  MSG-AX-EVENT                        VALUE 16436.

*Entry Field ACTION values

 78  ACTION-CUT                          VALUE 1.
 78  ACTION-COPY                         VALUE 2.
 78  ACTION-PASTE                        VALUE 3.
 78  ACTION-DELETE                       VALUE 4.
 78  ACTION-UNDO                         VALUE 5.

*Grid ACTION values

 78  ACTION-FIRST-PAGE                   VALUE 10.

 78  ACTION-LAST-PAGE                    VALUE 11.
 78  ACTION-CURRENT-PAGE                 VALUE 12.
 78  ACTION-HIDE-DRAG                    VALUE 13.

*Window ACTION values

 78  ACTION-MINIMIZE                     VALUE 20.
 78  ACTION-MAXIMIZE                     VALUE 21.
 78  ACTION-RESTORE                      VALUE 22.

*Paged grid FILE-POS values

 78  PAGED-AT-START                      VALUE 2147418113.
 78  PAGED-AT-END                        VALUE 2147418114.
 78  PAGED-EMPTY                         VALUE 2147418115.

*Grid search options

 01  GRID-SEARCH-OPTIONS                 VALUE ALL ZEROS.
    03  GRID-SEARCH-DIRECTION           PIC 9.
        88  GRID-SEARCH-FORWARDS        VALUE ZERO, FALSE 1.

    03  GRID-SEARCH-WRAP-FLAG           PIC 9.
        88  GRID-SEARCH-WRAP            VALUE ZERO, FALSE 1.

    03  GRID-SEARCH-CASE-FLAG           PIC 9.
        88  GRID-SEARCH-IGNORE-CASE     VALUE ZERO, FALSE 1.

    03  GRID-SEARCH-MATCH-FLAG          PIC 9.
        88  GRID-SEARCH-MATCH-ANY       VALUE ZERO.
        88  GRID-SEARCH-MATCH-LEADING   VALUE 1.
        88  GRID-SEARCH-MATCH-ALL       VALUE 2.

    03  GRID-SEARCH-LOCATION-FLAG       PIC 9.
        88  GRID-SEARCH-VISIBLE         VALUE ZERO.
        88  GRID-SEARCH-HIDDEN          VALUE 1.
        88  GRID-SEARCH-ALL-DATA        VALUE 2.

    03  GRID-SEARCH-SKIP-FLAG           PIC 9.
        88  GRID-SEARCH-SKIP-CURRENT    VALUE ZERO, FALSE 1.

    03  GRID-SEARCH-CURSOR-FLAG         PIC 9.
        88  GRID-SEARCH-MOVES-CURSOR    VALUE ZERO, FALSE 1.

    03  GRID-SEARCH-COLUMN              PIC 9(5).
        88  GRID-SEARCH-ALL-COLUMNS     VALUE ZERO.

*Grid search status flags

 78  GRDSRCH-NOT-FOUND                   VALUE 0.
 78  GRDSRCH-FOUND                       VALUE 1.
 78  GRDSRCH-WRAPPED                     VALUE 2.

*Grid FINISH-REASON values

 78  GRFR-BLANK-PAST-END                 VALUE -1.
 78  GRFR-TERMINATING                    VALUE -2.

 78  GRFR-CELL-CLICKED                   VALUE -3.
 78  GRFR-NAVIGATION-KEY                 VALUE -4.
 78  GRFR-ESCAPE-KEY                     VALUE -5.
 78  GRFR-ENTER-KEY                      VALUE -6.
 78  GRFR-TAB-KEY                        VALUE -7.

*Flags for win$playsound

 78  SND-SYNC                            VALUE 0.
 78  SND-ASYNC                           VALUE 1.
 78  SND-LOOP                            VALUE 8.
 78  SND-NOSTOP                          VALUE 16.

*Tree-View control placement flags

 78  TVPLACE-FIRST                       VALUE 4294901761.
 78  TVPLACE-LAST                        VALUE 0.
 78  TVPLACE-SORT                        VALUE 4294901763.

*Tree-View NEXT-ITEM values

 78  TVNI-CHILD                          VALUE 1.
 78  TVNI-FIRST-VISIBLE                  VALUE 2.
 78  TVNI-NEXT                           VALUE 3.
 78  TVNI-NEXT-VISIBLE                   VALUE 4.
 78  TVNI-PARENT                         VALUE 5.
 78  TVNI-PREVIOUS                       VALUE 6.
 78  TVNI-PREVIOUS-VISIBLE               VALUE 7.
 78  TVNI-ROOT                           VALUE 8.

*Tree-View miscellaneous flags

 78  TVFLAG-COLLAPSE                     VALUE 1.
 78  TVFLAG-EXPAND                       VALUE 2.
 78  TVFLAG-PROGRAM                      VALUE ZERO.
 78  TVFLAG-MOUSE                        VALUE 1.
 78  TVFLAG-KEYBOARD                     VALUE 2.
 78  TVFLAG-NORMAL                       VALUE 1.
 78  TVFLAG-BOLD                         VALUE 2.

*Paged list sort-order values

 78  PL-SORT-DEFAULT                     VALUE 0.
 78  PL-SORT-NONE                        VALUE 1.
 78  PL-SORT-NATIVE                      VALUE 2.
 78  PL-SORT-NATIVE-IGNORE-CASE          VALUE 3.

*Bitmap control flags
 78  BM-CORNER-COLOR                     VALUE x#1000000.

* Predefined handle values for MS Windows registry

* Windows 3.1:
 78  HKEY_CLASSES_ROOT_31                VALUE 1.

* 32-bit Windows:
 78  HKEY_CLASSES_ROOT                   VALUE 2147483648.

 78  HKEY_CURRENT_USER                   VALUE 2147483649.
 78  HKEY_LOCAL_MACHINE                  VALUE 2147483650.
 78  HKEY_USERS                          VALUE 2147483651.
 78  HKEY_PERFORMANCE_DATA               VALUE 2147483652.
 78  HKEY_CURRENT_CONFIG                 VALUE 2147483653.
 78  HKEY_DYN_DATA                       VALUE 2147483654.

*32-bit Windows Registry Value Types
 78  REG_NONE                       VALUE ZERO.
 78  REG_SZ                         VALUE 1.
 78  REG_EXPAND_SZ                  VALUE 2.
 78  REG_BINARY                     VALUE 3.
 78  REG_DWORD                      VALUE 4.
 78  REG_DWORD_LITTLE_ENDIAN        VALUE 4.
 78  REG_DWORD_BIG_ENDIAN           VALUE 5.
 78  REG_LINK                       VALUE 6.
 78  REG_MULTI_SZ                   VALUE 7.
 78  REG_RESOURCE_LIST              VALUE 8.
 78  REG_FULL_RESOURCE_DESCRIPTOR   VALUE 9.
 78  REG_RESOURCE_REQUIREMENTS_LIST VALUE 10.

 01  WIN32-REGISTRY-VALUE-TYPE          USAGE IS UNSIGNED-LONG.
    88  TYPE-IS-REG_NONE                       VALUE ZERO.
    88  TYPE-IS-REG_SZ                         VALUE 1.
    88  TYPE-IS-REG_EXPAND_SZ                  VALUE 2.
    88  TYPE-IS-REG_BINARY                     VALUE 3.
    88  TYPE-IS-REG_DWORD                      VALUE 4.
    88  TYPE-IS-REG_DWORD_LITTLE_ENDIAN        VALUE 4.
    88  TYPE-IS-REG_DWORD_BIG_ENDIAN           VALUE 5.
    88  TYPE-IS-REG_LINK                       VALUE 6.
    88  TYPE-IS-REG_MULTI_SZ                   VALUE 7.
    88  TYPE-IS-REG_RESOURCE_LIST              VALUE 8.
    88  TYPE-IS-REG_FULL_RESOURCE_DESCRIPTOR   VALUE 9.
    88  TYPE-IS-REG_RESOURCE_REQUIREMENTS_LIST VALUE 10.

* 32-bit Windows Registry Key Options:
 78  REG_OPTION_NON_VOLATILE               VALUE 0.
 78  REG_OPTION_VOLATILE                   VALUE 1.

* 32-bit Windows Registry Access Rights:
 78  KEY_QUERY_VALUE         VALUE 1.
 78  KEY_SET_VALUE           VALUE 2.
 78  KEY_CREATE_SUB_KEY      VALUE 4.
 78  KEY_ENUMERATE_SUB_KEYS  VALUE 8.
 78  KEY_NOTIFY              VALUE 16.
 78  KEY_CREATE_LINK         VALUE 32.
 78  KEY_WRITE               VALUE 131078.
 78  KEY_READ                VALUE 131097.
 78  KEY_EXECUTE             VALUE 131097.
 78  KEY_ALL_ACCESS          VALUE 983103.

* 32-bit Windows Registry Disposition Values:
 78  REG_CREATED_NEW_KEY               VALUE 1.
 78  REG_OPENED_EXISTING_KEY           VALUE 2.

*end of acugui.def
*COPY "acucobol.def".

*ACUCOBOL.DEF - Some useful ACUCOBOL definitions.
*Last modified: 07-May-2001 TDC.

*Copyright (c) 1996-2003 by Acucorp, Inc.  Users of ACUCOBOL
*may freely include this file in their COBOL source code.

 01  TERMINAL-ABILITIES.
    03  TERMINAL-NAME                   PIC X(10).
    03  FILLER                          PIC X.
        88  HAS-REVERSE                 VALUE "Y".
    03  FILLER                          PIC X.
        88  HAS-BLINK                   VALUE "Y".
    03  FILLER                          PIC X.
        88  HAS-UNDERLINE               VALUE "Y".
    03  FILLER                          PIC X.
        88  HAS-DUAL-INTENSITY          VALUE "Y".
    03  FILLER                          PIC X.
        88  HAS-132-COLUMN-MODE         VALUE "Y".
    03  FILLER                          PIC X.
        88  HAS-COLOR                   VALUE "Y".
    03  FILLER                          PIC X.
        88  HAS-LINE-DRAWING            VALUE "Y".
    03  NUMBER-OF-SCREEN-LINES          PIC 9(3).
    03  NUMBER-OF-SCREEN-COLUMNS        PIC 9(3).
    03  FILLER                          PIC X.
        88  HAS-LOCAL-PRINTER           VALUE "Y".
    03  FILLER                          PIC X.
        88  HAS-VISIBLE-ATTRIBUTES      VALUE "Y".
    03  FILLER                          PIC X.
        88  HAS-GRAPHICAL-INTERFACE     VALUE "Y".
    03  USABLE-SCREEN-HEIGHT            PIC X(2) COMP-X.
    03  USABLE-SCREEN-WIDTH             PIC X(2) COMP-X.
    03  PHYSICAL-SCREEN-HEIGHT          PIC X(2) COMP-X.
    03  PHYSICAL-SCREEN-WIDTH           PIC X(2) COMP-X.
    03  FILLER                          PIC X.
        88  IS-REMOTE                   VALUE "Y".
    03  CLIENT-MACHINE-NAME             PIC X(64).


 01  SYSTEM-INFORMATION.
    03  OPERATING-SYSTEM                PIC X(10).
        88  OS-IS-MSDOS                 VALUE "MS-DOS".
        88  OS-IS-OS2                   VALUE "OS/2".
        88  OS-IS-VMS                   VALUES "VMS",
                                        "VAX/VMS".
*       88  OS-IS-UNIX                  VALUES "Unix",
*                                              "Unix-V", "Unix-4",
                                               "UNOS".
        88  OS-IS-AOS                   VALUE "AOS/VS".
        88  OS-IS-WINDOWS               VALUE "WINDOWS".
        88  OS-IS-WIN-NT                VALUE "WIN/NT".
        88  OS-IS-WIN-FAMILY            VALUES "WINDOWS",
                                               "WIN/NT".
        88  OS-IS-AMOS                  VALUE "AMOS".
        88  OS-IS-MPE                   VALUE "MPE/iX".
        88  OS-IS-MPEIX                 VALUE "MPE/iX".
    03  USER-ID                         PIC X(12).

    03  STATION-ID                      PIC X(12).
    03  FILLER                          PIC X.
        88  HAS-INDEXED-READ-PREVIOUS   VALUE "Y".
    03  FILLER                          PIC X.
        88  HAS-RELATIVE-READ-PREVIOUS  VALUE "Y".
    03  FILLER                          PIC X.
        88  CAN-TEST-INPUT-STATUS       VALUE "Y".
    03  FILLER                          PIC X.
        88  IS-MULTI-TASKING            VALUE "Y".
    03  RUNTIME-VERSION.
        88  VERSION-PRIOR-TO-2-2        VALUE SPACES.
        05  RUNTIME-MAJOR-VERSION       PIC 99.
        05  RUNTIME-MINOR-VERSION       PIC 99.
        05  RUNTIME-RELEASE             PIC 99.
    03  FILLER                          PIC X.
        88  IS-PLUGIN                   VALUE "Y".
    03  SERIAL-NUMBER                   PIC X(20).
    03  FILLER                          PIC X.
        88  HAS-LARGE-FILE-SUPPORT      VALUE "Y".

 01  BROWSERINFO-DATA.
    03  USER-AGENT-STRING               PIC X(50).
    03  BROWSER-MAJOR-VERSION           PIC X COMP-X.
    03  BROWSER-MINOR-VERSION           PIC X COMP-X.

 78  BLACK                               VALUE 1.
 78  BLUE                                VALUE 2.
 78  GREEN                               VALUE 3.
 78  CYAN                                VALUE 4.
 78  RED                                 VALUE 5.
 78  MAGENTA                             VALUE 6.
 78  BROWN                               VALUE 7.
 78  WHITE                               VALUE 8.
 78  DARK-GRAY                           VALUE 9.
 78  BRIGHT-BLUE                         VALUE 10.
 78  BRIGHT-GREEN                        VALUE 11.
 78  BRIGHT-CYAN                         VALUE 12.
 78  BRIGHT-RED                          VALUE 13.
 78  BRIGHT-MAGENTA                      VALUE 14.
 78  YELLOW                              VALUE 15.
 78  BRIGHT-WHITE                        VALUE 16.
 78  BCKGRND-BLACK                       VALUE 32.
 78  BCKGRND-BLUE                        VALUE 64.
 78  BCKGRND-GREEN                       VALUE 96.
 78  BCKGRND-CYAN                        VALUE 128.
 78  BCKGRND-RED                         VALUE 160.
 78  BCKGRND-MAGENTA                     VALUE 192.
 78  BCKGRND-BROWN                       VALUE 224.
 78  BCKGRND-WHITE                       VALUE 256.
 78  BCKGRND-DARK-GRAY                   VALUE 288.
 78  BCKGRND-BRIGHT-BLUE                 VALUE 320.
 78  BCKGRND-BRIGHT-GREEN                VALUE 352.
 78  BCKGRND-BRIGHT-CYAN                 VALUE 384.
 78  BCKGRND-BRIGHT-RED                  VALUE 416.
 78  BCKGRND-BRIGHT-MAGENTA              VALUE 448.
 78  BCKGRND-YELLOW                      VALUE 480.
 78  BCKGRND-BRIGHT-WHITE                VALUE 512.

 78  COLOR-REVERSE                       VALUE 1024.
 78  FRGRND-LOW                          VALUE 2048.
 78  FRGRND-HIGH                         VALUE 4096.
 78  COLOR-UNDERLINE                     VALUE 8192.
 78  COLOR-BLINK                         VALUE 16384.
 78  COLOR-PROTECTED                     VALUE 32768.
 78  BCKGRND-LOW                         VALUE 65536.
 78  BCKGRND-HIGH                        VALUE 131072.
 78  WINDOW-BRIGHT-WHITE                 VALUE 131328.

* Options for C$RERR STATUS-TYPE

 78  GET-FILE-STATUS                     VALUE 1.
 78  GET-TRANSACTION-STATUS              VALUE 2.

* Opcodes for C$FILESYS

 78  START-FILESYSTEM-LIST               VALUE 0.
 78  CONTINUE-FILESYSTEM-LIST            VALUE 1.
 78  CHECK-FOR-FILESYSTEM                VALUE 2.
 78  NUMBER-OF-FILESYSTEMS               VALUE 3.

 77  FILESYSTEM                          PIC X(5).

*Flags for "C$SYSTEM"

 78  CSYS-ASYNC                          VALUE 1.
 78  CSYS-NO-IO                          VALUE 2.
 78  CSYS-MAXIMIZED                      VALUE 4.
 78  CSYS-MINIMIZED                      VALUE 8.
 78  CSYS-COMPATIBILITY                  VALUE 16.
 78  CSYS-HIDDEN                         VALUE 32.
 78  CSYS-SHELL                          VALUE 64.
 78  CSYS-DESKTOP                        VALUE 128.

*Return codes for "C$PING"

 78  CPING_OK                            VALUE 0.
 78  CPING_NO_CLIENT                     VALUE 1.
 78  CPING_PARAM_ERROR                   VALUE 2.
 78  CPING_CONN_REFUSED                  VALUE 3.
 78  CPING_VERSION_ERROR                 VALUE 4.
 78  CPING_SOCKET_ERROR                  VALUE 5.

*Opcodes for C$LIST-DIRECTORY

 78  LISTDIR-OPEN                        VALUE 1.
 78  LISTDIR-NEXT                        VALUE 2.
 78  LISTDIR-CLOSE                       VALUE 3.

*The file information group passed to C$LIST-DIRECTORY
 01  LISTDIR-FILE-INFORMATION.
    03  LISTDIR-FILE-TYPE               PIC X.
    03  LISTDIR-FILE-CREATION-TIME.
        05  LDFC-YEAR                   PIC XX COMP-X.
        05  LDFC-MONTH                  PIC X COMP-X.
        05  LDFC-DAY                    PIC X COMP-X.

        05  LDFC-HOUR                   PIC X COMP-X.
        05  LDFC-MINUTE                 PIC X COMP-X.
        05  LDFC-SECOND                 PIC X COMP-X.
        05  LDFC-HUNDRETHS              PIC X COMP-X.
    03  LISTDIR-FILE-LAST-ACCESS-TIME.
        05  LDFLA-YEAR                  PIC XX COMP-X.
        05  LDFLA-MONTH                 PIC X COMP-X.
        05  LDFLA-DAY                   PIC X COMP-X.
        05  LDFLA-HOUR                  PIC X COMP-X.
        05  LDFLA-MINUTE                PIC X COMP-X.
        05  LDFLA-SECOND                PIC X COMP-X.
        05  LDFLA-HUNDRETHS             PIC X COMP-X.
    03  LISTDIR-FILE-LAST-MODIFICATION-TIME.
        05  LDFLM-YEAR                  PIC XX COMP-X.
        05  LDFLM-MONTH                 PIC X COMP-X.
        05  LDFLM-DAY                   PIC X COMP-X.
        05  LDFLM-HOUR                  PIC X COMP-X.
        05  LDFLM-MINUTE                PIC X COMP-X.
        05  LDFLM-SECOND                PIC X COMP-X.
        05  LDFLM-HUNDRETHS             PIC X COMP-X.
    03  LISTDIR-FILE-SIZE               PIC X(8) COMP-X.

*Opcodes for C$XML

 78  CXML-PARSE-FILE                     VALUE 1.
 78  CXML-RELEASE-PARSER                 VALUE 2.
 78  CXML-GET-FIRST-CHILD                VALUE 3.
 78  CXML-GET-NEXT-SIBLING               VALUE 4.
 78  CXML-GET-PARENT                     VALUE 5.
 78  CXML-GET-DATA                       VALUE 6.
 78  CXML-GET-ATTRIBUTE-COUNT            VALUE 7.
 78  CXML-GET-ATTRIBUTE                  VALUE 8.
 78  CXML-GET-LAST-ERROR                 VALUE 9.

*Error codes for C$XML

*Unable to create parser due to low memory
 78  CXML_NO_MEMORY                      VALUE 1.
*Unable to create parser - expat error
 78  CXML_EXPAT_ERROR                    VALUE 2.
*Unable to open named file
 78  CXML_FILE_OPEN_ERROR                VALUE 3.
*Invalid XML file or other parsing error
 78  CXML_PARSE_ERROR                    VALUE 4.
*The passed handle is not a valid parser handle
 78  CXML_INVALID_PARSER_HANDLE          VALUE 5.
*The passed handle is not a valid element handle
 78  CXML_INVALID_ELEMENT_HANDLE         VALUE 6.
*Invalid attribute numb
 78  CXML_INVALID_ATTRIBUTE_NUMBER       VALUE 7.
*The URL given could not be accessed
 78  CXML_URL_ERROR                      VALUE 8.

*Opcodes for C$CONFIG (not many yet, but open for expansion)

 78  CCONFIG-RESET                       VALUE 1.


*end of acucobol.def
*COPY "crtvars.def".
*CRTVARS.DEF - definitions of commonly needed screen handling variables
*Date written: 27-Aug-96 - TDC.

*Copyright (c) 1996-2003 by Acucorp, Inc.  Users of ACUCOBOL
*may freely include this file in their COBOL source code.

 01  EVENT-STATUS
    IS SPECIAL-NAMES EVENT STATUS.
    03  EVENT-TYPE                      PIC X(4) COMP-X.
    03  EVENT-WINDOW-HANDLE             HANDLE OF WINDOW.
    03  EVENT-CONTROL-HANDLE            HANDLE.
    03  EVENT-CONTROL-ID                PIC XX COMP-X.
    03  EVENT-DATA-1                    SIGNED-SHORT.
    03  EVENT-DATA-2                    SIGNED-LONG.
    03  EVENT-ACTION                    PIC X COMP-X.

 01  SCREEN-CONTROL
    IS SPECIAL-NAMES SCREEN CONTROL.
    03  ACCEPT-CONTROL                  PIC 9.
    03  CONTROL-VALUE                   PIC 999.
    03  CONTROL-HANDLE                  HANDLE.
    03  CONTROL-ID                      PIC XX COMP-X.

 End of CRTVARS.DEF
*COPY "fonts.def".
*FONTS.DEF - Definitions for the W$FONT routine
*Last modified: 03-Jun-1996 - TDC.

*Copyright (c) 1996-2003 by Acucorp, Inc.  Users of ACUCOBOL
*may freely include this file in their COBOL source code.

*Opcodes

 78  WFONT-SUPPORTED                     VALUE 1.
 78  WFONT-CHOOSE-FONT                   VALUE 2.
 78  WFONT-GET-FONT                      VALUE 101.
 78  WFONT-GET-CLOSEST-FONT              VALUE 102.
 78  WFONT-DESCRIBE-FONT                 VALUE 106.

*W$FONT return codes

 78  WFONT-FONT-SUPPORT                  VALUE 1.
 78  WFONT-FULL-SUPPORT                  VALUE 2.

 78  WFONTERR-UNSUPPORTED                VALUE 0.
 78  WFONTERR-CANCELLED                  VALUE -1.
 78  WFONTERR-FONT-NOT-FOUND             VALUE -2.
 78  WFONTERR-INVALID-HANDLE             VALUE -3.

*WFONT-CHOOSE-FLAGS values

 78  WFCHOOSE-FIXED-ONLY                 VALUE 1.
 78  WFCHOOSE-INITIALIZE                 VALUE 2.
 78  WFCHOOSE-EFFECTS-OK                 VALUE 4.


 01  WFONT-DATA.
    03  WFONT-FACE-DATA.
        05  WFONT-DEVICE                HANDLE, VALUE NULL.
            88  WFDEVICE-CONSOLE        VALUE NULL.
            88  WFDEVICE-WIN-PRINTER    VALUE 1.
        05  WFONT-NAME                  PIC X(33).
        05  WFONT-CHAR-SET              PIC X COMP-X.
            88  WFCHARSET-DONT-CARE       VALUE 0.
            88  WFCHARSET-DEFAULT         VALUE 1.
            88  WFCHARSET-WIN-OEM         VALUE 2.
            88  WFCHARSET-WIN-SYMBOL      VALUE 3.
            88  WFCHARSET-WIN-SHIFTJIS    VALUE 4.
            88  WFCHARSET-WIN-HANGUL      VALUE 5.
            88  WFCHARSET-WIN-GB2312      VALUE 6.
            88  WFCHARSET-WIN-CHINESEBIG5 VALUE 7.
            88  WFCHARSET-WIN-JOHAB       VALUE 8.
            88  WFCHARSET-WIN-HEBREW      VALUE 9.
            88  WFCHARSET-WIN-ARABIC      VALUE 10.
            88  WFCHARSET-WIN-GREEK       VALUE 11.
            88  WFCHARSET-WIN-TURKISH     VALUE 12.
            88  WFCHARSET-WIN-VIETNAMESE  VALUE 13.
            88  WFCHARSET-WIN-THAI        VALUE 14.
            88  WFCHARSET-WIN-EASTEUROPE  VALUE 15.
            88  WFCHARSET-WIN-RUSSIAN     VALUE 16.
            88  WFCHARSET-WIN-MAC         VALUE 17.
            88  WFCHARSET-WIN-BALTIC      VALUE 18.
        05  WFONT-SIZE                  PIC X COMP-X.
        05  WFONT-BOLD-STATE            PIC X COMP-X.
            88  WFONT-BOLD              VALUE 1, FALSE ZERO.
        05  WFONT-ITALIC-STATE          PIC X COMP-X.
            88  WFONT-ITALIC            VALUE 1, FALSE ZERO.
        05  WFONT-UNDERLINE-STATE       PIC X COMP-X.
            88  WFONT-UNDERLINE         VALUE 1, FALSE ZERO.
        05  WFONT-STRIKEOUT-STATE       PIC X COMP-X.
            88  WFONT-STRIKEOUT         VALUE 1, FALSE ZERO.
        05  WFONT-PITCH-STATE           PIC X COMP-X.
            88  WFONT-FIXED-PITCH       VALUE 1, FALSE ZERO.
        05  WFONT-FAMILY                PIC X COMP-X.
            88  WFFAMILY-DONT-CARE      VALUE 0.
            88  WFFAMILY-MODERN         VALUE 1.
            88  WFFAMILY-ROMAN          VALUE 2.
            88  WFFAMILY-SWISS          VALUE 3.
            88  WFFAMILY-SCRIPT         VALUE 4.
            88  WFFAMILY-DECORATIVE     VALUE 5.
    03  WFONT-CHOOSE-DATA.
        05  WFONT-CHOOSE-FLAGS          PIC X COMP-X.
        05  WFONT-CHOOSE-MIN-SIZE       PIC X COMP-X.
        05  WFONT-CHOOSE-MAX-SIZE       PIC X COMP-X.
        05  WFONT-CHOOSE-RED            PIC X COMP-X.
        05  WFONT-CHOOSE-GREEN          PIC X COMP-X.
        05  WFONT-CHOOSE-BLUE           PIC X COMP-X.
        05  WFONT-CHOOSE-COLOR-NUM      PIC X COMP-X.

*end of fonts.def
*COPY "showmsg.def".
*01 Extend-Stat.
*   03 Primary-Error              PIC X(2).

*   03 Secondary-Error            PIC X(10).
*01 Text-Message                   PIC X(40).

*01 Acu-Show-Msg.
*  05 Acu-Call-Fail-Code     PIC X(2).
   05 Acu-Msg-Id             PIC 9(3).
*  05 Acu-Err-File           PIC X(30).

*for message display
*78 Acu-Length VALUE 80.
*78 Acu-Full-Len VALUE 250.
 01 Acu-Msg-BOX.
*Mb-Default-Icon, Mb-Warning-Icon, Mb-Error-Icon, 4:QUESTION
*  05 Acu-Icon-Type PIC 9 VALUE 1.
*Mb-Yes, Mb-No, Mb-Cancel
*  05 Acu-Default-Button PIC 9 VALUE 1.
*Mb-Ok, Mb-Yes-No, Mb-Ok-Cancel, Mb-Yes-No-Cancel
*  05 Acu-Button-Type PIC 9 VALUE 1.
*Mb-Yes, Mb-No, Mb-Cancel
*  05 Acu-Return-Value PIC 9 VALUE 1.
*  05 Acu-Msg-1 PIC X(Acu-Length).
*  05 Acu-Msg-2 PIC X(Acu-Length).
*  05 Acu-Msg-3 PIC X(Acu-Length).
*  05 Acu-Msg-Text PIC X(Acu-Full-Len).

*  05 Acu-Text-Ptr             PIC S9(4) COMP-1.
*  05 Acu-Size                 PIC S9(4) COMP-1.


 77 Acu-Idx1                    PIC 9(3).
 77 Acu-Idx2                    PIC 9(3).
 77 Acu-Idx3                    PIC 9(3).
*{Bench}end
 01  W-ODRW-AC-TABLE.

    02  W-ODRW-AC-SW                    PIC X(1).

    02  W-ODRW-AC-YN                    PIC X(1).

 01  W-HR-ODRW-WK-NAME                   PIC X(8).
*{Bench}copy-working
*COPY "HRRCB1IF.wrk".
*HRRCB1IF.wrk
*HRRCB1IF.wrk is generated from C:\HMIS1.DIR\VN\HR\nicol\if\HRG.DIR\HRRCB1IF.Psf
*This is a generated file. DO NOT modify this file directly.

*77 Key-Status IS SPECIAL-NAMES CRT STATUS PIC 9(4) VALUE 0.
*   88 Exit-Pushed VALUE 27.
*   88 Message-Received VALUE 95.
*   88 Event-Occurred VALUE 96.
*   88 Screen-No-Input-Field VALUE 97.
*   88 Screen-Time-Out VALUE 99.
*property-defined variable

*user-defined variable
*77 S-RCB1-Handle
           USAGE IS HANDLE OF WINDOW.

*77 S-HT-DATA-Handle
           USAGE IS HANDLE OF WINDOW.
*77 S-RCB1-Mn-1-Handle
           USAGE IS HANDLE OF MENU.
 77 細明體12
           USAGE IS HANDLE OF FONT.
 77 細明體11
           USAGE IS HANDLE OF FONT.
*77 Fixed-Font
           USAGE IS HANDLE OF FONT FIXED-FONT.
 01 W-GD-REC.
    05 W-INQ-SEQ        PIC  Z(3).
    05 W-INQ-PRS-NAME   PIC  X(40).
    05 W-INQ-RX-UQTY    PIC  X(9).
    05 W-INQ-RX-WAY     PIC  X(10).
    05 W-INQ-RX-DAYS    PIC  Z(2).
    05 W-INQ-RX-QTY     PIC  X(9).
    05 W-INQ-INS-DATE   PIC  Z(12).
    05 W-INQ-TYPE       PIC  X(4).
    05 W-INQ-MARK       PIC  X(01).
    05 W-INQ-ICB-OP-B   PIC  X(25).
    05 W-INQ-RTB-RX-QTY PIC  X(09).
    05 W-INQ-CANCEL-DTTI            PIC  X(12).
*{Bench}end
*{TAMIS}copy-working
*COPY    "HR_RCB1IF.WRK".
***********************************************************************
*> C-PY "HR_RCB1IF.WRK".
***********************************************************************
*>---98.02.02增加變數判別是主程式或是副主式
*------>日期時間
*COPY    "ZD_DTI.WRK".
*
* ZD_DTI.WRK ... 日期時間 ...
*
 01      W-DATE          PIC 9(08).
 01      W-DATEDEF REDEFINES W-DATE.
        02  W-YY        PIC 9(04).
        02  W-MM        PIC 9(02).
        02  W-DD        PIC 9(02).
 01      W-TIME.
        02  W-HH        PIC 9(02).
        02  W-MT        PIC 9(02).
        02  W-SS        PIC 9(02).
*
*COPY    "ZS_DFF.WRK".
*
*  ZS_DFF.WRK --- 功能鍵值設定 ---
*
 01      W-KEY-ENTERED           PIC 9(3).
        88  W-WRAP-KEY          VALUE 0.
        88  W-ESC-KEY           VALUE 27.
        88  W-CR-KEY            VALUE 13.
        88  W-LF-KEY            VALUE 10.
        88  W-RETURN-KEY        VALUE 10,13.
        88  W-UP-KEY            VALUE 52,1.
        88  W-DOWN-KEY          VALUE 53,2.

        88  W-PGUP-KEY          VALUE 67,3.
        88  W-PGDN-KEY          VALUE 68,4.
        88  W-HOME-KEY          VALUE 65,7.
        88  W-END-KEY           VALUE 66,8.
        88  W-LEFT-KEY          VALUE 50.
        88  W-RIGHT-KEY         VALUE 51.
*
        88  W-UP-KEY1           VALUE 52,11.
        88  W-DOWN-KEY1         VALUE 53,12.
        88  W-PGUP-KEY1         VALUE 67,33.
        88  W-PGUP-KEY2         VALUE 67,13.
        88  W-PGDN-KEY1         VALUE 68,14.
        88  W-HOME-KEY1         VALUE 65,17.
        88  W-END-KEY1          VALUE 66,18.
*
        88  W-UP-KEYS           VALUE 52.
        88  W-DOWN-KEYS         VALUE 53.
        88  W-PGUP-KEYS         VALUE 67.
        88  W-PGDN-KEYS         VALUE 68.
        88  W-HOME-KEYS         VALUE 65.
        88  W-END-KEYS          VALUE 66.
*
        88  W-F1-KEY            VALUE 1.
        88  W-F2-KEY            VALUE 2.
        88  W-F3-KEY            VALUE 3.
        88  W-F4-KEY            VALUE 4.
        88  W-F5-KEY            VALUE 5.
        88  W-F6-KEY            VALUE 6.
        88  W-F7-KEY            VALUE 7.
        88  W-F8-KEY            VALUE 8.
        88  W-F9-KEY            VALUE 9.
        88  W-F10-KEY           VALUE 10.
        88  W-SF1-KEY           VALUE 11.
        88  W-SF2-KEY           VALUE 12.
        88  W-SF3-KEY           VALUE 13.
        88  W-SF4-KEY           VALUE 14.
        88  W-SF5-KEY           VALUE 15.
        88  W-SF6-KEY           VALUE 16.
        88  W-SF7-KEY           VALUE 17.
        88  W-SF8-KEY           VALUE 18.
        88  W-SF9-KEY           VALUE 19.
        88  W-SF10-KEY          VALUE 20.
*
        88  W-TIME-OUT          VALUE 99.
        88  W-TAB-KEY           VALUE 31.
        88  W-STAB-KEY          VALUE 32.
        88  W-SF3-KEY1          VALUE 33.
*
        88  W-MOUSE-MOVED       VALUE 80.
        88  W-MOUSE-PUSHED      VALUE 81.
        88  W-MOUSE-RELEASED    VALUE 82.
        88  W-MOUSE-CLICKED     VALUE 83.
        88  W-MOUSE-R-PUSHED    VALUE 87.
        88  W-MOUSE-R-RELEASED  VALUE 88.
        88  W-MOUSE-R-CLICKED   VALUE 89.
        88  W-MOUSE-LR-PUSHED   VALUE 81,87.
        88  W-MOUSE-LR-RELEASED VALUE 82,88.

        88  W-MOUSE-LR-CLICKED  VALUE 83,89.
*
**** 94.03.26 ...
*
* FUN-KEY
        88  W-KB-F11            VALUE 915.
        88  W-KB-F12            VALUE 916.
*
* SHIFT-FUN-KEY
*       88  W-KB-SF10           VALUE 917.
        88  W-KB-SF11           VALUE 918.
        88  W-KB-SF12           VALUE 919.
*
* CTRL-FUN-KEY
        88  W-KB-CF1            VALUE 901.
        88  W-KB-CF2            VALUE 902.
        88  W-KB-CF3            VALUE 903.
        88  W-KB-CF4            VALUE 904.
        88  W-KB-CF5            VALUE 905.
        88  W-KB-CF6            VALUE 906.
        88  W-KB-CF7            VALUE 907.
        88  W-KB-CF8            VALUE 908.
        88  W-KB-CF9            VALUE 909.
*       88  W-KB-CF10           VALUE 910.
        88  W-KB-CF11           VALUE 911.
        88  W-KB-CF12           VALUE 912.
*
        88  W-KB-CTL-INS        VALUE 980.
        88  W-KB-CTL-DEL        VALUE 981.
        88  W-KB-CTL-HOME       VALUE 982.
        88  W-KB-CTL-END        VALUE 983.
        88  W-KB-CTL-PGUP       VALUE 984.
        88  W-KB-CTL-PGDN       VALUE 985.
*
        88  W-KB-CTL-UP         VALUE 986.
        88  W-KB-CTL-DOWN       VALUE 987.
        88  W-KB-CTL-LEFT       VALUE 988.
        88  W-KB-CTL-RIGHT      VALUE 989.
*
*KEYSTROKE  Exception=971   ^Z
*KEYSTROKE  Exception=972   ^X
*KEYSTROKE  Exception=973   ^C
*KEYSTROKE  Exception=974   ^V
*KEYSTROKE  Exception=975   ^D
*KEYSTROKE  Exception=976   ^A
*KEYSTROKE  Exception=978   ^H
*
        88  W-KB-UNDO           VALUE 971.
        88  W-KB-CUT            VALUE 972.
        88  W-KB-COPY           VALUE 973.
        88  W-KB-PASTE          VALUE 974.
        88  W-KB-DELETE         VALUE 975.
        88  W-KB-SELECT-ALL     VALUE 976.
        88  W-KB-ITEM-HELP      VALUE 978.
        88  W-KB-HELP-CURSOR    VALUE 979.
*
* CTRL + 1,2,3,4,5,6,7,8,9,0

        88  W-KB-DF1            VALUE 921.
        88  W-KB-DF2            VALUE 922.
        88  W-KB-DF3            VALUE 923.
        88  W-KB-DF4            VALUE 924.
        88  W-KB-DF5            VALUE 925.
        88  W-KB-DF6            VALUE 926.
        88  W-KB-DF7            VALUE 927.
        88  W-KB-DF8            VALUE 928.
        88  W-KB-DF9            VALUE 929.
        88  W-KB-DF10           VALUE 930.
*
* ALT-FUN-KEY --- 暫不開放使用 ...
        88  W-KB-AF1            VALUE 931.
        88  W-KB-AF2            VALUE 932.
        88  W-KB-AF3            VALUE 933.
*       88  W-KB-AF4            VALUE 934.
        88  W-KB-AF5            VALUE 935.
*       88  W-KB-AF6            VALUE 936.
        88  W-KB-AF7            VALUE 937.
        88  W-KB-AF8            VALUE 938.
        88  W-KB-AF9            VALUE 939.
        88  W-KB-AF10           VALUE 940.
        88  W-KB-AF11           VALUE 941.
        88  W-KB-AF12           VALUE 942.
*
* SHIFT-CTRL-FUN-KEY
        88  W-KB-SCF1           VALUE 951.
        88  W-KB-SCF2           VALUE 952.
        88  W-KB-SCF3           VALUE 953.
        88  W-KB-SCF4           VALUE 954.
        88  W-KB-SCF5           VALUE 955.
        88  W-KB-SCF6           VALUE 956.
        88  W-KB-SCF7           VALUE 957.
        88  W-KB-SCF8           VALUE 958.
        88  W-KB-SCF9           VALUE 959.
*       88  W-KB-SCF10          VALUE 960.
        88  W-KB-SCF11          VALUE 961.
        88  W-KB-SCF12          VALUE 962.
*
 01      W-KB-KEYMAP-OPERATIONS.
        03  W-KB-SAVE-KEYMAP    PIC 9 VALUE 1.
        03  W-KB-RESTORE-KEYMAP PIC 9 VALUE ZERO.
*
*------>日期檢查
*COPY    "ZD_CHK.WRK".
*
* ZD_CHK.WRK ... CALL "ZDCHKCF" USING W-DTCHK-TBL.  --- 16 BYTES ---
*            --- 日期檢查 ...
*
 01      W-DTCHK-TBL.
        02 W-DTCHK-TBL1                 PIC 9(08).
        02 W-DTCHK-TBL11 REDEFINES W-DTCHK-TBL1.
                03 W-YMTBL.
                        04 W-YYTBL      PIC 9(04).
                        04 W-MMTBL      PIC 9(02).
                03 W-DDTBL              PIC 9(02).
        02 W-YYALL-SW                   PIC X(01).

        02 W-DT-YYSW                    PIC X(01).
        02 W-DT-YYDEF                   PIC 9(04).
        02 W-DT-YYCOM                   PIC X(01).
        02 W-DTCHK-SW                   PIC X(01).
*
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `A' 表示年允許為  01 --～ 年.
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = ` ' 表示年僅能為  69 --～ 年.
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `C' 表示年僅能為 今年--～ 年.
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `S' 表示日期僅能 今天--～ 年.
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `M' 表示日期僅能 本月--～ 年.
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `L' 表示日期僅能 上月--～ 年.
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `R' 表示日期僅能 去年--～ 年.
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `D' 表示日期僅能  01 --～今天.
*
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `1' 表示年允許為  01 --加3年.
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `2' 表示年僅能為  69 --加3年.
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `3' 表示年僅能為 今年--加3年.
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `4' 表示日期僅能 今天--加3年.
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `5' 表示日期僅能 本月--加3年.
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `6' 表示日期僅能 上月--加3年.
* 若 CALL "ZDCHKCF" 前 設定 W-YYALL-SW = `7' 表示日期僅能 去年--加3年.
*
******-------------------------------------→ 加3年 表示今年起之大後年.
*
* YYSW      : 使用年曆設定     -- 4:使用四碼西元年 2:二碼西元年, 空白表使用國年
* YYDEF     : 年度換算初值     -- 西元年換算使用國年初值(例:1911, 0 視同1911)
* YYCOM     : 年度計算方式     -- 西元年計算使用國年方式(例:+,-, 空白視同 - )
*
* 若 日期審核後 W-DTCHK-SW = `Y' 表 示 日 期 是 正 確 的, 否 則 有 誤.
*
*COPY    "ZD_YMD.WRK".
*
* ZD_YMD.WRK ...
*
* YYSW   : 使用年曆設定     -- 4:使用四碼西元年 2:二碼西元年, 0:表使用當地國年
* YYDEF  : 年度換算初值     -- 西元年換算使用國年初值(例:1911, 0 視同1911)
* YYCOM  : 年度計算方式     -- 西元年計算使用國年方式(例:+,-, 空白視同 - )
* YDFSW  : 變數用...
*
* YYB    : 年度 (轉換前)
* DATE1  : 日期 (轉換前 6 碼)
* YYS    : - 表轉換後年度為負值
* DATE   : 日期 (轉換後 8 碼)
* TIME   : 時間 ( 6 碼)
* TIME8  : 時間 ( 8 碼)
*
 01      W-YMD-YYWK.
        02 W-YMD-YYSW           PIC X(01).
        02 W-YMD-YYDEF          PIC 9(04).
        02 W-YMD-YYCOM          PIC X(01).
        02 W-YMD-YDFSW          PIC X(04).
*
 01      W-YMD-YYB               PIC 9(04).
 01      W-YMD-DATE1             PIC 9(06).
 01      W-YMD-DATEB REDEFINES W-YMD-DATE1.
        02 W-YMD-YY1            PIC 9(02).
        02 W-YMD-MM1            PIC 9(02).

        02 W-YMD-DD1            PIC 9(02).
*
 01      W-YMD-YYS               PIC X(01).
 01      W-YMD-DATE              PIC 9(08).
 01      W-YMD-DATEA REDEFINES W-YMD-DATE.
        02 W-YMD-YY             PIC 9(04).
        02 W-YMD-MM             PIC 9(02).
        02 W-YMD-DD             PIC 9(02).
*
 01      W-YMD-TIME.
        02 W-YMD-HH             PIC 9(02).
        02 W-YMD-MT             PIC 9(02).
        02 W-YMD-SS             PIC 9(02).
*
 01      W-YMD-TIME8             PIC 9(08).
 01      W-YMD-TIMES REDEFINES W-YMD-TIME8.
        02 W-YMD-HHS            PIC 9(02).
        02 W-YMD-MTS            PIC 9(02).
        02 W-YMD-SSS            PIC 9(02).
        02 W-YMD-TIS            PIC 9(02).
*
*COPY    "ZP_RUNS.LNK".
*
*** ZP_RUNS.LNK ... 長度:6000 --- ( ZP_RUNSL.LNK LINK 使用 ) ...
*               --- TAMIS 系統參數表 ...
*
* -PSD-------------------------------------------------------
* USER  : 使用者代碼
* CFID  : 客戶檔案識別  --- 內容為TATUNG時表要重接受PSD-CFID (ZPSEMSF)
* USID  : 使用者員工編號
* PID   : 身份証字號
*
* PASS  : 使用者密碼
* FLP   : 預留(密碼)
* PSPM  : 密碼檢查碼
* RMK1  : 資料檢查內容
*           PES   : 系統代碼  (PES)
*           PDATE : 帳號使用到期日
*           UDATE : 最近使用日期
*           CDATE : 最近更新密碼日期
*           IMP   : 中文輸入法 -- 可用 1,2,3,4,5,6,8,9,0
*           FGP   : SMT 功能檢查群組, 目前 SYSTEM-TREE 畫面僅讀取 E & U,
*                       TA 表系統管理員, 即 SMT-SID = E,U, 全部
*                       TS 表特定使用者( E & U ),
*                       TU 表一般使用者( E & U ),
*           FL1   : 預留
*           DPT   : 通告所屬單位
*           FL2   : 預留
*           CHG   : N-->單一簽入密碼變更不同步更新此帳號之密碼
*           LOGCT : 登入次數
* RMK2  : 資料檢查內容
*           PNAME :員工姓名
*           RMK21 :預留
*           PTEL  :電話
*           PTSN  :分機
*
* -PSP-------------------------------------------------------

* PAR1      : 資料檢查內容
* PAR2      : 資料檢查內容
*
* -SEM-TMS---------------------------------------------------
* TAMIS : 識別碼       --- TAMIS (固定使用)
*
* -SEM-CID---------------------------------------------------
* CHKSW     : 檢查碼                  -- TATUNG OK
* MASTER    : 客戶主副識別            -- 空白 或 M 表總部, S 表分部
* SYSID1    : ＴＡＭＩＳ系統識別-1    -- TAMIS
* SYSID2    : ＴＡＭＩＳ系統識別-2    -- T A M I S
* FAMILY    : 系統主機識別            -- D.G. AV/3750
* VERSION   : 系統ＯＳ版本            -- AViiON UX 5.4 版
* COPYRIGHT : 系統版權所有            -- ＴＡＭＩＳ所有權
*             ㊣(C)Copyright Tatung Co., All rights reserved. On 1-APR-84'
* SYSNM1    : 系統標題                -- 經  營  資  訊  整  合  系  統
* FL-CID    : 系統設定預留
*
* -SEM-MIS---------------------------------------------------
* CFNO-S    : 客戶檔案編號     --- 統一註冊編訂, 原則上空白, 特殊狀況才使用
*             HOSP1 : 客戶識別,  例: 醫療 -- 01:衛生署 10：十家 07：七家,..
*             HOSP2 : 識別排序,  例: 醫療 -- 01:第一家, 02：第二家, ....
* COPD      : 使用識別,     例: 醫療 -- C 表本醫院有中醫門診
* DBID      : 資料庫識別,      -- S:SYB, O:ORA, I:INF, V:VISION,
* CHRID     : 載入已造字形,    -- C:表要執行載入作業
* LOGID     : 系統簽入記錄,    -- N:表不記錄,餘表要記錄
* BMPID     : 圖檔展示         -- 空白表要執行圖檔展示, N:表不展示
* HIDID     : 檔案開檔識別     -- 資料開檔識別 -- TP,TC, ,...
* FL-SR     : 預留
* ACUGT     : RUNTIME 版本識別 -- Y 表使用 ACUGT 版 RUNTIME
* NEWET     : PRINT 印表識別   -- W 表使用 winprint 印表
* ACULK     : ACULOCK 版本識別 -- Y 表使用 新版 ACULOCK
* LNOSW     : 執行線路檢查     -- Y 表要執行系統線路設定檢查
* PEPSW     : 使用電子病歷查詢 -- Y 表有使用病人電子病歷查詢系統
* VERSW     : 系統版本         -- 空白表醫療Ｈ版, Y 表Ｍ版, L 表旅館版
* VERID     : 系統版次         -- 空白表使用一般綜合版, 其他則表特定版
* APLSW     : 使用申報主機     -- Y 表有使用申報主機系統
* RPASW     : 不再接受密碼檢查 -- N 表選單密碼設定 R 時不再接受密碼檢查(舊版)
* PSDID     : 密碼檢查顯示方式 -- D:表顯示密碼, 餘則(SECURE)不顯示密碼
* PDAY      : 密碼變更期限日數   (最後一次變更超過期限, 則要求變更密碼)
* VBMSW     : 系統架構設定     -- C 表使用Client-server
*                                 V 表使用Thin-client
*                                 B 表使用Thin-client 及 Client-server 混用
*                                 M 表使用Host-terminal
* LCESW     : 系統語言版本     -- C 表中文版, E 表英文版
* YYSW      : 使用年曆設定     -- 4:四碼西元年 2:二碼西元年, 0 表使用當地國年
* YYDEF     : 年度換算初值     -- 西元年換算使用國年初值(例:1911, 0 視同1911)
* YYCOM     : 年度計算方式     -- 西元年計算使用國年方式(例:+,-, 空白視同 - )
* SMTSW     : 系統識別顯示方式 -- A 表全部顯示, 餘僅顯示 USER 相同之資料
* SBRSW     : 系統選單顯示方式 -- A 表全部顯示, 餘僅顯示 USER 相同之資料
* TCVER     : Thin-client 版別 -- A 表使用ACU版, C 表使用CITIRX版, 空白表其他
* INOLH     : 身份証字號長度   -- 0 表使用 10 碼, 餘依設定
* TELLH     : 電話號碼長度     -- 0 表使用 10 碼, 餘依設定
* TSNLH     : 電話分機長度     -- 0 表使用  4 碼, 餘依設定
* VNOLH     : 廠商統碼長度     -- 0 表使用  8 碼, 餘依設定
* HSTID     : 主機識別         -- XXXX 例:S1
* HSTIP     : 主機位址         -- XXX.XXX.XX.XXX 例:139.XXX.XX.XXX

* HSTOS     : 主機作業系統     -- D:MS-DOS, W:WINDOWS, N:WIN/NT, U:Unix,
*                                 A:AOS/VS, O:OS/2, V:VAX/VMS, S:AMOS, M:MPE/iX,
* LDAY      : 密碼禁用期限日數 (最後一次簽入超過期限, 則禁止再使用)
* SMHID     : Y 表系統有多區設定
* THID      : A--Z 表總區之各區識別
* UWDLH     : 密碼限定最少之長度 --- 例 6 表最少 6 位數, 0 表不限
* UWDSW     : 密碼內容型態 --- N:數字, A:文字, X:文數字, 餘不限
* SCLNO     : 系統設定線路號碼 -- VBMSW 為 V 及 B 時才要設定.
* EMISW     : 資訊通告顯示識別 -- E 表要顯示電子通告,  M 表要顯示電子郵件,
*                                 I 表只顯示公司通告,  餘表要正常顯示
*                                 W 表POP-UP視窗
* FBSW      : Y 表有使用後台批次作業系統
* WEBSW     : Y 表啟用內部資訊網單一簽入功能
* USERSW    : Y 表單一簽入可選HIS使用者帳號
* FUNSW     : Y 表新掛功能預設無權限
* ACULOCKSW : Y 表特定使用者能全部解鎖的功能預設無權限
* OFFCHK    : Y 表醫師休假檢核
* SUPDRCHK  : Y 表支援醫師檢核
* FL-MIS    : 系統設定預留
*
* -SEM-UNM-----------------------------------------------------
* UNAME1    : 客戶名稱1  (簡稱)
* UNAME2    : 客戶名稱2
* UNAME3    : 客戶名稱3
* UNAME4    : 客戶名稱4  (全稱)
*
* -SEM-UID-----------------------------------------------------
* BOSS      : 客戶負責人
* ITNM      : 資訊負責人
* VNO       : 客戶統編
* FL-UID    : 系統設定預留
* TEL1      : 電話-1
* TSN1      : 分機-1
* TEL2      : 電話-2
* TSN2      : 分機-2
* FAX       : 傳真-1
* FSN       : 分機-1
* MAIL      : e-mail
* ADR       : 地址
*
* -SEM-RDV-----------------------------------------------------
* RCO       : 系統研發公司
* RDPT      : 系統研發部門
* RPM       : 系統負責人
* RVNO      : 研發公司統編
* RFL-RDV   : 系統設定預留
* RTEL1     : 電話-1
* RTSN1     : 分機-1
* RTEL2     : 電話-2
* RTSN2     : 分機-2
* RFAX      : 傳真-1
* RFSN      : 分機-1
* RMAIL     : e-mail
* RADR      : 地址
*
* -SMT-------------------------------------------------------
* SID       : 系統功能識別     --- E 表執行手冊,   U 表自設程式執行

*                                  G 表歷史資料-1, H 表歷史資料-2
*                                  S 表系統管理
* GNO1      : 系統群組第一階   --- 例:23會計系統
* GNO2      : 群組項次第二階   --- 例:00會計系統 , 01財會, 02出納, 03成會
* GNO3      : 群組項次第三階   --- 預留
* SEQ1      : 系統群組第一階排序
* SEQ2      : 群組項次第二階排序
* SEQ3      : 群組項次第三階排序-- 預留
* PCTL-S    : 程式執行控制碼   --- 空白,P,L,C,S,W,H,T,,,
* DES-S     : 系統說明描述
* PRG-S     : 啟動之程式,指令集
* SPRG-S    : 啟動呼叫之副程式
* USE-S     : 程式之 USING 內容
* SBUD-S    : 選單使用識別     --- U 表使用者自設系統, 空白表 TAMIS 系統定義
* SBGP-S    : 選單群組
* SBRT-S    : 選單首項
* LNKC-S    : CALL 回上階程式名稱
* SETP-S    : 設定時要呼叫之副程式
* PSPP-S    : 系統參數設定時要呼叫之副程式
* SCESW-S   : 系統語言版本     --- C 表中文版, E 表英文版
* FBSW-S    : Y 表轉換後台選單
*           : B 表轉換後台環境(選單不變)
*           : 空白表依原環境設定
* SMT-S     : 預留
*
* -SMU-------------------------------------------------------
* GID       : 使用者群組代碼
* FL-SMU    : 預留
*
* -SBR-------------------------------------------------------
* CFNO      : 客戶檔案編號     --- 統一註冊編訂
* SBUD      : 選單使用識別     --- U 表使用者自設系統, 空白表 TAMIS 系統定義
* SBGP      : 選單群組         --- HAA01.....
* PSID      : 作業編碼系統別   --- 依編碼規則設定 例:HAC
* PSNO      : 作業編碼識別     --- 依編碼規則設定 例:HGNIDKF-2399
* BNO1      : 選單群組第一階   --- 01        結構: 010000
* BNO2      : 選單群組第二階   --- 01                010100
* BNO3      : 選單群組第三階   --- 01                010200 -> 010201
* BNO4      : 選單群組第四階   --- 預留                        010202
* BNO5      : 選單群組第五階   --- 預留              010300
* PCTL-B    : 程式執行控制碼   --- 空白,P,L,C,S,W,H,T,,,
* DES-B     : 系統說明描述
* PRG-B     : 啟動之程式,指令集
* SPRG-B    : 副程式
* USE-B     : 程式之 USING 內容
* SLSW-B    : 項目識別         --- | 表項下畫線, X 表標示項, * 表DISABLE選項,
*                                                - 表標示項且項下畫線.
* BCESW-B   : 系統語言版本     --- C 表中文版, E 表英文版
* SBR-B     : 預留
*
* -SBF-------------------------------------------------------
* RIGHT     : 作業權限         --- 空白:可使用  *:不可使用
* SUPDR     : Y表設定為支援醫師
* FL-SBG    : 預留
*
* -EXE-------------------------------------------------------
* CTL       : 程式執行控制碼   --- 空白,P,L,C,S,W,H,T,,,

* DES       : 系統說明描述
* PRG       : 啟動之程式,指令集
* SPRG      : 啟動呼叫之副程式
* PARA      : 執行手冊檔之 USING 內容傳送
*             參數內容由執行手冊之 MNU-USE 取得
* LNK       : CALL 回上階程式名稱
* FILLX     : 預留
*
* -UGH-------------------------------------------------------
* ENDP      : E 表呼叫副程式後因異常終止往下執行碼
* GHSW      : 第一(G), 二(H)歷史資料設定, 空白表正式槽(F)
* HYYY      : 第二歷史資料查詢之年度(大於 0 表有設定歷史年度)
* HPTH      : H PORT 之 PATH --- @av37:\history2\092.dir\
* ENVF      : ENV 內容存入之檔名  --- ZS_ENV年月日時分秒微秒.線路USER-ID
*                                      (ZS_ENV92042819302010.V0136..........)
* SEMF      : SEM 內容存入之檔名  --- ZS_SEM年月日時分秒微秒.線路客戶USER
*                                      (ZS_SEM92042819302010.V0136..........)
* RUNF      : RUN 內容存入之檔名  --- ZS_RUN年月日時分秒微秒.線路客戶USER
*                                      (ZS_RUN92042819302010.V0136..........)
* MCNT      : SMT 總組數
* MOCC      : SMT 使用組數
* SMTF      : SMT 內容存入之檔名  --- ZS_SMT年月日時分秒微秒.線路客戶USER
*                                      (ZS_SMT92042819302010.V0136..........)
* BCNT      : SBR 總組數
* BOCC      : SBR 使用組數
* SBRF      : SBR 內容存入之檔名  --- ZS_SBR年月日時分秒微秒.線路客戶USER
*                                      (ZS_SBR92042819302010.V0136..........)
* CCNT      : SBC 總組數
* COCC      : SBC 使用組數
* SBCF      : SBC 內容存入之檔名  --- ZS_SBC年月日時分秒微秒.線路客戶USER
*                                      (ZS_SBC92042819302010.V0136..........)
* FILLU     : 預留
*
* -TRM--------TERMINAL-ABILITIES-----------------------------
* TRNNM     : TERMINAL-NAME
* 132CL     : Y:HAS-132-COLUMN-MODE
* COLOR     : Y:HAS-COLOR
* SCRLN     : NUMBER-OF-SCREEN-LINES
* SCRCL     : NUMBER-OF-SCREEN-COLUMNS
* LOCPR     : Y:HAS-LOCAL-PRINTER
* ISRMT     : Y:IS-REMOTE
* PCNM      : CLIENT-MACHINE-NAME
* PCIP      : CLIENT IP ADDRESS
* FILLR     : 預留
*
* -STM-------------------------------------------------------
* OS        : OS ID. --- DOS--\, UNIX--/, AOS--:
* OSNM      : OPERATING-SYSTEM
* WINSW     : W:OS-IS-WIN-FAMILY --- WINDOWS & WIN/NT
* OSID      : D:MS-DOS, W:WINDOWS, N:WIN/NT,  U:Unix,
*             A:AOS/VS, O:OS/2     V:VAX/VMS, S:AMOS, M:MPE/iX,
* USERID    : USER-ID
* STATID    : STATION-ID
* VERSION   : RUNTIME-VERSION 版本
* PLUGIN    : Y:IS-PLUGIN
* SERNO     : SERIAL-NUMBER
* 98XP      : 9:表98電腦, 2:表2000電腦, X:表XP電腦. 7:WINDOWS7, 8:WINDOWS8,

*             V:VISTA   , 3:Windows Server 2003
* PC-BIT    : WINDOSW 7 或 8,1:32 bits 或 64 bits
* PC-IP     : 電腦IP
* PC-NAME   : 電腦名稱
* PC-MAC    : 電腦MAC
* FILLS     : 預留
*
* -ENV-------------------------------------------------------
* DBC       : CODE-SYSTEM
* TYPE      : TYPE 指令     ( WIN/DOS/AOS:TYPE, UNIT:cat )
* COMD      : COMMAND 指令  ( NT:CMD, WIN:COMMAND.COM /C, DOS:COMMAND.COM )
* MHIDO     : 原多區識別 --- 有多區設定時使用
* MHIDN     : 新多區識別 --- 有多區設定時使用
* MHDNM     : 多區識別名稱
* FILLE     : 預留
* VMSW      : 線路識別 -- V 表虛擬主機線路，M 表主機線路, C 表網路線路
* SLNO      : 系統線路號碼 例:0096
* SLNO1     : 系統線路號碼 例:96
* SLBF      : 樓層位置
* FILLV     : 預留
*
* -CBL-------------------------------------------------------
* CPREFIX   : CODE-PREFIX              --- m:\lsy.dir;m:\ler1.dir;...
* FPREFIX   : FILE-PREFIX              --- n:\lmisa
* XFDDIR    : XFD-DIRECTORY            --- m:\lfd.dir
* CODESTM   : CODE-SYSTEM              --- BIG5
* FILLB     : 預留
* WINTITLE  : WINDOW-TITLE             --- LMIS(M)
* DEFHOST   : DEFAULT-HOST             --- SYBASE
* DATABASE  : A-SYB-DATABASE           --- lmisa1
* DEFCONT   : A-SYB-DEFAULT-CONNECTION --- SYB_LMIS
* LOCKDB    : A-SYB-LOCK-DB            --- lmisa1
* LOGIN     : A-SYB-LOGIN              --- .....
* PASSWD    : A-SYB-PASSWD             --- .......
* FILLC     : 預留
* MPTH      : ZS_MPTH                  --- ZS_MPTHL
* SZMS      : ZS_SZMS                  --- c:\lmisa\
* SCMS      : ZS_SCMS                  --- c:\lmisa\
* SFMS      : ZS_SFMS                  --- n:\lmisa\
* SWIN      : ZS_SWIN                  --- c:\lwin\
* FILLL     : 預留
* SCID      : ZS_SCID                  --- 離線系統之客戶檔案識別
* SVER      : ZS_SVER                  --- 系統版本         --> VERSW
* SVBM      : ZS_SVBM                  --- 系統架構設定     --> VBMSW
* SLCE      : ZS_SLCE                  --- 系統語言版本     --> LCESW
* SYYW      : ZS_SYYW                  --- 使用年曆設定     --> YYSW
* SYDF      : ZS_SYDF                  --- 年度換算初值     --> YYDEF
* SYCM      : ZS_SYCM                  --- 年度計算方式     --> YYCOM
* SHID      : ZS_SHID                  --- 主機識別         --> HSTID
* SHIP      : ZS_SHIP                  --- 主機位址         --> HSTIP
* SHOS      : ZS_SHOS                  --- 主機作業系統     --> HSTOS
* STCV      : ZS_STCV                  --- Thin-client 版別 --> TCVER
* STMS      : ZS_STMS                  --- T-c 之 client 路徑 --- c$:\lmisa\
* SOFF      : ZS_SOFF                  --- OF 表離線作業系統
* SLLC      : ZS_SLLC                  --- 線路簽入檢查碼, 例: o,q,m,x,r,w,..
* SEPG      : ZS_SEPG                  --- /progs/
* SVSN      : ZS_SVSN                  --- /vision

* SVSF      : ZS_SVSF                  --- /vision/lmisa/
*
* -PTH-------------------------------------------------------
* SCNT      : 有效PATH資料筆數
* SOCC      : 最新一次之選取組數
* HLOC      : H PORT 之yyy.dir之位置
* FILLH     : 預留
* 1:Z, 2:C, 3:A, 4:B, 5:E, 6:F, 7:G, 8:H, 9:I, 10:J, 11:S, 12: ,... 16: ,..
* 1:z, 2:c, 3:a, 4:b, 5:e, 6:f, 7:g, 8:h, 9:i, 10:j, 11:s, 12: ,... 16: ,..
* PORT      : ? 碟      --- F 大寫
* PORTL     : ? 碟      --- f 小寫
* PSLH      : ? 節點    --- DOS--\, UNIX--/, AOS--:
* PTH1      : ? 路徑-1  --- n:\
* PTH2      : ? 路徑-2  --- n:\hmisa\
*
* -DHS-------------------------------------------------------
* LDATE     : 最新LOGIN日期
* LTIME     : 最新LOGIN時間
* DATE      : 最新系統日期
* TIME      : 最新系統時間
* NDATE     : 網路最新存取之系統日期
* NTIME     : 網路最新存取之系統時間
*
* -WEK-------------------------------------------------------
* MONNM1    : 月大寫        --- JANUARY -- DECEMBER
* MONNM2    : 月小寫        --- January -- December
* MONNM3    : 月簡寫        --- JAN     -- DEC
* MONDAY    : 月日數        --- 31      -- 31
* MONFSP    : 月初空白日
* WKNM1     : 週全名        --- Monday  -- Sunday
* WKNM2     : 週簡寫        --- mon     -- SUN
* WKNM3     : 週中文        --- 一      -- 日
* WKNM4     : 週星期別      --- 1       -- 7
* HOLIDAYS  : 系統假日      --- 直接人員出勤日, 空白全天出勤,
*                               * 表全天放假, # 表半天出勤, @ 表隔週六休假
* HOLIDAYD  : 統計假日
* HOLIDAYU  : 使用者假日
*             UDAY1(01)     --- 行政人員出勤日
* WKFILLW   : 預留
* DAYS-CNT  : 年度日數      --- 365
* WKM-CNT   : 月週別
* WKY-CNT   : 年週別
* WKFILLK   : 預留
* WKFS      : Y 表日曆讀取成功
*
* -PGB-------------------------------------------------------
* PRGUSE    : 程式LINK資料暫存區
* -----------------------------------------------------------
*
 01      W-RUN-CHK.
* 200  (1:200)
        02 W-RUN-PSD.
                03 W-RUN-USER                   PIC X(20).
                03 W-RUN-CFID                   PIC X(06).
                03 W-RUN-USID                   PIC X(10).
                03 W-RUN-PID                    PIC X(20).
                03 W-RUN-PASS                   PIC X(20).

                03 W-RUN-FLP                    PIC X(03).
                03 W-RUN-PSPM                   PIC 9(01).
                03 W-RUN-RMK1.
                        04 W-RUN-PES            PIC X(03).
                        04 W-RUN-PDATE          PIC 9(08).
                        04 W-RUN-UDATE          PIC 9(08).
                        04 W-RUN-CDATE          PIC 9(08).
                        04 W-RUN-IMP            PIC X(01).
                        04 W-RUN-FGP            PIC X(02).
                        04 W-RUN-FL1            PIC X(03).
                        04 W-RUN-DPT            PIC X(10).
                        04 W-RUN-FL2            PIC X(10).
                        04 W-RUN-CHG            PIC X(01).
                        04 W-RUN-LOGCT          PIC 9(06).
                03 W-RUN-RMK2.
                        04 W-RUN-PNAME          PIC X(12).
                        04 W-RUN-RMK21          PIC X(22).
                        04 W-RUN-PTEL           PIC X(20).
                        04 W-RUN-PTSN           PIC X(06).
* 120  (201:120)
        02 W-RUN-PSP.
                03 W-RUN-PAR1                   PIC X(60).
                03 W-RUN-PAR2                   PIC X(60).
* 880  (321:880)
        02 W-RUN-SEM.
                03 W-RUN-SEM-TMS.
                        04 W-RUN-TAMIS          PIC X(10).
                03 W-RUN-SEM-CID.
                        04 W-RUN-CHKSW          PIC X(10).
                        04 W-RUN-MASTER         PIC X(01).
                        04 W-RUN-SYSID1         PIC X(10).
                        04 W-RUN-SYSID2         PIC X(20).
                        04 W-RUN-FAMILY         PIC X(12).
                        04 W-RUN-VERSION        PIC X(16).
*                       04 W-RUN-COPYRIGHT      PIC X(60).
                        04 W-RUN-SYSNM1         PIC X(40).
                        04 W-RUN-FL-CID         PIC X(21).
*>PENNY001
                        04 W-RUN-FL-CIDH REDEFINES W-RUN-FL-CID.
                           05 W-RUN-RS-Y        PIC X(1).
                           05 W-RUN-RS          PIC X(20).
                03 W-RUN-SEM-MIS.
                        04 W-RUN-CFNO-S         PIC X(04).
                        04 W-RUN-CFNO-SH REDEFINES W-RUN-CFNO-S.
                           05 W-RUN-HOSP1       PIC X(02).
                           05 W-RUN-HOSP2       PIC X(02).
                        04 W-RUN-COPD           PIC X(01).
                        04 W-RUN-DBID           PIC X(01).
                        04 W-RUN-CHRID          PIC X(01).
                        04 W-RUN-LOGID          PIC X(01).
                        04 W-RUN-BMPID          PIC X(01).
                        04 W-RUN-HIDID          PIC X(02).
                        04 W-RUN-FL-SR          PIC X(02).
                        04 W-RUN-ACUGT          PIC X(01).
                        04 W-RUN-NEWET          PIC X(01).
                        04 W-RUN-ACULK          PIC X(01).
                        04 W-RUN-LNOSW          PIC X(01).

                        04 W-RUN-PEPSW          PIC X(01).
                        04 W-RUN-VERSW          PIC X(01).
                        04 W-RUN-VERID          PIC X(02).
                        04 W-RUN-APLSW          PIC X(01).
                        04 W-RUN-RPASW          PIC X(01).
                        04 W-RUN-PSDID          PIC X(01).
                        04 W-RUN-PDAY           PIC 9(03).
                        04 W-RUN-VBMSW          PIC X(01).
                        04 W-RUN-LCESW          PIC X(01).
                        04 W-RUN-YYSW           PIC X(01).
                        04 W-RUN-YYDEF          PIC 9(04).
                        04 W-RUN-YYCOM          PIC X(01).
                        04 W-RUN-SMTSW          PIC X(01).
                        04 W-RUN-SBRSW          PIC X(01).
                        04 W-RUN-TCVER          PIC X(01).
                        04 W-RUN-INOLH          PIC 9(02).
                        04 W-RUN-TELLH          PIC 9(02).
                        04 W-RUN-TSNLH          PIC 9(01).
                        04 W-RUN-VNOLH          PIC 9(02).
                        04 W-RUN-HSTID          PIC X(10).
                        04 W-RUN-HSTIP          PIC X(20).
                        04 W-RUN-HSTOS          PIC X(01).
                        04 W-RUN-LDAY           PIC 9(03).
                        04 W-RUN-SMHID          PIC X(01).
                        04 W-RUN-THID           PIC X(01).
                        04 W-RUN-UWDLH          PIC 9(02).
                        04 W-RUN-UWDSW          PIC X(01).
                        04 W-RUN-SCLNO          PIC 9(04).
                        04 W-RUN-EMISW          PIC X(01).
                        04 W-RUN-FBSW           PIC X(01).
                        04 W-RUN-WEBSW          PIC X(01).
                        04 W-RUN-USERSW         PIC X(01).
                        04 W-RUN-FUNSW          PIC X(01).
                        04 W-RUN-ACULOCKSW      PIC X(01).
                        04 W-RUN-OFFCHK         PIC X(01).
                        04 W-RUN-SUPDRCHK       PIC X(01).
                        04 W-RUN-FL-MIS         PIC X(04).
                03 W-RUN-SEM-UNM.
                        04 W-RUN-UNAME1         PIC X(10).
                        04 W-RUN-UNAME2         PIC X(20).
                        04 W-RUN-UNAME3         PIC X(30).
                        04 W-RUN-UNAME4         PIC X(60).
                03 W-RUN-SEM-UID.
                        04 W-RUN-BOSS           PIC X(20).
                        04 W-RUN-ITNM           PIC X(20).
                        04 W-RUN-VNO            PIC X(16).
                        04 W-RUN-FL-UID         PIC X(16).
                        04 W-RUN-TEL1           PIC X(20).
                        04 W-RUN-TSN1           PIC X(06).
                        04 W-RUN-TEL2           PIC X(20).
                        04 W-RUN-TSN2           PIC X(06).
                        04 W-RUN-FAX            PIC X(20).
                        04 W-RUN-FSN            PIC X(06).
                        04 W-RUN-MAIL           PIC X(26).
                        04 W-RUN-ADR            PIC X(34).
                03 W-RUN-SEM-RDV.
                        04 W-RUN-RCO            PIC X(40).

                        04 W-RUN-RDPT           PIC X(20).
                        04 W-RUN-RPM            PIC X(20).
                        04 W-RUN-RVNO           PIC X(16).
                        04 W-RUN-RFL-RDV        PIC X(16).
                        04 W-RUN-RTEL1          PIC X(20).
                        04 W-RUN-RTSN1          PIC X(06).
                        04 W-RUN-RTEL2          PIC X(20).
                        04 W-RUN-RTSN2          PIC X(06).
                        04 W-RUN-RFAX           PIC X(20).
                        04 W-RUN-RFSN           PIC X(06).
                        04 W-RUN-RMAIL          PIC X(26).
                        04 W-RUN-RADR           PIC X(34).
* 226  (1201:226)
        02 W-RUN-SMT.
                03 W-RUN-CSID.
                        04 W-RUN-SID            PIC X(01).
                03 W-RUN-GNO.
                        04 W-RUN-GNO1           PIC 9(02).
                        04 W-RUN-GNO2           PIC 9(02).
                        04 W-RUN-GNO3           PIC 9(02).
                03 W-RUN-SEQ.
                        04 W-RUN-SEQ1           PIC 9(02).
                        04 W-RUN-SEQ2           PIC 9(02).
                        04 W-RUN-SEQ3           PIC 9(02).
                03 W-RUN-CSMT.
                        04 W-RUN-PCTL-S         PIC X(01).
                        04 W-RUN-DES-S          PIC X(40).
                        04 W-RUN-PRG-S          PIC X(40).
                        04 W-RUN-SPRG-S         PIC X(20).
                        04 W-RUN-USE-S          PIC X(40).
                        04 W-RUN-SBR-S.
                           05 W-RUN-SBUD-S      PIC X(01).
                           05 W-RUN-SBGP-S      PIC X(10).
                           05 W-RUN-SBRT-S      PIC 9(02).
                        04 W-RUN-LNKC-S         PIC X(20).
                        04 W-RUN-SETP-S         PIC X(12).
                        04 W-RUN-PSPP-S         PIC X(12).
                        04 W-RUN-SCESW-S        PIC X(01).
                        04 W-RUN-FBSW-S         PIC X(01).
                        04 W-RUN-SMT-S          PIC X(13).
* 20   (1427:20)
        02 W-RUN-SMU.
                03 W-RUN-UGD.
                        04 W-RUN-GID            PIC X(10).
                        04 W-RUN-FL-SMU         PIC X(10).
* 216  (1447:216)
        02 W-RUN-SBR.
                03 W-RUN-CF.
                        04 W-RUN-CFNO           PIC X(04).
                03 W-RUN-SBG.
                        04 W-RUN-SBUD           PIC X(01).
                        04 W-RUN-SBGP           PIC X(10).
                03 W-RUN-PSG.
                        04 W-RUN-PSID           PIC X(03).
                        04 W-RUN-PSNO           PIC X(20).
                03 W-RUN-BNO.
                        04 W-RUN-BNO1           PIC 9(02).

                        04 W-RUN-BNO2           PIC 9(02).
                        04 W-RUN-BNO3           PIC 9(02).
                        04 W-RUN-BNO4           PIC 9(02).
                        04 W-RUN-BNO5           PIC 9(02).
                03 W-RUN-CSBR.
                        04 W-RUN-PCTL-B         PIC X(01).
                        04 W-RUN-DES-B          PIC X(40).
                        04 W-RUN-PRG-B          PIC X(40).
                        04 W-RUN-SPRG-B         PIC X(20).
                        04 W-RUN-USE-B          PIC X(40).
                        04 W-RUN-SLSW-B         PIC X(01).
                        04 W-RUN-BCESW-B        PIC X(01).
                        04 W-RUN-SBR-B          PIC X(25).
* 10   (1663:10)
        02 W-RUN-SBF.
                03 W-RUN-SRTF.
                        04 W-RUN-RIGHT          PIC X(01).
                        04 W-RUN-SUPDR          PIC X(01).
                        04 W-RUN-FL-SBG         PIC X(08).
* 245  (1673:245)
        02 W-RUN-EXE.
                03 W-RUN-CTL                    PIC X(01).
                03 W-RUN-DES                    PIC X(40).
                03 W-RUN-PRG                    PIC X(40).
                03 W-RUN-SPRG                   PIC X(20).
                03 W-RUN-PARA                   PIC X(40).
                03 W-USE-PARA REDEFINES W-RUN-PARA.
                        04 W-USE-PARA1          PIC X(30).
                        04 W-USE-PARA2          PIC X(10).
                03 W-RUN-LNK                    PIC X(20).
                03 W-RUN-FILLX                  PIC X(84).
* 380  (1918:380)
        02 W-RUN-UGH.
                03 W-RUN-ENDP                   PIC X(01).
                03 W-RUN-GHSW                   PIC X(01).
                03 W-RUN-HYYY                   PIC 9(04).
                03 W-RUN-HPTH                   PIC X(40).
                03 W-RUN-ENVF                   PIC X(40).
                03 W-RUN-SEMF                   PIC X(52).
                03 W-RUN-RUNF                   PIC X(52).
                03 W-RUN-MCNT                   PIC 9(04).
                03 W-RUN-MOCC                   PIC 9(04).
                03 W-RUN-SMTF                   PIC X(52).
                03 W-RUN-BCNT                   PIC 9(04).
                03 W-RUN-BOCC                   PIC 9(04).
                03 W-RUN-SBRF                   PIC X(52).
                03 W-RUN-CCNT                   PIC 9(04).
                03 W-RUN-COCC                   PIC 9(04).
                03 W-RUN-SBCF                   PIC X(52).
                03 W-RUN-FILLU                  PIC X(10).
* 125  (2298:125)
        02 W-RUN-TRM.
                03 W-RUN-TRNNM                  PIC X(10).
                03 W-RUN-132CL                  PIC X(01).
                03 W-RUN-COLOR                  PIC X(01).
                03 W-RUN-SCRLN                  PIC 9(03).
                03 W-RUN-SCRCL                  PIC 9(03).

                03 W-RUN-LOCPR                  PIC X(01).
                03 W-RUN-ISRMT                  PIC X(01).
                03 W-RUN-PCNM                   PIC X(64).
                03 W-RUN-PCIP                   PIC X(20).
                03 W-RUN-FILLR                  PIC X(21).
* 130  (2423:130)
        02 W-RUN-STM.
                03 W-RUN-OS                     PIC X(01).
                03 W-RUN-OSNM                   PIC X(10).
                03 W-RUN-WINSW                  PIC X(01).
                03 W-RUN-OSID                   PIC X(01).
                03 W-RUN-USERID                 PIC X(12).
                03 W-RUN-STATID                 PIC X(12).
                03 W-RUN-VERSION1.
                        04 W-RUN-MAJOR          PIC 9(02).
                        04 W-RUN-MINOR          PIC 9(02).
                        04 W-RUN-RELEASE        PIC 9(02).
                03 W-RUN-PLUGIN                 PIC X(01).
                03 W-RUN-SERNO                  PIC X(20).
                03 W-RUN-98XP                   PIC X(01).
                03 W-RUN-PC-BIT                 PIC X(01).
                03 W-RUN-PC-IP                  PIC X(15).
                03 W-RUN-PC-NAME                PIC X(20).
                03 W-RUN-PC-MAC                 PIC X(12).
                03 W-RUN-FILLS                  PIC X(17).
* 100  (2553:100)
        02 W-RUN-ENV.
                03 W-RUN-DBC                    PIC 9(05).
                03 W-RUN-TYPE                   PIC X(06).
                03 W-RUN-COMD                   PIC X(16).
                03 W-RUN-MHIDO                  PIC X(02).
                03 W-RUN-MHIDN                  PIC X(02).
                03 W-RUN-MHDNM                  PIC X(22).
                03 W-RUN-FILLE                  PIC X(25).
                03 W-RUN-VSB.
                        04 W-RUN-VMSW           PIC X(01).
                        04 W-RUN-SLNO           PIC 9(04).
                        04 W-RUN-SLNO1          PIC X(04).
                        04 W-RUN-SLBF           PIC X(03).
                        04 W-RUN-FILLV          PIC X(10).
* 520  (2653:520)
        02 W-RUN-CBL.
                03 W-RUN-DBSET.
                        04 W-RUN-CPREFIX        PIC X(120).
                        04 W-RUN-FPREFIX        PIC X(20).
                        04 W-RUN-XFDDIR         PIC X(20).
                        04 W-RUN-CODESTM        PIC 9(05).
                        04 W-RUN-FILLB          PIC X(05).
                        04 W-RUN-WINTITLE       PIC X(40).
                        04 W-RUN-DEFHOST        PIC X(10).
                        04 W-RUN-DATABASE       PIC X(10).
                        04 W-RUN-DEFCONT        PIC X(10).
                        04 W-RUN-LOCKDB         PIC X(10).
                        04 W-RUN-LOGIN          PIC X(10).
                        04 W-RUN-PASSWD         PIC X(10).
                        04 W-RUN-FILLC          PIC X(10).
                03 W-RUN-VFSET.

                        04 W-RUN-MPTH           PIC X(20).
                        04 W-RUN-SZMS           PIC X(20).
                        04 W-RUN-SCMS           PIC X(20).
                        04 W-RUN-SFMS           PIC X(20).
                        04 W-RUN-SWIN           PIC X(20).
                        04 W-RUN-FILLL          PIC X(24).
                        04 W-RUN-SCID           PIC X(06).
                        04 W-RUN-SVER           PIC X(01).
                        04 W-RUN-SVBM           PIC X(01).
                        04 W-RUN-SLCE           PIC X(01).
                        04 W-RUN-SYYW           PIC X(01).
                        04 W-RUN-SYDF           PIC 9(04).
                        04 W-RUN-SYCM           PIC X(01).
                        04 W-RUN-SHID           PIC X(06).
                        04 W-RUN-SHIP           PIC X(20).
                        04 W-RUN-SHOS           PIC X(01).
                        04 W-RUN-STCV           PIC X(01).
                        04 W-RUN-STMS           PIC X(10).
                        04 W-RUN-SOFF           PIC X(02).
                        04 W-RUN-SLLC           PIC X(01).
                        04 W-RUN-SEPG           PIC X(20).
                        04 W-RUN-SVSN           PIC X(20).
                        04 W-RUN-SVSF           PIC X(20).
* 1180 (3173:1180)
        02 W-RUN-PTH.
                03 W-RUN-PTHKS.
                        04 W-RUN-SCNT           PIC 9(02).
                        04 W-RUN-SOCC           PIC 9(02).
                        04 W-RUN-HLOC           PIC 9(02).
                        04 W-RUN-FILLH          PIC X(06).
                03 W-RUN-PTHKP OCCURS 16 TIMES.
                        04 W-RUN-PORT           PIC X(01).
                        04 W-RUN-PORTL          PIC X(01).
                        04 W-RUN-PSLH           PIC X(01).
                        04 W-RUN-PTH1           PIC X(30).
                        04 W-RUN-PTH2           PIC X(40).
* 48   (4353:48)
        02 W-RUN-DHS.
                03 W-RUN-LDATE                  PIC 9(08).
                03 W-RUN-LDATER REDEFINES W-RUN-LDATE.
                        04 W-RUN-LDTY           PIC 9(04).
                        04 W-RUN-LDTM           PIC 9(02).
                        04 W-RUN-LDTD           PIC 9(02).
                03 W-RUN-LTIME                  PIC 9(08).
                03 W-RUN-LTIMER REDEFINES W-RUN-LTIME.
                        04 W-RUN-LTIMES.
                           05 W-RUN-LTIH        PIC 9(02).
                           05 W-RUN-LTIM        PIC 9(02).
                           05 W-RUN-LTIS        PIC 9(02).
                        04 W-RUN-LTISEC         PIC 9(02).
                03 W-RUN-DATE                   PIC 9(08).
                03 W-RUN-DATER REDEFINES W-RUN-DATE.
                        04 W-RUN-DTY            PIC 9(04).
                        04 W-RUN-DTM            PIC 9(02).
                        04 W-RUN-DTD            PIC 9(02).
                03 W-RUN-TIME                   PIC 9(08).
                03 W-RUN-TIMER REDEFINES W-RUN-TIME.

                        04 W-RUN-TIMES.
                           05 W-RUN-TIH         PIC 9(02).
                           05 W-RUN-TIM         PIC 9(02).
                           05 W-RUN-TIS         PIC 9(02).
                        04 W-RUN-TISEC          PIC 9(02).
                03 W-RUN-NDATE                  PIC 9(08).
                03 W-RUN-NDATER REDEFINES W-RUN-NDATE.
                        04 W-RUN-NDTY           PIC 9(04).
                        04 W-RUN-NDTM           PIC 9(02).
                        04 W-RUN-NDTD           PIC 9(02).
                03 W-RUN-NTIME                  PIC 9(08).
                03 W-RUN-NTIMER REDEFINES W-RUN-NTIME.
                        04 W-RUN-NTIMES.
                           05 W-RUN-NTIH        PIC 9(02).
                           05 W-RUN-NTIM        PIC 9(02).
                           05 W-RUN-NTIS        PIC 9(02).
                        04 W-RUN-NTISEC         PIC 9(02).
* 100  (4401:100)
        02 W-RUN-WEK.
                03 W-RUN-MONNM1                 PIC X(09).
                03 W-RUN-MONNM2                 PIC X(09).
                03 W-RUN-MONNM3                 PIC X(03).
                03 W-RUN-MONDAY                 PIC 9(02).
                03 W-RUN-MONFSP                 PIC 9(01).
                03 W-RUN-WKNM1                  PIC X(09).
                03 W-RUN-WKNM2                  PIC X(03).
                03 W-RUN-WKNM3                  PIC X(02).
                03 W-RUN-WKNM4                  PIC 9(01).
                03 W-RUN-HOLIDAYS               PIC X(01).
                03 W-RUN-HOLIDAYD               PIC X(01).
                03 W-RUN-HOLIDAYU.
                   04 W-RUN-HOLIDAYU1 OCCURS 10 TIMES.
                        05 W-RUN-UDAY1          PIC X(01).
                03 W-RUN-WKFILLW                PIC X(20).
                03 W-RUN-DAYS-CNT               PIC 9(04).
                03 W-RUN-WKM-CNT                PIC 9(02).
                03 W-RUN-WKY-CNT                PIC 9(02).
                03 W-RUN-WKFILLK                PIC X(20).
                03 W-RUN-WKFS                   PIC X(01).
* 1500 (4501:1500)
        02 W-RUN-PGB.
                03 W-RUN-PRGUSE                 PIC X(1500).
*
*COPY    "ZP_RUNSE.LNK".
*
* ZP_RUNSE.LNK ...  --- TAMIS 系統參數表 ...
*
* W-RUNE-DATA : 同 ZP_RUNS.LNK 之 W-RUN-CHK(1:4500) 之內容
* W-RUNE-OK   : Y 表系統進入時已將 W-RUN-CHK(1:4500) 存入 W-RUNE-DATA
*               餘則並未存入故不得使用.
*               特別注意: CALL PROGRAM "...." 時 EXTERNAL 是無效的.
*
*       IF W-RUNE-OK = "Y" THEN
*               MOVE W-RUNE-CHK TO W-RUN-CHK(1:4500)
*       ELSE    INITIALIZE         W-RUN-CHK
*       END-IF.
*

 01      W-RUNE-CHK IS EXTERNAL.
        02      W-RUNE-DATA     PIC X(4500).
*
 01      W-RUNE-OKSW IS EXTERNAL.
        02      W-RUNE-OK       PIC X(01).
*
*>
*COPY    "HI_ELC.WRK".
*******************************************************************************，
*>      C-PY FILE : HI_ELC.WRK          電子病歷/申報主機 共用WORK
*>      ALSO USED BY 檢驗檢查單張重結功能
*>      900915 INSERT: W-USE-APY-YN
*******************************************************************************，
 01      ELC-TRN-STATUS          PIC X(2)        EXTERNAL.
*> Y-> 表示電子病歷連線
 01      W-ELC-YN                PIC X(1)                VALUE SPACE.
 01      W-ELC-MARK              PIC X(1)                VALUE SPACE.
*> Y-> 表示使用申報主機
 01      W-USE-APY-YN            PIC X(1)                VALUE SPACE.
*> 呼叫HIELCCF 傳遞之參數
*COPY    "HI_ELCCF.LNK".
*-----------------------------------------------------------------------------*
*>      電子病歷日結之LNK (修改請通知文傑)                                    *
*>      CALLED BY 1.住院申請作業 2.住院批價作業 3.住院退藥作業 4.住院申報作業 *
*-----------------------------------------------------------------------------*
 01      W-LNK-ELCCF.
*>      功能識別：01.讀取系統參數，判斷該院是否上線電子病歷、申報主機
*>                02.開檔
*>                03.關檔
*>                11.住院基本資料
*>                21.批價
*>                31.退藥
*>                41.申報主機批價
*>                51.申報主機退藥
        02 W-ELCCF-ID                                   PIC X(02).
*>      傳回是否上線電子病歷(Y/N)
        02 W-ELCCF-YN                                   PIC X(01).
        02 W-ELCCF-KEY                                  PIC X(30).
*>      住院序號
        02 W-ELCCF-IPD-NO.
                03 W-ELCCF-IPD-DT                       PIC 9(07).
                03 W-ELCCF-IPD-SEQ                      PIC 9(04).
        02 W-ELCCF-NO                                   PIC X(11).
*>      處方序號        (W-ELCCF-ID = "21")
        02 W-ELCCF-ODR-NO REDEFINES W-ELCCF-NO.
                03      W-ELCCF-INS-DATE                PIC 9(07).
                03      W-ELCCF-ODR-SEQ                 PIC 9(04).
*>      退藥處方序號    (W-ELCCF-ID = "31")
        02 W-ELCCF-RTA-NO1 REDEFINES W-ELCCF-NO.
                03      W-ELCCF-RTA-NO.
                        05      W-ELCCF-RTA-DATE        PIC 9(07).
                        05      W-ELCCF-RTA-SEQ         PIC 9(03).
                03      W-ELCCF-RTA-FILLER              PIC X(01).
*>      處理狀況(C.新增 M.修改 D.刪除)
        02 W-ELCCF-MARK                                 PIC X(01).
*>      傳回錯誤訊息狀況(Y/N)
        02 W-ELCCF-ERR                                  PIC X(01).

*>      傳回錯誤訊息
        02 W-ELCCF-NOTE                                 PIC X(60).
*>      傳回是否上線申報主機(Y/N)
        02 W-ELCCF-APY-YN                               PIC X.
*>      預留欄位
        02 W-ELCCF-FILLER                               PIC X(29).
*--------------------------------------------------------------------------
*>      ＥＮＤ　ＯＦ　ＣＯＰＹ　ＦＩＬＥ　
*--------------------------------------------------------------------------
*******************************************************************************，
*       END     OF      FILE
*******************************************************************************，
*COPY    "HI_DTE.WRK".
*******************************************************************************
*>      C-PY FILE :     HI_DTE.WRK      申報鎖檔月份共用WORK
*>      PROGRAM USED: HIOD1KF, HIOD2MF, HIOD3DF, HIRTNKF ,醫令相關作業
*>      890511 增加: W-CHK-DTE-YMD
*>      901026 原申報鎖檔判斷改由副程式(HILOCKCF)判斷，故將所有變數MARK (JAY)
*******************************************************************************
*78      W-MAX-DTE                               VALUE 40.
*01      W-DTE-TABLE.
*        03      W-DTE-CNT                       PIC 9(02).
*        03      W-DTE-TAB       OCCURS  W-MAX-DTE TIMES
*                                INDEXED BY W-DTE-INDEX.
*>              申報年月
*                05      W-DTE-YM                PIC 9(05).
*>              Y->鎖檔
*                05      W-DTE-LOCK              PIC X(01).
*01      W-CHK-DTE-YM                            PIC 9(05).
*>      處方日期
 01      W-CHK-DTE-YMD                           PIC 9(07).
*>      是否檢查整帳鎖檔(NID-1029)
 01      W-CHK-1029-YN                           PIC X.
*>      判斷整帳鎖檔副程式之LNK(CALL FROM HILOCKCF)
 01      W-LNK-LOCKCF.
*>              功能識別；01.讀取NID-1000是否判斷整帳鎖檔參數
*>                        02.判別整帳鎖檔與申報鎖檔否
*>                        03.只判別申報鎖檔否
        02      W-LOCKCF-ID             PIC X(2).
*>              處方日期
        02      W-LOCKCF-DT             PIC 9(7).
*>              NID-1000是否判斷整帳鎖檔參數(W-LOCKCF-ID = "01")
        02      W-LOCKCF-CHK-YN         PIC X.
*>              是否鎖檔('Y'鎖檔)
        02      W-LOCKCF-YN             PIC X.
*>              傳回訊息(W-LOCKCF-YN = "Y")
        02      W-LOCKCF-NOTE           PIC X(60).
*>              預留
        02      W-LOCKCF-FILLER         PIC X(50).
*******************************************************************************
*       END     OF      FILE
*******************************************************************************
*COPY    "HI_ICA.WRK".
*> ***************************************************************************
*>      C-PY FILE : HI_ICA.WRK                  used by HIOD2MF, HIOD3DF
*>                                                      HISINBF
*>      ICA-MST WORKING

*> ***************************************************************************
 01      W-ICA-TMP-MST-REC.
*> KEY 值 = 住院序號+處方序號
        10 W-ICA-TMP-KEY.
*> 住院序號(由住院申請作業產生,為病人住院唯一序號)
*$XFD USE GROUP
           20 W-ICA-TMP-IPD-NO.
              30 W-ICA-TMP-IPD-DATE           PIC 9(7).
              30 W-ICA-TMP-IPD-SEQ            PIC 9(4).
*> 處方序號(處方日期+處方流水號)
*$XFD USE GROUP
           20 W-ICA-TMP-ODR-NO.
*> 處方日期(下處方之日期,DEFAULT 為系統日,為可修改之欄位=>因為可能補打)
              30 W-ICA-TMP-INS-DATE           PIC 9(7).
*> 處方流水號(為第幾張之處方)
              30 W-ICA-TMP-ODR-SEQ            PIC 9(4).
*$XFD USE GROUP,VAR-LENGTH
        10 W-ICA-TMP-GROUP-DATA1.
*> 結帳序號(此筆處方須歸類到那一筆結帳序號)             (1, 3)
                20 W-ICA-TMP-SEG-SEQ                  PIC 9(3).
*> 處方科別代碼                                         (4, 4)
                20 W-ICA-TMP-DEPT-NO                  PIC X(4).
*> 處方醫師代碼                                         (8, 4)
                20 W-ICA-TMP-DR-NO                    PIC X(4).
*> 處方身份代碼                                         (12, 4)
                20 W-ICA-TMP-IDNT-NO                  PIC X(4).
*> 處方參考身份                                         (16, 4)
                20 W-ICA-TMP-IDNT-REF                 PIC X(4).
*> 處方床號                                             (20, 6)
                20 W-ICA-TMP-WARD.
                        30 W-ICA-TMP-BED-ROOM         PIC X(4).
                        30 W-ICA-TMP-BED-NO           PIC X(2).
*> 手術種類                                             (26, 1)
                20 W-ICA-TMP-SERG-KND                 PIC X.
*> 手術代碼(取消不用)                                   (27, 7)
                20 W-ICA-TMP-SERG-NO                  PIC X(7).
*> 891009 SMSTL UPDATE :
                20 W-ICA-TMP-SERG-NO1 REDEFINES W-ICA-TMP-SERG-NO.
*> 處方時間(住院醫令使用)                               (27, 4)
                        30 W-ICA-TMP-ODR-TIME         PIC 9(4).
*> 預留                                                 (31, 3)
                        30 W-ICA-TMP-SERG-FILLER      PIC X(3).
*> 附刀一                                               (34, 4)
                20 W-ICA-TMP-OP1                      PIC X(4).
*> 附刀二                                               (38, 4)
                20 W-ICA-TMP-OP2                      PIC X(4).
*> 附刀三                                               (42, 4)
                20 W-ICA-TMP-OP3                      PIC X(4).
*> 最大用藥天數                                         (46, 3)
                20 W-ICA-TMP-RX-DAYS                  PIC 9(3).
*> 最大序號(列印) ==> 藥品部份 ...                      (49, 3)
                20 W-ICA-TMP-MAX-SEQ                  PIC 9(3).
*> 藥袋號碼                                             (52, 4)
                20 W-ICA-TMP-PILL-NO                  PIC 9(4).
*> 應收總額                                             (56, 9)
                20 W-ICA-TMP-NOM-AMT                  PIC S9(7)V9(2).
*> 優免金額                                             (65, 9)

                20 W-ICA-TMP-DIS-AMT                  PIC S9(7)V9(2).
*> 部份負擔金額                                         (74, 9)
                20 W-ICA-TMP-PART-AMT                 PIC S9(7)V9(2).
*> 自付金額                                             (83, 9)
                20 W-ICA-TMP-SP-AMT                   PIC S9(7)V9(2).
*> 申報金額                                             (92, 9)
                20 W-ICA-TMP-APP-AMT                  PIC S9(7)V9(2).
*> 參考身份申報金額                                     (101, 9)
                20 W-ICA-TMP-REF-AMT                  PIC S9(7)V9(2).
*> 已收金額                                             (110, 9)
                20 W-ICA-TMP-RCV-AMT                  PIC S9(7)V9(2).
*> 處方登錄者代號  X(4) ==> X(5)                        (119, 5)
                20 W-ICA-TMP-USR-ID                   PIC X(5).
*> 處方時間                                             (124, 4)
                20 W-ICA-TMP-INS-TIME                 PIC 9(4).
                20 W-ICA-TMP-UDP-DATA.
*> 處方異動人代號  X(4) ==> X(5)                        (128, 5)
                        30 W-ICA-TMP-UPD-USR-ID       PIC X(5).
*> 處方異動日期                                         (133, 7)
                        30 W-ICA-TMP-UPD-DATE         PIC 9(7).
*> 處方異動時間                                         (140, 4)
                        30 W-ICA-TMP-UPD-TIME         PIC 9(4).
*> 處方異動碼                                           (144, 1)
                        30 W-ICA-TMP-UPD-MARK         PIC X.
*> 發藥單位                                             (145, 4)
                20 W-ICA-TMP-PILL-DEPT                PIC X(4).
*> 床位等級                                             (149, 2)
                20 W-ICA-TMP-CLASS                    PIC X(2).
*> 處方註記       A, a->固定費用, B->首日量, C->緊急檢驗, F->伙食, G->長期照護,
*>                O->門診轉住院, U->UD, H->呼吸照護     (151, 1)
                20 W-ICA-TMP-UD-MARK                  PIC X.
*> 超等病房( Y - 超等付費 )                             (152, 1)
*               20 W-ICA-TMP-EXT-SERV                 PIC X.
*> 890828 取消W-ICA-TMP-EXT-SERV, 改為【是否為補登】(住院醫令使用)
                20 W-ICA-TMP-RMK-YN                   PIC X.
*> 病房類別(Y-急性病房, N-慢性病房)                     (153, 1)
                20 W-ICA-TMP-BED-ID                   PIC X.
*> 累積天數(84.09.20)                                   (154, 3)
                20 W-ICA-TMP-COM-DAYS                 PIC 9(3).
*> 部份負擔代碼(000:應部份負擔,001,002,003,004,005:免部份負擔,111:自費)
*>             B01:其他機關 ...                         (157, 3)
                20 W-ICA-TMP-IPD-PART                 PIC X(3).
*> 負擔%(因為住院是一段區間,可能某期間需要部份負擔,某期間不需部份負擔)
*>        ( 0:免部份負擔, 1:急性病房部份負擔 10%, 2:急性病房 20%, 3:急性
*>            病房 30%, 4:慢性病房 5%, 5:慢性病房 10%, 6:慢性病房 20%,
*>          7:慢性病房 30%  A:自費 100%  B:其他機關 100%        (160, 1)
                20 W-ICA-TMP-RESPOND                  PIC X.
*> 緊急處方( Y - On line 列印,N - Batch 列印 S:強制住院)        (161, 1)
                20 W-ICA-TMP-EMG-CD                   PIC X.
*> 優免項次(單一處方箋中共有幾項需優免打折之檢驗項次)           (162, 3)
                20 W-ICA-TMP-LB-CNT                   PIC 9(3).
*> 優免項次申報金額( UPDATE 84.09.29)                           (165, 9)
                20 W-ICA-TMP-LB-APP-AMT               PIC 9(7)V9(2).
*> [T] 過帳資料 [D] 刪除備註                                    (174, 1)
                20 W-ICA-TMP-DEL-MARK                 PIC X.
*> 保留欄位
                20 W-ICA-TMP-FILLER                   PIC X(76).

                20 W-ICA-TMP-REF-DATA         REDEFINES W-ICA-TMP-FILLER.
*>                                                              (175, 9)
                   30 W-ICA-TMP-LB-PART-AMT           PIC S9(7)V9(2).
*> Y-> 為 ICU 病床                                              (184, 1)
                   30 W-ICA-TMP-BED-ICU               PIC X.
*> 備註 [ ]一般用藥 [1]帶藥 [2]退藥 [3]常規用藥                 (185, 1)
                   30 W-ICA-TMP-PR-MRK                PIC X.
*> 轉檢 MARK ....                                               (186, 1)
                   30 W-ICA-TMP-CD00-MARK             PIC X.
*> 慢性部份負擔金額                                             (187, 8)
                   30 W-ICA-TMP-SLOW-PART-DEF         PIC X(8).
                   30 W-ICA-TMP-SLOW-PART REDEFINES  W-ICA-TMP-SLOW-PART-DEF  PIC S9(6)V99.
*> 急性部份負擔金額                                             (195, 8)
                   30 W-ICA-TMP-QUICK-PART-DEF        PIC X(8).
                   30 W-ICA-TMP-QUICK-PART REDEFINES W-ICA-TMP-QUICK-PART-DEF PIC S9(6)V99.
*>                                                              (203, 3)
                   30 W-ICA-TMP-QUICK-DAYS-DEF        PIC X(3).
                   30 W-ICA-TMP-QUICK-DAYS REDEFINES W-ICA-TMP-QUICK-DAYS-DEF PIC 9(3).
*>                                                              (206, 3)
                   30 W-ICA-TMP-SLOW-DAYS-DEF         PIC X(3).
                   30 W-ICA-TMP-SLOW-DAYS REDEFINES W-ICA-TMP-SLOW-DAYS-DEF   PIC 9(3).
*> 結帳異動日期                                                 (209, 7)
                   30 W-ICA-TMP-SEG-DATE              PIC 9(7).
*> 結帳異動時間                                                 (216, 4)
                   30 W-ICA-TMP-SEG-TIME              PIC 9(4).
*> 定期結帳編號                                                 (220, 3)
                   30 W-ICA-TMP-SEG-NO                PIC 9(3).
*> 處方建檔日                                                   (223, 7)
                   30 W-ICA-TMP-CRE-DT                PIC 9(7).
*> 出院批價申報修改者                                           (230, 5)
                   30 W-ICA-TMP-APY-USR               PIC X(5).
*> 醫令識別 Y->醫令系統產生之處方                               (235, 1)
                   30 W-ICA-TMP-DR-YN                 PIC X(01).
*> Y->處方明細含即時報備重要醫令 890630 增加                    (236, 1)
                   30 W-ICA-TMP-ANN-YN                PIC X(01).
*> １ 庫房別預設先帶門診庫房; ２ 庫房別預設先帶門診庫房;        (237, 1)
                   30 W-ICA-TMP-OPD-YN                PIC X(01).
*> Y->表示需展開對應處方(讀ICR-SON)                             (238, 1)
                   30 W-ICA-TMP-EXP-YN                PIC X(01).
*> 舊領藥號                                                     (239, 4)
*> 欲使用此欄位時, 請先判別是否為NUMERIC, 否則會有NON-NUMERIC 之問題
                   30 W-ICA-TMP-OLD-PILL-NO             PIC 9(04).
                   30 W-ICA-TMP-FILLER1               PIC X(08).

*> ***************************************************************************
*>      END     OF      FILE
*> ***************************************************************************
*COPY    "HI_ICB.WRK".
*******************************************************************************
*       C-PY FILE :     HI_ICB.WRK      USED BY : HIOD1KF, HIOD2MF, HIOD3DF
*  870707  增加 W-OWN-DATE, W-OWN-OLD-UPC
*  890317  增加INDEX BY W-ICB-INDEX.
*******************************************************************************
 01 W-WS-TMP-REC.
   02 WS-TMP-REC        OCCURS 97  TIMES
                        INDEXED BY W-ICB-INDEX.
        04 WS-MST-REC.

           06 WS-KEY.
              08 WS-IPD-NO.
                 30 WS-IPD-DATE                 PIC 9(7).
                 30 WS-IPD-SEQ                  PIC 9(4).
              08 WS-ODR-NO.
                 30 WS-INS-DATE                 PIC 9(7).
                 30 WS-ODR-SEQ                  PIC 9(4).
              08 WS-FEE-SEQ                     PIC 9(3).
           06 WS-FEE-KEY                        PIC X(9).
           06 WS-STD-FNO                        PIC X(3).
           06 WS-FEE-DEPT                       PIC X(5).
           06 WS-STO-DEPT                       PIC X(4).
           06 WS-RX-QTY.
              08 WS-RX-QTY1                     PIC 9(4).
              08 WS-RX-QTY2                     PIC 9(2).
           06 WS-RX-UQTY.
              08 WS-RX-UQTY1                    PIC 9(2).
              08 WS-RX-UQTY2                    PIC 9(2).
           06 WS-UNIT                           PIC X(6).
* 880626 增加
           06 WS-NEW-UQTY1 REDEFINES WS-UNIT    PIC 9(6).
           06 WS-RX-UNIT                        PIC X(6).
* 880626 增加
           06 WS-NEW-UQTY2 REDEFINES WS-RX-UNIT PIC 9(6).
*>         改成小兒兩段加成( A: < 2 歲 30%,B: 2-6 歲 20%, N 不加成)(930701生效)
           06 WS-BBY-RANK                       PIC X.
           06 WS-PAY-RANK                       PIC X.
           06 WS-PRICE                          PIC 9(6)V9(2).
           06 WS-RX-WAY.
              08 WS-RX-WAY1                     PIC X(2).
              08 WS-RX-WAY2                     PIC X(2).
           06 WS-POWDER                         PIC X.
           06 WS-RX-DAYS                        PIC 9(2).
           06 WS-CHG-FLAG                       PIC X.
           06 WS-ASU-PAY                        PIC X.
           06 WS-DG-FLAG                        PIC X(3).
           06 WS-NOM-AMT                        PIC S9(7)V9(2).
           06 WS-DIS-AMT                        PIC S9(7)V9(2).
           06 WS-PART-AMT                       PIC S9(7)V9(2).
           06 WS-RE-AMT1                        PIC S9(7)V9(2).
           06 WS-RE-AMT2                        PIC S9(7)V9(2).
           06 WS-RE-AMT3                        PIC S9(7)V9(2).
           06 WS-SP-AMT                         PIC S9(7)V9(2).
           06 WS-APP-AMT                        PIC S9(7)V9(2).
           06 WS-REF-AMT                        PIC S9(7)V9(2).
           06 WS-LB-DIS                         PIC X.
           06 WS-OP-BDATE.
              08 WS-OP-BD-YY                    PIC 9(3).
              08 WS-OP-BD-MM                    PIC 9(2).
              08 WS-OP-BD-DT                    PIC 9(2).
           06 WS-OP-BTIME.
              08 WS-OP-BT-HH                    PIC 9(2).
              08 WS-OP-BT-MM                    PIC 9(2).
           06 WS-OP-EDATE.
              08 WS-OP-ED-YY                    PIC 9(3).
              08 WS-OP-ED-MM                    PIC 9(2).
              08 WS-OP-ED-DT                    PIC 9(2).

           06 WS-OP-ETIME.
              08 WS-OP-ET-HH                    PIC 9(2).
              08 WS-OP-ET-MM                    PIC 9(2).
           06 WS-DEL-MARK                       PIC X.
           06 WS-RTN-QTY.
              08 WS-RTN-QTY1                    PIC 9(4).
              08 WS-RTN-QTY2                    PIC 9(2).
*06 WS-OP-COUNTER.
           06 WS-OPP-ID                      PIC X(1).
           06 WS-II-OP-COUNTER               PIC 9(2).
           06 WS-INS-CHG                     PIC 9(6)V99.
           06 WS-PRS-ADD                     PIC X.
           06 WS-FILLER                      PIC X(71).
           06 WS-ANT-DATA  REDEFINES WS-FILLER.
                        10 WS-ANT-YN           PIC X.
                        10 WS-STL-YN           PIC X.
**處置類別(PRS-FEE-KND)=C.檢驗 D.檢查 E.Ｘ光
                        10 WS-PAS-DATA.
                           15   WS-PAS-FRONT.
**檢驗檢查科室(PRS-PAS-DPT)
                                20 WS-PAS-DPT  PIC X(1).
**單據類別(PRS-PAS-TAB)
                                20 WS-PAS-TAB  PIC X(2).
**傳送對象(PRS-PAS-RCV),A>檢驗檢查,B>部位檢查,C>細菌檢驗,D>血庫檢驗
                                20 WS-PAS-RCV  PIC X(1).
**檢驗檢查細項代碼(PRS-PAS-ITM)
                                20 WS-PAS-ITM  PIC X(6).
**處置細項對映項次(PRS-PAS-SEQ)
                                20 WS-PAS-SEQ  PIC 9(1).
                           15   WS-PAS-BACK.
**檢驗檢查單號(HTCHK-CHK-NO)
                                20 WS-CHK-NO.
**檢驗檢查類別代號(HTCHK-CLS-NO)
                                   25 WS-CLS-NO PIC X(3).
**開單流水碼(HTCHK-PR-SEQ)
                                   25 WS-PR-SEQ PIC 9(5).
**檢驗檢查項目代碼(HTCHK-ITM-CD)
                                20 WS-ITM-CD   PIC X(6).
                        10 WS-PER-RATE         PIC X(3).
* 單一劑量處方 [開始日]
                        10 WS-UD-BDT           PIC 9(07).
* 單一劑量處方 [開始別]
                        10 WS-UD-BMTH          PIC X(01).
* 單一劑量處方 [結束日]
                        10 WS-UD-EDT           PIC 9(07).
* 單一劑量處方 [結束別]
                        10 WS-UD-EMTH          PIC X(01).
                        10 WS-TST-SMP          PIC X(01).
                        10 WS-PAS-WAY          PIC X(01).
                        10 WS-RTB-ODR          PIC 9(10).
                        10 WS-RTB-SEQ          PIC 9(3).
                        10 WS-RTB-MRK          PIC X(01).
* 容器
                        10 WS-PAS-BTL          PIC X(1).
**檢驗檢查組合/備註項目 Y:呼叫 HTODRICF
                        10 WS-PAS-RMK          PIC X(1).
*87/07/28增加:

*起迄日期&時間不合併(費用清單)
                        10 WS-SEP-ID           PIC X(1).
                        10 WS-SP-YN            PIC X(1).
*強制自費(Y)
                        10 WS-FILLER1          PIC X(5).
**********
 01      W-MST-REC               IS EXTERNAL.
        10 W-KEY.
           20 W-IPD-NO.
              30 W-IPD-DATE             PIC 9(7).
              30 W-IPD-SEQ              PIC 9(4).
           20 W-ODR-NO.
              30 W-INS-DATE             PIC 9(7).
              30 W-ODR-SEQ              PIC 9(4).
           20 W-FEE-SEQ                 PIC 9(3).
        10 W-FEE-KEY                    PIC X(9).
        10 W-STD-FNO                    PIC X(3).
        10 W-FEE-DEPT                   PIC X(5).
        10 W-STO-DEPT                   PIC X(4).
        10 W-RX-QTY.
           20 W-RX-QTY1                 PIC 9(4).
           20 W-RX-QTY2                 PIC 9(2).
        10 W-RX-UQTY.
           20 W-RX-UQTY1                PIC 9(2).
           20 W-RX-UQTY2                PIC 9(2).
        10 W-UNIT                       PIC X(6).
        10 W-NEW-UQTY1 REDEFINES W-UNIT PIC 9(6).
        10 W-RX-UNIT1                   PIC X(6).
        10 W-NEW-UQTY2 REDEFINES W-RX-UNIT1 PIC 9(6).
*>      改成小兒兩段加成( A: < 2 歲 30%,B: 2-6 歲 20%, N 不加成)(930701生效)
        10 W-BBY-RANK                   PIC X.
        10 W-PAY-RANK                   PIC X.
        10 W-PRICE                      PIC 9(6)V9(2).
        10 W-RX-WAY.
           20 W-RX-WAY1                 PIC X(2).
           20 W-RX-WAY2                 PIC X(2).
        10 W-POWDER                     PIC X.
        10 W-RX-DAYS                    PIC 9(2).
        10 W-CHG-FLAG                   PIC X.
        10 W-ASU-PAY                    PIC X.
        10 W-DG-FLAG                    PIC X(3).
        10 W-NOM-AMT                    PIC S9(7)V9(2).
        10 W-DIS-AMT                    PIC S9(7)V9(2).
        10 W-PART-AMT                   PIC S9(7)V9(2).
        10 W-RE-AMT1                    PIC S9(7)V9(2).
        10 W-RE-AMT2                    PIC S9(7)V9(2).
        10 W-RE-AMT3                    PIC S9(7)V9(2).
        10 W-SP-AMT                     PIC S9(7)V9(2).
        10 W-APP-AMT                    PIC S9(7)V9(2).
        10 W-REF-AMT                    PIC S9(7)V9(2).
        10 W-LB-DIS                     PIC X.
        10 W-OP-BDATE.
           20 W-OP-BD-YY                PIC 9(3).
           20 W-OP-BD-MM                PIC 9(2).
           20 W-OP-BD-DT                PIC 9(2).
        10 W-OP-BTIME.
           20 W-OP-BT-HH                PIC 9(2).

           20 W-OP-BT-MM                PIC 9(2).
        10 W-OP-EDATE.
           20 W-OP-ED-YY                PIC 9(3).
           20 W-OP-ED-MM                PIC 9(2).
           20 W-OP-ED-DT                PIC 9(2).
        10 W-OP-ETIME.
           20 W-OP-ET-HH                PIC 9(2).
           20 W-OP-ET-MM                PIC 9(2).
        10 W-DEL-MARK                   PIC X.
        10 W-RTN-QTY.
           20 W-RTN-QTY1                PIC 9(4).
           20 W-RTN-QTY2                PIC 9(2).
*10 W-OP-COUNTER.
        10 W-OPP-ID                     PIC X(1).
*>      手術刀數
        10 W-II-OP-COUNTER              PIC 9(2).
        10 W-INS-CHG                    PIC 9(6)V99.
        10 W-PRS-ADD                    PIC X.
        10 W-FILLER                     PIC X(71).
        10 W-ANT-DATA  REDEFINES W-FILLER.
                        20 W-ANT-YN           PIC X.
                        20 W-STL-YN           PIC X.
**處置類別(PRS-FEE-KND)=C.檢驗 D.檢查 E.Ｘ光
                        20 W-PAS-DATA.
                           25   W-PAS-FRONT.
**檢驗檢查科室(PRS-PAS-DPT)
                                30 W-PAS-DPT    PIC X(1).
**單據類別(PRS-PAS-TAB)
                                30 W-PAS-TAB    PIC X(2).
**傳送對象(PRS-PAS-RCV),A>檢驗檢查,B>部位檢查,C>細菌檢驗,D>血庫檢驗
                                30 W-PAS-RCV    PIC X(1).
**檢驗檢查細項代碼(PRS-PAS-ITM)
                                30 W-PAS-ITM    PIC X(6).
**處置細項對映項次(PRS-PAS-SEQ)
                                30 W-PAS-SEQ    PIC 9(1).
                           25   W-PAS-BACK.
**檢驗檢查單號(HTCHK-CHK-NO)
                                30 W-CHK-NO.
**檢驗檢查類別代號(HTCHK-CLS-NO)
                                   35 W-CLS-NO PIC X(3).
**開單流水碼(HTCHK-PR-SEQ)
                                   35 W-PR-SEQ PIC 9(5).
**檢驗檢查項目代碼(HTCHK-ITM-CD)
                                30 W-ITM-CD     PIC X(6).
                        20 W-PER-RATE           PIC X(3).
* 單一劑量處方 [開始日]
                        20 W-UD-BDT             PIC 9(07).
* 單一劑量處方 [開始別]
                        20 W-UD-BMTH            PIC X(01).
* 單一劑量處方 [結束日]
                        20 W-UD-EDT             PIC 9(07).
* 單一劑量處方 [結束別]
                        20 W-UD-EMTH            PIC X(01).
                        20 W-TST-SMP            PIC X(01).
                        20 W-PAS-WAY            PIC X(01).
                        20 W-RTB-ODR            PIC 9(10).
                        20 W-RTB-SEQ            PIC 9(3).

                        20 W-RTB-MRK            PIC X(01).
* 容器
                        20 W-PAS-BTL            PIC X(1).
**檢驗檢查組合/備註項目 Y:呼叫 HTODRICF
                        20 W-PAS-RMK            PIC X(1).
*87/07/28增加:
*起迄日期&時間不合併(費用清單)
                        20 W-SEP-ID             PIC X(1).
*強制自費(Y)
                        20 W-SP-YN              PIC X(1).
                        20 W-FILLER1            PIC X(5).
*-------------------------------------------------------------------------------
*>      自費單價生效日(870706)
 01      W-OWN-DATE                              PIC 9(07).
*>      自費舊單價
 01      W-OWN-OLD-UPC                           PIC 9(06)V9(2).
*>      健保差額生效日(890712)
 01      W-DIF-DATE                              PIC 9(07).
*>      健保舊差額
 01      W-DIF-OLD-UPC                           PIC 9(06)V9(2).
*******************************************************************************
*       END     OF      FILE
*******************************************************************************
*COPY    "HI_ECB.WRK".
*******************************************************************************
*>      C-PY FILE :     HI_ECB.WRK
*>      USED BY : 住院收費-
*>                住院醫令(GUI)-HRCAECF/HRCFMKF/HRMETCF/HRODAKF/HRODC2KF/HRCAEBF
*>      890524 增加 腦部手術麻醉加成
*>      890622 增加重要醫令報備
*>      900219 增加會診科別
*>      900604 增加手術年齡加成
*>      900721 增加實作治療師代碼(ECB-THE-NO)
*>      900927 增加WS-UDL-FEE-SEQ
*>      910131 增加改門診申報之註記(STL)
*>      910312 增加給藥餐數(首日量磨粉專用)(醫令)       (JAY)
*>      910312 增加麻醉細項(不可異動識別碼)             (JAY)
*>      940412 增加申報補登識別                         (TCC)
*>      950918 增加依處置設定輸入部位欄位               (TCC)
*> 2006/10/31 增加UDL起迄時間(UD真正的,不含首日量之時間,為配合旭仁藥包機新格式)
*> 97/04/25 Frank-台大雲林-增加化療針劑備註說明(ECB-CANCER-REMARK)
*> 97/05/07 Frank-增加特殊加成
*> 97/10/10 Frank-優免定義新增欄位
*> 98/07/09 Frank-增加替代處置
*> 98/07/29 Frank-增加疫苗種類、疫苗批號
*> 98/07/29 Frank-增加醫令預開處置
*> 98/09/22 Frank-增加台中RFID化療針劑用藥起迄日期
*> 98/12/19 Frank-增加台大雲林檢體取樣註記
*> 98/12/24 Frank-增加疫苗上傳註記
*> 99/07/13 Frank-增加健保特殊折扣組別
*> 2011/2/8  增加健保折扣率 - 向榮
*> 2011/2/19 增加連帶項是否列入PPF計算
*> 2011/3/18 (J1100431)4歲. 科別加成 - 向榮
*> 2011/4/8  桃醫座談會, 增加屬於CHEMO用藥欄位 - 向榮
*> 2011/6/21 增加CHEMO相關欄位 - 向榮
*> 2012/3/19 (J1200483)媒體改版, 增加執行人員. 影像來源欄位 - 向榮
*> 2012/6/13 (J1201066)新增是否為清淨手術前(中)抗生素醫令 - 昱志

*> 2012/6/25 (J1201098)新增執行日期時間、執行人員寫入識別 - 昱志
*> 2012/8/24 (J1201217)新增20碼疫苗批號 - 昱志
*> 2013/1/10 (J1201966)自費特材替代群組 - 昱志
*> 2013/8/30 (J1301047)新增20碼疫苗種類 - 昱志
*> 2014/4/18 (J1400397)新增預定用血日期、預定用血時間 - 王婕
*> 2015/11/14 (J1500842)全日平均護病比加成3.5% - 淑儀
*> 2015/11/30 聖母－新增次劑量 - 淑儀
*> 2017/01/09 醫管會-未列項 - 瑋育
*> 2017/11/06 醫管會-C肝用藥開立審核 - 瑋育
*> 2019/01/22 增加代檢醫事機構代碼 - 瑋育
*> 2021/12/27 年齡計算至年月日
*******************************************************************************
 01      W-WS-ECB-REC.
   02   WS-ECB-REC      OCCURS 97  TIMES.
* KEY 值 = 住院序號+處方序號+處置流水號
        10      WS-ECB-KEY.
* 住院序號
*$XFD USE GROUP
           20   WS-ECB-IPD-NO.
                30      WS-ECB-IPD-DATE                 PIC 9(7).
                30      WS-ECB-IPD-SEQ                  PIC 9(4).
* 處方序號
*$XFD USE GROUP
           20   WS-ECB-ODR-NO.
* 處方日期
                30      WS-ECB-INS-DATE                 PIC 9(7).
* 處方流水號
                30      WS-ECB-ODR-SEQ                  PIC 9(4).
* 處置流水號
           20   WS-ECB-FEE-SEQ                          PIC 9(3).
*>
* 刪除MARK
        10      WS-ECB-DEL-MARK                         PIC X(1).
* 處置代碼
        10      WS-ECB-FEE-KEY                          PIC X(9).
* 檔案序號
        10      WS-ECB-FILE-NO                          PIC 9(3).
* 類別 1:藥品,  2:檢驗檢查放射線 3:F 處置類(890525 增加)
        10      WS-ECB-TYPE                             PIC X(1).
* 處方序號倒序
*$XFD USE GROUP
        10      WS-ECB-ODR-NO-V.
                30      WS-ECB-INS-DATE-V               PIC 9(7).
                30      WS-ECB-ODR-SEQ-V                PIC 9(4).
*> 備用key 1
        10      WS-ECB-ALT1                             PIC X(50).
*> 備用key 2
        10      WS-ECB-ALT2                             PIC X(50).
*>
*$XFD USE GROUP
        10      WS-ECB-GROUP-DATA1                      PIC X(250).
        10      WS-ECB-GROUP-DATA11 REDEFINES WS-ECB-GROUP-DATA1.
*> 備註
                30      WS-ECB-REMARK                   PIC X(50).
*> Y-> 腦部麻醉加成
                30      WS-ECB-BRAIN-YN                 PIC X(01).
*> 腦部手術之麻醉加成

                30      WS-ECB-BRAIN-RATE               PIC 9(03).
*> 連帶指標父項(*)
                30      WS-ECB-LNK-POINT-HEAD           PIC X(01).
*> 連帶指標項次
                30      WS-ECB-LNK-POINT                PIC X(09).
*> 連帶指標展開時間
                30      WS-ECB-LNK-TIME.
                        40      WS-ECB-LNK-HH           PIC 9(02).
                        40      WS-ECB-LNK-MM           PIC 9(02).
                        40      WS-ECB-LNK-SS           PIC 9(02).
*> Y-> 重要醫令報備     890622 INSERT
                30      WS-ECB-ANN-YN                   PIC X(01).
*> 庫房對照碼           890629 INSERT
                30      WS-ECB-STK-CNT                  PIC X(13).
*> 開單醫師
                30      WS-ECB-APY-DR                   PIC X(04).
*> 實作醫師１
                30      WS-ECB-OPR-DR1                  PIC X(04).
*> 實作醫師２
                30      WS-ECB-OPR-DR2                  PIC X(04).
*> 報告醫師
                30      WS-ECB-RPT-DR                   PIC X(04).
*> 會診科別
                30      WS-ECB-DEPT-NO                  PIC X(04).
*> 手術年齡加成('1'->0-0.5, 'A'->0.5-2, 'B'->2-6)
*> 改成小兒三段加成('1'->0-0.5, 'A'->0.5-2, 'B'->2-6)(930701生效)
                30      WS-ECB-OPP-RANK                 PIC X(01).
*> 手術年齡加成百分比
*> 改成小兒三段加成百分比(930701生效)
                30      WS-ECB-OPP-RATE                 PIC 9(03).
*> 實作治療師                900721 INSERT
                30      WS-ECB-THE-NO                   PIC X(05).
*> UDL 處置序號
                30      WS-ECB-UDL-FEE-SEQ              PIC 9(03).
*> 檢驗開立未執行('Y'未執行、餘執行)(901007)
                30      WS-ECB-HT-UNDO                  PIC X(01).
*> Y-> 改為門診申報(910131)
                30      WS-ECB-OPD-APY                  PIC X(01).
*> 給藥餐數(首日量磨粉專用)(醫令)(910312)
                30      WS-ECB-MED-PACKET               PIC 9(04).
*> 麻醉細項(不可異動識別碼)(910312)
                30      WS-ECB-LNK-SON                  PIC X(01).
*> 氣喘0-6加成(930210)
                30      WS-ECB-PANT-YN                  PIC X(01).
*> 責任加成(930617)
                30      WS-ECB-DUTY-YN                  PIC X(01).
*> 急診夜間假日加成(930617)
                30      WS-ECB-NIGHT-YN                 PIC X(01).
*> 處置特殊識別(比對處置代碼)(D.子宮頸)(930820)
                30      WS-ECB-SPEC-MARK                PIC X(01).
*> 事前審查項目(940105)
                30      WS-ECB-PRD-YN                   PIC X(01).
*> 增加申報補登識別
                30      WS-ECB-APY-MARK                 PIC X(01).
*> 應收額
                30      WS-ECB-NOM-AMT                  PIC S9(7)V9(2).
*> 優免額

                30      WS-ECB-DIS-AMT                  PIC S9(7)V9(2).
*> 自付額
                30      WS-ECB-SP-AMT                   PIC S9(7)V9(2).
*> 部份負擔額
                30      WS-ECB-PART-AMT                 PIC S9(7)V9(2).
*> 申報額
                30      WS-ECB-APP-AMT                  PIC S9(7)V9(2).
*> 0-4歲兒童齲齒加成(941114)
                30      WS-ECB-TEETH-YN                 PIC X(01).
*> 950918  增加依處置設定輸入部位欄位
                30      WS-ECB-LRB-FIELD                PIC X(01).
**> 2006/10/31 增加UDL起迄時間(UD真正的,不含首日量之時間,為配合旭仁藥包機新格式)
                30      WS-ECB-UDL-BDT                  PIC 9(7).
                30      WS-ECB-UDL-BTI                  PIC 9(2).
                30      WS-ECB-UDL-EDT                  PIC 9(7).
                30      WS-ECB-UDL-ETI                  PIC 9(2).
*> 970430 台大化療-增加醫令開立UDL實際時間
                30      WS-ECB-HRUDL-BTI                PIC 9(2).
                30      WS-ECB-HRUDL-ETI                PIC 9(2).
*> 97.10.07 手術折扣：健保不給付額(健保)
                30      WS-ECB-NHI-DIS-AMT              PIC S9(7)V9(2).
*> 97.10.07 手術折扣：其他金額(自費)
                30      WS-ECB-SP-DIS-AMT               PIC S9(7)V9(2).
*> 98/07/09 替代處置 (如A處置停用，替換為B處置，此欄位存A處置代碼)
                30      WS-ECB-REPLACE-FEE-KEY          PIC X(9).
*> 98/07/29 預防接種-疫苗種類
                30      WS-ECB-INJ-KIND                 PIC X(6).
*> 98/07/29 預防接種-疫苗批號
                30      WS-ECB-INJ-BATCH-NO             PIC X(12).
*> 98/07/29 醫令預開處置 (Y:預開處置)
                30      WS-ECB-HRPRN-YN                 PIC X(1).
*> 98/09/22 台中RFID自備藥識別 (K：自備藥)
                30      WS-ECB-SELF-DRUG                PIC X(1).
*> 98/12/19 台大雲林檢體取樣註記 (Y：已取樣)
                30      WS-ECB-HT-SAMPLE                PIC X(1).
*> 98/12/24 預防接種-疫苗上傳註記 (Y：已上傳)
                30      WS-ECB-INJ-ICS-YN               PIC X(1).
*> 99/07/13 健保特殊折扣組別 (NID-062A)
                30      WS-ECB-SPC-DIS-GRP              PIC X(2).
*> 2011/4/8 識別屬於CHEMO用藥 (C/T用藥識別) (Y: 該項屬於C/T用藥)
                30      WS-ECB-CHEMO-CT                 PIC X(1).
*$XFD USE GROUP
        10      WS-ECB-GROUP-DATA2                      PIC X(250).
        10      WS-ECB-GROUP-DATA21 REDEFINES WS-ECB-GROUP-DATA2.
*> 化療備註(97/04/25)
                30      WS-ECB-CANCER-REMARK            PIC X(80).
*> 特殊加成(97/05/07)
                30      WS-ECB-SPC-RATE                 PIC 9(3).
*> 98/09/22 台中RFID化療針劑用藥起始日期 (住醫寫入)
                30      WS-ECB-HRUDL-BDT                PIC 9(7).
*> 98/09/22 台中RFID化療針劑用藥結束日期 (住醫寫入)
                30      WS-ECB-HRUDL-EDT                PIC 9(7).
*> 98/09/22 台中RFID化療針劑劑量 (住醫寫入)
                30      WS-ECB-HRUDL-RX-QTY             PIC 9(6)V9(2).
*> 99/07/26 健保特殊折扣率
                30      WS-ECB-SPC-DIS-RATE             PIC 9(1)V9(2).
*> 2011/2/8 健保折扣率

                30      WS-ECB-NHI-DIS-RATE             PIC 9(3)V9(2).
*> 2011/2/19 連帶項是否列入PPF計算
                30      WS-ECB-PPF-YN                   PIC X(1).
*> 2011/3/18 4歲兒童門診診察費加成
                30      WS-ECB-DIAG-RANK                PIC X(1).
                30      WS-ECB-DIAG-RATE                PIC 9(3).
*> 2011/3/18 科別門診診察費加成
                30      WS-ECB-DPT-RANK                 PIC X(1).
                30      WS-ECB-DPT-RATE                 PIC 9(3).
*> 2011/6/21 CHEMO流水號
                30      WS-ECB-HYGUDL-SN-NO             PIC 9(4).
*> 2011/6/21 CHEMO識別 (C:送CHEMO, U:送UD, S:送護理站)
                30      WS-ECB-HYGUDL-CHEMO-ID          PIC X(1).
*> 2011/6/21 CHEMO序號
                30      WS-ECB-HYGUDL-SEQ-NO            PIC 9(2).
*> 2012/3/19 執行人員
                30      WS-ECB-EXECUTE-USR              PIC X(5).
*> 2012/3/19 影像來源
                30      WS-ECB-IMAGE-SW                 PIC X(1).
*> 2012/6/13 是否為清淨手術前(中)抗生素醫令(Y:是 , 空白:否)
                30      WS-ECB-CLEAN-OPP-ANT-YN         PIC X(1).
*> 2012/6/25 執行日期時間、執行人員寫入識別
*>           (1.批價  2.補登  3.檢驗  4.手術  5.轉介)
                30      WS-ECB-OP-DATE-USR-ID           PIC X(1).
*> 2012/8/24 20碼疫苗批號
                30      WS-ECB-NEW-INJ-BATCH-NO         PIC X(20).
*> 2013/1/10 自費特材替代群組
                30      WS-ECB-REPLACE-GROUP            PIC X(03).
*> 2013/8/30 20碼疫苗種類
                30      WS-ECB-NEW-INJ-KIND             PIC X(20).
*> 2014/4/18 預定用血日期(血庫)
                30      WS-BLOOD-DATE                   PIC 9(07).
*> 2014/4/18 預定用血時間(血庫)
                30      WS-BLOOD-TIME                   PIC 9(04).
*> 2015/11/14 全日平均護病比加成3.5%
                30      WS-ECB-PER-RATE                 PIC 9(05).
*> 2015/11/30 聖母-新增次劑量
                30      WS-ECB-RX-N-UQTY.
                        40      WS-ECB-RX-N-UQTY1       PIC 9(05).
                        40      WS-ECB-RX-N-UQTY2       PIC 9(05).
*> 2017/01/09 醫管會-未列項
*>              未列項註記
                30      WS-ECB-NLI-MARK                 PIC X(01).
*>              未列項健保代碼
                30      WS-ECB-NLI-INS-ID               PIC X(16).
*>              未列項健保代碼流水號
                30      WS-ECB-NSI-INS-ID-SEQ           PIC 9(02).
*> 2017/11/06 醫管會-C肝用藥開立審核
*>              C肝用藥申請日期
                30      WS-ECB-CHE-STR-DATE             PIC 9(07).
*> 2017/11/09 加成數3碼改6碼
*>              新加成數
                30      WS-ECB-PER-RATE-NEW             PIC 9(05).
*> 2019/01/22 增加代檢醫事機構代碼
                30      WS-ECB-INSPECT-HOSP-ID          PIC X(10).
*>      2020/07/24 健保規範「直線加速器放射診療項目」之「診療之部位」改為2長
                30      WS-ECB-LRB-FIELD-NEW    PIC X(02).

                30      WS-ECB-FILLER2                  PIC X(01).

*> END
*> ---------------------------------------------------------------------------
*
 01      W-ECB-REC.
* KEY 值 = 住院序號+處方序號+處置流水號
        10      W-ECB-KEY.
* 住院序號
*$XFD USE GROUP
           20   W-ECB-IPD-NO.
                30      W-ECB-IPD-DATE                  PIC 9(7).
                30      W-ECB-IPD-SEQ                   PIC 9(4).
* 處方序號
*$XFD USE GROUP
           20   W-ECB-ODR-NO.
* 處方日期
                30      W-ECB-INS-DATE                  PIC 9(7).
* 處方流水號
                30      W-ECB-ODR-SEQ                   PIC 9(4).
* 處置流水號
           20   W-ECB-FEE-SEQ                           PIC 9(3).
*>
* 刪除MARK
        10      W-ECB-DEL-MARK                          PIC X(1).
* 處置代碼
        10      W-ECB-FEE-KEY                           PIC X(9).
* 檔案序號
        10      W-ECB-FILE-NO                           PIC 9(3).
* 類別 1:藥品,  2:檢驗檢查放射線
        10      W-ECB-TYPE                              PIC X(1).
* 處方序號倒序
*$XFD USE GROUP
        10      W-ECB-ODR-NO-V.
                30      W-ECB-INS-DATE-V                PIC 9(7).
                30      W-ECB-ODR-SEQ-V                 PIC 9(4).
*> 備用key 1
        10      W-ECB-ALT1                              PIC X(50).
*> 備用key 2
        10      W-ECB-ALT2                              PIC X(50).
*>
*$XFD USE GROUP
        10      W-ECB-GROUP-DATA1                       PIC X(250).
        10      W-ECB-GROUP-DATA11 REDEFINES W-ECB-GROUP-DATA1.
*> 備註
                30      W-ECB-REMARK                    PIC X(50).
*> Y-> 腦部麻醉加成
                30      W-ECB-BRAIN-YN                  PIC X(01).
*> 腦部手術之麻醉加成
                30      W-ECB-BRAIN-RATE                PIC 9(03).
*> 連帶指標父項(*)
                30      W-ECB-LNK-POINT-HEAD            PIC X(01).
*> 連帶指標項次
                30      W-ECB-LNK-POINT                 PIC X(09).
*> 連帶指標展開時間
                30      W-ECB-LNK-TIME.
                        40      W-ECB-LNK-HH            PIC 9(02).

                        40      W-ECB-LNK-MM            PIC 9(02).
                        40      W-ECB-LNK-SS            PIC 9(02).
*> Y-> 重要醫令報備     890622 INSERT
                30      W-ECB-ANN-YN                    PIC X(01).
*> 庫房對照碼           890629 INSERT
                30      W-ECB-STK-CNT                   PIC X(13).
*> 開單醫師
                30      W-ECB-APY-DR                    PIC X(04).
*> 實作醫師１
                30      W-ECB-OPR-DR1                   PIC X(04).
*> 實作醫師２
                30      W-ECB-OPR-DR2                   PIC X(04).
*> 報告醫師
                30      W-ECB-RPT-DR                    PIC X(04).
*> 會診科別
                30      W-ECB-DEPT-NO                   PIC X(04).
*> 手術年齡加成('1'->0-0.5, 'A'->0.5-2, 'B'->2-6)
*> 改成小兒三段加成('1'->0-0.5, 'A'->0.5-2, 'B'->2-6)(930701生效)
                30      W-ECB-OPP-RANK                  PIC X(01).
*> 手術年齡加成百分比
*> 改成小兒三段加成百分比(930701生效)
                30      W-ECB-OPP-RATE                  PIC 9(03).
*> 實作治療師                900721 INSERT
                30      W-ECB-THE-NO                    PIC X(05).
*> UDL 處置序號
                30      W-ECB-UDL-FEE-SEQ               PIC 9(03).
*> 檢驗開立未執行('Y'未執行、餘執行)(901007)
                30      W-ECB-HT-UNDO                   PIC X(01).
*> Y-> 改為門診申報(910131)
                30      W-ECB-OPD-APY                   PIC X(01).
*> 給藥餐數(首日量磨粉專用)(醫令)(910312)
                30      W-ECB-MED-PACKET                PIC 9(04).
*> 麻醉細項(不可異動識別碼)(910312)
                30      W-ECB-LNK-SON                   PIC X(01).
*> 氣喘0-6加成(930210)
                30      W-ECB-PANT-YN                   PIC X(01).
*> 責任加成(930617)
                30      W-ECB-DUTY-YN                   PIC X(01).
*> 急診夜間假日加成(930617)
                30      W-ECB-NIGHT-YN                  PIC X(01).
*> 處置特殊識別(比對處置代碼)(D.子宮頸)(930820)
                30      W-ECB-SPEC-MARK                 PIC X(01).
*> 事前審查項目(940105)
                30      W-ECB-PRD-YN                    PIC X(01).
*> 94/04/12 SMTCC 新增申報補登之識別註記
                30      W-ECB-APY-MARK                  PIC X(01).
*> 應收額
                30      W-ECB-NOM-AMT                  PIC S9(7)V9(2).
*> 優免額
                30      W-ECB-DIS-AMT                  PIC S9(7)V9(2).
*> 自付額
                30      W-ECB-SP-AMT                   PIC S9(7)V9(2).
*> 部份負擔額
                30      W-ECB-PART-AMT                 PIC S9(7)V9(2).
*> 申報額
                30      W-ECB-APP-AMT                  PIC S9(7)V9(2).
*> 0-4歲兒童齲齒加成

                30      W-ECB-TEETH-YN                  PIC X(01).
*> 950918  增加依處置設定輸入部位欄位
                30      W-ECB-LRB-FIELD                 PIC X(01).
**> 2006/10/31 增加UDL起迄時間(UD真正的,不含首日量之時間,為配合旭仁藥包機新格式)
                30      W-ECB-UDL-BDT                   PIC 9(7).
                30      W-ECB-UDL-BTI                   PIC 9(2).
                30      W-ECB-UDL-EDT                   PIC 9(7).
                30      W-ECB-UDL-ETI                   PIC 9(2).
*> 970430 台大化療-增加醫令開立UDL實際時間
                30      W-ECB-HRUDL-BTI                 PIC 9(2).
                30      W-ECB-HRUDL-ETI                 PIC 9(2).
*> 97.10.07 手術折扣：健保不給付額(健保)
                30      W-ECB-NHI-DIS-AMT               PIC S9(7)V9(2).
*> 97.10.07 手術折扣：其他金額(自費)
                30      W-ECB-SP-DIS-AMT                PIC S9(7)V9(2).
*> 98/07/09 替代處置 (如A處置停用，替換為B處置，此欄位存A處置代碼)
                30      W-ECB-REPLACE-FEE-KEY           PIC X(9).
*> 98/07/29 預防接種-疫苗種類
                30      W-ECB-INJ-KIND                  PIC X(6).
*> 98/07/29 預防接種-疫苗批號
                30      W-ECB-INJ-BATCH-NO              PIC X(12).
*> 98/07/29 醫令預開處置 (Y:預開處置)
                30      W-ECB-HRPRN-YN                  PIC X(1).
*> 98/09/22 台中RFID自備藥識別 (K：自備藥)
                30      W-ECB-SELF-DRUG                 PIC X(1).
*> 98/12/19 台大雲林檢體取樣註記 (Y：已取樣)
                30      W-ECB-HT-SAMPLE                 PIC X(1).
*> 98/12/24 預防接種-疫苗上傳註記 (Y：已上傳)
                30      W-ECB-INJ-ICS-YN                PIC X(1).
*> 99/07/13 健保特殊折扣組別 (NID-062A)
                30      W-ECB-SPC-DIS-GRP               PIC X(2).
*> 2011/4/8 識別屬於CHEMO用藥 (C/T用藥識別) (Y: 該項屬於C/T用藥)
                30      W-ECB-CHEMO-CT                  PIC X(1).
*$XFD USE GROUP
        10      W-ECB-GROUP-DATA2                       PIC X(250).
        10      W-ECB-GROUP-DATA21 REDEFINES W-ECB-GROUP-DATA2.
*> 化療備註(97/04/25)
                30      W-ECB-CANCER-REMARK             PIC X(80).
*> 特殊加成(97/05/07)
                30      W-ECB-SPC-RATE                  PIC 9(3).
*> 98/09/22 台中RFID化療針劑用藥起始日期 (住醫寫入)
                30      W-ECB-HRUDL-BDT                 PIC 9(7).
*> 98/09/22 台中RFID化療針劑用藥結束日期 (住醫寫入)
                30      W-ECB-HRUDL-EDT                 PIC 9(7).
*> 98/09/22 台中RFID化療針劑劑量 (住醫寫入)
                30      W-ECB-HRUDL-RX-QTY              PIC 9(6)V9(2).
*> 99/07/26 健保特殊折扣率
                30      W-ECB-SPC-DIS-RATE              PIC 9(1)V9(2).
*> 2011/2/8 健保折扣率
                30      W-ECB-NHI-DIS-RATE              PIC 9(3)V9(2).
*> 2011/2/19 連帶項是否列入PPF計算
                30      W-ECB-PPF-YN                    PIC X(1).
*> 2011/3/18 4歲兒童門診診察費加成
                30      W-ECB-DIAG-RANK                 PIC X(1).
                30      W-ECB-DIAG-RATE                 PIC 9(3).
*> 2011/3/18 科別門診診察費加成
                30      W-ECB-DPT-RANK                  PIC X(1).

                30      W-ECB-DPT-RATE                  PIC 9(3).
*> 2011/6/21 CHEMO流水號
                30      W-ECB-HYGUDL-SN-NO              PIC 9(4).
*> 2011/6/21 CHEMO識別 (C:送CHEMO, U:送UD, S:送護理站)
                30      W-ECB-HYGUDL-CHEMO-ID           PIC X(1).
*> 2011/6/21 CHEMO序號
                30      W-ECB-HYGUDL-SEQ-NO             PIC 9(2).
*> 2012/3/19 執行人員
                30      W-ECB-EXECUTE-USR               PIC X(5).
*> 2012/3/19 影像來源
                30      W-ECB-IMAGE-SW                  PIC X(1).
*> 2012/6/13 是否為清淨手術前(中)抗生素醫令(Y:是 , 空白:否)
                30      W-ECB-CLEAN-OPP-ANT-YN          PIC X(1).
*> 2012/6/25 執行日期時間、執行人員寫入識別
*>           (1.批價  2.補登  3.檢驗  4.手術  5.轉介)
                30      W-ECB-OP-DATE-USR-ID            PIC X(1).
*> 2012/8/24 20碼疫苗批號
                30      W-ECB-NEW-INJ-BATCH-NO          PIC X(20).
*> 2013/1/10 自費特材替代群組
                30      W-ECB-REPLACE-GROUP             PIC X(03).
*> 2013/8/30 20碼疫苗種類
                30      W-ECB-NEW-INJ-KIND              PIC X(20).
*> 2014/4/18 預定用血日期(血庫)
                30      W-BLOOD-DATE                    PIC 9(07).
*> 2014/4/18 預定用血時間(血庫)
                30      W-BLOOD-TIME                    PIC 9(04).
*> 2015/11/14 全日平均護病比加成3.5%
                30      W-ECB-PER-RATE                  PIC 9(05).
*> 2015/11/30 聖母-新增次劑量
                30      W-ECB-RX-N-UQTY.
                        40      W-ECB-RX-N-UQTY1        PIC 9(05).
                        40      W-ECB-RX-N-UQTY2        PIC 9(05).
*> 2017/01/09 醫管會-未列項
*>              未列項註記
                30      W-ECB-NLI-MARK                  PIC X(01).
*>              未列項健保代碼
                30      W-ECB-NLI-INS-ID                PIC X(16).
*>              未列項健保代碼流水號
                30      W-ECB-NSI-INS-ID-SEQ            PIC 9(02).
*> 2017/11/06 醫管會-C肝用藥開立審核
*>              C肝用藥申請日期
                30      W-ECB-CHE-STR-DATE              PIC 9(07).
*> 2017/11/09 加成數3碼改6碼
*>              新加成數
                30      W-ECB-PER-RATE-NEW              PIC 9(05).
*> 2019/01/22 增加代檢醫事機構代碼
                30      W-ECB-INSPECT-HOSP-ID           PIC X(10).
*>      2020/07/24 健保規範「直線加速器放射診療項目」之「診療之部位」改為2長
                30      W-ECB-LRB-FIELD-NEW             PIC X(02).
                30      W-ECB-FILLER2                   PIC X(01).

*> -----------------------------------------------------------------------
*> 最後檔案序號
 01      W-LAST-FILE-NO                                  PIC 9(03) VALUE ZERO.
*> M -> 修改
 01      W-SAVE-MODE                                     PIC X(01) VALUE SPACE.
*>      醫令日期

 01      W-IP-DATE                                       PIC 9(07) VALUE ZERO.

*> 941114 SMTCC 增加0-4歲兒童齲齒加成
 01      W-PAT-BIRTH-MONTHS      PIC 9(3).
*> 2021/12/27 年齡計算至年月日
 01      W-PAT-BIRTH-DAYS        PIC 9(3).
*> END
*******************************************************************************
*       END     OF      FILE
*******************************************************************************
*COPY    "HI_GCA.WRK".
*********************************************************************************
*       C-PY    FILE : HI_GCA.WRK       USED BY : HIOD1KF, HIOD2MF, HIOD3DF     *
* 901123  CREATE BY JAY                                                         *
* 910306  增加W-GCA-APY-ID由申報系統異動識別(JAY)                               *
*********************************************************************************
 01      HIGCA-MST-STATUS        PIC XX  EXTERNAL.
 01      HIGCB-MST-STATUS        PIC XX  EXTERNAL.
*>      Y->產生處方異動記錄
 01      W-WRITE-GCA-YN          PIC X.
*>      異動狀態:I.新增 MD.修改前 MI.修改後 D.刪除
 01      W-UPD-ID                PIC X(2).
*>      申報系統識別碼(Y)(910306)
 01      W-GCA-APY-ID            PIC X   VALUE   SPACE.
*>      異動日期
 01      W-GCA-DATE              PIC 9(7).
*>      異動時間
 01      W-GCA-TIME              PIC 9(6).
*COPY    "HG_NIDIF.LNK".
**********************************************************************************
*>      930920 因應北市代碼存取啟用日及停用日, 增加呼叫HGNIDIF 之第三組LINK (SMSTL)
*>      如需判別該代碼之啟用日或停用日, 則必需傳遞三組參數
*>      EX. CALL "HGNIDIF" USING W-NIDIF-LNK W-COLOR-LNK W-EXTIF-LNK    END-CALL.
**********************************************************************************
*> 此為 呼叫 HGNIDIF 所傳遞之第一組參數
 01      W-NIDIF-LNK.
*       查詢設定：1.表多筆查詢前後均開查詢功能選擇視窗
*                 2.表多筆查詢後才開查詢功能選擇視窗
*                 3.表僅作多筆查詢，不開查詢功能選擇視窗
        02  W-NIDIF-SEL                         PIC X(01).
        02  W-NIDIF-ID                          PIC X(04).
        02  W-NIDIF-CODE                        PIC X(10).
        02  W-NIDIF-CHK-TBL REDEFINES W-NIDIF-CODE.
                03 W-NIDIF-CA                   PIC 9(03).
                03 W-NIDIF-CS                   PIC 9(02).
                03 W-NIDIF-CM                   PIC 9(03).
                03 W-NIDIF-CN                   PIC 9(02).
        02  W-NIDIF-TITLE                       PIC X(16).
        02  W-NIDIF-FUN                         PIC 9(01).
        02  W-NIDIF-LINE                        PIC 9(02).
        02  W-NIDIF-COL                         PIC 9(02).
        02  W-NIDIF-SIZE                        PIC 9(02).
*       暫作為指定訊息視窗位置之用
        02  W-NIDIF-SCROLL                      PIC 9(02).
*       傳入:表檢查 NID-MST-REC(W-NIDIF-CA:W-NIDIF-CS)
*            E: 表檢查 NID-MST-REC(W-NIDIF-CA:W-NIDIF-CS) =  傳入值
*               否則結束查詢(KEY)

*            ---------------------------------------------------------
*            F: 表檢查 NID-MST-REC(W-NIDIF-CA:W-NIDIF-CS) =  傳入值
*               IF W-NIDIF-CN > 0 多 CHECK
*                      NID-MST-REC(W-NIDIF-CM:W-NIDIF-CN) =  傳入值
*               END-IF
*               否則 NEXT RECORD
*            ---------------------------------------------------------
*            >: 表檢查 NID-MST-REC(W-NIDIF-CA:W-NIDIF-CS) >  傳入值
*            <: 表檢查 NID-MST-REC(W-NIDIF-CA:W-NIDIF-CS) <  傳入值
*            X: 表檢查 NID-MST-REC(W-NIDIF-CA:W-NIDIF-CS) <> 傳入值
*               IF W-NIDIF-CN > 0 多 CHECK
*                      NID-MST-REC(W-NIDIF-CM:W-NIDIF-CN) <> 傳入值
*               END-IF
*               否則 NEXT RECORD
*       傳回:"Y" 表取值，"N" 表未取值，"0" 表此代號無資料
        02  W-NIDIF-YN                          PIC X(01).
        02  W-NIDIF-REC                         PIC X(300).
*       " " 表開檔，"N" 表不開檔
        02  W-NIDIF-OPEN                        PIC X(01).
*> 以上為原 HG_NIDIF.LNK 之內容 930920 MEMO 說明

*> 此為 呼叫 HGNIDIF 所傳遞之第二組參數
 01      W-COLOR-LNK                             PIC 9(05)       COMP-1.

*> 此為 呼叫 HGNIDIF 所傳遞之第三組參數(查詢啟用日或停用日)
 01      W-EXTIF-LNK.
*>      Y->查全部, 不檢查啟用日及停用日(不看W-EXTIF-CHK-DT)
        02 W-EXTIF-ALL-YN                       PIC X(01).
*>      代碼檢查日期(如未傳日期, 則HGNIDIF 以系統日比對啟用日或停用日)
        02 W-EXTIF-CHK-DT                       PIC 9(07).
*>      傳回 HGEXT-MST-REC 整筆RECORD之內容(W-NIDIF-YN = "Y"時)
        02 W-EXTIF-EXT-REC                      PIC X(231).
*>      預留
        02 W-EXTIF-FILLER                       PIC X(50).
**********************************************************************************
*>      END     OF      FILE
**********************************************************************************

*COPY    "HO_GCK.WRK".
*
 01      W-1799-REC      PIC X(300) IS EXTERNAL.
*
*------>開關檔
*COPY    "HR_WAIT.WRK".
*
*       處理中回應訊息視窗
*       "HR_WAIT.WRK".
*
*77      S-LOAD-FORM-Handle HANDLE OF WINDOW.

 01      W-LA-NAME                       PIC X(40).
 01      W-FONT-TITLE                    PIC X(40).
 01      W-PERCENT                       PIC 9(03).
 01      W-PERCENT-FMT.
        03      W-PERCENT-FMT1          PIC  ZZ9.
        03      FILLER                  PIC  XX VALUE IS "％".
 01      W-OPEN-MESG-TYPE                PIC X(01).

*> 百分比每次增加之數字(一定要是100的因數)
 01      W-PERCENT-ADD                   PIC 9(02).
*COPY    "HR_LOA.WRK".

*------->暫存醫師代碼表...
 01      HR-TMP-DR                       PIC X(4).
 01      HR-TMP-DR-NAME                  PIC X(12).
 01      HR-DR-II                        PIC 9(4) IS EXTERNAL.
 01      HR-DR-II1                       PIC 9(4).
 01      HR-DR-TAB                                IS EXTERNAL.
        02      W-DR-TAB1 OCCURS 1 TO 5000 TIMES
                DEPENDING ON HR-DR-II INDEXED BY HR-DR-JJ.
                03      HR-DR-TAB1-NO    PIC X(4).
                03      HR-DR-TAB1-NAME  PIC X(12).

*------->暫存科別代碼表...
 01      HR-TMP-DPT                      PIC X(4).
 01      HR-TMP-DPT-NAME                 PIC X(16).
 01      HR-DPT-II                       PIC 9(3) IS EXTERNAL.
 01      HR-DPT-II1                      PIC 9(4).
 01      W-DEP-TAB                                IS EXTERNAL.
        02      W-DEP-TAB1 OCCURS 1 TO 999 TIMES
                DEPENDING ON HR-DPT-II INDEXED BY HR-DPT-JJ.
                03      HR-DEP-TAB1-NO   PIC X(4).
                03      HR-DEP-TAB1-NAME PIC X(16).
*COPY    "HR_IPDIF.LNK".
***********************************************************************
*HR_IPDIF.LNK        HRIPDIF護理站患者點選作業使用
*> 呼叫方式為 CALL "HRIPDIF" USING L-IPDIF-LNK L-IPDIF-LNK1 ON EXCEPTION CONTINUE
***********************************************************************
 01      L-IPDIF-LNK.
*------->       住院序號
        02      L-LNK-IPD-NO.
                03      L-LNK-IPD-DT    PIC 9(07).
                03      L-LNK-IPD-SEQ   PIC 9(04).

*------->       是否有傳回值 [Y]-有
        02      L-LNK-YN                PIC X(01).

*------->       目前已點選之序號
        02      L-LNK-II                PIC 9(02).

*------->       目前之主治醫師代號
        02      L-LNK-MJ-DR             PIC X(04).

*------->       床號區間
        02      L-LNK-SBED              PIC X(06).
        02      L-LNK-EBED              PIC X(06).

*------->       使用之查詢方式 [ ]依護理站選病人 [A]依主治醫師選病人
*                           [B]自行輸入床號區間 [C]依科別選病人
*                           [D]自動依主治醫師選擇病人
        02      L-LNK-INQ-TYPE          PIC X(01).
 01      L-IPDIF-LNK1.
*------->94.2.18 住院識別 (A.或" " 因病住院 B.護理之家 C.日間照護 X.不可使用)
        02      L-LNK-IPD-LIVE-ID       PIC X(01).
*------->95.8.16 可輸入患者備註[Y]

        02      L-LNK-IPD-PAT-NOTE      PIC X(01).
*------->95.11.28 判斷VIP患者不可處理 [N]
        02      L-LNK-IPD-ACCESS-YN     PIC X(01).
*------->95.12.27 密碼使用者之醫師代碼
        02      L-LNK-IPD-RUN-DR        PIC X(04).
*--------108.03.28 預立醫囑
        02      L-LNK-HRNPTCF-YN        PIC X(01).
*>
        02      L-LNK-FILLER            PIC X(03).
***********************************************************************
*COPY    "HR_MESCF.LNK".
***********************************************************************
*> HR_MESCF.LNK
*> CALL "HRMESCF" 程式使用  顯示MESSAGE BOX
***********************************************************************
 01      W-HRMESCF-DATA.
*> 訊息符號 1.[?] 2.[i] 3.[!] 4.[X]
        02      W-HRMESCF-PIC-TYPE      PIC X(01).
*> 按鈕種類     1.是 否 取消
*>              2.確定 取消
*>              3.確定
*>              4.是 否
*>              5.是 否 變更使用者 [醫令專用]
*>              6.存檔 放棄 再修改
*>              7.存檔 放棄 存檔並列印
*>              8.1.轉留觀 2.診療中 3.MBD 4.轉住院 5.轉院 6.AAD 7.DOA 8.死亡 9.不告而別
*>              A.自訂模式(二個按鈕)
*>              B.自訂模式(三個按鈕)
*>              C.自訂模式(四個按鈕)
*>              D.自訂模式(一個按鈕)
*>              E.自訂模式(五個按鈕) 使用此模式者請務必要傳 W-HRMESCF-DATA3 哦!
        02      W-HRMESCF-BUT-TYPE      PIC X(01).
*> 傳回值 Y-是(存檔) N-否(放棄) O-確定 C-取消 P-變更使用者(存檔並列印) M-再修改
        02      W-HRMESCF-RETURN        PIC X(01).
*> 由此開始50長的FILLER
*> 是否要有警示音 Y-是
        02      W-HRMESCF-BELL          PIC X(01).
*> 預設ID值為何 Y-是(存檔) N-否(放棄) O-確定 C-取消 P-變更使用者(存檔並列印) M-再修改
*>              若為自訂按鈕則搬 1-第一個 2-第二個 3-第三個 4-第四個
        02      W-HRMESCF-CONTROL-ID    PIC X(01).
*> 自訂按鈕內容 (1-4)
        02      W-HRMESCF-BUT-SET.
                03      W-HRMESCF-BUT-SET1 OCCURS 4 TIMES.
                04      W-HRMESCF-BUT-VALUE     PIC X(01).
                04      W-HRMESCF-BUT-NAME      PIC X(10).
*> 不顯示按鈕，改為使用 ENTRY
        02      W-HRMESCF-ENTRY-OPEN    PIC X(01).
*> 預留
        02      W-HRMESCF-FILLER        PIC X(03).
*> 訊息字串 (每行60字,共十行)
 01      W-HRMESCF-DATA2.
        02      W-HRMESCF-NOTE OCCURS 10 TIMES PIC X(60).
 01      W-HRMESCF-DATA3.
*> WINDOW TITLE
        02      W-HRMESCF-TITLE         PIC X(60).
*> 自訂按鈕內容 (5)
        02      W-HRMESCF-BUT-SETA.

                04      W-HRMESCF-BUT-VALUEA    PIC X(01).
                04      W-HRMESCF-BUT-NAMEA     PIC X(10).
*> 若使用ENTRY輸入，可於此說明
        02      W-HRMESCF-ENTRY-TITLE   PIC X(56).
*> 是否可按ESC離開
        02      W-HRMESCF-ESC-OK        PIC X(01).
        02      W-HRMESCF-DATA3-FILLER  PIC X(132).
***********************************************************************
*COPY    "HR_DOSE.LNK".
*********************************************************************************
*> C-PY FROM "MR_DOSE.LNK".
*********************************************************************************
*------>"1"︰將輸入值(W-LNK-DOSE-SUR)約分去雜值
*>              輸入-->W-LNK-DOSE-SUR
*>              輸出--> W-LNK-DOSE-NUM W-LNK-DOSE-DEN
*------>"2"︰將輸入值(W-LNK-DOSE-NUM W-LNK-DOSE-DEN) 約分為最簡分數
*>              輸入-->分子(W-LNK-DOSE-NUM)分母(W-LNK-DOSE-DEN)
*>              輸出-->W-LNK-DOSE-SUR
*------>"3"︰將輸入值(W-LNK-DOSE-NUM W-LNK-DOSE-DEN) 轉化為小數模式
*>              輸入-->分子(W-LNK-DOSE-NUM)分母(W-LNK-DOSE-DEN)
*>              輸出-->W-LNK-DOSE-SUR
*------>"4"︰將輸入值(W-LNK-DOSE-SUR)轉換為日期型態
*>              輸入-->W-LNK-DOSE-SUR
*>              輸出--> W-LNK-DOSE-NUM (日期)
*>                      W-LNK-DOSE-YY W-LNK-DOSE-MM W-LNK-DOSE-DD (年月日)
*------>"5"︰將輸入值(W-LNK-DOSE-SUR)轉換為時間型態
*>              輸入-->W-LNK-DOSE-SUR
*>              輸出--> W-LNK-DOSE-HH (時) W-LNK-DOSE-MT (分)
*------>"6"︰將輸入值(W-LNK-DOSE-SUR)轉換為牙位
*>              輸入-->W-LNK-DOSE-SUR
*>              輸出--> W-LNK-DOSE-TTH(N) 共三組
*------>"7"︰將輸入值(W-LNK-DOSE-SUR)轉換為床位
*>              輸入-->W-LNK-DOSE-SUR
*>              輸出--> W-LNK-DOSE-BED
*------>"8"︰將輸入值(W-LNK-DOSE-SUR)轉換日為時間區間
*>              輸入-->W-LNK-DOSE-SUR
*>              輸出--> W-LNK-DOSE-HH (時1) W-LNK-DOSE-MT (分1)
*>              輸出--> W-LNK-DOSE-HH2 (時2) W-LNK-DOSE-MT2 (分2)
*********************************************************************************
 01      W-LNK-DOSE-DATA.
*-------> 處理模式
        05      W-LNK-DOSE-ID                   PIC X(1).
                88      W-LNK-DOSE-ID-OK        VALUE "1","2","3","4","5","6","7","8".
*-------> 輸入/輸出區
        05      W-LNK-DOSE-SUR                  PIC X(12).
        05      W-LNK-DOSE-NUM                  PIC 9(7).
        05      W-LNK-DOSE-NUM-1 REDEFINES W-LNK-DOSE-NUM.
                10      W-LNK-DOSE-YY           PIC 9(03).
                10      W-LNK-DOSE-MM           PIC 9(02).
                10      W-LNK-DOSE-DD           PIC 9(02).
        05      W-LNK-DOSE-NUM-2 REDEFINES W-LNK-DOSE-NUM.
                10      W-LNK-DOSE-TTH OCCURS 3 TIMES PIC X(02).
                10      W-LNK-DOSE-2-F          PIC X(01).
        05      W-LNK-DOSE-BED REDEFINES W-LNK-DOSE-NUM.
                10      W-LNK-DOSE-BED-ROOM     PIC X(04).
                10      W-LNK-DOSE-BED-NO       PIC X(02).
                10      W-LNK-DOSE-3-F          PIC X(01).

        05      W-LNK-DOSE-NUM-4 REDEFINES W-LNK-DOSE-NUM.
                10      W-LNK-DOSE-HH2          PIC 9(02).
                10      W-LNK-DOSE-MT2          PIC 9(02).
                10      W-LNK-DOSE-4-F          PIC X(03).
        05      W-LNK-DOSE-DEN                  PIC 9(4).
        05      W-LNK-DOSE-DEN-1 REDEFINES W-LNK-DOSE-DEN.
                10      W-LNK-DOSE-HH           PIC 9(02).
                10      W-LNK-DOSE-MT           PIC 9(02).
*------>當 W-LNK-DOSE-ID = "1" 時，傳回 "." 表 USER 輸入小數
*------>                              "/" 表 USER 輸入分數
        05      W-LNK-DOSE-SEP                  PIC X(1).
*------>輸入錯誤判別碼
*------>"1"︰分子或小數之整數部份太長或沒輸入但有輸入"." OR "/"
*------>"2"︰分母或小數太長或沒輸入但有輸入"." OR "/"
*------>"Y"︰其他錯誤
        05      W-LNK-DOSE-ERR                  PIC X(1).
*********************************************************************************
*> END OF FILE
*********************************************************************************
*COPY    "HR_BAR.WRK".
***********************************************************************
*> STATUS-BAR
***********************************************************************
* S-HRSTATUS-1
*77      S-HRSTATUS-1-Handle HANDLE OF STATUS-BAR.
 77      W-HRSTATUS-P1   PIC X(08).
 77      W-HRSTATUS-P2   PIC X(60).
 77      W-HRSTATUS-P3   PIC X(08).
 77      W-HRSTATUS-P4   PIC X(06).
 77      W-HRSTATUS-P5   PIC X(04).
 77      W-HRSTATUS-P6   PIC Z(08).
 77      W-HRSTATUS-P7   PIC X(05).
***********************************************************************
*COPY    "HR_AGECF.LNK".
*> ============================================================
*>  年齡計算  HRAGECF ....(請先將PAT-MST讀好,再CALL此副程式)
*> ============================================================
*>
*>>>>>> INPUT ... 計算的日期 (EX.門診日)
 01      L-DT                            PIC 9(07).
*>>>>>> OUTPUT .. 實歲 (YY歲MM個月DD天)
*>>>>>> 當 L-ID 為空白時, 才會有此OUTPUT值
 01      L-AGE.
        02      L-AGE-YY                PIC 9(3).
        02      L-AGE-MM                PIC S9(2).
        02      L-AGE-DD                PIC S9(2).
*>>>>>> OUTPUT .. 實歲最大單位值
*>>>>>> 不管 L-ID 為多少, 此OUTPUT值一定會有
*>>>>>> 滿一歲為YY, 不滿一歲滿一個月為MM, 不滿一個月為DD
 01      L-AGE-2                         PIC S9(03).
*>>>>>> OUTPUT .. 前項值之單位 (YY時 => A , MM時 => M , DD時 => D)
 01      L-AGE-UNIT                      PIC X(01).
*> 92.01.28 (新增)
*>>>>>> INPUT ... [ ]計算實歲 [Y]以年度算
 01      L-ID                            PIC X(01).
*
*COPY    "HR_IBGCF.LNK".

***********************************************************************
*>102.09.06 (FISH) 因RD14藥袋品項錯誤照會單有問題，故需新增欄位，以傳遞資料

 01      W-IBGCF-LNK.
*>   開單日期
        02      W-IBGCF-DATE                    PIC 9(07).
*>   開單護理站(表單來源)
        02      W-IBGCF-UNIT                    PIC X(05).
*>   表單種類
*>      [A]ＵＤ憑證                     [B]臨時處方,出院帶藥,首日量     [C]會診單
*>      [D]護理治療憑證                 [E]檢驗放射線憑證               [F]檢驗放射單
*>      [G]預開處方憑證(含預開治療)     [H]X光片借閱單                  [I]出院帶藥憑證(預開)
*>      [J]預掛單                       [K]退藥申請單                   [L]手術通知單
*>      [M]即時檢驗報告                 [N]出院通知單                   [O]領血備血單
*>      [P]管制抗生素處方箋             [Q]取消處方箋                   [R]退藥憑證
*>      [S]自費意願書                   [T]特殊藥品使用申請單           [U]排程單
*>      [V]感管藥品申請單               [W]治療處置單(復健)             [X]轉介復健通知單
*>      [Y]復健治療單(手持單)           [Z]中醫住院護理站藥單
*>      [a]抗流感表單                   [b]CHEMO 標籤                   [c]CHEMO 標籤(緊急處方)
*>      [d]醫囑單(DC)                   [e]醫囑單                       [f]檢驗放射單(逐項)
*>      [g]成癮性同意書                 [h]血庫退件單
*>      [m]檢驗退件通知單               [n]感管藥品審查單
*>      [q]取消處方箋(檢驗)             [o]領血備血單(新版)             [v]非管制性感管藥品申請單
*>      [1]批價憑證(刪除)               [2]旭仁版ＵＤ憑證               [3]化療藥品領用通知單
*>      [4]護理退藥申請單               [5]RFID照會單                   [6]特殊用藥照會單
*>      [7]藥袋品項錯誤照會單           [9]長期醫囑單(樹林仁愛)         [9]臨時醫囑單(樹林仁愛)
        02      W-IBGCF-PAPER-ID                PIC X(01).
*>   傳遞變數(為了要印出各種表單,使用此欄位儲存KEY值)
        02      W-IBGCF-PRINT-DATA              PIC X(50).
        02      W-IBGCF-SP-PAPER                PIC X(01).
*>   同類表單特殊識別 [ ]一般住院處方   [1]首日量處方       [2]出院帶藥處方 (住院處方箋)
*>   同類表單特殊識別 [1]會診通知單     [2]會診回覆單                       (會診單)
*>   同類表單特殊識別 [1]預開處方憑證   [2]預開復健治療                     (預開處方箋)
*>   同類表單特殊識別 [1]抗生素審核通過 [2]抗生素審核不通過                 (抗生素處方箋)
*>   同類表單特殊識別 [A]門診藥局使用   [B]住院藥局使用                     (取消處方箋)
        02      W-IBGCF-PAPER-ID2               PIC X(01).
*>   含檢查項識別[Y]
        02      W-IBGCF-HAS-D                   PIC X(01).
*>   是否需自行取得護理站代號
*>   [ ]-表不需 HRIBGCF 自行開關檔，只利用 W-IBGCF-UNIT 傳入之護理站代碼產生單據
*>   [Y]-表需由 HRIBGCF 自行開關檔[HI_MBED.HR_MRNU.HR_MIBG]，且利用 W-IBGCF-IPD-BED 傳入之床號對應之護理站代碼產生單據
*>   [A]-表不需 HRIBGCF 自行開關檔，利用 W-IBGCF-IPD-BED 傳入之床號對應之護理站代碼產生單據
*>   [B]-表需由 HRIBGCF 自行開關檔[HR_MRNU.HR_MIBG]，且利用 EXTERNAL 之 BED-UNIT 之護理站代碼產生單據
*>   [C]-表需由 HRIBGCF 自行開關檔[HR_MRNU.HR_MIBG]，且利用 W-IBGCF-IPD-BED 傳入之床號對應之護理站代碼產生單據
*>   [D]-表需由 HRIBGCF 自行開關檔[HR_MRNU.HR_MIBG]，且利用 W-IBGCF-UNIT 傳入之護理站代碼產生單據
        02      W-IBGCF-GET-UNIT                PIC X(01).
*>   床號(W-IBGCF-GET-UNIT = "Y" OR "A" OR "C")時要搬
        02      W-IBGCF-IPD-BED                 PIC X(06).
*>   來源程式
        02      W-IBGCF-CALL-FROM               PIC X(11).
*>   含治療項識別[Y]
        02      W-IBGCF-HAS-F                   PIC X(01).
*>   識別退藥退材是否判斷參數(醫令大瓶點滴為空白不看參數)
        02      W-IBGCF-RDC-YN                  PIC X(01).
*>   是否有中藥識別
        02      W-IBGCF-CHMED-YN                PIC X(01).
*>   是否為新版醫令寫入(Y:表示新版醫令寫入)

        02      W-IBGCF-NEW-PRINT               PIC X(01).
*>
        02      W-IBGCF-FILLER                  PIC X(26).


*>102.09.06 (FISH) 因RD14鴻益-藥袋品項錯誤照會單有誤，故需新增欄位，以傳遞資料
*>01      W-IBGCF-ERR-LNK.
*>      02       W-IBGCF-ERR-CODE               PIC X(04).
*>      02       W-IBGCF-ERR-NOTE               PIC X(40).
*>      02       W-IBGCF-ERR-WAY                PIC X(40).
*>      02       W-IBGCF-ERR-FILLER             PIC X(116).
*>102.09.06 END
***********************************************************************
*>
*COPY    "HT_W01.LNK".
*************
* C-PY FILE : HT_W01.LNK   84/08/03     作者：謝枝財
* LENGTH 20 BYTES          85/03/26     呼叫視窗參數檔
*************
 01 W01-TABLE.
** 呼叫視窗參數資料
   02 W01-M.
**    主程式參數
      03 W01-SYS-NO                     PIC X(2).
**       系統代號                       -- HTPWD-SYS-NO
      03 W01-USR-NO                     PIC X(5).
**       使用者代號                     -- HTPWD-USR-NO
      03 W01-DPT-NO                     PIC X(1).
**       檢驗檢查科室簡碼               -- HTPWD-DPT
      03 W01-DPT-NO1                    PIC X(5).
**       使用科室單位代號               -- HG_NID.MST
      03 W01-CLS-TBL.
         04 W01-CLS-CD  OCCURS 14 TIMES PIC X(2).
**          檢驗檢查類別碼              -- HTPWD-CLS
      03 W01-PWD.
**       密碼權限碼                     -- HTPWD-LVL
         04 W01-PWD-C                   PIC X(1).
**          新增權限碼 : Y> 新增
         04 W01-PWD-M                   PIC X(1).
**          修改權限碼 : Y> 修改
         04 W01-PWD-D                   PIC X(1).
**          刪除權限碼 : Y> 刪除
         04 W01-PWD-I                   PIC X(1).
**          查詢權限碼 : Y> 查詢
         04 W01-PWD-P                   PIC X(1).
**          列印權限碼 : Y> 列印

** IF W01-DPT-NO = SPACES               不分科室
*COPY    "HT_PATR.LNK".
*************
* C-PY FILE : HT_PATR.LNK  88/09/22     作者：謝枝財
* LENGTH 55 BYTES          88/09/22     報告列印條件連結參數檔
* CALL "HTPATRPF" USING W01-TABLE, W-PATR-TABLE
*************
 01 W-PATR-TABLE.
** 報告列印參數資料
   02 W-PATR-PT-NO                      PIC 9(8).

**    起始病歷號碼
   02 W-PATR-IP-DATE1                   PIC 9(7).
**    醫令(或報告)起始日期
   02 W-PATR-IP-DATE2                   PIC 9(7).
**    醫令(或報告)終止日期
   02 W-PATR-CLS-CD1                    PIC X(2).
**    檢驗檢查起始類別碼
   02 W-PATR-CLS-CD2                    PIC X(2).
**    檢驗檢查終止類別碼
   02 W-PATR-CHO                        PIC X(1).
**    列印選擇 ( 1>依醫令日期 2>依報告日期 ) --> 2001/09/26 ADD BY LCH
*COPY    "HT_W01.WRK".
*************
* C-PY FILE : HT_W01.WRK
* LENGTH XXX BYTES
*************
 01 W-LNK-TABLE.
** 呼叫視窗參數資料
**    主程式參數
      03 W-SYS-NO                        PIC X(2).
**       系統代號      -- W-PWD-SYS-NO
      03 W-USE-NO                        PIC X(5).
**       使用者代號    -- W-PWD-USR-NO
      03 W-DPT-NO                        PIC X(1).
**       科室代號      -- W-PWD-DPTC
      03 W-DPT-NO1                       PIC X(5).
**       科室單位代號  -- W-PWD-DPT
      03 W-CLS-TBL.
         04 W-CLS-CD  OCCURS 14 TIMES    PIC X(2).
**          檢驗檢查類別碼
      03 W-PWD.
**       密碼權限碼
         04 W-PWD-C                      PIC X(1).
**          新增權限碼 : Y> 新增
         04 W-PWD-M                      PIC X(1).
**          修改權限碼 : Y> 修改
         04 W-PWD-D                      PIC X(1).
**          刪除權限碼 : Y> 刪除
         04 W-PWD-I                      PIC X(1).
**          查詢權限碼 : Y> 查詢
         04 W-PWD-P                      PIC X(1).
**          列印權限碼 : Y> 列印
*COPY    "HI_FONCF.LNK".
*--------------------------------------------------------------------------
*>      門診轉住院公用程式                      HI_FONCF.LNK
*--------------------------------------------------------------------------
 01      W-FONCF-LNK.
*>      識別碼 ([01].門診身份修改<回寫FON-MST之FON-06-CHG-CLA> (HIFON1CF 處理)
*>              [02].住院申請修改和出院結帳提示是否有作門診轉住院
*>              [03].出院結帳提示住院身份和門診身份不合
*>              [04].查詢門診序號所對應之門轉住的住院序號
*>              [05].查詢門急診應退之金額
*>              [06].比對符合住院處方序號之門轉住的門診序號
*>              [07].異動記錄<OPEN I-O CHG-MST>
*>              [08].檢查門診是否有申報鎖檔<OPEN INPUT DTE-MST>)

        02 W-FONCF-ID                           PIC X(02).

*>      是否處理成功
        02 W-FONCF-YN                           PIC X(01).
*>      錯誤訊息 (W-FONCF-YN = "N"  有值)
        02 W-FONCF-NOTE                         PIC X(60).
*>      住院序號 (W-FONCF-ID = "02" , "06" , "07" 有效)
        02 W-FONCF-IPD-NO                       PIC X(11).
*>      處方序號 (W-FONCF-ID = "06" 有效)
        02 W-FONCF-ODR-NO                       PIC X(11).
*>      門診序號 (W-FONCF-ID = "01" , "06" 有效)
        02 W-FONCF-RO-NO                        PIC X(11).
*>      異動註記 (W-FONCF-ID =  "07" 有效)
*>               (O.出院結帳 o.開帳 I.整批結帳 i.住院結帳
*>                P.收預繳金 p.退預繳金 R.收款 r.退款)
        02 W-FONCF-CHG-ID                       PIC X(01).
*>      異動者
        02 W-FONCF-USER-ID                      PIC X(05).
*>      病床號 (W-FONCF-ID =  "07" 有效)
        02 W-FONCF-BED                          PIC X(06).
*>      是否開DG1-MST (W-FONCF-ID =  "05" 有效)
        02 W-FONCF-OPEN-YN                      PIC X(01).
*>      預留
        02 W-FONCF-REC                          PIC X(87).

*--------------------------------------------------------------------------
*>      範例
*--------------------------------------------------------------------------
*>      [01].門診身份修改
*>      IF      (DG1-IPD-MARK = "I") AND (原身份 NOT = 修改後的身份) THEN
*>              INITIALIZE      W-FONCF-LNK
*>              MOVE    "01"            TO      W-FONCF-ID
*>              MOVE    "門診序號"      TO      W-FONCF-RO-NO
*>              CALL    "HIFONCF"       USING   W-FONCF-LNK
*>                                      ON      EXCEPTION CONTINUE END-CALL
*>              IF      W-FONCF-YN = "N"        THEN
*>                      MOVE    W-FONCF-NOTE    TO      W-NOTE
*>                      DISPLAY 錯誤訊息
*>              END-IF
*>      END-IF
*>
*>
*>      [02].住院申請修改提示是否有作門診轉住院
*>      IF      [0709] NID-MST-REC(192:1) = "Y" THEN
*>              INITIALIZE      W-FONCF-LNK
*>              MOVE    "02"            TO      W-FONCF-ID
*>              MOVE    住院序號        TO      W-FONCF-IPD-NO
*>              CALL    "HIFONCF"       USING   W-FONCF-LNK
*>                                      ON      EXCEPTION CONTINUE END-CALL
*>              IF      W-FONCF-YN = "N"        THEN
*>                      MOVE    W-FONCF-NOTE    TO      W-NOTE
*>                      DISPLAY 錯誤訊息
*>              END-IF
*>
*>      [03].出院結帳提示住院身份和門診身份不合
*>      IF      [0709] NID-MST-REC(197:1) = "Y" THEN
*>              INITIALIZE      W-FONCF-LNK
*>              MOVE    "03"            TO      W-FONCF-ID
*>              MOVE    住院序號        TO      W-FONCF-IPD-NO

*>              CALL    "HIFONCF"       USING   W-FONCF-LNK
*>                                      ON      EXCEPTION CONTINUE END-CALL
*>              IF      W-FONCF-YN = "N"        THEN
*>                      MOVE    W-FONCF-NOTE    TO      W-NOTE
*>                      DISPLAY 錯誤訊息
*>              END-IF

*>      [05].查詢門急診應退之金額
*>      IF      [0709] NID-MST-REC(226:1) = "Y" THEN
*>              INITIALIZE      W-FONCF-LNK
*>              MOVE    "05"            TO      W-FONCF-ID
*>              MOVE    住院序號        TO      W-FONCF-IPD-NO
*>              若未開HO_MDG1 , W-FONCF-OPEN-YN = "Y"
*>              MOVE    "Y"             TO      W-FONCF-OPEN-YN
*>              CALL    "HIFONCF"       USING   W-FONCF-LNK
*>                                      ON      EXCEPTION CONTINUE END-CALL
*>              IF      W-FONCF-YN = "Y"        THEN
*>                      MOVE    W-FONCF-NOTE    TO      W-NOTE
*>                      DISPLAY 退款金額
*>              END-IF

*>
*>      [07].異動記錄<OPEN I-O CHG-MST>
*>              INITIALIZE      W-FONCF-LNK
*>              MOVE    "07"            TO      W-FONCF-ID
*>              MOVE    住院序號        TO      W-FONCF-IPD-NO
*>              MOVE    異動註記        TO      W-FONCF-CHG-ID
*>              MOVE    異動者          TO      W-FONCF-USER-ID
*>              MOVE    病床號          TO      W-FONCF-BED
*>              CALL    "HIFONCF"       USING   W-FONCF-LNK
*>                                      ON      EXCEPTION CONTINUE END-CALL
*>              IF      W-FONCF-YN = "N"        THEN
*>                      MOVE    W-FONCF-NOTE    TO      W-NOTE
*>                      DISPLAY 錯誤訊息
*>              END-IF
*>
*>
*>
*>
*>

*--------------------------------------------------------------------------
*>      ＥＮＤ　ＯＦ　ＣＯＰＹ　ＦＩＬＥ　
*--------------------------------------------------------------------------
*COPY    "HT_VVV0.WRK".
*************
* C-PY FILE : HT_VVV.WRK 88/11/04       作者：陳志彥
* LENGTH 302 BYTES       88/11/04       系統參數設定檔
*************
 01 W-VVV-REC.
** 檔案對應RECORD暫存變數 (與 HTVVV-REC 同)
   02 W-VVV-KEY.
      03 W-VVV-DPT-CD.
         04 W-VVV-DPT-CD1                       PIC X(01).
         04 W-VVV-DPT-CD2                       PIC X(01).
   02 W-VVV-DATA1.
      03 W-VVV-CLS-TBL.

         04 W-VVV-CLS-CD OCCURS 08 TIMES        PIC X(02).
      03 W-VVV-V99-TBL.
         04 W-VVV-V99-CD OCCURS 04 TIMES        PIC X(02).
      03 W-VVV-STN-TBL.
         04 W-VVV-STN-CD OCCURS 04 TIMES        PIC X(02).
      03 W-VVV-TYP-MODE                         PIC X(01).
      03 W-VVV-TYP-CHK                          PIC X(01).
      03 W-VVV-PRT-TYP                          PIC X(01).
      03 W-VVV-RPT-TYP                          PIC X(01).
      03 W-VVV-V99-MODE                         PIC X(01).
      03 W-VVV-BAR-TYP                          PIC X(01).
      03 W-VVV-BAR-PRT                          PIC X(01).
      03 W-VVV-ORSA-VIRNO                       PIC X(07).
      03 W-VVV-ORSA-DRUG                        PIC X(05).
      03 W-VVV-MIC-YN                           PIC X(01).
      03 W-VVV-ICD-YN                           PIC X(01).
      03 W-VVV-FIRST-YN                         PIC X(01).
      03 W-VVV-VPL-TYP                          PIC X(01).
      03 W-VVV-WRK-1                            PIC X(01).
      03 W-VVV-WRK-2                            PIC X(01).
      03 W-VVV-WRK-3                            PIC X(01).
      03 W-VVV-SAV-PRT                          PIC X(01).
      03 W-VVV-WRK-4                            PIC X(01).
      03 W-VVV-DATA1-FILL                       PIC X(40).
   02 W-VVV-DATA2                               PIC X(100).
   02 W-VVV-DATA3.
      03 W-VVV-RPT-END-1                        PIC X(50).
      03 W-VVV-RPT-END-2                        PIC X(50).


** W-VVV-DPT-CD      : 系統代號 (ex. 'TV':微生物室)
** W-VVV-DPT-CD1     : 科
** W-VVV-DPT-CD2     : 室

** W-VVV-CLS-CD      : 細菌室用到的檢驗類別
** W-VVV-V99-CD      : 細菌室用到的檢驗類別(抗藥性試驗)
** W-VVV-STN-CD      : 細菌室用到的檢驗類別(染色試驗)

** W-VVV-TYP-MODE    : 報告登錄模式( 1> 片語模式 2> 代碼模式 3> 視窗模式 )
** W-VVV-TYP-CHK     : 報告審核模式( Y> 須審核 N> 不須審核 )
** W-VVV-PRT-TYP     : 發報告方式  ( 1> 手動 )
** W-VVV-RPT-TYP     : 報告印表格式( 1> 全張  2> 半張  3> 8 英吋  4> 9 英吋 5> 8.5 英吋 )

** W-VVV-V99-MODE    : 申報模式    ( 1> 手動   2> 自動 )

** W-VVV-BAR-TYP     : 標籤格式    ( 1> 新竹醫院 2> 台中醫院 )
** W-VVV-BAR-PRT     : 檢體登錄印標籤

** W-VVV-ORSA-VIRNO  : ORSA 菌株
** W-VVV-ORSA-DRUG   : ORSA 藥品

** W-VVV-MIC-YN      : 是否有 MIC 法
** W-VVV-ICD-YN      : 報告是否印診斷

** W-VVV-FIRST-YN    : 血液培養是否有初次報告

** W-VVV-VPL-TYP     : 檢體編碼規則( 1> 年  2> 年月  3> 年月日 )


** W-VVV-WRK-1       : 依檢驗類別列印工作清單    ( Y> 是  N> 否 )
** W-VVV-WRK-2       : 工作清單印抗生素代碼      ( Y> 是  N> 否 )
** W-VVV-WRK-3       : 每日檢驗登記簿印抗生素代碼( Y> 是  N> 否 )
** W-VVV-WRK-4       : 工作清單與每日登記簿印簡表( Y> 是  N> 否 )
** W-VVV-SAV-PRT     : 存檔完列印                ( Y> 是  N> 否 )

** W-VVV-RPT-END-1   : 報告表尾備註一
** W-VVV-RPT-END-2   : 報告表尾備註二

*COPY    "HM_SID0.WRK".
*   檔案對應RECORD暫存變數 (與 HMSID-REC 同)
 01  W-SID-REC.
    02  W-SID-KEY.
*       >系統代號 (ex. 'HM':醫學研究, 'HT':檢驗室, 'TV':微生物室)
        03  W-SID-SYS-CODE.
*           部/局
            04  W-SID-SYS-CODE1                     PIC X.
*           課/區
            04  W-SID-SYS-CODE2                     PIC X.
    02  W-SID-DATA.
*       >系統名稱
        03  W-SID-SYS-NAME                          PIC X(40).
*       >系統管理者代號
        03  W-SID-USER-NO                           PIC X(10).
*       >系統管理者密碼
        03  W-SID-USER-PASS                         PIC X(10).
*       >資料內容 (格式由 程式中重新定義)
        03  W-SID-REMARK.
            04  W-SID-REMARK1                       PIC X(60).
            04  W-SID-REMARK1-REDEF REDEFINES W-SID-REMARK1.
*               >科室簡碼(T)
                05  W-SID-DPTC                      PIC X.
*               >作業類別代號(13)
                05  W-SID-CLS                       PIC X(02).
*               >單位代號
                05  W-SID-DPT-NO                    PIC X(05).
*               >ＯＲＳＡ菌(STAAUR0)
                05  W-SID-ORSA-VIR                  PIC X(07).
*               >ＯＲＳＡ藥(OX)
                05  W-SID-ORSA-ANT                  PIC X(05).
*               >檢驗登記簿(Y/N)
                05  W-SID-REC-BOOK                  PIC X(01).
*               >儀器連線(Y/N)
                05  W-SID-EQU-NET                   PIC X(01).
*               >已完成且列印過後;單日檢驗批次列印則不再列出該單號
                05  W-SID-PRT-OVER                  PIC X(01).
*               >檢驗登記簿依檢驗日期分頁(Y分/N不分) -- DEAFULT = Y
                05  W-SID-REC-PAGE                  PIC X(01).
*               >工作清單
                05  W-SID-WRK-LIST                  PIC X(01).
*               >先檢後批
                05  W-SID-PRE-TEST                  PIC X(01).
*               >與檢驗系統連線
                05  W-SID-HT-LINK                   PIC X(01).
*               >使用舊式敏感性、抗藥性統計表
                05  W-SID-OLD-RS-RPT                PIC X(01).

*               >分離菌株統計表細分至菌株
                05  W-SID-NEW-VR-RPT                PIC X(01).
*               >微生物檢驗報告格式
                05  W-SID-RPT-TYP                   PIC X(01).
*               >空白項
                05  W-SID-FILLER                    PIC X(30).
            04  W-SID-REMARK2                       PIC X(60).
            04  W-SID-REMARK2-REDEF REDEFINES W-SID-REMARK2.
                05  W-SID-ANTNO1 OCCURS 12 TIMES    PIC X(05).
            04  W-SID-REMARK3                       PIC X(60).
            04  W-SID-REMARK3-REDEF REDEFINES W-SID-REMARK3.
                05  W-SID-ANTNO2 OCCURS 12 TIMES    PIC X(05).




*COPY    "HM_SYS0.WRK".
*<< BOF OF HM_SYS0.WRK >>*******************************************************
*   檔案對應RECORD暫存變數 (與 HMSYS-REC 同)
 01  W-SYS-REC.
    02  W-SYS-KEY.
*       系統代號 (ex. HT:檢驗)
        03  W-SYS-SYS-CODE.
*           部/局
            04  W-SYS-SYS-CODE1                PIC X.
*           課/區
            04  W-SYS-SYS-CODE2                PIC X.
*       使用者代號 (員工代號)
        03  W-SYS-USER-NO                      PIC X(10).
*   使用者密碼
    02  W-SYS-USER-PASS                        PIC X(10).
*   屬性樣板代號 (與HT_ATTX相關連)
    02  W-SYS-ATT-CODE                         PIC X(2).
*   系統密碼啟用日期
    02  W-SYS-DATE-FROM.
        03  W-SYS-DATEF-YYY                    PIC 9(3).
        03  W-SYS-DATEF-MM                     PIC 9(2).
        03  W-SYS-DATEF-DD                     PIC 9(2).
*   系統密碼停用日期
    02  W-SYS-DATE-TO.
        03  W-SYS-DATET-YYY                    PIC 9(3).
        03  W-SYS-DATET-MM                     PIC 9(2).
        03  W-SYS-DATET-DD                     PIC 9(2).
*   同一系統下使用者權限
    02  W-SYS-PWD-RIGHT                        PIC X(60).
*   同一系統下詢問密碼否
    02  W-SYS-PWD-ASK                          PIC X(60).
*   系統備註
    02  W-SYS-PWD-REMARK                       PIC X(60).
 01  W-SYS-REF.
*   系統管理者
    02  W-SYS-SYS-OWNER                        PIC X(10).
*   系統名稱
    02  W-SYS-SYS-NAME                         PIC X(40).
*   樣板名稱
    02  W-SYS-ATT-NAME                         PIC X(40).
*<< EOF OF HM_SYS0.WRK >>*******************************************************




*97.07.08(MONIYA)病歷互通加解密
*COPY    "HH_PTDEC.LNK".
**************************************************************************
*>      病歷資料寫檔、刪檔、解密 HH_PTDEC.LNK <<HHPTDECF.CBL>>           *
*>      CALL "HHPTDECF" USING W-PTDECF-LNK ON EXCEPTION CONTINUE END-CALL*
**************************************************************************
*病歷互通需加解密的欄位                                                  *
*病患生日：pat_birth_dt、pa2_birth_dt                                    *
*病患姓名：pat_name、pa2_name                                            *
*身份證號：pat_idno、pa2_idno                                            *
*病患住址：pat_addr、pa2_addr、pa2_addr1                                 *
*公司電話：pat_tel1                                                      *
*居家電話：pat_tel2、pa2_tel3                                            *
*E-MAIL  ：pa2_email                                                     *
**************************************************************************
 01      W-PTDECF-LNK.
*>      處理識別：W>新增WRITE(依參數加密Encryption)、R>修改REWRITE(依參數加密Encryption)
*>                D>刪除(Delete) -> 刪除部份只處理 HH_MTEL、HH_MPAT、HH_MAP2、HH_MPA3、HH_MPAL，其餘檔案請各系統自行處理
*>                O>解密(Decryption)
*>                A>單一身份證加密(Encryption)
*>                B>單一病歷號解密(Decryption)
*>                Z>判斷寫檔時PAT-MST-STATUS狀態若為[99]則將此紀錄寫入病歷異動紀錄檔
               02      W-PTDECF-IO-SW                          PIC X(01).
*>      處理檔案HH_MPAT
               02      W-PTDECF-IO-HHPAT-YN                    PIC X(01).
*>      處理檔案HH_MPA2
               02      W-PTDECF-IO-HHPA2-YN                    PIC X(01).
*>      處理檔案HH_MPA3
               02      W-PTDECF-IO-HHPA3-YN                    PIC X(01).
*>      病歷號碼
               02      W-PTDECF-PAT-NO                         PIC 9(08).
*>      處理：Y>成功、N>失敗
               02      W-PTDECF-IO-YN                          PIC X(01).
*>      處理失敗訊息
               02      W-PTDECF-IO-ERR-MSG                     PIC X(80).
*>      登入資料
               02      W-PTDECF-LOGIN-DATA.
*>              程式名稱（如：HHPATKF...等）
                       03      W-PTDECF-PROG-ID                PIC X(10).
*>              C-PY FILE（如：HT_PAT0.PRC...等）
                       03      W-PTDECF-COPY-FILE              PIC X(20).
*>              程式段名(如：F-HH-FPAT-REA...)
                       03      W-PTDECF-PROG-PARA              PIC X(30).
*>              程式中文說明(如：病歷維護作業-TEXT、住院申請-GUI...)
                       03      W-PTDECF-PROG-NM                PIC X(20).
*>              功能選項(如：[1 ]、[F1]...等作業功能，或由各系統自行編號活用)
                       03      W-PTDECF-FUN-SEL                PIC X(02).
*>              異動人代碼(員工編號)
                       03      W-PTDECF-UPD-UID                PIC X(05).
*>      病歷主檔 (PAT-MST-REC 共 [520] 長)
               02      W-PTDECF-PAT-MST-REC                    PIC X(520).
*>      病歷主檔(二) (PA2-MST-REC 共 [386] 長)
               02      W-PTDECF-PA2-MST-REC                    PIC X(386).
*>      病歷主檔(三) (HHPA3-MST-REC 共 [508] 長)

               02      W-PTDECF-HHPA3-MST-REC                  PIC X(508).
*>      預留
               02      W-PTDECF-FILLER.
*>              HHPAT-MST 寫檔檔案狀態
                       03      W-PTDECF-IO-HHPAT-STATUS        PIC X(02).
*>              HHPA2-MST 寫檔檔案狀態
                       03      W-PTDECF-IO-HHPA2-STATUS        PIC X(02).
*>              HHPA3-MST 寫檔檔案狀態
                       03      W-PTDECF-IO-HHPA3-STATUS        PIC X(02).
*>              單一身份證加密輸入條件
                       03      W-PTDECF-INPUT-PAT-IDNO-DATA.
                               04 W-PTDECF-INPUT-PAT-IDNO      PIC X(10).
                               04 W-PTDECF-INPUT-PAT-BIRTH-DT  PIC S9(7).
*>              單一身份證加密輸出條件
                       03      W-PTDECF-OUTPUT-PAT-IDNO-DATA.
                               04 W-PTDECF-OUTPUT-PAT-IDNO     PIC X(10).
*>              E-TABLE 病歷互通查詢作業呼叫
                       03      W-PTDECF-E-PROG-CALL-YN         PIC X(01).
*>              是否要進行 HHPAL 寫檔，若不搬是預設要寫檔，搬 N 是不寫入 HHPAL
                       03      W-PTDECF-HHPAL-WRT-YN           PIC X(01).
*>              單一出生日加密輸出條件
                       03      W-PTDECF-OUTPUT-PAT-BIRTH-DT-DATA.
                               04 W-PTDECF-OUTPUT-PAT-BIRTH-DT PIC S9(7).
*>              單一病歷號解密輸入條件
                       03      W-PTDECF-INPUT-PAT-NO           PIC X(8).
*>              單一病歷號解密輸出條件
                       03      W-PTDECF-OUTPUT-PAT-NO          PIC X(8).
*>              預留欄位
                       03      W-PTDECF-FILLER-1               PIC X(192).
*>106.09.04(柏勝)
 01      W-PTDECF2-LNK.
*>      處理檔案HH_MPA7
               02      W-PTDECF-IO-HHPA7-YN                    PIC X(01).
*>      HHPA7-MST 寫檔檔案狀態
               02      W-PTDECF-IO-HHPA7-STATUS                PIC X(02).
*>      病歷主檔(七) (HHPA7-MST-REC 共 [508] 長)
               02      W-PTDECF-HHPA7-MST-REC                  PIC X(508).
*>      預留
               02      W-PTDECF2-FILLER.
*>              預留欄位
                       03      W-PTDECF2-FILLER-1               PIC X(1521).

*>106.06.07 桃醫-檢驗放射線查詢作業刪除檢驗單時，需重印重驗單
*COPY    "HT_ICB2BF.LNK".
*****************
* HT_ICB2BF.lnk *
*****************
 01  L-HTICB2BF-LNK.
    02  L-HTICB2BF-STATUS               PIC X(1).
    02  L-HTICB2BF-IP-NO                PIC X(22).
    02  L-HTICB2BF-CR-MAN               PIC X(5).
    02  L-HTICB2BF-CR-DATE              PIC 9(7).
    02  L-HTICB2BF-CR-TIME              PIC 9(6).
    02  L-HTICB2BF-IP-MAN               PIC X(4).
    02  L-HTICB2BF-IP-DATE              PIC 9(7).

 01  L-HTICB2BF-LNK2.

    02  L-HTICB2BF-CHK-NO               PIC X(8).
    02  L-HTICB2BF-FIL                  PIC X(242).


*>END 106.06.07
*>
 01 W-TMP-PARA                   PIC X(1).
 01 W-PARAMETERS                 PIC 9(04) COMP-1.
*>
 01      W-YYZ                           PIC Z(04).
 01      NID-MST-STATUS                  PIC XX IS EXTERNAL.
 01      PAT-MST-STATUS                  PIC XX IS EXTERNAL.
 01      IPD-MST-STATUS                  PIC XX IS EXTERNAL.
 01      IPX-MST-STATUS                  PIC XX IS EXTERNAL.
 01      ICA-MST-STATUS                  PIC XX IS EXTERNAL.
 01      ICB-MST-STATUS                  PIC XX IS EXTERNAL.
 01      BED-MST-STATUS                  PIC XX IS EXTERNAL.
 01      PRS-MST-STATUS                  PIC XX IS EXTERNAL.
 01      ECB-MST-STATUS                  PIC XX IS EXTERNAL.

 01      FON-MST-STATUS                  PIC XX IS EXTERNAL.
 01      DTE-MST-STATUS                  PIC XX IS EXTERNAL.
 01      PEF-MST-STATUS                  PIC XX IS EXTERNAL.
 01      IBG-MST-STATUS                  PIC XX IS EXTERNAL.
 01      RNU-MST-STATUS                  PIC XX IS EXTERNAL.
 01      FNS-MST-STATUS                  PIC XX IS EXTERNAL.
 01      HRDTA-MST-STATUS                PIC XX IS EXTERNAL.
 01      HRDTB-MST-STATUS                PIC XX IS EXTERNAL.

 01      HTSYS-SON-STATUS                PIC X(2) IS EXTERNAL.
 01      HTDPT-MST-STATUS                PIC X(2) IS EXTERNAL.
 01      HTCHK-MST-STATUS                PIC X(2) IS EXTERNAL.
 01      HTRPT-MST-STATUS                PIC X(2) IS EXTERNAL.
 01      HTCLS-MST-STATUS                PIC X(2) IS EXTERNAL.
 01      HTCTM-MST-STATUS                PIC X(2) IS EXTERNAL.
 01      HTCTR-MST-STATUS                PIC X(2) IS EXTERNAL.
 01      HTITM-MST-STATUS                PIC X(2) IS EXTERNAL.
 01      HTREF-MST-STATUS                PIC X(2) IS EXTERNAL.
 01      HTSPL-MST-STATUS                PIC X(2) IS EXTERNAL.
 01      HTBTL-MST-STATUS                PIC X(2) IS EXTERNAL.
 01      HTWRK-MST-STATUS                PIC X(2) IS EXTERNAL.
 01      HTCSP-MST-STATUS                PIC X(2) IS EXTERNAL.
*
 01      W-FS-HTV03                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTV02                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTV05                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTVNO                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTVVV                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTVK1                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTVK2                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTVK3                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTVK4                      PIC X(2) IS EXTERNAL.
 01      W-FS-HMSID                      PIC X(2) IS EXTERNAL.
*
 01      W-FS-HTVHK                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTVHR                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTVH1                      PIC X(2) IS EXTERNAL.

 01      W-FS-HTVPL                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTANT                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTATE                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTATC                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTVIR                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTMIC                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTDDM                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTVRT                      PIC X(2) IS EXTERNAL.
 01      W-FS-HTVR1                      PIC X(2) IS EXTERNAL.
*>
 01      HXSRM-MST-STATUS                PIC XX IS EXTERNAL.
 01      HXSCT-MST-STATUS                PIC XX IS EXTERNAL.
 01      HXSCD-MST-STATUS                PIC XX IS EXTERNAL.
 01      HXSCC-MST-STATUS                PIC XX IS EXTERNAL.
 01      HXSCM-MST-STATUS                PIC XX IS EXTERNAL.
 01      HXSCH-MST-STATUS                PIC XX IS EXTERNAL.
*>
 01      HXANN-MST-STATUS                PIC XX IS EXTERNAL.
*>
 01      W-NID-1000                      PIC X(300) IS EXTERNAL.
 01      W-NID-1099                      PIC X(300) IS EXTERNAL.
 01      W-NID-1198                      PIC X(300) IS EXTERNAL.
 01      W-NID-6101                      PIC X(300) IS EXTERNAL.
 01      W-NID-0503                      PIC X(300).
 01      W-PICB                          PIC X(650).
*> 97.7.23 金額重結
 01      ENB-MST-STATUS                  PIC XX IS EXTERNAL.
 01      IKEY-TMP-STATUS                 PIC XX IS EXTERNAL.
 01      ICC-MST-STATUS                  PIC XX IS EXTERNAL.
 01      ENA-MST-STATUS                  PIC XX IS EXTERNAL.
 01      ENC-MST-STATUS                  PIC XX IS EXTERNAL.
 01      HIEND-MST-STATUS                PIC XX IS EXTERNAL.
*> 103.06.27 (書伶) 修改實際退藥量欄位讀取來源，改讀RTA及RTB。
 01      RTA-MST-STATUS                  PIC XX IS EXTERNAL.
 01      RTB-MST-STATUS                  PIC XX IS EXTERNAL.
*> 103.06.27 END
*>2019/12/24 耀瑄NIS
*>刪除時加寫HR_UDL3
 01      HRUDL3-MST-STATUS               PIC X(02) IS EXTERNAL.
*>記錄ICA寫檔錯誤碼[7]
 01      LOG2-MST-STATUS                 PIC X(02) IS EXTERNAL.
*------->檔案相關變數...
 01 W-FS                         PIC 9(02).
        88 W-FS-OK              VALUE 00 THRU 09.
        88 W-FS-EOF             VALUE 10.
***********************************************************************
 78      W-EXIT                  VALUE IS 2027.
 78      W-SEARCH                VALUE IS 2028.
 78      W-DEL                   VALUE IS 2029.
 78      W-DELETE                VALUE IS 2030.
 78      W-PRINT                 VALUE IS 2031.
 78      W-REPORT                VALUE IS 2032.
 78      W-DATA                  VALUE IS 2033.
 78      W-EXIT2                 VALUE IS 2034.
 78      W-RCB1                  VALUE IS 2035.
 78      W-RCB2                  VALUE IS 2036.
 78      W-RCB3                  VALUE IS 2037.

***********************************************************************
 01      W-WRK.
        02      W-NOTE          PIC X(60).
        02      W-SEQ           PIC Z(04).
        02      W-II            PIC 9(03).
        02      W-PAGE          PIC 9(03).
        02      W-NO            PIC 9(04).
        02      W-NUM           PIC 9(06).
*>      02      W-TYPE          PIC X(04).
        02      W-FEE-NAME      PIC X(32).
        02      W-RX-UQTY1      PIC ZZZ9.
        02      W-RX-UQTY2      PIC ZZZ9.
        02      W-RX-QTY1       PIC ZZZ9.
        02      W-RX-QTY2       PIC Z9.
        02      W-RTB-MARK      PIC X(01).
        02      W-RK-DUTY-ID1   PIC X(05).
        02      W-DIS-AC-NAME   PIC X(12).
*--->計算次劑量或數量
        02      W-QTY1          PIC 9(07).
        02      W-QTY2          PIC 9(04).
        02      W-DIS-QTY       PIC X(12).
        02      W-CHK-EXIT      PIC X(01).
*-->判斷是否要查詢刪除處方"D"
        02      W-TYPE1         PIC X(01).
        02      W-GRID-Y        PIC 9(03).
        02      W-GRID-Y1       PIC 9(03).
*--->區分HRRCB123IF
        02      W-TMP-ECB-TYPE  PIC X(01).
        02      W-FORM-TITLE    PIC X(22).
        02      W-GCK-CHK       PIC X(01).
        02      W-TMP-ICB-OP-BDATE      PIC Z(07).
        02      W-TMP-ICB-OP-EDATE      PIC Z(07).
*>
 01 W-IPLIF-LNK.
        02      W-LNK-IPL-NO.
                03      W-LNK-IPL-DT    PIC 9(7).
                03      W-LNK-IPL-SEQ   PIC 9(4).
        02      W-LNK-PAT-NO            PIC 9(8).
*------->是否有傳值回去(Y/N).........
        02      W-LNK-IPL-YN            PIC X(1).
***********************************************************************
 01      W-TOP-TITLE                     PIC X(130).
 01      W-DPT-NAME                      PIC X(20).
 01      W-HT-DATA-TITLE                 PIC X(40).
 01      W-HRDTA-COUNT                   PIC 9(03).
 01      W-TMP-IBGCF-IPD-BED             PIC X(06).
***********************************************************************
 01 W-TITLE-DATA.
        02      W-PAT-NO                PIC Z(08).
        02      W-PAT-NAME              PIC X(12).
        02      W-SEX                   PIC X(02).
        02      W-AGE                   PIC Z(03).
        02      W-AGE-UNIT              PIC X(02).
        02      W-IPD-UNIT-NAME         PIC X(24).
        02      W-BED                   PIC X(07).
        02      W-IPD-DT                PIC Z(07).
        02      W-IPD-SEQ1              PIC 9(04).

        02      W-IPD-OUT-DT            PIC Z(07).
        02      W-IPD-MJ-DR             PIC X(12).
        02      W-IPD-RD-DR             PIC X(12).
        02      W-IPD-DPT               PIC X(16).
        02      W-IPD-MARK              PIC X(24).
 01 W-HT-DATA.
        02      W-AC-NAME               PIC X(12).
        02      W-AC-DATE               PIC Z(07).
        02      W-AC-TIME               PIC X(08).
        02      W-ITM-NM                PIC X(40).
        02      W-SPL-NM                PIC X(20).
        02      W-BTL-NM                PIC X(20).
        02      W-RP-F-NAME             PIC X(12).
        02      W-RP-L-NAME             PIC X(12).
        02      W-RP-DATE               PIC Z(07).
        02      W-RP-TIME               PIC X(08).
***********************************************************************
*> 將GRID的資料存在W-DIS-TABLE
***********************************************************************
 78      W-MENU-ITEMS                    VALUE 16.
 01      W-MENU-SEL                      PIC 9(2) VALUE 1.
        88 W-EXIT-SEL                   VALUE 99.
*>
 01      W-KEY-TABLE.
        02 W-KEY-TBL1 OCCURS 100 TIMES.
                03 W-KEY1               PIC X(300).
*>START                 (AICE) 106.11.09 增加顯示已刪除之檢驗項目
                03 W-KEY2               PIC X(300).
*>END 106.11.09
***********************************************************************
 01      W-DIS-TABLE.
        02      W-DIS-TABLE1.
                03      W-DIS-DATA OCCURS W-MENU-ITEMS TIMES.
*>                      04      W-DISR  PIC X(80).
                        04      W-DISR  PIC X(115).
        02      W-DIS-TABLE3.
                03      W-DIS-TABLE31 OCCURS W-MENU-ITEMS TIMES.
                        04      W-DIS-REC       PIC X(400).
*>START                 (AICE) 106.11.09 增加顯示已刪除之檢驗項目
                        04      W-HRDTB-REC     PIC X(207).
*>END 106.11.09
                        04      W-DIS-CLS-CD    PIC X(02).
                        04      W-DIS-DPT-NO    PIC X(01).
                        04      W-DIS-CHK-NO    PIC X(08).
                        04      W-DIS-ITM-CD    PIC X(06).
                        04      W-DIS-NAME      PIC X(40).
*> 簽收時間
                        04      W-DIS-AC-MAN    PIC X(05).
                        04      W-DIS-AC-DATE   PIC 9(07).
                        04      W-DIS-AC-TIME.
                                05      W-DIS-AC-HH     PIC 9(02).
                                05      W-DIS-AC-MM     PIC 9(02).
                                05      W-DIS-AC-SS     PIC 9(02).
*> 報告時間
                        04      W-DIS-RP-F-MAN  PIC X(05).
                        04      W-DIS-RP-L-MAN  PIC X(05).
                        04      W-DIS-RP-DATE   PIC 9(07).

                        04      W-DIS-RP-TIME.
                                05      W-DIS-RP-HH     PIC 9(02).
                                05      W-DIS-RP-MM     PIC 9(02).
                                05      W-DIS-RP-SS     PIC 9(02).
*> 項目名稱
                        04      W-DIS-ITM-NM    PIC X(40).
*> 檢體
                        04      W-DIS-SPL-NM    PIC X(20).
*> 容器
                        04      W-DIS-BTL-NM    PIC X(20).
*> 改門診申報
                        04      W-DIS-OPD-APY   PIC X(01).
                        04      W-HTCHK-IP-DATE PIC 9(07).

*>---暫存檔名---
 01 W-TRTB-REC.
        10 FILLER       PIC X(07) VALUE "ZPT.DIR".
        10 W-TMP1-OS    PIC X(01).
        10 W-TMP-NM.
                20 FILLER       PIC X(07) VALUE "HO_TRTB".
                20 W-TMP1-SS    PIC 9(02).
 01      W-LOC.
        03      W-TMP-NM-H      PIC X(09).
        03      W-LOC-HOST      PIC X(05) VALUE IS "_HOST".
***********************************************************************
*> HRRCB2IF
***********************************************************************
*COPY    "HT_ODRW.LNK".
*************
* C-PY FILE : MT_ODRW.LNK 890424-890510 作者：謝枝財
* CALL "HTODRWCF" USING W-ODRW-TABLE    檢驗檢查進度查詢參數檔
*************
 01 W-ODRW-TABLE.
** 進度查詢傳輸資料
   02 W-ODRW-IP-NO                       PIC X(22).
**    醫令序號
   02 W-ODRW-IP-NO1 REDEFINES W-ODRW-IP-NO.
**    門診醫令序號
      03 W-ODRW-RO-NO                   PIC 9(11).
**       門診序號                       -- ODR-RO-NO
      03 W-ODRW-RO-SEQ                  PIC 9(2).
**       處方序號                       -- ODR-ODR-SEQ
      03 W-ODRW-RO-FL                   PIC X(9).
**       空白項
   02 W-ODRW-IP-NO2 REDEFINES W-ODRW-IP-NO.
**    住院醫令序號
      03 W-ODRW-PD-NO                   PIC 9(11).
**       住院序號                       -- ICB-IPD-NO
      03 W-ODRW-PD-SEQ                  PIC 9(11).
**       處方序號                       -- ICB-ODR-NO
   02 W-ODRW-PRS.
**    處置查詢資料
      03 W-ODRW-PRS-SEQ                 PIC 9(3).
**       處置序號                       -- ICB-FEE-SEQ OR ODR-FEE-NO
      03 W-ODRW-CHK-NO                  PIC X(8).
**       檢驗檢查單號                   -- ICB-CHK-NO  OR ODR-CHK-NO
      03 W-ODRW-ITM-CD                  PIC X(6).

**       檢驗檢查項目代碼               -- ICB-ITM-CD  OR ODR-ITM-CD
      03 W-ODRW-TRN-SW                  PIC X(1).
**       可異動碼                       -- Y > 可異動分單序號或刪除處置
      03 W-ODRW-WK-SW                   PIC X(1).
**       作業流程碼 : A> 醫令開立, B> 檢體指示, C> 檢體取樣, D> 檢體送檢,
**                    E> 醫令排檢, F> 醫令簽收, G> 醫令外送, H> 醫令檢查,
**                    I> 醫令耗材, J> 結果報告, K> 報告審核
      03 W-ODRW-WK-NAME                 PIC X(8).
**       作業流程名稱
   02 W-ODRW-DEL-SW                     PIC X(1).
**    可異動碼                          -- Y > 可刪除整張處置(由刪除進去)
*COPY    "HX_GSCH.LNK".
* ==SCL== 2003.01.23 START ----- 增加住院醫令護理站分散式 ---------- *
*************
* C-PY FILE : HX_GSCH.LNK 901106-910318  作者：謝枝財
* CALL "HXSCHCF" USING LX-SCH-TABLE     檢查類別病患日排檢連結檔
*************
 01 LX-SCH-TABLE.
   02 LX-SCH-FUN-SW                     PIC X(1).
**    排檢項功能鍵碼(Y/N)               -- 91/03/18
   02 LX-SCH-PT-NO                      PIC 9(8).
**    病歷號碼
   02 LX-SCH-PT-ID                      PIC X(10).
**    身份字號
   02 LX-SCH-PT-NAME                    PIC X(12).
**    姓名
   02 LX-SCH-PT-DATE                    PIC S9(7).
**    出生日
   02 LX-SCH-PT-SEX                     PIC X(1).
**    性別
   02 LX-SCH-PT-BED.
**    床號
      04 LX-SCH-PT-BED-ROOM             PIC X(04).
      04 LX-SCH-PT-BED-NO               PIC X(02).
   02 LX-SCH-IP-NO                      PIC X(22).
**    醫令序號
   02 LX-SCH-IP-NO1 REDEFINES LX-SCH-IP-NO.
**    門診醫令序號
      03 LX-SCH-RO-NO                   PIC 9(11).
**       門診序號
      03 LX-SCH-OR-NO                   PIC 9(2).
**       處方序號
      03 LX-SCH-RO-FL                   PIC X(9).
**       空白項
   02 LX-SCH-IP-NO2 REDEFINES LX-SCH-IP-NO.
**    住院醫令序號
      03 LX-SCH-PD-NO                   PIC 9(11).
**       住院序號
      03 LX-SCH-OD-NO                   PIC 9(11).
**       處方序號
* ==SCL== 2003.01.23 START ----- 增加住院醫令護理站分散式 ---------- *
   02 LX-SCH-SCP-PRINT-SW               PIC X(01).
**    排程單特殊印表方式
   02 LX-SCH-QUE-UNIT                   PIC X(05).
**    護理站代碼
* ==SCL== 2003.01.23 END   ----- 增加住院醫令護理站分散式 ---------- *
   02 LX-SCH-FILLER                     PIC X(54).

**    保留
   02 LX-SCH-DATA-PRS OCCURS 98 TIMES.
      03 LX-SCH-CMD-ISW                 PIC X(1).
**       前端增修刪功能碼 (C:新增處置, D:刪除處置, M:修改處置排檢時段)
      03 LX-SCH-CMD-OSW                 PIC X(1).
**       後端增修刪功能碼 (C:新增處置, D:刪除處置, M:修改處置排檢時段)
      03 LX-SCH-PRS-NO                  PIC X(9).
**       處置代碼                       -- PRS-MST-ID (IF PEF-MST-REC(436:1) = 'Y')
      03 LX-SCH-PRS-DPT                 PIC X(1).
**       檢查科室簡碼                   -- PRS-PAS-DPT
      03 LX-SCH-PRS-CLS                 PIC X(2).
**       檢查單據類別代碼               -- PRS-PAS-TAB
      03 LX-SCH-PRS-ITM                 PIC X(6).
**       檢查細項代碼                   -- PRS-PAS-ITM
      03 LX-SCH-NEW-DATE                PIC 9(7).
**       診間新排檢日期                 -- ICB-PAS-DAT OR ODR-PAS-DAT
      03 LX-SCH-NEW-TIME                PIC 9(4).
**       診間新排檢時分                 -- ICB-PAS-TIM OR ODR-PAS-TIM
      03 LX-SCH-OLD-DATE                PIC 9(7).
**       診間原排檢日期                 -- ICB-PAS-DAT OR ODR-PAS-DAT
      03 LX-SCH-OLD-TIME                PIC 9(4).
**       診間原排檢時分                 -- ICB-PAS-TIM OR ODR-PAS-TIM
      03 LX-SCH-PRS-SEQ                 PIC 9(3).
**       處置序號                       -- ICB-FEE-SEQ OR ODR-FEE-NO
      03 LX-SCH-CRE-SEQ                 PIC 9(4).
**       處置建檔號(住醫不變)           -- ICB-FEE-SEQ OR ODR1-CRE-NO
      03 LX-SCH-FILLER1                 PIC X(30).

**    PEF-MST-REC(436:1) = 'Y'   診間排程檢查項目

**WX-SCH-SCP-PRINT-SW： 空白 & Y >LOACL 列印
*                       N        >不列印
*                       1        >QUE   列印 (住院醫令開，由護理站印出) ，需加傳WX-SCH-QUE-UNIT
*                       2        >QUE   列印 & LOACL 列印               ，需加傳WX-SCH-QUE-UNIT
*COPY    "HT_OLGP.WRK".
*護理站列印紀錄.
 01  W-ODR-LGP    PIC X IS EXTERNAL.
*報表列印結果(N:表失敗)
 01  W-ODR-PRN    PIC X IS EXTERNAL.
 01      W-DIS-CHK-DATA.
               02      W-DIS-AC-NAME   PIC X(12).
               02      W-DIS-RP-F-NAME PIC X(12).
               02      W-DIS-RP-L-NAME PIC X(12).
 01      W-EXT-HEIGHT                    PIC X(05) IS EXTERNAL.
*>01    ECB-OPD-APY                     PIC X(01).

*> 列印檢驗放射單(交科室)
 01      W-ODRPF-PASS-LNK.
*       醫令單號
        02 W-ODRPF-CHK-NO-LNK.
                03 W-ODRPF-CHK-NO1-LNK       PIC X.
                03 W-ODRPF-CHK-NO2-LNK       PIC X(2).
                03 W-ODRPF-CHK-NO3-LNK       PIC 9(5).
*       醫令日期
        02 W-ODRPF-IP-DATE-LNK          PIC 9(7).
*       醫院名稱
        02 W-ODRPF-HOS-NAME-LNK         PIC X(18).

 01      W-ODRPF-PASS2-LNK.
        02 W-ODRPF-P2-LNK  OCCURS 99 TIMES.
                03 W-ODRPF-CTM-CD-LNK        PIC X(6).
 01      W-ODRPF-PASS3-LNK.
*       N:不印"重印"提示
        02 W-ODRPF-REPRN-SW-LNK         PIC X.

*> 檢驗單重印標示識別
 01      W-REPRN-SW                      PIC X(01) IS EXTERNAL.
*> CALL HTRPTICF 專用
 01      W-HTRPTICF-IP-DATE              PIC 9(07).
 01      W-HTRPTICF-RPT-OK               PIC X(01).
 01      W-HTRPTICF-RPT-MESSAGE          PIC X(60).
 01      W-TMP-LNK-POINT                 PIC X(09).
 01      W-TMP-LNK-TIME.
        02      W-TMP-LNK-HH            PIC 9(02).
        02      W-TMP-LNK-MM            PIC 9(02).
        02      W-TMP-LNK-SS            PIC 9(02).
 01      W-TMP-PAT-MST-REC               PIC X(300).
 01      W-TMP-IPD-MST-REC               PIC X(1000).
 01      W-TMP-BED-MST-REC               PIC X(300).
 01      W-LX-SCH-COUNT                  PIC 9(03).
*>START 106.06.07  W-HTICB2BF-LNK 以COPY FILE HT_ICB2BF.LNK取代
*01     W-HTICB2BF-LNK.
**> 作業識別 [1]儲存至暫存檔  [2]結束批次處理
**> 回應訊息 [E]處理失敗
*       02      W-HTICB2BF-STATUS       PIC X(01).
**> 住院序號及處方序號
*       02      W-HTICB2BF-IP-NO        PIC X(22).
**> 操作者
*       02      W-HTICB2BF-CR-MAN       PIC X(05).
**> 目前時間
*       02      W-HTICB2BF-CR-DATE      PIC 9(07).
*       02      W-HTICB2BF-CR-TIME      PIC 9(06).
**> 開立DR
*       02      W-HTICB2BF-IP-MAN       PIC X(04).
**> ip-date
*       02      W-HTICB2BF-IP-DATE      PIC 9(07).
*>END 106.06.07
 01      W-GD-COLOR              PIC 9(05) COMP-1.
*> 檢驗報告查詢使用 (志彥)
 01      W-HT-GUI-SW                     PIC X(01) IS EXTERNAL.
*> 97.7.23 金額重結
 01      W-ODRW-CNT              PIC 9(2).
*COPY    "HI_ODRW.LNK".
*********************************************************************************
* 住院處方異動(新增、修改、刪除)副程式傳遞參數                                  *
* 940201 若LNK總長度擴充，需同步修正程式內W-ODRICF-LNK長度                      *
*********************************************************************************
 01      W-ODRW-LNK.
*>      功能識別(I.新增 M.修改 D.刪除)
        02      W-ODRW-ID                               PIC X(1).
*>      操作者員工代號
        02      W-ODRW-USER                             PIC X(5).
*>      (HT.檢驗簽收 HR.醫令開立 HB.血庫出退庫)
        02      W-ODRW-FROM                             PIC X(2).
*>      處理成功(Y.成功 N.有錯誤)

        02      W-ODRW-OK                               PIC X(1).
*>      處理有誤訊息(W-ODRW-OK = "N")
        02      W-ODRW-NOTE                             PIC X(60).
*>      住院序號
        02      W-ODRW-IPD-NO.
                03      W-ODRW-IPD-DATE                 PIC 9(7).
                03      W-ODRW-IPD-SEQ                  PIC 9(4).
*>      空白.由副程式鎖IKEY-TMP
*>      Y.不由副程式鎖IKEY-TMP，由呼叫程式自行鎖IKEY-TMP
        02      W-ODRW-NO-LOCK                          PIC X(1).
*>      回傳處方序號(I.新增使用)
        02      W-ODRW-ODR-NO                           PIC 9(11).
        02      FILLER                                  PIC X(188).

*>      ICA-MST資料
        02      W-ODRW-ICA-DATA                         PIC X(200).
*>      I.新增(ICA傳遞參數)
        02      WI-ODRW-ICA-DATA        REDEFINES       W-ODRW-ICA-DATA.
*>              處方日期(必填)
                03      WI-ICA-INS-DATE                 PIC 9(7).
*>              處方科別(可不填，預設值帶住院科別IPD-DPT)
                03      WI-ICA-DEPT-NO                  PIC X(4).
*>              處方醫師(可不填，預設值帶主治醫師IPD-MJ-DR)
                03      WI-ICA-DR-NO                    PIC X(4).
*>              處方床號(可不填，預設值帶BDL-BED)
                03      WI-ICA-WARD                     PIC X(6).
                03      FILLER                          PIC X(179).
*>      M.修改(ICA傳遞參數)
        02      WM-ODRW-ICA-DATA        REDEFINES       W-ODRW-ICA-DATA.
*>              處方序號
                03      WM-ICA-ODR-NO.
                        04      WM-ICA-INS-DATE         PIC 9(7).
                        04      WM-ICA-ODR-SEQ          PIC 9(4).
                03      FILLER                          PIC X(189).
*>      D.刪除(ICA傳遞參數)
        02      WD-ODRW-ICA-DATA        REDEFINES       W-ODRW-ICA-DATA.
*>              處方序號
                03      WD-ICA-ODR-NO.
                        04      WD-ICA-INS-DATE         PIC 9(7).
                        04      WD-ICA-ODR-SEQ          PIC 9(4).
                03      FILLER                          PIC X(189).

*>      ICB/ECB相關資料
        02      W-ODRW-ICB-DATA                         PIC X(12901).
*>              I.新增
        02      WI-ODRW-ICB-DATA        REDEFINES       W-ODRW-ICB-DATA.
                03      WI-ICB-DATA     OCCURS 97  TIMES.
*>                      處置代碼(必填)
                        04      WI-ICB-FEE-KEY          PIC X(9).
*>                      數量分子(可不填，預設值為1)
                        04      WI-ICB-RX-QTY1          PIC 9(4).
*>                      數量分母(可不填，預設值為1)
                        04      WI-ICB-RX-QTY2          PIC 9(2).
*>                      付費(計價)(Y/N)(可不填，預設值帶處置代碼設定PRS-INS-PAY/PRS-OWN-PAY)
                        04      WI-ICB-CHG-FLAG         PIC X(1).
*>                      強制自費(Y/ )(可不填，預設值為空白)
                        04      WI-ICB-SP-YN            PIC X(1).

*>                      執行日期(起)(可不填，預設值為空白)
                        04      WI-ICB-OP-BDATE         PIC 9(7).
*>                      執行時間(起)(可不填，預設值為空白)
                        04      WI-ICB-OP-BTIME         PIC 9(4).
*>                      執行日期(迄)(可不填，預設值為空白)
                        04      WI-ICB-OP-EDATE         PIC 9(7).
*>                      執行時間(迄)(可不填，預設值為空白)
                        04      WI-ICB-OP-ETIME         PIC 9(4).
*>                      連帶指標父項(*-->連帶指標、#-->麻醉切割)(可不填，預設值為空白)
                        04      WI-ECB-LNK-POINT-HEAD   PIC X(01).
*>                      連帶指標項次(連帶指標、麻醉首項)(可不填，預設值為空白)
                        04      WI-ECB-LNK-POINT        PIC X(09).
*>                      連帶指標、麻醉切割展開時間(可不填，預設值為空白)
                        04      WI-ECB-LNK-TIME.
                                05      WI-ECB-LNK-HH   PIC 9(02).
                                05      WI-ECB-LNK-MM   PIC 9(02).
                                05      WI-ECB-LNK-SS   PIC 9(02).
*>                      2017/12/28 台南-衛材寫入批價
*>                      ICB寫入失敗
                        04      WI-ICB-WRITE-YN         PIC X(01).
*>                      2019/04/02 台中-執行人員
                        04      WI-ECB-EXECUTE-USR      PIC X(05).
*>                      預留
                        04      FILLER                  PIC X(72).
*>              M.修改(ICB、ECB傳遞參數)
        02      WM-ODRW-ICB-DATA        REDEFINES       W-ODRW-ICB-DATA.
                03      WM-ICB-DATA     OCCURS 97  TIMES.
*>                      作用(I.新增處置 M.替代指定流水號處置 D.刪除指定流水號處置)
                        04      WM-ICB-ID               PIC X(1).
*>                      處置流水號(WM-ICB-ID = "M" OR "D"時，必須有指定值)
                        04      WM-ICB-FEE-SEQ          PIC 9(3).
*>                      處置代碼
                        04      WM-ICB-FEE-KEY          PIC X(9).
*>                      數量分子
                        04      WM-ICB-RX-QTY1          PIC 9(4).
*>                      數量分母
                        04      WM-ICB-RX-QTY2          PIC 9(2).
*>                      檢驗檢查單號(HTCHK-CHK-NO)
                        04      WM-ICB-CHK-NO.
*>                              檢驗檢查類別代號(HTCHK-CLS-NO)
                                05      WM-ICB-CLS-NO   PIC X(3).
*>                              開單流水碼(HTCHK-PR-SEQ)
                                05      WM-ICB-PR-SEQ   PIC 9(5).
*>                              檢驗檢查項目代碼(HTCHK-ITM-CD)
                                05      WM-ICB-ITM-CD   PIC X(6).
*>                      付費(計價)(Y/N)
                        04      WM-ICB-CHG-FLAG         PIC X(1).
*> 2005/6/10
*>                      連帶指標父項(*-->連帶指標、#-->麻醉切割)(可不填，預設值為空白)
                        04      WM-ECB-LNK-POINT-HEAD   PIC X(01).
*>                      連帶指標項次(連帶指標、麻醉首項)(可不填，預設值為空白)
                        04      WM-ECB-LNK-POINT        PIC X(09).
*>                      連帶指標、麻醉切割展開時間(可不填，預設值為空白)
                        04      WM-ECB-LNK-TIME.
                                05      WM-ECB-LNK-HH   PIC 9(02).
                                05      WM-ECB-LNK-MM   PIC 9(02).
                                05      WM-ECB-LNK-SS   PIC 9(02).

*
                        04      FILLER                  PIC X(83).
*97.10.15(MONIYA)新增檢核先判斷資料是否能刪除再繼續往下執行
 01      W-DELETE-YN             PIC X(01).
*> IKEY-TMP 鎖檔作業
*COPY    "HI_KMPCF.LNK".
******************************************************************************
*       C-PY FILE : HI_KMPCF.LNK        呼叫    HIKMPCF 傳遞之參數
*>      2012/9/17 新增住院序號、處方序號 - 昱志
******************************************************************************
 01      W-LNK-KMPCF.
*>      病歷號碼
        03      W-KMPCF-PAT-NO          PIC 9(08).
*>      功能識別(W->WRITE, D->DELETE)
        03      W-KMPCF-FUN-ID          PIC X(01).
*>      不成功時之執行次數
        03      W-KMPCF-CNT             PIC 9(03).
*>      是否成功-->Y
        03      W-KMPCF-OK              PIC X(01).
*>      執行作業
        03      W-KMPCF-JOB             PIC X(08).
*>      錯誤訊息
        03      W-KMPCF-NOTE            PIC X(60).
*>      使用者
        03      W-KMPCF-USER            PIC X(05).
*>      2012/9/17 住院序號
        03      W-KMPCF-IPD-NO.
                05 W-KMPCF-IPD-DATE     PIC 9(07).
                05 W-KMPCF-IPD-SEQ      PIC 9(04).
*>      2012/9/17 處方序號
        03      W-KMPCF-ODR-NO.
                05 W-KMPCF-INS-DATE     PIC 9(07).
                05 W-KMPCF-ODR-SEQ      PIC 9(04).
*>      預留
*>      2012/9/17 新增住院序號、處方序號 X(95)-->X(73).
        03      W-KMPCF-DATA            PIC X(73).
******************************************************************************
*       END     OF      FILE
******************************************************************************
*>---98.02.02---
*>      ---M：主程式、S：副程式、O：副程式(由.NET呼叫)
 01      W-SOU                   PIC X(01).
 01      W-HTCGUICF-EXT-PT-NO    PIC 9(08) IS EXTERNAL.
*>---(AICE) 98.05.15 電子病歷查印紀錄 ---
*COPY    "HZ_RCD.LNK".
***********************
*-> 電子病歷異動紀錄LINK
***********************


 01      L-HZRCDCF-LNK.
*>      識別 (M-維護 I-查詢 R-印表  )
        02 L-RCD-ID             PIC X(01).
*>      作業人員 員工編號
        02 L-RCD-USER           PIC X(05).
*>      系統
        02 L-RCD-SYS            PIC X(04).

*>      程式名稱
        02 L-RCD-PROG           PIC X(15).
*>      病歷號
        02 L-RCD-PAT-NO         PIC 9(08).
*>      病患身分證
        02 L-RCD-PAT-ID         PIC X(10).
*>      醫師代碼
        02 L-RCD-DC-ID          PIC X(05).
*>      記錄方式 (1-xml 2-圖檔 3-web form)
        02 L-RCD-REC-WAY        PIC X(01).
*>      判斷是否進行壓縮
        02 L-RCD-ARCH-YN        PIC X(01).
*>      判斷是否打包
        02 L-RCD-OPEN-YN        PIC X(01).
*>      告知有兩個以上的報表要打包
        02 L-RCD-TWOUP-YN       PIC X(01).
*>      報表路徑
        02 L-RCD-RPT-PTH        PIC X(40).
*>      報表檔名
        02 L-RCD-RPT-NAME       PIC X(20).
*>      備註
        02 L-RCD-MEMO           PIC X(100).
*>      PVS參數
        02 L-RCD-PVS-TBL.
                03 L-RCD-PVS-RPTF           PIC X(100).
                03 L-RCD-PVS-WINDOW         PIC X(10).
                03 L-RCD-PVS-LINE           PIC 9(02).
                03 L-RCD-PVS-COL            PIC 9(02).
                03 L-RCD-PVS-COLOR          PIC 9(05).
                03 L-RCD-PVSS               PIC X(01).
                03 L-RCD-PVSD               PIC X(01).
                03 L-RCD-PVSQ               PIC 9(02).
                03 L-RCD-PVSROW             PIC 9(02).
                03 L-RCD-PVSCOL             PIC 9(02).
                03 L-RCD-PVSSAVE            PIC X(01).
                03 L-RCD-PVSSASW            PIC X(01).
                03 L-RCD-PVSPROG            PIC X(07).
                03 L-RCD-PVSE               PIC 9(03).
                03 L-RCD-POLP               PIC X(01).
                03 L-RCD-PVSTROW            PIC 9(03).
                03 L-RCD-PVSTCOL            PIC 9(03).
                03 L-RCD-PVS-FILLER         PIC X(43).
*
                03 L-RCD-PVSL-RCD-TBL.
                        04 L-RCD-PVSP            PIC X(01).
                        04 L-RCD-PVSH            PIC X(01).
                        04 L-RCD-PUSW            PIC X(02).
                        04 L-RCD-PWSW            PIC X(10).
                        04 L-RCD-PHSW            PIC X(10).
                        04 L-RCD-PPSW            PIC X(10).
                        04 L-RCD-PLFL            PIC X(08).
                        04 L-RCD-PLVW            PIC X(01).
                        04 L-RCD-PLSA            PIC X(01).

*>      選單群組
        02 L-RCD-RUN-SBGP                       PIC X(10).
*>      系統描述

        02 L-RCD-RUN-DES-B                      PIC X(40).
*>      異動紀錄預留(已有用)
        02 L-RCD-OTH                            PIC X(05).
*>      I的判斷 1.空白:原作法(僅做查印),2.大寫'Y':PDF+簽章,3.P:PDF但不簽章 4.大寫N:不做
        02 L-RCD-LOGSG-SW-I                     PIC X(01).
*>      M的判斷 1.空白:原作法(僅做查印),2.大寫'Y':PDF+簽章,3.P:PDF但不簽章 4.大寫N:不做
        02 L-RCD-LOGSG-SW-M                     PIC X(01).
*>      R的判斷 1.空白:原作法(僅做查印),2.大寫'Y':PDF+簽章,3.P:PDF但不簽章 4.大寫N:不做
        02 L-RCD-LOGSG-SW-R                     PIC X(01).
*>      判斷同一查詢條件下,有複數印表條件並做出複數報表的程式判斷
        02 L-RCD-IMG-RUNNING-YN                 PIC X(01).
*>      預留
        02 L-RCD-FILLER                         PIC X(241).
        02 L-RCD-DATA1  REDEFINES L-RCD-FILLER.
*2010/8/18 MARS 增加回傳HZRCD的KEY值
                03      L-RCD-KEY               PIC X(37).
*2010/8/19 MARS 增加報表轉PDF的資料
                03      L-RCD-TXT-TO-PDF        PIC X(60).
*>              2010/9/2 MARS 增加電子病歷宣告群組
                03      L-RCD-GROUP             PIC X(2).
*>              2010/9/2 MARS 增加電子病歷暫存(N)與正式(R)的識別
                03      L-RCD-CHK-ID            PIC X(1).
*>              2010/9/2 MARS 增加表單編號
                03      L-RCD-SN                PIC X(5).
*預留
                03      L-RCD-FILLER1           PIC X(136).

*COPY    "HZ_PAM.LNK".
**************************
*電子病歷異動紀錄參數主檔*
**************************

 01      L-PAM-LNK.
*>      識別 (M-維護 I-查詢 R-印表)
        02 L-PAM-ID             PIC X(01).
*>      查印紀錄機制是否啟動
*>      2010/3/30 改為 FOR 查詢-紀錄機制是否啟動
        02 L-PAM-LOG-YN         PIC X(01).
*>      電子簽章機制是否啟動
*>      2010/3/30 改為 FOR 查詢-電子簽章機制是否啟動
        02 L-PAM-PKI-YN         PIC X(01).
*>      圖檔壓縮機制是否啟動
        02 L-PAM-ARCH-YN        PIC X(01).
*>      紀錄資料保留天數
        02 L-PAM-LOGDAY         PIC 9(04).
*>      系統
        02 L-PAM-SYS            PIC X(04).
*>      程式名稱(EX.HPXXXIF)
        02 L-PAM-PROG           PIC X(15).
*>      印表-紀錄機制是否啟動
        02 L-PAM-LOG-R-YN       PIC X(01).
*>      印表-電子簽章機制是否啟動
        02 L-PAM-PKI-R-YN       PIC X(01).
*>      維護-異動紀錄是否啟動
        02 L-PAM-LOG-M-YN       PIC X(01).
*>      維護-紀錄機制是否啟動PKI
        02 L-PAM-PKI-M-YN       PIC X(01).

*>      I的判斷 1.空白:原作法(僅做查印), 2.大寫'Y':PDF+簽章, 3.P:PDF但不簽章, 4.大寫N:不做
        02 L-PAM-LOGSG-SW-I     PIC X(01).
*>      R的判斷 1.空白:原作法(僅做查印), 2.大寫'Y':PDF+簽章, 3.P:PDF但不簽章, 4.大寫N:不做
        02 L-PAM-LOGSG-SW-R     PIC X(01).
*>      PIN-CDOE
        02 L-PAM-PIN-CODE       PIC X(10).

*>      簽驗模式(1整批,2逐筆,3只驗身分)
        02 L-PAM-SIGN-MODE      PIC X(01).
*>      身分驗證是否成功(Y往下做,N請各作業點離開程式)
        02 L-PAM-GO-YN          PIC X(01).
*>      XML公版路徑
        02 L-PAM-XML-PTH        PIC X(50).
*>      作業點是否要詢問完成否
        02 L-PAM-ASK-YN         PIC X(01).
*>      預留1
        02 L-PAM-FILLER-1       PIC X(31).


*COPY    "HZ_PAM.WRK".
*2010/6/3 MARS 電子病歷查印共用EXTERNAL
 01 W-TMP-HZPAM  IS EXTERNAL.
*>      識別 (M-維護 I-查詢 R-印表)
        03 W-PAM-ID             PIC X(01).
*>      紀錄機制是否啟動
        03 W-PAM-LOG-YN         PIC X(01).
*>      電子簽章機制是否啟動
        03 W-PAM-PKI-YN         PIC X(01).
*>      圖檔壓縮機制是否啟動
        03 W-PAM-ARCH-YN        PIC X(01).
*>      紀錄資料保留天數
        03 W-PAM-LOGDAY         PIC 9(04).
*>      系統
        03 W-PAM-SYS            PIC X(04).
*>      程式名稱(EX.HPXXXIF)
        03 W-PAM-PROG           PIC X(15).
*>      印表-紀錄機制是否啟動
        03 W-HZPAM-LOG-R-YN     PIC X(01).
*>      印表-電子簽章機制是否啟動
        03 W-HZPAM-PKI-R-YN     PIC X(01).
*>      維護-異動紀錄是否啟動
        03 W-HZPAM-LOG-M-YN     PIC X(01).
*>      維護-紀錄機制是否啟動PKI
        03 W-HZPAM-PKI-M-YN     PIC X(01).
*>      I的判斷 1.空白:原作法(僅做查印), 2.大寫'Y':PDF+簽章, 3.P:PDF但不簽章, 4.大寫N:不做
        03 W-HZPAM-LOGSG-SW-I   PIC X(01).
*>      R的判斷 1.空白:原作法(僅做查印), 2.大寫'Y':PDF+簽章, 3.P:PDF但不簽章, 4.大寫N:不做
        03 W-HZPAM-LOGSG-SW-R   PIC X(01).
*>      PIN-CDOE
        03 W-HZPAM-PIN-CODE     PIC X(10).
*>      簽驗模式(1整批,2逐筆,3只驗身分)
        03 W-HZPAM-SIGN-MODE    PIC X(01).
*>      身分驗證是否成功(Y往下做,N請各作業點離開程式)
        03 W-HZPAM-GO-YN        PIC X(01).
*>      XML公版路徑
        03 W-HZPAM-XML-PTH      PIC X(50).
*>      預留1

        03 W-HZPAM-FILLER-1     PIC X(32).
*>-----------------------------------------
 01 W-TMP-PACK-YN                PIC X(01).

*>103.06.27 (書伶) 修改實際退藥量欄位讀取來源，改讀RTA及RTB。
 77      A4GL-WHERE-CONSTRAINT           PIC X(300) IS EXTERNAL.
*> 計算退藥總量變數(HI_RTB)
 01      W-RTB-QTY.
        02      W-RTB-QTY1              PIC 9(07).
        02      W-RTB-QTY2              PIC 9(04).
*> 通分處理變數
 01      W-TMP-QTY.
        02      W-TMP-QTY1              PIC 9(08).
        02      W-TMP-QTY2              PIC 9(04).
*> 約分處理變數
 01      W-GCD-VAR.
        02      W-IN-SON                PIC 9(10).
        02      W-IN-MOTHER             PIC 9(10).
        02      W-OUT-SON               PIC 9(10).
        02      W-OUT-MOTHER            PIC 9(10).
        02      W-GG                    PIC 9(05).
        02      W-RR                    PIC 9(05).
*>103.06.27 END
*>2019/12/24 記錄ICA寫檔錯誤筆數COUNT
 01      W-LOG2-CON                      PIC 9(02).
 01      W-LOG2-ODR-TIME                 PIC 9(6).
 01      W-DEC-TIME                      PIC 9(6).
 01      W-UPD-MRK                       PIC X(01).
 01      W-TMP-ID                        PIC X(01).
***********************************************************************
*> END OF HR_RCB1IF.WRK
***********************************************************************
*{TAMIS}end
 LINKAGE                     SECTION.
*{Bench}linkage
*COPY "HRRCB1IF.lks".
*HRRCB1IF.lks
*HRRCB1IF.lks is generated from C:\HMIS1.DIR\VN\HR\nicol\if\HRG.DIR\HRRCB1IF.Psf
*This is a generated file. DO NOT modify this file directly.
*   COPY  "C:\zurg.dir\zp_runsl.lnk".
*
* ZP_RUNSL.LNK ...  --- TAMIS 系統參數表 ...
*
 01      W-RUNL-CHK.
        02      FILLER          PIC X(6000).
*
 01 W-LNK2           PIC  X(01).
*{Bench}end

* [SCREEN SECTION - ACUCOBOL GUI definitions commented]
*{Bench}copy-screen
*COPY "HRRCB1IF.scr".
*HRRCB1IF.scr
*HRRCB1IF.scr is generated from C:\HMIS1.DIR\VN\HR\nicol\if\HRG.DIR\HRRCB1IF.Psf
*This is a generated file. DO NOT modify this file directly.

*01 S-RCB1,

*   EXCEPTION PROCEDURE S-RCB1-Exception-Proc.
*   03 S-RCB1-Fr-1, Frame,
*      COL 1.00, LINE 1.00, LINES 9.00 CELLS, SIZE 80.00 CELLS,
*      ENGRAVED, COLOR IS 3, FONT IS 細明體12, FULL-HEIGHT,
*      ID IS 2, HEAVY, TITLE W-FORM-TITLE, TITLE-POSITION 2,
*      BACKGROUND-LOW.
*   03 S-RCB1-La-1, Label,
*      COL 2.20, LINE 3.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 3, LABEL-OFFSET 0,
*      TITLE "患者姓名：".
*   03 S-RCB1-La-1a, Label,
*      COL 2.20, LINE 5.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 4, LABEL-OFFSET 0,
*      TITLE "護 理 站：".
*   03 S-RCB1-La-1b, Label,
*      COL 2.20, LINE 7.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 5, LABEL-OFFSET 0,
*      TITLE "住院科別：".
*   03 S-RCB1-La-1c, Label,
*      COL 34.40, LINE 5.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 6, LABEL-OFFSET 0,
*      TITLE "床    號：".
*   03 S-RCB1-La-1d, Label,
*      COL 34.40, LINE 3.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 7, LABEL-OFFSET 0,
*      TITLE "病 歷 號：".
*   03 S-RCB1-La-1e, Label,
*      COL 34.40, LINE 7.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 8, LABEL-OFFSET 0,
*      TITLE "主治醫師：".
*   03 S-RCB1-La-1f, Label,
*      COL 56.50, LINE 5.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 9, LABEL-OFFSET 0,
*      TITLE "住院日期：".
*   03 S-RCB1-La-1g, Label,
*      COL 56.50, LINE 7.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 10, LABEL-OFFSET 0,
*      TITLE "住院醫師：".
*   03 S-PAT-NAME, Label,
*      COL 11.40, LINE 3.60, LINES 2.00 CELLS, SIZE 9.60 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 11, LABEL-OFFSET 0,
*      TITLE W-PAT-NAME.
*   03 S-SEX, Label,
*      COL 23.30, LINE 3.60, LINES 2.00 CELLS, SIZE 2.00 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 12, LABEL-OFFSET 0,
*      TITLE W-SEX.
*   03 S-RCB1-La-1h, Label,
*      COL 22.20, LINE 3.60, LINES 2.00 CELLS, SIZE 1.00 CELLS,
*      FONT IS 細明體12, ID IS 13, LABEL-OFFSET 0,
*      TITLE "(".
*   03 S-RCB1-La-1ha, Label,
*      COL 25.50, LINE 3.60, LINES 2.00 CELLS, SIZE 1.00 CELLS,
*      FONT IS 細明體12, ID IS 14, LABEL-OFFSET 0,
*      TITLE ")".
*   03 S-AGE, Label,
*      COL 27.10, LINE 3.60, LINES 2.00 CELLS, SIZE 2.40 CELLS,
*      COLOR IS 2, FONT IS 細明體12, PIC Z(3), ID IS 15,

*      LABEL-OFFSET 0, FROM W-AGE.
*   03 S-AGE-UNIT, Label,
*      COL 30.70, LINE 3.60, LINES 2.00 CELLS, SIZE 2.40 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 16, LABEL-OFFSET 0,
*      TITLE W-AGE-UNIT.
*   03 S-IPD-UNIT-NAME, Label,
*      COL 11.40, LINE 5.60, LINES 2.00 CELLS, SIZE 20.40 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 17, LABEL-OFFSET 0,
*      TITLE W-IPD-UNIT-NAME.
*   03 S-DPT-NAME, Label,
*      COL 11.40, LINE 7.60, LINES 2.00 CELLS, SIZE 20.40 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 18, LABEL-OFFSET 0,
*      TITLE W-DPT-NAME.
*   03 S-PAT-NO, Label,
*      COL 43.40, LINE 3.60, LINES 2.00 CELLS, SIZE 7.20 CELLS,
*      COLOR IS 2, FONT IS 細明體12, PIC Z(8), ID IS 19,
*      LABEL-OFFSET 0, FROM W-PAT-NO.
*   03 S-BED, Label,
*      COL 43.40, LINE 5.60, LINES 2.00 CELLS, SIZE 6.00 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 20, LABEL-OFFSET 0,
*      TITLE W-BED.
*   03 S-IPD-MJ-DR, Label,
*      COL 43.40, LINE 7.60, LINES 2.00 CELLS, SIZE 9.60 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 21, LABEL-OFFSET 0,
*      TITLE W-IPD-MJ-DR.
*   03 S-IPD-MARK, Label,
*      COL 56.50, LINE 3.60, LINES 2.00 CELLS, SIZE 21.90 CELLS,
*      COLOR IS 13, FONT IS 細明體12, ID IS 30, LABEL-OFFSET 0,
*      TITLE W-IPD-MARK.
*   03 S-IPD-SEQ, Label,
*      COL 74.50, LINE 5.60, LINES 2.00 CELLS, SIZE 3.60 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 25, LABEL-OFFSET 0,
*      TITLE W-IPD-SEQ1.
*   03 S-RCB1-La-1haa, Label,
*      COL 72.40, LINE 5.60, LINES 2.00 CELLS, SIZE 1.00 CELLS,
*      FONT IS 細明體12, ID IS 24, LABEL-OFFSET 0,
*      TITLE "/".
*   03 S-IPD-DT, Label,
*      COL 65.50, LINE 5.60, LINES 2.00 CELLS, SIZE 6.00 CELLS,
*      COLOR IS 2, FONT IS 細明體12, PIC Z(7), ID IS 23,
*      LABEL-OFFSET 0, FROM W-IPD-DT.
*   03 S-IPD-RD-DR, Label,
*      COL 65.50, LINE 7.60, LINES 2.00 CELLS, SIZE 9.60 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 22, LABEL-OFFSET 0,
*      TITLE W-IPD-RD-DR.
*   03 S-RCB1-Fr-2, Frame,
*      COL 1.00, LINE 10.00, LINES 39.00 CELLS,
*      SIZE 80.00 CELLS,
*      ENGRAVED, FONT IS 細明體12, FULL-HEIGHT, ID IS 27, HEAVY,
*      BACKGROUND-LOW.
*   03 S-RCB1-Gd-1, Grid,
*      COL 1.20, LINE 10.60, LINES 37.70 CELLS,
*      SIZE 79.50 CELLS,
*      3-D, COLUMN-HEADINGS,
*      DATA-COLUMNS (1, 4, 44, 53, 63, 65, 74, 86, 90, 91, 116,
*      125),
*      DISPLAY-COLUMNS (1, 5, 46, 54, 65, 69, 77, 90, 95, 98,

*      124, 134),
*      ALIGNMENT ("R", "U", "C", "U", "C", "C", "U", "U", "U",
*      "U", "C", "U"),
*      SEPARATION (5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5),
*      COLUMN-DIVIDERS (0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1),
*      CURSOR-FRAME-WIDTH 0, DIVIDER-COLOR 1, DRAG-COLOR 1,
*      FONT IS 細明體11, HEADING-COLOR 144,
*      HEADING-DIVIDER-COLOR 1, HEADING-FONT IS 細明體12,
*      HSCROLL, ID IS 26, NUM-ROWS 16, PAGED,
*      RECORD-DATA W-GD-REC, TILED-HEADINGS, VPADDING 20,
*      VIRTUAL-WIDTH 123, VSCROLL,
*      EVENT PROCEDURE S-RCB1-Gd-1-Event-Proc.
*01 S-HT-DATA,
*   EXCEPTION PROCEDURE S-HT-DATA-Exception-Proc.
*   03 S-HT-DATA-FR, Frame,
*      COL 1.00, LINE 1.00, LINES 15.00 CELLS, SIZE 56.00 CELLS,
*      ENGRAVED, COLOR IS 3, FONT IS 細明體12, ID IS 1,
*      TITLE W-HT-DATA-TITLE, TITLE-POSITION 2, BACKGROUND-LOW.
*   03 S-HT-DATA-La-1, Label,
*      COL 2.00, LINE 3.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 2, LABEL-OFFSET 0,
*      TITLE "簽收人員：".
*   03 S-HT-DATA-La-1a, Label,
*      COL 2.00, LINE 5.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 3, LABEL-OFFSET 0,
*      TITLE "簽收日期：".
*   03 S-HT-DATA-La-1aa, Label,
*      COL 2.00, LINE 7.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 4, LABEL-OFFSET 0,
*      TITLE "簽收時間：".
*   03 S-HT-DATA-La-1ab, Label,
*      COL 2.00, LINE 9.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 5, LABEL-OFFSET 0,
*      TITLE "項目名稱：".
*   03 S-HT-DATA-La-1ac, Label,
*      COL 2.00, LINE 11.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 6, LABEL-OFFSET 0,
*      TITLE "檢體名稱：".
*   03 S-HT-DATA-La-1ad, Label,
*      COL 2.00, LINE 13.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 7, LABEL-OFFSET 0,
*      TITLE "容器名稱：".
*   03 S-HT-DATA-La-1ae, Label,
*      COL 25.80, LINE 3.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 8, LABEL-OFFSET 0,
*      TITLE "報告人員：".
*   03 S-HT-DATA-La-1aea, Label,
*      COL 25.80, LINE 5.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 9, LABEL-OFFSET 0,
*      TITLE "報告日期：".
*   03 S-HT-DATA-La-1aeb, Label,
*      COL 25.80, LINE 7.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 細明體12, ID IS 10, LABEL-OFFSET 0,
*      TITLE "報告時間：".
*   03 S-DIS-AC-NAME, Label,
*      COL 11.20, LINE 3.20, LINES 2.00 CELLS, SIZE 13.20 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 11, LABEL-OFFSET 0,

*      TITLE W-AC-NAME.
*   03 S-DIS-AC-DATE, Label,
*      COL 11.20, LINE 5.20, LINES 2.00 CELLS, SIZE 13.20 CELLS,
*      COLOR IS 2, FONT IS 細明體12, PIC Z(7), ID IS 12,
*      LABEL-OFFSET 0, FROM W-AC-DATE.
*   03 S-DIS-AC-TIME, Label,
*      COL 11.20, LINE 7.20, LINES 2.00 CELLS, SIZE 13.20 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 13, LABEL-OFFSET 0,
*      TITLE W-AC-TIME.
*   03 S-DIS-ITM-NM, Label,
*      COL 11.20, LINE 9.20, LINES 2.00 CELLS, SIZE 30.00 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 14, LABEL-OFFSET 0,
*      TITLE W-ITM-NM.
*   03 S-DIS-SPL-NM, Label,
*      COL 11.20, LINE 11.20, LINES 2.00 CELLS,
*      SIZE 16.80 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 15, LABEL-OFFSET 0,
*      TITLE W-SPL-NM.
*   03 S-DIS-BTL-NM, Label,
*      COL 11.20, LINE 13.20, LINES 2.00 CELLS,
*      SIZE 16.80 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 16, LABEL-OFFSET 0,
*      TITLE W-BTL-NM.
*   03 S-DIS-RP-F-NAME, Label,
*      COL 35.10, LINE 3.20, LINES 2.00 CELLS, SIZE 9.60 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 17, LABEL-OFFSET 0,
*      TITLE W-RP-F-NAME.
*   03 S-DIS-RP-DATE, Label,
*      COL 35.10, LINE 5.20, LINES 2.00 CELLS, SIZE 13.20 CELLS,
*      COLOR IS 2, FONT IS 細明體12, PIC Z(7), ID IS 18,
*      LABEL-OFFSET 0, FROM W-RP-DATE.
*   03 S-DIS-RP-TIME, Label,
*      COL 35.10, LINE 7.20, LINES 2.00 CELLS, SIZE 13.20 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 19, LABEL-OFFSET 0,
*      TITLE W-RP-TIME.
*   03 S-DIS-RP-L-NAME, Label,
*      COL 46.30, LINE 3.20, LINES 2.00 CELLS, SIZE 9.60 CELLS,
*      COLOR IS 2, FONT IS 細明體12, ID IS 20, LABEL-OFFSET 0,
*      TITLE W-RP-L-NAME.
*   03 S-HT-DATA-Pb-1, Push-Button,
*      COL 48.20, LINE 12.70, LINES 2.50 CELLS, SIZE 8.00 CELLS,
*      EXCEPTION-VALUE W-EXIT2, FONT IS 細明體12, ID IS 21,
*      TITLE "離開".
*{Bench}end
*{TAMIS}copy-screen
*------>開關檔
*COPY    "HR_WAT.SCR".
***********************************************************************
*> HR_WAT.SCR
***********************************************************************
*01      S-LOAD-FORM.
*       03      S-FR-LOAD-BAR, Frame,
*               COL 3.50, LINE 3.65, LINES 1.00 CELLS, SIZE 35.00 CELLS,
*               LOWERED, ALTERNATE, COLOR IS 521, FILL-COLOR 2, FILL-PERCENT 90,
*               FILL-COLOR2 16, FONT IS Fixed-Font, FULL-HEIGHT, ID IS 1,
*               LOW-COLOR 16, VERY-HEAVY, TITLE-POSITION 7, BACKGROUND-LOW.
*       03      S-LOAD-FOR-La-1, Label,

*               COL 3.50, LINE 2.30, LINES 1.00 CELLS, SIZE 35.00 CELLS,
*               ID IS 2, FONT IS Fixed-Font, LABEL-OFFSET 0, TITLE W-LA-NAME.
***********************************************************************
*> END
***********************************************************************
*{TAMIS}end
*{Bench}linkpara
 PROCEDURE DIVISION USING W-RUNL-CHK, W-LNK2.
*{Bench}end
*{Bench}declarative
*{Bench}end

 Acu-Main-Logic.
*{Bench}entry-befprg
*    Before-Program
*{Bench}end
     PERFORM Acu-Initial-Routine
* run main screen
*{Bench}run-mainscr
     PERFORM Acu-S-RCB1-Routine
*{Bench}end
     .
     PERFORM F-STOP-RTN.

*{Bench}copy-procedure
*COPY "showmsg.cpy".
 *
 Acu-Extended-File-Status.
    CALL "C$RERRNAME" USING Acu-Err-File
    CALL "C$RERR" USING Extend-Stat, Text-Message
       MOVE Primary-Error TO Acu-Msg-Id
       PERFORM Acu-Show-Msg
    .
 Acu-Show-Msg.
    MOVE SPACE TO Acu-Msg-1 Acu-Msg-2 Acu-Msg-3
    EVALUATE Acu-Msg-Id
    WHEN 10
       MOVE "No more data."  TO Acu-Msg-1
       MOVE Mb-Default-Icon TO Acu-Icon-Type
       MOVE Mb-Ok TO Acu-Button-Type
    WHEN 22
       MOVE "Key duplication." TO Acu-Msg-1
       MOVE Mb-Error-Icon TO Acu-Icon-Type
       MOVE Mb-Ok TO Acu-Button-Type
    WHEN 23
       MOVE "Record not found." TO Acu-Msg-1
       MOVE Mb-Warning-Icon TO Acu-Icon-Type
       MOVE Mb-Ok TO Acu-Button-Type
    WHEN 101
       MOVE "Quit?" TO Acu-Msg-1
       MOVE 4 TO Acu-Icon-Type
       MOVE Mb-Yes-No TO Acu-Button-Type
    WHEN 201
       MOVE "Add Record?" TO Acu-Msg-1
       MOVE 4 TO Acu-Icon-Type
       MOVE Mb-Yes-No TO Acu-Button-Type
    WHEN 202

       MOVE "Update Record?" TO Acu-Msg-1
       MOVE 4 TO Acu-Icon-Type
       MOVE Mb-Yes-No TO Acu-Button-Type
    WHEN 203
       MOVE "Delete Record?" TO Acu-Msg-1
       MOVE 4 TO Acu-Icon-Type
       MOVE Mb-Yes-No TO Acu-Button-Type
    WHEN 204
       MOVE "Key duplication." TO Acu-Msg-1
       MOVE Mb-Warning-Icon TO Acu-Icon-Type
       MOVE Mb-Ok TO Acu-Button-Type
    WHEN 301
       MOVE "Add Successful." TO Acu-Msg-1
       MOVE Mb-Default-Icon TO Acu-Icon-Type
       MOVE Mb-Ok TO Acu-Button-Type
    WHEN 302
       MOVE "Update Successful." TO Acu-Msg-1
       MOVE Mb-Default-Icon TO Acu-Icon-Type
       MOVE Mb-Ok TO Acu-Button-Type
    WHEN 303
       MOVE "Delete Successful." TO Acu-Msg-1
       MOVE Mb-Default-Icon TO Acu-Icon-Type
       MOVE Mb-Ok TO Acu-Button-Type
    WHEN 401
       MOVE "Shell not found." TO Acu-Msg-1
       MOVE Mb-Error-Icon TO Acu-Icon-Type
       MOVE Mb-Ok TO Acu-Button-Type
 user-defined message
    WHEN 901
       MOVE Mb-Warning-Icon TO Acu-Icon-Type
       MOVE Mb-Ok TO Acu-Button-Type
    WHEN OTHER
       MOVE Text-Message TO Acu-Msg-1
       STRING "File:" Acu-Err-File DELIMITED BY SPACE
          INTO Acu-Msg-2
       STRING "File status ", Primary-Error "," Secondary-Error
          DELIMITED BY SIZE INTO Acu-Msg-3
    END-EVALUATE
    PERFORM Acu-Message-Box
    .

 Acu-Message-Box.
    MOVE 1 TO Acu-Text-Ptr
    IF Acu-Msg-1 NOT = SPACE
       MOVE 0 TO Acu-Size
       INSPECT Acu-Msg-1 TALLYING Acu-Size FOR TRAILING SPACE
       STRING Acu-Msg-1( 1 : Acu-Length - Acu-Size )
          DELIMITED BY SIZE
          INTO Acu-Msg-Text, POINTER Acu-Text-Ptr
    END-IF

    IF Acu-Msg-2 NOT = SPACE
       MOVE 0 TO Acu-Size
       INSPECT Acu-Msg-2 TALLYING Acu-Size FOR TRAILING SPACE
       IF ACU-Text-Ptr > 1
          STRING X"0A" DELIMITED BY SIZE
              INTO Acu-Msg-Text, POINTER Acu-Text-Ptr

       END-IF
       STRING Acu-Msg-2( 1 : Acu-Length - Acu-Size )
           DELIMITED BY SIZE
           INTO Acu-Msg-Text, POINTER Acu-Text-Ptr
    END-IF

    IF Acu-Msg-3 NOT = SPACE
       MOVE 0 TO Acu-Size
       INSPECT Acu-Msg-3 TALLYING Acu-Size FOR TRAILING SPACE
       IF Acu-Text-Ptr > 1
          STRING X"0A" DELIMITED BY SIZE
              INTO Acu-Msg-Text, POINTER Acu-Text-Ptr
       END-IF
       STRING Acu-Msg-3( 1 : Acu-Length - Acu-Size )
           DELIMITED BY SIZE
           INTO Acu-Msg-Text, POINTER Acu-Text-Ptr
    END-IF

    IF Acu-Text-Ptr = 1
      MOVE 0 TO Acu-Size
      INSPECT Acu-Msg-Text TALLYING Acu-Size FOR TRAILING SPACE
      COMPUTE Acu-Text-Ptr = Acu-Full-Len - Acu-Size + 1
    END-IF
    MOVE Low-Values TO Acu-Msg-Text( Acu-Text-Ptr : 1 )

    DISPLAY MESSAGE BOX
       Acu-Msg-Text
       TYPE IS Acu-Button-Type
       ICON IS Acu-Icon-Type
       DEFAULT IS Acu-Default-Button
       RETURNING Acu-Return-Value
    .
*COPY "HRRCB1IF.prd".
*HRRCB1IF.prd
*HRRCB1IF.prd is generated from C:\HMIS1.DIR\VN\HR\nicol\if\HRG.DIR\HRRCB1IF.Psf
*This is a generated file. DO NOT modify this file directly.

 Acu-Initial-Routine.
    Before-Init
 get system information
    ACCEPT System-Information FROM System-Info
 get terminal information
    ACCEPT Terminal-Abilities FROM Terminal-Info
 set font
    PERFORM Acu-Init-Font
    After-Init
    .

 Acu-Init-Font.
 font setting
    INITIALIZE WFONT-DATA 細明體12
    MOVE 12 TO WFONT-SIZE
    MOVE "細明體" TO WFONT-NAME
    SET WFCHARSET-DONT-CARE TO TRUE
    SET WFONT-BOLD TO FALSE
    SET WFONT-ITALIC TO FALSE
    SET WFONT-UNDERLINE TO FALSE

    SET WFONT-STRIKEOUT TO FALSE
    SET WFFAMILY-DONT-CARE TO TRUE
    SET WFONT-FIXED-PITCH TO FALSE
    CALL "W$FONT" USING WFONT-GET-FONT, 細明體12, WFONT-DATA
    INITIALIZE WFONT-DATA 細明體11
    MOVE 11 TO WFONT-SIZE
    MOVE "細明體" TO WFONT-NAME
    SET WFCHARSET-DONT-CARE TO TRUE
    SET WFONT-BOLD TO FALSE
    SET WFONT-ITALIC TO FALSE
    SET WFONT-UNDERLINE TO FALSE
    SET WFONT-STRIKEOUT TO FALSE
    SET WFFAMILY-DONT-CARE TO TRUE
    SET WFONT-FIXED-PITCH TO FALSE
    CALL "W$FONT" USING WFONT-GET-FONT, 細明體11, WFONT-DATA
    .

 Acu-Exit-Rtn.
    After-Program
    EXIT PROGRAM
    STOP RUN
    .

 Acu-S-RCB1-Routine.
    Before-Routine
    PERFORM Acu-S-RCB1-Scrn
    PERFORM Acu-S-RCB1-Proc
    After-Routine
    .

 Acu-S-HT-DATA-Routine.
    Before-Routine
    PERFORM Acu-S-HT-DATA-Scrn
    PERFORM Acu-S-HT-DATA-Proc
    After-Routine
    .

 Acu-S-RCB1-Scrn.
    PERFORM Acu-S-RCB1-Create-Win
    PERFORM Acu-S-RCB1-Init-Data
    .

 Acu-S-HT-DATA-Scrn.
    PERFORM Acu-S-HT-DATA-Create-Win
    PERFORM Acu-S-HT-DATA-Init-Data
    .

 Acu-S-RCB1-Create-Win.
    PERFORM F-RCB1-Bef-Create
 display screen
       DISPLAY Floating GRAPHICAL WINDOW
          LINES 50.00, SIZE 80.00, CELL HEIGHT 10,
          CELL WIDTH 10, COLOR IS 65793,
          CONTROL FONT Fixed-Font, LABEL-OFFSET 0,
          LINK TO THREAD, NO SCROLL, TITLE W-TOP-TITLE,
          TITLE-BAR, NO WRAP,
          HANDLE IS S-RCB1-Handle

 main menu
    PERFORM Acu-S-RCB1-Mn-1-Menu
    MOVE Menu-Handle TO S-RCB1-Mn-1-Handle
    CALL "W$MENU" USING Wmenu-Show, S-RCB1-Mn-1-Handle
 toolbar
    DISPLAY S-RCB1 UPON S-RCB1-Handle
    PERFORM F-RCB1-Aft-Create
    .

 Acu-S-HT-DATA-Create-Win.
    Before-Create
 display screen
       DISPLAY Floating GRAPHICAL WINDOW
          LINES 15.00, SIZE 56.00, CELL HEIGHT 10,
          CELL WIDTH 10, COLOR IS 65793, CONTROL FONT 細明體12,
          LABEL-OFFSET 0, LINK TO THREAD, NO SCROLL,
          TITLE "檢驗放射線相關資料", TITLE-BAR, NO WRAP,
          HANDLE IS S-HT-DATA-Handle
 toolbar
    DISPLAY S-HT-DATA UPON S-HT-DATA-Handle
    After-Create
    .

 Acu-S-RCB1-Init-Data.
    Before-Initdata
    PERFORM Acu-S-RCB1-Gd-1-Content
    PERFORM F-RCB1-Aft-Initdata
    .

 Acu-S-HT-DATA-Init-Data.
    Before-Initdata
    PERFORM F-HT-DATA-Aft-Initdata
    .
 S-RCB1
 Acu-S-RCB1-Proc.
    PERFORM UNTIL Exit-Pushed
       ACCEPT S-RCB1
          ON EXCEPTION PERFORM Acu-S-RCB1-Evaluate-Func
       END-ACCEPT
    END-PERFORM
    DESTROY S-RCB1-Handle
    INITIALIZE Key-Status
    .
 S-HT-DATA
 Acu-S-HT-DATA-Proc.
    PERFORM UNTIL Exit-Pushed
       ACCEPT S-HT-DATA
          ON EXCEPTION PERFORM Acu-S-HT-DATA-Evaluate-Func
       END-ACCEPT
    END-PERFORM
    DESTROY S-HT-DATA-Handle
    INITIALIZE Key-Status
    .

 S-RCB1-Gd-1
 Acu-S-RCB1-Gd-1-Content.
 Cells' Setting

    MODIFY S-RCB1-Gd-1, X = 1, Y = 1, CELL-DATA = "序",
    MODIFY S-RCB1-Gd-1, X = 2, Y = 1, CELL-DATA = "處置名稱",
    MODIFY S-RCB1-Gd-1, X = 6, Y = 1, CELL-DATA = "數量",
    MODIFY S-RCB1-Gd-1, X = 7, Y = 1, CELL-DATA = "處方日-時間",
    MODIFY S-RCB1-Gd-1, X = 10, Y = 1, CELL-DATA =
       "執行日-時間",
 Columns' Setting
    MODIFY S-RCB1-Gd-1, X = 1, COLUMN-FONT = 細明體11
    MODIFY S-RCB1-Gd-1, X = 2, COLUMN-FONT = 細明體11
    MODIFY S-RCB1-Gd-1, X = 3, COLUMN-FONT = 細明體11
    MODIFY S-RCB1-Gd-1, X = 4, COLUMN-FONT = 細明體11
    MODIFY S-RCB1-Gd-1, X = 5, COLUMN-FONT = 細明體11
    MODIFY S-RCB1-Gd-1, X = 6, COLUMN-FONT = 細明體11
    MODIFY S-RCB1-Gd-1, X = 7, COLUMN-FONT = 細明體11
    MODIFY S-RCB1-Gd-1, X = 8, COLUMN-FONT = 細明體11
    MODIFY S-RCB1-Gd-1, X = 9, COLUMN-FONT = 細明體11
    MODIFY S-RCB1-Gd-1, X = 10, COLUMN-FONT = 細明體11
    .

 S-RCB1
 Acu-S-RCB1-Evaluate-Func.
    EVALUATE TRUE
       WHEN Exit-Pushed
          PERFORM Acu-S-RCB1-Exit
       WHEN Event-Occurred
          IF Event-Type = Cmd-Close
             PERFORM Acu-S-RCB1-Exit
          END-IF
    END-EVALUATE
 avoid changing focus
    MOVE 1 TO Accept-Control
    .

 S-HT-DATA
 Acu-S-HT-DATA-Evaluate-Func.
    EVALUATE TRUE
       WHEN Exit-Pushed
          PERFORM Acu-S-HT-DATA-Exit
       WHEN Event-Occurred
          IF Event-Type = Cmd-Close
             PERFORM Acu-S-HT-DATA-Exit
          END-IF
    END-EVALUATE
 avoid changing focus
    MOVE 1 TO Accept-Control
    .

 Acu-S-RCB1-Exit.
    SET Exit-Pushed TO TRUE
    .

 Acu-S-HT-DATA-Exit.
    SET Exit-Pushed TO TRUE
    .

*COPY "HRRCB1IF.mnu".
*HRRCB1IF.mnu

*HRRCB1IF.mnu is generated from C:\HMIS1.DIR\VN\HR\nicol\if\HRG.DIR\HRRCB1IF.Psf
*This is a generated file. DO NOT modify this file directly.

 S-RCB1-Mn-1
 Acu-S-RCB1-Mn-1-Menu.
    PERFORM Acu-S-RCB1-Mn-1
       THRU Acu-S-RCB1-Mn-1-Exit.

 Acu-S-RCB1-Mn-1.
    CALL "W$MENU" USING Wmenu-New GIVING Menu-Handle
    IF Menu-Handle = ZERO
       GO TO Acu-S-RCB1-Mn-1-Exit
    END-IF
    CALL "W$MENU" USING Wmenu-New GIVING Sub-Handle-1
    IF Sub-Handle-1 = ZERO
       MOVE ZERO TO Menu-Handle
       GO TO Acu-S-RCB1-Mn-1-EXIT
    END-IF
    CALL "W$MENU" USING WMENU-ADD, Menu-Handle, 0, 0,
       "&1. 作業", 1000, Sub-Handle-1
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&1. 住院期間用藥明細查詢", W-RCB1
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&2. 住院期間檢驗放射線查詢", W-RCB2
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&3. 住院期間治療處置查詢", W-RCB3
    CALL "W$MENU" USING Wmenu-New GIVING Sub-Handle-1
    IF Sub-Handle-1 = ZERO
       MOVE ZERO TO Menu-Handle
       GO TO Acu-S-RCB1-Mn-1-EXIT
    END-IF
    CALL "W$MENU" USING WMENU-ADD, Menu-Handle, 0, 0,
       "&2. 查詢", 1004, Sub-Handle-1
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&1. 查詢歷次住院記錄", W-SEARCH
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&2. 查詢已刪除藥品", W-DEL
    CALL "W$MENU" USING Wmenu-New GIVING Sub-Handle-1
    IF Sub-Handle-1 = ZERO
       MOVE ZERO TO Menu-Handle
       GO TO Acu-S-RCB1-Mn-1-EXIT
    END-IF
    CALL "W$MENU" USING WMENU-ADD, Menu-Handle, 0, 0,
       "&3. 檢驗", 1007, Sub-Handle-1
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&1. 查詢檢驗報告", W-REPORT
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&2. 查詢簽收相關資料", W-DATA
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&3. 刪除", W-DELETE
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&4. 重印檢驗單(交科室)", W-PRINT
    CALL "W$MENU" USING Wmenu-New GIVING Sub-Handle-1
    IF Sub-Handle-1 = ZERO
       MOVE ZERO TO Menu-Handle
       GO TO Acu-S-RCB1-Mn-1-EXIT
    END-IF

    CALL "W$MENU" USING WMENU-ADD, Menu-Handle, 0, 0,
       "&4. 離開", 1012, Sub-Handle-1
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&1. 離開", W-EXIT
    .

 Acu-S-RCB1-Mn-1-Exit.
    MOVE ZERO TO Return-Code.

*COPY "HRRCB1IF.evt".
*HRRCB1IF.evt
*HRRCB1IF.evt is generated from C:\HMIS1.DIR\VN\HR\nicol\if\HRG.DIR\HRRCB1IF.Psf
*This is a generated file. DO NOT modify this file directly.


 S-RCB1-Exception-Proc.
    PERFORM F-RCB1-Ex-Other
    .

 S-RCB1-Gd-1-Event-Proc.
 *
    EVALUATE Event-Type
    WHEN Msg-Begin-Drag
       PERFORM F-RCB1-Gd-1-Ev-Msg-Begin-Drag
    WHEN Msg-Begin-Entry
       PERFORM F-RCB1-Gd-1-Ev-Msg-Begin-Entry
    WHEN Msg-Goto-Cell
       PERFORM F-RCB1-Gd-1-Ev-Msg-Goto-Cell
    WHEN Msg-Goto-Cell-Mouse
       PERFORM F-RCB1-Gd-1-Ev-Msg-Goto-Cell-Mouse
    WHEN Msg-Paged-Next
       PERFORM F-RCB1-Gd-1-Ev-Msg-Paged-Next
    WHEN Msg-Paged-Nextpage
       PERFORM F-RCB1-Gd-1-Ev-Msg-Paged-Nextpage
    WHEN Msg-Paged-Prev
       PERFORM F-RCB1-Gd-1-Ev-Msg-Paged-Prev
    WHEN Msg-Paged-Prevpage
       PERFORM F-RCB1-Gd-1-Ev-Msg-Paged-Prevpage
    END-EVALUATE
    .

 S-HT-DATA-Exception-Proc.
 *
    IF Event-Occurred
       EVALUATE Event-Type
       WHEN Cmd-Close
          PERFORM F-HT-DATA-Ex-Cmd-Close
       END-EVALUATE
    ELSE
       PERFORM S-HT-DATA-Ex-Other
    END-IF
    .
**   start event editor code   ***



*{Bench}end

*{TAMIS}copy-procedure
*COPY    "HR_RCB1IF.PRC".
***********************************************************************
*> C-PY "HR_RCB1IF.PRC".
***********************************************************************
*>W-LNK2 = "A"---->HRRCB1IF
*>W-LNK2 = "B"---->HRRCB2IF
*>W-LNK2 = "C"---->HRRCB3IF
*> 98.02.02增加變數判別是主程式或是副主式
*> 98.03.19 (AICE) 由ICB搬
*> 98.05.15 (AICE) 電子病歷查印紀錄
*> 99.05.20 (AICE) 電子病歷查印紀錄增加電子簽章(DM1001-J1001461)
*> 99.07.19 (AICE) MEMORY ACCESS 加WITH CONVERT DM1001-J1002025
*> 99.11.17 (AICE) 小蟲說要將ICB-ODR-SEQ(2:3)改為ICB-FEE-SEQ(DM1001-J1003068)
*>100.02.21 (AICE) 狀態欄位顯示錯誤，呼叫前先INITIALIZE (DM1101-J1100473)
*>101.08.31 (AICE) DM1201-J1201492 MAV
*>102.03.15 (FISH) MAV-如果ICA-ODR-TIME為數字型態，才搬值 （DM1301-J1300326
*>103.06.27 (書伶) 修改實際退藥量欄位讀取來源，改讀RTA及RTB。
*>104.03.19 (書伶) 因IPD指標可能被異動，改用預先暫存的BED傳送護理站表單列印作業。
*>106.06.07 (彙婷) 桃醫-檢驗放射線查詢作業刪除檢驗單時，需重印重驗單(DM1701-J1700049)
*>106.07.06 (彙婷) 禮中反應刪除時，要加傳處方日
*>106.11.09 (AICE) 增加顯示已刪除之檢驗項目(DM1701-J1700569)(業-105121502)
*>2023/01/30 桃園 - 因為檢驗檢查取消後檢驗資料就消失了而無法取得細項名稱 - 瑋育
***********************************************************************
 F-RCB1-Bef-Create.
        INITIALIZE W-TOP-TITLE W-TMP-PARA W-HRDTA-COUNT W-SOU W-TMP-PACK-YN.
        MOVE 385        TO W-GD-COLOR.
        CALL "C$NARG" USING W-PARAMETERS.
        IF W-PARAMETERS = 1 THEN
                MOVE "M" TO W-SOU
                MOVE W-RUNL-CHK         TO W-RUN-CHK
                MOVE W-RUN-PARA(1:1)    TO W-TMP-PARA
                PERFORM F-OPEN-RTN THRU F-OPEN-EXIT
        ELSE
*>              INITIALIZE W-RUN-CHK
                IF W-HTCGUICF-EXT-PT-NO > 0 THEN
                        MOVE "O" TO W-SOU
                        MOVE W-RUNL-CHK         TO W-RUN-CHK
                        MOVE W-RUN-PARA(1:1)    TO W-TMP-PARA
                        PERFORM F-OPEN-RTN THRU F-OPEN-EXIT
                ELSE
                        MOVE "S" TO W-SOU
                        IF W-RUNE-OK = "Y" THEN
                                MOVE W-RUNE-CHK TO W-RUN-CHK(1:4500)
                        ELSE
                                INITIALIZE W-RUN-CHK
                        END-IF
                        MOVE W-LNK2     TO W-TMP-PARA
                END-IF
        END-IF.
*>START (AICE) 98.05.15 電子病歷查印紀錄
        IF W-TMP-HZPAM(1:4) NOT = "    " AND LOW-VALUE THEN
                MOVE W-RUNE-CHK         TO W-RUN-CHK
                MOVE W-TMP-HZPAM        TO L-PAM-LNK
        ELSE
                PERFORM F-CHK-LOG-RTN THRU F-CHK-LOG-EXIT
                INITIALIZE W-TMP-HZPAM

                IF   L-PAM-LOG-YN  = "Y"    THEN
                        MOVE L-PAM-LNK    TO W-TMP-HZPAM
                        MOVE "Y"        TO W-TMP-PACK-YN
                END-IF
        END-IF.
*


        PERFORM F-HT-OPEN.
        PERFORM F-TOP-TITLE.
*       COPY "ZD_DTI.PRC".
*
* ZD_DTI.PRC ... 同 ZD_YMD.PRC ...  取日期時間 ...
*
        MOVE W-RUN-YYSW  TO W-YMD-YYSW.
        MOVE W-RUN-YYDEF TO W-YMD-YYDEF.
        MOVE W-RUN-YYCOM TO W-YMD-YYCOM.
*
* 日期 ...
        ACCEPT W-YMD-DATE FROM CENTURY-DATE.
        MOVE W-YMD-YY TO W-YMD-YYB.
        MOVE W-YMD-YY TO W-YMD-YY1.
        MOVE W-YMD-MM TO W-YMD-MM1.
        MOVE W-YMD-DD TO W-YMD-DD1.
*
* YYSW   : 使用年曆設定     -- 4:使用四碼西元年 2:二碼西元年, 0:表使用當地國年
* YYDEF  : 年度換算初值     -- 西元年換算使用國年初值(例:1911, 0 視同1911)
* YYCOM  : 年度計算方式     -- 西元年計算使用國年方式(例:+,-, 空白視同 - )
* YDFSW  : 變數用...
*
        IF W-YMD-YYCOM NOT = "+" AND "-" THEN
                ACCEPT W-YMD-YYSW       FROM ENVIRONMENT "ZS_SYYW"
                END-ACCEPT
                ACCEPT W-YMD-YDFSW      FROM ENVIRONMENT "ZS_SYDF"
                END-ACCEPT
                ACCEPT W-YMD-YYCOM      FROM ENVIRONMENT "ZS_SYCM"
                END-ACCEPT
                IF W-YMD-YYSW NOT = "2" AND "4" THEN
                        MOVE "0" TO W-YMD-YYSW
                END-IF
                IF W-YMD-YYCOM NOT = "+" AND "-" THEN
                        MOVE "-" TO W-YMD-YYCOM
                END-IF
                MOVE W-YMD-YDFSW TO W-YMD-YYDEF WITH CONVERT
                IF ( W-YMD-YYDEF = 0 ) AND
                   ( W-YMD-YYSW  = "0" ) AND
                   ( W-YMD-YYCOM = "-" ) THEN
                        MOVE 1911 TO W-YMD-YYDEF
                END-IF
        END-IF.
*
* YYS : - 表轉換後年度為負值
*
        MOVE SPACE TO W-YMD-YYS.
        IF W-YMD-YYSW = "4" THEN
                CONTINUE
        ELSE

        IF W-YMD-YYSW = "2" THEN
                MOVE W-YMD-YY1 TO W-YMD-YY
        ELSE    IF W-YMD-YYCOM = "+" THEN
                        COMPUTE W-YMD-YY = W-YMD-YY + W-YMD-YYDEF
                ELSE    IF W-YMD-YY > W-YMD-YYDEF THEN
                                COMPUTE W-YMD-YY = W-YMD-YY - W-YMD-YYDEF
                        ELSE    COMPUTE W-YMD-YY = W-YMD-YY - W-YMD-YYDEF - 1
                                MOVE "-" TO W-YMD-YYS
                        END-IF
                END-IF
        END-IF.
*
* 時間 ...
        ACCEPT W-YMD-TIME8 FROM TIME.
        MOVE W-YMD-HHS TO W-YMD-HH.
        MOVE W-YMD-MTS TO W-YMD-MT.
        MOVE W-YMD-SSS TO W-YMD-SS.
*
        MOVE W-YMD-DATE TO W-DATE.
        MOVE W-YMD-TIME TO W-TIME.
*
*>
 F-RCB1-Aft-Create.
        PERFORM F-CREATE-HRSTATUS-RTN.
*>
 F-RCB1-Aft-Initdata.
        MODIFY S-IPD-MARK, ENABLED = 0.
        PERFORM F-INIT-RTN THRU F-INIT-EXIT.
*>      若為主程式則可選擇病患
*>      IF W-PARAMETERS = 1 THEN
*>              MOVE W-RUNL-CHK TO W-RUN-CHK
*>              PERFORM F-IPDIF-RTN
*>      ELSE
*>              INITIALIZE W-RUN-CHK
*>              PERFORM F-MOVE-INQ-TITLE
*>              PERFORM F-RCB-RTN
*>      END-IF.
*>---98.02.02---
        EVALUATE W-SOU
                WHEN "M"
                        PERFORM F-IPDIF-RTN
                WHEN "S"
                        PERFORM F-MOVE-INQ-TITLE
                        PERFORM F-RCB-RTN
                WHEN "O"
                        PERFORM F-IPDNO-RTN THRU F-IPDNO-END
                        PERFORM F-MOVE-INQ-TITLE
                        PERFORM F-RCB-RTN
        END-EVALUATE.
*>      0941206 先將床號存起來
        MOVE IPD-BED    TO W-TMP-IBGCF-IPD-BED.
*>
        PERFORM F-BLANK.
*>      檢驗檢查開檔
*>START (彙婷)106.06.07 W-HTICB2BF-LNK -> L-HTICB2BF-LNK
        INITIALIZE L-HTICB2BF-LNK.
        MOVE "0"        TO L-HTICB2BF-STATUS.

        CALL "HTICB2BF" USING L-HTICB2BF-LNK ON EXCEPTION CONTINUE.
*>END 106.06.07
***********************************************************************
 F-RCB1-Ex-Other.
        PERFORM F-BLANK.
        EVALUATE KEY-STATUS
                WHEN 27
                WHEN W-EXIT
*>                      IF W-PARAMETERS = 1 THEN
*>                              INITIALIZE KEY-STATUS
*>                              PERFORM F-IPDIF-RTN
*>                      ELSE
*>                              PERFORM F-EXIT-RTN
*>                      END-IF
*>                      ---(AICE) 98.05.15 電子病歷查印紀錄---
*>                      離開時打包所有圖
                        IF W-TMP-PACK-YN = "Y" THEN
                                IF L-PAM-LOG-YN = "Y" THEN
                                        INITIALIZE W-TMP-HZPAM
                                        PERFORM F-PACK-RTN
                                END-IF
                        END-IF
*>                      ---------------------------------------
*>                      ---98.02.02---
                        EVALUATE W-SOU
                                WHEN "M"
                                        INITIALIZE KEY-STATUS
                                        PERFORM F-IPDIF-RTN
                                WHEN "S"
                                        PERFORM F-EXIT-RTN
                                WHEN "O"
                                        PERFORM F-EXIT-RTN
                        END-EVALUATE
*>              查歷次
                WHEN W-SEARCH
                        PERFORM F-SEARCH-IPLIF-RTN
*>              查刪藥
                WHEN W-DEL
                        PERFORM F-DEL-RTN
*>              重印
                WHEN W-PRINT
                        MODIFY S-RCB1-GD-1, Y = W-GRID-Y
                        INQUIRE S-RCB1-GD-1, RECORD-DATA = W-GD-REC
                        IF W-GD-REC NOT = SPACE THEN
                                PERFORM F-F5-PRINT-RTN
                        END-IF
*>              刪除
                WHEN W-DELETE
                        IF W-RUN-SID = "G" OR "H" THEN
                                INITIALIZE W-NOTE
                                MOVE "歷史區只可使用查詢功能！！"       TO W-NOTE
                                PERFORM F-ERR-NOTE
                        ELSE
                                MODIFY S-RCB1-GD-1, Y = W-GRID-Y
                                INQUIRE S-RCB1-GD-1, RECORD-DATA = W-GD-REC
                                IF W-GD-REC NOT = SPACE THEN
                                        PERFORM F-DELETE-RTN

                                END-IF
                        END-IF
*>              看報告
                WHEN W-REPORT
                        MODIFY S-RCB1-GD-1, Y = W-GRID-Y
                        INQUIRE S-RCB1-GD-1, RECORD-DATA = W-GD-REC
                        PERFORM F-REPORT-RTN
*>              相關報告
                WHEN W-DATA
                        MODIFY S-RCB1-GD-1, Y = W-GRID-Y
                        INQUIRE S-RCB1-GD-1, RECORD-DATA = W-GD-REC
                        IF W-INQ-RX-WAY NOT = SPACE THEN
                                PERFORM Acu-S-HT-DATA-Routine
                        END-IF
*>              作業(用藥,檢驗,治療)
                WHEN W-RCB1
                        INITIALIZE W-TMP-PARA
                        MOVE "A"        TO W-TMP-PARA
                        PERFORM F-RCB-RTN
                WHEN W-RCB2
                        INITIALIZE W-TMP-PARA
                        MOVE "B"        TO W-TMP-PARA
                        PERFORM F-RCB-RTN
                WHEN W-RCB3
                        INITIALIZE W-TMP-PARA
                        MOVE "C"        TO W-TMP-PARA
                        PERFORM F-RCB-RTN
        END-EVALUATE.

 F-RCB-RTN.
*>      表單名稱
        PERFORM F-TOP-TITLE.
        DISPLAY S-RCB1.
        PERFORM F-FORM-TITLE.
        PERFORM F-FUN-RTN THRU F-FUN-EXIT.
        IF W-CHK-EXIT = "Y"THEN
*>              IF W-PARAMETERS = 1 THEN
*>                      PERFORM F-IPDIF-RTN
*>              ELSE
*>                      PERFORM F-EXIT-RTN
*>              END-IF
*>              ---98.02.02---
                EVALUATE W-SOU
                        WHEN "M"
                                PERFORM F-IPDIF-RTN
                        WHEN "S"
                                PERFORM F-EXIT-RTN
                        WHEN "O"
                                PERFORM F-EXIT-RTN
                END-EVALUATE
        END-IF.
***********************************************************************
*> 離開處理
***********************************************************************
 F-STOP-RTN.
*>      0941206 增加產生檢驗刪除處方單(產生QUE表記錄)
        IF W-HRDTA-COUNT > 0 THEN

                PERFORM F-HRIBGCF-MOVE-QQ
        END-IF.
*>START (彙婷)106.06.07 W-HTICB2BF-LNK -> L-HTICB2BF-LNK
*>      檢驗檢查取消
        INITIALIZE L-HTICB2BF-LNK.
        MOVE "2"        TO L-HTICB2BF-STATUS.
*>      ---(AICE) 98.04.17 檢驗檢查連線失敗時秀出訊息 ---
        CALL "HTICB2BF" USING L-HTICB2BF-LNK ON EXCEPTION
*>END 106.06.07
                PERFORM F-HTICB2BF-NOTE-RTN THRU F-HTICB2BF-NOTE-END
        END-CALL.
*>      ----------------------------------------------------------------

*>
*>      PERFORM Acu-Exit-Rtn
        PERFORM F-HT-CLOSE.
*>      IF W-PARAMETERS = 1 THEN
*>              PERFORM F-CLOSE-RTN THRU F-CLOSE-EXIT
*>      END-IF.
*>      ---98.02.02---
        EVALUATE W-SOU
                WHEN "M"
                        PERFORM F-CLOSE-RTN THRU F-CLOSE-EXIT
                WHEN "O"
                        PERFORM F-CLOSE-RTN THRU F-CLOSE-EXIT
        END-EVALUATE.
*>      0931207 增加DESTROY FONT
        DESTROY 細明體12, 細明體11, Fixed-Font.
        DESTROY S-RCB1-Mn-1-Handle.
        GOBACK.
***********************************************************************
*> 住院醫令表單控制檔 (某護理站要列印的表單檔)－取消處方箋(檢驗刪除)
 F-HRIBGCF-MOVE-QQ.
        INITIALIZE W-IBGCF-LNK.
        MOVE W-DATE                     TO W-IBGCF-DATE.
        MOVE "A"                        TO W-IBGCF-GET-UNIT.
        MOVE W-TMP-IBGCF-IPD-BED        TO W-IBGCF-IPD-BED.
        MOVE "q"                        TO W-IBGCF-PAPER-ID.
        MOVE HRDTA-IPD-NO               TO W-IBGCF-PRINT-DATA(1:11).
        MOVE HRDTA-ODR-NO               TO W-IBGCF-PRINT-DATA(12:13).

*>START (書伶) 104.03.19 因IPD指標可能被異動，改用預先暫存的BED傳送護理站表單列印作業
*>      ---(AICE) 98.06.24 增加傳床位號 ---
*>      MOVE IPD-BED                    TO W-IBGCF-IPD-BED.
*>      104.03.19 END

        CALL "HRIBGCF" USING W-IBGCF-LNK ON EXCEPTION CONTINUE.
***********************************************************************
 F-RCB1-Gd-1-Ev-Msg-Begin-Entry.
        SET EVENT-ACTION TO EVENT-ACTION-FAIL.
        PERFORM F-RCB1-GD-1-EV-MSG-GOTO-CELL.
*>      點二下可看報告
        IF W-TMP-ECB-TYPE = "2" THEN
                MODIFY S-RCB1-GD-1, Y = W-GRID-Y
                INQUIRE S-RCB1-GD-1, RECORD-DATA = W-GD-REC
                PERFORM F-REPORT-RTN
        END-IF.

*
 F-RCB1-Gd-1-Ev-Msg-Begin-Drag.
        SET EVENT-ACTION TO EVENT-ACTION-FAIL.
*
 F-RCB1-Gd-1-Ev-Msg-Goto-Cell.
        IF (EVENT-DATA-2 = 16 AND W-GRID-Y = 2) OR (EVENT-DATA-2 = 2 AND W-GRID-Y = 16) THEN
                SET EVENT-ACTION TO EVENT-ACTION-FAIL
        ELSE
                MOVE EVENT-DATA-2       TO W-GRID-Y
        END-IF.
        PERFORM F-COLOR-RTN.

 F-COLOR-RTN.
        MODIFY S-RCB1-GD-1, CURSOR-Y = W-GRID-Y, Y = W-GRID-Y.
        MODIFY S-RCB1-GD-1,START-X = 1,X = 99,START-Y = W-GRID-Y ,Y = W-GRID-Y,REGION-COLOR = W-GD-COLOR.
*
 F-RCB1-Gd-1-Ev-Msg-Goto-Cell-Mouse.
        MOVE EVENT-DATA-2       TO W-GRID-Y.
        PERFORM F-COLOR-RTN.
*
 F-TOP-TITLE.
        EVALUATE W-TMP-PARA
                WHEN "A"
                        MOVE "住院期間用藥明細查詢"     TO W-TOP-TITLE(1:50)
                WHEN "B"
                        MOVE "住院期間檢驗放射線查詢"   TO W-TOP-TITLE(1:50)
                WHEN "C"
                        MOVE "住院期間治療處置查詢"     TO W-TOP-TITLE(1:50)
        END-EVALUATE.
 F-IPDIF-RTN.
        INITIALIZE L-IPDIF-LNK.
        CALL "HRIPDIF" USING L-IPDIF-LNK.
        IF L-LNK-YN NOT = "Y" THEN
                PERFORM F-EXIT-RTN
        ELSE
                PERFORM F-MOVE-INQ-TITLE
                PERFORM F-RCB-RTN
        END-IF.
*>---98.02.02---
 F-IPDNO-RTN.
        INITIALIZE PAT-MST-REC IPD-MST-REC.
        MOVE W-HTCGUICF-EXT-PT-NO TO PAT-NO IPD-PAT-NO.
        READ PAT-MST KEY IS PAT-MST-KEY.
        INITIALIZE W-PTDECF-LNK.
        MOVE 'O'                TO W-PTDECF-IO-SW.
        MOVE 'Y'                TO W-PTDECF-IO-HHPAT-YN.
        MOVE PAT-NO             TO W-PTDECF-PAT-NO.
        MOVE 'HRRCB1IF'         TO W-PTDECF-PROG-ID.
        MOVE 'F-IPDNO'          TO W-PTDECF-PROG-PARA.
*>      MOVE 'HT_PAT0.PRC'      TO W-PTDECF-C-PY-FILE.
        MOVE '住院期間用藥明細查詢' TO W-PTDECF-PROG-NM.
*>      MOVE 'W1'        TO W-PTDECF-FUN-SEL.
        MOVE W-RUN-USID         TO W-PTDECF-UPD-UID.
        MOVE PAT-MST-REC        TO W-PTDECF-PAT-MST-REC.
        CALL "HHPTDECF" USING W-PTDECF-LNK
                ON EXCEPTION  CONTINUE
        END-CALL.

        EVALUATE W-PTDECF-IO-YN
                WHEN 'Y'
                        MOVE W-PTDECF-PAT-MST-REC TO PAT-MST-REC
                WHEN 'N'
                        DISPLAY MESSAGE "病歷號: " PAT-NO "病歷檔加解密失敗!!"
        END-EVALUATE.
        IF PAT-MST-STATUS NOT = "00"
                DISPLAY MESSAGE "無此病歷號碼，請檢查！"
        ELSE
                INITIALIZE IPX-MST-REC
                MOVE "A"        TO IPX-LIVE-ID
                MOVE PAT-NO     TO IPX-PAT-NO
                START IPX-MST KEY IS >= IPX-ALT-KEY3
                READ IPX-MST NEXT RECORD
                IF IPX-MST-STATUS NOT = "00" OR IPX-LIVE-ID NOT = "A" OR
                   IPX-PAT-NO NOT = PAT-NO THEN
                        DISPLAY MESSAGE "查無符合之住院延伸資料，請檢查！"
                ELSE
                        INITIALIZE IPD-MST-REC
                        MOVE IPX-NO     TO IPD-NO
                        READ IPD-MST KEY IS IPD-MST-KEY
*
                        IF IPD-MST-STATUS NOT = "00" OR
                           IPD-PAT-NO NOT = W-HTCGUICF-EXT-PT-NO THEN
                                DISPLAY MESSAGE "查無符合之住院延伸資料，請檢查！"
                        ELSE
                                IF (IPD-OUT-DT NOT = 0 AND IPD-OUT-DT < W-DATE) THEN
                                        DISPLAY MESSAGE "請注意！此病患已辦理出院！！"
                                END-IF
                        END-IF
                END-IF
        END-IF.
 F-IPDNO-END.
        EXIT.

*>---(AICE) 98.04.17 檢驗連線失敗 ---
 F-HTICB2BF-NOTE-RTN.
        INITIALIZE W-HRMESCF-DATA W-HRMESCF-DATA2.
        MOVE "檢驗放射線連線處理失敗！！"       TO W-HRMESCF-NOTE(1).
        MOVE "請注意：本次檢驗處方並無連線至檢驗系統！" TO W-HRMESCF-NOTE(3).
        MOVE "　　　　如有刪除檢驗處方，則請盡速連絡資訊室人員" TO W-HRMESCF-NOTE(5).
*>      MOVE "　　　　若已選擇存檔者，請先刪除已產生之項目以免重覆計價！"       TO W-HRMESCF-NOTE(7).
        MOVE "2"        TO W-HRMESCF-PIC-TYPE.
        MOVE "3"        TO W-HRMESCF-BUT-TYPE.
        CALL "HRMESCF" USING W-HRMESCF-DATA W-HRMESCF-DATA2 ON EXCEPTION CONTINUE.
 F-HTICB2BF-NOTE-END.
        EXIT.
******************************************************************
*> PAGE
******************************************************************
 F-RCB1-Gd-1-Ev-Msg-Paged-Prev.
        PERFORM F-BLANK.
        IF W-GRID-Y = 2 THEN
                PERFORM F-SCREEN-UP
        ELSE
                SUBTRACT 1 FROM W-GRID-Y
                MOVE W-GRID-Y TO W-GRID-Y1

                MODIFY S-RCB1-GD-1,START-X = 1,X = 99,START-Y = W-GRID-Y ,Y = W-GRID-Y,REGION-COLOR = W-GD-COLOR
        END-IF.
        SET EVENT-ACTION  TO Event-Action-Complete.
*
 F-RCB1-Gd-1-Ev-Msg-Paged-Next.
        PERFORM F-BLANK.
        IF W-GRID-Y = W-MENU-ITEMS THEN
                PERFORM F-Screen-DOWN
        ELSE
                ADD 1 TO W-GRID-Y
                MOVE W-GRID-Y TO W-GRID-Y1
                MODIFY S-RCB1-GD-1,START-X = 1,X = 99,START-Y = W-GRID-Y ,Y = W-GRID-Y,REGION-COLOR = W-GD-COLOR
        END-IF.
        SET EVENT-ACTION  TO Event-Action-Complete.
*
 F-RCB1-Gd-1-Ev-Msg-Paged-Nextpage.
        PERFORM F-BLANK.
        PERFORM F-SCREEN-DOWN.
        SET EVENT-ACTION TO EVENT-ACTION-FAIL.
*
 F-RCB1-Gd-1-Ev-Msg-Paged-Prevpage.
        PERFORM F-BLANK.
        PERFORM F-SCREEN-UP.
        SET EVENT-ACTION TO EVENT-ACTION-FAIL.
******************************************************************
*> 視窗二
******************************************************************
 F-HT-DATA-Ex-Cmd-Close.
        PERFORM Acu-S-HT-DATA-Exit.
*
 F-HT-DATA-Aft-Initdata.
        PERFORM F-HT-DATA-RTN.
*
 S-HT-DATA-Ex-Other.
        PERFORM F-HT-DATA-EX-CMD-CLOSE.
***********************************************************************
 F-CHK-FORM-RTN.
        EVALUATE W-TMP-PARA
                WHEN "A"
                        MODIFY S-RCB1-Gd-1, COLUMN-DIVIDERS = (1,1,1,1,1,1,1,1,1)
                        PERFORM F-SHOW-FORM1-RTN
                        MOVE "1"        TO W-TMP-ECB-TYPE
                WHEN "B"
                        MODIFY S-RCB1-Gd-1, COLUMN-DIVIDERS = (1,1,0,1,0,1,1,1,1)
                        PERFORM F-SHOW-FORM2-RTN
                        MOVE "2"        TO W-TMP-ECB-TYPE
                WHEN "C"
                        MODIFY S-RCB1-Gd-1, COLUMN-DIVIDERS = (1,0,0,1,1,1,1,1,1)
                        PERFORM F-SHOW-FORM3-RTN
                        MOVE "3"        TO W-TMP-ECB-TYPE
        END-EVALUATE.

 F-SHOW-FORM1-RTN.
        MODIFY S-RCB1-GD-1, START-X = 1, X = 99, START-Y = 2, Y = 2, REGION-COLOR = 1.
        MODIFY S-RCB1-GD-1, RESET-GRID = 1, NUM-ROWS = 16.
        PERFORM ACU-S-RCB1-GD-1-CONTENT.
        MODIFY S-RCB1-GD-1, X = 3, Y = 1, CELL-DATA = "次劑量".

        MODIFY S-RCB1-GD-1, X = 4, Y = 1, CELL-DATA = "服法".
        MODIFY S-RCB1-GD-1, X = 5, Y = 1, CELL-DATA = "天".
        MODIFY S-RCB1-GD-1, X = 8, Y = 1, CELL-DATA = "類別".
        MODIFY S-RCB1-GD-1, X = 9, Y = 1, CELL-DATA = "退".
*>      ---(AICE) 98.10.22 增加實際退藥量---
        MODIFY S-RCB1-GD-1, X = 11, Y = 1, CELL-DATA = "實際退藥量".
        MODIFY S-RCB1-GD-1, VIRTUAL-WIDTH = 134.
        CALL "W$MENU" USING WMENU-DISABLE,S-RCB1-Mn-1-Handle,W-PRINT.
        CALL "W$MENU" USING WMENU-DISABLE,S-RCB1-Mn-1-Handle,W-DELETE.
        CALL "W$MENU" USING WMENU-DISABLE,S-RCB1-Mn-1-Handle,W-REPORT.
        CALL "W$MENU" USING WMENU-DISABLE,S-RCB1-Mn-1-Handle,W-DATA.
        CALL "W$MENU" USING WMENU-DISABLE,S-RCB1-Mn-1-Handle,W-RCB1.
        CALL "W$MENU" USING WMENU-ENABLE,S-RCB1-Mn-1-Handle,W-RCB2.
        CALL "W$MENU" USING WMENU-ENABLE,S-RCB1-Mn-1-Handle,W-RCB3.
        CALL "W$MENU" USING WMENU-ENABLE,S-RCB1-Mn-1-Handle,W-DEL.
 F-SHOW-FORM2-RTN.
        MODIFY S-RCB1-GD-1, START-X = 1, X = 99, START-Y = 2, Y = 2, REGION-COLOR = 1.
        MODIFY S-RCB1-GD-1, RESET-GRID = 1, NUM-ROWS = 16.
        PERFORM ACU-S-RCB1-GD-1-CONTENT.
        MODIFY S-RCB1-GD-1, X = 4, Y = 1, CELL-DATA = "狀況".
        MODIFY S-RCB1-GD-1, X = 8, Y = 1, CELL-DATA = "異常".
        MODIFY S-RCB1-GD-1, X = 9, Y = 1, CELL-DATA = "刪".
*>START (AICE) 106.11.09 增加顯示已刪除之檢驗項目
        IF W-RUN-CFNO-S = "1205" THEN
                MODIFY S-RCB1-GD-1, X = 12, Y = 1, CELL-DATA = "取消日-時間"
                MODIFY S-RCB1-GD-1, VIRTUAL-WIDTH = 147
        END-IF.
*>END 106.11.09
        CALL "W$MENU" USING WMENU-ENABLE,S-RCB1-Mn-1-Handle,W-PRINT.
        CALL "W$MENU" USING WMENU-ENABLE,S-RCB1-Mn-1-Handle,W-DELETE.
        CALL "W$MENU" USING WMENU-ENABLE,S-RCB1-Mn-1-Handle,W-REPORT.
        CALL "W$MENU" USING WMENU-ENABLE,S-RCB1-Mn-1-Handle,W-DATA.
        CALL "W$MENU" USING WMENU-ENABLE,S-RCB1-Mn-1-Handle,W-RCB1.
        CALL "W$MENU" USING WMENU-ENABLE,S-RCB1-Mn-1-Handle,W-RCB3.
        CALL "W$MENU" USING WMENU-DISABLE,S-RCB1-Mn-1-Handle,W-RCB2.
        CALL "W$MENU" USING WMENU-DISABLE,S-RCB1-Mn-1-Handle,W-DEL.
 F-SHOW-FORM3-RTN.
        MODIFY S-RCB1-GD-1, START-X = 1, X = 99, START-Y = 2, Y = 2, REGION-COLOR = 1.
        MODIFY S-RCB1-GD-1, RESET-GRID = 1, NUM-ROWS = 16.
        PERFORM ACU-S-RCB1-GD-1-CONTENT.
        MODIFY S-RCB1-GD-1, X = 5, Y = 1, CELL-DATA = "天".
        MODIFY S-RCB1-GD-1, X = 8, Y = 1, CELL-DATA = "類別".
        MODIFY S-RCB1-GD-1, X = 9, Y = 1, CELL-DATA = "退".
        CALL "W$MENU" USING WMENU-DISABLE,S-RCB1-Mn-1-Handle,W-PRINT.
        CALL "W$MENU" USING WMENU-DISABLE,S-RCB1-Mn-1-Handle,W-DELETE.
        CALL "W$MENU" USING WMENU-DISABLE,S-RCB1-Mn-1-Handle,W-REPORT.
        CALL "W$MENU" USING WMENU-DISABLE,S-RCB1-Mn-1-Handle,W-DATA.
        CALL "W$MENU" USING WMENU-DISABLE,S-RCB1-Mn-1-Handle,W-RCB3.
        CALL "W$MENU" USING WMENU-ENABLE,S-RCB1-Mn-1-Handle,W-RCB1.
        CALL "W$MENU" USING WMENU-ENABLE,S-RCB1-Mn-1-Handle,W-RCB2.
        CALL "W$MENU" USING WMENU-ENABLE,S-RCB1-Mn-1-Handle,W-DEL.
***************************************************************************************
 F-FUN-RTN.
        PERFORM F-CHK-FORM-RTN.
        INITIALIZE W-CHK-EXIT.
        EVALUATE W-TMP-PARA
                WHEN "A"

                        PERFORM F-CHK-ECB1-RTN
                        IF W-FS = 10 THEN
                                PERFORM F-MESG1-RTN
                                PERFORM F-IPLIF-RTN
                                IF W-LNK-IPL-YN = "Y" THEN
                                        PERFORM F-MOVE-INQ-TITLE
                                        GO TO F-FUN-RTN
                                ELSE
                                        MOVE "Y"        TO W-CHK-EXIT
                                        GO TO F-FUN-EXIT
                                END-IF
                        ELSE
                                PERFORM F-PICB-RTN
                        END-IF
                WHEN "B"
                        PERFORM F-CHK-ECB2-RTN
*>START                 (AICE) 106.11.09 增加顯示已刪除之檢驗項目
                        IF W-RUN-CFNO-S = "1205" THEN
                                INITIALIZE HRDTB-MST-REC
                                MOVE IPD-NO     TO HRDTB-IPD-NO
                                PERFORM F-START-HRDTB-RTN THRU F-START-HRDTB-EXIT
                        END-IF
*>END 106.11.09
                        IF W-FS = 10     THEN
                                PERFORM F-MESG2-RTN
                                PERFORM F-IPLIF-RTN
                                IF W-LNK-IPL-YN = "Y" THEN
                                        PERFORM F-MOVE-INQ-TITLE
                                        GO TO F-FUN-RTN
                                ELSE
                                        MOVE "Y"        TO W-CHK-EXIT
                                        GO TO F-FUN-EXIT
                                END-IF
                        ELSE
*>START                         (AICE) 106.11.09 增加顯示已刪除之檢驗項目
*>                              PERFORM F-PICB-RTN
                                IF W-RUN-CFNO-S = "1205" THEN
                                        MOVE 1          TO W-PAGE W-NO
                                        MOVE ECB-MST-REC        TO W-PICB W-KEY1(W-PAGE)
                                        MOVE HRDTB-MST-REC      TO W-KEY2(W-PAGE)
                                        PERFORM F-READ-TEST-RTN THRU F-READ-TEST-EXIT
                                ELSE
                                        PERFORM F-PICB-RTN
                                END-IF
*>END 106.11.09
                        END-IF
                WHEN "C"
                        PERFORM F-CHK-ECB1-RTN
                        IF W-FS = 10 THEN
                                PERFORM F-MESG3-RTN
                                PERFORM F-IPLIF-RTN
                                IF W-LNK-IPL-YN = "Y" THEN
                                        PERFORM F-MOVE-INQ-TITLE
                                        GO TO F-FUN-RTN
                                ELSE
                                        MOVE "Y"        TO W-CHK-EXIT
                                        GO TO F-FUN-EXIT

                                END-IF
                        ELSE
                                PERFORM F-PICB-RTN
                        END-IF
        END-EVALUATE.

 F-FUN-EXIT.
        EXIT.
***********************************************************************
 F-MESG1-RTN.
        INITIALIZE W-NOTE.
        IF W-TYPE1 = "D" THEN
                MOVE "患者此次住院期間並無刪除整張處方！"       TO W-NOTE
                PERFORM F-ERR-NOTE
                INITIALIZE W-TYPE1
        ELSE
                MOVE "患者此次住院期間並無開立藥品！"   TO W-NOTE
                PERFORM F-ERR-NOTE
        END-IF.

 F-MESG2-RTN.
        INITIALIZE W-NOTE.
        MOVE "患者此次住院期間並無開立檢驗放射線！" TO W-NOTE.
        PERFORM F-ERR-NOTE.
 F-MESG3-RTN.
        INITIALIZE W-NOTE.
        IF W-TYPE1 = "D" THEN
                MOVE "患者此次住院期間並無刪除整張處方！" TO W-NOTE
                PERFORM F-ERR-NOTE
                INITIALIZE W-TYPE1
        ELSE
                MOVE "患者此次住院期間並無確認治療處置！" TO W-NOTE
                PERFORM F-ERR-NOTE
        END-IF.
 F-IPLIF-RTN.
        INITIALIZE ECB-MST-REC W-PICB.
        INITIALIZE W-IPLIF-LNK.
        MOVE PAT-NO     TO W-LNK-PAT-NO.
        CALL "HRIPLIF" USING W-IPLIF-LNK ON EXCEPTION CONTINUE.

 F-PICB-RTN.
        MOVE 1           TO W-PAGE W-NO.
        MOVE ECB-MST-REC TO W-PICB W-KEY1(W-PAGE).
        PERFORM F-999-RTN.
*>      ---(AICE) 98.05.15 電子病歷查印紀錄---
        IF      L-PAM-LOG-YN     = "Y"       THEN
                PERFORM F-CATCH-SEL-RTN
        END-IF.
*>      ----------------------------------------------

 F-CHK-ECB1-RTN.
        INITIALIZE ECB-MST-REC.
        IF W-TYPE1 = "D" THEN
                MOVE "D"        TO ECB-DEL-MARK
        END-IF.
        MOVE IPD-NO             TO ECB-IPD-NO.
        MOVE W-TMP-ECB-TYPE     TO ECB-TYPE.

        PERFORM F-STARTS-RTN.
        PERFORM F-READN-RTN THRU F-READN-EXIT.
 F-CHK-ECB2-RTN.
        INITIALIZE ECB-MST-REC.
        MOVE IPD-NO             TO ECB-IPD-NO.
        MOVE W-TMP-ECB-TYPE     TO ECB-TYPE.
        PERFORM F-STARTS-RTN.
        PERFORM F-READN-RTN THRU F-READN-EXIT.

 F-STARTS-RTN.
        START ECB-MST KEY IS NOT < ECB-ALT-KEY2.
        MOVE ECB-MST-STATUS TO W-FS.

 F-STARTG-RTN.
        START ECB-MST KEY IS > ECB-ALT-KEY2.
        MOVE ECB-MST-STATUS TO W-FS.

 F-READN-RTN.
        READ ECB-MST NEXT RECORD.
        MOVE ECB-MST-STATUS TO W-FS.
        IF ECB-MST-STATUS = "00" THEN
                INITIALIZE ICB-MST-REC
                MOVE ECB-KEY   TO ICB-KEY
                READ ICB-MST KEY IS ICB-KEY
                IF ICB-MST-STATUS NOT = "00" THEN
                        GO TO F-READN-RTN
                END-IF
        END-IF.
        IF ECB-MST-STATUS NOT = "00" OR ECB-IPD-NO NOT = IPD-NO
           OR ECB-TYPE NOT = W-TMP-ECB-TYPE THEN
                MOVE 10 TO W-FS
        END-IF.

 F-READN-EXIT.
        EXIT.

 F-999-RTN.
        PERFORM F-CHK-FORM-RTN.
        INITIALIZE W-DIS-TABLE.
        PERFORM VARYING W-II FROM 2 BY 1 UNTIL ECB-MST-STATUS NOT = "00" OR
                                               W-II > W-MENU-ITEMS OR W-FS = 10
                PERFORM F-LOAD-GRID-RTN
                PERFORM F-READN-RTN
        END-PERFORM.
*>      先把指標移到第一筆資料
        MODIFY S-RCB1-GD-1,START-X = 1,X = 99,START-Y = 2 ,Y = 2,REGION-COLOR = W-GD-COLOR.
        MOVE 2  TO W-GRID-Y W-GRID-Y1.

 F-LOAD-GRID-RTN.
        INITIALIZE W-GD-REC.
        MOVE ECB-MST-REC TO W-DIS-REC(W-II).
        MOVE W-NO       TO W-INQ-SEQ.
        IF ICB-UNIT NOT = SPACE THEN
                MOVE ICB-UNIT           TO W-QTY1 WITH CONVERT
                MOVE ICB-RX-UNIT        TO W-QTY2 WITH CONVERT
                PERFORM F-QTY-RTN
                MOVE W-DIS-QTY          TO W-INQ-RX-UQTY

        ELSE
                IF ICB-RX-UQTY1 > 0 AND ICB-RX-UQTY2 > 0 THEN
*>2022/08/22 增加WITH CONVERT
                        MOVE ICB-RX-UQTY(1:2)   TO W-QTY1 WITH CONVERT
                        MOVE ICB-RX-UQTY(3:2)   TO W-QTY2 WITH CONVERT
                        PERFORM F-QTY-RTN
                        MOVE W-DIS-QTY          TO W-INQ-RX-UQTY
                ELSE
                        MOVE SPACE              TO W-INQ-RX-UQTY
                END-IF
        END-IF.
        IF ICB-RX-QTY1 > 0 AND ICB-RX-QTY2 > 0 THEN
*>2022/08/22 增加WITH CONVERT
                MOVE ICB-RX-QTY(1:4)    TO W-QTY1 WITH CONVERT
                MOVE ICB-RX-QTY(5:2)    TO W-QTY2 WITH CONVERT
                PERFORM F-QTY-RTN
                MOVE W-DIS-QTY          TO W-INQ-RX-QTY
        ELSE
                MOVE ICB-RX-QTY1        TO W-INQ-RX-QTY(1:4)
                MOVE ICB-RX-QTY2        TO W-INQ-RX-QTY(6:2)
        END-IF.
        IF ECB-ODR-NO NOT = ICA-ODR-NO THEN
                INITIALIZE ICA-MST-REC
                MOVE ECB-ODR-NO         TO ICA-ODR-NO
                MOVE IPD-NO             TO ICA-IPD-NO
                READ ICA-MST KEY IS ICA-KEY
        END-IF.
        EVALUATE W-TMP-ECB-TYPE
                WHEN "1"
                WHEN "3"
                        EVALUATE ICA-UD-MARK
                                WHEN "U"
                                        MOVE "長期"     TO W-INQ-TYPE
                                WHEN "O"
                                        MOVE " 轉 "     TO W-INQ-TYPE
                                WHEN "B"
                                        MOVE "首日"     TO W-INQ-TYPE
                                WHEN "J"
                                        MOVE "傳送"     TO W-INQ-TYPE
                                WHEN OTHER
                                        EVALUATE TRUE
                                                WHEN ICA-EMG-CD = "1"
                                                        MOVE "出院"     TO W-INQ-TYPE
                                                WHEN ICA-DR-YN = "X"
                                                        MOVE "臨時"     TO W-INQ-TYPE
                                                WHEN ICA-EMG-CD = "Y"
*>                                                      ---(AICE) 98.11.17 增加自備藥顯示---
                                                        IF ECB-SELF-DRUG = "K" THEN
                                                                MOVE "自備"     TO W-INQ-TYPE
                                                        ELSE
                                                                MOVE "緊急"     TO W-INQ-TYPE
                                                        END-IF
                                                WHEN ICA-DR-YN = "T"
                                                        MOVE "檢驗"     TO W-INQ-TYPE
                                                WHEN ICA-DR-YN = "C"
                                                        MOVE "治療"     TO W-INQ-TYPE
                                                WHEN ICA-DR-YN = " "

                                                        MOVE "批價"     TO W-INQ-TYPE
                                                WHEN OTHER
                                                        INITIALIZE W-INQ-TYPE
                                        END-EVALUATE
                        END-EVALUATE
                WHEN OTHER
                        INITIALIZE W-INQ-TYPE
        END-EVALUATE.
*>      服法
        MOVE ICB-RX-WAY1        TO W-INQ-RX-WAY(1:5).
        MOVE ICB-RX-WAY2        TO W-INQ-RX-WAY(6:5).
        MOVE ICB-RX-DAYS        TO W-INQ-RX-DAYS.
        MOVE ICA-INS-DATE       TO W-INQ-INS-DATE(1:7) .
        MOVE "-"                TO W-INQ-INS-DATE(8:1).
*>START (FISH) 102.03.15 MAV-如果ICA-ODR-TIME為數字型態，才搬值 （DM1301-J1300326）
*>      MOVE ICA-ODR-TIME       TO W-INQ-INS-DATE(9:4).
        IF ICA-ODR-TIME IS NUMERIC      THEN
                MOVE ICA-ODR-TIME       TO W-INQ-INS-DATE(9:4)
        END-IF.
*>102.03.15 END
        INITIALIZE PRS-MST-REC.
        MOVE ICB-FEE-KEY        TO PRS-MST-ID.
        READ PRS-MST KEY IS PRS-MST-KEY.
        IF PRS-MST-STATUS = "00" THEN
                MOVE PRS-ID-NAME        TO W-INQ-PRS-NAME
        ELSE
                MOVE "代碼已不存在"     TO W-INQ-PRS-NAME
        END-IF.

*>      103.06.27 (書伶)修改實際退藥量欄位讀取來源，改讀RTA及RTB。
        INITIALIZE RTB-MST-REC W-RTB-QTY.
        MOVE IPD-NO TO RTB-IPD-NO.
        INITIALIZE A4GL-WHERE-CONSTRAINT.
        STRING " rtb_key like '" IPD-NO "%'"
                " and substring(rtb_group_data1,145,11) = '" ICB-ODR-NO "'"
                " and substring(rtb_group_data1,156,3) = '" ICB-FEE-SEQ "'"
                DELIMITED BY SIZE INTO A4GL-WHERE-CONSTRAINT.
        INSPECT A4GL-WHERE-CONSTRAINT REPLACING TRAILING SPACES
                BY LOW-VALUES.
        START RTB-MST KEY IS > RTB-KEY.
        INITIALIZE A4GL-WHERE-CONSTRAINT.
        READ RTB-MST NEXT RECORD.
        PERFORM UNTIL RTB-MST-STATUS NOT = "00" OR RTB-IPD-NO NOT = IPD-NO
*>              讀RTA資料，若已上刪除註記，則讀下一筆
                INITIALIZE RTA-MST-REC
                MOVE RTB-IPD-NO TO RTA-IPD-NO
                MOVE RTB-ODR-NO TO RTA-ODR-NO
                READ RTA-MST KEY IS RTA-KEY
                IF RTA-MST-STATUS = "00" AND RTA-DEL-MARK = "D" THEN
                        READ RTB-MST NEXT RECORD
                        EXIT PERFORM CYCLE
                END-IF
*>              ADD  RTB-RX-QTY1        TO W-RTB-QTY1
*>              MOVE RTB-RX-QTY2        TO W-RTB-QTY2
*>              計算已退總量
                PERFORM F-ADD-RTB-QTY
                READ RTB-MST NEXT RECORD

        END-PERFORM.
        IF W-RTB-QTY1 > 0 AND W-RTB-QTY2 > 0 THEN
                MOVE "*"                TO W-INQ-MARK
                MOVE W-RTB-QTY1         TO W-QTY1
                MOVE W-RTB-QTY2         TO W-QTY2
                PERFORM F-QTY-RTN
                MOVE W-DIS-QTY          TO W-INQ-RTB-RX-QTY
        ELSE
                MOVE SPACE      TO W-INQ-MARK
                INITIALIZE W-INQ-RTB-RX-QTY
        END-IF.
*>      103.06.27 END

*>      IF ICB-RTN-QTY1 > 0 AND ICB-RTN-QTY2 > 0 THEN
*>                MOVE "*"        TO W-INQ-MARK
*>*>            ---(AICE) 98.10.22 增加顯示退藥量---
*>              MOVE ICB-RTN-QTY1       TO W-QTY1
*>              MOVE ICB-RTN-QTY2       TO W-QTY2
*>              PERFORM F-QTY-RTN
*>              MOVE W-DIS-QTY          TO W-INQ-RTB-RX-QTY
*>      ELSE
*>              MOVE SPACE      TO W-INQ-MARK
*>              INITIALIZE W-INQ-RTB-RX-QTY
*>      END-IF.
*----->若為住院期間檢驗放射線查詢
        IF W-TMP-PARA = "B" THEN
                PERFORM F-GET-STATUS
                IF W-NID-6101(80:1) = "Y" AND W-DIS-ITM-NM(W-II) NOT = SPACE THEN
                        MOVE W-DIS-ITM-NM(W-II) TO W-INQ-PRS-NAME
                END-IF
                MOVE SPACE      TO W-INQ-RX-UQTY W-INQ-RX-DAYS
        END-IF.
        IF W-TMP-PARA = "C" THEN
                MOVE SPACE      TO W-INQ-RX-UQTY W-INQ-RX-WAY W-INQ-RX-DAYS
        END-IF.
*>      0940828 增加顯示執行區間
        INITIALIZE W-INQ-ICB-OP-B.
        MOVE ICB-OP-BDATE       TO W-TMP-ICB-OP-BDATE WITH CONVERT.
        MOVE ICB-OP-EDATE       TO W-TMP-ICB-OP-EDATE WITH CONVERT.
        IF ICB-OP-BD-YY > 0 OR ICB-OP-ED-YY > 0 THEN
                STRING W-TMP-ICB-OP-BDATE "-" ICB-OP-BTIME "~"
                        W-TMP-ICB-OP-EDATE "-" ICB-OP-ETIME
                        DELIMITED BY SIZE INTO W-INQ-ICB-OP-B
                END-STRING
        END-IF.

*>
        MODIFY S-RCB1-Gd-1, X = 1 , Y = W-II, RECORD-TO-ADD = W-GD-REC.
        MOVE W-GD-REC   TO W-DISR(W-II).
        ADD 1           TO W-NO.

 F-GET-STATUS.
        INITIALIZE HTCHK-REC.
        MOVE ICB-CHK-NO         TO HTCHK-CHK-NO.
*>      門診轉住院原處方日期處理
        IF ICA-UD-MARK = "O" THEN
*>              0930219修改 因門轉住資料筆數不見得是一個

                INITIALIZE FON-MST-REC
                MOVE "06"       TO FON-ID
                MOVE IPD-NO     TO FON-06-IPD-NO
                START FON-MST KEY IS NOT < FON-MST-KEY
                READ FON-MST NEXT RECORD
                PERFORM F-GET-STATUS1 UNTIL FON-MST-STATUS NOT = "00" OR
                        FON-ID NOT = "06" OR FON-06-IPD-NO NOT = IPD-NO OR
                        HTCHK-IP-DATE > 0
        ELSE
                MOVE ICB-INS-DATE       TO HTCHK-IP-DATE
        END-IF.
        MOVE HTCHK-IP-DATE      TO W-HTCHK-IP-DATE(W-II).
        READ HTCHK-MST KEY IS HTCHK-KEY.
        IF HTCHK-MST-STATUS = "00" THEN
*>START         (AICE) 100.02.21 (DM1101-J1100473)
                INITIALIZE W-ODRW-TABLE W-ODRW-AC-TABLE W-HR-ODRW-WK-NAME
                MOVE ICB-IPD-NO TO W-ODRW-IP-NO(1:11)
                MOVE ICB-ODR-NO TO W-ODRW-IP-NO(12:11)
*>START         (AICE) 99.11.17 DM1001-J1003068
*>              MOVE ICB-ODR-SEQ(2:3)   TO W-ODRW-PRS-SEQ
                MOVE ICB-FEE-SEQ        TO W-ODRW-PRS-SEQ
*>END DM1001-J1003068
                MOVE ICB-CHK-NO TO W-ODRW-CHK-NO
                MOVE ICB-ITM-CD TO W-ODRW-ITM-CD

*>START         (AICE) 100.02.21 (DM1101-J1100473)
                CALL "HTODRWCF" USING W-ODRW-TABLE, W-ODRW-AC-TABLE, W-HR-ODRW-WK-NAME
                        ON EXCEPTION PERFORM F-MOVE-WK-NAME-RTN THRU F-MOVE-WK-NAME-EXIT
                END-CALL
                MOVE W-HR-ODRW-WK-NAME TO W-INQ-RX-WAY(1:8)
                IF W-HR-ODRW-WK-NAME(1:4) = "異常" OR "危險" THEN
                               MOVE "⊕"       TO W-INQ-TYPE
                END-IF
*>96.7.30有危險值,異常欄位卻是空白
*               EVALUATE HTCHK-WK-SW
*                       WHEN " "
*                               MOVE "無狀態"   TO W-INQ-RX-WAY
*                       WHEN "A" THRU "D"
*                               MOVE "未執行"   TO W-INQ-RX-WAY
*                       WHEN "E" THRU "I"
*                               MOVE "執行中"   TO W-INQ-RX-WAY
*                       WHEN OTHER
*                               MOVE "已完成"   TO W-INQ-RX-WAY
*                                IF HTCHK-RP-ST = "N" THEN
*                                        MOVE "⊕"       TO W-INQ-TYPE
*                                END-IF
*                END-EVALUATE
*>              搬移檢驗時刻相關資料
                PERFORM F-MOVE-CHK-DATA
        ELSE
                IF ICB-CHK-NO = SPACE OR "   00000" THEN
                        INITIALIZE W-INQ-RX-UQTY
                ELSE
                        MOVE "不存在"   TO W-INQ-RX-UQTY
                END-IF
        END-IF.
*>      --- (AICE) HTCHK-CLS-CD等有可能因CALL "HTODRWCF"之後指標移位 ---

        MOVE ICB-CHK-NO(2:2) TO W-DIS-CLS-CD(W-II)
        MOVE ICB-CHK-NO(1:1) TO W-DIS-DPT-NO(W-II)
        MOVE ICB-CHK-NO      TO W-DIS-CHK-NO(W-II)
*>      MOVE HTCHK-CLS-CD       TO W-DIS-CLS-CD(W-II).
*>      MOVE HTCHK-DPT-CD       TO W-DIS-DPT-NO(W-II).
*>      MOVE HTCHK-CHK-NO       TO W-DIS-CHK-NO(W-II).
*>      -----------------------------------------------------------------
        MOVE ICB-ITM-CD         TO W-DIS-ITM-CD(W-II).
        MOVE ECB-OPD-APY        TO W-DIS-OPD-APY(W-II).

 F-GET-STATUS1.
        IF FON-MST-STATUS = "00" AND FON-ID = "06" AND FON-06-IPD-NO = IPD-NO THEN
                IF ICB-ODR-NO = FON-06-ODR-NO THEN
                        MOVE FON-06-RO-NO(1:7)  TO HTCHK-IP-DATE WITH CONVERT
                END-IF
                IF ICB-ODR-NO = FON-06-ODR-NO2 THEN
                        MOVE FON-06-RO-NO(1:7)  TO HTCHK-IP-DATE WITH CONVERT
                END-IF
        END-IF.
        READ FON-MST NEXT RECORD.

 F-MOVE-CHK-DATA.
*>      簽收時間
        MOVE HTCHK-AC-MAN       TO W-DIS-AC-MAN(W-II).
        MOVE HTCHK-AC-DATE      TO W-DIS-AC-DATE(W-II).
        MOVE HTCHK-AC-TIME      TO W-DIS-AC-TIME(W-II).
*>      報告時間
        MOVE HTCHK-RP-F-MAN     TO W-DIS-RP-F-MAN(W-II).
        MOVE HTCHK-RP-L-MAN     TO W-DIS-RP-L-MAN(W-II).
        MOVE HTCHK-RP-DATE      TO W-DIS-RP-DATE(W-II).
        MOVE HTCHK-RP-TIME      TO W-DIS-RP-TIME(W-II).
*>      增加顯示檢驗項目名稱及檢體、容器等資料
        INITIALIZE HTCTM-REC.
        MOVE HTCHK-CHK-NO    TO HTCTM-CHK-NO.
        MOVE HTCHK-IP-DATE   TO HTCTM-IP-DATE.
        MOVE ICB-ITM-CD      TO HTCTM-ITM-CD.
        READ HTCTM-MST KEY IS HTCTM-KEY.

        IF HTCTM-MST-STATUS = "00" AND HTCTM-CHK-NO = HTCHK-CHK-NO AND
           HTCTM-IP-DATE = HTCHK-IP-DATE AND HTCTM-ITM-CD = ICB-ITM-CD THEN
*               ITM 項目名稱
                INITIALIZE HTITM-REC
                MOVE HTCTM-CLS-NO TO HTITM-CLS-NO
                MOVE HTCTM-ITM-CD TO HTITM-ITM-CD
                READ HTITM-MST KEY IS HTITM-KEY
                IF HTITM-MST-STATUS = "00" AND HTITM-CLS-NO = HTCTM-CLS-NO AND
                   HTITM-ITM-CD = HTCTM-ITM-CD THEN
                        MOVE HTITM-ITM-NM TO W-DIS-ITM-NM(W-II)
                END-IF
*               SPL 檢體
                INITIALIZE HTSPL-REC
                MOVE HTCTM-DPT-CD TO HTSPL-DPT-CD
                MOVE HTCTM-SPL-CD TO HTSPL-SPL-CD
                READ HTSPL-MST KEY IS HTSPL-KEY
                IF HTSPL-MST-STATUS = "00" AND HTSPL-DPT-CD = HTCTM-DPT-CD AND
                   HTSPL-SPL-CD = HTCTM-SPL-CD THEN
                        MOVE HTSPL-SPL-NM TO W-DIS-SPL-NM(W-II)

                END-IF
*               BTL 容器
                INITIALIZE HTBTL-REC
                MOVE HTCTM-DPT-CD TO HTBTL-DPT-CD
                MOVE HTCTM-BTL-CD TO HTBTL-BTL-CD
                READ HTBTL-MST KEY IS HTBTL-KEY
                IF HTBTL-MST-STATUS = "00" AND HTBTL-DPT-CD = HTCTM-DPT-CD AND
                   HTBTL-BTL-CD = HTCTM-BTL-CD THEN
                        MOVE HTBTL-BTL-NM TO W-DIS-BTL-NM(W-II)
                END-IF
        END-IF.
*************************************************************************************
*------->顯示病患住院資料
*************************************************************************************
 F-MOVE-INQ-TITLE.
        MOVE PAT-NAME           TO W-PAT-NAME.
        IF PAT-SEX = "1" THEN
                MOVE "男"       TO W-SEX
        ELSE
                IF PAT-SEX = "2" THEN
                        MOVE "女"       TO W-SEX
                ELSE
                        INITIALIZE W-SEX
                END-IF
        END-IF.
*       COPY "ZD_DTI.PRC".
*
* ZD_DTI.PRC ... 同 ZD_YMD.PRC ...  取日期時間 ...
*
        MOVE W-RUN-YYSW  TO W-YMD-YYSW.
        MOVE W-RUN-YYDEF TO W-YMD-YYDEF.
        MOVE W-RUN-YYCOM TO W-YMD-YYCOM.
*
* 日期 ...
        ACCEPT W-YMD-DATE FROM CENTURY-DATE.
        MOVE W-YMD-YY TO W-YMD-YYB.
        MOVE W-YMD-YY TO W-YMD-YY1.
        MOVE W-YMD-MM TO W-YMD-MM1.
        MOVE W-YMD-DD TO W-YMD-DD1.
*
* YYSW   : 使用年曆設定     -- 4:使用四碼西元年 2:二碼西元年, 0:表使用當地國年
* YYDEF  : 年度換算初值     -- 西元年換算使用國年初值(例:1911, 0 視同1911)
* YYCOM  : 年度計算方式     -- 西元年計算使用國年方式(例:+,-, 空白視同 - )
* YDFSW  : 變數用...
*
        IF W-YMD-YYCOM NOT = "+" AND "-" THEN
                ACCEPT W-YMD-YYSW       FROM ENVIRONMENT "ZS_SYYW"
                END-ACCEPT
                ACCEPT W-YMD-YDFSW      FROM ENVIRONMENT "ZS_SYDF"
                END-ACCEPT
                ACCEPT W-YMD-YYCOM      FROM ENVIRONMENT "ZS_SYCM"
                END-ACCEPT
                IF W-YMD-YYSW NOT = "2" AND "4" THEN
                        MOVE "0" TO W-YMD-YYSW
                END-IF
                IF W-YMD-YYCOM NOT = "+" AND "-" THEN
                        MOVE "-" TO W-YMD-YYCOM

                END-IF
                MOVE W-YMD-YDFSW TO W-YMD-YYDEF WITH CONVERT
                IF ( W-YMD-YYDEF = 0 ) AND
                   ( W-YMD-YYSW  = "0" ) AND
                   ( W-YMD-YYCOM = "-" ) THEN
                        MOVE 1911 TO W-YMD-YYDEF
                END-IF
        END-IF.
*
* YYS : - 表轉換後年度為負值
*
        MOVE SPACE TO W-YMD-YYS.
        IF W-YMD-YYSW = "4" THEN
                CONTINUE
        ELSE
        IF W-YMD-YYSW = "2" THEN
                MOVE W-YMD-YY1 TO W-YMD-YY
        ELSE    IF W-YMD-YYCOM = "+" THEN
                        COMPUTE W-YMD-YY = W-YMD-YY + W-YMD-YYDEF
                ELSE    IF W-YMD-YY > W-YMD-YYDEF THEN
                                COMPUTE W-YMD-YY = W-YMD-YY - W-YMD-YYDEF
                        ELSE    COMPUTE W-YMD-YY = W-YMD-YY - W-YMD-YYDEF - 1
                                MOVE "-" TO W-YMD-YYS
                        END-IF
                END-IF
        END-IF.
*
* 時間 ...
        ACCEPT W-YMD-TIME8 FROM TIME.
        MOVE W-YMD-HHS TO W-YMD-HH.
        MOVE W-YMD-MTS TO W-YMD-MT.
        MOVE W-YMD-SSS TO W-YMD-SS.
*
        MOVE W-YMD-DATE TO W-DATE.
        MOVE W-YMD-TIME TO W-TIME.
*
        IF PAT-BIRTH-DT NOT = 0 THEN
                INITIALIZE L-DT L-AGE L-AGE-2 L-AGE-UNIT L-ID
                MOVE W-DATE     TO L-DT
                MOVE "Y"        TO L-ID
                CALL "HRAGECF" USING L-DT L-AGE L-AGE-2 L-AGE-UNIT L-ID
                END-CALL
                MOVE L-AGE-2    TO W-AGE
                IF L-AGE-UNIT = "A" THEN
                        MOVE "歲"       TO W-AGE-UNIT
                ELSE
                        IF L-AGE-UNIT = "M" THEN
                                MOVE "月"       TO W-AGE-UNIT
                        ELSE
                                MOVE "天"       TO W-AGE-UNIT
                        END-IF
                END-IF
        END-IF.
        MOVE PAT-NO             TO W-PAT-NO.
        IF IPD-OUT-DT NOT = 0 THEN
                STRING "非本次資料," IPD-OUT-DT "日出院" DELIMITED BY SIZE
                        INTO W-IPD-MARK

                MODIFY S-IPD-MARK, ENABLED = 1
                MODIFY S-IPD-MARK, TITLE = W-IPD-MARK
        ELSE
                MODIFY S-IPD-MARK, ENABLED = 0
                MOVE SPACE      TO W-IPD-MARK
                MODIFY S-IPD-MARK, TITLE = W-IPD-MARK
        END-IF.
        INITIALIZE NID-MST-REC.
        MOVE "0704"             TO NID-ID.
        MOVE IPD-UNIT           TO NID-CODE.
        READ NID-MST KEY IS NID-MST-KEY.
        IF NID-MST-STATUS = "00" THEN
                MOVE NID-NAME   TO W-IPD-UNIT-NAME
        ELSE
                INITIALIZE W-IPD-UNIT-NAME
        END-IF.
        MOVE IPD-BED-ROOM       TO W-BED(1:4).
        MOVE "-"                TO W-BED(5:1).
        MOVE IPD-BED-NO         TO W-BED(6:2).
        MOVE IPD-DT             TO W-IPD-DT.
        MOVE IPD-SEQ            TO W-IPD-SEQ1.
*>      若密碼進入者為醫師則看其醫師代碼,若非醫師則找主治醫師
        INITIALIZE NID-MST-REC.
        MOVE "0503"     TO NID-ID.
        IF W-RUN-PAR1(6:1) = "A" THEN
                MOVE W-RUN-PAR1(1:4)    TO NID-CODE
        ELSE
                MOVE IPD-MJ-DR          TO NID-CODE
        END-IF.
        READ NID-MST KEY IS NID-MST-KEY.
        IF NID-MST-STATUS = "00" THEN
                MOVE NID-MST-REC        TO W-NID-0503
        ELSE
                INITIALIZE W-NID-0503
        END-IF.
*
        MOVE IPD-DPT            TO HR-TMP-DPT.
        PERFORM F-SEARCH-DPT-RTN.
        MOVE HR-TMP-DPT-NAME    TO W-DPT-NAME.
        MOVE IPD-MJ-DR          TO HR-TMP-DR.
        PERFORM F-SEARCH-DR-RTN.
        MOVE HR-TMP-DR-NAME     TO W-IPD-MJ-DR.
        MOVE IPD-RD-DR          TO HR-TMP-DR.
        PERFORM F-SEARCH-DR-RTN.
        MOVE HR-TMP-DR-NAME     TO W-IPD-RD-DR.
        DISPLAY S-RCB1.
        CALL "W$MENU" USING WMENU-CHANGE,S-RCB1-Mn-1-Handle,W-DEL,0,"&2. 查詢已刪除藥品", W-DEL.
        CALL "W$MENU" USING WMENU-SHOW,S-RCB1-Mn-1-Handle.
        INITIALIZE W-TYPE1.
***********************************************************************
*> 計算次劑量及數量
***********************************************************************
 F-QTY-RTN.
        INITIALIZE W-LNK-DOSE-DATA.
        MOVE W-QTY1             TO W-LNK-DOSE-NUM.
        MOVE W-QTY2             TO W-LNK-DOSE-DEN.
        PERFORM F-CALL-HRDOSERF-RTN.

        MOVE W-LNK-DOSE-SUR     TO W-DIS-QTY.

 F-CALL-HRDOSERF-RTN.
        IF W-NID-0503(272:1) = 1 THEN
                MOVE "3"        TO W-LNK-DOSE-ID
        ELSE
                IF W-NID-0503(188:1) = "Y" THEN
                        MOVE "3"        TO W-LNK-DOSE-ID
                ELSE
                        MOVE "2"        TO W-LNK-DOSE-ID
                END-IF
        END-IF.
        CALL "HRDOSERF" USING W-LNK-DOSE-DATA ON EXCEPTION CONTINUE.

*>103.06.27 (書伶)修改實際退藥量欄位讀取來源，改讀RTA及RTB。
 F-ADD-RTB-QTY.
        INITIALIZE W-GCD-VAR W-TMP-QTY.
        IF W-RTB-QTY1 = 0 OR W-RTB-QTY2 = 0 THEN
                MOVE RTB-RX-QTY1        TO W-RTB-QTY1
                MOVE RTB-RX-QTY2        TO W-RTB-QTY2
        ELSE
*>              通分
                COMPUTE W-TMP-QTY1 = RTB-RX-QTY1 * W-RTB-QTY2 +
                                     RTB-RX-QTY2 * W-RTB-QTY1
                COMPUTE W-TMP-QTY2 = RTB-RX-QTY2 * W-RTB-QTY2
*>              約分
                MOVE W-TMP-QTY1         TO W-OUT-SON
                MOVE W-TMP-QTY2         TO W-OUT-MOTHER
                PERFORM F-DIVI-RTN
                MOVE W-OUT-MOTHER       TO W-RTB-QTY2
                MOVE W-OUT-SON          TO W-RTB-QTY1
        END-IF.

*> 數量整數化處理....
 F-DIVI-RTN.
        DIVIDE W-OUT-SON BY W-OUT-MOTHER GIVING W-GG REMAINDER W-RR.
        IF W-RR > 0 THEN
                MOVE 1 TO W-OUT-MOTHER
                COMPUTE W-OUT-SON = W-GG + 1
        ELSE
                MOVE 1          TO W-OUT-MOTHER
                MOVE W-GG       TO W-OUT-SON
        END-IF.
*>103.06.27 END
***********************************************************************
*> 查下頁
***********************************************************************
 F-SCREEN-DOWN.
        IF W-PAGE = 100 THEN
                PERFORM F-END-MESG
        ELSE
                IF NOT W-FS-EOF THEN
*>START                 (AICE) 106.11.09 增加顯示已刪除之檢驗項目
*>                      MOVE W-DIS-REC(W-MENU-ITEMS) TO ECB-MST-REC
                        IF W-RUN-CFNO-S = "1205" AND
                           W-TMP-PARA = "B" THEN
                                IF W-DIS-REC(W-MENU-ITEMS) = SPACE THEN

                                        INITIALIZE ECB-MST-REC
                                        MOVE IPD-NO             TO ECB-IPD-NO
                                        MOVE W-TMP-ECB-TYPE     TO ECB-TYPE
                                END-IF
                        ELSE
                                MOVE W-DIS-REC(W-MENU-ITEMS) TO ECB-MST-REC
                        END-IF
*>END 106.11.09
                        PERFORM F-STARTG-RTN
                        PERFORM F-READN-RTN THRU F-READN-EXIT
*>START                 (AICE) 106.11.09 增加顯示已刪除之檢驗項目
                        IF W-RUN-CFNO-S = "1205" AND
                           W-TMP-PARA = "B" THEN
                                MOVE W-HRDTB-REC(W-MENU-ITEMS)  TO HRDTB-MST-REC
                                PERFORM F-START-HRDTB-RTN THRU F-START-HRDTB-EXIT
                        END-IF
*>END 106.11.09
                        IF W-FS = 00 THEN
                                ADD 1   TO W-PAGE
                                MOVE ECB-MST-REC        TO W-KEY1(W-PAGE)
*>START                         (AICE) 106.11.09 增加顯示已刪除之檢驗項目
*>                              PERFORM F-999-RTN
                                IF W-RUN-CFNO-S = "1205" AND
                                   W-TMP-PARA = "B" THEN
                                        MOVE HRDTB-MST-REC      TO W-KEY2(W-PAGE)
                                        PERFORM F-READ-TEST-RTN THRU F-READ-TEST-EXIT
                                ELSE
                                        PERFORM F-999-RTN
                                END-IF
*>END 106.11.09
*>                              ---(AICE) 98.05.15 電子病歷查印紀錄---
                                IF      L-PAM-LOG-YN     = "Y"       THEN
                                        PERFORM F-CATCH-SEL-RTN
                                END-IF
*>                              ----------------------------------------------
                        ELSE
                                PERFORM F-END-MESG
                        END-IF
                ELSE
                        PERFORM F-END-MESG
                END-IF
        END-IF.
***********************************************************************
*> 查上頁
***********************************************************************
 F-SCREEN-UP.
        IF W-PAGE > 1 THEN
                SUBTRACT 1 FROM W-PAGE
                MOVE W-KEY1(W-PAGE)     TO ECB-MST-REC
                PERFORM F-STARTS-RTN
                PERFORM F-READN-RTN THRU F-READN-EXIT
*>START         (AICE) 106.11.09 增加顯示已刪除之檢驗項目
                IF W-RUN-CFNO-S = "1205" AND
                   W-TMP-PARA = "B" THEN
                        MOVE W-KEY2(W-PAGE)     TO HRDTB-MST-REC
                        PERFORM F-START-HRDTB-RTN THRU F-START-HRDTB-EXIT
                END-IF

*>END 106.11.09
                IF W-FS = 00 THEN
*>                      算出正確的序號(翻頁時)
                        MODIFY S-RCB1-GD-1, X = 1, Y = 2
                        INQUIRE S-RCB1-GD-1, CELL-DATA IN W-NO
                        COMPUTE W-NO = W-NO - 15
*>START                 (AICE) 106.11.09 增加顯示已刪除之檢驗項目
*>                      PERFORM F-999-RTN
                        IF W-RUN-CFNO-S = "1205" AND
                           W-TMP-PARA = "B" THEN
                                PERFORM F-READ-TEST-RTN THRU F-READ-TEST-EXIT
                        ELSE
                                PERFORM F-999-RTN
                        END-IF
*>END 106.11.09
                END-IF
        ELSE
                INITIALIZE W-NOTE
                MOVE "本頁為可查詢資料第一頁！" TO W-NOTE
                PERFORM F-WAR-NOTE
        END-IF.
***********************************************************************
*> 查歷次
***********************************************************************
 F-SEARCH-IPLIF-RTN.
        INITIALIZE W-IPLIF-LNK.
        MOVE PAT-NO     TO W-LNK-PAT-NO.
        CALL "HRIPLIF" USING W-IPLIF-LNK.
        IF W-LNK-IPL-YN = "Y" THEN
                PERFORM F-SEARCH-RTN
        END-IF.
 F-SEARCH-RTN.
        EVALUATE W-TMP-PARA
                WHEN "A"
                        PERFORM F-CHK-ECB1-RTN
                        PERFORM F-SEARCH-1-RTN
                WHEN "B"
                        PERFORM F-CHK-ECB2-RTN
                        PERFORM F-SEARCH-2-RTN
                WHEN "C"
                        PERFORM F-CHK-ECB1-RTN
                        PERFORM F-SEARCH-3-RTN
        END-EVALUATE.
*> 藥品訊息
 F-SEARCH-1-RTN.
        IF W-FS = 10 THEN
                MOVE "N"        TO W-LNK-IPL-YN
                INITIALIZE W-NOTE
                IF W-TYPE1 = "D" THEN
                        MOVE "患者此次住院期間並無刪除整張處方！"       TO W-NOTE
                ELSE
                        MOVE "患者此次住院期間並無開立藥品！"           TO W-NOTE
                END-IF
                PERFORM F-ERR-NOTE
        ELSE
                PERFORM F-MOVE-INQ-TITLE
                PERFORM F-RCB-RTN

        END-IF.
*> 檢驗放射線訊息
 F-SEARCH-2-RTN.
        IF W-FS = 10 THEN
                MOVE "N"        TO W-LNK-IPL-YN
                INITIALIZE W-NOTE
                MOVE "患者此次住院期間並無開立檢驗放射線！"     TO W-NOTE
                PERFORM F-ERR-NOTE
        ELSE
                PERFORM F-MOVE-INQ-TITLE
                MOVE 1           TO W-PAGE W-NO
                MOVE ECB-MST-REC TO W-PICB W-KEY1(W-PAGE)
                PERFORM F-999-RTN
        END-IF.
*> 治療處置訊息
 F-SEARCH-3-RTN.
        IF W-FS = 10 THEN
                MOVE "N"        TO W-LNK-IPL-YN
                INITIALIZE W-NOTE
                IF W-TYPE1 = "D" THEN
                        MOVE "患者此次住院期間並無刪除整張處方！"       TO W-NOTE
                ELSE
                        MOVE "患者此次住院期間並無確認治療處置！"       TO W-NOTE
                END-IF
                PERFORM F-ERR-NOTE
        ELSE
                PERFORM F-MOVE-INQ-TITLE
                PERFORM F-RCB-RTN
        END-IF.
***********************************************************************
*> 查刪藥
***********************************************************************
 F-DEL-RTN.
        IF W-TYPE1 = "D" THEN
                INITIALIZE W-TYPE1
                CALL "W$MENU" USING WMENU-CHANGE,S-RCB1-Mn-1-Handle,W-DEL,0,"&2. 查詢已刪除藥品", W-DEL
        ELSE
                MOVE "D"        TO W-TYPE1
                CALL "W$MENU" USING WMENU-CHANGE,S-RCB1-Mn-1-Handle,W-DEL,0,"&2. 還原刪藥查詢", W-DEL
        END-IF.
        CALL "W$MENU" USING WMENU-SHOW,S-RCB1-Mn-1-Handle.
        PERFORM F-RCB-RTN.
***********************************************************************
*> 最末頁訊息
***********************************************************************
 F-END-MESG.
        INITIALIZE W-NOTE.
        MOVE "本頁為資料可查詢最末頁！" TO W-NOTE.
        PERFORM F-WAR-NOTE.
***********************************************************************
*> 檢驗放射線(重印)
***********************************************************************
 F-F5-PRINT-RTN.
        IF W-DIS-DATA(W-GRID-Y)(65:6) = SPACE THEN
                INITIALIZE W-NOTE
                MOVE "此項非檢驗連線項目，無法列印檢驗單！"     TO W-NOTE
                PERFORM F-ERR-NOTE

        ELSE
                PERFORM F-PRINT-RTN
        END-IF.
*> 列印檢驗檢查單(交科室)
 F-PRINT-RTN.
        INITIALIZE W-REPRN-SW W-ODRPF-REPRN-SW-LNK.
        INITIALIZE HTCHK-REC.
*>      單號
        MOVE W-DIS-CHK-NO(W-GRID-Y)             TO HTCHK-CHK-NO.
        MOVE W-HTCHK-IP-DATE(W-GRID-Y)  TO HTCHK-IP-DATE.
        READ HTCHK-MST KEY IS HTCHK-KEY.
        IF HTCHK-MST-STATUS = "00" AND HTCHK-CHK-NO = W-DIS-CHK-NO(W-GRID-Y)
           AND HTCHK-IP-DATE = W-HTCHK-IP-DATE(W-GRID-Y) THEN
                INITIALIZE W-ODRPF-PASS-LNK W-ODRPF-PASS2-LNK
                MOVE HTCHK-CHK-NO       TO W-ODRPF-CHK-NO-LNK
                MOVE HTCHK-IP-DATE      TO W-ODRPF-IP-DATE-LNK
*>              0901108增加列印檢驗檢查單時檢查是否印表成功HT_OLGP.WRK
                INITIALIZE W-ODR-LGP W-ODR-PRN
                MOVE "Y"        TO W-ODR-LGP
                CALL "HTODRPF" USING W-ODRPF-PASS-LNK W-ODRPF-PASS2-LNK
                        W-ODRPF-PASS3-LNK ON EXCEPTION CONTINUE
                END-CALL
                INITIALIZE W-ODR-LGP W-ODR-PRN
        END-IF.
***********************************************************************
*> 檢驗放射線(看報告)
***********************************************************************
 F-REPORT-RTN.
*       IF W-INQ-RX-WAY = "已完成" THEN
*>              910718 修改看報告前先搬
*               MOVE "940"      TO W-EXT-HEIGHT
*                PERFORM F-CALL-HTPATRPF
*                INITIALIZE W-EXT-HEIGHT
*        ELSE
*               INITIALIZE W-NOTE
*               MOVE "此項處置無報告可供查詢！" TO W-NOTE
*               PERFORM F-ERR-NOTE
*       END-IF.
        IF W-INQ-RX-WAY = SPACES THEN
                INITIALIZE W-NOTE
                MOVE "此項處置無報告可供查詢！" TO W-NOTE
                PERFORM F-ERR-NOTE
        ELSE
*>              910718 修改看報告前先搬
                MOVE "940"      TO W-EXT-HEIGHT
                PERFORM F-CALL-HTPATRPF
                INITIALIZE W-EXT-HEIGHT
        END-IF.

*> 呼叫檢驗查看檢驗報告
 F-CALL-HTPATRPF.
*>      檢驗報告查詢使用 (志彥)
        MOVE 'Y' TO W-HT-GUI-SW.
*
        INITIALIZE W-HTRPTICF-IP-DATE W-HTRPTICF-RPT-OK W-HTRPTICF-RPT-MESSAGE.
        MOVE W-HTCHK-IP-DATE(W-GRID-Y)  TO W-HTRPTICF-IP-DATE.


*        DISPLAY WINDOW LINE 1 COL 1 LINES 25 SIZE 80
*                WITH NO WRAP NO SCROLL POP-UP AREA IS W-WINDOW4.
        CALL "HTRPTICF" USING W-RUN-CHK "HR" "V" W-DIS-CHK-NO(W-GRID-Y)
                W-HTRPTICF-IP-DATE W-HTRPTICF-RPT-OK W-HTRPTICF-RPT-MESSAGE
                ON EXCEPTION CONTINUE.
        CANCEL "HTRPTICF".
*>      檢驗報告查詢使用 (志彥)
        INITIALIZE W-HT-GUI-SW.
*
*       CLOSE WINDOW W-WINDOW4.
*        ADD AUTO-MOUSE-HANDLING, ALLOW-LEFT-DOWN,
*           ALLOW-RIGHT-DOWN, ALLOW-ALL-SCREEN-ACTIONS,
*            ALLOW-LEFT-DOUBLE,
*            GIVING W-MOUSE-FLAGS.
*        SET ENVIRONMENT "mouse-flags" TO W-MOUSE-FLAGS.
*        SET ENVIRONMENT "CURSOR-MODE" TO W-CURSOR-OFF.
*
        IF W-HTRPTICF-RPT-OK = "N" THEN
                INITIALIZE W-NOTE
                MOVE W-HTRPTICF-RPT-MESSAGE     TO W-NOTE
                PERFORM F-ERR-NOTE
        END-IF.
************************************************************************
*> 檢驗放射線(相關資料)
***********************************************************************
 F-HT-DATA-RTN.
        INITIALIZE W-HT-DATA.
        MOVE W-DIS-ITM-NM(W-GRID-Y)     TO W-HT-DATA-TITLE W-ITM-NM.
        INITIALIZE NID-MST-REC.
        MOVE "5100"                     TO NID-ID.
        MOVE W-DIS-AC-MAN(W-GRID-Y)     TO NID-CODE.
        READ NID-MST KEY IS NID-MST-KEY.
        IF NID-MST-STATUS = "00" AND NID-ID = "5100" AND
           NID-CODE = W-DIS-AC-MAN(W-GRID-Y) THEN
                MOVE NID-NAME   TO W-AC-NAME
        ELSE
                MOVE SPACE      TO W-AC-NAME
        END-IF.
        MOVE W-DIS-AC-DATE(W-GRID-Y)    TO W-AC-DATE.
        MOVE W-DIS-AC-HH(W-GRID-Y)      TO W-AC-TIME(1:2).
        MOVE ":"                        TO W-AC-TIME(3:1).
        MOVE W-DIS-AC-MM(W-GRID-Y)      TO W-AC-TIME(4:2).
        MOVE ":"                        TO W-AC-TIME(6:1).
        MOVE W-DIS-AC-SS(W-GRID-Y)      TO W-AC-TIME(7:2).
        MOVE W-DIS-SPL-NM(W-GRID-Y)     TO W-SPL-NM.
        MOVE W-DIS-BTL-NM(W-GRID-Y)     TO W-BTL-NM.
        MOVE W-DIS-RP-F-NAME            TO W-RP-F-NAME.
        MOVE W-DIS-RP-L-NAME            TO W-RP-L-NAME.
        MOVE W-DIS-RP-DATE(W-GRID-Y)    TO W-RP-DATE.
        MOVE W-DIS-RP-HH(W-GRID-Y)      TO W-RP-TIME(1:2).
        MOVE ":"                        TO W-RP-TIME(3:1).
        MOVE W-DIS-RP-MM(W-GRID-Y)      TO W-RP-TIME(4:2).
        MOVE ":"                        TO W-RP-TIME(6:1).
        MOVE W-DIS-RP-SS(W-GRID-Y)      TO W-RP-TIME(7:2).
        DISPLAY S-HT-DATA-FR S-HT-DATA.
***********************************************************************
*> 檢驗放射線(刪除)

***********************************************************************
 F-DELETE-RTN.
*>      0910221 修改不可執行刪除功能W-NID-1198(255:1) = "Y"
        IF W-NID-1198(255:1) = "Y" THEN
                INITIALIZE W-NOTE
                MOVE "對不起！您無權使用此功能！請持退單由住院中心刪除！"       TO W-NOTE
                PERFORM F-ERR-NOTE
        ELSE
                IF W-IPD-MARK = SPACE THEN
                        IF W-RUN-GNO1 = "11" AND W-RUN-PAR1(6:1) = "A" THEN
                                PERFORM F-HT-DELETE-RTN THRU F-HT-DELETE-EXIT
                                PERFORM F-CHK-ECB2-RTN
*>START                         (AICE) 106.11.09 增加顯示已刪除之檢驗項目
                                IF W-RUN-CFNO-S = "1205" THEN
                                        INITIALIZE HRDTB-MST-REC
                                        MOVE IPD-NO     TO HRDTB-IPD-NO
                                        PERFORM F-START-HRDTB-RTN THRU F-START-HRDTB-EXIT
                                END-IF
*>END 106.11.09
                                IF W-FS = 10 THEN
                                        INITIALIZE W-DIS-TABLE
                                        MOVE "N"        TO W-LNK-IPL-YN
*97.12.25(MONIYA)基隆李宏珠說看到很礙眼
*                                       INITIALIZE W-NOTE
*                                       MOVE "患者此次住院期間並無開立檢驗放射線！"     TO W-NOTE
*                                       PERFORM F-ERR-NOTE
*97.09.02(MONIYA)測試修改基隆刪除更新畫面資料
                                        PERFORM F-FUN-RTN THRU F-FUN-EXIT
                                ELSE
*>START                                 (AICE) 106.11.09 增加顯示已刪除之檢驗項目
*>                                      PERFORM F-PICB-RTN
                                        IF W-RUN-CFNO-S = "1205" THEN
                                                MOVE 1          TO W-PAGE W-NO
                                                MOVE ECB-MST-REC        TO W-PICB W-KEY1(W-PAGE)
                                                MOVE HRDTB-MST-REC      TO W-KEY2(W-PAGE)
                                                PERFORM F-READ-TEST-RTN THRU F-READ-TEST-EXIT
                                        ELSE
                                                PERFORM F-PICB-RTN
                                        END-IF
*>END 106.11.09
                                END-IF
                        ELSE
                                INITIALIZE W-NOTE
                                MOVE "對不起！刪除功能僅限醫師使用！"   TO W-NOTE
                                PERFORM F-ERR-NOTE
                        END-IF
                END-IF
        END-IF.
*> 刪除檢驗作業
 F-HT-DELETE-RTN.

*>      901030加判斷整帳鎖檔
        MOVE W-DIS-REC(W-GRID-Y)(12:7)  TO W-CHK-DTE-YMD WITH CONVERT.
        PERFORM F-CHK-LOCK-RTN THRU F-CHK-LOCK-EXIT.
        IF W-LOCKCF-YN = "Y" THEN
                INITIALIZE W-NOTE
                MOVE W-LOCKCF-NOTE TO W-NOTE

                PERFORM F-ERR-NOTE
                GO TO F-HT-DELETE-EXIT
        END-IF.
*>      先看看可不可以刪除.....
        IF W-DIS-OPD-APY(W-GRID-Y) = "Y" THEN
                STRING "此項處置已轉由門診申報，無法刪除！！"
                        DELIMITED BY SIZE INTO W-NOTE
                END-STRING
                PERFORM F-ERR-NOTE
                GO TO F-HT-DELETE-EXIT
        END-IF.
*>      檢驗單號
        IF W-DIS-CHK-NO(W-GRID-Y) NOT = SPACE AND
           W-DIS-CHK-NO(W-GRID-Y) NOT = "   00000" THEN
*>      0930826 志彥說.這個不要審
*>         AND W-DIS-ITM-CD(W-GRID-Y) NOT = SPACE THEN
                INITIALIZE W-ODRW-TABLE
*>              住院序號
                MOVE W-DIS-REC(W-GRID-Y)(1:11)          TO W-ODRW-PD-NO
*>              處方序號
                MOVE W-DIS-REC(W-GRID-Y)(12:11)         TO W-ODRW-PD-SEQ
*>              處置序號
                MOVE W-DIS-REC(W-GRID-Y)(23:3)          TO W-ODRW-PRS-SEQ WITH CONVERT
*>              檢驗單號
                MOVE W-DIS-CHK-NO(W-GRID-Y)             TO W-ODRW-CHK-NO
*>              項目代碼
                MOVE W-DIS-ITM-CD(W-GRID-Y)             TO W-ODRW-ITM-CD
*>
                CALL "HTODRWCF" USING W-ODRW-TABLE ON EXCEPTION CONTINUE
                END-CALL

*>              表示不可刪
                IF W-ODRW-TRN-SW NOT = "Y"
                        INITIALIZE W-NOTE
*>                      作業流程名稱
                        STRING "此項處置已至" W-ODRW-WK-NAME "階段，無法刪除"
                                DELIMITED BY SIZE INTO W-NOTE
                        END-STRING
                        PERFORM F-ERR-NOTE
                        GO TO F-HT-DELETE-EXIT
                ELSE
                        PERFORM F-HT-DELETE-RTN2
                END-IF
        ELSE
                IF W-DIS-REC(W-GRID-Y) NOT = SPACE THEN
                        PERFORM F-HT-DELETE-RTN2
                END-IF
        END-IF.
 F-HT-DELETE-EXIT.
        EXIT.
 F-HT-DELETE-RTN2.
        INITIALIZE W-HRMESCF-DATA W-HRMESCF-DATA2.
        MOVE "2"                TO W-HRMESCF-PIC-TYPE.
        MOVE "4"                TO W-HRMESCF-BUT-TYPE.
        MOVE "Y"                TO W-HRMESCF-CONTROL-ID.
        MOVE "是否確定要刪除??" TO W-HRMESCF-NOTE(1).
        CALL "HRMESCF" USING W-HRMESCF-DATA W-HRMESCF-DATA2 ON EXCEPTION CONTINUE

        END-CALL.
        IF W-HRMESCF-RETURN = "Y" THEN
*97.10.15(MONIYA)新增檢核先判斷資料是否能刪除再繼續往下執行
                INITIALIZE W-DELETE-YN
                PERFORM F-CHK-DEL-RTN THRU F-CHK-DEL-EXIT
                IF W-DELETE-YN = "Y" THEN
*>              確定要刪除時若為連線項則要先CALL "HTICB2BF"
                    IF (W-DIS-CHK-NO(W-GRID-Y) NOT = SPACE AND "   00000") THEN
*>              0930826 志彥說.這個不要審
*>                 AND W-DIS-ITM-CD(W-GRID-Y) NOT = SPACE THEN
*>START                 (彙婷) 106.06.07 桃醫-檢驗放射線查詢作業刪除檢驗單時，需重印重驗單-加傳 W-HTICB2BF-LNK2、加傳檢驗單號
*>                              W-HTICB2BF-LNK -> L-HTICB2BF-LNK
                        INITIALIZE L-HTICB2BF-LNK  L-HTICB2BF-LNK2
                        MOVE "1"                        TO L-HTICB2BF-STATUS
                        MOVE W-DIS-REC(W-GRID-Y)(1:22)  TO L-HTICB2BF-IP-NO
                        MOVE W-RUN-USER                 TO L-HTICB2BF-CR-MAN
                        MOVE W-DATE                     TO L-HTICB2BF-CR-DATE
*>START                 (AICE) 99.07.19 DM1001-J1002025 MEMORY ACCESS 加WITH CONVERT
                        MOVE W-TIME                     TO L-HTICB2BF-CR-TIME WITH CONVERT

                        MOVE W-DIS-REC(W-GRID-Y)        TO ECB-MST-REC
                        MOVE ECB-APY-DR                 TO L-HTICB2BF-IP-MAN
*>START 106.07.06       (彙婷) 禮中反應刪除時，要加傳處方日
                        MOVE W-DIS-REC(W-GRID-Y)(12:7)  TO L-HTICB2BF-IP-DATE WITH CONVERT
*>END 106.07.06
                        IF W-RUN-CFNO-S = "1205" THEN
                                MOVE W-DIS-CHK-NO(W-GRID-Y)     TO L-HTICB2BF-CHK-NO
                                CALL "HTICB2BF" USING L-HTICB2BF-LNK , L-HTICB2BF-LNK2 ON EXCEPTION CONTINUE
                                END-CALL
                        ELSE
                                CALL "HTICB2BF" USING L-HTICB2BF-LNK ON EXCEPTION CONTINUE
                                END-CALL
                        END-IF
                        IF L-HTICB2BF-STATUS = "E" THEN
*>END 106.06.07
                                INITIALIZE W-NOTE
                                STRING "檢驗檢查放射線系統處理失敗！請重新執行此功能！"
                                        DELIMITED BY SIZE INTO W-NOTE
                                END-STRING
                                PERFORM F-ERR-NOTE
                        ELSE
                                PERFORM F-HT-DELETE-RTN3
                        END-IF
                    ELSE
                        PERFORM F-HT-DELETE-RTN3
                    END-IF
                END-IF
        END-IF.

*97.10.15(MONIYA)新增檢核先判斷資料是否可刪除再繼續往下執行
 F-CHK-DEL-RTN.
        INITIALIZE IPD-MST-REC.
        MOVE W-DIS-REC(W-GRID-Y)(1:11)  TO IPD-NO.
        READ IPD-MST KEY IS IPD-MST-KEY.
        IF IPD-MST-STATUS = "00" THEN
*> IKEY-TMP 鎖檔作業
                INITIALIZE IKEY-TMP-REC

                MOVE "A"        TO IKEY-TMP-ID
                MOVE IPD-PAT-NO TO IKEY-ENA-PAT-NO
                READ IKEY-TMP KEY IS IKEY-TMP-KEY
                IF IKEY-TMP-STATUS = "00" THEN
                        DISPLAY MESSAGE "患者使用中，使用者[ " IKEY-USER " ]，作業 [ " IKEY-JOB " ]"
                        MOVE "N"        TO W-DELETE-YN
                        GO TO F-CHK-DEL-EXIT
                END-IF
                EVALUATE        TRUE
                        WHEN    IPD-MST-STATUS NOT = "00"
                                STRING  "["IPD-MST-STATUS"]住院序號檢查失敗，請檢查！"
                                        DELIMITED  BY   SIZE    INTO    W-NOTE
                                END-STRING
                                DISPLAY MESSAGE W-NOTE
                                MOVE "N"        TO W-DELETE-YN
                                GO TO F-CHK-DEL-EXIT
*>              身分代碼
                        WHEN    IPD-A-CLA = SPACE
                                MOVE    "身分代碼空白，請檢查！"        TO      W-NOTE
                                DISPLAY MESSAGE W-NOTE
                                MOVE "N"        TO W-DELETE-YN
                                GO TO F-CHK-DEL-EXIT
                        WHEN    IPD-OC-END-YN   = "Y"
                                MOVE    "病人已關帳！"  TO      W-NOTE
                                DISPLAY MESSAGE W-NOTE
                                MOVE "N"        TO W-DELETE-YN
                                GO TO F-CHK-DEL-EXIT
                END-EVALUATE

*>      3.身分計價識別
                INITIALIZE      NID-MST-REC
                MOVE    "0106"          TO      NID-ID
                MOVE    IPD-A-CLA       TO      NID-CODE
                READ    NID-MST   KEY   IS      NID-MST-KEY
                IF      NID-MST-STATUS = "00"
                        IF NID-MST-REC(93:1) NOT = "1" AND "2" AND "3" THEN
                                MOVE    "身分代碼計價識別錯誤，請檢查！"        TO      W-NOTE
                                DISPLAY MESSAGE W-NOTE
                                MOVE "N"        TO W-DELETE-YN
                                GO TO F-CHK-DEL-EXIT
                        END-IF
                END-IF
                MOVE "Y"        TO W-DELETE-YN
        END-IF.
 F-CHK-DEL-EXIT.
        EXIT.

 F-HT-DELETE-RTN3.
*>      刪除排程相關資料
        PERFORM F-DEL-SCH-RTN.
*>      更新IPD-AMV-YN = "Y"成功才可繼續
        INITIALIZE IPD-MST-REC.
        MOVE W-DIS-REC(W-GRID-Y)(1:11)  TO IPD-NO.
        READ IPD-MST KEY IS IPD-MST-KEY.
        IF IPD-MST-STATUS = "00" AND IPD-NO = W-DIS-REC(W-GRID-Y)(1:11) THEN
*               MOVE "Y"                TO IPD-AMV-YN
                REWRITE IPD-MST-REC

                IF IPD-MST-STATUS = "00" THEN
*>                      修改ICA
                        INITIALIZE ICA-MST-REC
                        MOVE W-DIS-REC(W-GRID-Y)(1:11)          TO ICA-IPD-NO
                        MOVE W-DIS-REC(W-GRID-Y)(12:11)         TO ICA-ODR-NO
                        READ ICA-MST KEY IS ICA-KEY
                        IF ICA-MST-STATUS = "00" AND
                           ICA-IPD-NO = W-DIS-REC(W-GRID-Y)(1:11) AND
                           ICA-ODR-NO = W-DIS-REC(W-GRID-Y)(12:11) THEN
*> 97.7.23(金額重結)
                                INITIALIZE W-ODRW-LNK W-ODRW-CNT
                                ADD   1                        TO W-ODRW-CNT
*>修改處方
                                MOVE "HR"                      TO W-ODRW-FROM
                                MOVE "M"                       TO W-ODRW-ID
                                MOVE ICA-ODR-NO                TO WM-ICA-ODR-NO
*>刪除處置
                                MOVE "D"                       TO WM-ICB-ID(W-ODRW-CNT)
                                MOVE W-RUN-USID(1:5)           TO W-ODRW-USER
                                MOVE W-DIS-REC(W-GRID-Y)(1:11) TO W-ODRW-IPD-NO
*                               MOVE "D" TO WM-ICB-ID(1)
*                               MOVE W-DIS-REC(W-GRID-Y)(23:3) TO WM-ICB-FEE-SEQ(1)
                                MOVE W-DIS-REC(W-GRID-Y)(23:3) TO WM-ICB-FEE-SEQ(W-ODRW-CNT)
*                               CALL "HIODRWCF" USING W-RUN-CHK W-ODRW-LNK ON EXCEPTION CONTINUE
*                               END-CALL
*>end

*>                              先將目前ICA及ICB之資料暫存於WRK中
*                               MOVE ICA-MST-REC        TO W-ICA-TMP-MST-REC
*>                              處方異動人代號  X(4) ==> X(5)
*                               MOVE W-RUN-USID         TO ICA-UPD-USR-ID
*>                              處方異動日期
*                                MOVE W-DATE             TO ICA-UPD-DATE
*>                              處方異動時間
*                                MOVE W-TIME             TO ICA-UPD-TIME
*                                REWRITE ICA-MST-REC
*>                              891121 INSERT : 電子病歷異動檔寫檔   <HI_ELC.PRC>
                                MOVE "M"        TO W-ELC-MARK
                                PERFORM F-WRITE-ELC-TRN-21
*                                IF ICA-MST-STATUS = "00" THEN
*>                                      異動前
*                                       MOVE "MD"       TO W-UPD-ID
*                                        PERFORM F-WRITE-GCA-OLD-RTN THRU F-WRITE-GCA-OLD-EXIT
*                                        PERFORM F-WRITE-GCB-MI-RTN
*>                                      0900620增加若此項目為連帶母項則要先刪除子項之後再將母項刪除
                                        INITIALIZE ECB-MST-REC
                                        MOVE W-DIS-REC(W-GRID-Y)(1:25)  TO ECB-KEY
                                        READ ECB-MST KEY IS ECB-KEY
                                        IF ECB-LNK-POINT-HEAD = "*" THEN
                                                MOVE ECB-LNK-POINT      TO W-TMP-LNK-POINT
                                                MOVE ECB-LNK-TIME       TO W-TMP-LNK-TIME
                                                PERFORM F-DEL-LNK-RTN
                                        END-IF
*>                                      2019/12/24 耀瑄NIS
*>                                      刪除時加寫HR_UDL3
                                        INITIALIZE ICB-MST-REC ECB-MST-REC
                                        MOVE W-DIS-REC(W-GRID-Y)(1:25)  TO ICB-KEY ECB-KEY

                                        READ ICB-MST KEY IS ICB-KEY
                                        READ ECB-MST KEY IS ECB-KEY
                                        PERFORM F-DEL-TO-WRITE-HRUDL3-RTN
*>                                      2019/12/24 END
*>                                      刪除ICB及ECB
                                        INITIALIZE ICB-MST-REC ECB-MST-REC
                                        MOVE W-DIS-REC(W-GRID-Y)(1:25)  TO ICB-KEY ECB-KEY
                                        READ ICB-MST KEY IS ICB-KEY
                                        READ ECB-MST KEY IS ECB-KEY
*>                                      處理ANN取消作業
                                        IF ECB-ANN-YN = "Y" THEN
                                                PERFORM F-DEL-ANN-MST
                                        END-IF
*>                                      930820 增加子宮頸抹片處置審核檔刪除 PEF-MST-REC(462:1) = "D"
                                        IF W-1799-REC(69:1) = "Y" THEN
                                                PERFORM F-DELETE-FNS-RTN
                                        END-IF
*>                                      0941206 增加寫入檢驗刪除處方檔
                                        PERFORM F-WRITE-HRDTB-RTN
*                                       DELETE ICB-MST
*                                        DELETE ECB-MST
*>                                      異動後
                                        PERFORM F-ADD-MT-RTN THRU F-ADD-MT-EXIT
*                                        MOVE "MI"       TO W-UPD-ID
*                                        MOVE ICA-MST-REC        TO W-ICA-TMP-MST-REC
*                                        PERFORM F-WRITE-GCA-OLD-RTN THRU F-WRITE-GCA-OLD-EXIT
*                                        PERFORM F-WRITE-GCB-MI-RTN
*>                                      檢查處方是否已無內容若無則於ICA-DEL-MARK上刪除註記
*                                       PERFORM F-REWRITE-ICA-RTN
*                               ELSE
*>                                      處方主檔異動失敗
*                                       INITIALIZE W-NOTE
*                                       STRING "處方主檔異動失敗，狀況："
*                                             ICA-MST-STATUS " 請重新執行此功能......"
*                                               DELIMITED BY SIZE INTO W-NOTE
*                                       END-STRING
*                                       PERFORM F-ERR-NOTE
*                               END-IF
                                CALL "HIODRWCF" USING W-RUN-CHK W-ODRW-LNK ON EXCEPTION CONTINUE
                                END-CALL
*97.09.17(MONIYA)顯示錯誤訊息
                                IF W-ODRW-OK = "N" THEN
                                        INITIALIZE W-NOTE
                                        MOVE W-ODRW-NOTE TO W-NOTE
                                        PERFORM F-ERR-NOTE
*>                                      2019/12/24 記錄ICA寫檔錯誤碼[7]
                                        INITIALIZE  W-LOG2-CON
                                        MOVE "W"        TO W-UPD-MRK
                                        MOVE "A"        TO W-TMP-ID
                                        PERFORM F-WRT-LOG2-RTN THRU F-WRT-LOG2-EXIT
                                END-IF
                        ELSE
*>                              處方主檔讀取失敗
*                               INITIALIZE W-NOTE
*                               STRING "處方主檔讀取失敗，狀況："
*                                       ICA-MST-STATUS " 請查詢此處方是否存在...."
*                                       DELIMITED BY SIZE INTO W-NOTE

*                               END-STRING
*                               PERFORM F-ERR-NOTE
*>                              2019/12/24 記錄ICA寫檔錯誤碼[7]
                                INITIALIZE  W-LOG2-CON
                                MOVE "R"        TO W-UPD-MRK
                                MOVE "A"        TO W-TMP-ID
                                PERFORM F-WRT-LOG2-RTN THRU F-WRT-LOG2-EXIT
*                       END-IF
*>                      0910501 依參數設定傳送取消處方箋
                ELSE
*>                      住院主檔更新失敗
                        INITIALIZE W-NOTE
                        STRING "住院主檔更新失敗，狀況：" IPD-MST-STATUS
                                " 請重新執行此功能......"
                                DELIMITED BY SIZE INTO W-NOTE
                        END-STRING
                        PERFORM F-ERR-NOTE
                END-IF
        ELSE
*>              住院主檔讀取失敗
                INITIALIZE W-NOTE
                STRING "住院主檔讀取失敗，狀況：" IPD-MST-STATUS
                        " 請查詢此住院資料是否存在...."
                        DELIMITED BY SIZE INTO W-NOTE
                END-STRING
                PERFORM F-ERR-NOTE
        END-IF.
 F-DEL-LNK-RTN.
        INITIALIZE ECB-MST-REC.
        MOVE W-DIS-REC(W-GRID-Y)(1:22)  TO ECB-KEY.
        START ECB-MST KEY IS NOT < ECB-KEY.
        READ ECB-MST NEXT RECORD.
        PERFORM F-DEL-LNK-RTN1 UNTIL ECB-MST-STATUS NOT = "00" OR
                ECB-KEY(1:22) NOT = W-DIS-REC(W-GRID-Y)(1:22).
 F-DEL-LNK-RTN1.
        IF ECB-LNK-POINT-HEAD NOT = "*" AND
           ECB-LNK-POINT = W-TMP-LNK-POINT AND
           ECB-LNK-TIME = W-TMP-LNK-TIME AND
           ECB-KEY(1:22) = W-DIS-REC(W-GRID-Y)(1:22) THEN
*>              找到要刪除的子項還要看是不是已簽收不可刪除
                INITIALIZE ICB-MST-REC
                MOVE ECB-KEY    TO ICB-KEY
                READ ICB-MST KEY IS ICB-KEY
                IF (ICB-DG-FLAG(1:1) = "C" OR "D" OR "E") AND
                   ICB-CLS-NO NOT = SPACE THEN
                        INITIALIZE W-ODRW-TABLE
*>                      住院序號
                        MOVE ICB-IPD-NO         TO W-ODRW-PD-NO
*>                      處方序號
                        MOVE ICB-ODR-NO         TO W-ODRW-PD-SEQ
*>                      處置序號
                        MOVE ICB-FEE-SEQ        TO W-ODRW-PRS-SEQ
*>                      檢驗單號
                        MOVE ICB-CHK-NO         TO W-ODRW-CHK-NO
*>                      項目代碼
                        MOVE ICB-ITM-CD         TO W-ODRW-ITM-CD
                        CALL "HTODRWCF" USING W-ODRW-TABLE ON EXCEPTION CONTINUE

                        END-CALL
*>                      表示可刪
                        IF W-ODRW-TRN-SW = "Y" THEN
                                ADD 1 TO W-ODRW-CNT
*>                              刪除處置
                                MOVE "D"          TO WM-ICB-ID(W-ODRW-CNT)
*>                              處置流水號
                                MOVE ICB-FEE-SEQ  TO WM-ICB-FEE-SEQ(W-ODRW-CNT)
*                               DELETE ICB-MST
*                               DELETE ECB-MST
                        END-IF
                ELSE
                        ADD 1 TO W-ODRW-CNT
*>                      刪除處置
                        MOVE "D"          TO WM-ICB-ID(W-ODRW-CNT)
*>                      處置流水號
                        MOVE ICB-FEE-SEQ  TO WM-ICB-FEE-SEQ(W-ODRW-CNT)
*                       DELETE ICB-MST
*                       DELETE ECB-MST
                END-IF
        END-IF.
        READ ECB-MST NEXT RECORD.
*> 刪除排程相關資料
 F-DEL-SCH-RTN.
*>      ICA
        INITIALIZE ICA-MST-REC.
        MOVE W-DIS-REC(W-GRID-Y)(1:11)        TO ICA-IPD-NO.
        MOVE W-DIS-REC(W-GRID-Y)(12:11)       TO ICA-ODR-NO.
        READ ICA-MST KEY IS ICA-KEY.
*>      ICB
        INITIALIZE ICB-MST-REC ECB-MST-REC.
        MOVE W-DIS-REC(W-GRID-Y)(1:25)        TO ICB-KEY ECB-KEY.
        READ ICB-MST KEY IS ICB-KEY.
        READ ECB-MST KEY IS ECB-KEY.
        INITIALIZE PEF-MST-REC.
        INITIALIZE LX-SCH-TABLE W-LX-SCH-COUNT.
        MOVE ICB-FEE-KEY        TO PEF-CODE.
        READ PEF-MST KEY IS PEF-MST-KEY.
        IF PEF-MST-STATUS = "00" AND PEF-CODE(1:9) = ICB-FEE-KEY THEN
                IF PEF-MST-REC(436:01) = "Y" THEN
                        ADD 1                   TO W-LX-SCH-COUNT
                        MOVE "D"                TO LX-SCH-CMD-ISW(W-LX-SCH-COUNT)
                        MOVE ICB-FEE-KEY        TO LX-SCH-PRS-NO(W-LX-SCH-COUNT)
                        MOVE ICB-PAS-DPT        TO LX-SCH-PRS-DPT(W-LX-SCH-COUNT)
                        MOVE ICB-PAS-TAB        TO LX-SCH-PRS-CLS(W-LX-SCH-COUNT)
                        MOVE ICB-PAS-ITM        TO LX-SCH-PRS-ITM(W-LX-SCH-COUNT)
                        MOVE ICB-FEE-SEQ        TO LX-SCH-PRS-SEQ(W-LX-SCH-COUNT)
                        MOVE ICB-FEE-SEQ        TO LX-SCH-CRE-SEQ(W-LX-SCH-COUNT)
                        INITIALIZE W-LNK-TABLE
                        MOVE "X1"               TO W-SYS-NO
                        MOVE W-RUN-USID         TO W-USE-NO
                        MOVE "X"                TO W-DPT-NO
                        MOVE "YYYYY"            TO W-PWD
                        MOVE IPD-PAT-NO         TO LX-SCH-PT-NO
                        MOVE PAT-IDNO           TO LX-SCH-PT-ID
                        MOVE PAT-NAME           TO LX-SCH-PT-NAME
                        MOVE PAT-BIRTH-DT       TO LX-SCH-PT-DATE

                        MOVE PAT-SEX            TO LX-SCH-PT-SEX
*>START                 (AICE) 101.08.31 DM1201-J1201492 MAV
                        MOVE IPD-NO             TO LX-SCH-PD-NO WITH CONVERT
*
                        MOVE IPD-BED            TO LX-SCH-PT-BED
                        MOVE ICA-ODR-NO         TO LX-SCH-OD-NO
*>                      儲存目前患者紀錄
                        PERFORM F-BEFORE-RTN
                        CALL "HXGSCHKF" USING W-LNK-TABLE LX-SCH-TABLE ON EXCEPTION CONTINUE
                        END-CALL
                        CANCEL "HXGSCHKF"
*>                      還原患者紀錄
                        PERFORM F-AFTER-RTN
                END-IF
        END-IF.
*> 儲存ICB之資料至GCB
 F-WRITE-GCB-MI-RTN.
        INITIALIZE ICB-MST-REC.
        MOVE ICA-IPD-NO TO ICB-IPD-NO.
        MOVE ICA-ODR-NO TO ICB-ODR-NO.
        START ICB-MST KEY IS NOT < ICB-KEY.
        READ ICB-MST NEXT RECORD.
        PERFORM F-WRITE-GCB-MI-RTN1 UNTIL ICB-MST-STATUS NOT = "00" OR
                ICB-IPD-NO NOT = ICA-IPD-NO OR ICB-ODR-NO NOT = ICA-ODR-NO.
 F-WRITE-GCB-MI-RTN1.
        INITIALIZE ECB-MST-REC.
        MOVE ICB-KEY    TO ECB-KEY.
        READ ECB-MST KEY IS ECB-KEY.
        MOVE ICB-MST-REC        TO W-MST-REC.
        MOVE ECB-MST-REC        TO W-ECB-REC.
        PERFORM F-WRITE-GCB-RTN THRU F-WRITE-GCB-EXIT.
        READ ICB-MST NEXT RECORD.
*> 檢查處方是否已無內容若無則於ICA-DEL-MARK上刪除註記
 F-REWRITE-ICA-RTN.
        INITIALIZE ICB-MST-REC.
        MOVE W-DIS-REC(W-GRID-Y)(1:11)        TO ICB-IPD-NO.
        MOVE W-DIS-REC(W-GRID-Y)(12:11)       TO ICB-ODR-NO.
        START ICB-MST KEY IS NOT < ICB-KEY.
        READ ICB-MST NEXT RECORD.
        IF ICB-MST-STATUS NOT = "00" OR ICB-IPD-NO NOT = W-DIS-REC(W-GRID-Y)(1:11) OR
           ICB-ODR-NO NOT = W-DIS-REC(W-GRID-Y)(12:11) THEN
                MOVE "D"        TO ICA-DEL-MARK
                REWRITE ICA-MST-REC
        END-IF.
*> 930820 增加子宮頸抹片處置審核檔刪除 PEF-MST-REC(462:1) = "D"
 F-DELETE-FNS-RTN.
        INITIALIZE W-GCK-CHK.
        IF ECB-SPEC-MARK = "D" THEN
                MOVE "Y"        TO W-GCK-CHK
        END-IF.
*>
        IF W-GCK-CHK = SPACE THEN
                INITIALIZE FNS-MST-REC
                MOVE "Q"                                TO FNS-ID
                MOVE W-DIS-REC(W-GRID-Y)(1:11)          TO FNS-PQ-IPD-NO
                MOVE W-DIS-REC(W-GRID-Y)(12:11)         TO FNS-PQ-ODR-NO
                READ FNS-MST KEY IS FNS-MST-KEY

                IF FNS-MST-STATUS = "00" THEN
                        DELETE FNS-MST
                        IF FNS-MST-STATUS NOT = "00" THEN
                                INITIALIZE W-NOTE
                                STRING "子宮頸抹片記錄檔刪除失敗，狀況：" FNS-MST-STATUS
                                        DELIMITED BY SIZE INTO W-NOTE
                                END-STRING
                                PERFORM F-ERR-NOTE
                        END-IF
                END-IF
        END-IF.
***********************************************************************
*> 增加寫入檢驗刪除處方檔
 F-WRITE-HRDTB-RTN.
        ADD 1   TO W-HRDTA-COUNT.
        IF W-HRDTA-COUNT = 1 THEN
                PERFORM F-WRITE-HRDTA-RTN
        END-IF.
*>
        INITIALIZE HRDTB-MST-REC.
        MOVE HRDTA-IPD-NO       TO HRDTB-IPD-NO.
        MOVE HRDTA-ODR-NO       TO HRDTB-ODR-NO.
        MOVE W-HRDTA-COUNT      TO HRDTB-FEE-SEQ.
        MOVE ICB-FEE-KEY        TO HRDTB-FEE-KEY.
        MOVE ICB-RX-QTY         TO HRDTB-RX-QTY.
        MOVE ICB-CHK-NO         TO HRDTB-CHK-NO.
        MOVE ICB-INS-DATE       TO HRDTB-IP-DATE.
        MOVE ICB-ODR-NO         TO HRDTB-ICA-ODR-NO.
        MOVE ICB-ITM-CD         TO HRDTB-ICB-ITM-CD.
        WRITE HRDTB-MST-REC.
*>
 F-WRITE-HRDTA-RTN.
*       COPY "ZD_DTI.PRC".
*
* ZD_DTI.PRC ... 同 ZD_YMD.PRC ...  取日期時間 ...
*
        MOVE W-RUN-YYSW  TO W-YMD-YYSW.
        MOVE W-RUN-YYDEF TO W-YMD-YYDEF.
        MOVE W-RUN-YYCOM TO W-YMD-YYCOM.
*
* 日期 ...
        ACCEPT W-YMD-DATE FROM CENTURY-DATE.
        MOVE W-YMD-YY TO W-YMD-YYB.
        MOVE W-YMD-YY TO W-YMD-YY1.
        MOVE W-YMD-MM TO W-YMD-MM1.
        MOVE W-YMD-DD TO W-YMD-DD1.
*
* YYSW   : 使用年曆設定     -- 4:使用四碼西元年 2:二碼西元年, 0:表使用當地國年
* YYDEF  : 年度換算初值     -- 西元年換算使用國年初值(例:1911, 0 視同1911)
* YYCOM  : 年度計算方式     -- 西元年計算使用國年方式(例:+,-, 空白視同 - )
* YDFSW  : 變數用...
*
        IF W-YMD-YYCOM NOT = "+" AND "-" THEN
                ACCEPT W-YMD-YYSW       FROM ENVIRONMENT "ZS_SYYW"
                END-ACCEPT
                ACCEPT W-YMD-YDFSW      FROM ENVIRONMENT "ZS_SYDF"
                END-ACCEPT

                ACCEPT W-YMD-YYCOM      FROM ENVIRONMENT "ZS_SYCM"
                END-ACCEPT
                IF W-YMD-YYSW NOT = "2" AND "4" THEN
                        MOVE "0" TO W-YMD-YYSW
                END-IF
                IF W-YMD-YYCOM NOT = "+" AND "-" THEN
                        MOVE "-" TO W-YMD-YYCOM
                END-IF
                MOVE W-YMD-YDFSW TO W-YMD-YYDEF WITH CONVERT
                IF ( W-YMD-YYDEF = 0 ) AND
                   ( W-YMD-YYSW  = "0" ) AND
                   ( W-YMD-YYCOM = "-" ) THEN
                        MOVE 1911 TO W-YMD-YYDEF
                END-IF
        END-IF.
*
* YYS : - 表轉換後年度為負值
*
        MOVE SPACE TO W-YMD-YYS.
        IF W-YMD-YYSW = "4" THEN
                CONTINUE
        ELSE
        IF W-YMD-YYSW = "2" THEN
                MOVE W-YMD-YY1 TO W-YMD-YY
        ELSE    IF W-YMD-YYCOM = "+" THEN
                        COMPUTE W-YMD-YY = W-YMD-YY + W-YMD-YYDEF
                ELSE    IF W-YMD-YY > W-YMD-YYDEF THEN
                                COMPUTE W-YMD-YY = W-YMD-YY - W-YMD-YYDEF
                        ELSE    COMPUTE W-YMD-YY = W-YMD-YY - W-YMD-YYDEF - 1
                                MOVE "-" TO W-YMD-YYS
                        END-IF
                END-IF
        END-IF.
*
* 時間 ...
        ACCEPT W-YMD-TIME8 FROM TIME.
        MOVE W-YMD-HHS TO W-YMD-HH.
        MOVE W-YMD-MTS TO W-YMD-MT.
        MOVE W-YMD-SSS TO W-YMD-SS.
*
        MOVE W-YMD-DATE TO W-DATE.
        MOVE W-YMD-TIME TO W-TIME.
*
        PERFORM F-READ-RNUJ-RTN THRU F-READ-RNUJ-EXIT.
*>
        INITIALIZE HRDTA-MST-REC.
        MOVE ICB-IPD-NO TO HRDTA-IPD-NO.
        MOVE W-DATE     TO HRDTA-INS-DATE.
        MOVE W-NUM      TO HRDTA-ODR-SEQ.
        IF W-RUN-PAR1(6:1) = "A" THEN
                MOVE W-RUN-PAR1(1:4)    TO HRDTA-DR-NO
        END-IF.
        MOVE W-RUN-USID TO HRDTA-USR-ID.
        MOVE W-DATE     TO HRDTA-CRE-DT.
        MOVE W-TIME     TO HRDTA-CRE-TIME.
        WRITE HRDTA-MST-REC.


 F-READ-RNUJ-RTN.
        INITIALIZE RNU-MST-REC.
        MOVE "J"        TO RNU-J-ID.
        MOVE W-DATE     TO RNU-J-DT.
        READ RNU-MST LOCK KEY IS RNU-MST-KEY.
        IF RNU-MST-STATUS = "00" THEN
                MOVE RNU-J-NO   TO W-NUM
        ELSE
                IF RNU-MST-STATUS = "23" THEN
                        MOVE 1  TO W-NUM RNU-J-NO
                ELSE
                        GO TO F-READ-RNUJ-RTN
                END-IF
        END-IF.
**
        ADD 1 TO RNU-J-NO.
        WRITE RNU-MST-REC.
        IF RNU-MST-STATUS NOT = "00" THEN
                REWRITE RNU-MST-REC
        END-IF.
**
        UNLOCK RNU-MST.
 F-READ-RNUJ-EXIT.
        EXIT.
***********************************************************************
 F-BEFORE-RTN.
        MOVE PAT-MST-REC        TO W-TMP-PAT-MST-REC.
        MOVE IPD-MST-REC        TO W-TMP-IPD-MST-REC.
        MOVE BED-MST-REC        TO W-TMP-BED-MST-REC.
 F-AFTER-RTN.
        INITIALIZE PAT-MST-REC.
        MOVE W-TMP-PAT-MST-REC  TO PAT-MST-REC.
        READ PAT-MST KEY IS PAT-MST-KEY.
*97.07.08(MONIYA)病歷互通加解密
        INITIALIZE W-PTDECF-LNK.
        MOVE 'O'                TO W-PTDECF-IO-SW.
        MOVE 'Y'                TO W-PTDECF-IO-HHPAT-YN.
        MOVE PAT-NO             TO W-PTDECF-PAT-NO.
        MOVE 'HRRCB1IF'         TO W-PTDECF-PROG-ID.
        MOVE 'F-AFTER-RTN'      TO W-PTDECF-PROG-PARA.
*>      MOVE 'HT_PAT0.PRC'   TO W-PTDECF-C-PY-FILE.
        MOVE W-TOP-TITLE TO W-PTDECF-PROG-NM.
*>      MOVE 'W1'        TO W-PTDECF-FUN-SEL.
        MOVE W-RUN-USID         TO W-PTDECF-UPD-UID.
        MOVE PAT-MST-REC        TO W-PTDECF-PAT-MST-REC.
        CALL "HHPTDECF" USING W-PTDECF-LNK
                ON EXCEPTION  CONTINUE
        END-CALL.
        EVALUATE W-PTDECF-IO-YN
                WHEN 'Y'
                        MOVE W-PTDECF-PAT-MST-REC TO PAT-MST-REC
                WHEN 'N'
                        DISPLAY MESSAGE "病歷號: " PAT-NO "病歷檔加解密失敗!!"
        END-EVALUATE.
        MOVE W-TMP-PAT-MST-REC  TO PAT-MST-REC.

        INITIALIZE IPD-MST-REC.

        MOVE W-TMP-IPD-MST-REC  TO IPD-MST-REC.
        READ IPD-MST KEY IS IPD-MST-KEY.
        MOVE W-TMP-IPD-MST-REC  TO IPD-MST-REC.

        INITIALIZE BED-MST-REC.
        MOVE W-TMP-BED-MST-REC  TO BED-MST-REC.
        READ BED-MST KEY IS BED-MST-KEY.
        MOVE W-TMP-BED-MST-REC  TO BED-MST-REC.
***********************************************************************
*> 報備檔刪檔 -- 更新刪除日期等欄位
***********************************************************************
 F-DEL-ANN-MST.
        PERFORM F-READ-ANN-MST.
        IF HXANN-MST-STATUS NOT = "00"
                EXIT    PARAGRAPH
        END-IF.
*>      刪除
        MOVE    "E"                     TO      HXANN-TRN-SW.
*>      刪除日期
        MOVE    ICA-UPD-DATE            TO      HXANN-DEL-DATE.
*>      刪除時間
        MOVE    ICA-UPD-TIME            TO      HXANN-DEL-TIME(01:04).
*>      刪除人員
        MOVE    ICA-UPD-USR-ID          TO      HXANN-DEL-MAN.
*>      刪除識別碼  A->批價刪除
        MOVE    "A"                     TO      HXANN-DEL-SW.
        REWRITE         HXANN-REC.
*> 讀取報備檔
 F-READ-ANN-MST.
        INITIALIZE                      HXANN-REC.
*>      處方序號
        MOVE    ICA-ODR-NO              TO      HXANN-OD-NO.
*>      住院序號
        MOVE    ICA-IPD-NO              TO      HXANN-PD-NO.
*>      檔案序號
        MOVE    ECB-FILE-NO             TO      HXANN-IP-SEQ.
        READ    HXANN-MST       KEY IS  HXANN-KEY.
***********************************************************************
*> 開檔
***********************************************************************
 F-OPEN-RTN.
        PERFORM F-OPEN-MESG.
        PERFORM F-WIN-CLOCK.

        INITIALIZE W-LA-NAME.
        MOVE "NID-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT NID-MST.

        INITIALIZE W-LA-NAME.
        MOVE "PAT-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT PAT-MST.

        INITIALIZE W-LA-NAME.
        MOVE "IPD-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        OPEN    I-O IPD-MST.
        IF      IPD-MST-STATUS = "35" THEN
                OPEN    OUTPUT IPD-MST

                CLOSE   IPD-MST
                OPEN    I-O IPD-MST
        END-IF.
        INITIALIZE IPD-MST-REC.

        INITIALIZE W-LA-NAME.
        MOVE "IPX-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT IPX-MST.

        INITIALIZE W-LA-NAME.
        MOVE "ICA-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        PERFORM F-OICA-RTN THRU F-OICA-EXIT.

        INITIALIZE W-LA-NAME.
        MOVE "ICB-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        PERFORM F-OICB-RTN THRU F-OICB-EXIT.

        INITIALIZE W-LA-NAME.
        MOVE "HIGCA-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN    I-O HIGCA-MST.
        IF      HIGCA-MST-STATUS = "35" THEN
                OPEN    OUTPUT HIGCA-MST
                CLOSE   HIGCA-MST
                OPEN    I-O HIGCA-MST
        END-IF.

        INITIALIZE W-LA-NAME.
        MOVE "HIGCB-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN    I-O HIGCB-MST.
        IF      HIGCB-MST-STATUS = "35" THEN
                OPEN    OUTPUT HIGCB-MST
                CLOSE   HIGCB-MST
                OPEN    I-O HIGCB-MST
        END-IF.

        INITIALIZE W-LA-NAME.
        MOVE "FON-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT FON-MST.

        INITIALIZE W-LA-NAME.
        MOVE "BED-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT BED-MST.

        INITIALIZE W-LA-NAME.
        MOVE "DTE-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT DTE-MST.

        INITIALIZE W-LA-NAME.
        MOVE "PRS-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT PRS-MST.

        INITIALIZE W-LA-NAME.
        MOVE "PEF-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT PEF-MST.

        INITIALIZE W-LA-NAME.
        MOVE "ECB-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.

        OPEN    I-O ECB-MST.
        IF      ECB-MST-STATUS = "35" THEN
                OPEN    OUTPUT ECB-MST
                CLOSE   ECB-MST
                OPEN    I-O ECB-MST
        END-IF.
        INITIALIZE ECB-MST-REC.

        INITIALIZE W-LA-NAME.
        MOVE "ELC-TRN 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        OPEN    I-O ELC-TRN.
        IF      ELC-TRN-STATUS = "35" THEN
                OPEN    OUTPUT ELC-TRN
                CLOSE   ELC-TRN
                OPEN    I-O ELC-TRN
        END-IF.
        INITIALIZE ELC-TRN-REC.

        INITIALIZE W-LA-NAME.
        MOVE "IBG-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        OPEN    I-O IBG-MST.
        IF      IBG-MST-STATUS = "35" THEN
                OPEN    OUTPUT IBG-MST
                CLOSE   IBG-MST
                OPEN    I-O IBG-MST
        END-IF.
        INITIALIZE IBG-MST-REC.

        INITIALIZE W-LA-NAME.
        MOVE "RNU-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        OPEN    I-O RNU-MST.
        IF      RNU-MST-STATUS = "35" THEN
                OPEN    OUTPUT RNU-MST
                CLOSE   RNU-MST
                OPEN    I-O RNU-MST
        END-IF.
        INITIALIZE RNU-MST-REC.

        INITIALIZE W-LA-NAME.
        MOVE "FNS-MST 開 檔 中.....請 稍 候....."       TO W-LA-NAME.
        OPEN    I-O FNS-MST.
        IF      FNS-MST-STATUS = "35" THEN
                OPEN    OUTPUT FNS-MST
                CLOSE   FNS-MST
                OPEN    I-O FNS-MST
        END-IF.
        INITIALIZE FNS-MST-REC.

        INITIALIZE W-LA-NAME.
        MOVE "HRDTA-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        OPEN    I-O HRDTA-MST.
        IF      HRDTA-MST-STATUS = "35" THEN
                OPEN    OUTPUT HRDTA-MST
                CLOSE   HRDTA-MST
                OPEN    I-O HRDTA-MST
        END-IF.
        INITIALIZE HRDTA-MST-REC.


        INITIALIZE W-LA-NAME.
        MOVE "HRDTB-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        OPEN    I-O HRDTB-MST.
        IF      HRDTB-MST-STATUS = "35" THEN
                OPEN    OUTPUT HRDTB-MST
                CLOSE   HRDTB-MST
                OPEN    I-O HRDTB-MST
        END-IF.
        INITIALIZE HRDTB-MST-REC.

        INITIALIZE W-LA-NAME.
        MOVE "HTSYS-SON 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTSYS-SON.

        INITIALIZE W-LA-NAME.
        MOVE "HTDPT-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTDPT-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTCHK-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTCHK-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTRPT-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTRPT-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTCLS-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTCLS-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTCTM-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTCTM-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTCTR-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTCTR-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTITM-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTITM-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTREF-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTREF-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTSPL-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT HTSPL-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTBTL-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT HTBTL-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTWRK-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.

        PERFORM F-CLOCK.                OPEN INPUT HTWRK-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTCSP-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTCSP-MST.
*>      排程相關檔案
        INITIALIZE W-LA-NAME.
        MOVE "HXSRM-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT HXSRM-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HXSCT-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT HXSCT-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HXSCD-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HXSCD-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HXSCC-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HXSCC-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HXSCM-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HXSCM-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HXSCH-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HXSCH-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HXANN-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HXANN-MST.
*> 97.7.23 金額重結
        INITIALIZE W-LA-NAME.
        MOVE "ENB-MST 開 檔 中.....請 稍 候....." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O ENB-MST.

        INITIALIZE W-LA-NAME.
        MOVE "IKEY-TMP 開 檔 中.....請 稍 候....." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O IKEY-TMP.

        INITIALIZE W-LA-NAME.
        MOVE "ICC-MST 開 檔 中.....請 稍 候....." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O ICC-MST.

        INITIALIZE W-LA-NAME.
        MOVE "ENA-MST 開 檔 中.....請 稍 候....." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O ENA-MST.

        INITIALIZE W-LA-NAME.
        MOVE "ENC-MST 開 檔 中.....請 稍 候....." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O ENC-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HIEND-MST 開 檔 中.....請 稍 候....." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HIEND-MST.


*>      103.06.27 (書伶)修改實際退藥量欄位讀取來源，改讀RTA及RTB。
        INITIALIZE W-LA-NAME.
        MOVE "RTA-MST 開 檔 中.....請 稍 候....." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O RTA-MST.

        INITIALIZE W-LA-NAME.
        MOVE "RTB-MST 開 檔 中.....請 稍 候....." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O RTB-MST.
*>      103.06.27 END
*>      2019/12/24 耀瑄NIS
*>      刪除時加寫HR_UDL3
        INITIALIZE W-LA-NAME.
        MOVE "HRUDL3-MST 開 檔 中.....請 稍 候....." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HRUDL3-MST.

        PERFORM F-CLOCK.
*------->下載醫生代碼表及科別代碼表...
        PERFORM F-DEP-RTN.
        PERFORM F-DR-RTN.
*------->下載住院參數設定
        PERFORM F-NID-1000.
        PERFORM F-NID-1099.
        MOVE W-NID-1099(111:1)  TO W-CHK-1029-YN.
        PERFORM F-NID-1198.
        PERFORM F-NID-1799.

        PERFORM F-CLOSE-WIN-CLOCK.
 F-OPEN-EXIT.
        EXIT.

*>檢驗開檔
 F-HT-OPEN.
        PERFORM F-OPEN-MESG.
        PERFORM F-WIN-CLOCK.

        INITIALIZE W-LA-NAME.
        MOVE "HMSID-MST 開 檔 中.....請 稍 候....."     TO W-LA-NAME.
        PERFORM F-CLOCK.        OPEN INPUT HMSID-MST.
        MOVE 'TV' TO HMSID-SYS-CODE.
        READ HMSID-MST INTO HMSID-REC KEY IS HMSID-KEY.
        IF W-FS-HMSID = "00" THEN
                MOVE HMSID-REC TO W-SID-REC
        END-IF.
        CLOSE HMSID-MST.

        IF W-SID-HT-LINK = 'Y'
                OPEN I-O HTV03-MST
                OPEN I-O HTV02-MST
                OPEN I-O HTV05-MST
                OPEN I-O HTVNO-MST
                OPEN I-O HTVVV-MST
                OPEN I-O HTVK1-MST
                OPEN I-O HTVK2-MST
                OPEN I-O HTVK3-MST
                OPEN I-O HTVK4-MST
*

                INITIALIZE HTVVV-REC W-VVV-REC
                MOVE 'TV' TO HTVVV-DPT-CD
                READ HTVVV-MST INTO HTVVV-REC KEY IS HTVVV-KEY
                IF W-FS-HTVVV = "00" THEN
                        MOVE HTVVV-REC     TO W-VVV-REC
                END-IF
        ELSE
                OPEN I-O HTVHK-MST
                OPEN I-O HTVHR-MST
                OPEN I-O HTVH1-MST
                OPEN I-O HTVPL-MST
                OPEN I-O HTANT-MST
                OPEN I-O HTATE-MST
                OPEN I-O HTATC-MST
                OPEN I-O HTVIR-MST
                OPEN I-O HTMIC-MST
                OPEN I-O HTDDM-MST
                OPEN I-O HTVRT-MST
                OPEN I-O HTVR1-MST
        END-IF.

        PERFORM F-CLOSE-WIN-CLOCK.
***********************************************************************
*>關檔
***********************************************************************
 F-CLOSE-RTN.
        PERFORM F-CLOSE-MESG.
        PERFORM F-WIN-CLOCK.

        PERFORM F-BIRD.         CLOSE NID-MST.
        PERFORM F-BIRD.         CLOSE PAT-MST.
        PERFORM F-BIRD.         CLOSE IPD-MST.
        PERFORM F-BIRD.         CLOSE IPX-MST.
        PERFORM F-BIRD.         CLOSE ICA-MST.
        PERFORM F-BIRD.         CLOSE ICB-MST.
        PERFORM F-BIRD.         CLOSE HIGCA-MST.
        PERFORM F-BIRD.         CLOSE HIGCB-MST.
        PERFORM F-BIRD.         CLOSE FON-MST.
        PERFORM F-BIRD.         CLOSE BED-MST.
        PERFORM F-BIRD.         CLOSE DTE-MST.
        PERFORM F-BIRD.         CLOSE PRS-MST.
        PERFORM F-BIRD.         CLOSE PEF-MST.
        PERFORM F-BIRD.         CLOSE ECB-MST.
        PERFORM F-BIRD.         CLOSE ELC-TRN.
        PERFORM F-BIRD.         CLOSE IBG-MST.
        PERFORM F-BIRD.         CLOSE RNU-MST.
        PERFORM F-BIRD.         CLOSE FNS-MST.
        PERFORM F-BIRD.         CLOSE HRDTA-MST.
        PERFORM F-BIRD.         CLOSE HRDTB-MST.
        PERFORM F-BIRD.         CLOSE HTSYS-SON.
        PERFORM F-BIRD.         CLOSE HTDPT-MST.
        PERFORM F-BIRD.         CLOSE HTCHK-MST.
        PERFORM F-BIRD.         CLOSE HTRPT-MST.
        PERFORM F-BIRD.         CLOSE HTCLS-MST.
        PERFORM F-BIRD.         CLOSE HTCTM-MST.
        PERFORM F-BIRD.         CLOSE HTCTR-MST.
        PERFORM F-BIRD.         CLOSE HTITM-MST.

        PERFORM F-BIRD.         CLOSE HTREF-MST.
        PERFORM F-BIRD.         CLOSE HTSPL-MST.
        PERFORM F-BIRD.         CLOSE HTBTL-MST.
        PERFORM F-BIRD.         CLOSE HTWRK-MST.
        PERFORM F-BIRD.         CLOSE HTCSP-MST.
*>      排檢相關
        PERFORM F-BIRD.         CLOSE HXSRM-MST.
        PERFORM F-BIRD.         CLOSE HXSCT-MST.
        PERFORM F-BIRD.         CLOSE HXSCD-MST.
        PERFORM F-BIRD.         CLOSE HXSCC-MST.
        PERFORM F-BIRD.         CLOSE HXSCM-MST.
        PERFORM F-BIRD.         CLOSE HXSCH-MST.
        PERFORM F-BIRD.         CLOSE HXANN-MST.
*> 97.7.23 金額重結
        PERFORM F-BIRD.         CLOSE ENB-MST.
        PERFORM F-BIRD.         CLOSE IKEY-TMP.
        PERFORM F-BIRD.         CLOSE ICC-MST.
        PERFORM F-BIRD.         CLOSE ENA-MST.
        PERFORM F-BIRD.         CLOSE ENC-MST.
        PERFORM F-BIRD.         CLOSE HIEND-MST.
*>      103.06.27 (書伶) 修改實際退藥量欄位讀取來源，改讀RTA及RTB。
        PERFORM F-BIRD.         CLOSE RTA-MST.
        PERFORM F-BIRD.         CLOSE RTB-MST.
*>      103.06.27 END
*>      2019/12/24 耀瑄NIS
*>      刪除時加寫HR_UDL3
        PERFORM F-BIRD.         CLOSE HRUDL3-MST.
        PERFORM F-CLOSE-WIN-CLOCK.
 F-CLOSE-EXIT.
        EXIT.
*>
*>檢驗關檔
 F-HT-CLOSE.
        PERFORM F-CLOSE-MESG.
        PERFORM F-WIN-CLOCK.

        IF W-SID-HT-LINK = 'Y'
                PERFORM F-HT-CLOSE1
        ELSE
                PERFORM F-HT-CLOSE2
        END-IF.

        PERFORM F-CLOSE-WIN-CLOCK.
*>
 F-HT-CLOSE1.
        PERFORM F-BIRD.         CLOSE HTV03-MST.
        PERFORM F-BIRD.         CLOSE HTV02-MST.
        PERFORM F-BIRD.         CLOSE HTV05-MST.
        PERFORM F-BIRD.         CLOSE HTVNO-MST.
        PERFORM F-BIRD.         CLOSE HTVVV-MST.
        PERFORM F-BIRD.         CLOSE HTVK1-MST.
        PERFORM F-BIRD.         CLOSE HTVK2-MST.
        PERFORM F-BIRD.         CLOSE HTVK3-MST.
        PERFORM F-BIRD.         CLOSE HTVK4-MST.
*>
 F-HT-CLOSE2.
        PERFORM F-BIRD.         CLOSE HTVHK-MST.

        PERFORM F-BIRD.         CLOSE HTVHR-MST.
        PERFORM F-BIRD.         CLOSE HTVH1-MST.
        PERFORM F-BIRD.         CLOSE HTVPL-MST.
        PERFORM F-BIRD.         CLOSE HTANT-MST.
        PERFORM F-BIRD.         CLOSE HTATE-MST.
        PERFORM F-BIRD.         CLOSE HTATC-MST.
        PERFORM F-BIRD.         CLOSE HTVIR-MST.
        PERFORM F-BIRD.         CLOSE HTMIC-MST.
        PERFORM F-BIRD.         CLOSE HTDDM-MST.
        PERFORM F-BIRD.         CLOSE HTVRT-MST.
        PERFORM F-BIRD.         CLOSE HTVR1-MST.
***********************************************************************
 F-INIT-RTN.
        INITIALIZE W-CHK-EXIT W-TYPE1 W-TITLE-DATA W-PAGE.
        INITIALIZE W-KEY-TABLE W-TMP-ECB-TYPE W-FORM-TITLE.
*>      IF W-PARAMETERS = 1 THEN
*>              MOVE W-RUN-PARA(1:1)    TO W-TMP-PARA
*>              PERFORM F-FORM-TITLE
*>      ELSE
*>              MOVE W-LNK2             TO W-TMP-PARA
*>              PERFORM F-FORM-TITLE
*>      END-IF.
        EVALUATE W-SOU
                WHEN "M"
                        MOVE W-RUN-PARA(1:1)    TO W-TMP-PARA
                        PERFORM F-FORM-TITLE
                WHEN "S"
                        MOVE W-LNK2             TO W-TMP-PARA
                        PERFORM F-FORM-TITLE
                WHEN "O"
                        MOVE W-RUN-PARA(1:1)    TO W-TMP-PARA
                        PERFORM F-FORM-TITLE
        END-EVALUATE.
 F-INIT-EXIT.
        EXIT.
 F-FORM-TITLE.
        EVALUATE W-TMP-PARA
                WHEN "A"
                        MOVE "住院期間用藥查詢"         TO W-FORM-TITLE
                WHEN "B"
                        MOVE "住院期間檢驗放射線查詢"   TO W-FORM-TITLE
                WHEN "C"
                        MOVE "住院期間治療處置查詢"     TO W-FORM-TITLE
        END-EVALUATE.
        DISPLAY S-RCB1-Fr-1.
***********************************************************************
* 住院系統參數設定檔
***********************************************************************
 F-NID-1000.
        INITIALIZE NID-MST-REC.
        MOVE "1000"     TO NID-ID.
        MOVE "AV"        TO NID-CODE.
        READ NID-MST KEY IS NID-MST-KEY.
        IF NID-MST-STATUS NOT = "00" THEN
                INITIALIZE W-NOTE
                MOVE "住院參數設定檔尚未建檔，請連絡資訊室人員！"       TO W-NOTE
                PERFORM F-ERR-NOTE

        ELSE
                MOVE NID-MST-REC TO W-NID-1000
        END-IF.
*> 住院延伸參數設定
 F-NID-1099.
        INITIALIZE NID-MST-REC W-NID-1099.
        MOVE "1099"     TO NID-ID.
        MOVE "AV"       TO NID-CODE.
        READ NID-MST KEY IS NID-MST-KEY.
        IF NID-MST-STATUS = "00" THEN
                MOVE NID-MST-REC TO W-NID-1099
        END-IF.
 F-NID-1198.
        INITIALIZE NID-MST-REC W-NID-1198.
        MOVE "1198"     TO NID-ID.
        MOVE "0"        TO NID-CODE.
        READ NID-MST KEY IS NID-MST-KEY.
        IF NID-MST-STATUS = "00" THEN
                MOVE NID-MST-REC TO W-NID-1198
        END-IF.
        INITIALIZE NID-MST-REC W-NID-6101.
        MOVE "6101"     TO NID-ID.
        MOVE "0"        TO NID-CODE.
        READ NID-MST KEY IS NID-MST-KEY.
        IF NID-MST-STATUS = "00" THEN
                MOVE NID-MST-REC TO W-NID-6101
        END-IF.
*> 子宮頸檢查參數
 F-NID-1799.
        INITIALIZE NID-MST-REC W-1799-REC.
        MOVE "1799"     TO NID-ID.
        MOVE "0"        TO NID-CODE.
        READ NID-MST KEY IS NID-MST-KEY.
        IF NID-MST-STATUS = "00" THEN
                MOVE NID-MST-REC TO W-1799-REC
        END-IF.
***********************************************************************
*>START (AICE) 98.05.15 電子病歷查印紀錄
***********************************************************************
 F-CHK-LOG-RTN.
*>判斷參數是否需要壓縮
        INITIALIZE      L-PAM-LNK.
*>      識別 (M-維護 I-查詢 R-印表)
        MOVE    "I"             TO L-PAM-ID.
*>      程式名稱
        MOVE    "HRRCB1IF"      TO L-PAM-PROG.
*>      副程式幫忙判斷NID-9400裡的參數,然後回傳值
        CALL "HZPAMCF"  USING W-RUNL-CHK, L-PAM-LNK ON EXCEPTION CONTINUE
        END-CALL.
*>START (AICE) 99.05.20 DM1001-J1001461電子病歷查印紀錄加電子簽章
        IF L-PAM-GO-YN = "N" THEN
                IF W-SOU = "M" OR "O" THEN
                        PERFORM F-CLOSE-RTN THRU F-CLOSE-EXIT
                END-IF
                GOBACK
        END-IF.
*>END DM1001-J1001461

 F-CHK-LOG-EXIT.
        EXIT.

*>擷取畫面資料
 F-CATCH-SEL-RTN.
*>      由參數判斷是否要記錄
        IF      L-PAM-LOG-YN    = "Y"   THEN
                INITIALIZE L-HZRCDCF-LNK
*>              識別 (M-維護 I-查詢 R-印表)
                MOVE    "I"                     TO L-RCD-ID
*>              作業人員 員工編號
                MOVE    W-RUN-USID              TO L-RCD-USER
*>              系統別
                MOVE    L-PAM-SYS               TO L-RCD-SYS
*>              程式名稱
                MOVE    L-PAM-PROG              TO L-RCD-PROG
*>              畫面所輸入之病歷號
                MOVE    W-PAT-NO                TO L-RCD-PAT-NO
*>              記錄方式 (1-xml 2-圖檔 3-web form)
                MOVE    "2"                     TO L-RCD-REC-WAY
*>              查詢備註
                MOVE    "醫令開立管理作業-住院期間用藥明細查詢" TO L-RCD-MEMO
*>              NID9400判斷是否要壓縮
                MOVE    L-PAM-ARCH-YN           TO L-RCD-ARCH-YN
*>START         (AICE) 99.05.20
                MOVE    L-PAM-LOGSG-SW-I        TO L-RCD-LOGSG-SW-I
*>END DM1001-J1001461
*>              異動紀錄圖檔的副程式
                CALL "HZRCDCF"  USING W-RUNL-CHK, L-HZRCDCF-LNK ON    EXCEPTION CONTINUE
                END-CALL
        END-IF.

*>壓縮打包
 F-PACK-RTN.
        IF      L-PAM-LOG-YN    = "Y"   THEN
                INITIALIZE L-HZRCDCF-LNK
*>              識別
                MOVE "I"                        TO L-RCD-ID
*>              系統別
                MOVE    L-PAM-SYS               TO L-RCD-SYS
*>              程式名稱
                MOVE    L-PAM-PROG              TO L-RCD-PROG
*>              查詢條件的病歷號(畫面輸入條件)
                MOVE W-PAT-NO                   TO L-RCD-PAT-NO
*>              記錄方式(1-xml 2-圖檔 3-web form)
                MOVE "2"                        TO L-RCD-REC-WAY
*>              使用者編號
                MOVE W-RUN-USID                 TO L-RCD-USER
*>              告知副程式要離開作業
                MOVE "C"                        TO L-RCD-OPEN-YN
*>              查詢備註
                MOVE    "醫令開立管理作業-住院期間用藥明細查詢" TO L-RCD-MEMO
*>              NID9400判斷是否要壓縮
                MOVE    L-PAM-ARCH-YN           TO L-RCD-ARCH-YN
*>START         (AICE) 99.05.20
                MOVE    L-PAM-LOGSG-SW-I        TO L-RCD-LOGSG-SW-I
*>END DM1001-J1001461

*>              異動紀錄圖檔的副程式
                CALL "HZRCDCF"  USING W-RUNL-CHK, L-HZRCDCF-LNK ON EXCEPTION CONTINUE
                END-CALL
        END-IF.
*>START (AICE) 100.02.21 (DM1101-J1100473)
 F-MOVE-WK-NAME-RTN.
        MOVE "呼叫失敗" TO W-HR-ODRW-WK-NAME.
 F-MOVE-WK-NAME-EXIT.
        EXIT.
***********************************************************************
* 離開時詢問確定
***********************************************************************
 F-EXIT-RTN.
        INITIALIZE W-HRMESCF-DATA W-HRMESCF-DATA2.
        MOVE "2"        TO W-HRMESCF-PIC-TYPE.
        MOVE "4"        TO W-HRMESCF-BUT-TYPE.
        MOVE "Y"        TO W-HRMESCF-CONTROL-ID.
        MOVE "是否確定離開??" TO W-HRMESCF-NOTE(1).
        CALL "HRMESCF" USING W-HRMESCF-DATA W-HRMESCF-DATA2 ON EXCEPTION CONTINUE
        END-CALL.
        IF W-HRMESCF-RETURN = "Y" THEN
                MOVE 27 TO KEY-STATUS
        ELSE
                INITIALIZE KEY-STATUS
        END-IF.
*>START (AICE) 106.11.09 增加顯示已刪除之檢驗項目
 F-START-HRDTB-RTN.
        START HRDTB-MST KEY IS NOT < HRDTB-MST-KEY.
        IF HRDTB-MST-STATUS = "00" THEN
                READ HRDTB-MST NEXT RECORD
        END-IF.
        IF HRDTB-MST-STATUS NOT = "00" OR
           HRDTB-IPD-NO NOT = IPD-NO THEN
                MOVE "10"       TO HRDTB-MST-STATUS
        END-IF.
        IF W-FS = 10 AND HRDTB-MST-STATUS = "10" THEN
                CONTINUE
        ELSE
                MOVE 0  TO W-FS
        END-IF.
 F-START-HRDTB-EXIT.
        EXIT.
 F-READ-TEST-RTN.
        PERFORM F-CHK-FORM-RTN.
        INITIALIZE W-DIS-TABLE.
        MOVE 2          TO W-II.
        IF HRDTB-IPD-NO = IPD-NO THEN
                PERFORM F-READ-HRDTB-RTN THRU F-READ-HRDTB-EXIT
        END-IF.

        IF W-II <= W-MENU-ITEMS THEN
                PERFORM F-READ-HIECB-RTN THRU F-READ-HIECB-EXIT
        END-IF.
 F-READ-TEST-EXIT.
        EXIT.
 F-READ-HRDTB-RTN.


        PERFORM UNTIL   HRDTB-MST-STATUS NOT = "00" OR
                        HRDTB-IPD-NO NOT = IPD-NO OR
                        W-II > W-MENU-ITEMS
                PERFORM F-MOVE-GRID-RTN THRU F-MOVE-GRID-EXIT

                ADD 1   TO W-II
                READ HRDTB-MST NEXT RECORD
        END-PERFORM.
 F-READ-HRDTB-EXIT.
        EXIT.

 F-READ-HIECB-RTN.
        MOVE ECB-MST-REC TO W-PICB W-KEY1(W-PAGE).
        PERFORM UNTIL   ECB-MST-STATUS NOT = "00" OR
                        W-II > W-MENU-ITEMS OR
                        W-FS = 10
                PERFORM F-LOAD-GRID-RTN
                PERFORM F-READN-RTN
                ADD 1   TO W-II
        END-PERFORM.
*>      先把指標移到第一筆資料
        MODIFY S-RCB1-GD-1,START-X = 1,X = 99,START-Y = 2 ,Y = 2,REGION-COLOR = W-GD-COLOR.
        MOVE 2  TO W-GRID-Y W-GRID-Y1.
 F-READ-HIECB-EXIT.
        EXIT.
 F-MOVE-GRID-RTN.
        INITIALIZE W-GD-REC.
*>      MOVE ECB-MST-REC        TO W-DIS-REC(W-II).
*>      序
        MOVE W-NO               TO W-INQ-SEQ.

*>      處置名稱
        INITIALIZE PRS-MST-REC.
        MOVE HRDTB-FEE-KEY      TO PRS-MST-ID.
        READ PRS-MST KEY IS PRS-MST-KEY.
        IF PRS-MST-STATUS = "00" THEN
                MOVE PRS-ID-NAME        TO W-INQ-PRS-NAME
        ELSE
                MOVE "代碼已不存在"     TO W-INQ-PRS-NAME
        END-IF.

*>      2023/01/30 桃園 - 因為檢驗檢查取消後檢驗資料就消失了而無法取得細項名稱
        IF W-NID-6101(80:1) = "Y" THEN
*>              取得細項名稱
                INITIALIZE HTITM-REC
                MOVE HRDTB-DPT-CD       TO HTITM-DPT-CD
                MOVE HRDTB-CLS-CD       TO HTITM-CLS-CD
                MOVE HRDTB-ICB-ITM-CD   TO HTITM-ITM-CD
                READ HTITM-MST KEY IS HTITM-KEY
                IF HTITM-MST-STATUS = "00" AND HRDTB-DPT-CD = HTITM-DPT-CD AND
                   HRDTB-CLS-CD = HTITM-CLS-CD AND HRDTB-ICB-ITM-CD = HTITM-ITM-CD THEN
                        MOVE HTITM-ITM-NM TO W-INQ-PRS-NAME
                END-IF
        END-IF.
*>      2023/01/30 END

*>      狀況

        MOVE "取消"             TO W-INQ-RX-WAY(1:8).

*>      數量
        IF HRDTB-RX-QTY1 > 0 AND HRDTB-RX-QTY2 > 0 THEN
                MOVE HRDTB-RX-QTY1      TO W-QTY1
                MOVE HRDTB-RX-QTY2      TO W-QTY2
                PERFORM F-QTY-RTN
                MOVE W-DIS-QTY          TO W-INQ-RX-QTY
        ELSE
                MOVE HRDTB-RX-QTY1      TO W-INQ-RX-QTY(1:4)
                MOVE HRDTB-RX-QTY2      TO W-INQ-RX-QTY(6:2)
        END-IF.
*>      處方日-時間
        INITIALIZE ICA-MST-REC.
        MOVE HRDTB-IPD-NO       TO ICA-IPD-NO.
        MOVE HRDTB-ICA-ODR-NO   TO ICA-ODR-NO.
        READ ICA-MST KEY IS ICA-KEY.
        IF ICA-MST-STATUS = "00" THEN
                MOVE ICA-INS-DATE       TO W-INQ-INS-DATE(1:7)
                MOVE "-"                TO W-INQ-INS-DATE(8:1)
                IF ICA-ODR-TIME IS NUMERIC      THEN
                        MOVE ICA-ODR-TIME       TO W-INQ-INS-DATE(9:4)
                END-IF
        ELSE
                MOVE HRDTB-IP-DATE      TO W-INQ-INS-DATE(1:7)
                MOVE "-"                TO W-INQ-INS-DATE(8:1)
                MOVE "0000"             TO W-INQ-INS-DATE(9:4)
        END-IF.

*>      取消日-時間
        INITIALIZE HRDTA-MST-REC.
        MOVE HRDTB-KEY  TO HRDTA-KEY.
        READ HRDTA-MST KEY IS HRDTA-MST-KEY.
        IF HRDTA-MST-STATUS = "00" THEN
                MOVE HRDTA-INS-DATE             TO W-INQ-CANCEL-DTTI(1:7)
                MOVE "-"                        TO W-INQ-CANCEL-DTTI(8:1)
                MOVE HRDTA-CRE-TIME(1:4)        TO W-INQ-CANCEL-DTTI(9:4)
        ELSE
                MOVE HRDTB-INS-DATE             TO W-INQ-CANCEL-DTTI(1:7)
                MOVE "-"                        TO W-INQ-CANCEL-DTTI(8:1)
                MOVE "0000"                     TO W-INQ-CANCEL-DTTI(9:4)
        END-IF

*>
        MODIFY S-RCB1-Gd-1, X = 1 , Y = W-II, RECORD-TO-ADD = W-GD-REC.
        MOVE W-GD-REC           TO W-DISR(W-II).
        MOVE HRDTB-MST-REC      TO W-HRDTB-REC(W-II).
        ADD 1           TO W-NO.
 F-MOVE-GRID-EXIT.
        EXIT.
*>END 106.11.09

*>2019/12/24 耀瑄NIS
*>刪除時加寫HR_UDL3
 F-DEL-TO-WRITE-HRUDL3-RTN.
        INITIALIZE HRUDL3-MST-REC.
*       COPY "ZD_DTI.PRC".

*
* ZD_DTI.PRC ... 同 ZD_YMD.PRC ...  取日期時間 ...
*
        MOVE W-RUN-YYSW  TO W-YMD-YYSW.
        MOVE W-RUN-YYDEF TO W-YMD-YYDEF.
        MOVE W-RUN-YYCOM TO W-YMD-YYCOM.
*
* 日期 ...
        ACCEPT W-YMD-DATE FROM CENTURY-DATE.
        MOVE W-YMD-YY TO W-YMD-YYB.
        MOVE W-YMD-YY TO W-YMD-YY1.
        MOVE W-YMD-MM TO W-YMD-MM1.
        MOVE W-YMD-DD TO W-YMD-DD1.
*
* YYSW   : 使用年曆設定     -- 4:使用四碼西元年 2:二碼西元年, 0:表使用當地國年
* YYDEF  : 年度換算初值     -- 西元年換算使用國年初值(例:1911, 0 視同1911)
* YYCOM  : 年度計算方式     -- 西元年計算使用國年方式(例:+,-, 空白視同 - )
* YDFSW  : 變數用...
*
        IF W-YMD-YYCOM NOT = "+" AND "-" THEN
                ACCEPT W-YMD-YYSW       FROM ENVIRONMENT "ZS_SYYW"
                END-ACCEPT
                ACCEPT W-YMD-YDFSW      FROM ENVIRONMENT "ZS_SYDF"
                END-ACCEPT
                ACCEPT W-YMD-YYCOM      FROM ENVIRONMENT "ZS_SYCM"
                END-ACCEPT
                IF W-YMD-YYSW NOT = "2" AND "4" THEN
                        MOVE "0" TO W-YMD-YYSW
                END-IF
                IF W-YMD-YYCOM NOT = "+" AND "-" THEN
                        MOVE "-" TO W-YMD-YYCOM
                END-IF
                MOVE W-YMD-YDFSW TO W-YMD-YYDEF WITH CONVERT
                IF ( W-YMD-YYDEF = 0 ) AND
                   ( W-YMD-YYSW  = "0" ) AND
                   ( W-YMD-YYCOM = "-" ) THEN
                        MOVE 1911 TO W-YMD-YYDEF
                END-IF
        END-IF.
*
* YYS : - 表轉換後年度為負值
*
        MOVE SPACE TO W-YMD-YYS.
        IF W-YMD-YYSW = "4" THEN
                CONTINUE
        ELSE
        IF W-YMD-YYSW = "2" THEN
                MOVE W-YMD-YY1 TO W-YMD-YY
        ELSE    IF W-YMD-YYCOM = "+" THEN
                        COMPUTE W-YMD-YY = W-YMD-YY + W-YMD-YYDEF
                ELSE    IF W-YMD-YY > W-YMD-YYDEF THEN
                                COMPUTE W-YMD-YY = W-YMD-YY - W-YMD-YYDEF
                        ELSE    COMPUTE W-YMD-YY = W-YMD-YY - W-YMD-YYDEF - 1
                                MOVE "-" TO W-YMD-YYS
                        END-IF
                END-IF
        END-IF.

*
* 時間 ...
        ACCEPT W-YMD-TIME8 FROM TIME.
        MOVE W-YMD-HHS TO W-YMD-HH.
        MOVE W-YMD-MTS TO W-YMD-MT.
        MOVE W-YMD-SSS TO W-YMD-SS.
*
        MOVE W-YMD-DATE TO W-DATE.
        MOVE W-YMD-TIME TO W-TIME.
*
        ACCEPT W-YMD-TIME8 FROM TIME.
        MOVE W-YMD-HHS TO W-YMD-HH.
        MOVE W-YMD-MTS TO W-YMD-MT.
        MOVE W-YMD-SSS TO W-YMD-SS.
*
        MOVE W-YMD-DATE TO W-DATE.
        MOVE W-YMD-TIME TO W-TIME.
*
*>      新增日期
        MOVE W-DATE             TO HRUDL3-C-DATE HRUDL3-UPD-DT.
*>      新增時間
        MOVE W-TIME             TO HRUDL3-C-TIME.
*>      異動時間
        MOVE W-TIME             TO HRUDL3-UPD-TIME.
*>      病歷號
        MOVE PAT-NO             TO HRUDL3-PAT-NO.
*>      住院序號
        MOVE ICB-IPD-NO         TO HRUDL3-PATIENT-SEQ.
*>      流水序
        MOVE ECB-FEE-SEQ        TO HRUDL3-ORDER-SEQ.
*>      檔案序號
        MOVE ECB-FILE-NO        TO HRUDL3-FILE-NO.
*>      開立狀態"D"
        MOVE "D"                TO HRUDL3-STATUS-FLAG.
*>      處置代碼
        MOVE ICB-FEE-KEY        TO HRUDL3-ODR-CODE.
*>      次劑量-分子
        MOVE ICB-RX-UQTY1       TO HRUDL3-DOSE-MOLE.
*>      次劑量-分母
        MOVE ICB-RX-UQTY2       TO HRUDL3-DOSE-DENO.
*>      途徑
        MOVE ICB-RX-WAY2        TO HRUDL3-METHOD-CODE.
*>      開立天數
        MOVE ICB-RX-DAYS        TO HRUDL3-DAYS.
*>      開始日
        MOVE ICB-OP-BDATE       TO HRUDL3-B-DATE.
*>      開始時分
        MOVE ICB-OP-BTIME       TO HRUDL3-B-TIME.
*>      結束日
        MOVE ICB-OP-EDATE       TO HRUDL3-E-DATE.
*>      結束時分
        MOVE ICB-OP-ETIME       TO HRUDL3-E-TIME.
*>      總量-分子
        MOVE ICB-RX-QTY1        TO HRUDL3-NUM-MOLE.
*>      總量-分母
        MOVE ICB-RX-QTY2        TO HRUDL3-NUM-DENO.
*>      急作註記

        MOVE ICB-PAY-RANK       TO HRUDL3-ER-FLAG.
*>      自費識別
        MOVE ICB-ASU-PAY        TO HRUDL3-VAL-SWITCH.
*>      計價方式
        MOVE ICB-CHG-FLAG       TO HRUDL3-OWN-FLAG.
*>      腦部加成
        MOVE ECB-BRAIN-YN       TO HRUDL3-BRAIN-FLAG.
*>      部位
        MOVE ECB-LRB-FIELD      TO HRUDL3-POSITION-FLAG.
*>      開立醫師
        MOVE ECB-APY-DR         TO HRUDL3-DR-CODE.
*>      實作醫師一
        MOVE ECB-OPR-DR1        TO HRUDL3-CARRY1-CODE.
*>      實作醫師二
        MOVE ECB-OPR-DR2        TO HRUDL3-CARRY2-CODE.
*>      報告醫師
        MOVE ECB-RPT-DR         TO HRUDL3-REPORT-DR-CODE.
*>      連帶指標(父項)
        MOVE ECB-LNK-POINT-HEAD TO HRUDL3-LNK-POINT-HEAD.
*>      連帶指標(子項)
        MOVE ECB-LNK-POINT      TO HRUDL3-LNK-POINT.
*>      連帶指標時間
        MOVE ECB-LNK-TIME       TO HRUDL3-LNK-TIME.
*>      科室代碼
        MOVE ICB-PAS-DPT        TO HRUDL3-DPT-CODE.
*>      類別代碼
        MOVE ICB-CLS-NO         TO HRUDL3-CLS-CODE.
*>      流水序
        MOVE ICB-FEE-SEQ        TO HRUDL3-SERIAL-NO.
*>      醫令項目代碼
        MOVE ICB-PAS-ITM        TO HRUDL3-ITM-CODE.
*>      院內費用項目代碼→標準費用別？
        MOVE ICB-STD-FNO        TO HRUDL3-STD-CODE.
*>      庫存代碼→庫別？
        MOVE ICB-STO-DEPT       TO HRUDL3-STORE-CODE.
*>      備註
        MOVE ECB-REMARK         TO HRUDL3-ODR-NOTE.

        WRITE HRUDL3-MST-REC.
        IF HRUDL3-MST-STATUS NOT = "00" THEN
                MOVE "B"        TO W-TMP-ID
                MOVE "W"        TO W-UPD-MRK
                PERFORM F-WRT-LOG2-RTN THRU F-WRT-LOG2-EXIT
        END-IF.

*>記錄ICA寫檔錯誤碼[7]
 F-WRT-LOG2-RTN.
*       COPY "ZD_DTI.PRC".
*
* ZD_DTI.PRC ... 同 ZD_YMD.PRC ...  取日期時間 ...
*
        MOVE W-RUN-YYSW  TO W-YMD-YYSW.
        MOVE W-RUN-YYDEF TO W-YMD-YYDEF.
        MOVE W-RUN-YYCOM TO W-YMD-YYCOM.
*
* 日期 ...
        ACCEPT W-YMD-DATE FROM CENTURY-DATE.

        MOVE W-YMD-YY TO W-YMD-YYB.
        MOVE W-YMD-YY TO W-YMD-YY1.
        MOVE W-YMD-MM TO W-YMD-MM1.
        MOVE W-YMD-DD TO W-YMD-DD1.
*
* YYSW   : 使用年曆設定     -- 4:使用四碼西元年 2:二碼西元年, 0:表使用當地國年
* YYDEF  : 年度換算初值     -- 西元年換算使用國年初值(例:1911, 0 視同1911)
* YYCOM  : 年度計算方式     -- 西元年計算使用國年方式(例:+,-, 空白視同 - )
* YDFSW  : 變數用...
*
        IF W-YMD-YYCOM NOT = "+" AND "-" THEN
                ACCEPT W-YMD-YYSW       FROM ENVIRONMENT "ZS_SYYW"
                END-ACCEPT
                ACCEPT W-YMD-YDFSW      FROM ENVIRONMENT "ZS_SYDF"
                END-ACCEPT
                ACCEPT W-YMD-YYCOM      FROM ENVIRONMENT "ZS_SYCM"
                END-ACCEPT
                IF W-YMD-YYSW NOT = "2" AND "4" THEN
                        MOVE "0" TO W-YMD-YYSW
                END-IF
                IF W-YMD-YYCOM NOT = "+" AND "-" THEN
                        MOVE "-" TO W-YMD-YYCOM
                END-IF
                MOVE W-YMD-YDFSW TO W-YMD-YYDEF WITH CONVERT
                IF ( W-YMD-YYDEF = 0 ) AND
                   ( W-YMD-YYSW  = "0" ) AND
                   ( W-YMD-YYCOM = "-" ) THEN
                        MOVE 1911 TO W-YMD-YYDEF
                END-IF
        END-IF.
*
* YYS : - 表轉換後年度為負值
*
        MOVE SPACE TO W-YMD-YYS.
        IF W-YMD-YYSW = "4" THEN
                CONTINUE
        ELSE
        IF W-YMD-YYSW = "2" THEN
                MOVE W-YMD-YY1 TO W-YMD-YY
        ELSE    IF W-YMD-YYCOM = "+" THEN
                        COMPUTE W-YMD-YY = W-YMD-YY + W-YMD-YYDEF
                ELSE    IF W-YMD-YY > W-YMD-YYDEF THEN
                                COMPUTE W-YMD-YY = W-YMD-YY - W-YMD-YYDEF
                        ELSE    COMPUTE W-YMD-YY = W-YMD-YY - W-YMD-YYDEF - 1
                                MOVE "-" TO W-YMD-YYS
                        END-IF
                END-IF
        END-IF.
*
* 時間 ...
        ACCEPT W-YMD-TIME8 FROM TIME.
        MOVE W-YMD-HHS TO W-YMD-HH.
        MOVE W-YMD-MTS TO W-YMD-MT.
        MOVE W-YMD-SSS TO W-YMD-SS.
*
        MOVE W-YMD-DATE TO W-DATE.
        MOVE W-YMD-TIME TO W-TIME.

*
        ACCEPT W-YMD-TIME8 FROM TIME.
        MOVE W-YMD-HHS TO W-YMD-HH.
        MOVE W-YMD-MTS TO W-YMD-MT.
        MOVE W-YMD-SSS TO W-YMD-SS.
*
        MOVE W-YMD-DATE TO W-DATE.
        MOVE W-YMD-TIME TO W-TIME.
*
        INITIALIZE LOG2-MST-REC W-DEC-TIME W-LOG2-ODR-TIME.
        ADD 1 TO W-LOG2-CON.
        MOVE "7" TO LOG2-ID.
        MOVE W-DATE        TO LOG2-CRE-DT.
        MOVE W-TIME        TO LOG2-CRE-TI W-LOG2-ODR-TIME.
        COMPUTE LOG2-DCRE-DT = 9999999 - LOG2-CRE-DT.
        COMPUTE W-DEC-TIME = 999999 - W-LOG2-ODR-TIME.
        MOVE W-DEC-TIME TO LOG2-DCRE-TI.
        MOVE W-LOG2-CON TO LOG2-ID-SEQ LOG2-FEE-NO.
        MOVE W-UPD-MRK  TO LOG2-UPD-MRK.
        IF W-TMP-ID = "A" THEN
                STRING  "處方-" ICA-KEY " 寫檔不成功，狀況：" ICA-MST-STATUS " ！"
                        " 日期-" W-DATE " 時間-" W-TIME  DELIMITED BY SIZE INTO LOG2-DATA
                END-STRING
        ELSE
                STRING  "住院醫令[檢驗檢查放射]異動記錄檔寫檔不成功，狀況：" HRUDL3-MST-STATUS " ！"
                        " 日期-" W-DATE " 時間-" W-TIME  DELIMITED BY SIZE INTO LOG2-DATA
                END-STRING
        END-IF.
        WRITE LOG2-MST-REC.

 F-WRT-LOG2-EXIT.
        EXIT.
*>2019/12/24 END
***********************************************************************
*COPY    "HI_DTE.PRC".
*> ****************************************************************************
*> C-PY FILE : HI_DTE.PRC  CHECK 申報審核鎖檔，整帳鎖檔 HIOD1KF 醫令相關作業
*>      W-IPD-LOCK = "Y" 出院                           HIOD2MF
*>      W-IPD-LOCK = "X" 住院                           HIOD3DF
*>      890511 修改住院中申報鎖檔判別                   HIRTNKF
*>      901023 增加判斷整帳鎖檔(CALL HILOCKCF)  (JAY)   HIDENKF
*> ****************************************************************************
*F-CHK-DTE-DATA.
*        INITIALIZE              W-IPD-LOCK      W-DTE-TABLE.
*>      住院中, 以IPD-MST 之申報起迄來控制是否申報
*        IF IPD-OUT-DT   = 0
*                PERFORM F-CHK-APYI-LOCK
*        ELSE
*                PERFORM F-DTE-READ
*                IF DTE-VRY-LOCK = "Y"
*                        MOVE "Y"          TO W-IPD-LOCK
*                        PERFORM F-DIS-IPD-LOCK
*                END-IF
*        END-IF.
*> 住院中, 申報鎖檔審核
*F-CHK-APYI-LOCK.
*        IF      IPD-APY-STRDT-R = SPACE OR IPD-APY-ENDDT-R = SPACE

*                EXIT    PARAGRAPH
*        END-IF.
*        IF      (IPD-APY-STRDT-R IS NUMERIC AND IPD-APY-STRDT = ZERO)
*        OR      (IPD-APY-ENDDT-R IS NUMERIC AND IPD-APY-ENDDT = ZERO)
*                EXIT    PARAGRAPH
*        END-IF.
*>      實際住院日
*        IF IPD-REAL-YN = "Y" AND IPD-UD-DT NOT = ZERO
*                MOVE    IPD-UD-DT(1:5)  TO      W-CHK-DTE-YM    WITH CONVERT
*        ELSE
*                MOVE    IPD-DT(1:5)     TO      W-CHK-DTE-YM    WITH CONVERT
*        END-IF.
*>      從住院日之年月找尋所有鎖檔之年月
*        INITIALIZE                      DTE-MST-REC.
*        MOVE    W-CHK-DTE-YM            TO      DTE-VRY-YM.
*        START   DTE-MST KEY IS  >=      DTE-MST-KEY.
*        IF      DTE-MST-STATUS  = "00"
*                READ    DTE-MST NEXT RECORD
*        END-IF.
*>      下載自住院日以後所有有鎖檔之年月
*        PERFORM UNTIL   (DTE-MST-STATUS NOT = "00")
*                IF      DTE-VRY-LOCK    = "Y"
*                        ADD     1       TO      W-DTE-CNT
*                        IF      W-DTE-CNT > W-MAX-DTE
*                                MOVE    W-MAX-DTE       TO      W-DTE-CNT
*                                EXIT    PERFORM
*                        END-IF
*                        MOVE    DTE-VRY-YM      TO      W-DTE-YM(W-DTE-CNT)
*                        MOVE    DTE-VRY-LOCK    TO      W-DTE-LOCK(W-DTE-CNT)
*                END-IF
*                READ    DTE-MST NEXT
*        END-PERFORM.
*       IF      W-DTE-CNT       NOT = ZERO
*               MOVE "X"        TO W-IPD-LOCK
*       END-IF.
*> 依處方年月判別該月份是否已鎖檔
*F-SEARCH-DTE-LOCK.
*        INITIALIZE      W-IPD-LOCK.
*        IF      IPD-APY-STRDT-R = SPACE OR IPD-APY-ENDDT-R = SPACE
*                EXIT    PARAGRAPH
*        END-IF.
*        IF      (IPD-APY-STRDT-R IS NUMERIC AND IPD-APY-STRDT = ZERO)
*        OR      (IPD-APY-ENDDT-R IS NUMERIC AND IPD-APY-ENDDT = ZERO)
*                EXIT    PARAGRAPH
*        END-IF.
*>      判別處方日∕退藥日是否落在本次申報區間內, 如屬於本次申報區間,
*>      則以申報迄日之年月來當成鎖檔之年月判別, 否則以處方日或退藥日之年月
*>      來作鎖檔年月之判別      890511 UPDATE.
*        IF      W-CHK-DTE-YMD   >=      IPD-APY-STRDT
*        AND     W-CHK-DTE-YMD   <=      IPD-APY-ENDDT
*                MOVE    IPD-APY-ENDDT(1:5)      TO      W-CHK-DTE-YM WITH CONVERT
*        ELSE
*                MOVE    W-CHK-DTE-YMD(1:5)      TO      W-CHK-DTE-YM WITH CONVERT
*        END-IF.

*        SET     W-DTE-INDEX     TO      1.
*        SEARCH  W-DTE-TAB

*           WHEN W-DTE-YM(W-DTE-INDEX) = W-CHK-DTE-YM
*            AND W-DTE-LOCK(W-DTE-INDEX) = "Y"
*                MOVE    "Y"     TO      W-IPD-LOCK
*                PERFORM F-DIS-IPD-LOCK
*        END-SEARCH.
*> CHECK 該月份是否已申報鎖檔
*F-DTE-READ.
*        INITIALIZE              DTE-MST-REC.
*        IF      IPD-LIVE-ID     = "B" OR "C" OR "X"
*                EXIT    PARAGRAPH
*        END-IF.
*        MOVE IPD-OUT-DT(1:5)    TO DTE-VRY-YM   WITH CONVERT.
*        READ DTE-MST  KEY IS    DTE-MST-KEY.
*> 申報鎖檔訊息
*F-DIS-IPD-LOCK.
*        MOVE " 此病患已申報鎖檔,請查核 !!"  TO W-NOTE.
*        PERFORM F-NOTE-RTN.
*---------------------*
* 901023 判斷整帳年月 *
*---------------------*
 F-CHK-LOCK-RTN.
        INITIALIZE      W-LNK-LOCKCF.
        IF      W-CHK-1029-YN = "Y"
*>              副程式功能識別
                MOVE    "02"    TO      W-LOCKCF-ID
        ELSE
                MOVE    "03"    TO      W-LOCKCF-ID
        END-IF.
*>      處方日期
        MOVE    W-CHK-DTE-YMD   TO      W-LOCKCF-DT.
        CALL    "HILOCKCF"      USING   W-LNK-LOCKCF
                ON      EXCEPTION       CONTINUE
        END-CALL.
 F-CHK-LOCK-EXIT.
        EXIT.
*> ******************************************************
*>      END     OF      FILE
*> ******************************************************
*------> 電子病歷相關共用段
*COPY    "HI_ELC.PRC".
**************************************************************
*> C-PY FILE : HI_ELC.PRC       HR_ELC.TRN 寫檔共用段
*>                              EMBEDED IN HI_ODWI.PRC, HI_ICBV.PRC
*>                              USED BY HIOD2MF
*>      住院管理, 住院收費, 住院醫令共用
*>      900915 增加申報主機相關修改
**************************************************************
*> 讀取參數設定-CHECK 電子病歷連線否
 F-READ-ELC-SETTING.
        INITIALIZE              W-LNK-ELCCF.
        MOVE    "01"            TO      W-ELCCF-ID.
        CALL    "HIELCCF"       USING   W-LNK-ELCCF     ON EXCEPTION CONTINUE.
        MOVE    W-ELCCF-YN      TO      W-ELC-YN.
*>      900915 SMSTL UPDATE:
        MOVE    W-ELCCF-APY-YN  TO      W-USE-APY-YN.
*> 電子病歷開檔(提供其它系統程式使用)
 F-OPEN-ELC-TRN.

        INITIALIZE              W-LNK-ELCCF.
*>      未使用電子病歷及申報主機的, 才不開檔, 其餘一者成立都要開檔 900915 UPDATE
        IF      (W-ELC-YN       NOT = "Y")
        AND     (W-USE-APY-YN   NOT = "Y")
                EXIT    PARAGRAPH
        END-IF.
        MOVE    "02"            TO      W-ELCCF-ID.
        CALL    "HIELCCF"       USING   W-LNK-ELCCF     ON EXCEPTION CONTINUE.
*>      IF W-ELCCF-ERR  = "Y"
*>              不允許往下執行程式
*>      END-IF.
*> 電子病歷關檔(提供其它系統程式使用)
 F-CLOSE-ELC-TRN.
        INITIALIZE              W-LNK-ELCCF.
        IF      (W-ELC-YN       NOT = "Y")
        AND     (W-USE-APY-YN   NOT = "Y")
                EXIT    PARAGRAPH
        END-IF.
        MOVE    "03"            TO      W-ELCCF-ID.
        CALL    "HIELCCF"       USING   W-LNK-ELCCF     ON EXCEPTION CONTINUE.
*> 電子病歷住院基本資料異動檔寫檔
 F-WRITE-ELC-TRN-11.
*>      電子病歷未連線時則不處理
        IF      W-ELC-YN        NOT = "Y"
                EXIT    PARAGRAPH
        END-IF.
        INITIALIZE                      W-LNK-ELCCF.
*>      住院基本資料異動
        MOVE    "11"                    TO      W-ELCCF-ID.
        MOVE    IPD-NO                  TO      W-ELCCF-IPD-NO.
        MOVE    W-ELC-MARK              TO      W-ELCCF-MARK.
        CALL    "HIELCCF"       USING   W-LNK-ELCCF     ON EXCEPTION CONTINUE.
*> 電子病歷/申報主機處方異動檔寫檔
 F-WRITE-ELC-TRN-21.
*>      電子病歷處方異動
        PERFORM F-WRITE-ELC-TRN-211.
*>      申報主機處方異動
        PERFORM F-WRITE-ELC-TRN-41.
*> 電子病歷處方異動
 F-WRITE-ELC-TRN-211.
*>      電子病歷未連線時則不處理
        IF      W-ELC-YN        NOT = "Y"
                EXIT    PARAGRAPH
        END-IF.
        INITIALIZE                      W-LNK-ELCCF.
*>      批價資料新增C/修改M/刪除D
        MOVE    "21"                    TO      W-ELCCF-ID.
        MOVE    ICA-IPD-NO              TO      W-ELCCF-IPD-NO.
        MOVE    ICA-ODR-NO              TO      W-ELCCF-ODR-NO.
        MOVE    W-ELC-MARK              TO      W-ELCCF-MARK.
        CALL    "HIELCCF"       USING   W-LNK-ELCCF     ON EXCEPTION CONTINUE.
*> 申報主機處方異動寫檔
 F-WRITE-ELC-TRN-41.
*>      電子病歷未連線時則不處理
        IF      W-USE-APY-YN            NOT = "Y"
                EXIT    PARAGRAPH
        END-IF.

        INITIALIZE                      W-LNK-ELCCF.
*>      批價資料新增C/修改M/刪除D
        MOVE    "41"                    TO      W-ELCCF-ID.
        MOVE    ICA-IPD-NO              TO      W-ELCCF-IPD-NO.
        MOVE    ICA-ODR-NO              TO      W-ELCCF-ODR-NO.
        MOVE    W-ELC-MARK              TO      W-ELCCF-MARK.
        CALL    "HIELCCF"       USING   W-LNK-ELCCF     ON EXCEPTION CONTINUE.
*> ****************************************************************************
*>      END     OF      FILE
*> ****************************************************************************
*COPY    "HI_GCA2.PRC".
*********************************************************************************
*       C-PY    FILE : HI_GCA2.PRC      USED BY : HIOD2MF、醫令系統(宜霏)       *
* 901122  CREATE BY JAY                                                         *
* 910301  抓取W-ICA-TMP-UPD-USR-ID可區別修改前、修改後之異動者  (JAY)           *
* 910306  申報系統異動識別碼寫檔(JAY)                                           *
*********************************************************************************
*------------------------*
* 寫入修改前處方異動記錄 *
*------------------------*
 F-WRITE-GCA-OLD-RTN.
        INITIALIZE      HIGCA-MST-REC.
        MOVE    W-ICA-TMP-KEY           TO      HIGCA-KEY.
        MOVE    W-DATE                  TO      HIGCA-DATE.
        MOVE    W-TIME                  TO      HIGCA-TIME.
        MOVE    W-UPD-ID                TO      HIGCA-UPD-ID.
*>      異動者(910301)
        MOVE    W-ICA-TMP-UPD-USR-ID    TO      HIGCA-UPD-USR.
*       MOVE    W-RK-DUTY-ID1           TO      HIGCA-UPD-USR.
*>      申報系統異動識別(910306)
        MOVE    W-GCA-APY-ID            TO      HIGCA-APY-ID.
        MOVE    W-ICA-TMP-GROUP-DATA1   TO      HIGCA-DATA1.
        WRITE   HIGCA-MST-REC.
 F-WRITE-GCA-OLD-EXIT.
        EXIT.
*------------------*
* 寫入處方異動記錄 *
*------------------*
 F-WRITE-GCA-NEW-RTN.
        INITIALIZE      HIGCA-MST-REC.
*>      住院序號
        MOVE    ICA-IPD-NO      TO      HIGCA-IPD-NO.
*>      處方序號
        MOVE    ICA-ODR-NO      TO      HIGCA-ODR-NO.
*>      異動日期
        MOVE    W-DATE          TO      HIGCA-DATE.
*>      異動時間
        MOVE    W-TIME          TO      HIGCA-TIME.
*>      異動狀態
        MOVE    W-UPD-ID        TO      HIGCA-UPD-ID.
*>      異動者
        MOVE    W-RK-DUTY-ID1   TO      HIGCA-UPD-USR.
*>      申報系統異動識別(910306)
        MOVE    W-GCA-APY-ID            TO      HIGCA-APY-ID.
        MOVE    ICA-GROUP-DATA1 TO      HIGCA-DATA1.
        WRITE   HIGCA-MST-REC.
 F-WRITE-GCA-NEW-EXIT.

        EXIT.
*----------------------*
* 寫入處方明細異動記錄 *
*----------------------*
 F-WRITE-GCB-RTN.
        INITIALIZE      HIGCB-MST-REC.
        MOVE    ICB-IPD-NO      TO      HIGCB-IPD-NO.
        MOVE    ICB-ODR-NO      TO      HIGCB-ODR-NO.
        MOVE    W-DATE          TO      HIGCB-DATE.
        MOVE    W-TIME          TO      HIGCB-TIME.
        MOVE    ICB-FEE-SEQ     TO      HIGCB-FEE-SEQ.
        MOVE    ICB-FEE-KEY     TO      HIGCB-FEE-KEY.
        MOVE    W-UPD-ID        TO      HIGCB-UPD-ID.
        MOVE    ICB-GROUP-DATA1 TO      HIGCB-DATA1.
        MOVE    ECB-FILE-NO     TO      HIGCB-FILE-NO.
        MOVE    ECB-TYPE        TO      HIGCB-TYPE.
        MOVE    ECB-ALT1        TO      HIGCB-ECB-ALT1.
        MOVE    ECB-ALT2        TO      HIGCB-ECB-ALT2.
        MOVE    ECB-GROUP-DATA1 TO      HIGCB-ECB-DATA1.
        MOVE    ECB-GROUP-DATA2 TO      HIGCB-ECB-DATA2.
        WRITE   HIGCB-MST-REC.
 F-WRITE-GCB-EXIT.
        EXIT.
*--------------------------------------------------*
* 系統TIME 之'分' + 1 , 做為修改前後異動時間之差距 *
*--------------------------------------------------*
 F-ADD-MT-RTN.
        ADD     1       TO      W-MT.
 F-ADD-MT-EXIT.
        EXIT.
*------>搜尋醫師科別
*COPY    "HR_LOA1.PRC".
************************************************************************
*> HR_LOA1.PRC
************************************************************************
*搜尋
 F-SEARCH-DPT-RTN.
        IF HR-TMP-DPT NOT = SPACE THEN
                MOVE 1 TO HR-DPT-JJ
                SEARCH W-DEP-TAB1 VARYING HR-DPT-JJ
                        AT END
                                MOVE SPACE TO HR-TMP-DPT-NAME
                        WHEN HR-DEP-TAB1-NO(HR-DPT-JJ) = HR-TMP-DPT
                                MOVE HR-DEP-TAB1-NAME(HR-DPT-JJ) TO HR-TMP-DPT-NAME
                END-SEARCH
        ELSE
                INITIALIZE HR-TMP-DPT-NAME
        END-IF.
        IF HR-TMP-DPT-NAME = SPACE THEN
                INITIALIZE NID-MST-REC
                MOVE "0501"     TO NID-ID
                MOVE HR-TMP-DPT TO NID-CODE
                READ NID-MST KEY IS NID-MST-KEY
                IF NID-MST-STATUS = "00" THEN
                        MOVE NID-NAME   TO HR-TMP-DPT-NAME
                ELSE
                        MOVE HR-TMP-DPT TO HR-TMP-DPT-NAME

                END-IF
        END-IF.
 F-SEARCH-DR-RTN.
        IF HR-TMP-DR NOT = SPACE THEN
                MOVE 1 TO HR-DR-JJ
                SEARCH W-DR-TAB1 VARYING HR-DR-JJ
                        AT END
                                MOVE SPACE TO HR-TMP-DR-NAME
                        WHEN HR-DR-TAB1-NO(HR-DR-JJ) = HR-TMP-DR
                                MOVE HR-DR-TAB1-NAME(HR-DR-JJ) TO HR-TMP-DR-NAME
                END-SEARCH
        ELSE
                INITIALIZE HR-TMP-DR-NAME
        END-IF.
        IF HR-TMP-DR-NAME = SPACE THEN
                INITIALIZE NID-MST-REC
                MOVE "0503"     TO NID-ID
                MOVE HR-TMP-DR  TO NID-CODE
                READ NID-MST KEY IS NID-MST-KEY
                IF NID-MST-STATUS = "00" THEN
                        MOVE NID-NAME   TO HR-TMP-DR-NAME
                ELSE
                        MOVE HR-TMP-DR  TO HR-TMP-DR-NAME
                END-IF
        END-IF.
************************************************************************
*COPY    "HR_LOA2.PRC".
************************************************************************
*> HR_LOA2.PRC
*>102.12.02 (FISH) 修正醫師代碼載入過久問題。(DM1301-J1301394)
*>103.04.08 (書伶)
************************************************************************
*下載
 F-DEP-RTN.
*>      INITIALIZE W-PERCENT.
*>      INITIALIZE W-LA-NAME.
*>      MOVE "系統科別代碼下載中,請稍候 ..."    TO W-LA-NAME.
*>      PERFORM F-LOAD-BAR.
        INITIALIZE W-LA-NAME.
        MOVE "系統科別代碼下載中,請稍候 ..."    TO W-LA-NAME.
*>
        INITIALIZE NID-MST-REC.
        MOVE "0501" TO NID-ID.
        START NID-MST KEY IS NOT < NID-ALT-KEY1.
        READ NID-MST NEXT RECORD.
        PERFORM VARYING HR-DPT-II1 FROM 1 BY 1 UNTIL HR-DPT-II1 > 999
                OR NID-MST-STATUS NOT = "00"
*> 89.08.29 modify by vivian
                        if nid-mst-rec(300:1) not = "N" then
                                IF HR-DPT-II1 <= 999 THEN
                                        PERFORM F-CLOCK
                                        MOVE HR-DPT-II1 TO HR-DPT-II
                                        INITIALIZE W-DEP-TAB1(HR-DPT-II)
                                        MOVE NID-CODE   TO HR-DEP-TAB1-NO(HR-DPT-II)
                                        MOVE NID-NAME   TO HR-DEP-TAB1-NAME(HR-DPT-II)
                                END-IF
                        else

                                COMPUTE HR-DPT-II1 = HR-DPT-II1 - 1
                        end-if
                        READ NID-MST NEXT RECORD
                        IF NID-ID NOT = "0501"
                                MOVE "99" TO NID-MST-STATUS
                        END-IF
        END-PERFORM.
*>      MOVE 100 TO W-PERCENT.
*>      PERFORM F-LOAD-BAR.
 F-DR-RTN.
*>      INITIALIZE W-PERCENT.
*>      INITIALIZE W-LA-NAME.
*>      MOVE "系統醫師代碼下載中,請稍候 ..."    TO W-LA-NAME.
*>      PERFORM F-LOAD-BAR.
        INITIALIZE W-LA-NAME.
        MOVE "系統醫師代碼下載中,請稍候 ..."    TO W-LA-NAME.

*>START (書伶) 103.04.08
*>START (FISH) 102.12.02 修正醫師代碼載入過久問題。
*>MARK
        INITIALIZE NID-MST-REC.
        MOVE "0503" TO NID-ID.
        START NID-MST KEY IS NOT < NID-MST-KEY.
        READ NID-MST NEXT RECORD.
        PERFORM VARYING HR-DR-II1 FROM 1 BY 1 UNTIL HR-DR-II1 > 5000
                OR NID-MST-STATUS NOT = "00"
                        PERFORM F-CLOCK
                        IF HR-DR-II1 <= 5000 THEN
                                MOVE HR-DR-II1  TO HR-DR-II
                                INITIALIZE W-DR-TAB1(HR-DR-II)
                                MOVE NID-CODE           TO HR-DR-TAB1-NO(HR-DR-II)
                                MOVE NID-NAME           TO HR-DR-TAB1-NAME(HR-DR-II)
                        END-IF
                        READ NID-MST NEXT RECORD
                        IF NID-ID NOT = "0503"
                                MOVE "99" TO NID-MST-STATUS
                        END-IF
        END-PERFORM.


*>      INITIALIZE NID-MST-REC.
*>      INITIALIZE A4GL-WHERE-CONSTRAINT.
*>      STRING  " nid_id = '0503'"
*>              " and substring(nid_rec,59,7) = '0000000'"
*>              DELIMITED BY SIZE INTO A4GL-WHERE-CONSTRAINT
*>      END-STRING.
*>
*>      INSPECT A4GL-WHERE-CONSTRAINT REPLACING TRAILING SPACES
*>              BY LOW-VALUES.
*>      START NID-MST KEY IS NOT < NID-MST-KEY.
*>      INITIALIZE A4GL-WHERE-CONSTRAINT.
*>      READ NID-MST NEXT RECORD.
*>      PERFORM VARYING HR-DR-II1 FROM 1 BY 1 UNTIL HR-DR-II1 > 5000 OR
*>                      NID-MST-STATUS NOT = "00" OR
*>                      NID-ID NOT = "0503"
*>              PERFORM  F-LOAD-BAR
*>              MOVE HR-DR-II1  TO HR-DR-II

*>              INITIALIZE W-DR-TAB1(HR-DR-II)
*>              MOVE NID-CODE   TO HR-DR-TAB1-NO(HR-DR-II)
*>              MOVE NID-NAME   TO HR-DR-TAB1-NAME(HR-DR-II)
*>              READ NID-MST NEXT RECORD
*>      END-PERFORM.
*>102.12.02 END
*>103.04.08 END


*>      MOVE 100 TO W-PERCENT.
*>      PERFORM F-LOAD-BAR.
************************************************************************
*------>開關檔
*COPY    "HR_WAT.PRC".
***********************************************************************
*> 開關檔公用PRC
***********************************************************************
 F-OPEN-MESG.
        INITIALIZE W-LA-NAME.
        MOVE "程 式 開 檔 中.....請 稍 候....." TO W-LA-NAME.
        MOVE "程 式 開 檔 中.....請 稍 候....." TO W-FONT-TITLE.
        INITIALIZE W-PERCENT.
        MOVE "O"        TO W-OPEN-MESG-TYPE.

 F-CLOSE-MESG.
        INITIALIZE W-LA-NAME.
        MOVE "程 式 關 檔 中.....請 稍 候....." TO W-LA-NAME.
        MOVE "程 式 關 檔 中.....請 稍 候....." TO W-FONT-TITLE.
        MOVE 100        TO W-PERCENT.
        MOVE "C"        TO W-OPEN-MESG-TYPE.

 F-WIN-CLOCK.
        DISPLAY Floating WINDOW
                LINES 5.00, SIZE 40.00, CELL HEIGHT 20, CELL WIDTH 10,
                COLOR IS 65793, LABEL-OFFSET 0,
                LINK TO THREAD, NO SCROLL,
                TITLE W-FONT-TITLE, TITLE-BAR, NO WRAP,
                HANDLE IS S-LOAD-FORM-Handle.
*>
        DISPLAY S-LOAD-FORM UPON S-LOAD-FORM-Handle.

 F-CLOSE-WIN-CLOCK.
        IF W-OPEN-MESG-TYPE = "O" OR SPACE THEN
                IF W-PERCENT-ADD = 0 THEN
                        MOVE 99 TO W-PERCENT
                ELSE
                        COMPUTE W-PERCENT = 100 - W-PERCENT-ADD
                END-IF
                PERFORM F-CLOCK
        ELSE
                IF W-PERCENT-ADD = 0 THEN
                        MOVE 1  TO W-PERCENT
                ELSE
                        MOVE W-PERCENT-ADD      TO W-PERCENT
                END-IF
                PERFORM F-BIRD
        END-IF.

*>      隱藏游標 ＣＵＲＳＯＲ　ＯＮ／ＯＦＦ
        SET ENVIRONMENT "CURSOR-MODE"   TO 2.
*>      ACCEPT KEY-STATUS LINE 10 COL 100 BEFORE TIME 10 ON EXCEPTION CONTINUE.
        CALL 'C$SLEEP' USING "0.1".
*>      游標回復
        SET ENVIRONMENT "CURSOR-MODE"   TO 3.
        DESTROY S-LOAD-FORM-Handle.

 F-CLOCK.
        DISPLAY S-LOAD-FOR-La-1.
        PERFORM F-COMPUTE-CLOCK-PERCENT-RTN.
        MOVE W-PERCENT TO W-PERCENT-FMT1.
        MODIFY S-FR-LOAD-BAR,FILL-PERCENT = W-PERCENT,TITLE = W-PERCENT-FMT.

 F-BIRD.
        DISPLAY S-LOAD-FOR-La-1.
        PERFORM F-COMPUTE-CLOCK-PERCENT-RTN.
        MOVE W-PERCENT TO W-PERCENT-FMT1.
        MODIFY S-FR-LOAD-BAR,FILL-PERCENT = W-PERCENT,TITLE = W-PERCENT-FMT.
 F-LOAD-BAR.
        DISPLAY S-LOAD-FOR-La-1.
        PERFORM F-COMPUTE-CLOCK-PERCENT-RTN.
        MOVE W-PERCENT TO W-PERCENT-FMT1.
        MODIFY S-FR-LOAD-BAR,FILL-PERCENT = W-PERCENT,TITLE = W-PERCENT-FMT.

*> 計算百分比
 F-COMPUTE-CLOCK-PERCENT-RTN.
        IF W-OPEN-MESG-TYPE = "O" OR SPACE THEN
                IF W-PERCENT-ADD = 0 THEN
                        ADD 1   TO W-PERCENT
                        IF W-PERCENT > 100 THEN
                                MOVE 1          TO W-PERCENT
                        END-IF
                ELSE
                        ADD W-PERCENT-ADD       TO W-PERCENT
                        IF W-PERCENT > 100 THEN
                                MOVE W-PERCENT-ADD      TO W-PERCENT
                        END-IF
                END-IF
        ELSE
                IF W-PERCENT = 0 THEN
                        MOVE 100        TO W-PERCENT
                END-IF
                IF W-PERCENT-ADD = 0 THEN
                        SUBTRACT 1      FROM W-PERCENT
                ELSE
                        SUBTRACT W-PERCENT-ADD FROM W-PERCENT
                END-IF
        END-IF.
***********************************************************************
*------>錯誤訊息STATUS BAR
*COPY    "HR_NOT.PRC".
***********************************************************************
*> 醫令系統公用警告訊息
***********************************************************************
 F-ERR-NOTE.
        INITIALIZE W-HRMESCF-DATA W-HRMESCF-DATA2.

        MOVE W-NOTE     TO W-HRMESCF-NOTE(1).
        MOVE "2"        TO W-HRMESCF-PIC-TYPE.
        MOVE "3"        TO W-HRMESCF-BUT-TYPE.
        CALL "HRMESCF" USING W-HRMESCF-DATA W-HRMESCF-DATA2 ON EXCEPTION CONTINUE.

 F-ERR-NOTE-2.
        INITIALIZE W-HRMESCF-DATA W-HRMESCF-DATA2.
        MOVE W-NOTE     TO W-HRMESCF-NOTE(1).
        MOVE "2"        TO W-HRMESCF-PIC-TYPE.
        MOVE "3"        TO W-HRMESCF-BUT-TYPE.
        CALL "HRMESCF" USING W-HRMESCF-DATA W-HRMESCF-DATA2 ON EXCEPTION CONTINUE.
 F-ERR-NOTE-8.
        INITIALIZE W-HRMESCF-DATA W-HRMESCF-DATA2.
        MOVE W-NOTE     TO W-HRMESCF-NOTE(1).
        MOVE "2"        TO W-HRMESCF-PIC-TYPE.
        MOVE "3"        TO W-HRMESCF-BUT-TYPE.
        CALL "HRMESCF" USING W-HRMESCF-DATA W-HRMESCF-DATA2 ON EXCEPTION CONTINUE.
***********************************************************************
*COPY    "HR_OICA.PRC".
*
 F-OICA-RTN.
        OPEN    I-O ICA-MST.
        IF      ICA-MST-STATUS = "35" THEN
                OPEN    OUTPUT ICA-MST
                CLOSE   ICA-MST
                OPEN    I-O ICA-MST.
        INITIALIZE ICA-MST-REC.
 F-OICA-EXIT.
        EXIT.
*
*COPY    "HR_OICB.PRC".
*
 F-OICB-RTN.
        OPEN    I-O ICB-MST.
        IF      ICB-MST-STATUS = "35" THEN
                OPEN    OUTPUT ICB-MST
                CLOSE   ICB-MST
                OPEN    I-O ICB-MST.
        INITIALIZE ICB-MST-REC.
 F-OICB-EXIT.
        EXIT.
*
*COPY    "HR_BAR2.PRC".
***********************************************************************
*> STATUS-BAR訊息
***********************************************************************
 F-OK-NOTE.
        PERFORM F-CLEAR-HRSTATUS-RTN.
        MOVE "回應訊息" TO W-HRSTATUS-P1.
        MOVE W-NOTE     TO W-HRSTATUS-P2.
        PERFORM F-DISPLAY-HRSTATUS-RTN.
        CALL "C$SLEEP" USING 1.
        PERFORM F-CLEAR-HRSTATUS-RTN.
 F-WAR-NOTE.
        PERFORM F-CLEAR-HRSTATUS-RTN.
        MOVE "回應訊息" TO W-HRSTATUS-P1.
        MOVE W-NOTE     TO W-HRSTATUS-P2.

        PERFORM F-DISPLAY-HRSTATUS-RTN.
 F-BLANK.
        PERFORM F-CLEAR-HRSTATUS-RTN.

 F-DIS-DEL-MSG.
        INITIALIZE W-NOTE.
        MOVE "資料刪除中....請勿按中斷鍵..." TO W-NOTE.
        PERFORM F-WAR-NOTE.
 F-DIS-WRT-MSG.
        INITIALIZE W-NOTE.
        MOVE "資料存檔中....請勿按中斷鍵..." TO W-NOTE.
        PERFORM F-WAR-NOTE.
***********************************************************************
*> STATUS-BAR
***********************************************************************
 F-CREATE-HRSTATUS-RTN.
        DISPLAY STATUS-BAR
                PANEL-WIDTHS (80),
                PANEL-STYLE (1),
                PANEL-TEXT (W-HRSTATUS-P2),
                GRIP, FONT IS 細明體11,
                HANDLE IS S-HRSTATUS-1-Handle.

 F-DISPLAY-HRSTATUS-RTN.
        MODIFY S-HRSTATUS-1-Handle
                PANEL-WIDTHS (80),
                PANEL-STYLE (1),
                PANEL-TEXT (W-HRSTATUS-P2),
                GRIP, FONT IS 細明體11.

 F-CLEAR-HRSTATUS-RTN.
        INITIALIZE W-HRSTATUS-P1 W-HRSTATUS-P2 W-HRSTATUS-P3 W-HRSTATUS-P4.
        INITIALIZE W-HRSTATUS-P5 W-HRSTATUS-P6 W-HRSTATUS-P7.
        MOVE "回應訊息" TO W-HRSTATUS-P1.
        PERFORM F-DISPLAY-HRSTATUS-RTN.
***********************************************************************
***********************************************************************
*> END OF "HR_RCB1IF.PRC".
***********************************************************************
*{TAMIS}end



