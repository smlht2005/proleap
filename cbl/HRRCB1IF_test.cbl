*{Bench}prg-comment
* HRRCB1IF.cbl
* HRRCB1IF.cbl is generated from C:\AIFL\HRG.DIR\HRRCB1IF.Psf
*{Bench}end
 IDENTIFICATION              DIVISION.
*{Bench}prgid
 PROGRAM-ID. HRRCB1IF.
 AUTHOR. saltyfish.chang.
 DATE-WRITTEN. 2012撟?2??0??銝? 10:05:42.
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
*> 雿銝餅?撱嗡撓瑼?HI_IPX.SEL                          瑼?嚗I_MIPX  *
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
*>      嚗伐戮嚗扎嚗荔憐?嚗?摩嚗堆撕?嚗佗憬嚗穿憧?
*---------------------------------------------------------------------*

*COPY    "HI_ICA.SEL".
* 雿?瑼?
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
* 雿??敦瑼?
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
*> 雿??敦撱嗡撓瑼?
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
*>      雿?萄潭??HI_FON.SEL
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
*>      嚗伐戮嚗扎嚗荔憐?嚗?摩嚗堆撕?嚗佗憬嚗穿憧?
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
*>      雿??啣?閮?瑼HI_GCA.SEL
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
*>      嚗伐戮嚗扎嚗荔憐?嚗?摩嚗堆撕?嚗佗憬嚗穿憧?
*-------------------------------------------------------------------------------
*COPY    "HI_GCB.SEL".
*-------------------------------------------------------------------------------
*>      雿??敦?啣?閮?瑼HI_GCB.SEL      (?信I_ICB.MST, HI_ECB.MST)
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
*>      嚗伐戮嚗扎嚗荔憐?嚗?摩嚗堆撕?嚗佗憬嚗穿憧?
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
* 瑼ａ????瑼?HR_DTA.SEL                          瑼?嚗R_MDTA   *
*---------------------------------------------------------------------*
* 銝鳴?HRDTA-MST-KEY  = HRDTA-KEY                                      *
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
* 瑼ａ???蝝圈?瑼?HR_DTB.MST                          瑼?嚗R_MDTB   *
*---------------------------------------------------------------------*
* 銝鳴?HRDTB-MST-KEY  = HRDTB-KEY + HRDTB-FEE-SEQ                      *

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
*------->瑼ａ?瑼Ｘ?曉?蝺?!
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
* 敺桃??拙?蜓瑼?*
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
* 敺桃??拙???摨?閮?瑼?*
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
* 敺桃??拙??-- KEY?????孵???HT_MVHK ?詨?                                  *
*   ?格??Ⅳ = HTVH1-NO2 = 99999 - HTVHK-NO2                                   *
********************************************************************************
*   >?冽 HTRE10KF, HTRE11KF
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
* 敺桃??拇炎擃?                                                                 *
********************************************************************************
*   >?冽 HTRE10KF, HTRE11KF
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
*   瑼?: 敺桃??拙恕瑼ａ?蝯?銝餅?                                                 *
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
*   瑼?: 敺桃??拙恕??蝝??岫撽?                                             *
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
*> ???賊?瑼?
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
*> 97.7.23 ????
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
*>      ENC-MST 雿ENA-MST 撱嗡撓瑼?

        SELECT  ENC-MST
                ASSIGN TO "HI_MENC"
                WITH    COMPRESSION
                ORGANIZATION INDEXED
                ACCESS  DYNAMIC
                LOCK    MANUAL
                RECORD KEY      ENC-KEY
                ALTERNATE KEY
*>              ?粹蝯董?亥岷雿輻
                ENC-ALT-KEY1 = ENC-IPD-NO ENC-SEG-SEQ-V
                ALTERNATE KEY
*>              瘥??隢狡???湔蝯董雿輻
                ENC-ALT-KEY2 = ENC-END-DT ENC-IPD-NO ENC-SEG-SEQ
                STATUS  IS      ENC-MST-STATUS.
*>
*COPY    "HI_END.SEL".
* 雿蝯董撱嗡撓瑼?ENB撱嗡撓瑼?
        SELECT  HIEND-MST
                ASSIGN TO "HI_MEND"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL
                RECORD KEY   HIEND-KEY
                STATUS  IS HIEND-MST-STATUS.
*> 103.06.27 (?訾撰) 靽格撖阡???仿?甈?霈??皞??寡?RTA?TB??
*COPY    "HI_RTA.SEL".
* ??交??瑼?
        SELECT  RTA-MST
                ASSIGN TO "HI_MRTA"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL
                RECORD KEY   RTA-KEY
                STATUS  RTA-MST-STATUS.
*COPY    "HI_RTB.SEL".
* ??亥??寞?蝝唳?
        SELECT  RTB-MST
                ASSIGN TO "HI_MRTB"
                WITH COMPRESSION
                ORGANIZATION INDEXED
                ACCESS DYNAMIC
                LOCK MANUAL
                RECORD KEY   RTB-KEY
                STATUS  RTB-MST-STATUS.
*> 103.06.27 END
*>2019/12/24 ??IS
*>?芷??撖信R_UDL3
*COPY    "HR_UDL3.SEL".
*
* 雿?思誘[瑼ａ?瑼Ｘ?曉?]?啣?閮?瑼?HR_UDL3.MST
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
*>閮?ICA撖急??航炊蝣墩7]
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
***  隞??蝺函Ⅳ瑼?
***********************************************************
***  NID-MST-KEY  = NID-ID + NID-CODE
***  NID-ALT-KEY1 = NID-ID + NID-NAME + NID-CODE
***  NID-ALT-KEY2 = NID-ID + NID-TRN  + NID-CODE
***********************************************************
 FD  NID-MST EXTERNAL .
 01 NID-MST-REC.
 02 NID-MST-KEY.
* 隞??霅
*
 03 NID-ID           PIC  X(04).
* 隞??蝺函Ⅳ
*
 03 NID-CODE         PIC  X(20).
* 撠?隞??
*
 02 NID-TRN          PIC  X(20).
* 隞???迂
*

 02 NID-NAME         PIC  X(24).
*XFD USE GROUP , VAR-LENGTH
* ?閮剖?
*
 02 NID-REC          PIC  X(232).
***********************************************************
*COPY    "HH_PAT.MST".
*---------------------------------------------------------------------*
* ??箸鞈?瑼?: HH_PAT.MST   SIZE = 520            瑼?嚗H_MPAT   *
*---------------------------------------------------------------------*
* 銝鳴?PAT-NO                                                          *
* ?荔?PAT-ALT-KEY1 = PAT-NAME + PAT-BIRTH-DT + PAT-NO                 *
* ?荔?PAT-ALT-KEY2 = PAT-IDNO + PAT-NO                                *
*---------------------------------------------------------------------*
*
 FD      PAT-MST         EXTERNAL.
 01      PAT-MST-REC.
* ?風?Ⅳ
        02      PAT-NO                                  PIC 9(08).
* 頨思遢閮潸?
        02      PAT-IDNO                                PIC X(10).
* 憪?
        02      PAT-NAME                                PIC X(12).
* ?箇???
        02      PAT-BIRTH-DT                            PIC S9(07).
* PAT-MST GROUP 1 ... 250 BYTE...
*$XFD USE GROUP
        02      PAT-DATA-1.
*> ?批 [1]??[2]憟?                            (01:01)
                03      PAT-SEX                         PIC X(01).
*> 銵??                                        (02:02)
                03      PAT-BLO                         PIC X(02).
*> RH??                                        (04:01)
                03      PAT-RH                          PIC X(01).
*> 頨思遢隞?Ⅳ                                     (05:04)
                03      PAT-CLA                         PIC X(04).
*> 靽?怎?霅?                                 (09:12)
                03      PAT-INS-NO                      PIC X(12).
*> 閬?璈??桐???                              (21:10)
                03      PAT-INS-CD                      PIC X(10).
*> ?賜?甈⊥                                     (31:02)
                03      PAT-BRK-TIS                     PIC 9(02).
*> ?賜?????                                  (33:07)
                03      PAT-BRK-BDT                     PIC 9(07).
*> ?賜???甈曇?蝵啁?甇Ｘ??                      (40:07)
                03      PAT-BRK-EDT                     PIC 9(07).
*> 甈狡??                                     (47:07)
                03      PAT-UNR-AMT                     PIC 9(07).
*> ?駁??誨蝣?                                  (54:08)
                03      PAT-USR-ID                      PIC X(08).
*> ?澈隞賭誨蝣?                                (62:04)
                03      PAT-PT-MRGE                     PIC X(04).
*> 憍宏隞?Ⅳ                                     (66:01)
                03      PAT-MARITAL                     PIC X(01).
*> ?望仿鈭?                                  (67:08)
                03      PAT-TUH-NM                      PIC X(08).
*> ?望仿鈭箄??犖??                         (75:04)

                03      PAT-TUH-RE                      PIC X(04).
*> ?望仿鈭粹?窗?餉店(摰?                       (79:10)
                03      PAT-TUH-TEL                     PIC X(10).
*> ?瑟平隞?Ⅳ                                     (89:03)
                03      PAT-JOB                         PIC X(03).
*> ?蝔漲隞?Ⅳ                                 (92:02)
                03      PAT-EDU                         PIC X(02).
*> ?菟????                                    (94:05)
                03      PAT-MAIL                        PIC X(05).
*> 蝐疵隞?Ⅳ                                     (99:03)
                03      PAT-NATIVE                      PIC X(03).
*> ?餉店(摰? (銝)                                (102:10)
                03      PAT-TEL1                        PIC X(10).
*> ?餉店(?? (鈭?                                (112:10)
                03      PAT-TEL2                        PIC X(10).
*> 撅??啣?隞?Ⅳ                                 (122:07)
                03      PAT-LIVE                        PIC X(07).
*> ??啣?                                     (129:40)
                03      PAT-ADDR                        PIC X(40).
*> 摰園憪?                                     (169:08)
                03      PAT-PA-NAME                     PIC X(08).
*> 摰園?桐?隞?Ⅳ                                 (177:05)
                03      PAT-PA-UNIT                     PIC X(05).
*> ???交? (??????                        (182:07)
                03      PAT-INSU-DT                     PIC 9(07).
*> ?那??                                      (189:07)
                03      PAT-ODT-IST                     PIC 9(07).
*> ?那蝘隞?Ⅳ                                 (196:04)
                03      PAT-ODPT-IST                    PIC X(04).
*> ?餈停閮箸??                                (200:07)
                03      PAT-ODT-LST                     PIC 9(07).
*> ?餈停閮箇??乩誨蝣?                            (207:04)
                03      PAT-ODPT-LST                    PIC X(04).
*> ?活雿??                                  (211:07)
                03      PAT-IDT-IST                     PIC 9(07).
*> ?餈?Ｘ                                   (218:07)
                03      PAT-IOUT-LST                    PIC 9(07).
*> ?餈??Ｙ??乩誨蝣?                            (225:04)
                03      PAT-IDPT-LST                    PIC X(04).
*----------------------------------------------------------------------*
* 雿銝餅?嚗?餈?xxxx  嚗雿銝餅??芷??嚗迨甈?閬????神??雿葉 *
*----------------------------------------------------------------------*
                03      PAT-IKEY-LST.
*>     雿銝餅?嚗?餈??Ｘ                     (229:07)
                        04      PAT-IDT-LST             PIC 9(07).
*>     雿銝餅?嚗?餈??Ｘ雿摨?             (236:04)
                        04      PAT-ISEQ-LST            PIC 9(04).
*----------------------------------------------------------------------*
* ?仿雿平嚗?餈?xxxx  嚗雿銝餅??芷??嚗迨甈?銝?隞颱??湔??     *
*----------------------------------------------------------------------*
                03      PAT-EKEY-LST.
*>     ?仿雿平嚗?餈??Ｘ                     (240:07)
                        04      PAT-EDT-LST             PIC 9(07).
*>     ?仿雿平嚗?餈??Ｘ雿摨?             (247:04)
                        04      PAT-ESEQ-LST            PIC 9(04).
* PAT-MST GROUP 2 ... 233 BYTE...
*$XFD USE GROUP , VAR-LENGTH

        02      PAT-DATA-2.
*> ?餈?瘣餃??風                               (01:05)
                03      PAT-NON-YYMM                    PIC 9(05).
*> ?風雿蔭 - OCCURS 1嚗?甈∩?蝵?/ OCCURS 2嚗??蝵?  (06:100)
                03      PAT-CHG-STA.
                        04      PAT-CHG-POS OCCURS 2 TIMES.
*     ?啣?蝣?[1]? [2]?閮?[3]雿
                                05      PAT-CHG-CODE    PIC X(01).
*     ?啣???
                                05      PAT-CHG-DT      PIC 9(07).
*     ?啣???
                                05      PAT-CHG-TI      PIC 9(06).
*     ?啣?鈭箔誨蝣?
                                05      PAT-CHG-EMP     PIC X(08).
*     ?啣??桐?隞?Ⅳ (9991-??嚗?992-?芸??? 9993-?曄?)
                                05      PAT-CHG-DPT     PIC X(05).
*     ?那?交?
                                05      PAT-CHG-CDT     PIC 9(07).
*     ?摨?
                                05      PAT-CHG-WARD    PIC X(06).
*     ?隞?Ⅳ
                                05      PAT-CHG-TURN    PIC X(01).
*     閮粹?隞?Ⅳ
                                05      PAT-CHG-ROOM    PIC X(02).
*     甇賊???
                                05      PAT-CHG-ACDT    PIC 9(07).
*> ?粹?風瘚?雿蔭 [2]?? [3]?芸? [4]?曄?     (106:01)
                03      PAT-FLO-ID                      PIC X(01).
*> ?粹?風瘚??桐?隞?Ⅳ                         (107:06)
                03      PAT-FLO-CODE                    PIC X(06).
*> ?芸??風?粹??                              (113:07)
                03      PAT-FLO-DT                      PIC 9(07).
*> 撱箸???                                      (120:07)
                03      PAT-CRE-DT                      PIC 9(07).
*> ?酉                                         (127:34)
                03      PAT-REMARK                      PIC X(34).
*> ?那?芣:[Y]                                 (161:01)
                03      PAT-FST-REG                     PIC X(01).
*> ?啁?甇瑁?蝣?                                  (162:08)
                03      PAT-NEW-NO                      PIC 9(08).
*> ???1                                    (170:02)
                03      PAT-STOP-RN                     PIC X(02).
*> ?∠                                         (172:12)
                03      PAT-STAF-NM                     PIC X(12).
*> ?臬甇颱滿:[Y]                                 (184:01)
                03      PAT-DIE                         PIC X(01).
*> ?餈停閮箏靽???                            (185:04)
                03      PAT-INS-CAR                     PIC X(04).
*> ?餈停閮箏?銝???乩?摨?                     (189:04)
                03      PAT-INS-PRC                     PIC X(04).
*> ?????餈停閮箸??                        (193:07)
                03      PAT-PRC-LST                     PIC X(07).
*> ?臬瑼Ｘ?炎撽?                              (200:01)
                03      PAT-X-CHK                       PIC X(01).
*> ??隞?Ⅳ                                     (201:02)
                03      PAT-LEVEL                       PIC X(02).
*> ?嗅?霅?                                     (203:08)

                03      PAT-OTHER-ID                    PIC X(08).
*> ?隡??                                    (211:07)
                03      PAT-RETIRED                     PIC 9(07).
*> 頠車 86/12/8                                 (218:01)
                03      PAT-ADD                         PIC X(01).
                03      PAT-A-ADD       REDEFINES PAT-ADD.
                        04      PAT-A-KIND              PIC X(01).
*> ?刻??瑼?                                  (219:01)
                03      PAT-SEN                         PIC X(01).
*> ??閮?                                     (220:01)
                03      PAT-ANO-YN                      PIC X(01).
*> 撠梯那?孵? [1]?閮?[2]?亥那                     (221:02)
                03      PAT-CHG-WAY     OCCURS 2 TIMES.
                        04      PAT-OPD-WAY             PIC X(01).
*> 皜祈岫?風 [Y]                                 (223:01)
                03      PAT-TEST-YN                     PIC X(01).
*> ? [1]?砍? [2]憭?                         (224:01)
                03      PAT-ORIG                        PIC X(01).
*> ?那撠梯那?孵? [1]? [2]??                    (225:01)
                03      PAT-FIS-WAY                     PIC X(01).
*> ?風?Ｗ?蝣?                                  (226:1)
                03      PAT-HID                         PIC X(01).
*> ?風雿蔭?酉                                 (227:01)
                03      PAT-PS                          PIC X(01).
*> ?啣虜?風?酉 (Y)?啣虜                         (228:01)
                03      PAT-UNNOR                       PIC X(01).
*> ???2                                    (229:02)
                03      PAT-STOP-RN2                    PIC X(02).
*> ??-[??甇瑕歇?瑟?]閮餉?-95/07/17             (231:01)
                03      PAT-OBD-YN                      PIC X(01).
*> 銵?蝵脤?Ｙ???犖?ａ??風?亥岷???詨??啗酉閮?98/05/14(232:01)
                03      PAT-HROWN1PF-YN                 PIC X(01).
*
                03      PAT-FILLER                      PIC X(01).

***     [920730]
*****   THE     END
*COPY    "HI_IPD.MST".
*---------------------------------------------------------------------*
* 雿銝餅?嚗I_IPD.MST             SIZE 465           瑼?嚗I_MIPD   *
*---------------------------------------------------------------------*
* 銝鳴?IPD-MST-KEY  = IPD-NO                                           *
* ?荔?IPD-ALT-KEY1 = IPD-PAT-NO IPD-NO                                *
* ?荔?IPD-ALT-KEY2 = IPD-LEAVE-DT + IPD-PAT-NO + IPD-NO               *
* ?荔?IPD-ALT-KEY3 = IPD-LEAVE-DT + IPD-NAME   + IPD-NO               *
* ?荔?IPD-ALT-KEY4 = IPD-LEAVE-DT + IPD-BED    + IPD-NO               *
* ?荔?IPD-ALT-KEY5 = IPD-LEAVE-DT + IPD-DPT    + IPD-NO               *
* ?荔?IPD-ALT-KEY6 = IPD-LEAVE-DT + IPD-MJ-DR  + IPD-NO               *
* ?荔?IPD-ALT-KEY7 = IPD-PAT-NO + IPD-OUT-DT + IPD-NO                 *
* ?荔?IPD-ALT-KEY8 = IPD-OUT-DT + IPD-NO                              *
* ?荔?IPD-ALT-KEY9 = IPD-OUT-DT + IPD-PAT-NO + IPD-NO                 *
* ?荔?IPD-ALT-KEY10= IPD-OUT-DT + IPD-BED    + IPD-NO                 *
* ?荔?IPD-ALT-KEY11= IPD-CASE + IPD-DPT + IPD-OUT-DT                  *
*                    IPD-NO + IPD-ASK-SEQ                             *
* ?荔?IPD-ALT-KEY12= IPD-OUT-DT + IPD-UNIT + IPD-NO                   *
*---------------------------------------------------------------------*
**** 嚗殷摩嚗湛憧嚗?

*
* ?亥?蝣箏??犖?臬??恍嚗???IPD-LEAVE-DT 靘?伐?? IPD-OUT-DT
* ??賡??撓?? 靘?嚗??予閬?Ｙ??犖嚗???齒?粹?? (甇斗?
* IPD-OUT-DT  撠梯撓?亙潔?)
*
***********************************************************************
 FD      IPD-MST         EXTERNAL.
 01      IPD-MST-REC.
*$XFD USE GROUP
* 雿摨?
        02      IPD-NO.
*     雿?交?
                03      IPD-DT                          PIC 9(07).
*     雿瘚偌??
                03      IPD-SEQ                         PIC 9(04).
* ?風?Ⅳ
        02      IPD-PAT-NO                              PIC 9(08).
* 憪?
        02      IPD-NAME                                PIC X(12).
* 雿??
        02      IPD-TIME                                PIC 9(06).
*$XFD USE GROUP , VAR-LENGTH
* ?摨?
        02      IPD-BED.
*     ?
                03      IPD-BED-ROOM                    PIC X(04).
*     摨?
                03      IPD-BED-NO                      PIC X(02).
* 蝘隞?Ⅳ
        02      IPD-DPT                                 PIC X(04).
* 銝餅祥?怠葦隞?Ⅳ
        02      IPD-MJ-DR                               PIC X(04).
* ?桐?隞?Ⅳ (霅瑞?蝡?
        02      IPD-UNIT                                PIC X(05).
* 獢辣??隞?Ⅳ
        02      IPD-CASE                                PIC X(01).
* 撖阡??粹?交?
        02      IPD-OUT-DT                              PIC 9(07).
* 撖阡??ａ?交?
        02      IPD-LEAVE-DT                            PIC 9(07).
* ?喳瘚偌蝺刻? UPDATE 84.10.04
        02      IPD-ASK-SEQ                             PIC 9(06).
*
*$XFD USE GROUP , VAR-LENGTH
        02      IPD-GROUP1.
*
* 雿?怠葦隞?Ⅳ  (1:4)
                03      IPD-RD-DR                       PIC X(04).
* ?隞?Ⅳ      (5:4)
                03      IPD-DIV                         PIC X(04).
* 頨思遢隞?Ⅳ      (9:4)
                03      IPD-A-CLA                       PIC X(04).
* ?澈隞賭誨蝣? (13:4)
                03      IPD-B-CLA                       PIC X(04).
* ?撟湧翩      (17:3)
                03      IPD-AGE                         PIC 9(03).
*==================*

* ?冽??乩??啣?鞈? *
*==================*
* 蝯虫?憿隞?Ⅳ  (20:1)
                03      IPD-DZS-CHR                     PIC X(01).
* DRG蝣?        (21:5)
                03      IPD-DRG                         PIC X(05).
* ?典?鞎?隞?Ⅳ  (26:3)
                03      IPD-PART                        PIC X(03).
* ?靘?隞?Ⅳ  (29:1)
                03      IPD-FROM                        PIC X(01).
* 頧那?恍隞?Ⅳ  (30:10)
                03      IPD-FRM-HOSP                    PIC X(10).
* ?乩??∟? ( REPL-CE BY 雿?銵典???+ ?喲? 87.05.29)   (40:10)
                03      IPD-LB-NO                       PIC X(10).
                03      IPD-LB-NO-R REDEFINES IPD-LB-NO.
*>                      ?喲??
                        04      IPD-SEND-DT             PIC 9(07).
                        04      IPD-SEND-HR             PIC 9(02).
*>                      Y 銵刻身摰?憿舐內?潔??Ｘ閰Ｚ”
                        04      IPD-HIDDEN-YN           PIC X(01).
* ?乩??∪停?怠???(50:4)
                03      IPD-INS-NO                      PIC X(04).
* 鈭日???[N]  (54:1)
                03      IPD-TRAFFIC                     PIC X(01).
* ?粹頧飛隞?Ⅳ  (55:1)
                03      IPD-OUT-RES                     PIC X(01).
* 靽?怎?霅?  ( REPL-CE BY ?蔥銋??Ｗ???87.05.29)   (56:12)
                03      IPD-INS-NUM                     PIC X(12).
                03      IPD-INS-NUM-R REDEFINES IPD-INS-NUM.
*>                      ?蔥銋??Ｗ???
                        04      IPD-COM-NO.
                                05      IPD-COM-DT      PIC 9(07).
                                05      IPD-COM-SEQ     PIC 9(04).
*>                      ??臬頛詨?喳韏瑁????..UPDATED BY 蝧? 88.10.18
                        04      IPD-BIR-APP             PIC X(01).
* 閬?璈??桐???(68:10)
                03      IPD-INS-CD                      PIC X(10).
*------------------------------------------------------------------*
* 雿閮箸隞?Ⅳ 1 (78:7)
                03      IPD-IDZS1                       PIC X(07).
* 雿閮箸隞?Ⅳ 2 (85:7)
                03      IPD-IDZS2                       PIC X(07).
* 雿閮箸隞?Ⅳ 3 (92:7)
                03      IPD-IDZS3                       PIC X(07).
* 雿閮箸隞?Ⅳ 4 (99:7)
                03      IPD-IDZS4                       PIC X(07).
* 雿閮箸隞?Ⅳ 5 (106:7)
                03      IPD-IDZS5                       PIC X(07).
* 憭??隞?Ⅳ 1 (113:7)
                03      IPD-PH-DZS1                     PIC X(07).
* 憭??隞?Ⅳ 2 (120:7)
                03      IPD-PH-DZS2                     PIC X(07).
* ?粹閮箸隞?Ⅳ 1 (127:7)
                03      IPD-ODZS1                       PIC X(07).
* ?粹閮箸隞?Ⅳ 2 (134:7)
                03      IPD-ODZS2                       PIC X(07).
* ?粹閮箸隞?Ⅳ 3 (141:7)

                03      IPD-ODZS3                       PIC X(07).
* ?粹閮箸隞?Ⅳ 4 (148:7)
                03      IPD-ODZS4                       PIC X(07).
* ?粹閮箸隞?Ⅳ 5 (155:7)
                03      IPD-ODZS5                       PIC X(07).
* ?活雿摨?   (162:11)
                03      IPD-NO-L.
                        04      IPD-DT-L                PIC 9(07).
                        04      IPD-SEQ-L               PIC 9(04).
* ??隞?Ⅳ ( ICD-9-CM)  (173:35)
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
* ?蔥雿憭拇
                03      IPD-TOTAL-DAY.
*         蝝航??交抒??踹予??(1:3)
                        04      IPD-ACUTE-TOTAL         PIC 9(03).
*         蝝航??Ｘ抒??踹予??(4:3)
                        04      IPD-CHRO-TOTAL          PIC 9(03).
*         蝝航??其遢鞎???  .. UPDATE 84.10.23  (7:9)
                        04      IPD-TOT-PART-AMT        PIC S9(07)V99.
* ?嗆活雿憭拇
                03      IPD-CURRENT-DAY.
*         ?嗆活雿?交抒??踹予??(16:3)
                        04      IPD-ACUTE-DAY           PIC 9(03).
*         ?嗆活雿?Ｘ抒??踹予??(19:3)
                        04      IPD-CHRO-DAY            PIC 9(03).
*         ?嗆活雿?其遢鞎??? .. UPDATE 84.10.23  (22:9)
                        04      IPD-CUR-PART-AMT        PIC S9(07)V99.
* ?董?? 雿?孵鞈? ==> 撌脩?雿?孵鞈? ) UPDATE 84.10.04  (31:3)
                03      IPD-TRN-MARK                    PIC X.
                03      IPD-F01-AMT-YN                  PIC X.
                03      IPD-OC-END-YN                   PIC X.
* ?餈蝯?? (34:7)
                03      IPD-DAY-DT                      PIC 9(07).
* 撖阡??粹??  (41:6)
                03      IPD-OUT-TI                      PIC 9(06).
*> 撖阡??ａ??
*>              03      IPD-LEAVE-TI                    PIC 9(06).
* 雿霅  (A.??雿 B.霅瑞?銋振 C.?仿??扯風 X.銝雿輻) (47,1)
                03      IPD-LIVE-ID                     PIC X(01).
* ?活頧飛隞?Ⅳ  (48:1)
                03      IPD-EX-OUT-RES                  PIC X(01).
* 雿?蔥?孵? ( 1. 銝?砍?雿?2.?典??蔥 )(49:1)
                03      IPD-COM-WAY                     PIC X(01).
* 雿?蔥?? ( 蝛箇銵其誑 IPD-NO ?喳 , R 隞亙?雿萎??Ｗ????) (50:1)
                03      IPD-COM-ORDER                   PIC X(01).
* ?臬雿?憿?蝯??澆?Ｙ?撣喳祟?? <雿?思誘?芷雿?蔭> (51:1)

                03      IPD-AMV-YN                      PIC X(01).
* ?臬雿澈隞質岫蝞??澆?Ｙ?撣喳祟?? <雿?思誘靽格雿閮箸> (52:1)
                03      IPD-DEN-YN                      PIC X(01).
* 璅?雿??(53:6)
                03      IPD-STD-DAYS                    PIC 9(06).
* ??Ｘ??(59:7)
                03      IPD-STD-DT                      PIC 9(07).
* 撖阡?雿??(66:7)
                03      IPD-UD-DT                       PIC 9(07).
* ?敺?憌祥?冽 (73:7)
                03      IPD-UD-DATE                     PIC 9(07).
* ?曄??駁?蝣?(80:1)
                03      IPD-MARK                        PIC X(01).
* 摨??啣??交? (81:7)
                03      IPD-BED-DT                      PIC 9(07).
*> 摨??啣??? UPDATE BY SMHTP 880910
*>              03      IPD-BED-TIME                    PIC 9(06).
*> 雿?銵函?望?瘞渲?(?誨IPD-BED-TIME) (88:6)
                03      IPD-NOT-SEQ                     PIC 9(06).
* ?啣?鈭箔誨蝣?(94:5)
                03      IPD-UID                         PIC X(05).
* 撱箸??交? (99:7)
                03      IPD-CRE-DT                      PIC 9(07).
* 撱箸??? (106:6)
                03      IPD-CRE-TIME                    PIC 9(06).
* ?酉
                03      IPD-FILLER                      PIC X(70).
                03      IPD-REF-DATA            REDEFINES IPD-FILLER.
*?孵?CASE : 1.?芰?(????  2.??(????  3.?詨祕?喳
*           A.蝎曄?蝘????   B.?交扯銵蝞∠??C.頨思遢霈?隞質?????X.?董  (112:1)
                        04 IPD-CASE-MARK                PIC X.
*?喳????(113:7)
                        04 IPD-APY-STRDT-R                          PIC X(7).
                        04 IPD-APY-STRDT REDEFINES IPD-APY-STRDT-R  PIC 9(7).
*?喳蝯???(120:7)
                        04 IPD-APY-ENDDT-R                          PIC X(7).
                        04 IPD-APY-ENDDT REDEFINES IPD-APY-ENDDT-R  PIC 9(7).
*?隞質???摰?憪  (127:7)
                        04 IPD-CHS-STRDT-R                          PIC X(7).
                        04 IPD-CHS-STRDT REDEFINES IPD-CHS-STRDT-R  PIC 9(7).
*?隞質???摰?? (134:7)
                        04 IPD-CHS-ENDDT-R                          PIC X(7).
                        04 IPD-CHS-ENDDT REDEFINES IPD-CHS-ENDDT-R  PIC 9(7).
*?隞質??誨蝣?(141:3)
                        04 IPD-CHS-PART                             PIC X(3).
*??雿??(144:7)
                        04 IPD-ORG-DT-R                             PIC X(7).
                        04 IPD-ORIGINAL-DT REDEFINES IPD-ORG-DT-R   PIC 9(7).
*?孵??亙??典?? Y (151:13)
                        04 IPD-RTB-DRAG                             PIC X.
                        04 IPD-APP-DATA-R                           PIC X(12).
*?喳?遢,?,瘚偌??
                        04 IPD-APP-DATA   REDEFINES IPD-APP-DATA-R.
                             06 IPD-APP-DTE                         PIC 9(5).
                             06 IPD-APP-VER                         PIC 9(3).
                             06 IPD-APP-SEQ                         PIC 9(4).
*?孵雿輻?活蝯董Y (164:1)

                        04 IPD-NEW-SEG                              PIC X.
*>      89/10/27        IPD-APY-LOCK ?誨 IPD-APP-UNLOCK
*>      IPD-APY-LOCK ( Y 銵典歇雿?梯?瑼?N 銵其??喳)  (165:1)
*>                      04 IPD-APP-UNLOCK                           PIC X.
                        04 IPD-APY-LOCK                             PIC X.
*?閮箄?雿銋?閮箏???(166:11)
                        04 IPD-REG-NO                               PIC X(11).
*?臬雿輻IPD-UD-DT?箏祕???Ｘ (177:1)
                        04 IPD-REAL-YN                              PIC X(1).
*?臬雿輻?啁?蝯董摨?(178:1)
                        04 IPD-NEW-IPP                              PIC X(1).
*甈∪?蝘?179:2)
                        04 IPD-SUB-DPT                              PIC X(2).

*>      90/02/19 IPD-TRN-TYPE ?寞? IPD-NEWBORN-YN
*>      ??蝢抬??閮箄?雿?孵? (1.?乩? 頧??乩? 2.?芾祥 頧??乩?)
*>      ?啣?蝢抬??啁??酉閮?(181:1)
*>                      04 IPD-TRN-TYPE                             PIC X(1).
                        04 IPD-NEWBORN-YN                           PIC X(1).



*****
***** THE END

*COPY    "HI_IPX.MST".
*---------------------------------------------------------------------*
*> 雿銝餅?撱嗡撓瑼?HI_IPX.MST         SIZE   652       瑼?嚗I_MIPX  *
*---------------------------------------------------------------------*
*> 銝鳴?IPX-MST-KEY  = IPX-LIVE-ID + IPX-NO
*      ?桃?嚗?IPD-MST 雿??銋??
*> ?荔?IPX-ALT-KEY1 = IPX-LIVE-ID + IPX-DT + IPX-NO
*      ?桃?嚗誑雿?交?蝯梯?
*> ?荔?IPX-ALT-KEY2 = IPX-LIVE-ID + IPX-OUT-DT + IPX-DT   + IPX-NO
*      ?桃?嚗誑?粹?交?蝯梯?
*> ?荔?IPX-ALT-KEY3 = IPX-LIVE-ID + IPX-PAT-NO + IPX-DT-V + IPX-NO-V
*      ?桃?嚗???餈?雿鞈?
*> ?荔?IPX-ALT-KEY4 = IPX-LIVE-ID + IPX-ALT-1  + IPX-NO
*      ?桃?嚗洵銝???沛EY
*> ?荔?IPX-ALT-KEY5 = IPX-LIVE-ID + IPX-ALT-2  + IPX-NO
*      ?桃?嚗洵鈭??沛EY
*---------------------------------------------------------------------*
*>      911218          ?敺???撣單??
*>      2003/6/2        ?ａ?孵?(鈭日極??
*>      2003/11/26      ?啣?鞈?
*>      2003/12/18      靘?撠梢
*>      2005/3/2        隞晶鈭?
*>      2005/7/6        IC??銝?批?閮?
*>      2005/10/29      頝券?頧????- 頧?Ｗ?隞?Ⅳ
*>      2006/12/13      雿獢辣??(???PD-CASE)
*>      2007/9/7        撖虫??怠葦
*>      2007/9/20       DRG閮餉?
*>      0961115         ?啣之??恍
*>      2008/3/27       DRG霅
*>      2008/6/12       ??臬?箄楊?Ｗ?頧? ???瘙?- ?旨
*>      2009/1/12       憓?銝剛正?怨???Ｘ?雿?- ?旨
*>      2009/5/12       (J0900683)憓??脣?IC?∟澈??雿????瘙?- ?箏?

*>      2009/6/24       (J0900969)??恍雿?唾?嚗????嗅頛詨甈? - ?箏?
*>      2009/7/13       ?啣?閮???隞嗅?憿誨蝣?- ?旨
*>      2009/8/3        憓????粹??甈? - ?箏?
*>      2009/10/14      (0902064)憓?1.??芸??亦?臬甇賊?2.??啁拳?瑁??交?虫漱??雿?- ?箏?
*>      2009/11/19      "A"憓?DRG ECMO?酉閮?- ?旨
*>      2009/12/30      "A"靽格??IPX-CASE-ORI 嚗?雿輻嚗靘?活雿輻 - ?箏?
*>      2010/1/13       (IPX-GROUP-2-IPD)憓??仿?董靘????交?雿?- ?箏?
*>      2010/3/5        ??ECMO甈???NO-DRG-MARK ?孵? "F" ??"G"  - ?箏?
*>      2010/4/2        (?啣?)?Ｗ?(?之)?恍?頧霅閮餉?
*>      2012/06/14      憓?隢狡?桐?(???? - ?
*>      2012/06/14      頧??璈?隞?Ⅳ - ?
*>      2013/10/23      (?貉?)?ａ?蝯?霅 - ?訾撰
*>      2013/12/03      (??)?粹頧飛????憓?頧璈車霅(1.頠???.?湔?璈?.瘞璈? - ?訾撰
*>      2014/01/10      ??103撟???勗?擃??憓???????怒誨蝣?- ?訾撰
*>      2016/11/22      憓?NIS撠雿摨? 銝
*>      2021/06/21      敶亙遠 憓??∪靽酉閮?
*---------------------------------------------------------------------*
 FD IPX-MST EXTERNAL.
 01 IPX-MST-REC.
*> 雿霅 ??A.??雿 B.霅瑞?銋振 C.?仿??扯風 X.?舐鼠?芣獢???
*>          ??a.?芷??雿 b.?芷霅瑞?銋振 c.?芷?仿??扯風  ??
        02 IPX-LIVE-ID                                  PIC X(01).

*$XFD USE GROUP
*>      雿摨?
        02 IPX-NO.
                03 IPX-SYS-DT                           PIC 9(07).
                03 IPX-SYS-SEQ                          PIC 9(04).
*>      ?風?Ⅳ
        02 IPX-PAT-NO                                   PIC 9(08).
*>      雿??
        02 IPX-DT                                       PIC 9(07).
*>      ?粹?交?
        02 IPX-OUT-DT                                   PIC 9(07).

*$XFD USE GROUP , VAR-LENGTH
*>      蝚砌???萄?
        02 IPX-ALT-1                                    PIC X(50).
*>      IPD-LIVE-ID = "X" ??霅瑞?銋振)?舐鼠?芣獢?
        02 IPX-ALT-REG REDEFINES IPX-ALT-1.
*>      憪?
        03 IPX-TOUCH-NAME                               PIC X(12).
*>      ?箇??交?
        03 IPX-TOUCH-BIRTH-DT                           PIC S9(07).
        03 IPX-TOUCH-REC                                PIC X(31).

*$XFD USE GROUP , VAR-LENGTH
*>      蝚砌???萄?
        02 IPX-ALT-2                                    PIC X(50).

*$XFD USE GROUP
*>      隞交?憭批潸????Ｗ??祕???Ｘ?皜??? ?箔蝙鞈?敺?餈?蝑?憪???
*>      雿摨???KEY
        02 IPX-NO-V.
                03 IPX-SYS-DT-V                         PIC 9(07).
                03 IPX-SYS-SEQ-V                        PIC 9(04).
*>      撖阡?雿?亙?KEY

        02 IPX-DT-V                                     PIC 9(07).

*$XFD USE GROUP , VAR-LENGTH
        02 IPX-GROUP-1                                  PIC X(250).

*>      IPD-LIVE-ID = "A" ?????Ｕ?
        02 IPX-GROUP-1-A        REDEFINES IPX-GROUP-1.
*>              頨恍? (cm)                               (1:4)
                03 IPX-HEIGHT                           PIC 9(03)V9.
*>              擃? (kg)                               (5:4)
                03 IPX-WEIGHT                           PIC 9(03)V9.
*>              ?粹皞????嗆?(1.蝟倏??2.?Ｘ抒?)     (9:1)
                03 IPX-OUT-SRV                          PIC X(01).
*>              瘥扛?風????,?嫣誑PA2-PA-NO)          (10:8)
                03 IPX-MOM-PAT-NO                       PIC 9(08).
*>              ?啁??(??,?嫣誑IPD-NEWBORN-YN?箔蜓)   (18:1)
                03 IPX-NEWBORN-YN                       PIC X(01).
*>              Case Mix Index 銋?DRG                   (19:5)
                03 IPX-CMI-DRG                          PIC X(05).
*>              CMI-DRG 甈???                         (24:1)
                03 IPX-CMI-WGT                          PIC X(01).
*>              閮?批??                             (25:1)
                03 IPX-RE-IN                            PIC X(01).
*>              ?蔥雿摨??撅祇?嚗  ]銵典??Ｗ?      (26:2)
                03 IPX-COM-THID                         PIC X(02).
*>              ???其??典?頝臬?                      (28:5)
                03 IPX-DRG-SET                          PIC X(05).
*>              ?臬頝唾甇方摨楝敺?[Y]銵典歇頝唾         (33:1)
                03 IPX-DRG-SET-OFF                      PIC X(01).
*>              Case Mix Index(雿??蝯?) 銋?DRG ?撅祉? MDC          (34:2)
                03 IPX-DRG-MDC                          PIC X(02).
*>              DRGs 甈???- RW (Relative weight) ??蝯??詨???      (36:6)
                03 IPX-DRG-RW                           PIC 9(02)V9(04).
*>              雿閮箸隞?Ⅳ 6                          (42:7)
                03 IPX-IDZS6                            PIC X(07).
*>              雿閮箸隞?Ⅳ 7                          (49:7)
                03 IPX-IDZS7                            PIC X(07).
*>              雿閮箸隞?Ⅳ 8                          (56:7)
                03 IPX-IDZS8                            PIC X(07).
*>              雿閮箸隞?Ⅳ 9                          (63:7)
                03 IPX-IDZS9                            PIC X(07).
*>              雿閮箸隞?Ⅳ 10                         (70:7)
                03 IPX-IDZS10                           PIC X(07).

*>              ??隞?Ⅳ ( ICD-9-CM)                    (77:35)
                03 IPX-OPP-GRP.
                        04 IPX-OPP-ICD6                 PIC X(07).
                        04 IPX-OPP-ICD7                 PIC X(07).
                        04 IPX-OPP-ICD8                 PIC X(07).
                        04 IPX-OPP-ICD9                 PIC X(07).
                        04 IPX-OPP-ICD10                PIC X(07).
                03 IPX-OPP-TBL  REDEFINES IPX-OPP-GRP.
                        04 IPX-ICD      OCCURS 5  TIMES PIC X(07).

*>              2005/10/29 頝券?頧????
*>              頧?Ｗ?隞?Ⅳ(?閬??圈銝??)      (112:2)
                03 IPX-OUT-HOP                          PIC X(02).

*>              DRGs ?憭拇閮剖?嚗 ]30憭? [1]60憭?    (114:1)
                03 IPX-DRG-30-60                        PIC X(01).
*>              2007/9/20 DRG ?臬??CC                 (115:1)
                03 IPX-DRG-CC                           PIC X(01).
*>              2007/9/20 DRG ?臬??OR                 (116:1)
                03 IPX-DRG-OR                           PIC X(01).
*>              2007/9/20 DRG 閮餉?                      (117:1)
                03 IPX-DRG-MARK                         PIC X(01).

*>              0961115 ?啣??啣之??恍閮箸IPX-ANI-IDZ (118:60)
                03 IPX-ANI-IDZ                          PIC X(60).
*>              2008/6/12 敺PX-ANI-IDZ銝剖?X(01)摮????衣頝券?頧? ???瘙?- ?旨
                03 IPX-HOSP-IN  REDEFINES IPX-ANI-IDZ.
*>                      ??臬?箄楊?Ｗ?頧? ???瘙?- ?旨
                        04 IPX-HOSP-IN-YN               PIC X(01).
*>                      2011/6/18 ?啁姘?董??閮餉?(?寥鈭?瑽誨蝣澆???D.?董?? E.?董敺?)
                        04 IPX-CUT-HOP-MARK             PIC X(01).
*>                      TW-DRG?臬??西??喳,隞乩??? X.銵冽???
                        04 IPX-OUTOF-EX.
*>                              ?臬? X.?
                                05 IPX-OUTOF-EX-APP     PIC X(01).
*>                              ?憭????鞎餃銵??
                                05 IPX-OUTOF-NEWBABY    PIC X(01).
*>                              ?IABP?西??喳
                                05 IPX-OUTOF-IABP       PIC X(01).
*>                              ???鞎餃銵??
                                05 IPX-OUTOF-CAN-H      PIC X(01).
*>                              ??曄?鞎餃銵??
                                05 IPX-OUTOF-CAN-F      PIC X(01).
*>                              ????亥祥?西??喳
                                05 IPX-OUTOF-CAN-M      PIC X(01).
*>                              ??澆?典銵??
                                05 IPX-OUTOF-BRT        PIC X(01).
*>                              ?瘣?鞎餃銵??
                                05 IPX-OUTOF-DLS        PIC X(01).
*>                              2014/7/28  ??103撟??W-DRG?寧?憓?[??鋆賢??西??喳]
                                05 IPX-OUTOF-BIO        PIC X(01).
*>                      2011/6/18 X(59) => X(50)
*>                      2014/7/28 X(50) => X(49)
                        04 IPX-HOSP-IN-FIL              PIC X(49).

*>              0961115 ?啣??啣之??恍韏瑕?瑼Ｙ??     (178:7)
                03 IPX-ANI-CHK-DATE                     PIC 9(7).
*>              0961115 ?啣??啣之??恍?擃?(kg)    (185:5)
                03 IPX-ANI-WEIGHT                       PIC 9(03)V9(2).
*>              2007/12/1 憭批?DRG-蝵?閮餉?-NID[1627]    (190:3)
                03 IPX-DRG-1627                         PIC 9(03).
*>              2008/3/27 ?臬WEB?RG-蝵?閮餉?         (193:1)
                03 IPX-RSD-FLAG                         PIC X(01).
*>              2008/3/27 DRG蝺典祟鞈?靘?
*>              (L:?臬 T:憭批? S:?格?雿平)              (194:1)
                03 IPX-DRG-DATA-FROM                    PIC X(01).
*>              2009/1/12 銝餅祥?怠葦隞?Ⅳ(銝剝)            (195:4)
                03 IPX-MJ-DR-CHINMED                    PIC X(04).
*>              2009/1/12 雿?怠葦隞?Ⅳ(銝剝)            (199:4)
                03 IPX-RD-DR-CHINMED                    PIC X(04).
*>              2009/1/12 蝘隞?Ⅳ(銝剝)                (203:4)

                03 IPX-DPT-CHINMED                      PIC X(04).
*>              2009/5/12 IC?∟澈??雿?1.蝳? 2.璁格?)   (207:1)
                03 IPX-HIC-CLA                          PIC X(01).
*>              2009/6/24 ??恍雿?唾?嚗????嗅頛詨甈? (208:1)
                03 IPX-LIMIT-ICA-INPUT                  PIC X(01).
*>              2009/11/19 DRG ECMO閮餉?                 (209:1)
                03 IPX-DRG-ECMO                         PIC X(01).
*>              2010/3/5        ??ECMO甈???NO-DRG-MARK ?孵? "F" ??"G"
*>                              REDEFINES IPX-DRG-ECMO 雿輻
                03 IPX-NO-DRG-MARK      REDEFINES IPX-DRG-ECMO  PIC X(01).
*>              2012/06/14 憓?隢狡?桐?(????
                03 IPX-UNIT-GROUP.
*>                      隢狡?桐?銝
                        04 IPX-UNIT-CODE1               PIC X(04).
*>                      隢狡?桐?鈭?
                        04 IPX-UNIT-CODE2               PIC X(04).
*>                      隢狡?桐?銝?
                        04 IPX-UNIT-CODE3               PIC X(04).
*>              2012/11/29 ???撣?
                03 IPX-UNIT-GROUP1      REDEFINES IPX-UNIT-GROUP.
*>                      頨恍?蝑?隞?Ⅳ
                        04 IPX-HIDER-LEVEL-CODE         PIC X(01).
*>                      隢狡?桐?
                        04 IPX-UNIT-CODE                PIC X(04).
*>                      鋆憿漲隞?Ⅳ
                        04 IPX-SUBSIDY-CODE             PIC X(02).
*>                      FILLER
                        04 IPX-UNIT-GROUP-FILLER        PIC X(05).
*>              2012/06/14 憓?頧??璈?隞?Ⅳ
*>              頧??璈?隞?Ⅳ
                03 IPX-OUT-SER-CODE                     PIC X(10).
*>              2012/11/30 ??摨?敺蝯
                03 IPX-LAST-DAY-DT                      PIC 9(07).
*>              2016/11/22 NIS撠雿摨?
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
*>      IPD-LIVE-ID = "B" ?風??摰嗚?
*>      IPD-LIVE-ID = "C" ??霅瑯?
        02 IPX-GROUP-1-B REDEFINES IPX-GROUP-1.
*>              ?                                    (1:1)
                03 IPX-B-CARE                           PIC X(01).
*>              ?嗆???                                 (2:1)

                03 IPX-B-CASE                           PIC X(01).
*>              ??靘?                                (3:1)
                03 IPX-B-FROM                           PIC X(01).
*>              靘?隤芣?                                (4:40)
                03 IPX-B-FROM-DOC                       PIC X(40).
*>              銝餉風霅瑕ㄚ                                (44:5)
                03 IPX-B-NURSE                          PIC X(05).
*>              靘陷蝔漲                                (49:1)
                03 IPX-B-DEGREE                         PIC X(01).
*>              頧?鈭?                                 (50:10)
                03 IPX-B-TRN-NAME                       PIC X(10).
*>              ?敺?蝯                              (60:7)
                03 IPX-DB-DT                            PIC 9(07).
*>              霅瑞?摮?                                (67:10)
                03 IPX-B-NUR-NO                         PIC X(10).
*>              ?舀??”                                (77:1)
                03 IPX-B-KAM-DEGREE                     PIC X(01).
*>              撌湔??”                                (78:3)
                03 IPX-B-BARTH-SCORE                    PIC 9(03).
*>              蝺亥蝯∩犖憪?,?餉店1                    (81:12)
                03 IPX-B-TUH-NAME1                      PIC X(12).
*>                                                      (93:12)
                03 IPX-B-TUH-TEL1                       PIC X(12).
*>              蝺亥蝯∩犖憪?,?餉店2                    (105:12)
                03 IPX-B-TUH-NAME2                      PIC X(12).
*>                                                      (117:12)
                03 IPX-B-TUH-TEL2                       PIC X(12).
*>              蝺亥蝯∩犖憪?,?餉店3                    (129:12)
                03 IPX-B-TUH-NAME3                      PIC X(12).
*>                                                      (141:12)
                03 IPX-B-TUH-TEL3                       PIC X(12).

                03 IPX-B-REC                            PIC X(98).


*>      IPD-LIVE-ID = "X" ??霅瑞?銋振)?舐鼠?芣獢?
*>      IPD-LIVE-ID = "Y" ???仿??扯風)?舐鼠?芣獢?
        02 IPX-GROUP-1-X REDEFINES IPX-GROUP-1.
*>              ?批                                    (1:1)
                03 IPX-X-SEX                            PIC X(01).
*>              頧?靘?                                (2:1)
                03 IPX-X-FROM                           PIC X(01).
*>              靘?隤芣?                                (3:40)
                03 IPX-X-FROM-DOC                       PIC X(40).
*>              瘨???                                (43:1)
                03 IPX-X-CANCEL                         PIC X(01).
*>              閰摯蝯?                                (44:1)
                03 IPX-X-RESULT                         PIC X(01).
*>              閰摯霅瑕ㄚ                                (45:5)
                03 IPX-X-NURSE                          PIC X(05).
                03 IPX-X-REC-1                          PIC X(201).


*$XFD USE GROUP , VAR-LENGTH
        02 IPX-GROUP-2                                  PIC X(250).

*>      IPD-LIVE-ID = "A", "B", "C" ???Ｖ蜓瑼?IPD-MST)銋辣隡貉???

        02 IPX-GROUP-2-IPD REDEFINES IPX-GROUP-2.
*>              嚗?撠?隞乩?甇颱滿                        (1:1)
                03 IPX-OVER-48                          PIC X(01).
*>              ?芸?頨思遢嚗?                             (2:4)
                03 IPX-B-CLA2                           PIC X(04).
*>              ?芸?頨思遢嚗?                             (6:4)
                03 IPX-B-CLA3                           PIC X(04).
*>              ?芸?頨思遢嚗?                             (10:4)
                03 IPX-B-CLA4                           PIC X(04).
*>              ?芸?頨思遢嚗?                             (14:4)
                03 IPX-B-CLA5                           PIC X(04).
*>              銝??仿鈭箸(?曹??Ｙ隢?璆剜??        (18:1)
                03 IPX-DISCOUNT-IN                      PIC X(01).
*>              銝??粹鈭箸(?勗?Ｙ?撣喃?璆剜??        (19:1)
                03 IPX-DISCOUNT-OUT                     PIC X(01).
*>              雿?亦?,蝚砌?憭拐?皛曆??Ｚ那撖祥           (20:1)
                03 IPX-COM-REG                          PIC X(01).
*>              ???粹??                             (21:7)
                03 IPX-EXPECT-OUT-DT                    PIC 9(07).
*>              ?敺?隞?瑼                          (28:7)
                03 IPX-CHA-DT                           PIC 9(07).
*>              瘥扛雿摨?
                03 IPX-MOM-IPD-NO.
*>                                                      (35:7)
                        04 IPX-MOM-IPD-DT               PIC 9(07).
*>                                                      (42:4)
                        04 IPX-MOM-IPD-SEQ              PIC 9(04).
*>              ?粹蝯董?孵?([ ]銝?砍??[1]摰?頧???[2]頨思遢霈,[3]?瑟??董) (46:1)
                03 IPX-CUT-ID                           PIC X(01).
*>              擃炎憿                                (47:2)
                03 IPX-BODY                             PIC X(02).
*>              鈭?Ｚ那?瑁酉閮?                       (49:5)
                03 IPX-ODZS-MARK-TBL.
                        04 IPX-ODZS-MARK        OCCURS 5 TIMES  PIC X(01).
*>              ?臭?隞?Ⅳ ( 1.?暸? 2.?舐巨 3.?瑕 4.蝷曄?鋆 5.閮董鋆像)  (54:1)
                03 IPX-PAY-MARK                         PIC X(01).
*>              撣嗉???90/12/13 敹?銝??啣? )        (55:1)
                03 IPX-TAKE-ID                          PIC X(01).
*>              ?抵???90/12/13 敹?銝??啣? )        (56:1)
                03 IPX-EXTRA-ID                         PIC X(01).
*>              ??亦???90/12/13 敹?銝??啣? )        (57:1)
                03 IPX-RET-ID                           PIC X(01).
*>              ?亙??董?交?(90/12/13 敹?銝??啣? )    (58:7)
                03 IPX-DRUG-CLOSE-DT                    PIC 9(07).
*>              ?亙??董鈭箏隞?Ⅳ(90/12/13 敹?銝??啣?) (65:5)
                03 IPX-DRUG-CLOSE-USER                  PIC X(05).
*>              ?湔蝯董?交?(隢狡?交?)--910107 敹?銝??啣?     (70:7)
                03 IPX-LAST-DT                          PIC 9(07).
*>              鈭?Ｚ那??蝚穿?嚚?嚗?              (77:35)
                03 IPX-ODZS6-TBL.
                        04 IPX-ODZS6            OCCURS 5 TIMES  PIC X(07).
*>              鈭?Ｚ那?瑁酉閮?蝚穿?嚚?嚗?          (112:5)
                03 IPX-ODZS6-MARK-TBL.
                        04 IPX-ODZS6-MARK       OCCURS 5 TIMES  PIC X(01).
*>              ?臬隞付C?∟齒雿(Y銵其誑IC?∟齒雿)       (117:1)
                03 IPX-IC-YN                            PIC X(01).
*>              撠梢憿(IC??                          (118:2)

                03 IPX-IC-KND                           PIC X(02).
*>              撠梢摨?(IC??                          (120:4)
                03 IPX-IC-SEQ                           PIC X(04).
*>              鋆閮餉?(IC?? (1.甇?虜 2.鋆)          (124:1)
                03 IPX-DEN-MARK                         PIC X(01).
*>              ?仿撠梯那?交?????
                03 IPX-IC-IN-DT.
*>                                                      (125:7)
                        04 IPX-IC-IN-DATE               PIC 9(07).
*>                                                      (132:6)
                        04 IPX-IC-IN-TIME               PIC 9(06).
*>              ?粹撠梯那?交?????
                03 IPX-IC-OUT-DT.
*>                                                      (138:7)
                        04 IPX-IC-OUT-DATE              PIC 9(07).
*>                                                      (145:6)
                        04 IPX-IC-OUT-TIME              PIC 9(06).
*>              ?啁?????撠梢閮餉?(蝚昧??             (151:1)
*>              99/07/01銋??舐?詨?1~9嚗?9/07/01銋??臭誑?望?憭批神(????撖?憟?A~J
                03 IPX-IC-BABY-MARK                     PIC X(01).
*>              911218  ?敺???撣單??(smhkj)        (152:7)
                03 IPX-APL-DT                           PIC 9(7).
*>              2003/6/2 ?ａ?孵?(鈭日極??[NID-0739]   (159:2)
                03 IPX-OUT-TRF                          PIC X(2).
*>              撱踹?撠??扳?潛?38摨佗慫隞乩?(Y/N)         (161:1)
                03 IPX-OVER-38                          PIC X(01).
*>              雿??憭拇?????                 (162:1)
                03 IPX-FEVER                            PIC X(01).
*>              ?餈?勗??銋??                (163:1)
                03 IPX-2-WEEK                           PIC X(01).
*>              ?臬?箄??                             (164:1)
                03 IPX-PNEUMONIA                        PIC X(01).
*>              ?臬??貊?餈?                         (165:1)
                03 IPX-SOFFOCATE                        PIC X(01).
*>              ?臬?交抒?蝬?蝬??                  (166:1)
                03 IPX-NERVE                            PIC X(01).
*>              ?臬?交扯??                         (167:1)
                03 IPX-RUN                              PIC X(01).
*>              ?臬?交折???                         (168:1)
                03 IPX-ICTERUS                          PIC X(01).
*>              2003/11/26 ?啣??啣???                  (169:5)
                03 IPX-SARS-MOD-USER                    PIC X(05).
*>              2003/11/26 ?啣??交?                     (174:7)
                03 IPX-SARS-MOD-DT                      PIC 9(07).
*>              2003/11/26 ?啣???                     (181:6)
                03 IPX-SARS-MOD-TIME                    PIC 9(06).
*>              2003/12/18 靘?撠梢 [ ]??憭停??[1]撌脣?靽? [2]IC?⊿憭望????潭???      (187:1)
                03 IPX-IC-C001-MRK                      PIC X(01).
*>              2005/3/2   隞晶鈭?                      (188:12)
                03 IPX-INTR-NM                          PIC X(12).
*>              2005/3/2   隞晶鈭箸?衣?Ｗ?∪極         (200:1)
                03 IPX-INTR-WORKER-YN                   PIC X(01).
*>              2005/7/6 IC??銝?批?閮?               (201:1)
                03 IPX-IC-7-DAY                         PIC X(01).
*>              2006/12/13 雿獢辣??(???PD-CASE) (202:2)
                03 IPX-CASE                             PIC X(02).
*>              2007/9/7 撖虫??怠葦1隞?Ⅳ                  (204:4)

                03 IPX-OPR-DR1                          PIC X(04).
*>              2007/9/7 撖虫??怠葦2隞?Ⅳ                  (208:4)
                03 IPX-OPR-DR2                          PIC X(04).
*>              2009/7/13 DRG蝺典祟??隞嗅?憿誨蝣?        (212:2)
*>              2009/12/30 靽格???桀??∩蝙?剁??芯??臬?甈∩蝙??
                03 IPX-CASE-ORI                         PIC X(02).
*>              2009/8/3  憓????粹??甈? ( ??:?? )    (214:4)
                03 IPX-EXPECT-OUT-TI.
                        04      IPX-EXPECT-OUT-TI-HH    PIC 9(02).
                        04      IPX-EXPECT-OUT-TI-MM    PIC 9(02).
*>              2009/10/14 憓?1.??芸??亦?臬鈭日?(X(1))2.??啁拳?瑁??交?虫漱??雿?X(1))   (218:2)
                03 IPX-PAT-DRUG-BACK-YN                 PIC X(01).
                03 IPX-COLD-DRUG-BACK-YN                PIC X(01).
*>              2010/1/13       憓??仿?董靘????交?雿??其??脣?甇斤?雿鞈?憒?董靘?嚗?芯?蝔桃??董?孵? (220:1)
*>                              "1". 摰?頧???
*>                              "2". 頨怠?霈
*>                              "3". ?瑟??董
                03      IPX-CUT-FROM-MARK               PIC X(01).
*>              2010/4/2        (?啣?)?恍[?之]頧隞?Ⅳ        (221:10)
                03 IPX-FRM-HOSP-NCKU                    PIC X(10).
*>              2010/9/23       ?餃??風隤輸 VIP/?寞?鈭箏ㄚ?畾?酉閮?(231:2)
                03 IPX-SP-MARK                          PIC X(02).
*>              2013/10/23      (?貉?)?ａ?蝯?霅  (233:1)
                03 IPX-TB-MARK                          PIC X(01).
*>              2013/12/03      (??)?粹頧飛????憓?頧璈車霅(1.頠???.?湔?璈?.瘞璈?       (234:2)
                03 IPX-TRANS-WAY                        PIC X(02).
*>              2014/01/10      ??103撟???勗?擃??憓???????怒誨蝣?     (236:1)
                03 IPX-MED-SERVICE-PLAN                 PIC X(01).
*>              2014/01/10      ??103撟???勗?擃??憓??祕??靘?????思???璈?隞?Ⅳ?誨蝣?237:10)
                03 IPX-MED-INSTITUTION                  PIC X(10).
*>              2014/01/10      ??103撟???勗?擃??憓??岫颲西??怒誨蝣? (247:1)
                03 IPX-PAC-PLAN                         PIC X(01).
*>              2021/06/21      敶亙遠 憓??∪靽酉閮?
                03 IPX-NOHI-MARK                        PIC X(01).
*>              2022/05/30      敶亙遠 瘜鞎餌閮餉?
                03 IPX-NOTIDIS-MARK                     PIC X(01).
*>              ??
*>              2010/4/2        X(30) -> X(20)
*>              2010/9/23       X(20) -> X(18)
*>              2013/10/23      X(18) -> X(17)
*>              2013/12/03      X(17) -> X(15)
*>              2014/01/10      X(15) -> X(3)
*>              2021/06/21      X(3)  -> X(2)
*>              2022/05/30      X(2)  -> X(1)
                03 IPX-GROUP2-REC                       PIC X(1).


*>      IPD-LIVE-ID = "X" ??霅瑞?銋振)?舐鼠?芣獢?
*>      IPD-LIVE-ID = "Y" ???仿??扯風)?舐鼠?芣獢?
        02 IPX-GROUP-2-X REDEFINES IPX-GROUP-2.
*>              ?舐窗鈭? 嚗?嚗?(憪??閰晞?)       (1:192)
                03 IPX-X-CON-TBL.
                        04 IPX-X-CON-TBL1 OCCURS 3 TIMES.
                                05 IPX-X-CON-NAME       PIC X(12).
                                05 IPX-X-CON-TEL        PIC X(12).
                                05 IPX-X-CON-ADR        PIC X(40).
*>              撱箸???                                 (193:5)

                03 IPX-X-CRE-USER                       PIC X(05).
                03 IPX-X-REC-2                          PIC X(53).
*---------------------------------------------------------------------*
*>      嚗伐戮嚗扎嚗荔憐?嚗?摩嚗堆撕?嚗佗憬嚗穿憧?
*---------------------------------------------------------------------*


*COPY    "HI_ICA.MST".
*******************************************************************************
*> 雿?瑼?RECORD = 272 BYTES
*> 890630 憓? ICA-ANN-YN
*> 890803 憓? ICA-OPD-YN
*> 890828 撠CA-EXT-SERV ?寧 ICA-RMK-YN
*> 891009 REDEFINES ICA-SERG-NO, 憓?ADDRESS
*> 891117 憓?ICA-EXP-YN [?臬撅?撠??]
*> 900514 憓?ICA-OLD-PILL-NO
*> 910527 憓??閮箄?雿?亙?鈭支?隤踹?霅蝣潘????亙澈銝摨怎嚗? (JAY)
*> 910621 雿輻PDA?Ｙ??霅蝣???PDA撠?)    (JAY)
*> 990420 憓??乩??寞???活  (Frank)
*> 2012/10/11 (J1201427)?亥那?釭???寞??嗆?閮餉?(?之憭) - ?勗?
*> 2012/11/9  (J1201427)?亥那?釭???寞??嗆?閮餉?(?交扯銝剝◢????憛? - ?勗?
*******************************************************************************
 FD      ICA-MST         EXTERNAL.
 01      ICA-MST-REC.
*> KEY ??= 雿摨?+?摨?
        10 ICA-KEY.
*> 雿摨?(?曹??Ｙ隢?璆剔???箇?鈭箔??Ｗ銝摨?)
*$XFD USE GROUP
           20 ICA-IPD-NO.
              30 ICA-IPD-DATE           PIC 9(7).
              30 ICA-IPD-SEQ            PIC 9(4).
*> ?摨?(??交?+?瘚偌??
*$XFD USE GROUP
           20 ICA-ODR-NO.
*> ??交?(銝??嫣??交?,DEFAULT ?箇頂蝯望,?箏靽格銋?雿?>??航鋆?)
              30 ICA-INS-DATE           PIC 9(7).
*> ?瘚偌???箇洵撟曉撐銋???
              30 ICA-ODR-SEQ            PIC 9(4).
*$XFD USE GROUP,VAR-LENGTH
        10 ICA-GROUP-DATA1.
*> 蝯董摨?(甇斤???飛憿???蝑?撣喳???             (1, 3)
                20 ICA-SEG-SEQ                  PIC 9(3).
*> ?蝘隞?Ⅳ                                         (4, 4)
                20 ICA-DEPT-NO                  PIC X(4).
*> ??怠葦隞?Ⅳ                                         (8, 4)
                20 ICA-DR-NO                    PIC X(4).
*> ?頨思遢隞?Ⅳ                                         (12, 4)
                20 ICA-IDNT-NO                  PIC X(4).
*> ??澈隞?                                        (16, 4)
                20 ICA-IDNT-REF                 PIC X(4).
*> ?摨?                                             (20, 6)
                20 ICA-WARD.
                        30 ICA-BED-ROOM         PIC X(4).
                        30 ICA-BED-NO           PIC X(2).
*> ??蝔桅?                                             (26, 1)
                20 ICA-SERG-KND                 PIC X.
*> ??隞?Ⅳ(??銝)                                   (27, 7)

                20 ICA-SERG-NO                  PIC X(7).
*> 891009 SMSTL UPDATE :
                20 ICA-SERG-NO1 REDEFINES ICA-SERG-NO.
*> ???(雿?思誘雿輻??CA-INS-DATE雿輻)         (27, 4)
                        30 ICA-ODR-TIME         PIC 9(4).
*> ??                                                 (31, 3)
                        30 ICA-SERG-FILLER      PIC X(3).
*> ??銝                                               (34, 4)
                20 ICA-OP1                      PIC X(4).
*> ??鈭?                                              (38, 4)
                20 ICA-OP2                      PIC X(4).
*> ??銝?                                              (42, 4)
                20 ICA-OP3                      PIC X(4).
*> ?憭抒?亙予??                                        (46, 3)
                20 ICA-RX-DAYS                  PIC 9(3).
*> ?憭批????) ==> ?亙??其遢 ...                      (49, 3)
                20 ICA-MAX-SEQ                  PIC 9(3).
*> ?亥??Ⅳ                                             (52, 4)
                20 ICA-PILL-NO                  PIC 9(4).
*> ?蝮賡?                                             (56, 9)
                20 ICA-NOM-AMT                  PIC S9(7)V9(2).
*> ?芸???                                             (65, 9)
                20 ICA-DIS-AMT                  PIC S9(7)V9(2).
*> ?其遢鞎???                                         (74, 9)
                20 ICA-PART-AMT                 PIC S9(7)V9(2).
*> ?芯???                                             (83, 9)
                20 ICA-SP-AMT                   PIC S9(7)V9(2).
*> ?喳??                                             (92, 9)
                20 ICA-APP-AMT                  PIC S9(7)V9(2).
*> ?澈隞賜?梢?憿?                                    (101, 9)
                20 ICA-REF-AMT                  PIC S9(7)V9(2).
*> 撌脫??                                             (110, 9)
                20 ICA-RCV-AMT                  PIC S9(7)V9(2).
*> ??駁??誨?? X(4) ==> X(5)                        (119, 5)
                20 ICA-USR-ID                   PIC X(5).
*> ???(?剝?ICA-CRE-DT雿輻)                         (124, 4)
                20 ICA-INS-TIME                 PIC 9(4).
                20 ICA-UDP-DATA.
*> ??啣?鈭箔誨?? X(4) ==> X(5)                        (128, 5)
                        30 ICA-UPD-USR-ID       PIC X(5).
*> ??啣??交?                                         (133, 7)
                        30 ICA-UPD-DATE         PIC 9(7).
*> ??啣???                                         (140, 4)
                        30 ICA-UPD-TIME         PIC 9(4).
*> ??啣?蝣?                                          (144, 1)
                        30 ICA-UPD-MARK         PIC X.
*> ?潸?桐?                                             (145, 4)
                20 ICA-PILL-DEPT                PIC X(4).
*> 摨?蝑?                                             (149, 2)
                20 ICA-CLASS                    PIC X(2).
*> ?閮餉?       A, a->?箏?鞎餌 B->擐??  C->蝺交炎撽? F->隡?  G->?瑟??扯風,
*>                H->?澆?扯風    J->瘝餌??蔭 L.銵摨?O->?閮箄?雿 Q->頧?  U->UD   (151, 1)
                20 ICA-UD-MARK                  PIC X.
*> 頞??( Y - 頞?隞祥 )                             (152, 1)
*               20 ICA-EXT-SERV                 PIC X.
*> 890828 ??ICA-EXT-SERV, ?寧??衣鋆??雿?思誘雿輻)
                20 ICA-RMK-YN                   PIC X.

*> ?憿(Y-?交抒??? N-?Ｘ抒???                     (153, 1)
                20 ICA-BED-ID                   PIC X.
*> 蝝舐?憭拇(84.09.20)                                   (154, 3)
                20 ICA-COM-DAYS                 PIC 9(3).
*> ?其遢鞎?隞?Ⅳ(000:?隞質???001,002,003,004,005:?隞質???111:?芾祥)
*>             B01:?嗡?璈? ...                         (157, 3)
                20 ICA-IPD-PART                 PIC X(3).
*> 鞎?%(?雿?臭?畾萄????航????閬隞質?????????其遢鞎?)
*>        ( 0:?隞質??? 1:?交抒??輸隞質???10%, 2:?交抒???20%, 3:?交?
*>            ? 30%, 4:?Ｘ抒???5%, 5:?Ｘ抒???10%, 6:?Ｘ抒???20%,
*>          7:?Ｘ抒???30%  A:?芾祥 100%  B:?嗡?璈? 100%        (160, 1)
                20 ICA-RESPOND                  PIC X.
*> 蝺亥??? Y - On line ?,N - Batch ? S:撘瑕雿)        (161, 1)
                20 ICA-EMG-CD                   PIC X.
*> ?芸??活(?桐??蝞葉?望?撟暸???芸???銋炎撽?甈?           (162, 3)
                20 ICA-LB-CNT                   PIC 9(3).
*> ?芸??活?喳??( UPDATE 84.09.29)                           (165, 9)
                20 ICA-LB-APP-AMT               PIC 9(7)V9(2).
*> [T] ?董鞈? [D] ?芷?酉                                    (174, 1)
                20 ICA-DEL-MARK                 PIC X.
*> 靽?甈?
                20 ICA-FILLER                   PIC X(76).
                20 ICA-REF-DATA         REDEFINES ICA-FILLER.
*>                                                              (175, 9)
                   30 ICA-LB-PART-AMT           PIC S9(7)V9(2).
*> Y-> ??ICU ??                                              (184, 1)
                   30 ICA-BED-ICU               PIC X.
*> ?酉 [ ]銝?祉??[1]撣嗉 [2]???[3]撣貉??刻                 (185, 1)
                   30 ICA-PR-MRK                PIC X.
*> 頧炎 MARK ....                                               (186, 1)
                   30 ICA-CD00-MARK             PIC X.
*> ?Ｘ折隞質???憿?                                            (187, 8)
                   30 ICA-SLOW-PART-DEF         PIC X(8).
                   30 ICA-SLOW-PART REDEFINES  ICA-SLOW-PART-DEF  PIC S9(6)V99.
*> ?交折隞質???憿?                                            (195, 8)
                   30 ICA-QUICK-PART-DEF        PIC X(8).
                   30 ICA-QUICK-PART REDEFINES ICA-QUICK-PART-DEF PIC S9(6)V99.
*>                                                              (203, 3)
                   30 ICA-QUICK-DAYS-DEF        PIC X(3).
                   30 ICA-QUICK-DAYS REDEFINES ICA-QUICK-DAYS-DEF PIC 9(3).
*>                                                              (206, 3)
                   30 ICA-SLOW-DAYS-DEF         PIC X(3).
                   30 ICA-SLOW-DAYS REDEFINES ICA-SLOW-DAYS-DEF   PIC 9(3).
*> 蝯董?啣??交?                                                 (209, 7)
                   30 ICA-SEG-DATE              PIC 9(7).
*> 蝯董?啣???                                                 (216, 4)
                   30 ICA-SEG-TIME              PIC 9(4).
*> 摰?蝯董蝺刻?                                                 (220, 3)
                   30 ICA-SEG-NO                PIC 9(3).
*> ?撱箸???                                                  (223, 7)
                   30 ICA-CRE-DT                PIC 9(7).
*> ?粹?孵?喳靽格??                                          (230, 5)
                   30 ICA-APY-USR               PIC X(5).
*> ?思誘霅 Y->?思誘蝟餌絞?Ｙ?銋???                              (235, 1)
                   30 ICA-DR-YN                 PIC X(01).
*> Y->??敦?怠???閬隞?890630 憓?                    (236, 1)
                   30 ICA-ANN-YN                PIC X(01).

*> 嚗?摨急?仿?閮剖?撣園?閮箏澈?? 嚗?摨急?仿?閮剖?撣嗆亥那摨急;        (237, 1)
                   30 ICA-OPD-YN                PIC X(01).
*> Y->銵函內?撅?撠??(霈ICR-SON)                             (238, 1)
                   30 ICA-EXP-YN                PIC X(01).
*> ???亥?                                                     (239, 4)
*> 甈脖蝙?冽迨甈??? 隢??文?臬?摸UMERIC, ?血???NON-NUMERIC 銋?憿?
                   30 ICA-OLD-PILL-NO           PIC 9(04).
*> ?閮箄?雿?亙?鈭支?隤踹?霅蝣?910527)                         (243, 1)
                   30 ICA-PHA-WAY               PIC X(01).
*> 雿輻PDA?Ｙ??霅蝣?910621)                                (244, 1)
                   30 ICA-PDA-YN                PIC X(01).
*> ?寞?閮餉?(Y.?)(911205)                                     (245, 1)
                   30 ICA-SPEC-MARK             PIC X(01).
*> ?乩??寞???活 (990420)                                    (246, 2)
                   30 ICA-NHI-SPC-CNT           PIC 9(02).
*>2012/10/11 ?亥那?釭???寞??嗆?閮餉?(?之憭)                 (248, 1)
                   30 ICA-EMQ-MARK              PIC X(01).
*>2012/11/9 ?亥那?釭???寞??嗆?閮餉?(?交扯銝剝◢)                (249, 1)
                   30 ICA-EMQ-A-MARK            PIC X(01).
*>2012/11/9 ?亥那?釭???寞??嗆?閮餉?(?交批???憛?              (250, 1)
                   30 ICA-EMQ-B-MARK            PIC X(01).
*> *******************************************************************************
*>      END     OF      FILE
*> *******************************************************************************
*COPY    "HI_ICB.MST".
*********************************
*雿??敦瑼?RECORD LENGTH = 284 BYTES
*> 11/01 憓?ADDRESS 隤芣?
*> 2007/11/17 憓?[蝤函?]甈?銋?蝢?- 憓???恍撠銋?蝢?[蝯]
*> 97/09/26 Frank-?芸????摰儔嚗CB甈?靽格
*>                [?芸???]-->[?乩?銝策隞?]/[?嗡???]
*********************************
 FD      ICB-MST         EXTERNAL.
 01      ICB-MST-REC.
* KEY ??= 雿摨?+?摨?+?蔭瘚偌??
        10 ICB-KEY.
*雿摨?
*$XFD USE GROUP
           20 ICB-IPD-NO.
              30 ICB-IPD-DATE                   PIC 9(7).
              30 ICB-IPD-SEQ                    PIC 9(4).
*?摨?
*$XFD USE GROUP
           20 ICB-ODR-NO.
*??交?
              30 ICB-INS-DATE                   PIC 9(7).
*?瘚偌??
              30 ICB-ODR-SEQ                    PIC 9(4).
*?蔭瘚偌??
           20 ICB-FEE-SEQ                       PIC 9(3).
*?蔭隞?Ⅳ
        10 ICB-FEE-KEY                          PIC X(9).
*$XFD USE GROUP,VAR-LENGTH
        10 ICB-GROUP-DATA1.
*璅?鞎餌??                                                    (1, 3)
                20 ICB-STD-FNO                  PIC X(3).
*鞎餌甇詨惇蝘(?銝剖?)                                         (4, 5)

                20 ICB-FEE-DEPT                 PIC X(5).
*摨怠                                                           (9, 4)
                20 ICB-STO-DEPT                 PIC X(4).
*?賊?
                20 ICB-RX-QTY.
*?賊???                                                       (13, 4)
                        30 ICB-RX-QTY1          PIC 9(4).
*?賊???                                                       (17, 2)
                        30 ICB-RX-QTY2          PIC 9(2).
*甈∪???
                20 ICB-RX-UQTY.
*甈∪???摮?                                                    (19, 2)
                        30 ICB-RX-UQTY1         PIC 9(2).
*甈∪???瘥?                                                    (21, 2)
                        30 ICB-RX-UQTY2         PIC 9(2).
*閮?桐?(88.7 撌脫?箸甈∪?????)                            (23, 6)
                20 ICB-UNIT                     PIC X(6).
*??桐?(88.7 撌脫?箸甈∪?????)                            (29, 6)
                20 ICB-RX-UNIT                  PIC X(6).
*撠???( A: < 2 甇?30%,B: 2-6 甇?20%, N 銝???[C:???? 50 % => ICB-PRS-ADD] ) UPDATE 84.10.03
*?寞?撠??拇挾??( A: < 2 甇?30%,B: 2-6 甇?20%, N 銝???(930701??)(35, 1)
                20 ICB-BBY-RANK                 PIC X.
*蝯虫?蝑?(Y-?亥那??)                                           (36, 1)
                20 ICB-PAY-RANK                 PIC X.
*?桀                                                           (37, 8)
                20 ICB-PRICE                    PIC 9(6)V9(2).
*雿輻?寞?
                20 ICB-RX-WAY.
*??寞?                                                       (45, 2)
                        30 ICB-RX-WAY1          PIC X(2).
*???                                                       (47, 2)
                        30 ICB-RX-WAY2          PIC X(2).
*> 蝤函?(Y-?ㄗ蝎?                                               (49, 1)
*> ?亦???拚?Ｕ?甇斗?雿?蝢拍[蝯]嚗?[A.?亙?]?B.銵?]?靘撓?伐??撓?加蝯]?隞亥撓?乏ON-26?隤踹??孵?]
                20 ICB-POWDER                   PIC X.
*?刻憭拇                                                       (50, 2)
                20 ICB-RX-DAYS                  PIC 9(2).
*?嗉祥蝣?Y-?嗉祥,N-銝???                                        (52, 1)
                20 ICB-CHG-FLAG                 PIC X.
*?乩?蝯虫???(84.09.25) (Y-銝策隞??芾祥)                          (53, 1)
                20 ICB-ASU-PAY                  PIC X.
*?蔭憿(蝚砌?蝣?A-?亙?, B-銵?, C-瑼ａ?, D-瑼Ｘ, E-?曉?, F-?蔭)(54, 3)
*
                20 ICB-DG-FLAG                  PIC X(3).
*???(銝?乩?撌桅?, 雿?芸?憿?                             (57, 9)
                20 ICB-NOM-AMT                  PIC S9(7)V9(2).
*> 97/09/26 Frank-靽格[?芸???]?暨?乩?銝策隞?]/[?嗡???]
*?乩?銝策隞?/?嗡???                                          (66, 9)
***
                20 ICB-DIS-AMT                  PIC S9(7)V9(2).
*?其遢鞎???                                                   (75, 9)
                20 ICB-PART-AMT                 PIC S9(7)V9(2).
*撖行??銝?祇?憿?                                              (84, 9)
                20 ICB-RE-AMT1                  PIC S9(7)V9(2).
*撖行??隞???                                               (93, 9)
                20 ICB-RE-AMT2                  PIC S9(7)V9(2).
*撖行???寧??憿?                                            (102, 9)

                20 ICB-RE-AMT3                  PIC S9(7)V9(2).
*?芯?憿?                                                        (111, 9)
                20 ICB-SP-AMT                   PIC S9(7)V9(2).
*?喳憿?                                                        (120, 9)
                20 ICB-APP-AMT                  PIC S9(7)V9(2).
*甈∟?頨思遢?喳憿?                                                (129, 9)
                20 ICB-REF-AMT                  PIC S9(7)V9(2).
*?芸??活璅酉(甇日??蔭?臬撅祆?芸??活)                         (138, 1)
                20 ICB-LB-DIS                   PIC X.
*?????交?(瑼ａ??炎??                                       (139, 7)
                20 ICB-OP-BDATE.
                        30 ICB-OP-BD-YY         PIC 9(3).
                        30 ICB-OP-BD-MM         PIC 9(2).
                        30 ICB-OP-BD-DT         PIC 9(2).
*??????                                                   (146, 4)
                20 ICB-OP-BTIME.
                        30 ICB-OP-BT-HH         PIC 9(2).
                        30 ICB-OP-BT-MM         PIC 9(2).
*??蝯??交?(瑼ａ??炎??                                       (150, 7)
                20 ICB-OP-EDATE.
                        30 ICB-OP-ED-YY         PIC 9(3).
                        30 ICB-OP-ED-MM         PIC 9(2).
                        30 ICB-OP-ED-DT         PIC 9(2).
*??蝯???                                                   (157, 4)
                20 ICB-OP-ETIME.
                        30 ICB-OP-ET-HH         PIC 9(2).
                        30 ICB-OP-ET-MM         PIC 9(2).
*[T] ?董鞈? [D]?芷?酉                                       (161, 1)
                20 ICB-DEL-MARK                 PIC X.
*撌脤?賊?                                                       (162, 6)
                20 ICB-RTN-QTY.
*撌脤?賊???
                        30 ICB-RTN-QTY1         PIC 9(4).
*撌脤?賊???
                        30 ICB-RTN-QTY2         PIC 9(2).
**********************************************
*20 ICB-FILLER                  PIC X(13).
*20 ICB-OP-COUNTER      REDEFINES ICB-FILLER.
*********************************************
* Y->?? ..                                                    (168, 1)
                20 ICB-OPP-ID                   PIC X(1).
* ??瘚偌??..                                                 (169, 2)
                20 ICB-II-OP-COUNTER            PIC 9(2).
* ?芯?撌桀                                                      (171, 8)
                20 ICB-INS-CHG                  PIC 9(6)V99.
* ?????? ....                                             (179, 1)
                20 ICB-PRS-ADD                  PIC X.
                20 ICB-FILLER                   PIC X(71).
                20 ICB-ANT-DATA         REDEFINES ICB-FILLER.
*>                                                              (180, 1)
                        30 ICB-ANT-YN           PIC X.
*>                                                              (181, 1)
                        30 ICB-STL-YN           PIC X.
*> Y->雿輻?喳?? ?賊???ICB-APY-QTY, ?血???ICB-RX-QTY
                        30 ICB-APY-TYPE REDEFINES ICB-STL-YN PIC X.
**?蔭憿(PRS-FEE-KND)=C.瑼ａ? D.瑼Ｘ E.嚗詨?
                        30 ICB-PAS-DATA.

                           35   ICB-PAS-FRONT.
**瑼ａ?瑼Ｘ蝘恕(PRS-PAS-DPT)                                     (182, 1)
                                40 ICB-PAS-DPT  PIC X(1).
**?格?憿(PRS-PAS-TAB)                                         (183, 2)
                                40 ICB-PAS-TAB  PIC X(2).
**?喲?鞊?PRS-PAS-RCV),A>瑼ａ?瑼Ｘ,B>?其?瑼Ｘ,C>蝝啗?瑼ａ?,D>銵摨急炎撽?(185, 1)
                                40 ICB-PAS-RCV  PIC X(1).
**瑼ａ?瑼Ｘ蝝圈?隞?Ⅳ(PRS-PAS-ITM)                                 (186, 6)
                                40 ICB-PAS-ITM  PIC X(6).
**?蔭蝝圈?撠??活(PRS-PAS-SEQ)                                 (192, 1)
                                40 ICB-PAS-SEQ  PIC 9(1).
                           35   ICB-PAS-BACK.
**瑼ａ?瑼Ｘ?株?(HTCHK-CHK-NO)                                    (193, 8)
                                40 ICB-CHK-NO.
**瑼ａ?瑼Ｘ憿隞??(HTCHK-CLS-NO)
                                   45 ICB-CLS-NO PIC X(3).
**?瘚偌蝣?HTCHK-PR-SEQ)
                                   45 ICB-PR-SEQ PIC 9(5).
**瑼ａ?瑼Ｘ?隞?Ⅳ(HTCHK-ITM-CD)                                (201, 6)
                                40 ICB-ITM-CD   PIC X(6).
*> ???曉?瘥?
                        30 ICB-PER-RATE         PIC X(3).
* ?桐???? [???包
                        30 ICB-UD-BDT           PIC 9(07).
* ?桐???? [???包
                        30 ICB-UD-BMTH          PIC X(01).
* ?桐???? [蝯??包
                        30 ICB-UD-EDT           PIC 9(07).
* ?桐???? [蝯??包
                        30 ICB-UD-EMTH          PIC X(01).
*瑼ａ?
                        30 ICB-PAS-SMP          PIC X(01).
**?喲芋撘? PASS WAY, B>?孵敺甈∠偷??N>?孵敺犖撌亥???R>?孵敺??喳??
                        30 ICB-PAS-WAY          PIC X(01).
                        30 ICB-RTB-ODR          PIC 9(10).
                        30 ICB-RTB-SEQ          PIC 9(3).
                        30 ICB-RTB-MRK          PIC X.
* 摰孵
                        30 ICB-PAS-BTL          PIC X(1).
**瑼ａ?瑼Ｘ蝯?/?酉? Y:?澆 HTODRICF
                        30 ICB-PAS-RMK          PIC X(1).
*87/07/28憓?:
*韏瑁??交?&??銝?雿?鞎餌皜)
                        30 ICB-SEP-ID           PIC X(1).
*撘瑕?芾祥(Y)
                        30 ICB-SP-YN            PIC X(1).
*> ?喳?賊?(ICB-APY-TYPE = "Y" ????
                        30 ICB-APY-QTY          PIC 9(4)V9.
*********************************
*>      END OF FILE
*********************************
*COPY    "HI_ECB.MST".
*******************************************************************************
*> 雿??敦撱嗡撓瑼?   HI_ECB.MST              (HI_MECB)
*> RECORD LENGTH = 650 BYTES
*> RECORD KEY   ECB-KEY
*> ALTERNATE KEY1: ECB-ALT-KEY1 = ECB-DEL-MARK ECB-FEE-KEY ECB-ODR-NO ECB-IPD-NO

*                                ECB-FEE-SEQ
*> ALTERNATE KEY2: ECB-ALT-KEY2 = ECB-DEL-MARK ECB-IPD-NO ECB-TYPE ECB-ODR-NO-V
*                                ECB-FEE-SEQ
*> 890531  憓??阡暻駁???
*> 890622  憓????思誘?勗?
*> 890629  憓?摨急撠蝣?
*> 890717  GROUP-DATA 憓?VAR-LENGTH
*> 900220  憓??那蝘
*> 900604  憓???撟湧翩?????
*> 900721  憓?撖虫?瘝餌?撣思誨蝣?ECB-THE-NO)
*> 900928  憓?瑼ａ???銝銵?ECB-HT-UNDO)      (JAY)
*> 910131  憓??寥?閮箇?曹?閮餉?(STL)
*> 910312  憓?蝯西擗(擐?ㄗ蝎???(?思誘)   (JAY)
*> 910312  憓?暻駁?蝝圈?(銝?啣?霅蝣?         (JAY)
*> 930210  憓?瘞??0-6??                      (JAY)
*> 930617  憓?鞎砌遙?恍???????亙???      (JAY)
*> 940412  憓??喳鋆霅                     (TCC)
*> 940419  憓??喳鋆???隞?晞???    (TCC)
*> 950918  憓?靘?蝵株身摰撓?仿雿?雿?  (TCC)
*> 2006/10/31 憓?UDL韏瑁???(UD?迤??銝擐????,?粹??隞???唳撘?
*> 97/04/25 Frank-?啣之?脫?-憓??????酉隤芣?(ECB-CANCER-REMARK)
*> 97/05/07 Frank-憓??寞???
*> 97/10/07 Frank-憓????嚗靽?蝯虫?憿?銵?????嗡???(?芾祥)
*> 98/07/09 Frank-憓??蹂誨?蔭
*> 98/07/29 Frank-憓??怨?蝔桅?????
*> 98/07/29 Frank-憓??思誘???蔭
*> 98/09/22 Frank-憓??唬葉RFID?????刻韏瑁??交?
*> 98/12/19 Frank-憓??啣之?脫?瑼ａ??見閮餉?
*> 98/12/24 Frank-憓??怨?銝閮餉?
*> 99/07/13 Frank-憓??乩??寞??蝯
*> 2011/2/8  憓??乩????- ?旨
*> 2011/2/19 憓???葆??血??仙PF閮?
*> 2011/3/18 (J1100431)4甇? 蝘?? - ?旨
*> 2011/4/8  獢摨扯??? 憓?撅祆CHEMO?刻甈? - ?旨
*> 2011/6/21 憓?CHEMO?賊?甈? - ?旨
*> 2012/3/19 (J1200483)慦??寧?, 憓??瑁?鈭箏. 敶勗?靘?甈? - ?旨
*> 2012/6/13 (J1201066)?啣??臬?箸?瘛冽?銵?(銝???蝝隞?- ?勗?
*> 2012/6/25 (J1201098)?啣??瑁??交????銵犖?∪神?亥???- ?勗?
*> 2012/8/24 (J1201271)?啣?20蝣潛???- ?勗?
*> 2013/1/10 (J1201966)?芾祥?寞??蹂誨蝢斤? - ?勗?
*> 2013/8/30 (J1301047)?啣?20蝣潛?車憿?- ?勗?
*> 2014/4/18 (J1400397)?啣????刻??交???摰銵?? - ??
*> 2015/11/14 (J1500842)?冽撟喳?霅瑞?瘥???.5% - 瘛?
*> 2015/11/30 ??嚗憓活?? - 瘛?
*> 2017/01/09 ?怎恣???芸???- ?
*> 2017/11/06 ?怎恣??C??仿?蝡祟??- ?
*> 2019/01/22 憓?隞?炎?思?璈?隞?Ⅳ - ?
*>2020/07/24 ?乩?閬??蝺???曉?閮箇?????那???其??????- 雿喳鴃
*******************************************************************************
*> ?耨?過AYOUT嚗I_ECB.WRK, HI_OLDICB.WRK, HI_CANCERI.WRK銋??郊靽格
*******************************************************************************
 FD      ECB-MST         EXTERNAL.
 01      ECB-MST-REC.
* KEY ??= 雿摨?+?摨?+?蔭瘚偌??
        10      ECB-KEY.
* 雿摨?
*$XFD USE GROUP

           20   ECB-IPD-NO.
                30      ECB-IPD-DATE                    PIC 9(7).
                30      ECB-IPD-SEQ                     PIC 9(4).
* ?摨?
*$XFD USE GROUP
           20   ECB-ODR-NO.
* ??交?
                30      ECB-INS-DATE                    PIC 9(7).
* ?瘚偌??
                30      ECB-ODR-SEQ                     PIC 9(4).
* ?蔭瘚偌??
           20   ECB-FEE-SEQ                             PIC 9(3).
*>
* ?芷MARK
        10      ECB-DEL-MARK                            PIC X(1).
* ?蔭隞?Ⅳ
        10      ECB-FEE-KEY                             PIC X(9).
* 瑼?摨?
        10      ECB-FILE-NO                             PIC 9(3).
* 憿 1:?亙?,  2:瑼ａ?瑼Ｘ?曉?蝺? 3:F ?蔭憿?890525 憓?)
        10      ECB-TYPE                                PIC X(1).
* ?摨???
*$XFD USE GROUP
        10      ECB-ODR-NO-V.
                30      ECB-INS-DATE-V                  PIC 9(7).
                30      ECB-ODR-SEQ-V                   PIC 9(4).
*> ?key 1
        10      ECB-ALT1                                PIC X(50).
*> ?key 2
        10      ECB-ALT2                                PIC X(50).
*>
*$XFD USE GROUP
*$XFD USE GROUP, VAR-LENGTH
        10      ECB-GROUP-DATA1                         PIC X(250).
        10      ECB-GROUP-DATA11 REDEFINES ECB-GROUP-DATA1.
*> ?酉                                                                 (1,50)
                30      ECB-REMARK                      PIC X(50).
*> Y-> ?阡暻駁???                                                     (51,1)
                30      ECB-BRAIN-YN                    PIC X(01).
*> ?阡??銋獄????                                                  (52,3)
                30      ECB-BRAIN-RATE                  PIC 9(03).
*> ??葆???園?(*-->??葆????-->暻駁??)                             (55,1)
                30      ECB-LNK-POINT-HEAD              PIC X(01).
*> ??葆???活(??葆???獄????                                     (56,9)
                30      ECB-LNK-POINT                   PIC X(09).
*> ??葆???獄???脣?????                                          (65,6)
                30      ECB-LNK-TIME.
                        40      ECB-LNK-HH              PIC 9(02).
                        40      ECB-LNK-MM              PIC 9(02).
                        40      ECB-LNK-SS              PIC 9(02).
*> Y-> ???思誘?勗?     890622 INSERT                                   (71,1)
                30      ECB-ANN-YN                      PIC X(01).
*> 摨急撠蝣?          890629 INSERT                                   (72,13)
                30      ECB-STK-CNT                     PIC X(13).
*> ??怠葦                                                             (85,4)
                30      ECB-APY-DR                      PIC X(04).
*> 撖虫??怠葦嚗?                                                          (89,4)

                30      ECB-OPR-DR1                     PIC X(04).
*> 撖虫??怠葦嚗?                                                          (93,4)
                30      ECB-OPR-DR2                     PIC X(04).
*> ?勗??怠葦                                                             (97,4)
                30      ECB-RPT-DR                      PIC X(04).
*> ?那銋?????閮箄祥雿輻)-F02                                         (101,4)
                30      ECB-DEPT-NO                     PIC X(04).
*> ??撟湧翩??('1'->0-0.5, 'A'->0.5-2, 'B'->2-6)                       (105,1)
*> ?寞?撠?銝挾??('1'->0-0.5, 'A'->0.5-2, 'B'->2-6)(930701??)       (105,1)
                30      ECB-OPP-RANK                    PIC X(01).
*> ??撟湧翩???曉?瘥?                                                  (106,3)
*> ?寞?撠?銝挾???曉?瘥?930701??)                                   (106,3)
                30      ECB-OPP-RATE                    PIC 9(03).
*> 撖虫?瘝餌?撣?               900721 INSERT                              (109,5)
                30      ECB-THE-NO                      PIC X(05).
*> UDL ?蔭摨?                (UD ?喲蝙?? ?亦??)                  (114,3)
                30      ECB-UDL-FEE-SEQ                 PIC 9(03).
*> 瑼ａ????芸銵?'Y'?芸銵??瑁?)(900928)                            (117,1)
                30      ECB-HT-UNDO                     PIC X(01).
*> Y-> ?寧?閮箇??910131)                                             (118,1)
                30      ECB-OPD-APY                     PIC X(01).
*> 蝯西擗(擐?ㄗ蝎???(?思誘)(910312)                               (119,4)
                30      ECB-MED-PACKET                  PIC 9(04).
*> 暻駁?蝝圈?(銝?啣?霅蝣?(910312)                                     (123,1)
                30      ECB-LNK-SON                     PIC X(01).
*> 瘞??0-6??(930210)                                                  (124,1)
                30      ECB-PANT-YN                     PIC X(01).
*> 鞎砌遙?恍??(930617)                                                 (125,1)
                30      ECB-DUTY-YN                     PIC X(01).
*> ?亥那憭????(930617)                                             (126,1)
                30      ECB-NIGHT-YN                    PIC X(01).
*> ?蔭?寞?霅(瘥??蔭隞?Ⅳ)(D.摮悅??(930820)                         (127,1)
                30      ECB-SPEC-MARK                   PIC X(01).
*> 鈭?撖拇?(940105)                                                 (128,1)
                30      ECB-PRD-YN                      PIC X(01).
*> ?喳鋆霅( Y : ?喳鋆董)                                          (129,1)
                30      ECB-APY-MARK                    PIC X(01).
*> ?憿?                                                              (130,9)
                30      ECB-NOM-AMT                     PIC S9(7)V9(2).
*> ?芸?憿?                                                              (139,9)
                30      ECB-DIS-AMT                     PIC S9(7)V9(2).
*> ?芯?憿?                                                              (148,9)
                30      ECB-SP-AMT                      PIC S9(7)V9(2).
*> ?其遢鞎?憿?                                                          (157,9)
                30      ECB-PART-AMT                    PIC S9(7)V9(2).
*> ?喳憿?                                                              (166,9)
                30      ECB-APP-AMT                     PIC S9(7)V9(2).
*> 0-4甇脣?蝡仿蔡朣???Y:??)                                            (175,1)
                30      ECB-TEETH-YN                    PIC X(01).
*> 950918  憓?靘?蝵株身摰撓?仿雿?雿?                                  (176,1)
                30      ECB-LRB-FIELD                   PIC X(01).
**> 2006/10/31 憓?UDL韏瑁???(UD?迤??銝擐????,?粹??隞???唳撘?(177,7)
                30      ECB-UDL-BDT                     PIC 9(7).
*>                                                                      (184,2)
                30      ECB-UDL-BTI                     PIC 9(2).
*>                                                                      (186,7)
                30      ECB-UDL-EDT                     PIC 9(7).

*>                                                                      (193,2)
                30      ECB-UDL-ETI                     PIC 9(2).
*> 970430 ?啣之??-憓??思誘??UDL撖阡???                              (195,4)
                30      ECB-HRUDL-BTI                   PIC 9(2).
                30      ECB-HRUDL-ETI                   PIC 9(2).
*> 97.10.07 ???嚗靽?蝯虫?憿??乩?)                                (199,9)
                30      ECB-NHI-DIS-AMT                 PIC S9(7)V9(2).
*> 97.10.07 ???嚗隞?憿??芾祥)                                    (208,9)
                30      ECB-SP-DIS-AMT                  PIC S9(7)V9(2).
*> 98/07/09 ?蹂誨?蔭 (憒?蔭?嚗?B?蔭嚗迨甈?摮?蔭隞?Ⅳ)      (217,9)
                30      ECB-REPLACE-FEE-KEY             PIC X(9).
*> 98/07/29 ??亦車-?怨?蝔桅?                                           (226,6)
                30      ECB-INJ-KIND                    PIC X(6).
*> 98/07/29 ??亦車-?怨??寡?                                           (232,12)
                30      ECB-INJ-BATCH-NO                PIC X(12).
*> 98/07/29 ?思誘???蔭 (Y:???蔭)                                   (244,1)
                30      ECB-HRPRN-YN                    PIC X(1).
*> 98/09/22 ?唬葉RFID?芸??亥???(K嚗?)                              (245,1)
                30      ECB-SELF-DRUG                   PIC X(1).
*> 98/12/19 ?啣之?脫?瑼ａ??見閮餉? (Y嚗歇?見)                            (246,1)
                30      ECB-HT-SAMPLE                   PIC X(1).
*> 98/12/24 ??亦車-?怨?銝閮餉? (Y嚗歇銝)                           (247,1)
                30      ECB-INJ-ICS-YN                  PIC X(1).
*> 99/07/13 ?乩??寞??蝯 (NID-062A)                                 (248,2)
                30      ECB-SPC-DIS-GRP                 PIC X(2).
*> 2011/4/8 霅撅祆CHEMO?刻 (C/T?刻霅) (Y: 閰脤?撅祆C/T?刻)        (250:1)
                30      ECB-CHEMO-CT                    PIC X(1).
*$XFD USE GROUP
*$XFD USE GROUP, VAR-LENGTH
        10      ECB-GROUP-DATA2                         PIC X(250).
        10      ECB-GROUP-DATA21 REDEFINES ECB-GROUP-DATA2.
*> ???酉(97/04/25)                                                   (1,80)
                30      ECB-CANCER-REMARK               PIC X(80).
*> ?寞???(97/05/07)                                                   (81,3)
                30      ECB-SPC-RATE                    PIC 9(3).
*> 98/09/22 ?唬葉RFID?????刻韏瑕??交? (雿撖怠)                     (84,7)
                30      ECB-HRUDL-BDT                   PIC 9(7).
*> 98/09/22 ?唬葉RFID?????刻蝯??交? (雿撖怠)                     (91,7)
                30      ECB-HRUDL-EDT                   PIC 9(7).
*> 98/09/22 ?唬葉RFID?????? (雿撖怠)                             (98,8)
                30      ECB-HRUDL-RX-QTY                PIC 9(6)V9(2).
*> 99/07/26 ?乩??寞????                                             (106,3)
                30      ECB-SPC-DIS-RATE                PIC 9(1)V9(2).
*> 2011/2/8 ?乩????                                                 (109,5)
                30      ECB-NHI-DIS-RATE                PIC 9(3)V9(2).
*> 2011/2/19 ??葆??血??仙PF閮?                                      (114:1)
                30      ECB-PPF-YN                      PIC X(1).
*> 2011/3/18 4甇脣?蝡仿?閮箄那撖祥??                                      (115:1)
                30      ECB-DIAG-RANK                   PIC X(1).
*>                                                                      (116:3)
                30      ECB-DIAG-RATE                   PIC 9(3).
*> 2011/3/18 蝘?閮箄那撖祥??                                         (119:1)
                30      ECB-DPT-RANK                    PIC X(1).
*>                                                                      (120:3)
                30      ECB-DPT-RATE                    PIC 9(3).
*> 2011/6/21 CHEMO瘚偌??                                               (123:4)
                30      ECB-HYGUDL-SN-NO                PIC 9(4).

*> 2011/6/21 CHEMO霅 (C:?HEMO, U:?D, S:?風??)                  (127:1)
                30      ECB-HYGUDL-CHEMO-ID             PIC X(1).
*> 2011/6/21 CHEMO摨?                                                  (128:2)
                30      ECB-HYGUDL-SEQ-NO               PIC 9(2).
*> 2012/3/19 ?瑁?鈭箏                                                   (130:5)
                30      ECB-EXECUTE-USR                 PIC X(5).
*> 2012/3/19 敶勗?靘?                                                   (135:1)
                30      ECB-IMAGE-SW                    PIC X(1).
*> 2012/6/13 ?臬?箸?瘛冽?銵?(銝???蝝隞?Y:??, 蝛箇:??             (136:1)
                30      ECB-CLEAN-OPP-ANT-YN            PIC X(1).
*> 2012/6/25 ?瑁??交????銵犖?∪神?亥???                            (137:1)
*>           (1.?孵  2.鋆  3.瑼ａ?  4.??  5.頧?  6.瑼Ｚ?鋆?  7.??鋆?)
                30      ECB-OP-DATE-USR-ID              PIC X(1).
*> 2012/8/24 20蝣潛???                                              (138:20)
                30      ECB-NEW-INJ-BATCH-NO            PIC X(20).
*> 2013/1/10 ?芾祥?寞??蹂誨蝢斤?                                           (158:3)
                30      ECB-REPLACE-GROUP               PIC X(03).
*> 2013/8/30 20蝣潛?車憿?                                              (161,20)
                30      ECB-NEW-INJ-KIND                PIC X(20).
*
*> 2014/4/18 ???刻??交?(銵摨?                                         (181,7)
                30      ECB-BLOOD-DATE                  PIC 9(07).
*> 2014/4/18 ???刻???(銵摨?                                         (188,4)
                30      ECB-BLOOD-TIME                  PIC 9(04).
*> 2015/11/14 ?冽撟喳?霅瑞?瘥???.5%                                    (192,5)
                30      ECB-PRE-RATE                    PIC 9(05).
*> 2015/11/30 ??-?啣?甈∪???                                          (197,10)
                30      ECB-RX-N-UQTY.
                        40      ECB-RX-N-UQTY1          PIC 9(05).
                        40      ECB-RX-N-UQTY2          PIC 9(05).
*> 2017/01/09 ?怎恣???芸???
*>              ?芸??酉閮?                                             (207,1)
                30      ECB-NLI-MARK                    PIC X(01).
*>              ?芸??靽誨蝣?                                         (208,16)
                30      ECB-NLI-INS-ID                  PIC X(16).
*>              ?芸??靽誨蝣潭?瘞渲?                                    (224,2)
                30      ECB-NSI-INS-ID-SEQ              PIC 9(02).
*> 2017/11/06 ?怎恣??C??仿?蝡祟??
*>              C??亦隢??                                        (226,7)
                30      ECB-CHE-STR-DATE                PIC 9(07).
*> 2017/11/09 ????蝣潭6蝣?
*>              ?啣??                                                (233,5)
                30      ECB-PRE-RATE-NEW                PIC 9(05).
*> 2019/01/22 憓?隞?炎?思?璈?隞?Ⅳ                                      (238,10)
                30      ECB-INSPECT-HOSP-ID             PIC X(10).
*>      2020/07/24 ?乩?閬??蝺???曉?閮箇?????那???其??????
                30      ECB-LRB-FIELD-NEW       PIC X(02).
                30      ECB-FILLER2                     PIC X(01).
*******************************************************************************
*>      END     OF      FILE
*******************************************************************************
*COPY    "HI_BED.MST".
*---------------------------------------------------------------------*
* ???箸鞈?瑼?: HI_BED.MST                         瑼?嚗I_MBED   *
*---------------------------------------------------------------------*
* 銝鳴?BED-BED                                                         *
* ?荔?BED-ALT-KEY1 = BED-GRD    + BED-BED                             *

* ?荔?BED-ALT-KEY2 = BED-DPT    + BED-BED                             *
* ?荔?BED-ALT-KEY3 = BED-DR     + BED-BED                             *
* ?荔?BED-ALT-KEY4 = BED-UNIT   + BED-BED                             *
* ?荔?BED-ALT-KEY5 = BED-STATUS + BED-BED                             *
* ?荔?BED-ALT-KEY6 = BED-STATUS + BED-GRD  + BED-BED                  *
* ?荔?BED-ALT-KEY7 = BED-STATUS + BED-DPT  + BED-BED                  *
* ?荔?BED-ALT-KEY8 = BED-STATUS + BED-DR   + BED-BED                  *
* ?荔?BED-ALT-KEY9 = BED-STATUS + BED-UNIT + BED-BED                  *
*---------------------------------------------------------------------*
*
 FD      BED-MST         EXTERNAL.
 01      BED-MST-REC.
*--------------*
*   ?箸鞈?   *
*--------------*
* ?摨?
*$XFD USE GROUP
        02      BED-BED.
*     ?
                03      BED-ROOM                        PIC X(04).
*     摨?
                03      BED-NO                          PIC X(02).
* ??蝑?
        02      BED-GRD                                 PIC X(02).
* 蝘隞?Ⅳ
        02      BED-DPT                                 PIC X(04).
* ?怠葦隞?Ⅳ
        02      BED-DR                                  PIC X(04).
* ?桐?隞?Ⅳ (霅瑞?蝡?
        02      BED-UNIT                                PIC X(05).
*$XFD USE GROUP , VAR-LENGTH
        02      BED-GROUP1.
* UD? [Y]
                03      BED-UD                          PIC X(01).
* 韏啣?摨?[Y]
                03      BED-ROAD                        PIC X(01).
* ?乩?摨?[Y]
                03      BED-INSU                        PIC X(01).
* ?Ｗ儔摰?[Y]
                03      BED-RECOVER                     PIC X(01).
* 雿???(蝞?蝞?摨?) [Y]
                03      BED-CNT                         PIC X(01).
* ?批瑼Ｘ [Y]
                03      BED-SEX                         PIC X(01).
* 摨?蝔桅?隞?Ⅳ
                03      BED-CODE                        PIC X(01).
* ?交批???[N]
                03      BED-ACUTE                       PIC X(01).
* 靽風?? [Y]
                03      BED-ISO                         PIC X(01).
* ??撅祆?[Y-ICU?? 1-蝎曄??? 2-?仿?? 3-摰祐??]
                03      BED-ICU                         PIC X(01).

* ???嗉祥?曉?瘥?
                03      BED-ADD-PCT                     PIC 9(03).
* 摨??迫雿輻 [Y]
*>2003/1/28     ?迫[Y],??閮餉?[S]

                03      BED-STOP                        PIC X(01).
* ?乩?撠?摨?
                03      BED-TRAN                        PIC X(28).
*--------------*
*   ?啣?鞈?   *
*--------------*
* ?桀??瘜?(" "蝛箏?, "1"敺? , "2"雿?)
        02      BED-STATUS                              PIC X(01).
*
*$XFD USE GROUP , VAR-LENGTH
        02      BED-GROUP2.
                03      BED-PATIENT.
* ???甇瑁?蝣?
                        04      BED-PAT-NO              PIC 9(08).
* 雿????Ｗ???
                        04      BED-IPD-NO.
*     雿????Ｘ
                                05      BED-IPD-DT      PIC 9(07).
*     雿????Ｘ?瘞渲?
                                05      BED-IPD-SEQ     PIC 9(04).
* 敺??芣迫?交?
                        04      BED-END-DT              PIC 9(07).
* 敺??芣迫??
                        04      BED-END-TI              PIC 9(06).
* ?啣??誨蝣?
                        04      BED-CHG-UID             PIC X(05).
* ?餉店?? 102
                03      BED-PHONE                       PIC X(04).
* 嚗蛛慾????106
                03      BED-UD-DATE                     PIC 9(07).
*> 敺??風??nid-mst-rec(113:8) ; substring(bed_group2,49,8)
                03      BED-WAT-PAT-R                   PIC X(08).
                03      BED-WAT-PAT REDEFINES BED-WAT-PAT-R PIC 9(8).
*> ?臬?飢瘞?121
                03      BED-OXYGEN                      PIC X(01).
*> ????UPDATE BY 蝧?  88/09/13) 122
                03      BED-VALID-DATE                  PIC 9(07).
*> ?芣迫??UPDATE BY 蝧?  88/09/13) 129
                03      BED-EXP-DATE                    PIC 9(07).
*> ???酉(900306) nid-mst-rec(136:3)
                03      BED-REMARK                      PIC X(03).
*> ??雿?思誘?,?思誘??????迂頛詨甇斤?摨?nid-mst-rec(139:1)
                03      BED-ALLOW-MOD                   PIC X(01).
*> ?乩?撠?摨?????
                03      BED-TRAN-VALID-DT               PIC 9(07).
* FILLER
                03      BED-REC                         PIC X(05).
*****
***** THE END
*COPY    "HO_PRS.MST".
*
**?蔭隞?Ⅳ瑼?-- PRESCRIPTION CODE FILE  ?瑕漲(LENGTH) 300
**憭瑼?  HO_PRS.MST --> 瑼?  HO_MPRS
************************************************************
*銝?PRS-MST-KEY  = PRS-MST-ID.
*??PRS-ALT-KEY1 = PRS-INS-ID PRS-MST-ID.
*??PRS-ALT-KEY2 = PRS-FEE-KND PRS-MST-ID.

*??PRS-ALT-KEY3 = PRS-STK-CNT PRS-MST-ID.
*??PRS-ALT-KEY4 = PRS-ID-NAME PRS-MST-ID.
*??PRS-ALT-KEY5 = PRS-BRF-ID PRS-MST-ID.
************************************************************
**??敦鞈?
 FD      PRS-MST         EXTERNAL.
 01      PRS-MST-REC.
**?蔭隞?Ⅳ  PRESCRIPTION  CODE
*$XFD USE GROUP
        10 PRS-MST-ID.
**      ?蔭銝颱誨蝣?PRESCRIPTION  MAJOR  CODE
           20 PRS-MAJ-ID                PIC     X(08).
**      ?蔭?惇蝣?PRESCRIPTION  AUXILIARY  CODE
           20 PRS-AUX-ID                PIC     X(01).
**?乩?隞?Ⅳ  INSURANCE  CODE
*$XFD USE GROUP
        10 PRS-INS-ID.
**      ?乩?銝颱誨蝣?INSURANCE  MAJOR  CODE
           20 PRS-INS-MAJ                   PIC     X(09).
**      ?乩?銵?撱嗡撓蝣?INSURANCE  EXTEND  CODE
           20 PRS-INS-EXT                   PIC     X(07).
**摨急撠蝣? STOCK  CONTRASTIVE  CODE
        10  PRS-STK-CNT                     PIC     X(13).
**?蔭?迂
        10  PRS-ID-NAME                     PIC     X(40).
**蝪∠Ⅳ  PRESCRIPTION  BRIEF  CODE
        10 PRS-BRF-ID                       PIC     X(04).
*$XFD USE GROUP
        10 PRS-DATA1.
**璅?鞎餌?? STANDARD  FEE  KIND [0605]
            12  PRS-STD-FNO                 PIC     X(03).
**閮?桐?
            12  PRS-PRC-UNIT                PIC     X(08).
**??桐?
            12  PRS-SRV-UNIT                PIC     X(08).
**蝞∪ C/N
            12  PRS-CTL-ID                  PIC     X(01).
**?像鞎? Y/N (91.10.19 甇斗?雿?雿輻,閬蝙?刻??隢?
            12  PRS-PAY-ID                  PIC     X(01).
***********************
**?芾祥頨思遢?  OWN  EXPENSE  PARAMETER
            12  PRS-OWN-PAR.
**?憿  LIMITED  ID  Y/W/N  Y:???
                20 PRS-OWN-LTD              PIC     X(01).
**?桀  UNIT  PRICE
                20 PRS-OWN-UPC              PIC     9(06)V9(02).
**??葆??  LINKING  POINTER [0602]
                20 PRS-OWN-LNK              PIC     X(09).
**撅?霅  LINKING  POINTER  UNFOLD  ID  Y/N
                20 PRS-OWN-LNK-ID           PIC     X(01).
**?亥那??撅祆? EMERGENCY  RAISE  PRICE  ID  Y/N
                20 PRS-OWN-EMG              PIC     X(01).
**????霅  ADDITIONAL  SUPPLIES  ID  Y/N  Y:?隞祥
                20 PRS-OWN-ADD              PIC     X(01).
**蝯虫?(閮)霅  PAYMENT ID  Y/N
                20 PRS-OWN-PAY              PIC     X(01).
**???撅祆? SICKROOM  RAISE  PRICE  ID  Y/N

                20 PRS-OWN-SCK              PIC     X(01).
***********************
**?乩?頨思遢?  INSURENCE  EXPENSE  PARAMETER
            12  PRS-INS-PAR.
**?憿  LIMITED  ID  Y/W/N  Y:???
                20 PRS-INS-LTD              PIC     X(01).
**?桀  UNIT  PRICE
                20 PRS-INS-UPC              PIC     9(06)V9(02).
**??葆??  LINKING  POINTER  [0602]
                20 PRS-INS-LNK              PIC     X(09).
**撅?霅  LINKING  POINTER  UNFOLD  ID  Y/N
                20 PRS-INS-LNK-ID           PIC     X(01).
**?亥那??撅祆? EMERGENCY  RAISE  PRICE  ID  Y/N
                20 PRS-INS-EMG              PIC     X(01).
**????霅  ADDITIONAL  SUPPLIES  ID  Y/N
                20 PRS-INS-ADD              PIC     X(01).
**蝯虫?(閮)霅  PAYMENT  ID  Y/N  Y:?閮???
                20 PRS-INS-PAY              PIC     X(01).
**???撅祆? SICKROOM  RAISE  PRICE  ID  Y/N
                20 PRS-INS-SCK              PIC     X(01).
**?乩??芯?撌桅???  FEE  CHARGE
                20 PRS-INS-CHG              PIC     9(06)V9(02).
**?葆?勗?霅  REPORT  ATTACHED  ID  Y/N  Y:?喳???勗?
                20 PRS-INS-RPT              PIC     X(01).
**蝯西憭拇?  DAYS  LIMITED
                20 PRS-INS-DAY              PIC     9(02).
***********************
**??頨思遢?  SPARE  FOR  EXPENSE  PARAMETER
            12  PRS-SPR-PAR.
**?憿  LIMITED  ID  Y/W/N
                20 PRS-SPR-LTD              PIC     X(01).
**?桀  UNIT  PRICE
                20 PRS-SPR-UPC              PIC     9(06)V9(02).
**??葆??  LINKING  POINTER  [0602]
                20 PRS-SPR-LNK              PIC     X(09).
**撅?霅  LINKING  POINTER  UNFOLD  ID  Y/N
                20 PRS-SPR-LNK-ID           PIC     X(01).
**?亥那??撅祆? EMERGENCY  RAISE  PRICE  ID  Y/N
                20 PRS-SPR-EMG              PIC     X(01).
**????霅  ADDITIONAL  SUPPLIES  ID  Y/N
                20 PRS-SPR-ADD              PIC     X(01).
**蝯虫?(閮)霅  PAYMENT  ID  Y/N
                20 PRS-SPR-PAY              PIC     X(01).
**???撅祆? SICKROOM  RAISE  PRICE  ID  Y/N
                20 PRS-SPR-SCK              PIC     X(01).
**?芯?撌桅???  FEE  CHARGE
                20 PRS-SPR-CHG              PIC     9(06)V9(02).
**?葆?勗?霅  REPORT  ATTACHED  ID  Y/N
                20 PRS-SPR-RPT              PIC     X(01).
**蝯西憭拇?  DAYS  LIMITED
                20 PRS-SPR-DAY              PIC     9(02).
***********************
**?蔭憿 A.?亙? B.銵? C.瑼ａ? D.瑼Ｘ E.嚗詨? F.閮箇??敦 L.??葆??
        10  PRS-FEE-KND                 PIC     X(03).
*$XFD USE GROUP
        10  PRS-DATA2.
**隞?甈曉惇?? COLLECTION  ID  Y/N  Y:隞?                               1:1

            12  PRS-COL-ID                  PIC     X(01).
**?撅祆? SHARE  ID  Y/N  Y:?                                      2:1
            12  PRS-SHA-ID                  PIC     X(01).
**?瘥?  SHARE  RATE                                                 3:3
            12  PRS-SHA-RAT                 PIC     9(03).
**??蝝? ANTIBIOTIC  ID  Y/N                                           6:1
            12  PRS-ANT-ID                  PIC     X(01).
**撠???撅祆? CHILDREN  RAISE  PRICE  ID  Y/N                         7:1
            12  PRS-CHL-ID                  PIC     X(01).
**??撅祆批?????UPD ON 85.08.24                                      8:3
            12  PRS-INS-CON                 PIC     9(03).
**?寞??蔭  SPECIAL  PRESCRIPTION  ID  Y/N                             11:1
            12  PRS-SPC-ID                  PIC     X(01).
**頛詨?孵?霅  1.?交?  2.??  3.甈∪??? 4.?????? 5.銝撓??      12:1
            12  PRS-KIN-ID                  PIC     X(01).
**霅血?閮  WARNING  CODE  [0603]                                      13:10
            12  PRS-WRN   OCCURS  5  TIMES.
                20  PRS-WRN-COD             PIC     X(02).
**?撅祆? COST  ID  1.?身?? 2.蝘  3.?怠葦??                      23:1
            12  PRS-CST-ID                  PIC     X(01).
**?銝剖?  COST CENTER                                                24:5
            12  PRS-CST-CTR                 PIC     X(05).
**蝺??批蝣? ON-LINE  CONTROL  ID  Y/N  Y:?∪澈摮????             29:1
            12  PRS-LIN-CON                 PIC     X(01).
**摨急頧??? STOCK  EXCHANGE  RATE                                    30:7
            12  PRS-STK-CHG                 PIC     9(04)V9(03).
**?閮箏澈??                                                            37:4
            12  PRS-DGN-STK                 PIC     X(04).
**?亥那摨急                                                             41:4
            12  PRS-EMG-STK                 PIC     X(04).
**雿那摨急                                                             45:4
            12  PRS-RES-STK                 PIC     X(04).
**瑼ａ?  TEST  SAMPLE                                                   49:1
            12  PRS-TST-SMP                 PIC     X(01).
**蝘恕  DEPARTMENT                                                     50:1
            12  PRS-PAS-DPT                 PIC     X(01).
**?格?憿  TABLE  ID                                                  51:2
            12  PRS-PAS-TAB                 PIC     X(02).
**摰孵                                                                 53:1
            12  PRS-PAS-WAY                 PIC     X(01).
**?喲?鞊? PASS RECEIVER, A>瑼ａ?瑼Ｘ,B>?其?瑼Ｘ,C>蝝啗?瑼ａ?,D>銵摨急炎撽?54:1
            12  PRS-PAS-RCV                 PIC     X(01).
**??蝘  ACCOUNTING  SUBJECT                                        55:6
            12  PRS-ACC-SUB                 PIC     X(06).
**?孵?瘝餌?  SPECIAL  CURE  ID  [1101](????                        61:2
            12  PRS-SPC-CUR                 PIC     X(02).
**?芸??活 ( UPDATE 84.09.29 )  Y/N                                    63:1
            12  PRS-DIS-YN                  PIC     X(01).
**?甈?
            12  PRS-FILLER                  PIC     X(40).
            12  PRS-FILLER1  REDEFINES PRS-FILLER.
**??霅  Y/N                                                        64:1
               20  PRS-OPP-ID               PIC     X(01).
**???身??銝)                                                       65:2
               20  PRS-SRV-NO1              PIC     X(02).
**???身??鈭?                                                       67:2
               20  PRS-SRV-NO2              PIC     X(02).

**???身??銝?                                                       69:2
               20  PRS-SRV-NO3              PIC     X(02).
**瑼ａ?瑼Ｘ蝝圈?隞?Ⅳ                                                     71:6
               20  PRS-PAS-ITM              PIC     X(06).
**?蔭蝝圈?撠??活                                                     77:1
               20  PRS-PAS-SEQ              PIC     9(01).
**?乩??桀????PRS_INS_UPC)                                          78:7
               20  PRS-INS-DATE             PIC     9(07).
**?乩??桀???乩????桀                                             85:8
               20  PRS-OLD-UPC              PIC     9(6)V99.
**蝺??批????UPD ON 85.08.24.                                      93:7
               20  PRS-CON-DATE             PIC     9(07).
**?芸??霅 86.09.03. Y:?芸??  N:鈭箏極?                       100:1
               20  PRS-BAG-ID               PIC     X(01).
**瑼ａ?瑼Ｘ蝯?/?酉? Y:?澆 HTODRICF                               101:2
               20  PRS-PAS-RMK              PIC     X(01).
               20  PRS-PAS-QTY-MRK          PIC     X(01).
*> 91.10.19 ?亙???                                                  103:1
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
*>      雿?萄潭??HI_FON.MST  -- RECORD LENGTH = 352 BYTES          *
*---------------------------------------------------------------------*
*> 銝? 嚗ON-ID FON-CODE
*> ?荔?嚗ON-ID FON-TRN FON-CODE
*---------------------------------------------------------------------*
*>      2009/1/12       銝剛正?怨???Ｗ???雿?- ?旨
*>      0980225         ?啣?擐???孵???05.UDL撱嗡撓鞈?)
*>      2009/5/27       ??嚗?閮箄?雿-瑼ａ?瑼Ｘ?湔憭望?蝝??J0901074.J0901229) - ?箏?
*>      2009/7/16       ??嚗憓隞??蝵??剝?ECB.MST)(J0901262) - ?箏?
*>      2009/10/22      撟??唬葉)???????亥?甈? - ?箏?
*>      2009/11/3       撟恍?亦??璆剖?鞈?甈?摮?HR_SBA,HI_RTB KEY - ?箏?
*>      2009/12/15      瑼Ｗ???寧5蝝???蝚?蝝?甈? - ?箏?
*>      2010/2/23       ?啣??典????賊?鞈?頛詨(憓?ID:29雿輻) - ?箏?
*>      2010/3/15       ?啣?撖?rfid 鞈? log (憓?ID:30雿輻) - ?箏?
*>      2010/4/7        ?啣? rfid 鞈??啣?蝝??靽格 ID:30 雿輻) - ?箏?
*>      2010/4/8        ?啣? 頧?雿平 皜??OG蝝??靽格 ID:31 雿輻) - ?箏?
*>      2010/4/27       ??蝵脣????撓瘜冽雯?擃”?Ｙ?(靽格 ID:67 雿輻) - ?箏?
*>      2010/4/29       靽格 HIRFD log 撖急?鞈?(靽格 ID:30 雿輻) - ?箏?
*>      2010/5/7        (J1001046)??啁姘??曹蜓璈?HIS WIC鞈?DUPLICATE?迨憓?LOG餈質馱(憓?ID:32雿輻) - ?箏?
*>      2010/6/11       撟怠??怠???????豢? (ID:67) - ?箏?
*>      2010/11/24      (J1003562)"?啣?"???霈?風瑼??祈???- 暾餌?
*>      2010/12/13      (J1003678)??嚗??HIPDCF?澆蝯??隤方???- 暾餌?
*>      2010/12/20      (J1003302)??嚗????ａ隞日???Ｗ??桅?蝡???- 暾餌?
*>      2010/12/30      ??嚗DL?活瘚偌???舫?閬?- 暾餌?
*>      2011/01/26      (J1100144)??嚗??????芷閮餉? D銵函內?芷 - 暾餌?
*>      2011/02/09      (J1100363)??嚗?葆摮?PPF?瘥? - 暾餌?

*>      2011/02/18      ??嚗?葆??血??仙PF閮? - 暾餌?
*>      2011/02/18      ??嚗???閮?Ｘ?啣??交?(key)???閮?Ｘ - 暾餌?
*>      2011/02/18      ??嚗???隞ΕIS雿摨?撠瑼?- 暾餌?
*>      2011/6/14       ?慫嚗???嚗?LAYOUT, ?芣FON-ID 銝?, 雿ATA ?詨?
*>                      ?浚HEMO?思誘??敦撱嗡撓瑼?- ?飧
*>      2011/6/14       ?慫嚗???嚗?LAYOUT, ?芣FON-ID 銝?, 雿ATA ?詨?
*>                      ?浚HEMO ?思誘?敦??鞈??芷瑼?- ?飧
*>      2011/6/14       ?慫嚗???嚗?LAYOUT, ?芣FON-ID 銝?, 雿ATA ?詨?
*>                      ?浚HEMO ?喲?瞈曇?酉閮???- ?飧
*>      2011/11/16      (J1102489) FON-31-WRI-FUN憓?雿?唾???支??Ｙ隢?- ?
*>      2012/03/26      ?啣?-??敺??酉甈???臭誑頛詨嚗摮?閮餌????- ?
*>      2013/10/14      (J1201427)?憧嚗准亥那?釭???寞??嗆?霅 - ?勗?
*>      2013/01/30      ?芾祥?寞??蹂誨蝢斤? - ?
*>      2013/04/19      ?啁?甇颱滿霅??賂?敺株矽?梯”?澆??宏??憍宏??"?憓??瑕??耦"
*>      2015/01/27      ??嚗QIP雿鞈?頧?雿平??瑼OG(J1500160) - 瘛?
*>      2015/02/09      ??嚗?瘥??粹鋆閮箸蝣潮?瑼??貉身摰?J1500091) - 瘛?
*>      2015/03/02      ??嚗?瘥??粹鋆雿平?臬摮?(J1500091) - 瘛?
*>      2015/03/10      ??嚗憓?瘥??粹鋆鈭箏摮?LOG??嚗?Ｚ??駁?瑼?OG
*>      2016/12/19      ??嚗??靘?撠梢?喳鞈?蝝??2016/12/19)-暾餌?
*>      2014/11/06 35.?亙???-鈭?鋆撣貊????啣?)(2014/11/06) - ?
*>      2017/06/20 36.雿蝪∟??(?啣?撣? - 銝
*>      2017/08/22 37.??-?圈?恣摮?甈?憓耨 - 銝
*>      2017/09/15 5.?啣?擐??銋?獢???- 銝
*---------------------------------------------------------------------*
 FD FON-MST EXTERNAL.
 01 FON-MST-REC.
        02 FON-MST-KEY.
*>      霅蝣?
*>              (01.甈脣?撣喟?鈭? 02.?寞活雿??仿??犖 03.??啣?         04.?舐鼠?芣獢?
*>              05.UDL撱嗡撓鞈? 06.?閮箄?雿       07.UDL??鞈??芷  08.UD?喲?瞈曇?酉閮???
*>              09.憭挪?駁?    10.?蝑?鞈? 11.??雿撱嗡撓鞈? 12.??撣喳??
*>      13.閮剖??喳閮餉?<?孵???雿平>      14.靽格?餈??Ｗ????啣?閮?
*>      15.雿?亦?閮?<IPD-MST撖急?99銋??? 16.靽格??亥那頧??Ｖ?閮餉?
*>      17.?粹??亦Ⅱ隤???2> 18.靽格?粹閮箸??銵Ⅳ銋????
*>      19.雿?交?嗉???
*>      20.頧?鞈??神?航炊銋???CNT-MST REWRITE ERROR銋???
*>      21.?粹蝯董皜?憭望?銋???BED-MST REWRITE ERROR銋???
*>      22.?董??蝝???董??雿誥銋??Ｗ???
*>      23.甇颱滿霅???                  2002/12/21 (23??4?箏?銝蝑香鈭∟???
*>      24.甇颱滿霅??訾?甇颱滿??         2002/12/21 ,2004/8/17 憓??嗡?撠甇颱滿?蔣?蹂??曄??澈擃?瘜?
*>      25.霅辣?芷?                     2003/1/10
*>      26.雿?孵[蝯]撠?銋矽?撘??賊?隤芣? - ??恍撠甈?嚗隤踹??孵?]-NID06A1 (2007/11/17)
*>              0970428,yung,?啣??啣之???酉甈?
*>      27.?? 頝券?頧??,摮?銝?Ｗ??箸鞈? - (97022501)(J0800594)(2008/6/10) - ?旨
*>      28.?? 雿恣蝟餌絞???Ｗ?閮?J0802247)(2008/10/31) - ?旨
*>      29.?啣??典????賊?鞈?頛詨(2010/2/23) - ?箏?
*>      30.?啣?撖?rfid 鞈? log(2010/3/15) - ?箏?
*>      31.?啣? 頧?雿平 皜??OG蝝??2010/4/8) - ?箏?
*>      32.?啣? HIWICWCF 撖?WIC 鞈? LOG 蝝??2010/5/7) - ?箏?
*>      33.??敺??酉甈???臭誑頛詨嚗摮?閮餌????2012/03/26) - ?
*>      34.?芾祥?寞??蹂誨蝢斤? - ?
*>      35.?亙???-鈭?鋆撣貊????啣?)(2014/11/06) - ?
*>      36.雿蝪∟??(?啣?撣? - 銝
*>      37.??-?圈?恣摮?甈?憓耨 - 銝
*>      66.?閮箄?雿-瑼ａ?瑼Ｘ?湔憭望?蝝??J0901074.J0901229)(2009/5/27) - ?箏?
*>      65.撟恍?亦??璆剖?鞈?甈?摮?HR_SBA,HI_RTB KEY (2009/11/3) - ?箏?
*>      67.(?唬葉)???????亥?甈?(2009/10/22) - ?箏?

*>      68.(??)甇颱滿霅??貊????祈????亙??雿?2010/11/24) - 暾餌?
*>      69.(敶啣?)憓?雿?思誘???粹?????(2010/12/20) - 暾餌?
*>      70.(??鈭誨HIS)憓?鈭誨HIS雿摨?撠瑼?2011/02/18) - 暾餌?
*>      71.TQIP雿鞈?頧?雿平??瑼OG(2015/01/27)(J1500160) - 瘛?
*>      72.??-?粹鋆閮箸蝣潮?瑼??貉身摰?2015/02/09)(J1500091) - 瘛?
*>      73.??-?粹鋆雿平?臬摮?(2015/03/02)(J1500091) - 瘛?
*>      74.??-?粹鋆閮箸蝣潮?瑼??貊?OG瑼?2015/03/10)(J1500091) - 瘛?
*>      93.?啁????停?怎?梯?????2016/12/19)-暾餌?
*>      LK.?喳??閫???啣?蝝??2019/7/11)-暾餌?
*>      94.獢?-?????2019/08/29)-敶亙遠
*>      95.獢?-?犖摨???函???2020/01/09)-敶亙遠
*>      96.獢?-?喳??唳?UD?刻皜(2020/02/25)-敶亙遠
*>      80.????(2022/12/23)-敶亙遠
*>      AA.?亥那?瑼?
*>      C5.CHEMO ?思誘?敦撱嗡撓鞈? C7.CHEMO ?思誘?敦??鞈??芷  C8.CHEMO ?喲?瞈曇?酉閮???- ?飧
*>                      ?浚HEMO ?喲?瞈曇?酉閮???- ?飧
                03 FON-ID PIC X(02).
                03 FON-CODE PIC X(50).

*>              ??嚗?甈脣?撣喟?鈭箝?
                03 FON-01-CODE-KEY REDEFINES FON-CODE.
*>              雿摨?
                        04 FON-01-IPD-NO                PIC X(11).
                        04 FON-01-CODE-REC              PIC X(39).

*>              ??嚗???啣???
                03 FON-03-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-03-IPD-NO                PIC X(11).
*>                      頧??交?
                        04 FON-03-DATE                  PIC 9(07).
*>                      頧???
                        04 FON-03-TIME                  PIC 9(06).
                        04 FON-03-CODE-REC              PIC X(26).

*>              ??嚗??舐鼠?芣獢?
                03 FON-04-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-04-CASE-NO               PIC X(11).
*>                      ?
                        04 FON-04-ITEM                  PIC X(03).
*>                      隞?Ⅳ
                        04 FON-04-CODE                  PIC 9(03).
                        04 FON-04-CODE-REC              PIC X(33).

*>              ??嚗?嚗蛛慾嚗砍辣隡貉???
                03 FON-05-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-05-IPD-NO                PIC X(11).
*>                      ?摨?
                        04 FON-05-FEE-SEQ               PIC 9(03).

                        04 FON-05-CODE-REC              PIC X(36).

*>              ??嚗??閮箄?雿??
                03 FON-06-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?

                        04 FON-06-IPD-NO                PIC X(11).
*>                      ?閮箏???
                        04 FON-06-RO-NO                 PIC X(11).
                        04 FON-06-CODE-REC              PIC X(28).

*>              ??嚗?嚗蛛慾嚗砍辣隡貉???????扎?
                03 FON-07-CODE-KEY REDEFINES FON-CODE.
*>                      ?亙???
                        04 FON-07-ID                    PIC X(02).
*>                      ?喲
                        04 FON-07-SEND-DT               PIC 9(07).
*>                      ?喲 [0.?冽/1.??2.??3.?
                        04 FON-07-SEND-METH             PIC X(01).
*>                      摨?
                        04 FON-07-BED.
                                05 FON-07-BED-ROOM      PIC X(04).
                                05 FON-07-BED-NO        PIC X(02).
*>                      ?
                        04 FON-07-FEE-SEQ               PIC 9(03).
*>                      ?蔭隞?Ⅳ
                        04 FON-07-FEE-KEY               PIC X(09).
                        04 FON-07-CODE-REC              PIC X(22).

*>              ??嚗?UD?喲?瞈曇?酉閮???
                03 FON-08-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-08-IPD-NO                PIC X(11).
*>                      ?單?交?????
                        04 FON-08-SEND-DT               PIC 9(07).
                        04 FON-08-SEND-TIME             PIC 9(06).
                        04 FON-08-CODE-REC              PIC X(26).

*>              ??嚗?憭挪?駁???
                03 FON-09-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?(???雁霅?FON-09-TRN-IPD-NO)
                        04 FON-09-IPD-NO                PIC X(11).
*>                      憭挪甈⊥?? (EX . 999999 - 1)
                        04 FON-09-SEQ-V                 PIC 9(06).
                        04 FON-09-CODE-REC              PIC X(33).

*>              ??嚗??蝑?鞈???
                03 FON-10-CODE-KEY REDEFINES FON-CODE.
*>                      撟湔?
                        04 FON-10-YM                    PIC 9(05).
*>                      霅瑞?蝡?
                        04 FON-10-UNIT                  PIC X(05).
*>                      1.嚗蛛慾?鈭箸  2.?撐嚗斤??Ｖ犖??3.嚗蛛慾?亙?蝑 4.?冽??亙?蝑 5.??亦???
                        04 FON-10-DATA-ID               PIC 9(01).
                        04 FON-10-CODE-REC              PIC X(39).

*>              ??嚗???雿撱嗡撓鞈???
                03 FON-11-CODE-KEY REDEFINES FON-CODE.
*>                      ?風?Ⅳ
                        04 FON-11-PAT-NO                PIC 9(08).
                        04 FON-11-PRE-SAVE              PIC X(01).
*>                      ?駁??交???
                        04 FON-11-PRE-DT                PIC 9(07).

                        04 FON-11-PRE-TIME              PIC 9(06).
                        04 FON-11-CODE-REC              PIC X(28).

*>              ??嚗??????犖??
                03 FON-12-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-12-IPD-NO                PIC X(11).
                        04 FON-12-CODE-REC              PIC X(39).

*>              ??嚗?閮剖??喳閮餉???
                03 FON-13-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-13-IPD-NO                PIC X(11).
*>                      ?啣??交?????
                        04 FON-13-UPD-DT                PIC 9(07).
                        04 FON-13-UPD-TIME              PIC 9(06).
                        04 FON-13-CODE-REC              PIC X(26).

*>              ??嚗?靽格?餈??Ｗ????啣?閮???
                03 FON-14-CODE-KEY REDEFINES FON-CODE.
*>                      ?風?Ⅳ
                        04 FON-14-PAT-NO                PIC 9(08).
*>                      ?啣??交?????
                        04 FON-14-UPD-DT                PIC 9(07).
                        04 FON-14-UPD-TIME              PIC 9(06).
                        04 FON-14-CODE-REC              PIC X(29).

*>              ??嚗?雿?亦?閮???
                03 FON-15-CODE-KEY REDEFINES FON-CODE.
*>                      ?瑁??交?????
                        04 FON-15-DT               PIC 9(07).
                        04 FON-15-TIME             PIC 9(06).
*>                      雿摨?
                        04 FON-15-IPD-NO           PIC X(11).
                        04 FON-15-CODE-REC         PIC X(26).

*>              ??嚗?靽格??亥那頧??Ｖ?閮餉???
                03 FON-16-CODE-KEY REDEFINES FON-CODE.
*>                      ?閮箏???
                        04 FON-16-RO-NO            PIC X(11).
*>                      靽格?交?????
                        04 FON-16-DT               PIC 9(07).
                        04 FON-16-TIME             PIC 9(06).

                        04 FON-16-CODE-REC         PIC X(26).

*>              ??嚗?靽格?粹閮箸??銵Ⅳ銋????
                03 FON-18-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-18-IPD-NO           PIC X(11).
*>                      靽格?交?????
                        04 FON-18-UPD-DT           PIC 9(07).
                        04 FON-18-UPD-TIME         PIC 9(06).

                        04 FON-18-CODE-REC         PIC X(26).

*>              ??嚗?雿?交?嗉???

                03 FON-19-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-19-IPD-NO PIC X(11).
*>                      靽格蝚昧甈∩??EY (999999 - 蝚昧甈?
                        04 FON-19-SEQ-V            PIC 9(06).

                        04 FON-19-CODE-REC         PIC X(33).

*>              ??嚗?頧??神?航炊銋???
                03 FON-20-CODE-KEY REDEFINES FON-CODE.
*>                      CNT-KEY ??
                        04 FON-20-CNT-KEY          PIC X(50).

*>              ??嚗??粹蝯董皜?憭望?銋???
                03 FON-21-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-21-IPD-NO           PIC X(11).
*>                      ???交?
                        04 FON-21-DATE             PIC 9(07).
*>                      ????
                        04 FON-21-TIME             PIC 9(06).
                        04 FON-21-CODE-REC         PIC X(26).

*>              ??嚗??董??閮???
                03 FON-22-CODE-KEY REDEFINES FON-CODE.
*>                      ?董??雿誥銋??Ｗ???
                        04 FON-22-IPD-NO           PIC X(11).
                        04 FON-22-CODE-REC         PIC X(39).

*>              2002/12/21 04:13銝?
*>              ??嚗?甇颱滿霅??詻?
                03 FON-23-CODE-KEY REDEFINES FON-CODE.
*>                      ?風?Ⅳ
                        04 FON-23-PAT-NO           PIC 9(08).
                        04 FON-23-CODE-REC         PIC X(42).

*>              ??嚗?甇颱滿霅??訾?甇颱滿????
                03 FON-24-CODE-KEY REDEFINES FON-CODE.
*>                      ?風?Ⅳ
                        04 FON-24-PAT-NO           PIC 9(08).
                        04 FON-24-CODE-REC         PIC X(42).

*>              2003/1/10 11:11AM
*>              ??嚗?霅辣?芷???
                03 FON-25-CODE-KEY REDEFINES FON-CODE.
*>                      ?董??雿誥銋??Ｗ???
                        04 FON-25-IPD-NO           PIC X(11).
                        04 FON-25-CODE-REC         PIC X(39).

*>              2007/11/19
*>              ??嚗???恍?孵?銋隤踹??孵?]??
                03 FON-26-CODE-KEY REDEFINES FON-CODE.
*>                      ?孵?銋??Ｗ???
                        04 FON-26-IPD-NO                PIC X(11).
*>                      ?孵?銋??孵???
                        04 FON-26-ODR-NO                PIC X(11).
*>                      蝯

                        04 FON-26-POWDER                PIC X(01).
                        04 FON-26-CODE-REC              PIC X(27).

*>              2008/6/10
*>              ??嚗?頝券?頧?,???Ｗ??箸鞈???
                03 FON-27-CODE-KEY REDEFINES FON-CODE.
*>                      頧?敺?雿摨?
                        04 FON-27-IPD-NO                PIC X(11).
                        04 FON-27-CODE-REC              PIC X(39).

*>              2008/10/31
*>              ??嚗?雿?酉??
                03 FON-28-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-28-IPD-NO                PIC X(11).
                        04 FON-28-CODE-REC              PIC X(39).

*>              2010/2/23 ?啣??典????賊?鞈?頛詨
*>              ??嚗??典????賊?鞈?頛詨??
                03 FON-29-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-29-IPD-NO                PIC X(11).
                        04 FON-29-CODE-REC              PIC X(39).

*>               2010/3/15 ?啣?撖?rfid 鞈? log
*>              ??嚗?撖?rfid 鞈? log蝝??  (50??
                03 FON-30-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?                                (1:11)
                        04 FON-30-IPD-NO                PIC X(11).
*>                      撖俠OG?頂蝯?(0.?風鞈?頧? 1.雿?唾? 2.頧? 3.?粹 5.?摨?6.?董 7.?粹頧??8.?摨?璆?9.???啣虜
*>                                                              (12:1)
                        04 FON-30-WRI-SYS               PIC X(01).
*>                      2010/4/7 ???啣???暺key???       (13:16)
                        04 FON-30-DTTI.
                                05 FON-30-DATE          PIC 9(08).
                                05 FON-30-TIME          PIC 9(08).
*>                      ??                                    (29:22)
*>                              2010/4/7 (38) ??(22)
                        04 FON-30-CODE-REC              PIC X(22).

*>               2010/4/8 ?啣? 頧?雿平 皜??OG蝝??
*>              ??嚗?頧?雿平 皜??OG蝝??  (50??
                03 FON-31-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?                                (1:11)
                        04 FON-31-IPD-NO                PIC X(11).
*>                      頧?雿平??摨??暺?(1.頧? 2.?芷頧?鞈? 3.撠? 4.?湔頧?8.雿?唾? 9.?芷雿?唾?)
*>                                                              (12:1)
                        04 FON-31-WRI-FUN               PIC X(01).
*>                      雿平?瑁???暺?                         (13:16)
                        04 FON-31-DTTI.
                                05 FON-31-DATE  PIC 9(08).
                                05 FON-31-TIME  PIC 9(08).
*>                      ??                                    (29:22)
                        04      FON-31-CODE-REC         PIC X(22).

*>              2010/5/7 ?啣? HIWICWCF 撖?WIC 鞈? LOG 蝝??
*>              ??嚗?HIWICWCF 撖?WIC 鞈? LOG 蝝??  (50??

                03 FON-32-CODE-KEY REDEFINES FON-CODE.
*>                      霅?霅 1.?之 2.蝳? 3.???咱 4.畾? (01:01)
                        04 FON-32-WIC-ID                PIC X(01).
*>                      霅?蝺刻?                                (02:15)
                        04 FON-32-WIC-NO                PIC X(15).
*>                      撱箸?蝟餌絞                                (17:03)
                        04 FON-32-WIC-CRE-SYS   PIC X(03).
*>                      雿平?瑁???暺?                 (20:16)
                        04 FON-32-DTTI.
                                05 FON-32-DATE          PIC 9(08).
                                05 FON-32-TIME          PIC 9(08).
*>                      ??                                    (36:15)
                        04 FON-32-CODE-REC              PIC X(15).

*>              2012/03/26 ??敺??酉甈???臭誑頛詨嚗摮?閮餌????
*>              ??嚗???敺???  (50??
                03 FON-33-CODE-KEY REDEFINES FON-CODE.
*>                      ??摨?
                        04 FON-33-BED.
*>                              ?                            (01:04)
                                05 FON-33-BED-ROOM      PIC X(04).
*>                              摨?                            (05:02)
                                05 FON-33-BED-NO        PIC X(02).
*>                      ??                                    (07:44)
                        04 FON-32-CODE-REC              PIC X(44).

*>              2013/01/30 ?芾祥?寞??蹂誨蝢斤?
*>              ??嚗??芾祥?寞?鞈???
                03 FON-34-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-34-IPD-NO           PIC X(11).
*>                      ?摨?
                        04 FON-34-FEE-SEQ          PIC 9(03).
                        04 FON-34-CODE-REC         PIC X(36).

*>              2014/11/06 ?亙???-鈭?鋆撣貊????啣?)
*>              ??嚗?鈭?鋆撣貊???
                03 FON-35-CODE-KEY REDEFINES FON-CODE.
*>                      ?亙葦 (1:5)
                        04 FON-35-DR-NO PIC X(05).
*>                      鞈?霅(01.撖拇 02.?貉 03.蝯西) (6:2)
                        04 FON-35-ID PIC X(02).
*>                      雿摨? (8:11)
                        04 FON-35-IPD-NO PIC X(11).
*>                      ?蔭隞?Ⅳ (19:9)
                        04 FON-35-PRS-ID PIC X(09).
*>                      ?? (28:23)
                        04 FON-35-CODE-REC PIC X(23).

*>              ??嚗?雿蝪∟????
                03 FON-36-CODE-KEY REDEFINES FON-CODE.
*>                      ?風??(1:8)
                        04 FON-36-PAT-NO PIC 9(8).
*>                      雿摨? (9:11)
                        04 FON-36-IPD-NO PIC X(11).
*>                      ?? (20:31)
                        04 FON-36-CODE-REC PIC X(31).


*>              ??嚗???-?圈?恣摮?甈???
                03 FON-37-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨? (1:11)
                        04 FON-37-IPD-NO PIC X(11).
*>                      ?風??(12:8)
                        04 FON-37-PAT-NO PIC 9(8).
*>                      ?? (20:31)
                        04 FON-37-CODE-REC PIC X(31).

*>              2009/5/27
*>              ??嚗??閮箄?雿-瑼ａ?瑼Ｘ?湔憭望?蝝??50??
                03 FON-66-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?                (01:11)
                        04 FON-66-IPD-NO                PIC X(11).
*>                      ?閮箏???               (12:11)
                        04 FON-66-RO-NO         PIC X(11).
*>                      ?思誘?株?                (23:08)
                        04 FON-66-HTCHK-CHK-NO  PIC X(08).
*>                      撖怎???蝵?1.REWRITE?航炊?神蝝??2.霈???唳炎撽??神蝝??
*>                                 3.頝?撖急???挾敺?蝵殷??其??斗?臬???瑁??湔瑼ａ?瑼?撘?  (31:01)
                        04 FON-66-WRITE-POSITION        PIC X(01).
*>                      撖怎???? ??        (32:16)
                        04 FON-66-WRI-DTTI.
                                05 FON-66-WRI-DATE      PIC 9(08).
                                05 FON-66-WRI-TIME      PIC 9(08).
*>                      ??                    (48:03)
                        04 FON-66-CODE-REC              PIC X(03).


*>       65. 撟恍?亦??璆剖?鞈?甈?摮?HR_SBA,HI_RTB KEY (2009/11/3) - ?箏?
*>              ??嚗? HI_RTB KEY??50??
                03 FON-65-CODE-KEY REDEFINES FON-CODE.
                        04 FON-65-RTB-KEY.
*>                              雿摨?
                                05      FON-65-RTB-IPD-NO.
*>                                      雿?交?
                                        06      FON-65-RTB-IPD-DATE     PIC 9(7).
*>                                      雿瘚偌??
                                        06      FON-65-RTB-IPD-SEQ      PIC 9(4).
                                05      FON-65-RTB-ODR-NO.
*>                                      ?????交?
                                        06      FON-65-RTB-INS-DATE     PIC 9(7).
*>                                      ???瘚偌??
                                        06      FON-65-RTB-ODR-SEQ      PIC 9(3).
*>                              ?蔭瘚偌??
                                05      FON-65-RTB-FEE-SEQ              PIC 9(3).
                        04 FON-65-CODE-REC                      PIC X(26).


*>       67.(?唬葉)???????亥?甈?(2009/10/22) - ?箏?
*>              ??嚗????????亥?甈???50??
                03 FON-67-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-67-IPD-NO PIC X(11).
*>                      ?摨?
                        04 FON-67-ODR-NO PIC X(11).

*>                      ?蔭瘚偌??
                        04 FON-67-FEE-SEQ               PIC 9(03).
*>                      ??
                        04 FON-67-CODE-REC              PIC X(25).

*>              ?慼嚗∴??亥那?瑼?
                03 FON-AA-CODE-KEY REDEFINES FON-CODE.
*>                      撟湔?
                        04 FON-AA-YM               PIC 9(05).
*>                      蝘
                        04 FON-AA-DPT              PIC X(04).
                        04 FON-AA-CODE-REC         PIC X(41).
*>              ?慰嚗ｇ??亥那?亙瑼?
                03 FON-BB-CODE-KEY REDEFINES FON-CODE.
*>                      ?交?
                        04 FON-BB-DT               PIC 9(07).
*>                      蝘
                        04 FON-BB-DPT              PIC X(04).
                        04 FON-BB-CODE-REC         PIC X(39).
*>              ??嚗?甇颱滿霅??訾?甇餉?祈???
                03 FON-68-CODE-KEY REDEFINES FON-CODE.
*>                      ?風?Ⅳ
                        04 FON-68-PAT-NO           PIC 9(08).
                        04 FON-68-CODE-REC         PIC X(42).
*>              ??嚗?雿?思誘???粹???
                03 FON-69-CODE-KEY REDEFINES FON-CODE.
*>                      ?風?Ⅳ
                        04 FON-69-PAT-NO           PIC 9(08).
                        04 FON-69-IPD-NO           PIC X(11).
*>                      2011/02/18 閮?甇瑟活???批捆
*>                      ???交?
                        04 FON-69-OPEN-DT               PIC 9(07).
                        04 FON-69-OPEN-TI.
                                05 FON-69-OPEN-HH       PIC 9(02).
                                05 FON-69-OPEN-MN       PIC 9(02).
                                05 FON-69-OPEN-SS       PIC 9(02).
                        04 FON-69-CODE-REC         PIC X(18).
*>              ??嚗???鈭誨HIS雿摨?撠瑼?
                03 FON-70-CODE-KEY REDEFINES FON-CODE.
*>                      ??鈭誨?風?Ⅳ
                        04 FON-70-PAT-NO                PIC 9(08).
*>                      ??鈭誨?摨?(?Ｗ?(2)+閰脩?????Ｘ活摨?4))
                        04 FON-70-PAT-SEQ          PIC X(06).
                        04 FON-70-CODE-REC         PIC X(36).

*>               2015/01/27 TQIP雿鞈?頧?雿平??瑼OG
*>              ??嚗?TQIP雿鞈?頧?蝝??
                03 FON-71-CODE-KEY REDEFINES FON-CODE.
*>                      頧?撟湔?
                        04 FON-71-TURN-DATE             PIC 9(05).
*>                      ?瑁??交?/??(韏?
                        04 FON-71-DTTI.
                                05 FON-71-UPD-DT                PIC 9(07).
                                05 FON-71-UPD-TIME              PIC 9(06).
*>                      ??32??
                        04 FON-71-CODE-REC         PIC X(32).


*>               2015/02/09     ??-?粹鋆閮箸蝣潮?瑼???
*>              ??嚗???-?粹鋆閮箸蝣潮?瑼身摰?
                03 FON-72-CODE-KEY REDEFINES FON-CODE.
*>                              ?粹鋆隞?Ⅳ嚗?
                        04 FON-72-ID                    PIC 9(1).
*>                              ??49??
                        04 FON-72-CODE-REC              PIC X(49).

*>               2015/03/02     ??-?粹鋆雿平?臬摮?
*>              ??嚗???-?粹鋆雿平?臬摮?(?粹鋆蝝????
                03 FON-73-CODE-KEY     REDEFINES   FON-CODE.
*>              雿霅 ??A.??雿 B.霅瑞?銋振 C.?仿??扯風 X.?舐鼠?芣獢???
*>                              ??a.?芷??雿 b.?芷霅瑞?銋振 c.?芷?仿??扯風  ??
                        04 FON-73-LIVE-ID               PIC X(01).
*>                      雿摨?
                        04 FON-73-IPD-NO.
                                05 FON-73-IPD-DT        PIC 9(07).
                                05 FON-73-IPD-SEQ       PIC 9(04).
*>                              ??38??
                        04 FON-73-CODE-REC     PIC X(38).

*>              2015/03/10      ??嚗?Ｚ??駁?瑼?OG
                03 FON-74-CODE-KEY REDEFINES FON-CODE.
*>                      ?瑁??交?/??
                        04 FON-74-DTTI.
                                05 FON-74-UPD-DT                PIC 9(07).
                                05 FON-74-UPD-TIME              PIC 9(06).
*>                      ??37??
                        04 FON-74-CODE-REC                      PIC X(37).

*>              2016/12/19
*>              ??嚗??啁????停?怎?梯?????
                03      FON-93-CODE-KEY     REDEFINES   FON-CODE.
*>                      ?風?Ⅳ
                        04      FON-93-PAT-NO           PIC 9(08).
*>                      1.?閮?2.雿
                        04      FON-93-ID               PIC X(01).
*>                      鞎餌撟湔?
                        04      FON-93-APY-YM           PIC 9(05).
*>                      ?喳憿   1:? 2:鋆
                        04      FON-93-APY-PART         PIC X(01).
*>                      鋆甈⊥
                        04      FON-93-APP-CNT          PIC 9(01).
*>                      獢辣
                        04      FON-93-CASE-ID          PIC X(02).
*>                      瘚偌??
                        04      FON-93-SEQ-NO           PIC 9(06).
*>                      ??
                        04      FON-93-CODE-REC         PIC X(26).

*>              ?憧嚗哨??亥那?釭???寞??嗆?霅??
                03 FON-EM-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?
                        04 FON-EM-IPD-NO.
                                05 FON-EM-IPD-DT        PIC 9(07).
                                05 FON-EM-IPD-SEQ       PIC 9(04).
*>                      ?風?Ⅳ

                        04 FON-EM-PAT-NO                PIC 9(08).
                        04 FON-EM-CODE-REC              PIC X(31).

*>              ?憔嚗恬??喳??/閫???啣?閮???2019/7/11
                03      FON-LK-CODE-KEY     REDEFINES   FON-CODE.
*>                      ?雿???I:雿;O:?閮?
                        04      FON-LK-IO               PIC X(01).
*>                      鞎餌撟湔?
                        04      FON-LK-YM               PIC 9(05).
*>                      靽格?交?????
                        04      FON-LK-DT               PIC 9(07).
                        04      FON-LK-TIME             PIC 9(06).
                        04      FON-LK-CODE-REC         PIC X(31).
*>              ??嚗??????
                03 FON-94-CODE-KEY REDEFINES FON-CODE.
*>                      ?風??(1:8)
                        04 FON-94-PAT-NO                PIC 9(8).
*>                      雿摨? (9:11)
                        04 FON-94-IPD-NO                PIC X(11).
*>                      ?交?(20:7)
                        04 FON-94-DATE                  PIC 9(07).
*>                      ?? (27:24)
                        04 FON-94-CODE-REC              PIC X(24).
*>              ??嚗??犖摨???函???
                03 FON-95-CODE-KEY REDEFINES FON-CODE.
*>                      ?風??(1:8)
                        04 FON-95-PAT-NO                PIC 9(08).
*>                      敺??駁??交? (9:7)
                        04 FON-95-WAT-DT                PIC 9(07).
*>                      敺??駁??? (16:6)
                        04 FON-95-WAT-TIME              PIC 9(06).
*>                      ?? (22:29)
                        04 FON-95-CODE-REC              PIC X(29).
*>              ??嚗??喳??唳?UD?刻皜??
                03 FON-96-CODE-KEY REDEFINES FON-CODE.
*>                      ?風??(1:7)
                        04 FON-96-DATE                  PIC 9(07).
*>                      霅瑞?蝡?(8:5)
                        04 FON-96-UNIT                  PIC X(05).
*>                      ?? (13:38)
                        04 FON-96-CODE-REC              PIC X(38).
*>              ??嚗???????
                03 FON-80-CODE-KEY REDEFINES FON-CODE.
*>                      雿摨?(1:11)
                        04 FON-80-IPD-NO                PIC 9(11).
*>                      ?摨?(12:11)
                        04 FON-80-ODR-NO                PIC 9(11).
*>                      瘚偌??23:3)
                        04 FON-80-SEQ                   PIC 9(03).
*>                      ??(26:25)
                        04 FON-80-CODE-REC              PIC X(25).
*>      ??KEY
*$XFD USE GROUP , VAR-LENGTH
        02 FON-TRN                                 PIC X(50).

*>      ??嚗?甈脣?撣喟?鈭箝?
        02 FON-01-TRN REDEFINES FON-TRN.

*>              ?粹?交?
                03 FON-01-OUT-DT                        PIC 9(07).
                03 FON-01-TRN-REC                       PIC X(43).
*>      ??嚗?嚗蛛慾嚗砍辣隡貉???
        02 FON-05-TRN REDEFINES FON-TRN.
*>              10蝣潭?獢???HRLOG4-G1-UDL-SEQ)
                03 FON-05-G1-UDL-SEQ            PIC 9(10).
*>              2017/09/15 ?啣?擐??銋?獢???
*>              ?啣?擐??銋?獢???
                03 FON-05-ECB-FILE-NO           PIC 9(03).
                03 FON-05-TRN-REC               PIC X(37).

*>      ??嚗??閮箄?雿??
        02 FON-06-TRN REDEFINES FON-TRN.
*>              ?閮箏???
                03 FON-06-TRN-RO-NO PIC X(11).
                03 FON-06-TRN-REC PIC X(39).

*>      ??嚗?UD?喲?瞈曇?酉閮???
        02 FON-08-TRN REDEFINES FON-TRN.
*>              ?單?交?????
                03 FON-08-TRN-SEND-DT              PIC 9(07).
                03 FON-08-TRN-SEND-TIME            PIC 9(06).
                03 FON-08-TRN-REC                  PIC X(37).

*>      ??嚗?憭挪?駁???
        02 FON-09-TRN REDEFINES FON-TRN.
*>              雿摨?
                03 FON-09-TRN-IPD-NO               PIC X(11).
*>              撖阡?頧??交?????
                03 FON-09-BACK-DTTI.
                        04 FON-09-BACK-DT          PIC 9(07).
                        04 FON-09-BACK-TIME        PIC 9(06).
                03 FON-09-TRN-REC                  PIC X(26).

*>      ??嚗???雿撱嗡撓鞈???
        02 FON-11-TRN REDEFINES FON-TRN.
*>              雿摨?
                03 FON-11-IPD-NO.
                        04 FON-11-IPD-DATE              PIC 9(07).
                        04 FON-11-IPD-SEQ               PIC 9(04).
*>              ?駁?蝘
                03 FON-11-PRE-DPT               PIC X(04).
                03 FON-11-TRN-REC               PIC X(35).

*>      ??嚗?雿?亦?閮???
        02 FON-15-TRN REDEFINES   FON-TRN.
*>              ?亦???
                03 FON-15-DAY-DT                        PIC 9(07).
                03 FON-15-TRN-REC                  PIC X(43).

*>      ??嚗?雿?交?嗉???
        02 FON-19-TRN REDEFINES FON-TRN.
*>              雿摨?
                03 FON-19-TRN-IPD-NO            PIC X(11).
*>              靽格蝚昧甈?
                03 FON-19-SEQ                   PIC 9(06).

                03 FON-19-TRN-REC                  PIC X(33).

*>      2002/12/21 04:16銝?
*>      ??嚗?甇颱滿霅??詻?
        02 FON-23-TRN REDEFINES FON-TRN.
*>              甇颱滿?交?
                03 FON-23-DIE-DT PIC 9(07).
                03 FON-23-DIE-TIME.
                        04 FON-23-DIE-HH PIC 9(02).
                        04 FON-23-DIE-MN PIC 9(02).
                03 FON-23-TRN-REC PIC X(39).

*>      2014/11/06 ?亙???-鈭?鋆撣貊????啣?)
*>      ??嚗?鈭?鋆撣貊???
        02 FON-35-TRN REDEFINES FON-TRN.
*>              ?亙葦
                03 FON-35-TRN-DR-NO PIC X(05).
*>              蝯西?交?
                03 FON-35-TRN-SEND-DT PIC 9(07).
*>              ?臬撌脖耨?寧撣貊??酉閮?Y:銵函內撌脩?靽格?????
                03 FON-35-TRN-MOD-MARK PIC X(01).
*>              ??
                03 FON-35-TRN-REC PIC X(37).

*>      ??嚗???-?圈?恣摮?甈???
        02 FON-37-TRN REDEFINES FON-TRN.
*>              ?圈?恣?啣??交? (1:7)
                03 FON-37-MOD-DATE PIC 9(7).
*>              ?圈?恣?啣??? (8:6)
                03 FON-37-MOD-TIME PIC 9(6).
*>              ?? (14:37)
                03 FON-37-TRN-REC PIC X(37).

*>       65. 撟恍?亦??璆剖?鞈?甈?摮?HR_SBA,HI_RTB KEY (2009/11/3) - ?箏?
*>      ??嚗?HR_SBA KEY??50??
        02 FON-65-TRN REDEFINES FON-TRN.
                03      FON-65-SBA-KEY.
*>                      雿摨?
                        04      FON-65-SBA-IPD-NO.
*>                              雿?交?
                                05      FON-65-SBA-IPD-DATE         PIC 9(07).
*>                              雿瘚偌??
                                05      FON-65-SBA-IPD-SEQ          PIC 9(04).
                        04      FON-65-SBA-ODR-NO.
*>                              ??亦隢??
                                05      FON-65-SBA-INS-DATE         PIC 9(07).
*>                              ??亦隢?瘞渲?
                                05      FON-65-SBA-ODR-SEQ          PIC 9(04).
                03      FON-65-TRN-REC          PIC X(28).

*>      ?慼嚗∴??亥那?瑼?
        02 FON-AA-TRN REDEFINES FON-TRN.
*>              蝘
                03      FON-AA-TRN-DPT                  PIC X(11).
                03      FON-AA-TRN-REC                  PIC X(39).
*>      ?B嚗亥那?亙瑼?
        02 FON-BB-TRN REDEFINES FON-TRN.

*>              蝘
                03 FON-BB-TRN-DPT                       PIC X(11).
                03 FON-BB-TRN-REC                  PIC X(39).

*>               2015/01/27 TQIP雿鞈?頧?雿平??瑼OG
*>              ??嚗?TQIP雿鞈?頧?蝝??
        02              FON-71-TRN     REDEFINES               FON-TRN.
*>                      ?瑁?鈭箏隞?Ⅳ
                        03      FON-71-UPD-UID           PIC X(05).
*>                      ??45??
                        03      FON-71-TRN-REC           PIC X(45).

*>              2015/03/10 ?粹鋆???啣?LOG
*>              ??嚗??粹鋆???啣?LOG??
        02              FON-74-TRN REDEFINES FON-TRN.
*>                      ?瑁?鈭箏隞?Ⅳ
                        03      FON-74-UPD-UID PIC X(05).
*>                      ??45??
                        03      FON-74-TRN-REC PIC X(45).

*>              2016/12/19
*>              ??嚗??啁????停?怎?梯?????
        02      FON-93-TRN     REDEFINES               FON-TRN.
*>                      1.?閮?2.雿
                        03      FON-93-ID-TRN            PIC X(01).
*>                      鞎餌撟湔?
                        03      FON-93-APY-YM-TRN        PIC 9(05).
*>                      ?喳憿   1:? 2:鋆
                        03      FON-93-APY-PART-TRN      PIC X(01).
*>                      鋆甈⊥
                        03      FON-93-APP-CNT-TRN       PIC 9(01).
*>                      ??45??
                        03      FON-93-TRN-REC           PIC X(42).
*>              ??嚗??犖摨???函???
        02      FON-95-TRN REDEFINES FON-TRN.
*>                      ?犖?桀???其?蝵?(1:1)
                        03 FON-95-FROM                  PIC 9(1).
*>                      雿摨? (2:11)
                        03 FON-95-IPD-NO.
*>                              雿?交?
                                04      FON-95-IPD-DATE PIC 9(07).
*>                              雿瘚偌??
                                04      FON-95-IPD-SEQ  PIC 9(04).
                        03 FON-95-TRN-REC               PIC X(38).

*$XFD USE GROUP , VAR-LENGTH
*>      鞈???
        02 FON-DATA                                PIC X(250).
*
*>      ??嚗???啣???
        02 FON-03-DATA     REDEFINES               FON-DATA.
*>              ?唳??乩誨蝣?
                03 FON-03-NEW-CARE                 PIC X(01).
*>              ???乩誨蝣?
                03 FON-03-OLD-CARE                 PIC X(01).
*>              ?啣?蝣? [1] ?仿 [2] 頧??
                03 FON-03-UPD-CODE                 PIC X(01).

*>              ?啣??交?
                03 FON-03-UPD-DATE                 PIC 9(07).
*>              ?啣???
                03 FON-03-UPD-TIME                 PIC 9(06).
*>              ?啣?鈭箔誨蝣?
                03 FON-03-UPD-UID                  PIC X(05).
*>              ?啣毀瘞?銵?
                03 FON-03-NEW-BARTH-SCORE          PIC 9(03).
*>              ?唬?鞈渡?摨?
                03 FON-03-NEW-DEGREE               PIC X(01).
*>              ?毀瘞?銵?
                03 FON-03-OLD-BARTH-SCORE          PIC 9(03).
*>              ??鞈渡?摨?
                03 FON-03-OLD-DEGREE               PIC X(01).
                03 FON-03-DATA-REC                 PIC X(221).


*>      ??嚗?嚗蛛慾嚗砍辣隡貉???
*>      ??嚗?嚗蛛慾嚗砍辣隡貉???????扎?
        02 FON-05-DATA REDEFINES FON-DATA.
*>              ?酉 (1:50)
                03 FON-05-REMARK                PIC X(50).
*>              UD?拚??賊??? (51:04)
                03 FON-05-QTY1                  PIC 9(04).
*>              UD?拚??賊??? (55:04)
                03 FON-05-QTY2                  PIC 9(04).
*>              ST (59:01)
                03 FON-05-ST                    PIC X(01).
*>              ?臬閬?UD?喲??(60:01)
                03 FON-05-UD-CHK-YN             PIC X(01).
*>              ?亙?蝤函?甈? (61:01)
                03 FON-05-POWDER-YN             PIC X(01).
*>              ?亙??那蝯?嚗??"Y"??N") (62:01)
                03 FON-05-SENDING-YN    PIC X(01).
*>              蝺抵??唳??交?蝥?唳??亙??? (63:09)
                03 FON-05-BUFFER-DATA.
*>                      ?交?
                        04 FON-05-BUFFER-DT PIC 9(07).
*>                      撠?
                        04 FON-05-BUFFER-TI PIC 9(02).
*>      92/04/22 ?啣??恣??蝝隢???恣蝟餌絞??             (72:11)
                03 FON-05-CAN1-NO.
                        04 FON-05-CAN1-DT               PIC 9(07).
                        04 FON-05-CAN1-SEQ              PIC 9(04).
*>      95/07/13 ?啣??恣??蝝??冽?(雿蝟餌絞??(???瘙?5042001) (83:09)
                03 FON-05-HC-LAST-DT            PIC 9(07).
                03 FON-05-HC-LAST-TI            PIC 9(02).
*>      2006/9/30 ?啁姘?閮?蝬剛風雿平 MATCH UDL-MST??         (92:16)
                03 FON-05-SYS-DTTI.
                        04 FON-05-SYS-DATE              PIC 9(8).
                        04 FON-05-SYS-TIME              PIC 9(8).
*>              0970428,yung,?啣??啣之???酉甈?80??                  (108:80)
                03 FON-05-HICMI-NOTE            PIC X(80).
*>              0980225 ?啣?擐???孵???                             (188:11)
                03 FON-05-ICA-ODR-NO.
                        04 FON-05-ICA-INS-DATE PIC 9(7).
                        04 FON-05-ICA-ODR-SEQ PIC 9(4).

*>              2009/7/16 05.?啣??蹂誨?蔭(J0901262)             (199:9)
                03 FON-05-REPLACE-FEE-KEY               PIC X(9).
*>              2010/7/6 ?思誘??蝯??交???憪???????     (208:9)
                03 FON-05-ORI-END-DT            PIC 9(07).
                03 FON-05-ORI-END-TI            PIC 9(02).
*>              2009/7/16       X(52) -> X(43)
*>              2010/7/6        X(43) -> X(34)
*>              2010/11/9 ?芸??亥???K" (217:1)
                03 FON-05-SELF-DRUG                     PIC X(01).
*>      2010/12/30      UDL?活瘚偌???舫?閬?(218:5)
                03 FON-05-UDL-SEQ                       PIC 9(05).
*>      2011/01/26 ??蝝?方酉閮?D銵函內?芷 (223:1)
                03 FON-05-ANT-DEL                       PIC X(01).
*>      2011/02/09 ??葆摮?PPF?瘥? (224:5)
                03 FON-05-PPF-DIS-RATE          PIC 9(3)V9(2).
*>              2011/02/18 ??葆??血??仙PF閮? (229:1)
                03 FON-05-PPF-YN                        PIC X(1).
*>              ?? (230:21)
                03 FON-05-DATA-REC                      PIC X(21).
*>      2015/11/27      ???HEMO?交?雿歇?∩蝙?剁??隞亦REDEFINES
                03 FON-05-CHEMO-REC REDEFINES FON-05-DATA-REC.
*>      2011/04/20 chemo?喲?嚗hemo?唳活??
                        04 FON-05-HYGUDL-RX-UQTY.
                                05 FON-05-HYGUDL-RX-UQTY1               PIC 9(06).
                                05 FON-05-HYGUDL-RX-UQTY2               PIC 9(06).
*>      2011/6/14 M:銵函內CHEMO UD & 霅瑞?蝡?亥???
                                05 FON-05-HYGUDL-CHEMO-MARK             PIC X(01).
*>      2011/6/14 CHEMO 瘚偌??
                                05 FON-05-HYGUDL-SN-NO                  PIC 9(04).
*>      2011/6/14 CHEMO 霅(C:?HEMO, U:?D, S:?風??)
                                05 FON-05-HYGUDL-CHEMO-ID               PIC X(01).
*>      2011/6/14 CHEMO 摨?
                                05 FON-05-HYGUDL-SEQ-NO                 PIC 9(02).
                                05 FON-05-CHEMO-FILLER                  PIC X(01).
                03 FON-05-MED-REC REDEFINES FON-05-DATA-REC.
*>      2015/12/25 ?唳活??
                        04 FON-05-RX-N-UQTY.
                                05 FON-05-RX-N-UQTY1            PIC 9(05).
                                05 FON-05-RX-N-UQTY2            PIC 9(05).
*>              2018/06/13 憓???蝝祟?詨???血????仿?
                        04 FON-05-ANT-B                         PIC X(01).
*>              2019/05/20 yan 憓?閮餉?蝝?偌?D蝯西
                        04 FON-05-UD-GIVE                       PIC X(01).
                        04 FON-05-MED-FILLER                    PIC X(09).

*>      ??嚗??閮箄?雿??
        02 FON-06-DATA REDEFINES FON-DATA.
*>              撠?銋??Ｚ??孵???蝚砌?撘?
                03 FON-06-ODR-NO PIC X(11).
*>              ?頧??交?????雿?雿?唾? HI_WRI.PRC)
                03 FON-06-CRE-DATE PIC 9(07).
                03 FON-06-CRE-TIME PIC 9(06).
                03 FON-06-CRE-USER PIC X(05).
*>              ?頧??Ｙ?雿?蝞??交?????雿??閮箄?雿 HITRNBF.CBL)
                03 FON-06-ODR-DATE PIC 9(07).
                03 FON-06-ODR-TIME PIC 9(06).
                03 FON-06-ODR-USER PIC X(05).

*>              撠?銋??Ｚ??孵???蝚砌?撘?
                03 FON-06-ODR-NO2 PIC X(11).
*>              ?閮箔耨?寡澈隞質酉閮?Y); 靽格?頧?銋酉閮???
                03 FON-06-CHG-CLA PIC X(01).
*>              ?閮箏????????[B] HITRNPF ?寞活?Ｙ?)
                03 FON-06-CRE-ID PIC X(01).
*>              2004/12/25 ?Ｗ???
                03 FON-06-FROM-THID PIC X(02).
*>              2004/12/25 X(190)?(188)
                03 FON-06-DATA-REC PIC X(188).

*>      ??嚗?UD?喲?瞈曇?酉閮???
        02 FON-08-DATA REDEFINES FON-DATA.
*>              ?亙???
                03 FON-08-ID PIC X(02).
                03 FON-08-DATA-REC PIC X(248).

*>      ??嚗?憭挪?駁???
        02 FON-09-DATA REDEFINES FON-DATA.
*>              (1.憭挪??.憭 3.??ａ)
                03 FON-09-ID PIC X(01).
*>              憭挪?交?????
                03 FON-09-OFF-DTTI.
                        04 FON-09-OFF-DT PIC 9(07).
                        04 FON-09-OFF-TIME PIC 9(06).
*>              ??頧??交?????
                03 FON-09-PRE-DTTI.
                        04 FON-09-PRE-DT PIC 9(07).
                        04 FON-09-PRE-TIME PIC 9(06).
                03 FON-09-DATA-REC PIC X(223).

*>      ??嚗??蝑?鞈???
        02 FON-10-DATA REDEFINES FON-DATA.
                03 FON-10-CNT-TBL.
*>                      嚗?嚗?憭?
                        04 FON-10-CNT-TBL1 OCCURS 31 TIMES.
                                05 FON-10-CNT PIC 9(05).
*>                      ??
                        04 FON-10-MON-CNT PIC 9(06).

                03 FON-10-DATA-REC PIC X(89).

*>      ??嚗???雿撱嗡撓鞈???
        02 FON-11-DATA REDEFINES FON-DATA.
*>              ?酉
                03      FON-11-REMARK                   PIC X(40).
*>              閮箸
                03      FON-11-IDZS-TBL.
                        04      FON-11-IDZS OCCURS 5 TIMES PIC X(07).
*>              ??唳????
                03      FON-11-ARRIVE-DT                PIC 9(07).
                03      FON-11-ARRIVE-TIME              PIC 9(04).
*>              ?????交?,隤芣?
                03      FON-11-OPE-DT                   PIC 9(07).
                03      FON-11-OPE-DOC                  PIC X(10).
*>              撱踹?撠??扳?潛?38摨佗慫隞乩?(Y/N)
                03      FON-11-OVER-38                  PIC X(01).

*>              雿??憭拇?????
                03      FON-11-FEVER                    PIC X(01).
*>              ?餈?勗??銋??
                03      FON-11-2-WEEK                   PIC X(01).
*>              ?臬?箄??
                03      FON-11-PNEUMONIA                PIC X(01).
*>              ?臬??貊?餈?
                03      FON-11-SOFFOCATE                PIC X(01).
*>              ?臬?交抒?蝬?蝬??
                03      FON-11-NERVE                    PIC X(01).
*>              ?臬?交扯??
                03      FON-11-RUN                              PIC X(01).
*>              ?臬?交折???
                03      FON-11-ICTERUS                  PIC X(01).
*>              ???駁???
                03      FON-11-USER-ID                  PIC X(05).
*>              ?啣???
                03      FON-11-DATE                     PIC 9(07).
*>              ?啣???
                03      FON-11-TIME                     PIC 9(06).
*>              頨思遢
                03      FON-11-CLA                      PIC X(04).
*>              ?摨?
                03      FON-11-BED-BED          PIC X(06).
*>              2009/1/12 ???怠葦隞?Ⅳ(銝剝)
                03      FON-11-MJ-DR-CHINMED    PIC X(04).
*>              2009/1/12 ??蝘隞?Ⅳ(銝剝)
                03      FON-11-DPT                      PIC X(04).
*>              2016/1/1  ICD-10閮箸 (??HI_PREKF.LNK 瘥?雿?(8))
                03      FON-11-ICD10-TBL.
                        04      FON-11-ICD10 OCCURS 5  TIMES    PIC X(08).
*>              2016/03/31  (J1600157)?啣???蝔桅? 1.銝?祉???2.?風?
                03      FON-11-BED-KIND                 PIC 9(01).
*>              2016/03/31  (J1600157)?啣?霅 1.雿 2.???.?亥那
                03      FON-11-ID                       PIC X(01).
*>              2019/10/23 ?啣??靘? 1.??2.?閮?3.?亥那
                03      FON-11-FROM-SEL              PIC 9(01).
*>              2019/10/23 ?啣??亥那???交???
                03      FON-11-EREG-DT               PIC 9(07).
                03      FON-11-EREG-TIME.
                        04      FON-11-EREG-HH       PIC 9(02).
                        04      FON-11-EREG-MM       PIC 9(02).
*>              2022/07/27 敶亙遠 憓?摨???
                03      FON-11-BED-ORDER.
                        04      FON-11-BED-ORDER1       PIC X(01).
                        04      FON-11-BED-ORDER2       PIC X(01).
                        04      FON-11-BED-ORDER3       PIC X(01).
                        04      FON-11-BED-ORDER4       PIC X(01).
                        04      FON-11-BED-ORDER5       PIC X(01).
*>              2022/07/27 敶亙遠 ??瑼Ｘ?交?
                03      FON-11-CHK-DT                   PIC 9(07).
*>              2022/07/27 敶亙遠 ?飛瘝餌??交?
                03      FON-11-CHEM-DT                  PIC 9(07).
*>              2004/1/27 X(147) -> X(121)
*>              2009/1/12 X(111) -> X(103)
*>              2016/1/1  X(103) -> X(63) ICD-10閮箸
*>              2016/03/31  X(63) -> X(61) ??蝔桅?

*>              2019/10/23  X(61) -> X(60) ?靘?
*>              2019/10/23  X(60) -> X(49) ?亥那???交???
*>              2022/07/27      X(49) -> X(30) 撅??憓?甈?
                03 FON-11-DATA-REC PIC X(30).

*>      ??嚗??????犖??
        02      FON-12-DATA     REDEFINES               FON-DATA.
*>              ??銋蝙?刻誨??
                03      FON-12-USR-ID                   PIC X(05).
*>              銝?銋??
                03      FON-12-BLD-DT                   PIC 9(07).
                03      FON-12-DATA-REC                 PIC X(238).

*>      ??嚗?閮剖??喳閮餉???
        02      FON-13-DATA     REDEFINES               FON-DATA.
*>              ?啣?銋蝙?刻誨??
                03      FON-13-USER-ID                  PIC X(05).
*>              ?啣?敺??喳閮餉?
                03      FON-13-NEW-APY-LOCK             PIC X(01).
*>              ?啣????喳閮餉?
                03      FON-13-OLD-APY-LOCK             PIC X(01).

                03      FON-13-DATA-REC                 PIC X(243).

*>      ??嚗?靽格?餈??Ｗ????啣?閮???
        02      FON-14-DATA     REDEFINES               FON-DATA.
*>              ?啣?銋蝙?刻誨??
                03      FON-14-USER-ID                  PIC X(05).
*>              ?啣????餈??Ｗ???
                03      FON-14-OLD-IKEY-LST             PIC X(11).
*>              ?啣?敺??餈??Ｗ???
                03      FON-14-NEW-IKEY-LST             PIC X(11).
*>              ?啣??餈??Ｗ????( 1.?桃?蝬剛風 2.?湔?啣? 3.?亦??啣?)
                03      FON-14-UPD-FUN                  PIC X(01).

                03      FON-14-DATA-REC                 PIC X(222).

*>      ??嚗?雿?亦?閮???
        02      FON-15-DATA     REDEFINES               FON-DATA.
*>              IPD-MST STATUS
                03      FON-15-STATUS                   PIC X(02).

                03      FON-15-DATA-REC                 PIC X(248).

*>      ??嚗?靽格??亥那頧??Ｖ?閮餉???
        02      FON-16-DATA     REDEFINES               FON-DATA.
*>              瑼?霅(1.HO_MREG  2.HO_MDG1)
                03      FON-16-FILE-ID                  PIC X(01).
*>              ?啣?銋蝙?刻誨??
                03      FON-16-USER-ID                  PIC X(05).
*>              ??頧?閮餉?
                03      FON-16-OLD-MARK                 PIC X(01).
*>              ?圈?頧?閮餉?
                03      FON-16-NEW-MARK                 PIC X(01).

                03      FON-16-DATA-REC                 PIC X(242).


*>      ??嚗?靽格?粹閮箸??銵Ⅳ銋????
        02      FON-18-DATA     REDEFINES               FON-DATA.
*>              ?湔?霅(1.?粹鋆雿平 2.?孵?獢辣雿平 3.?? 4.?曄???)
                03      FON-18-FUN-ID                   PIC X(01).
*>              ?啣?銋蝙?刻誨???迂)
                03      FON-18-USER-ID                  PIC X(10).
*>              ?湔???粹閮箸(1嚚?)
                03      FON-18-BEFORE-ODZS-TBL.
                        04     FON-18-BEFORE-ODZS OCCURS 5  TIMES       PIC X(07).
*>              ?湔敺??粹閮箸(1嚚?)
                03      FON-18-AFTER-ODZS-TBL.
                        04     FON-18-AFTER-ODZS  OCCURS 5  TIMES       PIC X(07).
*>              ?湔????蝣?
                03      FON-18-BEFORE-OPP-TBL.
                        04     FON-18-BEFORE-OPP OCCURS 5  TIMES        PIC X(07).
*>              ?湔敺???蝣?
                03      FON-18-AFTER-OPP-TBL.
                        04     FON-18-AFTER-OPP  OCCURS 5  TIMES        PIC X(07).
*>              ?湔???粹閮箸(6 嚚?0)
                03      FON-18-BEFORE-ODZS6-TBL.
                        04     FON-18-BEFORE-ODZS6 OCCURS 5  TIMES      PIC X(07).
*>              ?湔敺??粹閮箸(6 嚚?0)
                03      FON-18-AFTER-ODZS6-TBL.
                        04     FON-18-AFTER-ODZS6  OCCURS 5  TIMES      PIC X(07).

                03      FON-18-DATA-REC                 PIC X(29).

*>      ??嚗?雿?交?嗉???
        02      FON-19-DATA     REDEFINES               FON-DATA.
*>              ??撱園雿憭拇
                03      FON-19-EXTEND-DAYS              PIC 9(04).
*>              ??撱園雿?交?
                03      FON-19-EXTEND-DATE              PIC 9(07).
*>              ?駁???
                03      FON-19-USER-ID                  PIC X(05).
*>              ?駁??交?
                03      FON-19-UPD-DATE                 PIC 9(07).
*>              ?駁???
                03      FON-19-UPD-TIME                 PIC 9(06).
*>              撱園雿??
                03      FON-19-REASON-TBL.
                        04     FON-19-REASON-TBL1  OCCURS 5  TIMES.
                                05      FON-19-REASON-ID        PIC X(03).
                                05      FON-19-REASON-DOC       PIC X(30).

                03      FON-19-DATA-REC                 PIC X(56).

*>      ??嚗?頧?鞈??神?航炊銋???
        02      FON-20-DATA     REDEFINES               FON-DATA.
*>              ?神CNT-MST-R 銋TATUS
                03      FON-20-CNT-STATUS               PIC X(02).
*>              ?渡?CNT-MST-R 銋???
                03      FON-20-CNT-DATA                 PIC X(248).

*>      ??嚗??粹蝯董皜?憭望?銋???BED-MST REWRITE ERROR銋???      ??
        02      FON-21-DATA     REDEFINES               FON-DATA.
*>              甈脫?摨?摨?

                03      FON-21-BED.
                        05      FON-21-BED-BED          PIC X(04).
                        05      FON-21-BED-NO           PIC X(02).
*>              1->READ ERROR, 2->READ OK 雿PD-NO 銝?, 3-> READ OK, 銝PD-NO?詨?
                03      FON-21-ERR-ID                   PIC X(01).
*>              READ BED-MST ??Ⅳ
                03      FON-21-READ-STATUS              PIC X(02).
*>              REWRITE BED-MST ??Ⅳ(FON-21-ERR-ID = "3" ????
                03      FON-21-UPDATE-STATUS            PIC X(02).
*>              ?桀?雿?銋??Ｗ???
                03      FON-21-BED-IPD-NO               PIC X(11).
*>              ??
                03      FON-21-DATA-REC                 PIC X(228).

*>      ??嚗??董??閮???
        02      FON-22-DATA     REDEFINES               FON-DATA.
*>              ?風??
                03      FON-22-PAT-NO                   PIC 9(08).
*>              ?怠葦
                03      FON-22-DR-NO                    PIC X(04).
*>              蝘
                03      FON-22-DEPT-NO                  PIC X(04).
*>              頨怠?
                03      FON-22-A-CLA                    PIC X(04).
*>              ??
                03      FON-22-DATA-REC                 PIC X(230).

*>      2002/12/21 04:16銝?
*>      ??嚗?甇颱滿霅??詻?
        02      FON-23-DATA     REDEFINES               FON-DATA.
*>              甇颱滿?圈? [1]?恍[2]閮箸?[3]?拍?[4]?芸?[5]?嗅?
                03      FON-23-DIE-POS                  PIC X(01).
*>              甇颱滿雿?
                03      FON-23-DIE-ADDR                 PIC X(50).
*>              甇颱滿蝔桅? [1]?香??嗆香[2]??甇蒜3]?芣捏[4]隞捏[5]銝底
                03      FON-23-DIE-GP                   PIC X(01).
*>              ?潛??單香鈭⊥??交???
                03      FON-23-DIE-TIME1                PIC X(08).
                03      FON-23-DIE-TIME2                PIC X(08).
                03      FON-23-DIE-TIME3                PIC X(08).
                03      FON-23-DIE-TIME4                PIC X(08).
*>              ?箇???
                03      FON-23-BIR-TIME.
                        04      FON-23-BIR-HH           PIC 9(02).
                        04      FON-23-BIR-MT           PIC 9(02).
*>              ?瑟平
                03      FON-23-JOB1                     PIC X(20).
*>              ?瑕?
                03      FON-23-JOB2                     PIC X(20).
*>              憍宏
                03      FON-23-MAR                      PIC X(01).
*>              ?怠葦
                03      FON-23-DIE-DR                   PIC X(04).
*>              撱箸???
                03      FON-23-DIE-CRE-DT               PIC 9(07).
*>              撱箸???
                03      FON-23-DIE-DUTY-ID              PIC X(05).

*>              ?啣??瑕??耦 [1]?潮??颱?撟湔?瑕?  [2]?瑕?銝剜香鈭? [3]?瑕?蝯迫????42憭拙甇颱滿
*>                           [4]?瑕?蝯迫????43憭抵銝撟游甇颱滿 [5]銝?璆??颱?撟湔?行摮?
                03      FON-23-PREG                     PIC X(01).
*>              2019/11/21 YAN 蝝?CD蝔???
                03      FON-23-RCD-PROG                 PIC X(10).
*>              2019/11/21 YAN 蝝?CD KEY
                03      FON-23-RCD-KEY.
                        04      FON-23-RCD-ID           PIC X(01).
                        04      FON-23-RCD-DATE         PIC 9(08).
                        04      FON-23-RCD-TIME         PIC 9(08).
                        04      FON-23-RCD-NETNO        PIC X(20).
*>              ??
                03      FON-23-DATA-REC                 PIC X(57).

*>      2002/12/22
*>      ??嚗?甇颱滿霅??訾?甇颱滿????
        02      FON-24-DATA     REDEFINES               FON-DATA.
*>              ?湔甇颱滿??,?甇颱滿??
                03      FON-24-DIE-MRES.
                        04      FON-24-DIE-MRES1        PIC X(50).
                        04      FON-24-DIE-MRES2        PIC X(50).
                        04      FON-24-DIE-DRES1        PIC X(50).
                        04      FON-24-DIE-DRES2        PIC X(50).
*>              2004/8/17 ?嗡?撠甇颱滿?蔣?蹂??曄??澈擃?瘜?
                        04      FON-24-DIE-DRES3        PIC X(50).

*>      2003/1/10
*>      ??嚗?霅辣?芷???
        02      FON-25-DATA     REDEFINES               FON-DATA.
*>              ??
                03      FON-25-DATA-REC                 PIC X(250).

*>      2007/11/19
*>      ??嚗???恍?孵?銋隤踹??孵?]??
        02      FON-26-DATA     REDEFINES               FON-DATA.
*>              隤踹??孵?
                03      FON-26-PREPARE                  PIC X(01).
*>              蝯西撅隤芣?
                03      FON-26-MED-DES                  PIC X(60).
*>              蝯衣?銝餉牧??
                03      FON-26-WONER-DES1               PIC X(30).
*>              蝯衣?銝餉牧??
                03      FON-26-WONER-DES2               PIC X(30).
*>              蝯衣?銝餉牧??
                03      FON-26-WONER-DES3               PIC X(30).
*>              2008/3/5
*>              蝯甈∪???瘥活? ??憿?
                03    FON-26-SRV-QTY                    PIC 9(3).
*>              ??
                03      FON-26-DATA-REC                 PIC X(96).

*>      2008/6/10
*>      ??嚗?頝券?頧?,???Ｗ??箸鞈???
        02      FON-27-DATA     REDEFINES               FON-DATA.
*>              ???Ｗ?蝣?
                03      FON-27-HOSP             PIC X(01).
*>              ???Ｗ?摨?

                03      FON-27-BED.
                        04      FON-27-BED-ROOM PIC X(04).
                        04      FON-27-BED-NO   PIC X(02).
*>              蝘
                03      FON-27-DPT                      PIC X(04).
*>              頨思遢??
                03      FON-27-CLA                      PIC X(04).
*>              ?怎?(隞?Ⅳ)
                03      FON-27-MJ-DR                    PIC X(04).
                03      FON-27-DATA-REC                 PIC X(231).

*>      2008/10/31
*>      ??嚗?雿?酉??
        02      FON-28-DATA     REDEFINES               FON-DATA.
*>              ?酉?批捆
                03      FON-28-IPD-NOTE                 PIC X(100).
*>              ??
                03      FON-28-DATA-REC                 PIC X(150).

*>      2010/2/23 ?啣??典????賊?鞈?頛詨
*>      ??嚗??典????賊?鞈?頛詨??
        02      FON-29-DATA     REDEFINES               FON-DATA.
*>              憓????憭?韐?(0:憓??;1:憓???)      (1:1)
                03      FON-29-APPARATUS-TYPE           PIC X(01).
*>              憓????韐?隞?Ⅳ [0507]                   (2:10)
                03      FON-29-APPARATUS-HOSP           PIC X(10).
*>              憓???交?                                    (12:7)
                03      FON-29-APPARATUS-DATE           PIC 9(07).
*>              憓???D                                    (19:10)
                03      FON-29-APPARATUS-IDNO           PIC X(10).
*>              ??                                            (29:222)
                03      FON-29-DATA-REC                 PIC X(222).

*>      2010/3/15 ?啣?撖?rfid 鞈? log
*>      ??嚗?撖?rfid 鞈? log蝝??
        02      FON-30-DATA     REDEFINES               FON-DATA.
*>              雿?唾??神瑼? W-SAVE-PROCEDURE-OK ????Y/ )        (01:01)
                03      FON-30-300KF-SAVE-P-OK          PIC X(01).
*>              LOG1 蝝????                                  (02:13)
                03      FON-30-LOG1-DTTI.
                        04      FON-30-LOG1-DATE        PIC 9(07).
                        04      FON-30-LOG1-TIME        PIC 9(06).
*>              "HIRFD1CF"?批神-05-瑼???LOG蝝????A:?撖俘FD瑼???(15:01)
                03      FON-30-RFD1CF-BEFORE-SAVE-05    PIC X(01).
*>              LOG2 蝝????                                  (16:13)
                03      FON-30-LOG2-DTTI.
                        04      FON-30-LOG2-DATE        PIC 9(07).
                        04      FON-30-LOG2-TIME        PIC 9(06).
*>              "HIRFD1CF"?批神-05-瑼???STATUS 蝝??           (29:02)
                03      FON-30-RFD1CF-SAVE-STATUS       PIC X(02).
*>              LOG3 蝝????                                  (31:13)
                03      FON-30-LOG3-DTTI.
                        04      FON-30-LOG3-DATE        PIC 9(07).
                        04      FON-30-LOG3-TIME        PIC 9(06).
*>              蝝???淙RD1CF?IRFD瑼???                    (44:02)
                03      FON-30-LOG-HIRFD-OPEN-STATUS    PIC X(02).
*>              蝝???淙RD1CF?EN瑼???                      (46:02)

                03      FON-30-LOG-SEN-OPEN-STATUS      PIC X(02).
*>      2010/4/7 蝝??HIRFD ?批捆 **************************************************************
*>              憪?                                            (48:12)
                03      FON-30-PAT-NAME                 PIC X(12).
*>              ?箇??交?                                        (60:7)
                03      FON-30-BIRTH-DT                 PIC S9(07).
*>              摨?                                            (67:6)
                03      FON-30-BED.
                        04      FON-30-BED-ROOM         PIC X(04).
                        04      FON-30-BED-NO           PIC X(02).
*>              霅瑞?蝡?                                         (73:5)
                03      FON-30-UNIT                     PIC X(05).
*>              雿?交?                                        (78:7)
                03      FON-30-DT                       PIC X(07).
*>              ?粹?交?                                        (85:7)
                03      FON-30-OUT-DT                   PIC X(07).
*>              ?敺?甈∩耨?孵???1.雿?唾? 2.頧? 3.?粹 5.?摨?D.?芷) (92:1)
                03      FON-30-ORI                      PIC X(01).
*>              頨怠?霅?                                        (93:10)
                03      FON-30-IDNO                     PIC X(10).
*>              ??閮餉?                                        (103:1)(Y/ )
                03      FON-30-SEN-YN                   PIC X(01).
*>              銵??                                           (104:2)
                03      FON-30-BLOOD                    PIC X(02).
*>              ?活雿摨?                                    (106:11)
                03      FON-30-IPD-NO-L.
                        04      FON-30-IPD-DT-L         PIC 9(07).
                        04      FON-30-IPD-SEQ-L        PIC 9(04).
*>              ??雿??                                     (117:7)
                03      FON-30-ORG-DT                   PIC 9(07).
*>      2010/4/7 蝝??HIRFD ?批捆 **********************************************************
*>      2010/4/12       鋆??其??脩?撘?敺停擐砌?撖思??og蝝??
*>              ?臬?脣HIRFD1CF      Y:?脣HIRFD1CF        (124:01)
                03      FON-30-INTO-HIRFD1CF-YN         PIC X(01).
*>      2010/4/29       憓???00KF撖亭ON??賣??TATUS?航炊嚗?
*>                      ???芰???47"."48"."49"嚗?22"."00"?賜???OK"嚗?
*>                      ?????銋?撠勗?賜瘜??鈭?     (125:02)
                03      FON-30-300KF-WRITE-FON-STATUS   PIC X(02).
*>      2010/4/29       蝝???淙RD1CF?IDNR瑼???            (127:02)
                03      FON-30-LOG-HIDNR-OPEN-STATUS    PIC X(02).

*>              ??                                            (129:122)
*>                      2010/4/7        (203) ??(127)
*>                      2010/4/12       (127) ??(126)
*>                      2010/4/29       (126) ??(124) ??(122)
                03      FON-30-DATA-REC                 PIC X(122).

*>               2010/4/8 ?啣? 頧?雿平 皜??OG蝝??
*>      ??嚗?頧?雿平 皜??OG蝝??(250??
        02      FON-31-DATA     REDEFINES               FON-DATA.
*>              F-WRI-NEW ?湔?啣??風??鞈?????           (01:02)
                03      FON-31-AFTER-WRINEW-STATUS      PIC X(02).
*>              F-WRI-OLD 霈??摨??????                   (03:02)
                03      FON-31-READ-OLDBED-STATUS       PIC X(02).
*>              ??鞈?皜征???瘜?(" "蝛箏?, "1"敺? , "2"雿?) (05:01)
                03      FON-31-OLDBEDB-BED-STATUS       PIC X(01).
*>              ??鞈?皜征?????甇瑁?蝣?                   (06:08)

                03      FON-31-OLDBEDB-BED-PAT-NO       PIC 9(08).
*>              ??鞈?皜征??雿????Ｗ???               (14:11)
                03      FON-31-OLDBEDB-BED-IPD-NO       PIC X(11).
*>              ??鞈?皜征敺?撖急?敺???瘜?(" "蝛箏?, "1"敺? , "2"雿?) (25:01)
                03      FON-31-OLDBEDA-BED-STATUS       PIC X(01).
*>              ??鞈?皜征敺?撖急?敺????甇瑁?蝣?           (26:08)
                03      FON-31-OLDBEDA-BED-PAT-NO       PIC 9(08).
*>              ??鞈?皜征敺?撖急?敺????Ｘ???Ｗ???       (34:11)
                03      FON-31-OLDBEDA-BED-IPD-NO       PIC X(11).
*>              ??鞈?皜征敺?撖急?敺??神瑼???               (45:02)
                03      FON-31-OLDBEDA-WRI-STATUS       PIC X(02).
*>2010/12/13    HHIPDCF????( W-LNK-YN NOT = "Y" W-LNK-NOTE ????  (47:51)
                03      FON-31-HHIPD-LNK-YN             PIC     X(01).
                03      FON-31-HHIPD-LNK-NOTE           PIC     X(50).
*>              ??                                            (98:153)
                03      FON-31-DATA-REC                 PIC X(153).

*>              2010/5/7 ?啣? HIWICWCF 撖?WIC 鞈? LOG 蝝??
*>      ??嚗?HIWICWCF 撖?WIC 鞈? LOG 蝝??(250??
        02      FON-32-DATA     REDEFINES               FON-DATA.
*>              撱箸?靘??臬?舐??C?∩葉頧鞈???[Y/ ]      (01:01)
                03      FON-32-WIC-FROM-IC              PIC X(01).
*>              ?風?Ⅳ                                        (02:08)
                03      FON-32-WIC-PAT-NO               PIC 9(08).
*>              ?敺??                                     (10:05)
                03      FON-32-WIC-UPD-USID             PIC X(05).
*>              雿平蝺函Ⅳ蝟餌絞??+ 雿平蝺函Ⅳ霅                   (15:23)
                03 FON-32-RUN-PSG.
                        04 FON-32-RUN-PSID              PIC X(03).
                        04 FON-32-RUN-PSNO              PIC X(20).
*>              ??                                            (38:213)
                03      FON-32-DATA-REC                 PIC X(213).

*>              2012/03/26 ??敺??酉甈???臭誑頛詨嚗摮?閮餌????
*>      ??嚗???敺???(250??
        02      FON-33-DATA     REDEFINES               FON-DATA.
*>              ??敺??酉鞈?                                (01:50)
                03      FON-33-MEMO-DATA                PIC X(50).
*>              ??                                            (51:250)
                03      FON-33-DATA-REC                 PIC X(200).

*>              2013/01/30 ?芾祥?寞??蹂誨蝢斤?
*>      ??嚗??芾祥?寞???(250??
        02      FON-34-DATA     REDEFINES               FON-DATA.
*>              ?芾祥?寞??蹂誨蝢斤?                                (01:03)
                03      FON-34-REPLACE-GROUP            PIC X(03).
*>              ??                                            (04:247)
                03      FON-34-DATA-REC                 PIC X(247).

*>      2014/11/06 ?亙???-鈭?鋆撣貊????啣?)
*>      ??嚗?鈭?鋆撣貊???
        02      FON-35-DATA REDEFINES FON-DATA.
*>              ?風??(01:08)
                03 FON-35-PAT-NO PIC 9(09).
*>              ?摨? (09:11)
                03 FON-35-ODR-NO PIC X(11).
*>              摨? (20:03)

                03 FON-35-SEQ PIC 9(03).
*>              ?亥?摨? (23:20)
                03 FON-35-BAG-NO PIC X(20).
*>              ?? (43:207)
                03 FON-35-DATA-REC PIC X(207).

*>      ??嚗?雿蝪∟????
        02 FON-36-DATA REDEFINES FON-DATA.
*>              ?? (1:250)
                03 FON-36-DATA-REC PIC X(250).

*>      ??嚗???-?圈?恣摮?甈???
        02 FON-37-DATA REDEFINES FON-DATA.
*>              ?圈?恣撱箸??交? (1:7)
                03 FON-37-DATE PIC 9(7).
*>              ?圈?恣撱箸??? (8:6)
                03 FON-37-TIME PIC 9(6).
*>              ?圈?恣??霅瑞?蝡?(14:5)
                03 FON-37-UNIT PIC X(5).
*>              ?圈?恣??摨? (19:6)
                03 FON-37-BED PIC X(6).
*>              ?? (25:226)
                03 FON-37-DATA-REC PIC X(226).

*>       65. 撟恍?亦??璆剖?鞈?甈?摮?HR_SBA,HI_RTB KEY (2009/11/3) - ?箏?
*>      ??嚗???亦??璆剖?鞈???250??
        02      FON-65-DATA     REDEFINES               FON-DATA.
*>              ?酉?批捆 (150??
                03      FON-65-LOG-NOTE.
*>                      ?芷閮餉? D.銵典??                      (1:1)
                        04      FON-65-DEL-MARK                 PIC X.
*>                      FILLER                                  (2:149)
                        04      FON-65-LOG-NOTE-FILLER          PIC X(149).
*>              ?? (100??
                03      FON-65-DATA-REC.
                        04      FON-65-DATA-REC-FILLER          PIC X(100).

*>      2009/5/27
*>      ??嚗??閮箄?雿-瑼ａ?瑼Ｘ?湔憭望?蝝??(250??
        02      FON-66-DATA     REDEFINES               FON-DATA.
*>              ?酉?批捆 (100??
                03      FON-66-LOG-NOTE.
*>                      ?風??                 (01:08)
                        04      FON-66-PAT-NO           PIC 9(08).
*>                      撖怎???(?∪極蝺刻?)     (09:05)
                        04      FON-66-WRI-USER         PIC X(05).
*>                      蝺楝蝺刻?                (14:05)
                        04      FON-66-WRI-LINE-NO      PIC X(05).
*>                      ?摨?                (19:11)
                        04      FON-66-ODR-NO           PIC 9(11).
*>                      摮??????           (30:02)
                        04      FON-66-HTCHK-STATUS     PIC X(02).
*>                      ?思誘?交?                (32:08)
                        04      FON-66-HTCHK-IP-DATE    PIC 9(08).
*>                      FILLER                  (40:61)
                        04      FON-66-LOG-NOTE-FILLER  PIC X(61).
*>              ?? (150??

                03      FON-66-DATA-REC                 PIC X(150).

*>       67.(?唬葉)???????亥?甈?(2009/10/22) - ?箏?
*>              ??嚗????????亥?甈???250??
        02      FON-67-DATA     REDEFINES               FON-DATA.
*>              ?酉?批捆 (150??
                03      FON-67-LOG-NOTE.
*>                      ???交?                                (1:7)
                        04      FON-67-DATE-START               PIC 9(7).
*>                      蝯??交?                                (8:7)
                        04      FON-67-DATE-END                 PIC 9(7).
*>                      ??                                    (15:6)
                        04      FON-67-QTY1                     PIC 9(4)V9(2).
*>                      皞嗅??蔭隞?Ⅳ                            (21:9)
                        04      FON-67-SOLVENT-PRS              PIC X(09).
*>                      皞嗅?擃?                                (30:6)
                        04      FON-67-VOLUME                   PIC 9(04)V9(2).
*>                      瘜典??孵?(隞?Ⅳ)                          (36:2)
                        04      FON-67-INJECT-WAY               PIC X(02).
*>                      ?賣???                                (38:3)
                        04      FON-67-INJECT-HOURS             PIC 9(02)V9.
*>                      頨恍?                                    (41:4)
                        04      FON-67-HEIGHT                   PIC 9(03)V9.
*>                      擃?                                    (45:4)
                        04      FON-67-WEIGHT                   PIC 9(03)V9.
*>                      ?芷閮餉? D.銵典??                      (49:1)
                        04      FON-67-DEL-MARK                 PIC X.
*>                      2010/4/27 ??蝵脣????撓瘜冽雯?擃”?Ｙ? (50:3)
                        04      FON-67-BSA                      PIC 9V9(2).
*>                      2010/4/28 ????豢?                  (53:10)
                        04      FON-67-RENAL-DATA               PIC X(10).
*>                      2010/6/11 撟怠??怠???                  (63:7)
                        04      FON-67-ODR-QTY1                 PIC 9(5)V9(2).
*>                      2010/6/11 撟怠????賣??               (70:40)
                        04      FON-67-LIVER-FUNCTION-DATA      PIC X(40).
*>                      FILLER                                  (110:41)
*>                      2010/4/27 (101) ??(98)
*>                      2010/4/28  (98) ??(88)
*>                      2010/6/11  (88) ??(41)
                        04      FON-67-LOG-NOTE-FILLER          PIC X(41).
*>              ?? (100??
                03      FON-67-DATA-REC.
                        04      FON-67-DATA-REC-FILLER          PIC X(100).

*>      ?慼嚗∴??亥那?瑼?
        02      FON-AA-DATA     REDEFINES               FON-DATA.
*>              ?亥那鈭箸(?賜,撠?,憭批?)
                03      FON-AA-EME1-TBL.
                        04      FON-AA-EME1-NUM OCCURS 3 TIMES  PIC 9(04).

*>              [?亥那鈭箸 = 撟喳虜??+ ?]
*>              撟喳虜???賜,撠?,憭批?)
                03      FON-AA-EME21-TBL.
                        04      FON-AA-EME21-NUM OCCURS 3 TIMES PIC 9(04).

*>              ?(?賜,撠?,憭批?)
                03      FON-AA-EME22-TBL.

                        04      FON-AA-EME22-NUM OCCURS 3 TIMES PIC 9(04).

*>              ???孵?(嚗?嚗?, ?芰?堆?嚚?嚗? 嚗?銵典隞?)
                03      FON-AA-EME3-TBL.
                        04      FON-AA-EME3-NUM OCCURS 30 TIMES PIC 9(04).


*>              銝銋炎?瑕?憿?( ?賜,撠?,憭批?  ; 嚗?嚗?
                03      FON-AA-EME4-TBL.
                        04      FON-AA-EME4-TBL1 OCCURS 3 TIMES.
                                05      FON-AA-EME4-NUM OCCURS 4 TIMES  PIC 9(04).

*>              119  EME-119 鈭箸205(霅瑞?蝡?
                03      FON-AA-EME5-NUM                 PIC 9(4).

*>              2009/12/15      瑼Ｗ???寧5蝝???蝚?蝝?甈?
*>              蝚?蝝?銝銋炎?瑕?憿?( ?賜,撠?,憭批?  ; 5)
                03      FON-AA-EME4-5-TBL.
                        04      FON-AA-EME4-5-NUM OCCURS 3 TIMES        PIC 9(04).

*>              2004/5/10 03      FON-AA-DATA-REC                 PIC X(46).
*>              2004/5/10       X(46) -> X(42)
*>              2009/12/15      X(42) -> X(30)
                03      FON-AA-DATA-REC                 PIC X(30).

*>      ??嚗?甇颱滿霅??詻?
        02      FON-68-DATA     REDEFINES               FON-DATA.
*>              甇餉???
                03      FON-68-DIE-NAME                 PIC X(12).
*>              甇餉澈隞質?
                03      FON-68-DIE-IDNO                 PIC X(10).
*>              甇餉???
                03      FON-68-DIE-BIRTH-DT             PIC S9(07).
*>              甇餉批
                03      FON-68-DIE-SEX                  PIC X(01).
*>              甇餉蝐?
                03      FON-68-DIE-ADDR                 PIC X(40).
                03      FON-68-DIE-ADDR1                PIC X(40).
*>              甇餉?蝐?
                03      FON-68-DIE-ORIG                 PIC X(01).
*>              ??
                03      FON-68-DATA-REC                 PIC X(139).
*>      ??嚗?雿?思誘???粹???
        02      FON-69-DATA     REDEFINES               FON-DATA.
*>              憪?
                03      FON-69-PAT-NAME                 PIC X(12).
*>              ???粹??
                03      FON-69-EXPECT-OUT-DT            PIC 9(07).
*>              ???怠葦
                03      FON-69-OPEN-DR                  PIC X(05).
*>              ??
                03      FON-69-DATA-REC                 PIC X(226).

*>      ??嚗???鈭誨HIS雿摨?撠瑼?
        02      FON-70-DATA     REDEFINES               FON-DATA.
*>              憭批?雿摨?(隢?甇斗?雿?甇亙??蚌ON-TRN)
                03      FON-70-IPD-NO.

                        05      FON-70-IPD-DT           PIC 9(07).
                        05      FON-70-IPD-SEQ          PIC 9(04).
*>              ?湔?交?
                03      FON-70-UPD-DT                   PIC 9(07).
                03      FON-70-UPD-TI.
                        04      FON-70-UPD-HH           PIC 9(02).
                        04      FON-70-UPD-MN           PIC 9(02).
*>              PAT撖急?憭望????
                03      FON-70-PAT-STATUS               PIC X(02).
*>              ??
                03      FON-70-DATA-REC                 PIC X(226).
*>      2015/01/27 TQIP雿鞈?頧?雿平??瑼OG
*>      ??嚗?TQIP雿鞈?頧?蝝??
        02      FON-71-DATA     REDEFINES               FON-DATA.
*>              蝺楝
                03      FON-71-LINE-NUMBER              PIC 9(04).
*>              ?瑁??交?/??(餈?
                03      FON-71-DTTI-END.
                        04      FON-71-UPD-DT-END       PIC 9(07).
                        04      FON-71-UPD-TIME-END     PIC 9(06).
*>              ??233??
                03      FON-71-DATA-REC                 PIC X(233).


*>       2015/02/09     ??-?粹鋆閮箸蝣潮?瑼??貉身摰?
*>      ??嚗???-?粹鋆閮箸蝣潮?瑼身摰?
        02      FON-72-DATA     REDEFINES               FON-DATA.
*>              ?曉??駁?-閮箸/??蝬剛風??嚗???Y)嚗郎??W)嚗征??銝???
                03      FON-72-HDDISKF                  PIC X(01).
*>              ?孵?獢辣-閮箸/??蝬剛風??嚗???Y)嚗郎??W)嚗征??銝???
                03      FON-72-HICUTKF                  PIC X(01).
*>              雿?思誘-閮箸/??蝬剛風??嚗???Y)嚗郎??W)嚗征??銝???
                03      FON-72-HRODAKF                  PIC X(01).
*>              ???駁?-閮箸/??蝬剛風??嚗???Y)嚗郎??W)嚗征??銝???
                03      FON-72-HKRECKF                  PIC X(01).
*>              TW-DRG蝺典祟-閮箸/??蝬剛風??嚗???Y)嚗郎??W)嚗征??銝???
                03      FON-72-HDDRGNMF                 PIC X(01).
*>              ???啣虜雿平-閮箸/??蝬剛風??嚗???Y)嚗郎??W)嚗征??銝???
                03      FON-72-HI300DF                  PIC X(01).
*>              ??244??
                03      FON-72-TRN-REC                  PIC X(244).

*>      2015/03/02      ??-?粹鋆雿平?臬摮?
*>      2015/03/10      ?粹鋆鈭箏摮?LOG
*>      ??嚗???-?粹鋆雿平?臬摮?(?粹鋆蝝????
        02      FON-73-DATA     REDEFINES               FON-DATA.
*>              ???粹鋆摮?霅?剁?[Y]銵典?瑼?
                03  FON-73-HIIPOMF-SAVE         PIC X(01).
*>              ?粹鋆嚗?瑼犖??
                03  FON-73-USER                 PIC X(05).
*>              ?粹鋆摮??瑁??交?????
                03  FON-73-UPD-DT.
                        04 FON-73-UPD-DATE      PIC 9(07).
                        04 FON-73-UPD-TIME      PIC 9(06).
*>              ??231??
                03      FON-73-DATA-REC         PIC X(231).


*>      2015/03/10 ?粹鋆???啣?LOG
*>      ??嚗??粹鋆???啣?LOG??
        02      FON-74-DATA     REDEFINES               FON-DATA.
*>              ?曉??駁?-閮箸/??蝬剛風??嚗???Y)嚗郎??W)嚗征??銝???
                03      FON-74-HDDISKF                  PIC X(01).
*>              ?孵?獢辣-閮箸/??蝬剛風??嚗???Y)嚗郎??W)嚗征??銝???
                03      FON-74-HICUTKF                  PIC X(01).
*>              雿?思誘-閮箸/??蝬剛風??嚗???Y)嚗郎??W)嚗征??銝???
                03      FON-74-HRODAKF                  PIC X(01).
*>              ???駁?-閮箸/??蝬剛風??嚗???Y)嚗郎??W)嚗征??銝???
                03      FON-74-HKRECKF                  PIC X(01).
*>              TW-DRG蝺典祟-閮箸/??蝬剛風??嚗???Y)嚗郎??W)嚗征??銝???
                03      FON-74-HDDRGNMF                 PIC X(01).
*>              ???啣虜雿平-閮箸/??蝬剛風??嚗???Y)嚗郎??W)嚗征??銝???
                03      FON-74-HI300DF                  PIC X(01).
*>              ??244??
                03      FON-74-DATA-REC                 PIC X(244).

*>      2016/12/19
*>      ??嚗??啁????停?怎?梯?????
        02      FON-93-DATA     REDEFINES               FON-DATA.
*>              ?喳?交?(蝮質”APY-DATE)
                03      FON-93-APY-DATE                 PIC 9(07).
*>              雿摨?
                03      FON-93-IPD-NO.
                        04      FON-93-IPD-DT           PIC 9(07).
                        04      FON-93-IPD-SEQ          PIC 9(04).
*>              雿平???喳:HOAPY1BF)
                03      FON-93-PROGRAM                  PIC X(08).
*>              [902]?喳鞈?(頧??神??
                03      FON-93-APY-902-DATA.
*>                      雿摨?
                        04      FON-93-IPD-NO-902       PIC 9(11).
*>                      鞎餌撟湔?
                        04      FON-93-APY-YM-902       PIC 9(05).
*>                      ?喳憿   1:? 2:鋆
                        04      FON-93-APY-PART-902     PIC X(01).
*>                      獢辣
                        04      FON-93-CASE-ID-902      PIC X(02).
*>                      瘚偌??
                        04      FON-93-SEQ-NO-902       PIC 9(06).
*>              ??
                03      FON-93-DATA-REC                 PIC X(199).

*>      ?憧嚗哨??亥那?釭???寞??嗆?霅??
        02      FON-EM-DATA     REDEFINES               FON-DATA.
*>              ?湔?交?????
                03      FON-EM-UPD-DT.
                        04      FON-EM-UPD-DATE         PIC 9(07).
                        04      FON-EM-UPD-TIME         PIC 9(06).
*>              ?臬撌脫獢?Y嚗歇?嗆?  蝛箇嚗?嗆?)
                03      FON-EM-MARK                     PIC X(01).
*>              ??
                03      FON-EM-DATA-REC                 PIC X(236).

*>      ?憔嚗恬??喳??/閫???啣?閮???2019/7/11
        02      FON-LK-DATA     REDEFINES               FON-DATA.

*>              ?啣?銋蝙?刻誨??
                03      FON-LK-USR-ID                   PIC X(05).
*>              ??(Y)/閫??(N)
                03      FON-LK-MODE                     PIC X(01).
*>              蝔?畾?
                03      FON-LK-PROG                     PIC X(20).
                03      FON-LK-DATA-REC                 PIC X(224).
*>      ??嚗??????
        02      FON-94-DATA     REDEFINES               FON-DATA.
*>              ???
                03      FON-94-PILL-NO                  PIC 9(04).

                03      FON-94-DATA-REC                 PIC X(246).
*>      ??嚗??犖摨???函???
        02      FON-95-DATA     REDEFINES               FON-DATA.
*>              頧?啁??踹???
                03      FON-95-BED.
                        04      FON-95-BED-ROOM         PIC X(04).
                        04      FON-95-BED-NO           PIC X(02).
*>              鈭斤??
                03      FON-95-PHONE                    PIC X(05).
*>              ?怠葦隞?Ⅳ
                03      FON-95-DR-NO                    PIC X(04).
*>              ?交?
                03      FON-95-DATE                     PIC 9(07).
*>              ??
                03      FON-95-TIME                     PIC 9(06).
*>              ?啣???
                03      FON-95-USID                     PIC X(05).
*>              ?桀???典????CU蝝??
                03      FON-95-NOW-BED                  PIC X(03).
                03      FON-95-DATA-REC                 PIC X(214).
*>      ??嚗??喳??唳?UD?刻皜??
        02      FON-96-DATA     REDEFINES               FON-DATA.
*>              ??交?
                03      FON-96-PRINT-DATE               PIC 9(07).
*>              ???
                03      FON-96-PRINT-TIME               PIC 9(04).
                03      FON-96-DATA-REC                 PIC X(239).
*>      ??嚗???????
        02      FON-80-DATA     REDEFINES               FON-DATA.
*>              ??
                03 FON-80-TEETH-TBL1 OCCURS 9 TIMES.
                        05 FON-80-TEETH-CNT PIC X(02).
                03 FON-80-DATA-REC                      PIC X(232).

*---------------------------------------------------------------------*
*>      嚗伐戮嚗扎嚗荔憐?嚗?摩嚗堆撕?嚗佗憬嚗穿憧?                            *
*---------------------------------------------------------------------*

*COPY    "HI_DTE.MST".
 FD      DTE-MST IS EXTERNAL.
 01      DTE-MST-REC.
        10  DTE-MST-KEY.
**              ?閮箏???
                20 DTE-VRY-YM           PIC    9(5).
        10  DTE-CRE-DATE.

            12  DTE-VRY-DATE             PIC    9(07).
            12  DTE-VRY-TIME             PIC    9(06).
            12  DTE-VRY-VER              PIC    9(03).
*$XFD USE GROUP
            12  DTE-VRY-FILL.
*銝?閮餉? Y:?冽?銝?   DTE-CRE-DATE DTE-CRE-TIME   DTE-VRY-VER
*銝?閮餉? M:銝?????DTE-CRE-DATE2 DTE-CRE-TIME2 DTE-VRY-VER2 ( 1??- 15??
*銝?閮餉? N:閫??
*           鋆       DTE-CRE-DATE1 DTE-CRE-TIME1 DTE-VRY-VER1
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
*>      雿??啣?閮?瑼HI_GCA.MST
*---------------------------------------------------------------------*
*> 銝? 嚗IGCA-IPD-NO HIGCA-ODR-NO HIGCA-DTI  (?桀撐??啣??瘜?
*> ?? 嚗IGCA-DTI HIGCA-IPD-NO HIGCA-ODR-NO  (?亙?蝟餌絞雿輻)
*> ?? 嚗IGCA-IPD-NO HIGCA-DTI HIGCA-ODR-NO  (雿??啣??瘜?
*> SIZE : 605 BYTES
* 910306  憓?HIGCA-APY-ID?斗?梁?梁頂蝯梢脣?啣?霅(JAY)
*>97/10/11 Frank-?芸?摰儔
*>2014/4/10 憓??啣?雿平暺?- ?勗?
*---------------------------------------------------------------------*
 FD      HIGCA-MST         IS      EXTERNAL.
 01      HIGCA-MST-REC.
        02      HIGCA-KEY.
*$XFD USE GROUP
*>      雿摨?
                03      HIGCA-IPD-NO.
                        05      HIGCA-IPD-DT            PIC 9(07).
                        05      HIGCA-IPD-SEQ           PIC 9(04).
*$XFD USE GROUP
*>      ?摨?
                03      HIGCA-ODR-NO.
                        05      HIGCA-INS-DATE          PIC 9(07).
                        05      HIGCA-ODR-SEQ           PIC 9(04).
*$XFD USE GROUP
*>      ?啣??交?,?啣???
                03      HIGCA-DTI.
                        05      HIGCA-DATE              PIC 9(07).
                        05      HIGCA-TIME              PIC 9(06).
*$XFD USE GROUP, VAR-LENGTH
        02      HIGCA-CODE.
*>      ?啣?隞??                "I "=>INSERT, "MD"=>MODIFY??
*>                                    "MI"=>MODIFY敺?
*>                                    "M "=>MODIFY
*>                                    "D "=>DELETE

                03      HIGCA-UPD-ID                    PIC X(02).
*>      ?啣???
                03      HIGCA-UPD-USR                   PIC X(05).
*>      ?啣?霅蝣?
                03      HIGCA-JOB-ID                    PIC X(03).
*>      ?喳蝟餌絞?啣?霅蝣?Y)(910306)
                03      HIGCA-APY-ID                    PIC X(01).
*>      2014/4/10 ?啣?雿平暺?
                03      HIGCA-MOD-PROG                  PIC X(10).
*>      2014/4/10 ?啣?雿平?迂
                03      HIGCA-MOD-PG-NAME               PIC X(20).
*>      2014/4/10 X(59) --> X(29)
                03      HIGCA-CODE-FILLER               PIC X(29).
*>
*$XFD USE GROUP , VAR-LENGTH
*>      [HIGCA-DATA1]   mapping [ICA-DATA1]
        02      HIGCA-DATA1                             PIC X(250).
*>      ??
*$XFD USE GROUP , VAR-LENGTH
*>97/10/11 [HIGCA-DATA2]        mapping [ICAE-DATA1]
        02      HIGCA-DATA2                             PIC X(250).
*---------------------------------------------------------------------*
*>      ?啣?霅蝣?
*>      ?啣?[I]:
*>              I01: ?孵?啣?,
*>              I02: 雿?亦?
*>              I03: 霅瑞?銋振?湔蝯董
*>              I04: ?澆?扯風?
*>              I05: 頧???Ｙ?
*>              I06: ?粹蝯董
*>              I07: ??亥那頧???
*>              I08: UD?喲?
*>              I09: 隡?蝯?
*---------------------------------------------------------------------*
*>      嚗伐戮嚗扎嚗荔憐?嚗?摩嚗堆撕?嚗佗憬嚗穿憧?                            *
*---------------------------------------------------------------------*









*COPY    "HI_GCB.MST".
*********************************
*> 雿??敦?啣?瑼?RECORD LENGTH = 957 BYTES
*********************************
 FD      HIGCB-MST         EXTERNAL.
 01      HIGCB-MST-REC.
        02      HIGCB-KEY.
            03  HIGCB-GCA-KEY.
*$XFD USE GROUP
*>      雿摨?
                20      HIGCB-IPD-NO.
                        30      HIGCB-IPD-DATE          PIC 9(7).

                        30      HIGCB-IPD-SEQ             PIC 9(4).
*$XFD USE GROUP
*>      ?摨?
                20      HIGCB-ODR-NO.
                        30      HIGCB-INS-DATE            PIC 9(7).
                        30      HIGCB-ODR-SEQ             PIC 9(4).
*$XFD USE GROUP
*>      ?啣??交?, ??
                20      HIGCB-DTI.
                        30      HIGCB-DATE              PIC 9(7).
                        30      HIGCB-TIME              PIC 9(6).
*>      ?蔭瘚偌??
            03  HIGCB-FEE-SEQ                           PIC 9(3).
*>      ?蔭隞?Ⅳ
            03  HIGCB-FEE-KEY                           PIC X(9).
*>
*> ??
*$XFD USE GROUP, VAR-LENGTH
        02      HIGCB-CODE.
*>      ?啣?隞??
                20      HIGCB-UPD-ID                    PIC X(2).
*>      瑼?摨?
                20      HIGCB-FILE-NO                   PIC 9(3).
*>      憿
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
***  ?蔭撱嗡撓瑼?
***********************************************************
***  PEF-MST-KEY  = PEF-CODE
***********************************************************
 FD      PEF-MST IS EXTERNAL.
 01      PEF-MST-REC.
*       ??[1173] ?蔭撱嗡撓閮剖?(001:300)
        02 PEF-1173.
                03 PEF-ID                       PIC X(04).

                03 PEF-CODE                     PIC X(20).
                03 PEF-TRN                      PIC X(20).
                03 PEF-NAME                     PIC X(24).
*$XFD USE GROUP , VAR-LENGTH
                03 PEF-REC                      PIC X(232).
*       ?啗?蝵桀辣隡貉身摰?301:500)
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
* ?餃??風?亦?瑼?HR_ELC.TRN                          瑼?嚗R_TELC    *
*----------------------------------------------------------------------*
* 銝鳴?ELC-TRN-KEY = ELC-SYS + ELC-KEY                                  *
* ?荔?ELC-ALT-KEY1 = ELC-SYS + ELC-UPD + ELC-KEY                       *
*----------------------------------------------------------------------*
*
 FD ELC-TRN              EXTERNAL.
 01 ELC-TRN-REC.
*> ??蝟餌絞 [A]?閮?[B]雿?箸鞈? [C]雿?孵? [D] 雿??亥???
*>                  [E]?喳銝餅?雿?孵?
*>                  [F]?喳銝餅?雿??亥???
        02 ELC-SYS                                      PIC X(01).
*> ?摨?
        02 ELC-KEY                                      PIC X(50).
        02 ELC-A-KEY REDEFINES ELC-KEY.
                03 ELC-A-RO-NO.
                        04 ELC-A-RO-DT                  PIC 9(07).
                        04 ELC-A-RO-SEQ                 PIC 9(04).
                03 ELC-A-FILLER                         PIC X(39).
*> 雿?箸鞈?
        02 ELC-B-KEY REDEFINES ELC-KEY.
                03 ELC-B-DATE                           PIC 9(07).
                03 ELC-B-TIME                           PIC 9(08).
                03 ELC-B-IPD-NO.
                        04 ELC-B-IPD-DT                 PIC 9(07).
                        04 ELC-B-IPD-SEQ                PIC 9(04).
                03 ELC-B-FILLER                         PIC X(24).
*> 雿?孵?
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
*> 雿??亥???
        02 ELC-D-KEY REDEFINES ELC-KEY.

                03 ELC-D-DATE                           PIC 9(07).
                03 ELC-D-TIME                           PIC 9(08).
*>              雿摨?
                03 ELC-D-IPD-NO.
                        04 ELC-D-IPD-DATE               PIC 9(07).
                        04 ELC-D-IPD-SEQ                PIC 9(04).
                03 ELC-D-RTA-NO.
                        04 ELC-D-RTA-DATE               PIC 9(07).
                        04 ELC-D-RTA-SEQ                PIC 9(03).
                03 ELC-D-FILLER                         PIC X(14).
*> ?喳銝餅?雿?孵? 900912 INSERT
        02 ELC-E-KEY REDEFINES ELC-KEY.
                03 ELC-E-IPD-NO.
                        04 ELC-E-IPD-DATE               PIC 9(07).
                        04 ELC-E-IPD-SEQ                PIC 9(04).
                03 ELC-E-ODR-NO.
                        04 ELC-E-INS-DATE               PIC 9(07).
                        04 ELC-E-ODR-SEQ                PIC 9(04).
                03 ELC-E-FILLER                         PIC X(28).
*>
*> ?喳銝餅?雿??亥???900912 INSERT
        02 ELC-F-KEY REDEFINES ELC-KEY.
*>              雿摨?
                03 ELC-F-IPD-NO.
                        04 ELC-F-IPD-DATE               PIC 9(07).
                        04 ELC-F-IPD-SEQ                PIC 9(04).
*>              ??亙???
                03 ELC-F-RTA-NO.
                        04 ELC-F-RTA-DATE               PIC 9(07).
                        04 ELC-F-RTA-SEQ                PIC 9(03).
                03 ELC-F-FILLER                         PIC X(29).

*> ??啗???[Y]
        02 ELC-UPD                                      PIC X(01).
*>
        02 ELC-DATA.
*> ?? [C]?啣? [M]靽格 [D]?芷
                03 ELC-DO                               PIC X(01).
                03 ELC-FILLER                           PIC X(100).
*
*COPY    "HR_IBG.MST".
*--------------------------------------------------------------------------*
*> 雿?思誘銵典?批瑼?HR_IBG.MST                             瑼?嚗R_MIBG*
*--------------------------------------------------------------------------*
*>銝鳴?IBG-MST-KEY = IBG-UNIT-NO + IBG-DT + IBG-SEQ                         *
*>?荔?IBG-ALT-KEY1 = IBG-UNIT-NO + IBG-DT + IBG-PRINT-MARK + IBG-SEQ       *
*--------------------------------------------------------------------------*
 FD      IBG-MST         EXTERNAL.
 01      IBG-MST-REC.
*>   霅瑞?蝡誨??<GUI ?寧?甇斗?雿??桐?隞?Ⅳ>
        02      IBG-UNIT-NO                     PIC X(05).
*>   ?交?
        02      IBG-DT                          PIC 9(07).
*>   銵典摨?(瘚偌??
        02      IBG-SEQ                         PIC 9(10).
*>   銵典蝔桅?
*>      [A]嚗蛛慾??                     [B]?冽??,?粹撣嗉,擐??    [C]?那??

*>      [D]霅瑞?瘝餌???                 [E]瑼ａ??曉?蝺?霅?              [F]瑼ａ??曉???
*>      [G]?????(?恍??祥??     [H]X?????                 [I]?粹撣嗉??(??)
*>      [J]????                      [K]??亦隢                   [L]?????
*>      [M]?單?瑼ａ??勗?                 [N]?粹???                  [O]??????
*>      [P]蝞∪??蝝??寧?             [Q]???蝞?                  [R]??交?霅?
*>      [S]?芾祥????                  [T]?寞??亙?雿輻?唾???          [U]????
*>      [V]?恣?亙??唾???              [W]瘝餌??蔭??敺拙)             [X]頧?敺拙???
*>      [Y]敺拙瘝餌???????           [Z]銝剝雿霅瑞?蝡??
*>      [a]???”??                  [b]CHEMO 璅惜                   [c]CHEMO 璅惜(蝺亥???
*>      [d]?怠???DC)                   [e]?怠???                      [f]瑼ａ??曉?????)
*>      [h]銵摨恍隞嗅                   [i]?脰風???                  [j]瘜???Ｗ
*>      [m]瑼ａ??隞園??              [n]?恣?亙?撖拇??
*>      [q]???蝞?瑼ａ??芷)         [o]???????啁?)             [v]?恣?嗆扳?蝞∟?隢
*>      [w]?????
*>      [z]霅瑞?鈭箏瘝餌??蔭??鞊?)
*>      [1]?孵??(?芷)               [2]?凋??D??                 [3]???亙????
*>      [4]霅瑞???亦隢               [5]RFID?扳???                  [6]?寞??刻?扳???
*>      [7]?亥????航炊?扳???          [8]?瑟??怠??殷?璅寞?隞?嚗?      [9]?冽??怠??殷?璅寞?隞?嚗?

        02      IBG-PAPER-ID                    PIC X(01).
*>   ??瘜?"Y"銵刻府銵典歇?啣," "銵典??芸???
        02      IBG-PRINT-MARK                  PIC X(01).
*>   ?喲?霈(?箔?閬?箏?蝔株”??雿輻甇斗?雿摮EY??
*$XFD USE GROUP , VAR-LENGTH
        02      IBG-REC                         PIC X(200).
        02      IBG-REC-DATA REDEFINES IBG-REC.
*>                                              (1:50)
                03      IBG-PRINT-DATA          PIC X(50).
*>              ?喲”?格???                   (51:6)
                03      IBG-SEND-TIME.
                        04      IBG-SEND-HH     PIC 9(02).
                        04      IBG-SEND-MT     PIC 9(02).
                        04      IBG-SEND-SS     PIC 9(02).
*>              ?啗”??(蝚砌?甈?                (57:6)
                03      IBG-PRINT-TIME.
                        04      IBG-PRINT-HH    PIC 9(02).
                        04      IBG-PRINT-MT    PIC 9(02).
                        04      IBG-PRINT-SS    PIC 9(02).
*>              ?啗”??(?敺?甈?              (63:6)
                03      IBG-PRINT-E-TIME.
                        04      IBG-PRINT-E-HH  PIC 9(02).
                        04      IBG-PRINT-E-MT  PIC 9(02).
                        04      IBG-PRINT-E-SS  PIC 9(02).
*>              ?箏??芸????銝???臬??Y)
*>              [A] 銵刻撅??[B] 銵冽?閮粹??  (69:1)
                03      IBG-SP-PAPER            PIC X(01).
*>              摨???                         (70:6)
                03      IBG-BED.
                        04      IBG-BED-ROOM    PIC X(04).
                        04      IBG-BED-NO      PIC X(02).
*>              HTCHK-MST-STATUS???
*>                                              (76:2)
                03      IBG-HTCHK-STATUS        PIC X(02).
*>                                              (78:123)
                03      IBG-FILLER              PIC X(123).




*>102.09.06 (FISH) ?D14?亥????航炊?扳??格???嚗???啣?甈?嚗誑?喲?鞈?
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

*>102.09.06 (FISH) ?D14?亥????航炊?扳??格???嚗???啣?甈?嚗誑?喲?鞈?
***********************************************************************
*> END OF "HR_IBG.MST"
***********************************************************************
*COPY    "HR_RNU.MST".
*>---------------------------------------------------------------------*
*> ?思誘?Ⅳ瑼?HR_RNU.MST                              瑼?嚗R_MRNU   *
*> 2019/05/08 ?唬葉-憓??亙葦閮芾?閮?(R) - ?                          *
*>---------------------------------------------------------------------*
*> 銝?KEY : RNU-KEY                                                    *
*>---------------------------------------------------------------------*
 FD RNU-MST              EXTERNAL.
 01      RNU-MST-REC.
        02      RNU-KEY                         PIC X(40).
*> A. 霅瑞?蝡UE?桀???
        02      RNU-A-KEY REDEFINES RNU-KEY.
                03      RNU-A-ID                PIC X(01).
                03      RNU-A-DT                PIC 9(07).
                03      RNU-A-UNIT              PIC X(05).
                03      RNU-A-KFIL              PIC X(27).
*> B. ?那?摨?
        02      RNU-B-KEY REDEFINES RNU-KEY.
                03      RNU-B-ID                PIC X(01).
                03      RNU-B-DT                PIC 9(07).
                03      RNU-B-KFIL              PIC X(32).
*> C. 閮粹?QUE?桀???
        02      RNU-C-KEY REDEFINES RNU-KEY.
                03      RNU-C-ID                PIC X(01).
                03      RNU-C-DT                PIC 9(07).
                03      RNU-C-UNIT              PIC X(05).
                03      RNU-C-KFIL              PIC X(27).
*> D. ?仿?風撱箸?摨?
        02      RNU-D-KEY REDEFINES RNU-KEY.
                03      RNU-D-ID                PIC X(01).
                03      RNU-D-IPD-NO.
                        04      RUN-D-IPD-DT    PIC 9(07).
                        04      RUN-D-IPD-SEQ   PIC 9(04).
                03      RNU-D-KFIL              PIC X(28).
*> E. ??亦隢摨?
        02      RNU-E-KEY REDEFINES RNU-KEY.

                03      RNU-E-ID                PIC X(01).
                03      RNU-E-DT                PIC 9(07).
                03      RNU-E-KFIL              PIC X(32).
*> F. 閮箸???脩車?風??,頧那???桅?蝡???
        02      RNU-F-KEY REDEFINES RNU-KEY.
                03      RNU-F-ID                PIC X(01).
                03      RNU-F-DT                PIC 9(07).
                03      RNU-F-KFIL              PIC X(32).
*> G. ?亥那瑼Ｘ?瘞渲?
        02      RNU-G-KEY REDEFINES RNU-KEY.
                03      RNU-G-ID                PIC X(01).
                03      RNU-G-DT                PIC 9(07).
                03      RNU-F-KFIL              PIC X(32).
*> H. ?亥那??亙摨?
        02      RNU-H-KEY REDEFINES RNU-KEY.
                03      RNU-H-ID                PIC X(01).
                03      RNU-H-DT                PIC 9(07).
                03      RNU-H-UNIT              PIC X(05).
                03      RNU-H-KFIL              PIC X(27).
*> I. ?怨??寡?銋蝔桀???VAC-ID = "1" HBIG?????"2"BCG?∩???"3"HBV嚗Ｚ??怨? )
        02      RNU-I-KEY REDEFINES RNU-KEY.
                03      RNU-I-ID                PIC X(01).
                03      RNU-I-VAC-ID            PIC X(01).
                03      RNU-I-VAC-NO            PIC X(15).
                03      RNU-I-KFIL              PIC X(23).
*> J. 瑼ａ?????桀???
        02      RNU-J-KEY REDEFINES RNU-KEY.
                03      RNU-J-ID                PIC X(01).
                03      RNU-J-DT                PIC 9(07).
                03      RNU-J-KFIL              PIC X(32).
*> K. 銝餅祥?怠葦?神?怠??桀???HR_MMJA)
        02      RNU-K-KEY REDEFINES RNU-KEY.
                03      RNU-K-ID                PIC X(01).
                03      RNU-K-IPD-NO            PIC X(11).
                03      RNU-K-KFIL              PIC X(28).
*> 2009/11/4 01:52銝? selina
*> L. ?亥那鈭?瑼Ｗ撣貊銝餉迄撱箸??芸?蝺刻?
        02      RNU-L-KEY REDEFINES RNU-KEY.
                03      RNU-L-ID                PIC X(01).
*> 蝘 [1]????[2]憭 [3]??(????
                03      RNU-L-DPT               PIC X(01).
                03      RNU-L-KFIL              PIC X(38).
*> 2010.10.14 19:15 (P)
*> M. ?扳??桀???
        02      RNU-M-KEY REDEFINES RNU-KEY.
                03      RNU-M-ID                PIC X(01).
*>              [O]?閮?[I]雿
                03      RNU-M-IO                PIC X(01).
*> .............(?閮?>?閮箏??? , (雿->?摨?)
                03      RNU-M-ODR-NO.
                        04      RNU-M-ODR-DT    PIC 9(07).
                        04      RNU-M-ODR-SEQ   PIC 9(04).
*> .............雿摨? (雿??)
                03      RNU-M-IPD-NO.
                        04      RNU-M-IPD-DT    PIC 9(07).
                        04      RNU-M-IPD-SEQ   PIC 9(04).
*>              靽格甈⊥

                03      RNU-M-MOD-CNT           PIC 9(02).
                03      RNU-M-KFIL              PIC X(14).
*> 2010.10.22 (AICE)
*> N. ?扳??桀???雿????
        02      RNU-N-KEY REDEFINES RNU-KEY.
                03      RUN-N-ID                PIC X(01).
                03      RUN-N-IPD-NO.
                        04      RUN-N-IPD-DT    PIC 9(07).
                        04      RUN-N-IPD-SEQ   PIC 9(04).
                03      RUN-N-DATE              PIC 9(07).
                03      RUN-N-KFIL              PIC X(21).
*> O. 摰嗅滬瑼??Ⅳ瑼??閮?
        02      RNU-O-KEY REDEFINES RNU-KEY.
                03      RUN-O-ID                PIC X(01).
                03      RUN-O-KFIL              PIC X(39).
*> 2015.03.17 (SU) E-4339 ?亙葦?典??儔?扳??
*> P. ?怠葦?撣怎????(HR_MMEP)摨?
        02      RNU-P-KEY REDEFINES RNU-KEY.
                03      RNU-P-ID                PIC X(01).
                03      RNU-P-DT                PIC 9(07).
                03      RNU-P-KFIL              PIC X(32).
*> 2015.04.27 (SU) 鞊?-雿?思誘鈭斤??
*> Q. 雿?思誘鈭斤?株???(HR_MSOV)摨?
        02      RNU-Q-KEY REDEFINES RNU-KEY.
                03      RNU-Q-ID                PIC X(01).
                03      RNU-Q-DT                PIC 9(07).
                03      RNU-Q-KFIL              PIC X(32).
*> 2019/05/08 ?唬葉-憓??亙葦閮芾?閮?
*> R. ?亙葦閮芾?撱箸?摨?
        02      RNU-R-KEY REDEFINES RNU-KEY.
                03      RNU-R-ID                PIC X(01).
*>                      I:雿 O:?閮?
                03      RNU-R-IO                PIC X(01).
*>                      ?雿???
                03      RNU-R-NO.
                        04      RUN-R-DT        PIC 9(07).
                        04      RUN-R-SEQ       PIC 9(04).
                03      RNU-R-KFIL              PIC X(27).
*> ------------------------------------------------------------------------ *<
        02      RNU-DATA                        PIC X(40).
*> A. 霅瑞?蝡UE?桀???
        02      RNU-A-DATA REDEFINES RNU-DATA.
                03      RNU-A-NO                PIC 9(05).
                03      RNU-A-DFIL              PIC X(35).
*> B. ?那?摨?
        02      RNU-B-DATA REDEFINES RNU-DATA.
                03      RNU-B-NO                PIC 9(04).
                03      RNU-B-DFIL              PIC X(36).
*> C. 閮粹?QUE?桀???
        02      RNU-C-DATA REDEFINES RNU-DATA.
                03      RNU-C-NO                PIC 9(06).
                03      RNU-C-DFIL              PIC X(34).
*> D. ?仿?風撱箸?摨?
        02      RNU-D-DATA REDEFINES RNU-DATA.
                03      RNU-D-NO                PIC 9(10).
                03      RNU-D-DFIL              PIC X(30).
*> E. ??亦隢摨?

        02      RNU-E-DATA REDEFINES RNU-DATA.
                03      RNU-E-NO                PIC 9(04).
                03      RNU-E-DFIL              PIC X(36).
*> F. 閮箸???脩車?風??,頧那???桅?蝡???
        02      RNU-F-DATA REDEFINES RNU-DATA.
                03      RNU-F-NO                PIC 9(05).
                03      RNU-F-DFIL              PIC X(35).
*> G. ?亥那瑼Ｗ瘚偌??
        02      RNU-G-DATA REDEFINES RNU-DATA.
                03      RNU-G-NO                PIC 9(04).
                03      RNU-G-DFIL              PIC X(36).
*> H. ?亥那??亙摨?
        02      RNU-H-DATA REDEFINES RNU-DATA.
                03      RNU-H-NO                PIC 9(06).
                03      RNU-H-DFIL              PIC X(34).
*> I. ?怨??寡?銋蝔桀???
        02      RNU-I-DATA REDEFINES RNU-DATA.
                03      RNU-I-NO                PIC 9(04).
                03      RNU-I-DFIL              PIC X(36).
*> J. 瑼ａ?????桀???
        02      RNU-J-DATA REDEFINES RNU-DATA.
                03      RNU-J-NO                PIC 9(06).
                03      RNU-J-DFIL              PIC X(34).
*> K. 銝餅祥?怠葦?神?怠??桀???HR_MMJA)
        02      RNU-K-DATA REDEFINES RNU-DATA.
                03      RNU-K-NO                PIC 9(07).
                03      RNU-K-DFIL              PIC X(33).
*> 2009/11/4 01:52銝? selina
*> L. ?亥那鈭?瑼Ｗ撣貊銝餉迄撱箸??芸?蝺刻?
        02      RNU-L-DATA REDEFINES RNU-DATA.
                03      RNU-L-NO                PIC 9(03).
                03      RNU-L-DFIL              PIC X(37).
*> 2010.10.14 19:15 (P)
*> M. ?扳??桀???
        02      RNU-M-DATA REDEFINES RNU-DATA.
                03      RNU-M-NO                PIC 9(03).
                03      RNU-M-DFIL              PIC X(37).
*> 2010.10.22 (AICE)
*> N. ?扳??桀???雿????
        02      RNU-N-DATA REDEFINES RNU-DATA.
                03      RNU-N-NO                PIC 9(04).
                03      RNU-N-DFIL              PIC X(36).
*> O. 摰嗅滬瑼??Ⅳ瑼??閮?
        02      RNU-O-DATA REDEFINES RNU-DATA.
                03      RNU-O-NO                PIC 9(10).
                03      RNU-O-DFIL              PIC X(30).
*> 2015.03.17 (SU) E-4339 ?亙葦?典??儔?扳??
*> P. ?怠葦?撣怎????(HR_MMEP)摨?
        02      RNU-P-DATA REDEFINES RNU-DATA.
                03      RNU-P-NO                PIC 9(04).
                03      RNU-P-DFIL              PIC X(36).
*> 2015.04.27 (SU) 鞊?-雿?思誘鈭斤??
*> Q. 雿?思誘鈭斤?株???(HR_MSOV)摨?
        02      RNU-Q-DATA REDEFINES RNU-DATA.
                03      RNU-Q-NO                PIC 9(04).
                03      RNU-Q-DFIL              PIC X(36).
*> 2019/05/08 ?唬葉-憓??亙葦閮芾?閮?

*> R. ?亙葦閮芾?撱箸?摨?
        02      RNU-R-DATA REDEFINES RNU-DATA.
                03      RNU-R-NO                PIC 9(10).
                03      RNU-R-DFIL              PIC X(30).
***********************************************************************
*> END OF "HR_RNU.MST".
***********************************************************************
*COPY    "HR_FNS.MST".
*>----------------------------------------------------------------------*
*> ?萄潭?嚗R_FNS.MST         271 Bytes                瑼?嚗R_MFNS    *
*>----------------------------------------------------------------------*
*> 銝鳴?FNS-MST-KEY  = FNS-ID + FNS-P-KEY                                *
*> ?荔?FNS-ALT-KEY1 = FNS-ID + FNS-A-KEY + FNS-P-KEY                    *
*> ?荔?FNS-ALT-KEY2 = FNS-ID + FNS-B-KEY + FNS-P-KEY                    *
*>----------------------------------------------------------------------*
*
 FD      FNS-MST         EXTERNAL.
 01      FNS-MST-REC.
*>**********>
*> 霅???蝣?*
*>**********>
        02      FNS-ID                                  PIC X(01).
*>********************************************************************
*>                          銝? KEY
*>********************************************************************
        02      FNS-P-KEY                               PIC X(40).
*> [A] [B] [E] [O] [P] [R] [S] [T] [a] [d] [j] [l] [x]
        02      FNS-PA-KEY REDEFINES FNS-P-KEY.
*> .............?閮箏???
                03      FNS-PA-NO.
                        04      FNS-PA-DT               PIC 9(07).
                        04      FNS-PA-SEQ              PIC 9(04).
                03      FNS-PA-FILLER                   PIC X(29).
*> [C]
        02      FNS-PC-KEY REDEFINES FNS-P-KEY.
*> .............?閮箏???
                03      FNS-PC-NO.
                        04      FNS-PC-DT               PIC 9(07).
                        04      FNS-PC-SEQ              PIC 9(04).
*> .............霈?交?
                03      FNS-PC-CDATE                    PIC 9(07).
*> .............霈??
                03      FNS-PC-CTIME.
                        04      FNS-PC-CHH              PIC 9(02).
                        04      FNS-PC-CMM              PIC 9(02).
                        04      FNS-PC-CSS              PIC 9(02).
                03      FNS-PC-FILLER                   PIC X(16).
*> [D]
        02      FNS-PD-KEY REDEFINES FNS-P-KEY.
*> .............?閮箏???
                03      FNS-PD-NO.
                        04      FNS-PD-DT               PIC 9(07).
                        04      FNS-PD-SEQ              PIC 9(04).
*> .............?摨?
                03      FNS-ODR-SEQ                     PIC 9(02).
*> .............?蔭摨?
                03      FNS-FEE-NO                      PIC 9(02).

                03      FNS-PD-FILLER                   PIC X(25).
*> [F]
        02      FNS-PF-KEY REDEFINES FNS-P-KEY.
*> .............?風?Ⅳ
                03      FNS-PF-PAT-NO                   PIC 9(08).
*> .............銵?
                03      FNS-PF-SEQ                      PIC 9(01).
                03      FNS-PF-FILLER                   PIC X(31).
*> [G]
        02      FNS-PG-KEY REDEFINES FNS-P-KEY.
*> .............雿摨?
                03      FNS-PG-IPD-NO.
                        04      FNS-PG-IPD-DATE         PIC 9(07).
                        04      FNS-PG-IPD-SEQ          PIC 9(04).
*> .............?摨?
                03      FNS-PG-ODR-NO.
                        04      FNS-PG-INS-DATE         PIC 9(07).
                        04      FNS-PG-ODR-SEQ          PIC 9(04).
                03      FNS-PG-FILLER                   PIC X(18).
*> [H][Z]
        02      FNS-PH-KEY REDEFINES FNS-P-KEY.
*> .............?閮箏???
                03      FNS-PH-NO.
                        04      FNS-PH-DT               PIC 9(07).
                        04      FNS-PH-SEQ              PIC 9(04).
*> .............[1]?瑁 [2]隤? [3]?拍?
                03      FNS-PH-DEPT                     PIC X(01).
                03      FNS-PH-FILLER                   PIC X(28).
*> [I]
        02      FNS-PI-KEY REDEFINES FNS-P-KEY.
*> .............?閮箏???
                03      FNS-PI-NO.
                        04      FNS-PI-DT               PIC 9(07).
                        04      FNS-PI-SEQ              PIC 9(04).
*> .............[1]?瑁 [2]隤? [3]?拍?
                03      FNS-PI-DEPT                     PIC X(01).
*> .............銵?
                03      FNS-PI-SEQ1                     PIC 9(02).
                03      FNS-PI-FILLER                   PIC X(26).
*> [J]
        02      FNS-PJ-KEY REDEFINES FNS-P-KEY.
*> .............雿摨?
                03      FNS-PJ-IPD-NO.
                        04      FNS-PJ-IPD-DATE         PIC 9(07).
                        04      FNS-PJ-IPD-SEQ          PIC 9(04).
*> .............[1]?瑁 [2]隤? [3]?拍?
                03      FNS-PJ-DEPT                     PIC X(01).
                03      FNS-PJ-FILLER                   PIC X(28).
*> [K]
        02      FNS-PK-KEY REDEFINES FNS-P-KEY.
*> .............雿摨?
                03      FNS-PK-IPD-NO.
                        04      FNS-PK-IPD-DATE         PIC 9(07).
                        04      FNS-PK-IPD-SEQ          PIC 9(04).
*> .............[1]?瑁 [2]隤? [3]?拍?
                03      FNS-PK-DEPT                     PIC X(01).
*> .............銵?

                03      FNS-PK-SEQ1                     PIC 9(02).
                03      FNS-PK-FILLER                   PIC X(26).
*> [L]
        02      FNS-PL-KEY REDEFINES FNS-P-KEY.
*> .............雿摨?
                03      FNS-PL-IPD-NO.
                        04      FNS-PL-IPD-DATE         PIC 9(07).
                        04      FNS-PL-IPD-SEQ          PIC 9(04).
*> .............憿(A~F)
                03      FNS-PL-ID                       PIC X(01).
                03      FNS-PL-FILLER                   PIC X(28).
*> [M]
        02      FNS-PM-KEY REDEFINES FNS-P-KEY.
                03      FNS-PM-PAT-NO                   PIC 9(08).
                03      FNS-PM-SEQ                      PIC 9(04).
                03      FNS-PM-FILLER                   PIC X(28).
*> [N]
        02      FNS-PN-KEY REDEFINES FNS-P-KEY.
*> .............?交?
                03      FNS-PN-DT                       PIC 9(07).
*> .............蝘
                03      FNS-PN-DPT                      PIC X(04).
*> .............?
                03      FNS-PN-TURN                     PIC X(01).
*> .............閮粹?
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
*> [Q] --- ?Ｗ瑼Ｘ
*> [V] --- ???內閮?
        02      FNS-PQ-KEY REDEFINES FNS-P-KEY.
*> .............(?閮?>?閮箏??? , (雿->?摨?)
                03      FNS-PQ-ODR-NO.
                        04      FNS-PQ-ODR-DATE         PIC 9(07).
                        04      FNS-PQ-ODR-SEQ          PIC 9(04).
*> .............雿摨? (雿??)
                03      FNS-PQ-IPD-NO.
                        04      FNS-PQ-IPD-DATE         PIC 9(07).
                        04      FNS-PQ-IPD-SEQ          PIC 9(04).
                03      FNS-PQ-FILLER                   PIC X(18).
*>     --- 憭瑼Ｘ
        02      FNS-PQ2-KEY REDEFINES FNS-P-KEY.
                03      FNS-PQ2-ODR-DATE                PIC 9(07).
                03      FNS-PQ2-PAT-NO                  PIC 9(08).
                03      FNS-PQ2-FILLER                  PIC X(25).

*> [T] --- 頧那瘚偌??<O> REF 頧  <I> RRI頧
        02      FNS-PT-KEY REDEFINES FNS-P-KEY.
                03      FNS-PT-ID                       PIC X(01).

                03      FNS-PT-DT                       PIC 9(07).
                03      FNS-PT-FILLER                   PIC X(32).
*> [U] --- ??停閮箏靽???
        02      FNS-PU-KEY REDEFINES FNS-P-KEY.
                03      FNS-PU-PAT-NO                   PIC 9(08).
                03      FNS-PU-INS-DPT                  PIC X(04).
                03      FNS-PU-FILLER                   PIC X(28).
*> [W] --- 雿?思誘摮悅?豢?蝷?
        02      FNS-PW-KEY REDEFINES FNS-P-KEY.
*> .............雿摨?
                03      FNS-PW-IPD-NO.
                        04      FNS-PW-IPD-DATE         PIC 9(07).
                        04      FNS-PW-IPD-SEQ          PIC 9(04).
*> .............[A] 銵函內?箄?????怨??內??
                03      FNS-PW-TYPE                     PIC X(01).
                03      FNS-PW-FILLER                   PIC X(28).
*> [X] --- ?箇??????
*> ?芾??銝剜?銝?? 撠望????? ??蔭蝣澆?賣??末撟曉? 雿閬???隞颱?,
*> 撠梁??舫??? ?隞乩耨?寞?, ?憟賣??? ?嗅??斗?臬閬神瑼?!
        02      FNS-PX-KEY REDEFINES FNS-P-KEY.
*> [O]?閮?[I]雿
                03      FNS-PX-IO                       PIC X(01).
                03      FNS-PX-KEY-1                    PIC X(25).
*> .............?閮箄???
                03      FNS-PX-O-KEY REDEFINES FNS-PX-KEY-1.
                        04      FNS-PX-O-RO-KEY.
                                05 FNS-PX-O-RO-NO.
                                        06 FNS-PX-O-RO-DATE     PIC 9(07).
                                        06 FNS-PX-O-RO-SEQ      PIC 9(04).
                                05 FNS-PX-O-ODR-SEQ     PIC 9(02).
                        04      FNS-PX-O-FILER          PIC X(12).
*> .............雿?
                03      FNS-PX-I-KEY REDEFINES FNS-PX-KEY-1.
                        04      FNS-PX-I-IPD-NO.
                                05 FNS-PX-I-IPD-DATE    PIC 9(7).
                                05 FNS-PX-I-IPD-SEQ     PIC 9(4).
                        04      FNS-PX-I-ODR-NO.
                                05 FNS-PX-I-INS-DATE    PIC 9(7).
                                05 FNS-PX-I-ODR-SEQ     PIC 9(4).
                        04      FNS-PX-I-FILLER         PIC X(03).
                03      FNS-PX-FILLER                   PIC X(14).
*> [Y] --- ?鼓????
        02      FNS-PY-KEY REDEFINES FNS-P-KEY.
                03      FNS-PY-IO                       PIC X(01).
                03      FNS-PY-KEY-1                    PIC X(22).
*> .............?閮箄???
                03      FNS-PY-O-KEY REDEFINES FNS-PY-KEY-1.
                        04      FNS-PY-O-RO-KEY.
                                05 FNS-PY-O-RO-NO.
                                        06 FNS-PY-O-RO-DATE     PIC 9(07).
                                        06 FNS-PY-O-RO-SEQ      PIC 9(04).
                                05 FNS-PY-O-ODR-SEQ     PIC 9(02).
                        04      FNS-PY-O-FILER          PIC X(09).
*> .............雿?
                03      FNS-PY-I-KEY REDEFINES FNS-PY-KEY-1.
                        04      FNS-PY-I-IPD-NO.
                                05 FNS-PY-I-IPD-DATE    PIC 9(7).

                                05 FNS-PY-I-IPD-SEQ     PIC 9(4).
                        04      FNS-PY-I-ODR-NO.
                                05 FNS-PY-I-INS-DATE    PIC 9(7).
                                05 FNS-PY-I-ODR-SEQ     PIC 9(4).
*> .............撱箸??交???
                03      FNS-PY-CDATE                    PIC 9(7).
                03      FNS-PY-CTIME                    PIC 9(6).
                03      FNS-PY-FILLER                   PIC X(4).
*> [b] --- ?那蝪∟????閬?
        02      FNS-B1-KEY REDEFINES FNS-P-KEY.
                03      FNS-B1-KEY-1.
*> .............?那蝪∟?? [A]??閮箇陛閮?閬?[B]??閮箇陛閮?? [C]??閮箇陛閮?閬?瘨?[D]
                        04      FNS-B1-CLS-ID           PIC X(01).
*> .............?那蝪∟?敺???[N]??閮箇陛閮歇?? [Y]
                        04      FNS-B1-TRN-SW           PIC X(01).
*> .............?那蝪∟?撖怠??
                        04      FNS-B1-CRE-DATE         PIC 9(07).
                        04      FNS-B1-CRE-TIME         PIC 9(06).
*> .............[O]?閮箝I]雿
                        04      FNS-B1-IP-CLSW          PIC X(01).
*> .............?那??思誘摨?
                        04      FNS-B1-IP-NO            PIC X(11).
                        04      FNS-B1-FILLER           PIC X(13).
*> [c] --- 雿?思誘銵典?神瑼隤方???
        02      FNS-C1-KEY REDEFINES FNS-P-KEY.
                03      FNS-C1-KEY-1.
*> .............霅瑞?蝡誨??
                        04      FNS-C1-IBG-UNIT-NO      PIC X(05).
*> .............?交?
                        04      FNS-C1-IBG-DT           PIC 9(07).
*> .............銵典摨?(瘚偌??
                        04      FNS-C1-IBG-SEQ          PIC 9(10).
                        04      FNS-C1-FILLER           PIC X(18).
*> [f] --- ????隞賡?????
        02      FNS-F1-KEY REDEFINES FNS-P-KEY.
*> .............?風?Ⅳ
                03      FNS-F1-PAT-NO                   PIC 9(08).
*> .............?亙??遢????2摮?
                03      FNS-F1-FACTOR                   PIC X(32).
*> [g] --- ???刻?啣?閮?
        02      FNS-G1-KEY REDEFINES FNS-P-KEY.
*> .............?啣??交?
                03      FNS-G1-UPD-DT-DEC               PIC 9(07).
*> .............?啣???
                03      FNS-G1-UPD-TI-DEC               PIC 9(06).
*> .............?風?Ⅳ
                03      FNS-G1-PAT-NO                   PIC 9(08).
*>..............NKA
                03      FNS-G1-NKA                      PIC X(01).
                03      FNS-G1-FILLER                   PIC X(18).

*> [h] --- 摮?內閮餉?
        02      FNS-H1-KEY REDEFINES FNS-P-KEY.
*> .............?雿???
                03      FNS-H1-NO.
                        04      FNS-H1-DT               PIC 9(07).
                        04      FNS-H1-SEQ              PIC 9(04).

*> .............瘚偌??
                03      FNS-H1-NO-SEQ                   PIC 9(03).
*> .............?雿???[O]?閮?[I]雿
                03      FNS-H1-IO                       PIC X(01).
                03      FNS-H1-FILLER                   PIC X(25).
*> [i] 98.07.10 ?游??扯風?怠葦
        02      FNS-PI1-KEY REDEFINES FNS-P-KEY.
*> .............雿摨?
                03      FNS-PI1-IPD-NO.
                        04      FNS-PI1-IPD-DATE        PIC 9(07).
                        04      FNS-PI1-IPD-SEQ         PIC 9(04).
*> .............?游??扯風?怠葦1-4
                03      FNS-PI1-SEQ                     PIC 9(01).
                03      FNS-PI1-FILLER                  PIC X(28).
*> [k] 99.03.24
        02      FNS-KI1-KEY REDEFINES FNS-P-KEY.
*> .............??Ⅳ
                03      FNS-PK1-PAT-NO                  PIC 9(08).
*>..............[1].擃◢??[2].閬?撠梢
                03      FNS-PK1-PAT-ID                  PIC X(01).
*
                03      FNS-PK1-FILLER                  PIC X(31).
*> [m] --- ?飛瑼Ｘ 99.10.08
        02      FNS-M1-KEY REDEFINES FNS-P-KEY.
                03      FNS-PM1-PAT-NO                  PIC 9(08).
                03      FNS-PM1-REG-RO-NO.
                        04      FNS-PM1-REG-RO-DT       PIC 9(07).
                        04      FNS-PM1-REG-RO-SEQ      PIC 9(04).
                03      FNS-PM1-SEQ                     PIC 9(03).
                03      FNS-PM1-FILLER                  PIC X(18).

*> [n] 99.10.29 ?啁????酉閮?
        02      FNS-N1-KEY REDEFINES FNS-P-KEY.
                03      FNS-PN1-PAT-NO                  PIC 9(08).
                03      PNS-PN1-FILLER                  PIC X(32).

*> [o] 104.03.13.GD4-EVENT畾菔
        02      FNS-O1-KEY REDEFINES FNS-P-KEY.
*> .............?風?Ⅳ
                03      FNS-PO1-PAT-NO                   PIC 9(08).
*> .............銵?
                03      FNS-PO1-SEQ                      PIC 9(02).
                03      FNS-PO1-FILLER                   PIC X(30).
*> [p][r] 104.06.08??-[p]???蔭??????漲 [r]憿臬蔣??????撌脣???
        02      FNS-P1-KEY REDEFINES FNS-P-KEY.
*> .............?風??
                03      FNS-PP1-PAT-NO                  PIC 9(08).
*> .............?蔭隞?Ⅳ
                03      FNS-PP1-PRS-ID                  PIC X(09).
                03      FNS-PP1-FILLER                  PIC X(23).
*> [q] 104.06.08??-???亦????
        02      FNS-Q1-KEY REDEFINES FNS-P-KEY.
*> .............?閮箏???
                03      FNS-PQ1-RO-NO.
*> .....................?閮箸??
                        04      FNS-PQ1-RO-DT           PIC 9(07).
*> .....................?閮箸?瘞渲?

                        04      FNS-PQ1-RO-SEQ          PIC 9(04).
*> .............撱箸?摨?(?游撐?銝剔????活)(ODR1-CRE-NO)
                03      FNS-PQ1-CRE-NO                  PIC 9(5).
                03      FNS-PQ1-FILLER                  PIC X(24).
*> [s] 105.05.10 ATC CODE??閮?(??????Ｖ蝙??
        02      FNS-S1-KEY REDEFINES FNS-P-KEY.
*> .............?風??
                03      FNS-PS1-PAT-NO                  PIC 9(08).
*> .............ATC CODE
                03      FNS-PS1-ATC-CODE                PIC X(07).
*> .............??
                03      FNS-PS1-FILLER                  PIC X(25).
*> [t] 105.10.05 ATC CODE??閮??啣?(??????Ｖ蝙??
        02      FNS-T1-KEY REDEFINES FNS-P-KEY.
*> .............?風?Ⅳ
                03      FNS-PT1-PAT-NO                  PIC 9(08).
*> .............?啣??交?(??)
                03      FNS-PT1-DT                      PIC 9(07).
*> .............?啣???(??)
                03      FNS-PT1-TIME                    PIC 9(06).
*> .............ATC CODE
                03      FNS-PT1-ATC-CODE                PIC X(07).
*> .............??
                03      FNS-PT1-FILLER                  PIC X(12).
*> [u] ??-???刻?芷??
        02      FNS-U1-KEY REDEFINES FNS-P-KEY.
*> .............?風?Ⅳ
                03      FNS-PU1-PAT-NO                  PIC 9(08).
*> .............?啣??交?(??)
                03      FNS-PU1-DT-DEC                  PIC 9(07).
*> .............?啣???(??)
                03      FNS-PU1-TIME-DEC                PIC 9(06).
*> .............霅(1.???亦 3.ATC CODE 5.?嗡?閮?)
                03      FNS-PU1-ID                      PIC X(01).
*> .............??
                03      FNS-PU1-FILLER                  PIC X(18).
*> [v] ???刻?內?交?
        02      FNS-V1-KEY REDEFINES FNS-P-KEY.
*> .............?風?Ⅳ
                03      FNS-PV1-PAT-NO                  PIC 9(08).
*> .............??
                03      FNS-PV1-FILLER                  PIC X(32).
*> [w] 雿?思誘霅瑞?蝡”?桀?og 107.01.05
        02      FNS-W1-KEY REDEFINES FNS-P-KEY.
*> .............霅瑞?蝡誨??
                        04      FNS-PW1-UNIT-NO         PIC X(05).
*> .............??交?
                        04      FNS-PW1-IBG-DT          PIC 9(07).
*> .............霅瑞?蝡”?桃車憿?
                03      FNS-PW1-PAPER-ID                PIC X(01).
*> .............撱箸???
                03      FNS-PW1-CRE-TM                  PIC 9(06).
*> .............蝔?畾菔
                03      FNS-AW1-FUNC                    PIC X(02).
*> .............??
                03      FNS-PW1-FILLER                  PIC X(16).
*> [y] 獢?-??憭????臭??冽?蝷箇???

        02      FNS-Y1-KEY REDEFINES FNS-P-KEY.
*> .............雿摨?
                03      FNS-PY1-IPD-NO.
*> .............雿?交?
                        04      FNS-PY1-IPD-DT          PIC 9(07).
*> .............雿瘚偌??
                        04      FNS-PY1-IPD-SEQ         PIC 9(04).
*> .............??
                03      FNS-PY1-FILLER                  PIC X(29).
*> [z] 獢?-??思誘摮?霅衣內憓耨 (107.08.27) (璆?07012902) (DM1801-J1800319)
*> ??/??雿??? ?撣思?憭拙閬?撅??摰, ?亙?閫??敺? ?嗅予撠梢?臭誑??
*> ?隞乩誑銝?甈??貼EY閮? , ?思誘???臭誑?????臬?圾?? , ?停?舫?蝡?,
*> 瘝停撖思?蝑???亙?閫??
        02      FNS-Z1-KEY REDEFINES FNS-P-KEY.
*> .............?O/?乍/雿 霅
                03              FNS-PZ1-IOE                             PIC X(01).
*> .............?閮??亥那/雿摨?
        03      FNS-PZ1-NO.
                04      FNS-PZ1-DT                      PIC 9(07).
                04      FNS-PZ1-SEQ                     PIC 9(04).
*> .............???交? (蝟餌絞?交?)
                03              FNS-PZ1-CRE-DATE                PIC 9(07).
*> .............???怠葦
                03              FNS-PZ1-DR                              PIC X(04).
*> .............?蔭隞?Ⅳ
                03              FNS-PZ1-FEE-PRS                 PIC X(09).
                03              FNS-PZ1-FILLER                  PIC X(08).
*> [1] 2021/03/19 ??emr隤踵?喲??????脩楝) - ?
        02      FNS-P11-KEY REDEFINES FNS-P-KEY.
*> .........霅(1:雿?? 2:?粹??)
                03  FNS-P11-ID                          PIC X(01).
*> .........雿摨?
                03  FNS-P11-IPD-NO.
                        04      FNS-P11-IPD-DATE        PIC 9(07).
                        04      FNS-P11-IPD-SEQ         PIC 9(04).
*> .........鞈??交?
                03  FNS-P11-DAT-NO.
                       04      FNS-P11-DAT-DT           PIC 9(07).
*> .........撱箸?摨?
                       04      FNS-P11-CRE-SEQ          PIC 9(10).
*> .........??
                03      FNS-P11-FILLER                  PIC X(11).
*>
*> [3] ?啣???瑼ａ?閰血?撠?鋆賡?頛詨?詨???貉岫???靽Ⅳ??
*>     ?批捆??HO_DGM.SON , HODGM-SON-ID = C19 銋ODGM-SON-SKEY
        02      FNS-P2-KEY REDEFINES FNS-P-KEY.
*>      .............?:O 雿?I
                        03      FNS-P2-IO                                                               PIC X(01).
*>  .............?摨? : ?交?閮摧EG-RO-NO , ?交雿 ICA-ODR-NO
                        03      FNS-P2-C19-NO                                   PIC X(11).
*>      .............瑼ａ??:
*>        PCR ?賊瑼ａ? (?桀??芣???
*>        FST 敹恍炎撽?,        SPI ??瑼Ｘ葫  (?????, ?桀?銝?????
                        03      FNS-P2-C19-ITEM                                 PIC     X(03).
*>      .............頨怠?霅? (敹怎祟?湔?臬??)
                        03      FNS-P2-IDNO                                                     PIC X(10).
*>      .............??

                        03      FNS-P2-FILLER                                           PIC X(15).
*>********************************************************************
*>                          ?? KEY1
*>********************************************************************
        02      FNS-A-KEY                               PIC X(40).
*> [A] [S]
        02      FNS-AA-KEY REDEFINES FNS-A-KEY.
*> .............?風?Ⅳ
                03      FNS-AA-PAT                      PIC 9(08).
*> .............?乩?蝘
                03      FNS-AA-BDPT                     PIC X(04).
*> .............?閮箏?????)
                03      FNS-AA-DNO.
                        04      FNS-AA-DDT              PIC 9(07).
                        04      FNS-AA-DSEQ             PIC 9(04).
                03      FNS-AA-FILLER                   PIC X(17).
*> [C] [O] [Q] [R] [V] [g] [j]
        02      FNS-AC-KEY REDEFINES FNS-A-KEY.
*> .............?風?Ⅳ
                03      FNS-AC-PAT                      PIC 9(08).
                03      FNS-AC-FILLER                   PIC X(32).
*> [E]
        02      FNS-AE-KEY REDEFINES FNS-A-KEY.
*> .............?那?瘜?
                03      FNS-AE-OK                       PIC X(01).
*> .............摰???(??)
                03      FNS-AE-Y-DEC-DATE.
                        04      FNS-AE-Y-DEC-DT         PIC 9(07).
                        04      FNS-AE-Y-DEC-TIME       PIC 9(04).
*> .............?閮箏?敺???)
                03      FNS-AE-DEC-RO-NO.
                        04      FNS-AE-DEC-RO-DT        PIC 9(07).
                        04      FNS-AE-DEC-RO-SEQ       PIC 9(04).
                03      FNS-AE-FILLER                   PIC X(17).
*> [G]
        02      FNS-AG-KEY REDEFINES FNS-A-KEY.
*> .............?摨?
                03      FNS-AG-ODR-NO.
                        04      FNS-AG-INS-DATE         PIC 9(07).
                        04      FNS-AG-ODR-SEQ          PIC 9(04).
*> .............雿摨?
                03      FNS-AG-IPD-NO.
                        04      FNS-AG-IPD-DATE         PIC 9(07).
                        04      FNS-AG-IPD-SEQ          PIC 9(04).
                03      FNS-AG-FILLER                   PIC X(18).
*>
*> NOTE : [H]?J]KEY?????瑕漲閬?璅? ????豢閰Ｙ?撘?梁??
*>
*> [H][Z]
        02      FNS-AH-KEY REDEFINES FNS-A-KEY.
*> .............[1]?瑁 [2]隤? [3]?拍?
                03      FNS-AH-DEPT                     PIC X(01).
*> .............[H]撌脤?蝡祥????[ /Y]
*> .............[Z]撌脣銵祥??[ /Y]
                03      FNS-AH-OK                       PIC X(01).
                03      FNS-AH-FILLER                   PIC X(38).
*> [J]

        02      FNS-AJ-KEY REDEFINES FNS-A-KEY.
*> .............[1]?瑁 [2]隤? [3]?拍?
                03      FNS-AJ-DEPT                     PIC X(01).
*> .............撌脤?蝡祥????[ /Y]
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
*> ???(??)
                03      FNS-AX-DEC-ODR-DT               PIC 9(07).
                03      FNS-AX-FILLER                   PIC X(25).
*> [Y]
        02      FNS-AY-KEY REDEFINES FNS-A-KEY.
*> .............?風?Ⅳ
                03      FNS-AY-PAT                      PIC 9(08).
*> .............蝘
                03      FNS-AY-DPT                      PIC X(04).
*> .............撱箸???
                03      FNS-AY-CDATE                    PIC 9(07).
*> .............撱箸???
                03      FNS-AY-CTIME                    PIC 9(06).
                03      FNS-AY-FILLER                   PIC X(15).
*> [a]
        02      FNS-AA1-KEY REDEFINES FNS-A-KEY.
*> .............?風?Ⅳ
                03      FNS-AA1-PAT                     PIC 9(08).
*> .............?怨?蝔桅?
                03      FNS-AA1-INJ-KIND                PIC X(06).
                03      FNS-AA1-FILLER                  PIC X(26).
*> [b] --- ?那蝪∟????閬?
        02      FNS-AB1-KEY REDEFINES FNS-A-KEY.
                03      FNS-AB1-KEY-1.
*> .............?那蝪∟?????
                        04      FNS-AB1-TRN-DATE        PIC 9(07).
                        04      FNS-AB1-TRN-TIME        PIC 9(06).
*> .............?那蝪∟?? [A]??閮箇陛閮?閬?[B]??閮箇陛閮?? [C]??閮箇陛閮?閬?瘨?[D]
                        04      FNS-AB1-CLS-ID          PIC X(01).
                        04      FNS-AB1-FILLER          PIC X(26).
*> [d] 撅勗?Ｗ雀?? (?涔EY1 ?風?Ⅳ + ?∪? + ?嗆活?閮箏???)
        02      FNS-DD-KEY REDEFINES FNS-A-KEY.
*> .............?風?Ⅳ
                03      FNS-DD-PAT-NO                   PIC 9(08).
*> .............???∟?
                03      FNS-DD-INS-NO                   PIC X(04).

*> .............?嗆活?閮箏?????)
                03      FNS-DD-DNO.
                        04      FNS-DD-DDT              PIC 9(07).
                        04      FNS-DD-DSEQ             PIC 9(04).
                03      FNS-DD-FILLER                   PIC X(17).
*> [f] --- ????隞賡?????
        02      FNS-AF1-KEY REDEFINES FNS-A-KEY.
*> .............?亙??遢????0摮?
                03      FNS-AF1-FACTOR                  PIC X(40).
*> [h] --- 摮?內閮餉?
        02      FNS-AH1-KEY REDEFINES FNS-A-KEY.
*> .............?風?Ⅳ
                03      FNS-AH1-PAT                     PIC 9(08).
*> .............?閮箸??
                03      FNS-AH1-DT                      PIC 9(07).
                03      FNS-AH1-FILLER                  PIC X(25).
*> [i] 98.07.10 ?游??扯風?怠葦
        02      FNS-AI1-KEY REDEFINES FNS-A-KEY.
*> .............?游??扯風?怠葦隞?Ⅳ
                03      FNS-AI1-DR-NO                   PIC X(04).
                03      FNS-AI1-FILLER                  PIC X(36).
*> [l] ?啣之?脫?-?亥那頧?摨??絞閮???(99.06.15)
        02      FNS-AL1-KEY REDEFINES FNS-A-KEY.
                03      FNS-AL1-DPT                     PIC X(04).
                03      FNS-AL1-FILLER                  PIC X(36).
*> [u] ??-???刻?芷??
        02      FNS-AU1-KEY REDEFINES FNS-A-KEY.
*> .............?啣???
                03      FNS-AU1-USER-ID                 PIC X(05).
*> .............?啣??交?(??)
                03      FNS-AU1-DT-DEC                  PIC 9(07).
*> .............?啣???(??)
                03      FNS-AU1-TIME-DEC                PIC 9(06).
*> .............??
                03      FNS-AU1-FILLER                  PIC X(22).
*> [w] 雿?思誘霅瑞?蝡”?桀?og 107.01.05
        02      FNS-AW1-KEY REDEFINES FNS-A-KEY.
*> .............RNU??or QUE銵典???瘚偌??
                03      FNS-PW1-IBG-SEQ                 PIC 9(10).

                03      FNS-PW1-FILLER                  PIC X(30).
*> [y] 獢?-??憭????臭??冽?蝷箇???
        02      FNS-AY1-KEY REDEFINES FNS-A-KEY.
*> .............?風??
                03      FNS-AY1-PAT-NO                  PIC 9(08).
*> .............撖阡??ａ??
                03      FNS-AY1-IPD-LEAVE-DT            PIC 9(07).
*> .............??
                03      FNS-AY1-FILLER                  PIC X(25).
*> [z] 獢?-??思誘摮?霅衣內憓耨 (107.08.27) (璆?07012902) (DM1801-J1800319)
        02      FNS-AZ1-KEY REDEFINES FNS-A-KEY.
*> .........?風?Ⅳ
                03  FNS-AZ1-PAT-NO                      PIC 9(08).
*> .........?亙? : ?????交?
                03      FNS-AZ1-UNLOCK-DATE             PIC 9(07).
*> .........??
                03      FNS-AZ1-FILLER                  PIC X(25).

*>********************************************************************
*>                          ?? KEY2
*>********************************************************************
        02      FNS-B-KEY                               PIC X(40).
*> [E] [R]
        02      FNS-BE-KEY REDEFINES FNS-B-KEY.
*> .............?風?Ⅳ
                03      FNS-BE-PAT-NO                   PIC 9(08).
*> .............?閮箏?敺???)
                03      FNS-BE-DEC-RO-NO.
                        04      FNS-BE-DEC-RO-DT        PIC 9(07).
                        04      FNS-BE-DEC-RO-SEQ       PIC 9(04).
                03      FNS-BE-FILLER                   PIC X(21).
*> [H] ?閮箏?雿?思誘?蝙?冽迨隞?Ⅳ
*> [Z]
*> NOTE : 敺拙瘝餌?撣恍?蝡祥???? 撠勗?隞乩?鞈??砍;
*>        ?血??怠葦??頧??? 鞈?撠征?賜?
        02      FNS-BH-KEY REDEFINES FNS-B-KEY.
*> .............[1]?瑁 [2]隤? [3]?拍?
                03      FNS-BH-DEPT                     PIC X(01).
*> .............[H]瘝餌??蔭???交???
*> .............[Z]瘝餌??蔭?瑁??交???
                03      FNS-BH-OT-DT-DEC                PIC 9(07).
                03      FNS-BH-FILLER                   PIC X(32).
*> [Q] [V]
        02      FNS-BQ-KEY REDEFINES FNS-B-KEY.
*> .............?風?Ⅳ
                03      FNS-BQ-PAT-NO                   PIC 9(08).
*> .............(??)(?閮?>?閮箏??? , (雿->?摨?)
                03      FNS-BQ-DEC-ODR-NO.
                        04      FNS-BQ-DEC-ODR-DATE     PIC 9(07).
                        04      FNS-BQ-DEC-ODR-SEQ      PIC 9(04).
                03      FNS-BQ-FILLER                   PIC X(21).
*> [S]
        02      FNS-BS-KEY REDEFINES FNS-B-KEY.
*> .............?風?Ⅳ
                03      FNS-BS-PAT                      PIC 9(08).
*> .............?乩?蝘
                03      FNS-BS-DPT                      PIC X(04).
*> .............?蝯?????)
                03      FNS-BS-END-DT-DEC               PIC 9(07).
                03      FNS-BS-FILLER                   PIC X(21).
*> [X]
        02      FNS-BX-KEY REDEFINES FNS-B-KEY.
                03      FNS-BX-IDNO                     PIC X(10).
*> ???(??)
                03      FNS-BX-DEC-ODR-DT               PIC 9(07).
                03      FNS-BX-FILLER                   PIC X(23).
*> [Y]
        02      FNS-BY-KEY REDEFINES FNS-B-KEY.
*> .............?風?Ⅳ
                03      FNS-BY-PAT                      PIC 9(08).
*> .............撱箸??交?
                03      FNS-BY-CDATE                    PIC 9(07).
*> .............撱箸???
                03      FNS-BY-CTIME                    PIC 9(06).
                03      FNS-BY-FILLER                   PIC X(19).

*> [a]
        02      FNS-BA1-KEY REDEFINES FNS-B-KEY.
*> .............?風?Ⅳ
                03      FNS-BA1-PAT                     PIC 9(08).
*> .............?瑁??活
                03      FNS-BA1-RUN                     PIC X(01).
                03      FNS-BA1-FILLER                  PIC X(31).
*> [b] --- ?那蝪∟????閬?
        02      FNS-BB1-KEY REDEFINES FNS-B-KEY.
                03      FNS-BB1-KEY-1.
*> .............?那銝餅?銝膊EY (MET-SYS-KEY)
                        04      FNS-BB1-SYS-KEY         PIC X(21).
*> .............?那銝餅?銝膊EY (MET-NOT-NO)
                        04      FNS-BB1-NOT-NO          PIC X(11).
                        04      FNS-BB1-FILLER          PIC X(08).
*> [d] 撅勗?Ｗ雀???? (?涔EY2 蝚砌?甈⊿?閮箏???+ ?嗆活?閮箏???
        02      FNS-DE-KEY REDEFINES FNS-B-KEY.
*> .............??蝚砌?甈⊿?閮箏???
                03      FNS-DE-1ST-RO-NO.
                        04      FNS-DE-1ST-RO-DT        PIC 9(07).
                        04      FNS-DE-1ST-RO-SEQ       PIC 9(04).
                03      FNS-DE-FILLER                   PIC X(29).
*> [g] --- ???刻?啣?閮?
        02      FNS-BG1-KEY REDEFINES FNS-B-KEY.
*> .............?啣??撌亦楊??
                03      FNS-BG1-UPD-USR-ID              PIC X(05).
                03      FNS-BG1-FILLER                  PIC X(35).
*> [i] --- 98.12.30 ?游??扯風 ---
        02      FNS-BI1-KEY REDEFINES FNS-B-KEY.
*>              ?游??扯風?交?
                03      FNS-BI1-CRE-DT                  PIC 9(07).
                03      FNS-BI1-DATA-FILLER             PIC X(33).
*> [u] ??-???刻?芷??
        02      FNS-BU1-KEY REDEFINES FNS-B-KEY.
*> .............?啣??交?(??)
                03      FNS-BU1-DT-DEC                  PIC 9(07).
*> .............?啣???(??)
                03      FNS-BU1-TIME-DEC                PIC 9(06).
*> .............??
                03      FNS-BU1-FILLER                  PIC X(27).
*> =====================================================================
*>              鞈?                             ??
*> =====================================================================
*$XFD USE GROUP, VAR-LENGTH
        02      FNS-DATA                        PIC X(150).
*> .... [A]
        02      FNS-A-DATA REDEFINES FNS-DATA.
*> 蝘
                03      FNS-A-DPT               PIC X(04).
                03      FNS-A-FILLER            PIC X(146).
*> .... [B]
        02      FNS-B-DATA REDEFINES FNS-DATA.
*> 擃?
                03      FNS-B-WEI               PIC 9(03)V9.
*> 銵憯?
                03      FNS-B-BLD-PRE-1         PIC 9(03)V9.
                03      FNS-B-BLD-PRE-2         PIC 9(03)V9.

*> 擃澈
                03      FNS-B-TEM               PIC 9(02)V9.
*> ?孵?閮?[1]?那 [2]銴那
                03      FNS-B-ID                PIC X(01).
                03      FNS-B-FILLER            PIC X(134).
*> .... [C]
        02      FNS-C-DATA REDEFINES FNS-DATA.
*> 霈銋撣?
                03      FNS-C-DR                PIC X(04).
*> ?惇??
                03      FNS-C-OTYPE             PIC X(04).
*> ?啣惇??
                03      FNS-C-NTYPE             PIC X(04).
                03      FNS-C-FILLER            PIC X(138).
*> .... [D][F][I][M]
        02      FNS-D-DATA REDEFINES FNS-DATA.
                03      FNS-D-RMK               PIC X(70).
                03      FNS-D-FILLER            PIC X(80).
*> .... [G]
        02      FNS-G-DATA REDEFINES FNS-DATA.
*> ?臬??Ｙ????[Y] [N]
                03      FNS-G-PILL-CHK          PIC X(01).
*> ICA-EMG-CD
                03      FNS-G-ICA-EMG-CD        PIC X(01).
*> ICA-DR-YN
                03      FNS-G-ICA-DR-YN         PIC X(01).
*> W-MED-CHK
                03      FNS-G-W-MED-CHK         PIC X(01).
*> ?澆 HIPILLCF ???
                03      FNS-G-W-PILLCF-YN1      PIC X(01).
*> ?瑼?撖怎???
                03      FNS-G-ICA-MST-STATUS1   PIC X(02).
                03      FNS-G-QUE-PILL-NO1      PIC X(04).
*> ?澆 HIPILLCF ???
                03      FNS-G-W-PILLCF-YN2      PIC X(01).
*> ?瑼?撖怎???
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
*> NOTE : [H]?J]?????瑕漲閬?璅? ????豢閰Ｙ?撘?梁??
*>
*> .....[H]
        02      FNS-H-DATA REDEFINES FNS-DATA.
*> (DR.)頧??交?
                03      FNS-H-REF-DT            PIC 9(07).
*> (DR.)頧???
                03      FNS-H-REF-TIME          PIC 9(06).
*> 頧??怠葦
                03      FNS-H-DR                PIC X(04).
*> ?風?Ⅳ

                03      FNS-H-PAT-NO            PIC 9(08).
*> 瘝餌?撣恍?蝡?蝵格??
                03      FNS-H-OT-DT             PIC 9(07).
                03      FNS-H-FILLER            PIC X(118).
*> .....[J]
        02      FNS-J-DATA REDEFINES FNS-DATA.
*> (DR.)頧??交?
                03      FNS-J-REF-DT            PIC 9(07).
*> (DR.)頧???
                03      FNS-J-REF-TIME          PIC 9(06).
*> 頧??怠葦
                03      FNS-J-DR                PIC X(04).
*> ?風?Ⅳ
                03      FNS-J-PAT-NO            PIC 9(08).
*> 瘝餌?撣恍?蝡?蝵格??
                03      FNS-J-OT-DT             PIC 9(07).
                03      FNS-J-FILLER            PIC X(118).
*>......[L]
        02      FNS-L-DATA REDEFINES FNS-DATA.
*> 憿隞??
                03      FNS-L-6119-TBL.
                        04      FNS-L-6119-ID OCCURS 50 TIMES PIC X(02).
                03      FNS-L-FILLER            PIC X(50).
*> .....[N]
        02      FNS-N-DATA REDEFINES FNS-DATA.
*> 蝺楝蝺刻?
                03      FNS-N-PC-NO             PIC 9(03).
*> ???潛??交? (蝟餌絞?交?)
                03      FNS-N-LOCK-DT           PIC 9(07).
*> ???潛??? (蝟餌絞??)
                03      FNS-N-LOCK-TIME.
                        04  FNS-N-LOCK-HH       PIC 99.
                        04  FNS-N-LOCK-MT       PIC 99.
                        04  FNS-N-LOCK-SS       PIC 99.
                03      FNS-N-FILLER            PIC X(134).
*>......[N]
        02      FNS-N2-DATA REDEFINES FNS-DATA.
*> 靘?蝔?
                03      FNS-N-CALL-FROM         PIC X(10).
*> 銵典摨?
                03      FNS-N-NUM               PIC 9(10).
*> ?瘜Ⅳ隤芣?
                03      FNS-N-ERR.
                        04      FNS-N-ERR-FS    PIC X(08).
                        04      FNS-N-ERR-TEXT  PIC X(40).
                03      FNS-N2-FILLER           PIC X(82).
*> .....[O]
        02      FNS-O-DATA REDEFINES FNS-DATA.
*> ?航炊鞈?
                03      FNS-O-REC               PIC X(150).
*> .....[P]
        02      FNS-P-DATA REDEFINES FNS-DATA.
*> [1]?啣? [2]靽格 [3]?芷
                03      FNS-P-ID                PIC X(01).
                03      FNS-P-FILLER            PIC X(149).
*> .....[Q]
        02      FNS-Q-DATA REDEFINES FNS-DATA.

*> [Y]憭瑼Ｘ
                03      FNS-Q-OUT               PIC X(01).
*> ?蔭隞?Ⅳ
                03      FNS-Q-MST-ID            PIC X(09).
*> ?乩?隞?Ⅳ
                03      FNS-Q-INS-ID            PIC X(16).
*> 撱箸???
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
*> ?貉??[Y/N]
                03      FNS-V-SMK               PIC X(01).
*> ?????[Y/ ] (?內敺????岷?????)
                03      FNS-V-SUCE              PIC X(01).
*> ??芾?閮粹?孵? (?餃??萎辣??1',?餉店憭??2',??蝪∟???3')
                03      FNS-V-TEL-WAY           PIC X(01).
*> ??芾?閮粹?交?
                03      FNS-V-TEL-DATE          PIC 9(07).
*> ??芾?閮粹??
                03      FNS-V-TEL-TIME          PIC 9(04).
                03      FNS-V-FILLER            PIC X(136).
*> .....[X] --- ?箇??????
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
*> ?風?Ⅳ
                03      FNS-Z-PAT-NO            PIC 9(08).

*> 瘝餌?撣怠銵??
                03      FNS-Z-OT-DT             PIC 9(07).
*> 瘝餌?撣思誨蝣?
                03      FNS-Z-OT-USER           PIC X(05).
                03      FNS-Z-FILLER            PIC X(130).
*> .....[a]
        02      FNS-A1-DATA REDEFINES FNS-DATA.
*> 憭找噶?∠祟瑼Ｙ???(N:甇?虜 , A:銝迤撣?, U:銝??銝Ⅱ摰?
                03      FNS-A1-STL-RST          PIC X(01).
*> 撠梯那?交???
                03      FNS-A1-DT-TM            PIC 9(13).
*> ?蔭摨?
                03      FNS-A1-FEE-NO           PIC 9(03).
                03      FNS-A1-FILLER           PIC X(133).
*> [b] --- ?那蝪∟????閬?閮箇陛閮????閬?瘨?
        02      FNS-B1-DATA REDEFINES FNS-DATA.
*> .............?那??風?Ⅳ 1:8
                03      FNS-B1-PAT-NO           PIC 9(08).
*> .............?澆??撣怒?箏?閬??怠葦??粹???撣怒?箏?閬?瘨??怠葦 9:4
                03      FNS-B1-SEND-DR-NO       PIC X(04).
*> .............?交????乓?嗅?閬?蝘??園?????乓?嗅?閬?瘨?蝘 13:4
                03      FNS-B1-RECV-IP-DPT      PIC X(04).
*> .............?交??撣怒?嗅?閬??怠葦??園???撣怒?嗅?閬?瘨??怠葦 17:4
                03      FNS-B1-RECV-DR-NO       PIC X(04).
*> .............?那蝪∟??喲隤斤Ⅳ 21:1
                03      FNS-B1-ERR-ID           PIC X(01).
*> .............?那蝔桅? [1]?交?閮?[2]銝?祆?閮?
                03      FNS-B1-MET-ID           PIC X(01).
*> .............?憪? 107.01.03 (23:12)
                03      FNS-B1-PAT-NM           PIC X(12).
*> .............????107.01.03   (35:6)
                03      FNS-B1-BED              PIC X(06).
                03      FNS-B1-DATA-FILLER      PIC X(110).
*> [c] --- 雿?思誘銵典?神瑼隤方???
        02      FNS-C1-DATA REDEFINES FNS-DATA.
*> .............撖急????
                03      FNS-C1-STATUS           PIC X(60).
                03      FNS-C1-DATA-FILLER      PIC X(90).
*> [d] --- 撅勗?Ｗ雀????DATA
        02      FNS-D1-DATA REDEFINES FNS-DATA.
*> .............??蝘
                03      FNS-D1-DPT-NO           PIC X(04).
*> .............??摨?
                03      FNS-D1-INS-SEQ          PIC 9(02).

                03      FNS-D1-DATA-FILLER      PIC X(144).
*> [f] --- ????隞賡?????
        02      FNS-F1-DATA REDEFINES FNS-DATA.
*> .............?遢???券)
                03      FNS-F1-FACTOR-NAME      PIC X(50).
                03      FNS-F1-DATA-FILLER      PIC X(100).
*> [h] --- 摮?內閮餉?
        02      FNS-H1-DATA REDEFINES FNS-DATA.
                03      FNS-H1-DIS-MRK          PIC X(01).
                03      FNS-H1-DATA-FILLER      PIC X(149).
*> [i] --- ?游??扯風?怠葦
        02      FNS-I1-DATA REDEFINES FNS-DATA.

*>              蝯???
                03      FNS-I1-END-DT           PIC 9(07).
*>              撱箸???
                03      FNS-I1-CRE-USER         PIC X(05).
*>              撱箸???
                03      FNS-I1-CRE-DT           PIC 9(07).
*>              撱箸???
                03      FNS-I1-CRE-TI           PIC 9(04).
*>              ?啣???
                03      FNS-I1-MOD-USER         PIC X(05).
*>              ?啣???
                03      FNS-I1-MOD-DT           PIC 9(07).
*>              ?啣???
                03      FNS-I1-MOD-TI           PIC 9(04).
                03      FNS-I1-DATA-FILLER      PIC X(111).
*> [l] ?啣之?脫?-?亥那頧?摨??絞閮???(99.06.15)
        02      FNS-L1-DATA REDEFINES FNS-DATA.
                03      FNS-L1-WAIT-DT.
                        05 FNS-L1-WAIT-DATE             PIC 9(07).
                        05 FNS-L1-WAIT-TIME             PIC 9(06).
                03      FNS-L1-TRNS-DT.
                        05 FNS-L1-TRNS-DATE             PIC 9(07).
                        05 FNS-L1-TRNS-TIME             PIC 9(06).
                03      FNS-L1-FILLER                   PIC X(124).
*> [m] emr?ag
        02      FNS-M1-DATA REDEFINES FNS-DATA.
                03      FNS-M1-RESULT                   PIC X(60).
                03      FNS-M1-FILLER                   PIC X(90).
*> [n] 99.10.29 ?啁????酉閮?
        02      FNS-N1-DATA REDEFINES FNS-DATA.
*--------------->?批
                03      FNS-N1-PAT-SEX                  PIC 9(01).
*--------------->?啁????酉閮?
                03      FNS-N1-MUTI-BN-MRK              PIC 9(01).
*--------------->?啁??停?怨酉閮?
                03      FNS-N1-BN-CUR-MRK               PIC X(01).
                03      FNS-N1-FILLER                   PIC X(147).

*> [o] ???刻?寞?閮餉??逼RID-104.03.13.GD4-EVENT畾菔
        02      FNS-O1-DATA REDEFINES FNS-DATA.
*>              ???刻?寞?閮餉?
                03  FNS-O1-RMK                          PIC X(60).
                03  FNS-O1-FILLER                       PIC X(90).
*> [p] 104.06.08??-???蔭??????漲
        02      FNS-P1-DATA REDEFINES FNS-DATA.
*>              ?湧?摨?
                03      FNS-P1-LEVEL                    PIC X(01).
*>              ????
                03      FNS-P1-ADR                      PIC X(60).
*>              ?賊???
                03      FNS-P1-CORRELATION              PIC X(01).
*>              ??
                03      FNS-P1-FILLER                   PIC X(88).
*> [q] 104.06.08??-???亦????
        02      FNS-Q1-DATA REDEFINES FNS-DATA.
*>              ??隞?Ⅳ
                03      FNS-Q1-REA-NO                   PIC X(05).

*>              ?芾膩??
                03      FNS-Q1-REA-DATA                 PIC X(60).
                03      FNS-Q1-FILLER                   PIC X(85).
*> [r] 104.06.08??-憿臬蔣??????撌脣???
        02      FNS-R1-DATA REDEFINES FNS-DATA.
*>              ?蔭隞?Ⅳ
                03      FNS-R1-PRS-ID                   PIC X(09).
                03      FNS-R1-FILLER                   PIC X(141).
*> [s] 105.05.10 ATC CODE??閮?(??????Ｖ蝙??
        02      FNS-S1-DATA REDEFINES FNS-DATA.
*> 撱箸??交?
                03      FNS-S1-CRE-DATE                 PIC 9(07).
*> 撱箸?鈭箏
                03      FNS-S1-CRE-USER-ID              PIC X(05).
*> ???亙??迂
                03      FNS-S1-PRS-NAME                 PIC X(40).
*> ??
                03      FNS-S1-FILLER                   PIC X(98).
*> [t] 105.10.05 ATC CODE??閮??啣?(??????Ｖ蝙??
        02      FNS-T1-DATA REDEFINES FNS-DATA.
*> ?啣?鈭箏
                03      FNS-T1-USID                     PIC X(05).
*> [M]?啣? [D]?芷
                03      FNS-T1-ID                       PIC X(01).
*> NKA
                03      FNS-T1-NKA                      PIC X(01).
*> 撱箸???
                03      FNS-T1-CRE-DATE                 PIC 9(07).
*> 撱箸?鈭箏
                03      FNS-T1-CRE-USER-ID              PIC X(05).
*> ???亙??迂
                03      FNS-T1-PRS-NAME                 PIC X(40).
*> ??
                03      FNS-T1-FILLER                   PIC X(91).
*> [u] ??-???刻?芷??
        02      FNS-U1-DATA REDEFINES FNS-DATA.
*> ?芷?批捆
                03      FNS-U1-DEL-DETAIL               PIC X(60).
*> ??隞?Ⅳ
                03      FNS-U1-REA-NO                   PIC X(05).
*> ?芾膩??
                03      FNS-U1-REA-DETAIL               PIC X(60).
*> ??
                03      FNS-U1-FILLER                   PIC X(25).
*> [v] ???刻?內?交?
        02      FNS-V1-DATA REDEFINES FNS-DATA.
*> ?暸 [A]NKA [B]銝
                03      FNS-V1-REA-NO                   PIC X(01).
*> ?內?交?
                03      FNS-V1-DATE                     PIC 9(07).
*> ??
                03      FNS-V1-FILLER                   PIC X(142).
*> [w] 雿?思誘霅瑞?蝡”?桀?og 107.01.05
        02      FNS-W1-DATA REDEFINES FNS-DATA.
*>              蝔?畾菔隤芣?
                03      FNS-W1-FUNC-NM                  PIC X(40).
*>              ???

                03      FNS-W1-FILE-ST                  PIC 9(02).
                03      FNS-W1-FILLER                   PIC X(108).
*> [x] 鞊?-?芸蝜唾祥璈??唳?蝣潛???
        02      FNS-X1-DATA REDEFINES FNS-DATA.
*> 蝘
                03      FNS-X1-DPT                      PIC X(04).
*> 頨怠?
                03      FNS-X1-CLA                      PIC X(04).
*> 摮??交?
                03      FNS-X1-UPD-DATE                 PIC 9(07).
*> 摮???
                03      FNS-X1-UPD-TIME                 PIC 9(08).
*> ??
                03      FNS-X1-FILLER                   PIC X(127).
*> [y] 獢?-??憭????臭??冽?蝷箇???
        02      FNS-Y1-DATA REDEFINES FNS-DATA.
*> .............閮箸隞?Ⅳ
                03      FNS-Y1-ODZ-TBL.
                        04      FNS-Y1-ODZ-GPR OCCURS 3 TIMES.
                                05 FNS-Y1-ICD10-CODE    PIC X(12).
*> .............?蔭隞?Ⅳ
                03      FNS-Y1-FEE-PRS                  PIC X(09).
*> .............?內甈⊥
                03      FNS-Y1-PROMPT-TIMES             PIC 9(02).
*> .............蝘
                03      FNS-Y1-DPT                      PIC X(04).
*> .............銝餅祥?怠葦
                03      FNS-Y1-DR-NO                    PIC X(04).
*> .............?
                03      FNS-Y1-CANCER-ID                PIC X(04).
*> .............??
                03      FNS-Y1-FILLER                   PIC X(91).
*> .... [z] 獢?-??思誘摮?霅衣內憓耨 (107.08.27) (璆?07012902) (DM1801-J1800319)
        02      FNS-Z1-DATA REDEFINES FNS-DATA.
*> .........?思誘 : ????
                03              FNS-PZ1-CRE-TIME.
                                04      FNS-PZ1-CRE-TIME-HH     PIC 9(02).
                                04      FNS-PZ1-CRE-TIME-MM     PIC 9(02).
                                04      FNS-PZ1-CRE-TIME-SS     PIC 9(02).
*>      ........?亙? : ?????亙葦?∪極隞?Ⅳ
                03      FNS-Z1-UNLOCK-PHA               PIC X(05).
*>      ........?亙? : ??????
                03      FNZ-Z1-UNLOCK-TIME.
                        04      FNS-Z1-UNLOCK-HH        PIC 9(02).
                        04      FNS-Z1-UNLOCK-MM        PIC 9(02).
                        04      FNS-Z1-UNLOCK-SS        PIC 9(02).
*>  ........?亙? : ????蝯? [Y/????] [N/銝???蝡
                        04      FNS-Z1-CRE-YN           PIC X(01).
*>  ??
                03      FNS-Z1-FILLER                   PIC X(132).
*> [1] 2021/03/19 ??emr隤踵?喲??????脩楝) - ?
        02      FNS-11-DATA REDEFINES FNS-DATA.
*>              摰?閮餉?
                03      FNS-11-MARK                     PIC X(01).
*>              ?啣??交?
                03      FNS-11-MOD-DATE                 PIC 9(07).
*>              ?啣???

                03      FNS-11-MOD-TIME.
                        04      FNS-11-MOD-HH           PIC 9(02).
                        04      FNS-11-MOD-MM           PIC 9(02).
                        04      FNS-11-MOD-SS           PIC 9(02).
*>  ??
                03      FNS-11-FILLER                   PIC X(136).
*>  [3] ?啣???瑼ａ?閰血?撠?鋆賡?頛詨?詨???貉岫???靽Ⅳ??
        02      FNS-3-DATA REDEFINES FNS-DATA.
*>  ........撱箸?靘? [T]瑼ａ??勗??駁? [C]IC?∟?瑼?
                        03      FNS-3-CRE-FROM                                          PIC X(01).
*>      ........?賊閰血??乩?蝣?
                        03      FNS-3-A91-SUPPLEMENT                    PIC X(100).
                        03      FNS-3-DATA-FILLER                                       PIC X(49).
*> ======================================================================== <
*> [A] ??風甈⊿隞?(靘靽?)                          ?.....?瑁??思誘??
*> [B] ?寞??閮箄???(?折?雿輻)
*> [C] 霈撅祆扯??那閮?                               ?.....?瑁??思誘??
*> [D] ??酉(蝺??桀?銝蝙??                         ?.....?瑁??思誘??
*> [E] ??風甈⊥亥那                                     ?.....?瑁??思誘??
*> [F] ??畾?閮?(?寡酉)                                .....銝?芷銝???
*> [G] 雿?思誘雿輻-???撣碌OG                   ?.....?瑁??思誘?亦????
*> [H] ?閮箄?隞儔??                                      .....?瑁??思誘??
*> [I] ?閮箄?隞儔??(瘜冽?鈭?)                          ?.....?瑁??思誘??
*> [J] 雿頧?敺拙                                     ?.....?瑁??思誘??
*> [K] 雿頧?敺拙 (瘜冽?鈭?)                          ?.....?瑁??思誘??
*> [L] ?粹?風??蝝圈?閮?瑼?93.1.19)
*> [M] 瘞訾??                                           .....銝?芷銝???
*> [N] ?怠葦?瑼蝙?其葉蝺楝                               .....GUI撌脖????Ｙ?
*> [N] 雿?思誘雿輻-霅瑞?蝡”?桀???OG               ?.....?瑁??思誘?亦????
*> [O] ?亥那????航炊鞈?閮?(93.5.5)
*> [P] ?餃??風?寞活??閮?
*> [Q] 摮悅?豢???? (93.08.13)
*> [R] ?犖?靽閮?瑼?(94.02.24)
*> [S] ?Ｘ抒?????蝞?蝡???(94.03.12)?              .....?瑁??思誘?亦????
*> [T] 頧那XML?桐?瘚偌??94.3.28)
*> [U] ??風甈∠?閮箏靽???(銝?靽??亙???蝑? (2005/4/23 04:18銝?) .....銝?芷銝???
*> [V] ???內閮? (94.05.04)
*> [W] 雿?思誘摮悅?豢?蝷箄???(雿摨??箔蜓)
*> [X] ?箇?????蝡???(鞈?靽?鈭僑, ?思?撖怠?瑼?撘? (2005/9/12 03:42銝?)
*> [Y] ?鼓????(2005/10/5 02:12銝?)                   .....雿誥嚗?銝??Ｙ?鞈?
*> [Z] ?閮箏儔?亙銵Ⅱ隤???(S401-94041301)
*> [a] ?啁??之靘踹蝭拇炎閮?
*> [b] ?那蝪∟????閬?閮箇陛閮????閬?瘨?(96.03.05)
*> [c] 雿?思誘銵典?神瑼隤方???(97.8.27)-?粹?
*> [d] 撅勗?Ｗ雀?????瘙?98.01.20)
*      銝膊EY : ?嗆活?閮箏???
*      ?涔EY1: ?風?Ⅳ + ?∪? + ?嗆活?閮箏???
*      ?涔EY2: 蝚砌?甈⊿?閮箏??? + ?嗆活?閮箏???
*> [f] ????隞賡?????(98.04.16)
*> [g] ???刻?啣?閮?
*> [h] 摮?內閮餉?(??-閮?摮?內甈⊥(?桀???閮?
*> [i] ?唬葉?游??扯風?怠葦(?怠?)
*> [j] IC?⊥??∟???(????∪?芷)
*> [k] (??)蝎曄?蝘??????
*> [l] ?啣之?脫?-?亥那頧?摨??絞閮???(99.06.15)
*> [m] ?飛瑼Ｘ蝯?(99.09.23)                           ......銝?芷銝???
*> [n] ?啁????酉閮?99.10.29

*> [o] ???刻?寞?閮餉??逼RID-104.03.13.GD4-EVENT畾菔
*> [p] ??-???蔭??????漲(104.06.08)
*> [q] ??-???亦????(104.06.08)
*> [r] ??-憿臬蔣??????104.06.08)(撌脣???
*> [s] ATC CODE??閮?(??????Ｖ蝙??(105.05.10)
*> [t] ATC CODE??閮??啣?(??????Ｖ蝙??(105.10.05)
*> [u] ??-???刻?芷??(106.07.11)
*> [v] ???刻?思誘?內?交?(106.10.27)(E005286)
*> [w] 鞊?-雿?思誘霅瑞?蝡”?桀?og(107.01.05)
*> [x] 鞊?-?芸蝜唾祥璈??唳?蝣潛???(107.01.25)(璆?06062202)
*> [y] 獢?-??憭????臭??冽?蝷箇???(107.04.10)(璆?06101801)
*> [z] 獢?-??思誘摮?霅衣內憓耨 (107.08.27) (璆?07012902) (DM1801-J1800319)
*> [1] ??emr隤踵?喲???- ? (110.03.19)
*> [2] ??emr隤踵?喲???- ? (110.03.19)
*> [3] ?啣???瑼ａ?閰血?撠?鋆賡?頛詨?詨???貉岫???靽Ⅳ?? (110.08.02)
*> ======================================================================== <
*COPY    "HR_DTA.MST".
*---------------------------------------------------------------------*
* 瑼ａ????瑼?HR_DTA.MST                          瑼?嚗R_MDTA   *
*---------------------------------------------------------------------*
* 銝鳴?HRDTA-MST-KEY  = HRDTA-KEY                                      *
*---------------------------------------------------------------------*
 FD      HRDTA-MST       EXTERNAL.
 01      HRDTA-MST-REC.
* KEY ??= 雿摨? + 瑼ａ????交? + 瑼ａ???瘚偌??
*$XFD USE GROUP
        02 HRDTA-KEY.
*雿摨?
                03 HRDTA-IPD-NO.
*雿?交?
                        04 HRDTA-IPD-DATE       PIC 9(07).
*雿瘚偌??
                        04 HRDTA-IPD-SEQ        PIC 9(04).
                03 HRDTA-ODR-NO.
*瑼ａ????交?
                        04 HRDTA-INS-DATE       PIC 9(07).
*瑼ａ???瘚偌??
                        04 HRDTA-ODR-SEQ        PIC 9(06).
*$XFD USE GROUP,VAR-LENGTH
        02 HRDTA-GROUP-DATA1.
*瑼ａ????駁??怠葦
                03 HRDTA-DR-NO                  PIC X(04).
*瑼ａ????駁???
                03 HRDTA-USR-ID                 PIC X(05).
*?撱箸???
                03 HRDTA-CRE-DT                 PIC 9(07).
                03 HRDTA-CRE-TIME.
                        04 HRDTA-CRE-HH         PIC 9(02).
                        04 HRDTA-CRE-MM         PIC 9(02).
                        04 HRDTA-CRE-SS         PIC 9(02).
*>?望迨???梧?嚗???
                03 HRDTA-FILLER                 PIC X(150).
***********************************************************************
* END *
***********************************************************************
*COPY    "HR_DTB.MST".
*---------------------------------------------------------------------*

* 瑼ａ???蝝圈?瑼?HR_DTB.MST                          瑼?嚗R_MDTB   *
*---------------------------------------------------------------------*
* 銝鳴?HRDTB-MST-KEY  = HRDTB-KEY + HRDTB-FEE-SEQ                      *
*---------------------------------------------------------------------*
 FD      HRDTB-MST       EXTERNAL.
 01      HRDTB-MST-REC.
* KEY ??= 雿摨? + 瑼ａ????交? + 瑼ａ???瘚偌??+ ?蔭瘚偌??
*$XFD USE GROUP
        02 HRDTB-KEY.
*雿摨?
                03 HRDTB-IPD-NO.
*雿?交?
                        04 HRDTB-IPD-DATE       PIC 9(07).
*雿瘚偌??
                        04 HRDTB-IPD-SEQ        PIC 9(04).
                03 HRDTB-ODR-NO.
*瑼ａ????交?
                        04 HRDTB-INS-DATE       PIC 9(07).
*瑼ａ???瘚偌??
                        04 HRDTB-ODR-SEQ        PIC 9(06).
*?蔭瘚偌??
        02 HRDTB-FEE-SEQ                        PIC 9(03).
*$XFD USE GROUP,VAR-LENGTH
        02 HRDTB-GROUP-DATA1.
*?蔭隞?Ⅳ
                03 HRDTB-FEE-KEY                PIC X(09).
*蝮賡?
                03 HRDTB-RX-QTY.
*蝮賡???
                        04 HRDTB-RX-QTY1        PIC 9(04).
*蝮賡???
                        04 HRDTB-RX-QTY2        PIC 9(02).
*瑼ａ??株?
                03 HRDTB-CHK-NO.
*瑼ａ?瑼Ｘ憿隞??
                        04 HRDTB-CLS-NO.
*瑼ａ?瑼Ｘ蝘恕蝪∠Ⅳ
                                05 HRDTB-DPT-CD PIC X(1).
*瑼ａ?瑼Ｘ憿蝣?
                                05 HRDTB-CLS-CD PIC X(2).
*?瘚偌蝣?
                        04 HRDTB-PR-SEQ         PIC 9(5).
*?思誘?交?
                03 HRDTB-IP-DATE                PIC 9(7).
*?望迨???梧?嚗???
*?摨?
                03 HRDTB-ICA-ODR-NO             PIC X(11).
*瑼ａ?瑼Ｘ?隞?Ⅳ(HTCHK-ITM-CD)
                03 HRDTB-ICB-ITM-CD             PIC X(6).
*
                03 HRDTB-FILLER                 PIC X(133).
***********************************************************************
* END *
***********************************************************************

*------->瑼ａ?瑼Ｘ?曉?蝺?!
*COPY    "HT_SYS.SON".

*************
* C-PY FILE : HT_SYS.SON    85/12/17    雿?雓?鞎?
* HT_SSYS LENGTH 100 BYTES  86/02/13    瑼ａ?瑼Ｘ蝟餌絞?萄潭?
*************
 FD HTSYS-SON IS EXTERNAL.
 01 HTSYS-SON-REC.
*$XFD USE GROUP, VAR-LENGTH
   02 HTSYS-KEY.
      03 HTSYS-FIL-SW                   PIC X(1).
**       銝餅?霅蝣?
      03 HTSYS-KEY-SW                   PIC X(1).
**       ?萄潸??亦Ⅳ
      03 HTSYS-KEY-DATA                 PIC X(98).
**       ?萄澆摰?
*COPY    "HT_DPT.MST".
* ==SCL== 2004.03.09 START ----- ?勗?摮?憭批?閮剖? ---------------------------- *

* ==SCL== 2004.03.08 START ----- ?勗??CTRL + Y ?閮箝??Ｗ??啣撐?貉身摰?----- *
* >

* ==SCL== 2004.01.13 START ----- ?勗???椰?征?賣??---------------------- *
* ==SCL== 2002.11.09 START ----- ?思誘?桀?閮餅?行憭?-------------------------- *
* ?曉?芷??曄敦??閮?閮剖?
* 蝔?撌脣????芷??閮剖?撠勗隞仿?敦??閮?I),憿?酉(C),?抵??曉之(A)
* ==SCL== 2002.10.30 START ----- PACS?游?嚗隞文?訐ACS撌乩?摨? -------------- *
* ==SCL== 2002.07.28 START ----- ?????憭拇閮剖?  ----------------------- *
*************
* C-PY FILE : HT_DPT.MST    84/03/23    雿?雓?鞎?
* HT_MDPT LENGTH 100 BYTES  90/01/05    瑼ａ?瑼Ｘ蝘恕摰儔瑼?
*************
 FD HTDPT-MST IS EXTERNAL.
 01 HTDPT-REC.
   02 HTDPT-KEY.
      03 HTDPT-DPT-CD                   PIC X(1).
**       瑼ａ?瑼Ｘ蝘恕蝪∠Ⅳ
   02 HTDPT-DATA.
      03 HTDPT-DPT-NO                   PIC X(5).
**       瑼ａ?瑼Ｘ蝘恕隞??               -- ALT-KEY
*$XFD USE GROUP, VAR-LENGTH
      03 HTDPT-DATA-1.
         04 HTDPT-DPT-NN                PIC X(8).
**          瑼ａ?瑼Ｘ蝘恕蝪∠迂                            HTDPT-DATA-1  1:8
**       04 HTDPT-RPT-LN                PIC 9(2).
**          ?思誘?格?????                             HTDPT-DATA-1  9:2
         04 HTDPT-PRT-ODR-1             PIC X(1).
**          ?思誘?桐??啗?蝵桐誨蝣?                         HTDPT-DATA-1  9:1
         04 HTDPT-PRT-ODR-2             PIC X(1).
**          瑼ａ?瑼Ｘ蝟餌絞??思誘?桃??瑕漲瘥?勗??桅摨? HTDPT-DATA-1 10:1
         04 HTDPT-SPN-CD                PIC X(1).
**          瑼ａ?蝺刻?蝺函Ⅳ閬?            -- 860526       HTDPT-DATA-1 11:1
         04 HTDPT-CPM-SW                PIC X(1).
**          ?其??寥?雿平蝣?             -- 860304       HTDPT-DATA-1 12:1
         04 HTDPT-EMG-SW                PIC X(1).
**          ?亥那瑼ａ?摰文??函Ⅳ            -- 860701       HTDPT-DATA-1 13:1
         04 HTDPT-DATA-CLS.
**          憿閮剖?鞈?
            05 HTDPT-OK-RP              PIC X(1).

**             撖拇??蝣?                              HTDPT-DATA-1 14:1
            05 HTDPT-TY-SW1             PIC X(1).
**             瑼ａ?瑼Ｘ蝣?                              HTDPT-DATA-1 15:1
            05 HTDPT-TY-SW2             PIC X(1).
**             蝯??勗?蝣?                              HTDPT-DATA-1 16:1
            05 HTDPT-FE-OP              PIC X(1).
**             ?炎敺蝣?                              HTDPT-DATA-1 17:1
            05 HTDPT-ML-OP              PIC X(1).
**             ??雿平蝣?                              HTDPT-DATA-1 18:1
            05 HTDPT-ML-SP              PIC X(1).
**             ??蝭?蝣?                              HTDPT-DATA-1 19:1
            05 HTDPT-IP-SP              PIC X(1).
**             ?思誘?瑼ａ?摰孵蝣?                      HTDPT-DATA-1 20:1
            05 HTDPT-IP-TR              PIC X(1).
**             ?思誘銝?啣??挾蝣?                      HTDPT-DATA-1 21:1
            05 HTDPT-IP-PST             PIC X(1).
**             ?曄?嚗詨?瑼Ｘ?文?蝣?                      HTDPT-DATA-1 22:1
            05 HTDPT-IP-RP              PIC X(1).
**             ?思誘?勗?蝣?                              HTDPT-DATA-1 23:1
            05 HTDPT-RP-CS              PIC X(1).
**             ?勗?憿蝣?                              HTDPT-DATA-1 24:1
            05 HTDPT-PRS-CS             PIC X(1).
**             ?蔭憿蝣?              -- PRS-FEE-KND  HTDPT-DATA-1 25:1
            05 HTDPT-SPN-SW             PIC X(1).
**             瑼ａ?蝘?璅?炎擃楊??璆剔Ⅳ -- 860312       HTDPT-DATA-1 26:1
            05 HTDPT-SPN-SW1            PIC X(1).
**             霅瑞?蝡?璅?炎擃楊??璆剔Ⅳ -- 860503       HTDPT-DATA-1 27:1
            05 HTDPT-SPN-SW2            PIC X(1).
**             摰園蝘?璅?炎擃楊??璆剔Ⅳ -- 860526       HTDPT-DATA-1 28:1
            05 HTDPT-PST-TY             PIC X(1).
**             嚗詨???蝐斗撘Ⅳ  ?     -- 860507       HTDPT-DATA-1 29:1
            05 HTDPT-LNK-SW             PIC X(1).
**             ?蜓璈?璆剔Ⅳ                             HTDPT-DATA-1 30:1 --> LIS OR RIS OR PACS 蝟餌絞?游?蝣?(901205)
            05 HTDPT-ML-SW              PIC X(1).
**             ???孵?蝣?              -- 870124       HTDPT-DATA-1 31:1
            05 HTDPT-IP-EMG             PIC X(1).
**             ?乩辣?蝣?              -- 890502       HTDPT-DATA-1 32:1
            05 HTDPT-PNO-RPT-SW         PIC X(1).
**             ???勗??亥岷霅蝣?      -- 910324       HTDPT-DATA-1 33:1
            05 HTDPT-RPTD-NO-GRP        PIC X(1).
**             瑼ａ??餉?蝪? 蝯???? -- 910411       HTDPT-DATA-1 34:1

* ==SCL== 2002.07.28 START ----- ?????憭拇閮剖?  ----------------------- *
            05 HTDPT-LND-DATE-CNT       PIC X(01).
*              ???憭拇(隞亙?交? ??HTDPT-LND-DATE-CNT ????甇賊??交?)
*                                                       HTDPT-DATA-1 35:1
* ==SCL== 2002.07.28 END   ----- ?????憭拇閮剖?  ----------------------- *
* ==SCL== 2002.10.30 START ----- PACS?游?嚗隞文?訐ACS撌乩?摨? -------------- *
            05 HTDPT-BAR-IP-PACS        PIC X(1).
**             ?思誘?桀PACS撌乩?摨?璇Ⅳ -- 911030       HTDPT-DATA-1 36:1
* ==SCL== 2002.10.30 END   ----- PACS?游?嚗隞文?訐ACS撌乩?摨? -------------- *
* ==SCL== 2002.11.09 START ----- ?思誘?桀?閮餅?行憭?-------------------------- *
            05 HTDPT-IP-RK-FONT         PIC X(1).
*              ?思誘?酉摮??曉之(~W2)                    HTDPT-DATA-1 37:1
* ==SCL== 2002.11.09 END   ----- ?思誘?桀?閮餅?行憭?-------------------------- *

            05 HTDPT-PAGE-RPT           PIC X(1).

*              ??券???勗??亥岷??⊥?撘?          HTDPT-DATA-1 38:1
* ==SCL== 2004.01.13 START ----- ?勗???椰?征?賣??---------------------- *
            05 HTDPT-RPT-SPACE          PIC 9(2).
**             ?勗???椰?征?賣??                  HTDPT-DATA-1 39:2
* ==SCL== 2004.01.13 END   ----- ?勗???椰?征?賣??---------------------- *

* ==SCL== 2004.03.08 START ----- ?勗??CTRL + Y ?閮箝??Ｗ??啣撐?貉身摰?----- *
            05 HTDPT-RPT-ODR            PIC 9(1).
**             ?勗???TRL + Y ?閮箏??啣撐?貉身摰?     HTDPT-DATA-1 41:1
            05 HTDPT-RPT-ICB            PIC 9(1).
**             ?勗???TRL + Y 雿?撘菜閮剖?      HTDPT-DATA-1 42:1
* ==SCL== 2004.03.08 END   ----- ?勗??CTRL + Y ?閮箝??Ｗ??啣撐?貉身摰?----- *
* ==SCL== 2004.03.09 START ----- ?勗?摮?憭批?閮剖? ---------------------------- *
            05 HTDPT-RPT-FONT           PIC 9(2).
*              ?勗?摮?憭批?閮剖?
* ==SCL== 2004.03.09 END   ----- ?勗?摮?憭批?閮剖? ---------------------------- *

            05 HTDPT-CLS-FILLER         PIC X(12).
**             蝛箇??                                  HTDPT-DATA-1 43:14

         04 HTDPT-PRT-ODR-3             PIC X(1).
**          ?思誘?桀銵冽?                                HTDPT-DATA-1 57:1
         04 HTDPT-RPT-LN1               PIC X(1).
**          ?勗??格????貊Ⅳ            -- 900320       HTDPT-DATA-1 58:1
         04 HTDPT-AC-SW                 PIC X(1).
**          ?芸?蝪賣雿平蝣?             -- 860805       HTDPT-DATA-1 59:1
         04 HTDPT-REJ-SW                PIC X(1).
**          瑼ａ?????Ⅳ              -- 860901       HTDPT-DATA-1 60:1
         04 HTDPT-AS-SW                 PIC X(1).
**          雿瑼ａ??芸??見?內蝣?     -- 861013       HTDPT-DATA-1 61:1
         04 HTDPT-IO-SPT                PIC X(1).
**          憭敦?????啁Ⅳ          -- 861106       HTDPT-DATA-1 62:1
         04 HTDPT-IS-SW                 PIC X(1).
**          ??亥那瑼ａ?????楊?Ⅳ  -- 870202       HTDPT-DATA-1 63:1
         04 HTDPT-NO-ONE                PIC X(1).
**          ?∪蝑頛訾?璆剔Ⅳ            -- 870410       HTDPT-DATA-1 64:1
         04 HTDPT-BAT-SEC               PIC 9(2).
**          ?寞活?唾撓?怠?蝘            -- 870525       HTDPT-DATA-1 65:2
         04 HTDPT-RPT-SW                PIC X(1).
**          ?勗??駁?璅∪?                -- 870525       HTDPT-DATA-1 67:1
         04 HTDPT-LCHK-MO               PIC 9(1).
**          ?思誘靽??                -- 870604       HTDPT-DATA-1 68:1
         04 HTDPT-LRST-MO               PIC 9(1).
**          ?勗?靽??                -- 870604       HTDPT-DATA-1 69:1
         04 HTDPT-IDZ-SW                PIC X(1).
**          ?臬??風??蝣?         -- 870604       HTDPT-DATA-1 70:1
         04 HTDPT-ODC-SW                PIC X(1).
**          ?Ｙ??閮箄?蝵格炎?貊Ⅳ          -- 871119       HTDPT-DATA-1 71:1
         04 HTDPT-WRK-SW                PIC X(1).
**          瑼ａ?撌乩?摨?蝣?             -- 871119       HTDPT-DATA-1 72:1
         04 HTDPT-WRK-ST                PIC X(1).
**          撌乩?摨?憿舐內蝣?             -- 871119       HTDPT-DATA-1 73:1
         04 HTDPT-PHR-NEXT              PIC X(1).
**          ????蝣?                                 HTDPT-DATA-1 74:1
         04 HTDPT-OPPR-SW               PIC X(1).
**          ?思誘????血??啁?甇瑟?閬?                 HTDPT-DATA-1 75:1
         04 HTDPT-ACMN-SW               PIC X(1).

**          雿平鈭箏?芾?蝪賣蝣?         -- 880514       HTDPT-DATA-1 76:1
**       04 HTDPT-SEE-CTM               PIC X(1).
**          蝪賣銝?蝘餃??舐?蝝圈?        -- 880624       HTDPT-DATA-1
         04 HTDPT-ODR-IPD               PIC X(1).
**          雿?思誘??思誘?桃Ⅳ        -- 900209       HTDPT-DATA-1 77:1
         04 HTDPT-BAR-TY                PIC X(1).
**          BARCODE TYPE                --880707/900209 HTDPT-DATA-1 78:1
         04 HTDPT-RPST-AM               PIC X(1).
**          蝝圈??勗??文?雿平蝣?         -- 880806       HTDPT-DATA-1 79:1
         04 HTDPT-DNG-SW                PIC X(1).
**          ?梢?澆?蝣?           -- 890817       HTDPT-DATA-1 80:1
**       04 HTDPT-MRG-SW                PIC X(1).
**          瑼ａ??曉?蝟餌絞?蔥            -- 890825       HTDPT-DATA-1
         04 HTDPT-ODR-BAR               PIC X(1).
**          ?思誘?株?璅惜?郊?蝣?     -- 900209       HTDPT-DATA-1 81:1
         04 HTDPT-BAR-IP                PIC X(1).
**          ?思誘?桀??唳?蝣?             -- 900105       HTDPT-DATA-1 82:1
         04 HTDPT-PPF-SET                PIC X(1).
**          PPF鈭箏閮剖??潔?蝵?( /L)                     HTDPT-DATA-1 83:1
         04 HTDPT-OLD-RPT               PIC X(1).
**          雿輻???曉?蝺???     -- 900410       HTDPT-DATA-1 84:1
         04 HTDPT-SHOW-ONE              PIC X(1).
**          ?思誘?桃敦??箔???銵＊蝷? -- 900413       HTDPT-DATA-1 85:1
         04 HTDPT-ODR-TYP               PIC X(1).
**          ?唾??格撘?                 -- 900728       HTDPT-DATA-1 86:1
         04 HTDPT-RPT-BLO-MARK          PIC X(1).
**          銵?葫摰?葆?酉          -- 900728       HTDPT-DATA-1 87:1
         04 HTDPT-ODR-BLO-CHK           PIC X(1).
**          銵?葫摰?銴?蝡?撣嗉郎????-- 900728       HTDPT-DATA-1 88:1
         04 HTDPT-MUT-STA               PIC X(1).
**          ??摰支辣?詨?雿萇絞閮?         -- 900728       HTDPT-DATA-1 89:1
         04 HTDPT-PNO-HSP-CD            PIC X(2).
**          ??蝺刻??恍霅蝣?         -- 900817       HTDPT-DATA-1 90:2
         04 HTDPT-RPTD-IPDPT-YN         PIC X(1).
**          瑼ａ??餉?蝪?撅祇?閮粹隞??蝘 -- 900817    HTDPT-DATA-1 92:1
         04 HTDPT-REWRITE-ICB           PIC X(1).
**          雿??瑼ａ?瑼Ｘ?蝪賣??閮 -- 901010  HTDPT-DATA-1 93:1

** HTDPT-ALT-KEY = HTDPT-DPT-NO

** HTDPT-DPT-CD  : 銝??'I' & 'O'
** HTDPT-DPT-NO  : 敹?撌脣??冽 ?桐?銝餅?
** HTDPT-TY-SW1  : A> 瑼ａ???   B> 瑼Ｘ??
** HTDPT-TY-SW2  : A> 蝯???   B> ?勗???
** HTDPT-RPT-SW  : A> 靘隞斗?? ?嗅?> 靘?甇瑁?蝣?
** HTDPT-NO-ONE  : Y> ?∪蝑頛訾?璆?
** HTDPT-IP-SP   : Y> ?思誘?????賢??訾?蝔格炎擃捆??
**                 M> 憭車瑼ａ?摰孵, N> ?⊥炎擃捆??
** HTDPT-IP-TR   : A> ?思誘撌脤?蝡? B> 瑼ａ?撌脫?蝷箄? C> 瑼ａ?撌脣?璅??
**                 D> 瑼ａ?撌脤炎?? E> ?思誘撌脩偷?嗉? F> ?思誘撌脫?蝔?
**                 G> ?思誘撌脣??? H> ?思誘撌脫炎?亥? I> ?思誘撌脰???
**                 J> 蝯?撌脣?? K> ?勗?撌脣祟?貉?
** HTDPT-PRS-CS  : C> 瑼ａ?, D> 瑼Ｘ, E> 嚗詨?
** HTDPT-RPT-LN1 : 1> ?券?, 2> 1/2 ?? 3> 2/3 ?? 4> 1/3 ??
** HTDPT-SPN-CD  :  > HTSPN-SPN-NO1, 0> HTSPN-SPN-NO1,
**                 1> HTSPN-SPN-NO1, 2> HTSPN-SPN-NO2
** HTDPT-SPN-SW  : A> 瑼ａ?蝘?璅?炎擃?楊???璅惜,

**                 B> 瑼ａ?蝘?璅?炎擃犖撌亦策???璅惜,
**                 C> 瑼ａ?蝘?璅?炎擃?鈭楊???璅惜
**                 Y> 瑼ａ?蝘?璅?炎擃?楊??銝??唳?蝐?
**                 M> 瑼ａ?蝘?璅?炎擃犖撌亦策??銝??唳?蝐?
**                 N> 瑼ａ?蝘?璅?炎擃?鈭楊??銝??唳?蝐?
** HTDPT-SPN-SW1 : A> 霅瑞?蝡?璅?炎擃?楊???璅惜,
**                 B> 霅瑞?蝡?璅?炎擃犖撌亦策???璅惜,
**                 C> 霅瑞?蝡?璅?炎擃?鈭楊???璅惜
**                 Y> 霅瑞?蝡?璅?炎擃?楊??銝??唳?蝐?
**                 M> 霅瑞?蝡?璅?炎擃犖撌亦策??銝??唳?蝐?
**                 N> 霅瑞?蝡?璅?炎擃?鈭楊??銝??唳?蝐?
** HTDPT-SPN-SW2 : A> 摰園蝘?璅?炎擃?楊???璅惜,
**                 B> 摰園蝘?璅?炎擃犖撌亦策???璅惜,
**                 C> 摰園蝘?璅?炎擃?鈭楊???璅惜
**                 Y> 摰園蝘?璅?炎擃?楊??銝??唳?蝐?
**                 M> 摰園蝘?璅?炎擃犖撌亦策??銝??唳?蝐?
**                 N> 摰園蝘?璅?炎擃?鈭楊??銝??唳?蝐?
**                 IF HTDPT-IP-SP NOT = 'N'
**                      ACCEPT HTDPT-SPN-SW & HTDPT-SPN-SW1 & HTDPT-SPN-SW2.
** HTDPT-IS-SW   : Y> ??亥那瑼ａ?????楊??
**                    HTDPT-LNK-SW MUST = 'Y' & HTDPT-SPN-SW  MUST = 'A' OR 'Y'
** HTDPT-AS-SW   : Y> 雿瑼ａ??芸??見?內,
**                    HTDPT-LNK-SW MUST = 'Y' & HTDPT-SPN-SW1 MUST = 'A' OR 'Y'
** HTDPT-AC-SW   : A> ?券?芸?蝪賣,          B> ?支??Ｗ??券?芸?蝪賣,
**                 C> ?文?瑼Ｗ??券?芸?蝪賣,  D> ??偷?園??亥那?思誘??
** HTDPT-ML-OP   : A> 憿??, B> 蝝圈???
** HTDPT-RP-CS   : A> 蝝圈??勗?, B> 蝬??勗?, C> 蝝圈??勗? & 蝬??勗?
** HTDPT-ML-SP   : A> 憿蝭?, B> ?其?蝭?, C> 蝝圈蝭?, D> 蝝圈?蝭?
** HTDPT-IP-RP   : A> 瑼ａ?瑼Ｘ, B> ?其?瑼Ｘ, C> 蝝啗?瑼ａ?, D> 銵摨急炎撽?
**                 IF HTDPT-IP-RP = "B"    HTDPT-ML-SP = "A", "B", "C", "D" ELSE
**                                         HTDPT-ML-SP = "A", "D".
**                 IF HTDPT-IP-RP = "B"    ACCEPT HTDPT-PST-TY & HTDPT-CPM-SW &
**                                                HTDPT-IP-PST              ELSE
**                                         ACCEPT HTDPT-EMG-SW & HTDPT-LNK-SW &
**                                                HTDPT-SPN-CD
** HTDPT-ML-SW   : A> 鈭箏極???? B> ?芸????? C> ?寞活????
** HTDPT-REJ-SW  : Y> 瑼ａ??????閮颱?璆?-- CANCEL
**                 A> 瑼ａ?蝘??圈???? B> 霅瑞?蝡??圈???? C> ?炎?桐?????-- 90/09/27
** HTDPT-EMG-SW  : Y> ?亥那瑼ａ?摰?蝵脩??脫??恍), M> ??亥那瑼ａ?摰?蝵脩??啁姘?恍--90/5/2)
** HTDPT-LNK-SW  : Y> ?炎撽??券??銝餅?, ACCEPT HTDPT-LCHK-MO & HTDPT-LRST-MO
** HTDPT-LNK-SW  : Y> 憭批??IS, M> ?◣?IS, E> 摰?ACS
**                 EVALUATE HTDPT-DPT-CD
**                     WHEN 'T'
**                          MOVE ' ' OR 'Y' OR 'M' TO HTDPT-LNK-SW
**                     WHEN OTHER
**                          MOVE ' ' OR 'P' TO HTDPT-LNK-SW
**                 END-EVALUATE

** PACS........
** HTDPT-LNK-SW  : A> ?曉??潛? ?啣??曉?蝺蝙?? 嚗?A ??S ???踝????Ｗ????
**                 S> ????
**                 s> ?啗
**                 s> 撖ㄚ??->摰?  2004.03.20

** HTDPT-CPM-SW  : Y> 鋆?思誘??具雿?蝝圈-敺桅??畾菟?格撘?
** HTDPT-IP-PST  : Y> ???思誘??頛詨??行蝬?嚗詨?瑼Ｘ銋摰Ⅳ??
** HTDPT-OK-RP   : Y> 銵刻府蝘恕銋炎撽炎?亙??蝬祟?賊??孵??亥岷?啗”

** HTDPT-FE-OP   : Y> ???亥那?迂?炎敺, A> ?券?迂?炎敺
**                    CHECK 頨思遢??-- HT_SYS01.SON
** HTDPT-IO-SPT  : Y> 銝撘菜炎撽????株???????????唬?撘? N> ?券?啣銝韏?
** HTDPT-IDZ-SW  : Y> ??勗????啁?甇瑟?閬? N OR SPACE>銝
** HTDPT-WRK-SW  : M> ?◣?砍蝺函Ⅳ閬?
** HTDPT-WRK-ST  : Y> 蝪賣敺＊蝷箏極雿???
** HTDPT-PHR-NEXT: Y> ??頛詨敺?銵?
** HTDPT-ACMN-SW : N> 蝪賣??閮剔?券;
**                 Y> 蝪賣??閮剔?其???
**                 P> ?亦偷?嗡犖?∩?撖Ⅳ閮剖???摰?璆剝??交?,
**                    ?偷?嗆??恍???箇??憿銋???身?箏??
**                 C> 蝪賣???雿平憿,
**                    ??摰??身?箏?? ?⊥?摰??身?箏銝
** HTDPT-SEE-CTM : Y> 蝪賣銝?蝑宏?? ?喳?敦??
** HTDPT-BAR-TY  : SPACE/0 > ?曉?蝺帖摮? 1> ?曉?蝺?摮? 璇Ⅳ頛之                --?曉?蝺?具?蝣潦??唳?雿輻
**                 2>       > 璇Ⅳ頛?嚗WIN-PRINT?啣嚗??思誘?格?蝣潛??     --?曉?蝺?具?蝣潦??唳?雿輻
**                 G> ->?粹? 200璇Ⅳ璈?            ?風??
**                 H>                              頨思遢霅???
**                 I> ->敹???梯 CX208璇Ⅳ璈?   ?風??
**                 J>                              頨思遢霅???
**                 F> 憍血匱?恍瑼ａ?璅惜
**
**
** HTDPT-RPST-AM : A> 蝝圈??勗????芸??文?, P> 蝝圈??勗?銝??文?,
**                 M> 蝝圈??勗???鈭箏極?文?, ?園?> 蝝圈??勗??券鈭箏極?文?
** HTDPT-IP-EMG  : Y> ?乩辣?
** HTDPT-DNG-SW  : Y> ?梢?澆?, create ht_mdng
** HTDPT-MRG-SW  : Y> 瑼ａ??曉?蝟餌絞?蔥
** HTDPT-BAR-IP  : Y> ?思誘?桀??唳?蝣?
** HTDPT-ODR-IPD : E> 雿?思誘銝??唳乩辣?思誘?? N> 雿?思誘銝??唳隞園隞文, A> 雿?思誘銝??圈隞文
** HTDPT-ODR-BAR : 1> 雿?思誘?株?璅惜?郊?, 2> ?閮粹隞文??蝐文?甇亙??? 3> ?亥那?思誘?株?璅惜?郊?,
**                 4> 雿嚗?閮? 5> 雿嚗亥那, 6> ?閮綽??亥那, 7> 雿嚗?閮綽??亥那
** HTDPT-PPF-SET :' '> IF HTCLS-CKM-SW = P ?蝙??HTCLS-PPF-DATA ?蝪賣摮???PPF鈭箏閮剖??潔?蝵?
** PPF鈭箏閮剖??潔?蝵?: L > ??PPF鈭箏閮剖??潔?蝵??曉 LOCAL 蝡荔?C:\HMISA\ZTN.DIR\HT_PPF4嚗?
**                     HTSI31IF, ?????唳?嚗????瑼?
**                     HT_PPF4嚗??瑼?嚗誑HTCLS-PPF-DATA ?撣嗅銋?閮剖潘???靽格
**                     蝪賣摮???隞他OCAL 蝡舐??猥_PPF4]摰銝鳴?(?舫???唬蜓璈耨?寞???鞈?銝迤蝣綽?)
**HTDPT-IP-RK-FONT: I>蝝圈??酉嚗??撖祉?拙??~W2)
**                  C>憿?酉嚗?
**                  A>?抵??曉之
**HTDPT-LND-DATE-CNT:   銝0 ??SPACE ???臭誑????雿平銝?F3>?渲???嚗?

**HTDPT-RPT-FONT:       ?勗?摮?憭批?閮剖?
*                       銝身嚗? ?身??4摮?
*
*                       摮???X0 ??           80摮摨?       18.0CM          1/3     1/2     2/3     ?典撐
*                       24    ->?摭24摮?嚗?    14.0CM          80摮?          22      33      47      66
*                       26    ->?摭26摮?嚗?    15.2CM          80摮?          20      30      40      60
*                       28    ->?摭28摮?嚗?    16.5CM          80摮?          19      28      37      56
*                       30    ->?摭30摮?嚗?    17.5CM          80摮?          18      26      35      53
*                       32    ->?摭32摮?嚗?    18.5CM          78摮?          16      24      32      48
*                       34    ->?摭34摮?嚗?    20.0CM          73摮?          16      23      31      47
*                       36    ->?摭36摮?嚗?    21.0CM          69摮?          15      22      29      44

*COPY    "HT_CHK.MST".
*************
* C-PY FILE : HT_CHK.MST   84/03/29     雿?雓?鞎?

* HT_MCHK LENGTH 400 BYTES 86/02/04     ?思誘?桐蜓瑼?
*************
 FD HTCHK-MST IS EXTERNAL.
 01 HTCHK-REC.
   02 HTCHK-KEY.
      03 HTCHK-CHK-NO.
**       ?思誘?株?
         04 HTCHK-CLS-NO.
**          瑼ａ?瑼Ｘ憿隞??            -- ALT-KEY6
            05 HTCHK-DPT-CD             PIC X(1).
**             瑼ａ?瑼Ｘ蝘恕蝪∠Ⅳ         -- ALT-KEYE
            05 HTCHK-CLS-CD             PIC X(2).
**             瑼ａ?瑼Ｘ憿蝣?          -- ALT-KEYL
         04 HTCHK-PR-SEQ                PIC 9(5).
**          ?瘚偌蝣?                 -- ALT-KEYA
      03 HTCHK-IP-DATE                  PIC 9(7).
**       ?思誘?交?
   02 HTCHK-DATA.
**    ?格?鞈?
      03 HTCHK-DATA-FOR.
**       ?垢鞈?
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-P-KEY.
            05 HTCHK-IP-DATE1           PIC 9(7).
**             ?思誘?交?                 -- ALT-KEY6
            05 HTCHK-CHK-NO1            PIC X(8).
**             ?思誘?株?                 -- ALT-KEY6
         04 HTCHK-IP-CLSW               PIC X(1).
**          ?思誘靘?蝣?
         04 HTCHK-IP-HC.
**          ?交炎鞈?
            05 HTCHK-IP-HCID            PIC X(9).
**             ?交炎蝔桅?隞?Ⅳ
            05 HTCHK-IP-GPID            PIC X(8).
**             ?交炎??隞??             -- ALT-KEYL
            05 HTCHK-IP-GPSW            PIC X(1).
**             ?交炎蝣?                  -- ALT-KEYE
         04 HTCHK-DATA-PT.
**          ?鞈?
            05 HTCHK-PT-NO              PIC 9(8).
**             ?風?Ⅳ                 -- ALT-KEYE
*$XFD USE GROUP, VAR-LENGTH
            05 HTCHK-PT-DATA.
               06 HTCHK-PT-ID           PIC X(10).
**                頨思遢摮?
               06 HTCHK-PT-IDSW         PIC X(1).
**                頨思遢?啣?蝣?
               06 HTCHK-PT-NAME         PIC X(12).
**                憪?
               06 HTCHK-PT-DATE         PIC S9(7).
**                ?箇???
               06 HTCHK-PT-SEX          PIC X(1).
**                ?批
               06 HTCHK-PT-IDNT         PIC X(4).
**                頨思遢??
         04 HTCHK-DATA-IP.
**          ?思誘鞈?

*$XFD USE GROUP, VAR-LENGTH
            05 HTCHK-IP-NO              PIC X(22).
**             ?思誘摨?                 -- ALT-KEYM
            05 HTCHK-IP-NO1 REDEFINES HTCHK-IP-NO.
**             ?閮粹隞文???
               06 HTCHK-RO-NO           PIC 9(11).
**                ?閮箏???
               06 HTCHK-OR-NO           PIC 9(2).
**                ?摨?
               06 HTCHK-RO-FL           PIC X(9).
**                蝛箇??
            05 HTCHK-IP-NO2 REDEFINES HTCHK-IP-NO.
**             雿?思誘摨?
               06 HTCHK-PD-NO           PIC 9(11).
**                雿摨?
               06 HTCHK-OD-NO           PIC 9(11).
**                ?摨?
*$XFD USE GROUP, VAR-LENGTH
            05 HTCHK-IP-DATA.
               06 HTCHK-CR-TIME         PIC 9(6).
**                ?思誘?駁???
               06 HTCHK-CR-MAN          PIC X(5).
**                ?思誘?駁?鈭箏
               06 HTCHK-IP-TIME         PIC 9(6).
**                ?思誘??
               06 HTCHK-IP-MAN          PIC X(4).
**                ?思誘?怠葦
               06 HTCHK-IP-WAY          PIC X(1).
**                撠梯那?孵?
               06 HTCHK-IP-DPT          PIC X(4).
**                蝘
               06 HTCHK-IP-DZS1         PIC X(7).
**                閮箸嚗?
               06 HTCHK-IP-DZS2         PIC X(7).
**                閮箸嚗?
               06 HTCHK-IP-DZS3         PIC X(7).
**                閮箸嚗?
               06 HTCHK-IP-DZS4         PIC X(7).
**                閮箸嚗?
               06 HTCHK-IP-EMG          PIC X(1).
**                ?乩辣蝣?
               06 HTCHK-IP-PAST         PIC X(1).
**                銝僑?扳蝬炎?亦Ⅳ
               06 HTCHK-IP-SPL          PIC X(1).
**                瑼ａ?摰孵蝣?
               06 HTCHK-PER-ST          PIC X(1).
**                ?瑞??瘜?
               06 HTCHK-PRE-NO          PIC 9(2).
**                ?瑕??望
               06 HTCHK-DRG-NO.
                  07 HTCHK-DRG-NO1      PIC X(5).
**                   ??蝝誨??
                  07 HTCHK-DRG-NO2      PIC X(5).
**                   ??蝝誨??
                  07 HTCHK-DRG-NO3      PIC X(5).
**                   ??蝝誨??
               06 HTCHK-TP-DATE         PIC 9(7).

**                ??瑼ａ??交?
               06 HTCHK-AP-DATE         PIC 9(7).
**                ???炎?交?
               06 HTCHK-IP-RKNO         PIC X(10).
**                憿?思誘?酉蝺刻?
      03 HTCHK-DATA-BACK.
**       敺垢鞈?
         04 HTCHK-WK-SW                 PIC X(1).
**          雿平瘚?蝣?                 -- ALT-KEYA
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-DATA-AC.
**          蝪賣鞈?
            05 HTCHK-AC-MAN             PIC X(5).
**             蝪賣鈭箏
            05 HTCHK-AC-DATE            PIC 9(7).
**             蝪賣?交?
            05 HTCHK-AC-TIME            PIC 9(6).
**             蝪賣??
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-DATA-SC.
**          ??鞈?
            05 HTCHK-SC-ITM             PIC X(1).
**             蝝圈????挾蝣?
            05 HTCHK-SC-DATE            PIC 9(7).
**             ?敺?蝔??
            05 HTCHK-SC-MAN             PIC X(5).
**             ?敺?蝔犖??
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-DATA-IO.
**          憭???
            05 HTCHK-IO-ITM             PIC X(1).
**             蝝圈?憭?畾萇Ⅳ
            05 HTCHK-IO-DATE            PIC 9(7).
**             ?敺????
            05 HTCHK-IO-MAN             PIC X(5).
**             ?敺??犖??
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-DATA-CK.
**          瑼Ｘ鞈?
            05 HTCHK-CK-ITM             PIC X(1).
**             蝝圈?瑼Ｘ?挾蝣?
            05 HTCHK-ML-ITM             PIC X(1).
**             蝝圈???蝣?
            05 HTCHK-CK-DATE            PIC 9(7).
**             ?敺炎?交??
            05 HTCHK-CK-TIME            PIC 9(6).
**             ?敺炎?交???
            05 HTCHK-CK-MAN             PIC X(5).
**             ?敺炎?乩犖??
            05 HTCHK-US-DPT             PIC X(5).
**             ?銝剖?隞?? -   - HTCLS-US-DPT
         04 HTCHK-DATA-RP.
**          蝬??勗?鞈?
            05 HTCHK-RP-SV              PIC X(1).
**             ?飛蝭?蝣?
            05 HTCHK-RP-ST              PIC X(1).
**             ?勗???Ⅳ               -- ALT-KEY6

            05 HTCHK-RP-DATE            PIC 9(7).
**             ?勗??交?                 -- ALT-KEY6
*$XFD USE GROUP, VAR-LENGTH
            05 HTCHK-RP-DATA.
               06 HTCHK-RP-TIME         PIC 9(6).
**                ?勗???
               06 HTCHK-RP-F-MAN        PIC X(5).
**                ???犖??
               06 HTCHK-RP-L-MAN        PIC X(5).
**                ?蝯?犖??
               06 HTCHK-RP-NO           PIC X(10).
**                蝬??勗??辣蝺刻?
               06 HTCHK-CS-DPT          PIC X(5).
**                ?銝剖?隞?? -- HTCLS-CS-DPT
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-DATA-OK.
**          蝬?撖拇鞈?
            05 HTCHK-OK-ST              PIC X(1).
**             撖拇??Ⅳ
            05 HTCHK-OK-DATE            PIC 9(7).
**             撖拇?交?
            05 HTCHK-OK-TIME            PIC 9(6).
**             撖拇??
            05 HTCHK-OK-MAN             PIC X(5).
**             撖拇鈭箏
            05 HTCHK-OK-RKNO            PIC X(10).
**             憿撖拇?酉蝺刻?
*$XFD USE GROUP, VAR-LENGTH
         04 HTCHK-DATA-OTH.
**          ?嗅?鞈?
            05 HTCHK-FILLER             PIC X(48).
**             蝛箇??

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
** HTCHK-IP-MAN  : READ ?怠葦隞?Ⅳ銝餅? HG_NID.MST (NID-ID = "0503")
** HTCHK-IP-WAY  : READ 撠梯那?孵?銝餅? HG_NID.MST (NID-ID = "0505")
**                 IF HTCHK-IP-WAY = " "        銵具??Ｕ?
**                 IF HTCHK-IP-WAY = "@"        銵具犖?交炎?? -- 851107
**                 IF HTCHK-IP-WAY = "$"        銵具?擃瑼Ｕ? -- 851107
** HTCHK-IP-BED  : ?摨?, READ 雿銝餅? HI_IPD.MST -- IPD-BED
** HTCHK-IP-EMG  : Y> ?乩辣, N> ?乩辣
** HTCHK-PT-IDSW : Y> 頨思遢?啣?
** HTCHK-IP-CLSW : A> ?孵蝟餌絞, B> ?思誘蝟餌絞, C> 雿蝟餌絞,
**                 D> ?犖?交炎, E> ???交炎, F> ?思誘鋆
** IF HTCHK-IP-CLSW = "D"                    MOVE "********" TO HTCHK-IP-GPID.
** IF HTCHK-IP-CLSW = "D" OR "E"             MOVE "Y"        TO HTCHK-IP-GPSW.
** HTCHK-IP-GPID : IF HTCHK-IP-CLSW = "E"    READ ?交炎摰Ｘ銝餅? HG_VDN.MST.

** HTCHK-IP-GPSW : Y> ?交炎?思誘
** HTCHK-WK-SW   : A> ?思誘??雿平, B> 瑼ａ??內雿平, C> 瑼ａ??見雿平,
**                 D> 瑼ａ??炎雿平, E> ?思誘蝪賣雿平, F> ?思誘??雿平,
**                 G> ?思誘憭?璆? H> ?思誘瑼Ｘ雿平, I> ?思誘??雿平,
**                 J> 蝯??勗?雿平,
**                    IF HTCHK-RP-ST = "Y" MOVE "甇?虜?勗?" TO ?思誘瘚?
**                    IF HTCHK-RP-ST = "N" MOVE "?啣虜?勗?" TO ?思誘瘚?
**                 K> ?勗?撖拇雿平,
**                    IF HTCHK-OK-ST = "Y" MOVE "撖拇??" TO ?思誘瘚?
**                    IF HTCHK-OK-ST = "N" MOVE "撖拇?寥" TO ?思誘瘚?
** HTCHK-RP-SV   : Y> ?飛蝭?, CREATE HT_DZS.MST
** HTCHK-RP-ST   : Y> 甇?虜?勗?, N> ?啣虜?勗?
** HTCHK-OK-ST   : Y> ?詨?,     N> ?寥
** HTCHK-PR-SW   : Y> 撌脣??圈?摰?勗?
** HTCHK-SC-ITM  : Y> 銵刻府?思誘?桐??炎撽炎?亦敦??銝?銋?蝔??
** HTCHK-IO-ITM  : Y> 銵刻府?思誘?桐??炎撽炎?亦敦??銝?銋????
** HTCHK-CK-ITM  : Y> 銵刻府?思誘?桐??炎撽炎?亦敦??銝?銋炎?交??
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
** ?思誘鋆雿平  : ??HTCHK-PT-NO READ ?風銝餅?(HH_PAT.MST)
**                 -- ?憪?,?批,?箇???頨思遢??
**                 IF PAT-IDT-LST > PAT-IOUT-LST THEN
**                      ??HTCHK-PT-NO READ 雿銝餅?(HI_IPD.MST)
**                      -- 雿摨?,頨思遢,蝘,?思誘?怠葦,?摨?
**                 ELSE ??HTCHK-PT-NO READ ??銝餅?(HO_REG.MST)
**                      -- ?閮箏???頨思遢,蝘,?思誘?怠葦,撠梯那?孵?
** IF HTCHK-OK-ST = "N" & ?脰??格?撖拇?敦?祟??   INITIALIZE ALLHTCTM-DATA-SC.
** IF HTCHK-RP-SW NOT = " " AND
**    HTCLS-OK-RP NOT = "Y"     MOVE HTCHK-RP-L-MAN TO HTCHK-OK-MAN
**                              MOVE HTCHK-RP-DATE  TO HTCHK-OK-DATE
**                              MOVE HTCHK-RP-TIME  TO HTCHK-OK-TIME
**                              MOVE "Y"            TO HTCHK-OK-SW

** 雿平隤芣?嚗?
**              ================ ================ ======================
**               鞈???????     雿?璆???畾?     鞈???靘?皞?
**              ================ ================ ======================
**               HTCHK-IP-CLSW    ?思誘??????  ?交炎,?思誘,?孵蝟餌絞

**               HTCHK-DATA-PT    ?思誘??????  ?交炎,?思誘,?孵蝟餌絞
**               HTCHK-DATA-IP    ?思誘??????  ?交炎,?思誘,?孵蝟餌絞
**               HTCHK-AP-DATE    ?思誘??????  HTCHK-TP-DATE
**               HTCHK-AP-DATE    瑼ａ??見蝯?     霅瑞?蝡頂蝯?
**               HTCHK-DATA-AC    ?思誘蝪賣         瑼ａ?瑼Ｘ蝟餌絞
**               HTCHK-DATA-RP    蝯??勗?         瑼ａ?瑼Ｘ蝟餌絞
**               HTCHK-DATA-OK    ?勗?撖拇         瑼ａ?瑼Ｘ蝟餌絞
**               HTCHK-DATA-SC    ?思誘??         瑼ａ?瑼Ｘ蝟餌絞
**               HTCHK-DATA-IO    ?思誘憭?        瑼ａ?瑼Ｘ蝟餌絞
**               HTCHK-DATA-CK    瑼ａ?瑼Ｘ??   瑼ａ?瑼Ｘ蝟餌絞
**               HTCHK-DATA-PR    ?勗??         瑼ａ?瑼Ｘ蝟餌絞
*COPY    "HT_RPT.MST".
*************
* C-PY FILE : HT_RPT.MST   84/04/03     雿?雓?鞎?
* HT_MRPT LENGTH 791 BYTES 85/07/06     ?勗??酉?辣瑼?
*************
*
 FD  HTRPT-MST EXTERNAL .
 01 HTRPT-REC.
     02 HTRPT-KEY.
         03 HTRPT-USR-NO     PIC  X(5).
**       雿輻?誨??                    -- ALT-KEY
         03 HTRPT-RPT-TY     PIC  X(2).
**       ?辣??蝣?                    -- ALT-KEY
         03 HTRPT-RPT-NO     PIC  X(10).
**       ?勗??酉?辣蝺刻?
         03 HTRPT-RPT-CNT    PIC  9(2).
**       ?勗??酉?辣?               -- ALT-KEY
     02 HTRPT-DATA.
         03 HTRPT-RPT-NO1    PIC  X(10).
**       ?辣撠?蝺刻?                   -- ALT-KEY
         03 HTRPT-ROW        PIC  9(2).
**       ?祇?撖阡?蝺刻摩銵
         03 HTRPT-TXT.
**       ?辣?桅??批捆 (76 COL * 10 ROW)
*XFD VAR-LENGTH
             04 HTRPT-TXT1       PIC  X(228).
**          ?辣?桅??批捆 (ROW 1-3)
*XFD VAR-LENGTH
             04 HTRPT-TXT2       PIC  X(228).
**          ?辣?桅??批捆 (ROW 4-6)
*XFD VAR-LENGTH
             04 HTRPT-TXT3       PIC  X(152).
**          ?辣?桅??批捆 (ROW 7-8)
*XFD VAR-LENGTH
             04 HTRPT-TXT4       PIC  X(152).
**          ?辣?桅??批捆 (ROW 9-10)
*COPY    "HT_CLS.MST".
*************
* C-PY FILE : HT_CLS.MST   84/03/23     雿?雓?鞎?
* HT_MCLS LENGTH 200 BYTES 89/10/31     瑼ａ?瑼Ｘ憿摰儔瑼?
*************
 FD HTCLS-MST IS EXTERNAL.
 01 HTCLS-REC.
   02 HTCLS-KEY.
      03 HTCLS-CLS-NO.
**       瑼ａ?瑼Ｘ憿隞??

         04 HTCLS-DPT-CD                PIC X(1).
**          瑼ａ?瑼Ｘ蝘恕蝪∠Ⅳ
         04 HTCLS-CLS-CD                PIC X(2).
**          瑼ａ?瑼Ｘ憿蝣?
   02 HTCLS-DATA.
      03 HTCLS-SEQ-MN                   PIC 9(2).
**       ?恍?賊?摨?                   -- ALT-KEY2
*$XFD USE GROUP, VAR-LENGTH
      03 HTCLS-DATA-1.
         04 HTCLS-CLS-NM                PIC X(20).
**          瑼ａ?瑼Ｘ憿?迂
         04 HTCLS-CLS-NN                PIC X(8).
**          瑼ａ?瑼Ｘ憿蝪∠迂
         04 HTCLS-DATA-RK.
**          憿?酉蝭?鞈?
            05 HTCLS-IP-RKAT            PIC X(1).
**             憿?思誘?酉?芸?蝣?
            05 HTCLS-IP-RKNO            PIC X(10).
**             憿?思誘?酉蝭?蝺刻?
            05 HTCLS-RP-NO              PIC X(10).
**             蝬??勗??辣蝭?蝺刻?
            05 HTCLS-OK-RKAT            PIC X(1).
**             憿撖拇?酉?芸?蝣?
            05 HTCLS-OK-RKNO            PIC X(10).
**             憿撖拇?酉蝭?蝺刻?
         04 HTCLS-DATA-CLS.
**          憿閮剖?鞈?
            05 HTCLS-OK-RP              PIC X(1).
**             撖拇??蝣?
            05 HTCLS-TY-SW1             PIC X(1).
**             瑼ａ?瑼Ｘ蝣?
            05 HTCLS-TY-SW2             PIC X(1).
**             蝯??勗?蝣?
            05 HTCLS-FE-OP              PIC X(1).
**             ?炎敺蝣?
            05 HTCLS-ML-OP              PIC X(1).
**             ??雿平蝣?
            05 HTCLS-ML-SP              PIC X(1).
**             ??蝭?蝣?
            05 HTCLS-IP-SP              PIC X(1).
**             ?思誘?瑼ａ?摰孵蝣?
            05 HTCLS-IP-TR              PIC X(1).
**             ?思誘銝?啣??挾蝣?
            05 HTCLS-IP-PST             PIC X(1).
**             ?曄?嚗詨?瑼Ｘ?文?蝣?
            05 HTCLS-IP-RP              PIC X(1).
**             ?思誘?勗?蝣?
            05 HTCLS-RP-CS              PIC X(1).
**             ?勗?憿蝣?
            05 HTCLS-PRS-CS             PIC X(1).
**             ?蔭憿蝣?              -- PRS-FEE-KND
            05 HTCLS-SPN-SW             PIC X(1).
**             瑼ａ?蝘?璅?炎擃楊??璆剔Ⅳ -- 860312
            05 HTCLS-SPN-SW1            PIC X(1).
**             霅瑞?蝡?璅?炎擃楊??璆剔Ⅳ -- 860503
            05 HTCLS-SPN-SW2            PIC X(1).
**             摰園蝘?璅?炎擃楊??璆剔Ⅳ -- 860526

            05 HTCLS-PST-TY             PIC X(1).
**             嚗詨???蝐斗撘Ⅳ  ?     -- 860507
            05 HTCLS-LNK-SW             PIC X(1).
**             ?蜓璈?璆剔Ⅳ             -- 860522
            05 HTCLS-ML-SW              PIC X(1).
**             ???孵?蝣?              -- 870124
            05 HTCLS-IP-EMG             PIC X(1).
**             ?乩辣????桃Ⅳ         -- 890502
            05 HTCLS-CLS-FILLER         PIC X(2).
**             蝛箇??
         04 HTCLS-PPF-DATA.
**          嚗堆摯嚗西???                 -- 890619
            05 HTCLS-PPF-DATE           PIC 9(7).
**             嚗堆摯嚗西身摰??
            05 HTCLS-EXE-MAN1           PIC X(5).
**             撖虫?鈭箏隞??銝
            05 HTCLS-EXE-MAN2           PIC X(5).
**             撖虫?鈭箏隞??鈭?
            05 HTCLS-RPT-MAN            PIC X(5).
**             ?勗?鈭箏隞??
         04 HTCLS-DATA-ITM.
**          蝝圈?閮剖?鞈?
            05 HTCLS-SL-SW              PIC X(1).
**             ?寞?瑼Ｘ蝣?
            05 HTCLS-IO-FEE             PIC 9(6).
**             蝝圈?憭祥??
            05 HTCLS-IO-HSP             PIC X(12).
**             憭?Ｖ誨??
            05 HTCLS-IO-SW              PIC X(1).
**             ??撠情蝣?
            05 HTCLS-SC-SW              PIC X(1).
**             ???孵?蝣?
            05 HTCLS-RP-SW              PIC X(1).
**             蝝圈??勗???蝣?
            05 HTCLS-SG-SW              PIC X(1).
**             ?桐?蝝圈??勗?蝣?
            05 HTCLS-MC-SW              PIC X(1).
**             蝪賣敺?蝔Ⅳ
            05 HTCLS-CS-DPT             PIC X(5).
**             ?銝剖?隞??
            05 HTCLS-US-DPT             PIC X(5).
**             ?銝剖?隞??
            05 HTCLS-VP-DA.
**             ??鈭支辣鞈?
               06 HTCLS-VP-TU           PIC X(1).
**                ??鈭支辣???桐?蝣?
               06 HTCLS-VP-TQ           PIC 9(3).
**                ??鈭支辣???賊?
         04 HTCLS-DATA-MCW.
**          ??冽?蝔?????
            05 HTCLS-MCW-TYPE OCCURS 21 TIMES.
               06 HTCLS-MCW-TY          PIC X(1).
**                ??冽?蝔??Ⅳ
         04 HTCLS-RPT-RK                PIC X(1).
**          ?勗??憿?思誘?酉蝣?     -- 860531
         04 HTCLS-DRG-SW                PIC X(1).
**          ??蝝隞方撓?亦Ⅳ            -- 861015

         04 HTCLS-IDUP-SW               PIC X(1).
**          蝝圈????豢?蝣?
         04 HTCLS-IPR-ROW               PIC 9(2).
**          ?思誘?酉韏瑕?row雿蔭
         04 HTCLS-IPR-COL               PIC 9(2).
**          ?思誘?酉韏瑕?col雿蔭
         04 HTCLS-SC-TM                 PIC X(1).
**          ????頛詨蝣?
**       04 HTCLS-DATA-DPT.
**          ?炎?券?閮剖?鞈?            -- 871118
**          05 HTCLS-EMG-DPT            PIC X(2).
**             ?乩辣?炎?券?隞??
**          05 HTCLS-NMG-DPT            PIC X(2).
**             ?乩辣?炎?券?隞??
         04 HTCLS-LBL-QTY               PIC 9(1).
**          瑼ａ?璅惜?撘菜  ?        -- 880326
         04 HTCLS-EMG-AC                PIC X(1).
**          ?亥那?思誘??銝偷?嗥Ⅳ        -- 880705
         04 HTCLS-AC-IP                 PIC X(1).
**          ??思誘?桃Ⅳ                -- 881130
         04 HTCLS-RPT-LN1               PIC 9(2).
**          ?勗??格?????             -- 890203
         04 HTCLS-CKM-SW                PIC X(1).
**          蝪賣?撓?交炎?交?PPF鈭箏     -- 890424
         04 HTCLS-RPTD-SW               PIC X(1).
**          ?勗???勗??交?            -- 890614
         04 HTCLS-IRPT-SW               PIC X(1).
**          ???思誘?單??勗?            -- 890614
         04 HTCLS-INQ-SW                PIC X(1).
**          ?撣急?舀?勗?            -- 890808
         04 HTCLS-WAB-SW                PIC X(1).
**          瑼ａ??見?桀??唳炎撽敦??     -- 890825
         04 HTCLS-ODR-SRT               PIC X(1).
**          ?思誘?桀??圈?摨Ⅳ            -- 891031
         04 HTCLS-FILLER                PIC X(14).
**          蝛箇??

** HTCLS-ALT-KEY1 = HTCLS-CLS-CD + HTCLS-DPT-CD
** HTCLS-ALT-KEY2 = HTCLS-DPT-CD + HTCLS-SEQ-MN

** HTCLS-TY-SW1  : A> 瑼ａ???   B> 瑼Ｘ??
** HTCLS-TY-SW2  : A> 蝯???   B> ?勗???
** HTCLS-IP-PST  : Y> ???思誘??頛詨??行蝬?嚗詨?瑼Ｘ銋摰Ⅳ??
** HTCLS-IP-SP   : Y> ?思誘?????賢??訾?蝔格炎擃捆??
**                 M> 憭車瑼ａ?摰孵, N> ?⊥炎擃捆??
** HTCLS-IP-TR   : A> ?思誘撌脤?蝡? B> 瑼ａ?撌脫?蝷箄? C> 瑼ａ?撌脣?璅??
**                 D> 瑼ａ?撌脤炎?? E> ?思誘撌脩偷?嗉? F> ?思誘撌脫?蝔?
**                 G> ?思誘撌脣??? H> ?思誘撌脫炎?亥? I> ?思誘撌脰???
**                 J> 蝯?撌脣?? K> ?勗?撌脣祟?貉?
** HTCLS-PRS-CS  : C> 瑼ａ?, D> 瑼Ｘ, E> 嚗詨?
** HTCLS-LNK-SW  : Y> ?炎撽??券??銝餅?
** HTCLS-SPN-SW  : A> 瑼ａ?蝘?璅?炎擃?楊???璅惜,
**                 B> 瑼ａ?蝘?璅?炎擃犖撌亦策???璅惜,
**                 C> 瑼ａ?蝘?璅?炎擃?鈭楊???璅惜
**                 Y> 瑼ａ?蝘?璅?炎擃?楊??銝??唳?蝐?
**                 M> 瑼ａ?蝘?璅?炎擃犖撌亦策??銝??唳?蝐?
**                 N> 瑼ａ?蝘?璅?炎擃?鈭楊??銝??唳?蝐?

** HTCLS-SPN-SW1 : A> 霅瑞?蝡?璅?炎擃?楊???璅惜,
**                 B> 霅瑞?蝡?璅?炎擃犖撌亦策???璅惜,
**                 C> 霅瑞?蝡?璅?炎擃?鈭楊???璅惜
**                 Y> 霅瑞?蝡?璅?炎擃?楊??銝??唳?蝐?
**                 M> 霅瑞?蝡?璅?炎擃犖撌亦策??銝??唳?蝐?
**                 N> 霅瑞?蝡?璅?炎擃?鈭楊??銝??唳?蝐?
** HTCLS-SPN-SW2 : A> 摰園蝘?璅?炎擃?楊???璅惜,
**                 B> 摰園蝘?璅?炎擃犖撌亦策???璅惜,
**                 C> 摰園蝘?璅?炎擃?鈭楊???璅惜
**                 Y> 摰園蝘?璅?炎擃?楊??銝??唳?蝐?
**                 M> 摰園蝘?璅?炎擃犖撌亦策??銝??唳?蝐?
**                 N> 摰園蝘?璅?炎擃?鈭楊??銝??唳?蝐?
**                 IF HTCLS-IP-SP NOT = 'N'
**                      ACCEPT HTCLS-SPN-SW & HTCLS-SPN-SW1 & HTCLS-SPN-SW2.
** HTCLS-DRG-SW  : Y> 蝝啗?瑼ａ??思誘?撓?交???, HTCLS-IP-RP MUST = 'C'
** HTCLS-OK-RP   : Y> 銵刻府憿銋炎撽炎?亙??蝬祟?賊??孵??亥岷?啗”
** HTCLS-FE-OP   : Y> ???亥那?迂?炎敺, A> ?券?迂?炎敺
**                    CHECK 頨思遢??-- HT_SYS01.SON
** HTCLS-ML-OP   : A> 憿??, B> 蝝圈???
** HTCLS-IP-RP   : A> 瑼ａ?瑼Ｘ, B> ?其?瑼Ｘ, C> 蝝啗?瑼ａ?, D> 銵摨急炎撽?
**                 IF HTCLS-IP-RP = "B"        ACCEPT HTCLS-PST-TY.
** HTCLS-ML-SP   : A> 憿蝭?, B> ?其?蝭?, C> 蝝圈蝭?, D> 蝝圈?蝭?
**                 IF HTCLS-IP-RP = "B"    HTCLS-ML-SP = "A", "B", "C", "D" ELSE
**                                         HTCLS-ML-SP = "A", "D"
** HTCLS-ML-SW   : A> 鈭箏極???? B> ?芸????? C> ?寞活????
** HTCLS-RP-CS   : A> 蝝圈??勗?, B> 蝬??勗?, C> 蝝圈??勗? & 蝬??勗?
** HTCLS-RP-SW   : 1> ?詨澆?,   2> 隞?Ⅳ??   3> ????   4> ?辣??
**                 IF HTCLS-RP-CS = "B"        MOVE SPACE TO HTCLS-RP-SW
** HTCLS-IO-SW   : Y> 憭?蝔?, S> ?折???? N> ??蝔?,   A> 隞乩??
** HTCLS-SC-SW   : A> 鈭箏極???? B> ?芸????? C> ?寞活???? N> ??蝔?
**                 IF HTCLS-IO-SW = "N"        MOVE "N" TO HTCLS-SC-SW ELSE
**                 IF HTCLS-IO-SW = "Y"        MOVE "C" TO HTCLS-SC-SW ELSE
**                 IF HTCLS-IO-SW = "A" OR "S" ACCEPT HTCLS-SC-SW.
**                 IF HTCLS-SC-SW = "A" OR "B" ??亥那蝪賣雿平?ALL蝝圈???雿平.
** HTCLS-SC-TM   : Y> 頛詨???? & HTCLS-IO-SW MUST = 'S' & HTCLS-SC-SW = 'A'
** HTCLS-MC-SW   : Y> 蝪賣敺?舀?蝔? N> 銝?蝪賣?喳??, S> ??敺?舐偷??
**                 IF HTCLS-IO-SW NOT = "N"    ACCEPT HTITM-MC-SW.
** HTCLS-MCW-TY  : 0> ?甈? 1> ?閮? ?2> ?亥那, ?3> 雿,   4> ?交炎,
**               ?5> ?嗅?,   6> ?券,   A> ??閮? B> ?亥那, C> ????
**                 D> ?瑼? E> ?摰? F> ??乩?, G> ??亙, H> ?雿,
**                 I> ?乩??? J> ???   K> ?雿?   L> ???   M> ?乩?,
**                 N> ?亙,   O> 雿
**                 IF HTCLS-MC-SW = "Y" AND HTCLS-SC-SW = "A" OR "B" THEN
**                      MOVE    "0" TO HTCLS-DATA-MCW                ELSE
**                 IF HTCLS-MC-SW = "Y" AND HTCLS-SC-SW = "C"        THEN
**                      ACCEPT  HTCLS-DATA-MCW.
** HTCLS-SG-SW   : Y> ?桐?蝝圈??勗?, HTCLS-RP-SW = "2" IS REQUIRED
** HTCLS-SL-SW   : Y> ?寞?瑼Ｘ??
** HTCLS-RPT-RK  : Y> ?勗??憿?思誘?酉
** HTCLS-IP-RKAT : Y> 憿?思誘?芸??酉
** HTCLS-OK-RKAT : Y> 憿撖拇?芸??酉
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
** HTCLS-IDUP-SW : Y> ?嗆炎撽????桀?頛貊敦???2?? 閬????豢?, N>?湔?蔥
** HTCLS-EMG-AC  : Y> ?亥那?思誘??銝偷??
** HTCLS-AC-IP   : Y> 蝪賣???圈隞文, R> ?????圈隞文
** HTCLS-CKM-SW  : Y> 蝪賣?撓?交炎?乩犖?? P> 蝪賣?撓?伐摯嚗堆憐鈭箏
** HTCLS-IP-EMG  : Y> ?乩辣?, M> ?桅??
** HTCLS-RPTD-SW : N> ?勗?銝??啣???
** HTCLS-IRPT-SW : Y> ???思誘?單??勗?
** HTCLS-INQ-SW  : Y> ?撣急?舀?勗?(?勗??亥岷甈?蝞∪)
** HTCLS-WAB-SW  : Y> 瑼ａ??見?桀??唳炎撽敦??
*COPY    "HT_CTM.MST".
*************
* C-PY FILE : HT_CTM.MST    84/03/29    雿?雓?鞎?
* HT_MCTM LENGTH 250 BYTES  86/02/28    ?思誘?桃敦??
*************
 FD HTCTM-MST IS EXTERNAL.
 01 HTCTM-REC.
   02 HTCTM-KEY.
      03 HTCTM-CHK-NO.
**       ?思誘?株?
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-CLS-NO.
**          瑼ａ?瑼Ｘ憿隞??
            05 HTCTM-DPT-CD             PIC X(1).
**             瑼ａ?瑼Ｘ蝘恕蝪∠Ⅳ
            05 HTCTM-CLS-CD             PIC X(2).
**             瑼ａ?瑼Ｘ憿蝣?
         04 HTCTM-PR-SEQ                PIC 9(5).
**          ?瘚偌蝣?
      03 HTCTM-IP-DATE                  PIC 9(7).
**       ?思誘?交?
      03 HTCTM-ITM-CD                   PIC X(6).
**       瑼ａ?瑼Ｘ蝝圈?瘚偌??
   02 HTCTM-DATA.
      03 HTCTM-DATA-IP.
**       ?思誘鞈?
         04 HTCTM-P-KEY                 PIC X(21).
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-IP-PRS.
**          ?思誘?蔭鞈?                -- ALT-KEY8
            05 HTCTM-IP-NO              PIC X(22).
**             ?思誘摨?
            05 HTCTM-PRS-NO             PIC X(9).

**             ?孵?蔭隞?Ⅳ
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-SPB-CD.
**          瑼ａ?摰孵隞?Ⅳ                -- ALT-KEY4
            05 HTCTM-SPL-CD             PIC X(1).
**             瑼ａ?隞?Ⅳ
            05 HTCTM-BTL-CD             PIC X(1).
**             摰孵隞?Ⅳ
         04 HTCTM-IO-SW                 PIC X(1).
**          ??撠情蝣?-- HTITM-IO-SW   -- ALT-KEY1
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-IP-DATA.
            05 HTCTM-GRP-SW             PIC X(1).
**             蝯?蝝圈?蝣?-- HTITM-GRP-SW
            05 HTCTM-IP-MCSW            PIC X(1).
**             ?思誘??函Ⅳ
            05 HTCTM-IP-QTY             PIC 9(2).
**             嚗詨??撐?豢?瑼Ｘ甈⊥
            05 HTCTM-IP-RKNO            PIC X(10).
**             蝝圈??思誘?酉蝺刻?
      03 HTCTM-DATA-SC.
**       ??憭???
         04 HTCTM-LNK-SW                PIC X(1).
**          ?蜓璈?蝔Ⅳ                -- ALT-KEY3
         04 HTCTM-MC-NOP                PIC X(3).
**          ??瑼Ｘ??其誨??-- HTMCW-DPT-CD + HTMCW-MCH-CD
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-MC-SEQP               PIC 9(3).
**          ????其?璆剜?瘞渲? -- HTMCH-SEQ-NO
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-WRP-NO.
**          ?思誘??憭蝺刻? -- HTWRP-WRP-NO  -- ALT-KEY1
            05 HTCTM-WRP-SW             PIC X(1).
**             ?格?霅蝣?
            05 HTCTM-WRP-DPT            PIC X(1).
**             ?啣?桐?蝪∠Ⅳ
            05 HTCTM-WRP-DAT            PIC 9(7).
**             ??憭??
            05 HTCTM-WRP-SEQ            PIC 9(2).
**             ??憭瘚偌??
      03 HTCTM-DATA-CK.
**       瑼Ｘ鞈?
         04 HTCTM-MC-NOA                PIC X(3).
**          撖阡?瑼Ｘ??函陛蝣?           -- ALT-KEY2
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-CK-DATA.
            05 HTCTM-MC-SEQA            PIC 9(3).
**             撖阡???其?璆剜?瘞渲? -- HTMCH-SEQ-NO
            05 HTCTM-MC-TMA             PIC 9(7).
**             ??其?璆剖祕?? (蝘?
            05 HTCTM-CK-DATE            PIC 9(7).
**             瑼Ｘ?交?
            05 HTCTM-CK-TIME            PIC 9(6).
**             瑼Ｘ??
            05 HTCTM-CK-MAN             PIC X(5).
**             瑼Ｘ鈭箏
            05 HTCTM-US-DPT             PIC X(5).

**             ?銝剖?隞?? -- HTITM-US-DPT
      03 HTCTM-DATA-RP.
**       蝝圈??勗?鞈?
         04 HTCTM-RP-ST                 PIC X(1).
**          ?勗???Ⅳ                  -- ALT-KEY7
         04 HTCTM-RP-DATE               PIC 9(7).
**          ?勗??交?                    -- ALT-KEY6
*$XFD USE GROUP, VAR-LENGTH
         04 HTCTM-DATA-RP1.
            05 HTCTM-RP-TIME            PIC 9(6).
**             ?勗???
            05 HTCTM-RP-MAN             PIC X(5).
**             ?勗?鈭箏
            05 HTCTM-RP-SW              PIC X(1).
**             ?勗???蝣?-- HTITM-RP-SW
            05 HTCTM-RP-DATA            PIC X(10).
**             蝝圈??勗??批捆??隞嗥楊??
            05 HTCTM-RP-NUMB REDEFINES HTCTM-RP-DATA PIC S9(7)V9(3).
**              ?詨澆?蝝圈??勗?
            05 HTCTM-RP-CODE REDEFINES HTCTM-RP-DATA.
               06 HTCTM-RP-CD OCCURS 10 TIMES PIC X(1).
**                隞?Ⅳ?敦???
            05 HTCTM-CS-DPT             PIC X(5).
**             ?銝剖?隞?? -- HTITM-CS-DPT
*$XFD USE GROUP, VAR-LENGTH
      03 HTCTM-DATA-OTH.
         04 HTCTM-DATA-OK.
**          蝝圈?撖拇鞈?
            05 HTCTM-OK-ST              PIC X(1).
**             撖拇??Ⅳ
            05 HTCTM-OK-DATE            PIC 9(7).
**             撖拇?交?
            05 HTCTM-OK-TIME            PIC 9(6).
**             撖拇??
            05 HTCTM-OK-MAN             PIC X(5).
**             撖拇鈭箏
            05 HTCTM-OK-RKNO            PIC X(10).
**             蝝圈?撖拇?酉蝺刻?
         04 HTCTM-RP-RKNO               PIC X(10).
**          ?勗??酉??蝺刻? -- HTREF-?P-RKNO (86/02/21)
         04 HTCTM-SPL-SV                PIC 9(7).
**          瑼ａ?摮?? (蝘?           -- 86/02/28
         04 HTCTM-FILLER                PIC X(30).
**          蝛箇??

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
** HTCTM-ITM-NO (瑼ａ?瑼Ｘ?隞??) = HTCTM-CLS-NO + HTCTM-ITM-CD
** HTCTM-GRP-SW  : G> ?函???,   P> ?其遢蝯??? D> ?桐?蝝圈?, T> 撅?蝝圈?
** HTCTM-WRP-SW  : C> ?思誘???? D> ?思誘憭
** HTCTM-IP-MCSW : A> ?思誘??     B> ??券?
** HTCTM-IO-SW   : Y> 憭?蝔?, S> ?折???? N> ??蝔?
** HTCTM-LNK-SW  : Y> ?蜓璈歇??
** HTCTM-RP-SW   : 1> ?詨澆?, HTCTM-RP-DA2  = SPACES
**                 2> 隞?Ⅳ??
**                 3> ????
**                 4> ?辣?? HTCTM-RP-DATA = 蝝圈??勗??辣蝺刻?
** HTCTM-RP-ST   : IF HTCTM-RP-SW = "1"
**                 H> ???? L> ???? D> ?梢?? N> 甇?虜??
**                 IF HTCTM-RP-SW = "2" OR "3"
**                 A> ?啣虜?勗?, N> 甇?虜?勗?
** HTCTM-OK-ST   : Y> ?詨?,     N> ?寥, INITIALIZE HTCTM-DATA-SC
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

** 雿平隤芣?嚗?
**              =============== ================ =======================
**               鞈???????    雿?璆???畾?     鞈???靘?皞?
**              =============== ================ =======================
**               HTCTM-GRP-SW    ?交炎,?思誘,?孵   HTITM-GRP-SW
**               HTCTM-DATA-IP   ?交炎,?思誘,?孵   ?交炎,?思誘,?孵蝟餌絞
**               HTCTM-DATA-SC   蝝圈???憭?    瑼ａ?瑼Ｘ蝟餌絞

**               HTCTM-CK-MCP    ?思誘??         HTITM- OR HTCLS-MC-DA
**               HTCTM-DATA-CK   瑼ａ?瑼Ｘ         瑼ａ?瑼Ｘ蝟餌絞
**               HTCTM-DATA-RP   蝯??勗?         瑼ａ?瑼Ｘ蝟餌絞
**               HTCTM-DATA-OK   ?勗?撖拇         瑼ａ?瑼Ｘ蝟餌絞
*COPY    "HT_CTR.MST".
*************
* C-PY FILE : HT_CTR.MST    90/03/05    雿?雓?鞎?
* HT_MCTR LENGTH 101 BYTES  90/03/05    ?思誘?桃敦????勗?瑼?
*************
 FD HTCTR-MST IS EXTERNAL.
 01 HTCTR-REC.
   02 HTCTR-KEY                         PIC X(21).
**    ?思誘?桃敦???萄?                 --HTCTR-KEY
*$XFD VAR-LENGTH
   02 HTCTR-DATA                        PIC X(80).
**    ?思誘?桃敦????勗??批捆

** 雿平?挾 : ?勗??駁?&?亥岷?, ??, ?儔
*COPY    "HT_ITM.MST".
* ==SCL== 2004.08.17 START ----- ?MDLT??其誨蝣潸身摰?-------------------------*

*************
* C-PY FILE : HT_ITM.MST   84/03/27     雿?雓?鞎?
* HT_MITM LENGTH 300 BYTES 90/11/23     瑼ａ?瑼Ｘ?摰儔瑼?
*************
 FD HTITM-MST IS EXTERNAL.
 01 HTITM-REC.
   02 HTITM-KEY.
      03 HTITM-ITM-NO.
**    瑼ａ?瑼Ｘ?隞??           (1:9)
        04 HTITM-CLS-NO.
**         瑼ａ?瑼Ｘ憿隞??
           05 HTITM-DPT-CD              PIC X(1).
**            瑼ａ?瑼Ｘ蝘恕蝪∠Ⅳ   (1:1)
           05 HTITM-CLS-CD              PIC X(2).
**            瑼ａ?瑼Ｘ憿蝣?    (2:2)
*$XFD USE GROUP, VAR-LENGTH
        04 HTITM-ITM-CD                 PIC X(6).
**         瑼ａ?瑼Ｘ?隞?Ⅳ      (4:6)
        04 HTITM-SEQ-NO REDEFINES HTITM-ITM-CD.
**         瑼ａ?瑼Ｘ瘚偌??
           05 HTITM-SEQ-CD              PIC X(3).
**            瑼ａ?瑼Ｘ瘚偌蝣?    (4:3)
           05 HTITM-SEQ-SP              PIC X(3).
**            蝛箇??            (7:3)
        04 HTITM-PST-NO REDEFINES HTITM-ITM-CD.
**         ?其?瑼Ｘ蝯?蝣?       (4:6)
           05 HTITM-PST-CD1             PIC X(2).
**            ?其?瑼Ｘ?其?蝣?    (4:2)
           05 HTITM-PST-CD2             PIC X(2).
**            ?其?瑼Ｘ蝝圈蝣?    (6:2)
           05 HTITM-PST-CD3             PIC X(2).
**            ?其?瑼Ｘ敺桅蝣?    (8:2)
   02 HTITM-DATA.
      03 HTITM-ITM-NM                   PIC X(40).
**       瑼ａ?瑼Ｘ??迂 (10:40)
      03 HTITM-SEQ-MN                   PIC 9(3).

**       ?恍?賊?摨?     (50:3)        -- ALT-KEY4
      03 HTITM-FEE-CD1                  PIC X(12).
**       ?孵?蔭隞??     (53:12)       -- ALT-KEY1
      03 HTITM-FEE-CD2                  PIC X(12).
**       ?孵?蔭隞??     (65:12)       -- ALT-KEY6
      03 HTITM-MCH-CD                   PIC X(12).
**       ??刻?蝵桐誨??    (77:12)       -- ALT-KEY2
      03 HTITM-SYS-CD                   PIC X(12).
**       摰頂蝯梯?蝵桐誨??  (89:12)       -- ALT-KEY3
      03 HTITM-GRP-SW                   PIC X(1).
**       蝯?霅蝣?     (101:1)        -- ALT-KEY9
      03 HTITM-GRP-SL                   PIC X(1).
**       蝯??賊?蝣?     (102:1)
      03 HTITM-DATA-NGROUP.
**       ??????
         04 HTITM-REF-UT                PIC X(10).
**          瑼ａ??澆雿?  (103:10)
*$XFD USE GROUP, VAR-LENGTH
         04 HTITM-DATA-SPL.
**          瑼ａ?摰孵鞈? (113:10)
            05 HTITM-SPB-CD1.
**             瑼ａ?摰孵隞?Ⅳ嚗?
               06 HTITM-SPL-CD1         PIC X(1).
**                瑼ａ?隞?Ⅳ嚗?
               06 HTITM-BTL-CD1         PIC X(1).
**                摰孵隞?Ⅳ嚗?
            05 HTITM-SPB-CD2.
**             瑼ａ?摰孵隞?Ⅳ嚗?
               06 HTITM-SPL-CD2         PIC X(1).
**                瑼ａ?隞?Ⅳ嚗?
               06 HTITM-BTL-CD2         PIC X(1).
**                摰孵隞?Ⅳ嚗?
            05 HTITM-SPB-CD3.
**             瑼ａ?摰孵隞?Ⅳ嚗?
               06 HTITM-SPL-CD3         PIC X(1).
**                瑼ａ?隞?Ⅳ嚗?
               06 HTITM-BTL-CD3         PIC X(1).
**                摰孵隞?Ⅳ嚗?
            05 HTITM-SPB-CD4.
**             瑼ａ?摰孵隞?Ⅳ嚗?
               06 HTITM-SPL-CD4         PIC X(1).
**                瑼ａ?隞?Ⅳ嚗?
               06 HTITM-BTL-CD4         PIC X(1).
**                摰孵隞?Ⅳ嚗?
            05 HTITM-SPB-CD5.
**             瑼ａ?摰孵隞?Ⅳ嚗?
               06 HTITM-SPL-CD5         PIC X(1).
**                瑼ａ?隞?Ⅳ嚗?
               06 HTITM-BTL-CD5         PIC X(1).
**                摰孵隞?Ⅳ嚗?
         04 HTITM-DATA-REF.
**          ?潸???
*$XFD USE GROUP, VAR-LENGTH
            05 HTITM-REF-DA.
               06 HTITM-EX-REF          PIC X(1).
**                摮?Ⅳ  (123:1)
               06 HTITM-AG-REF          PIC X(1).

**                撟湧翩?Ⅳ
               06 HTITM-SX-REF          PIC X(1).
**                ?批?Ⅳ
               06 HTITM-SP-REF          PIC X(1).
**                瑼ａ??Ⅳ
               06 HTITM-TM-REF          PIC X(1).
**                ???Ⅳ
               06 HTITM-PR-REF          PIC X(1).
**                ?瑕??Ⅳ
               06 HTITM-PE-REF          PIC X(1).
**                ?瑞???Ⅳ
            05 HTITM-ITM-RF             PIC X(9).
**             瑼ａ?瑼Ｘ??誨??    -- ALT-KEY7 (130:9)
*$XFD USE GROUP, VAR-LENGTH
         04 HTITM-DATA-RK.
**          蝝圈??酉蝭?鞈?  (139:33)
            05 HTITM-IP-RKAT            PIC X(1).
**             蝝圈??思誘?酉?芸?蝣?
            05 HTITM-IP-RKNO            PIC X(10).
**             蝝圈??思誘?酉蝭?蝺刻?
            05 HTITM-RP-RKAT            PIC X(1).
**             蝝圈??勗??芸?蝣?
            05 HTITM-RP-NO              PIC X(10).
**             蝝圈??勗??辣蝭?蝺刻?
            05 HTITM-OK-RKAT            PIC X(1).
**             蝝圈?撖拇?酉?芸?蝣?
            05 HTITM-OK-RKNO            PIC X(10).
**             蝝圈?撖拇?酉蝭?蝺刻?
**-YMN- 981022
            05 HTITM-RP-CLS REDEFINES HTITM-OK-RKNO.
               06 HTITM-RPT-CLS         PIC X(1).
**                   銋單頞瘜Ｗ??隡啣?憿?血???(Y>? #蝛箇>銝???
               06 HTITM-RPT-EN          PIC X(1).
**                   ?勗???孵??               (1.銝剜? 2.?望? #蝛箇>銝剛??
               06 HTITM-RP-CLS-FILLER   PIC X(8).
**-YMN- 981022

         04 HTITM-DATA-ITM.
**          蝝圈?閮剖?鞈?      (172:1)
            05 HTITM-SL-SW              PIC X(1).
**             ?寞?瑼Ｘ蝣?              -- ALT-KEY5
*$XFD USE GROUP, VAR-LENGTH
            05 HTITM-ITM-DA.
**                            (173:37)
               06 HTITM-IO-FEE          PIC 9(6).
**                蝝圈?憭祥??
               06 HTITM-IO-HSP          PIC X(12).
**                憭?Ｖ誨??
               06 HTITM-IO-SW           PIC X(1).
**                ??撠情蝣?
               06 HTITM-SC-SW           PIC X(1).
**                ???孵?蝣?
               06 HTITM-RP-SW           PIC X(1).
**                蝝圈??勗???蝣?
               06 HTITM-SG-SW           PIC X(1).
**                ?桐?蝝圈??勗?蝣?
               06 HTITM-MC-SW           PIC X(1).

**                蝪賣敺?蝔Ⅳ
**               06 HTITM-CS-DPT          PIC X(5).
**                ?銝剖?隞??
**               06 HTITM-US-DPT          PIC X(5).
**                ?銝剖?隞??
               06 HTITM-EMG-PSW         PIC X.
**                ?乩辣瑼ａ??挾閮剖?蝣?   -- 90/01/30
               06 HTITM-EMG-PRD.
**                ?乩辣瑼ａ??挾          -- 90/01/30
                  07 HTITM-EMG-B.
**                   ????
                     08 HTITM-EMG-BHH   PIC X.
**                      ??撠?
                     08 HTITM-EMG-BMN   PIC X.
**                      ????
                  07 HTITM-EMG-EN.
**                   ???亦?????
                     08 HTITM-EMG-ENHH  PIC X.
**                      ???亦?????
                     08 HTITM-EMG-ENMN  PIC X.
**                      ???亦?????
                  07 HTITM-EMG-EH.
**                   ?蝯???
                     08 HTITM-EMG-EHHH  PIC X.
**                      ?蝯?撠?
                     08 HTITM-EMG-EHMN  PIC X.
**                      ?蝯???
                  07 HTITM-EMG-ES.
**                   ?望蝯???
                     08 HTITM-EMG-ESHH  PIC X.
**                      ?望蝯?撠?
                     08 HTITM-EMG-ESMN  PIC X.
**                      ?望蝯???
               06 HTITM-IPC-SW          PIC X(1).
**                ???亙??雿萇Ⅳ      -- 900309
               06 HTITM-VP-DA.
**                ??鈭支辣鞈?
                  07 HTITM-VP-TU        PIC X(1).
**                   ??鈭支辣???桐?蝣?
                  07 HTITM-ONLY-SEX     PIC X(1) REDEFINES HTITM-VP-TU.
**                   ???批??(1>?? 2>憟?
                  07 HTITM-VP-TQ        PIC 9(3).
**                   ??鈭支辣???賊?
                  07 HTITM-HDG-ITM REDEFINES HTITM-VP-TQ.
                     08 HTITM-HDG-YN        PIC X(1).
*                       擃◢?芣炎?仿??株身摰?
                     08 HTITM-HDG-FILLER    PIC X(2).
*                       蝛箇??
*980824
                     08 HTITM-HDG-FILLER1 REDEFINES HTITM-HDG-FILLER.
*980824 ?勗??芰霅衣內
                        09  HTITM-WARN-SW      PIC X(1).
                        09  HTITM-ITM-PART     PIC X(1).
*                           IC?⊿雿???        --YMN(98.9.30)


*$XFD USE GROUP, VAR-LENGTH

      03 HTITM-FILLER.
**                              (210:??)
         04 HTITM-ITM-NN                PIC X(10).
**          瑼ａ?瑼Ｘ?蝪∠迂    (210:10)
         04 HTITM-DEL-SW                PIC X(1).
**          ?芷?蝣?         (220:1)
         04 HTITM-RP-DATE               PIC 9(7).
**          ?餈?          (221:7)
         04 HTITM-DATA-UT.
**          瑼ａ??澆雿???     (228:??)
            05 HTITM-REF-UT1            PIC X(10).
**             瑼ａ??澆雿?     (228:10) (?嗆璈??桐?銝??潔???閮剖?)
            05 HTITM-REF-UT2            PIC X(10).
**             瑼ａ??澆雿?     (238:10)
* ==SCL== 2004.08.17 START ----- ?MDLT??其誨蝣潸身摰?-------------------------*
            05 HTITM-MDLT-DA  REDEFINES HTITM-REF-UT2.
                06 HTITM-MDLT-DATA      PIC X(10).
*                  PACS ??其??喃誨蝣潸身摰?(EX . CT CR MR ANGIO ...)
* ==SCL== 2004.08.17 END   ----- ?MDLT??其誨蝣潸身摰?-------------------------*
            05 HTITM-REF-UT3            PIC X(10).
**             瑼ａ??澆雿?     (248:10)
            05 HTITM-RPT-FIL3 REDEFINES HTITM-REF-UT3.
               06 HTITM-DATA-DPT-PC.
**                ?踵??炎?券?閮剖?鞈?
                  07 HTITM-EMG-DPT-PC   PIC X(2).
**                   ?踵??乩辣?炎?券?隞??
                  07 HTITM-NMG-DPT-PC   PIC X(2).
**                   ?踵??乩辣?炎?券?隞??
               06 HTITM-OLD-TRN-ITM-CD  PIC X(6).
**                ???Ⅳ頧蝣澆?摮?Ⅳ?TM-CD ??撠??怠?)?血?撣?摰?銝??芷嚗?

            05 HTITM-REF-UT4            PIC X(10).
**             瑼ａ??澆雿?     (258:10)
            05 HTITM-RPT-FIL4 REDEFINES HTITM-REF-UT4.
               06 HTITM-PRT-BIG-RPT     PIC X(1).
**                瑼ａ?瑼Ｘ蝯???曉之
               06 HTITM-GRR-YN          PIC X(1).
**                瑼ａ?瑼Ｘ蝯?雿?閮粹?抒??
               06 HTITM-CPU-YN          PIC X(1).
**                瑼ａ?瑼Ｘ蝯???蝞?
               06 HTITM-LBL-QTY         PIC 9(1).
**                璅惜?撘菜          -- 90/11/15
               06 HTITM-PRS-QTY         PIC X(1).
**                ?蔭??1銝??桃Ⅳ(Y/N) -- 90/11/23 --> PRS-PAS-QTY-MRK
               06 HTITM-NUM-FLOAT       PIC X(1).
**                ?詨澆??勗?憿舐內撠敺嗾雿?-- 910427
               06 HTITM-RF-PRT-YN       PIC X(1).
**                ??閮駁＊蝷?Y/E/N)   -- 930111
               06 HTITM-GRP-CNT-YN      PIC X(1).
**                蝯?蝝圈?鈭虫?隞嗆閮?  -- 930525
               06 HTITM-ANN-CD          PIC X(1).
**                撖行?其?隞?Ⅳ(A????)-- 931214
               06 HTITM-DNG-SW          PIC X(1).
**                ?梢?潮?撅祆?
            05 HTITM-REF-UT5            PIC X(10).
**             瑼ａ??澆雿?     (268:10)
            05 HTITM-RPT-FIL5 REDEFINES HTITM-REF-UT5.

               06 HTITM-RPT-NO-REF      PIC X(1).
**                瑼ａ??勗?銝??
               06 HTITM-CHG-ITM-NO      PIC X(9).
**                瑼ａ??勗??踵??炎撽誨蝣?
         04 HTITM-BRH-SW                PIC X(1).
**          銵?H瑼Ｘ??       (278:1)
         04 HTITM-MSV-SW                PIC X(1).
**          ?隞日?瑼ａ?蝯?摮?蝣? (279:1)
         04 HTITM-URG-SW                PIC X(1).
**          ?亥那???孵???? (280:1) -- 860618
**       04 HTITM-DATA-WK.
**          瑼ａ????梯???     (281:7)
**          05 HTITM-SCH-WK OCCURS 7 TIMES PIC X(1).
**             ?望活????蝣?          -- 860701
         04 HTITM-DATA-DPT.
**          ?炎?券?閮剖?鞈?    (281:4) -- 871130       -- APPEND
            05 HTITM-EMG-DPT            PIC X(2).
**             ?乩辣?炎?券?隞??
            05 HTITM-NMG-DPT            PIC X(2).
**             ?乩辣?炎?券?隞??
         04 HTITM-PPAT-SW               PIC X.
**          ?思誘?桀偏??鞈?(285:1) -- 900314
         04 HTITM-DRS-SW                PIC X(1).
**          ?亙?蝞∪蝣?         (286:1) -- 900412
         04 HTITM-ODR-HW                PIC X(1).
**          ?交炎????Y/N)     (287:1) -- 900417
         04 HTITM-SCRP-SW               PIC X.
**          ????株身摰Ⅳ    (288:1)
         04 HTITM-IRPT-SW               PIC X.
**          ???思誘?單??勗?    (289:1) -- 890614

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

** HTITM-DEL-SW  : Y> 甇斤敦???臬??
** HTITM-GRP-SW  : Y> ?思誘蝯??? R> ?勗?蝯??? N> ?箸??
**                 IF HTITM-GRP-SW NOT = 'N'    ACCEPT HTITM-GRP-SL.
** HTITM-GRP-SL  : Y> 蝯?蝝圈??舫脰??桐??賊?
** HTITM-VP-TU   : D> ?? H> ?? M> ?? S> 蝘? W> ????撟?
** HTITM-RP-SW   : 1> ?詨澆?, 2> 隞?Ⅳ?? 3> ????10 BYTE), 4> ?辣?? 5> ?瑟?摮?(57 BYTE--900305-->HT_CTR.MST)
** HTITM-IO-SW   : Y> 憭?蝔?, S> ?折???? N> ??蝔?
**                 IF HTITM-GRP-SW = "Y"                    THEN
**                      MOVE "N" TO HTITM-SC-SW HTITM-IO-SW ELSE
**                 IF HTCLS-IO-SW  > "A"                    THEN
**                      MOVE HTCLS-IO-SW TO HTITM-IO-SW     ELSE
**                      ACCEPT HTITM-IO-SW (HTITM-IO-SW MUST = "S" OR "Y").

** HTITM-SC-SW   : A> 鈭箏極???? B> ?芸????? C> ?寞活???? N> ??蝔?
**                 IF HTITM-IO-SW = "N"      MOVE "N" TO HTITM-SC-SW ELSE
**                 IF HTITM-IO-SW = "Y"      MOVE "C" TO HTITM-SC-SW ELSE
**                                           MOVE HTCLS-SC-SW TO HTITM-SC-SW
**                                           ACCEPT HTITM-SC-SW.
** HTITM-MC-SW   : Y> 蝪賣敺?舀?蝔? N> 銝?蝪賣?喳??
**                 IF HTITM-IO-SW NOT = "N"  ACCEPT HTITM-MC-SW.
** HTITM-SG-SW   : Y> ?桐?蝝圈??勗?, HTITM-RP-SW = "2" IS REQUIRED
** HTITM-SL-SW   : Y> ?寞?瑼Ｘ??
** HTITM-URG-SW  : Y> ?亥那???孵???? U> ?乩辣???? M> ?乩辣????
** HTITM-MSV-SW  : N> ?隞日?銋炎撽???摮?, ?園?銵券?摮?
** HTITM-BRH-SW  : B> 銵?葫摰?, R> RH(D)?炎?仿?
** HTITM-SCH-WK  : Y> ??摰?蝔? N> ?⊥?摰?蝔? Q> ?芣?摰?蝔?
**                 IF HTITM-DATA-WK = SPACES                      THEN
**                    HTITM-SCH-WK(1)-(6) = 'Y' & HTITM-SCH-WK(7) = 'N'
** HTITM-EX-REF  : Y> ???潦? CREATE HT_REF.MST
**                    IF HTITM-ITM-RF = SPACES
**                         MOVE HTITM-ITM-NO TO HTREF-ITM-NO
**                    ELSE MOVE HTITM-ITM-RF TO HTREF-ITM-NO
** HTITM-AG-REF  : Y> ?潦僑朣～???
** HTITM-SX-REF  : Y> ?潦批????
** HTITM-SP-REF  : Y> ?潦炎擃???
** HTITM-TM-REF  : Y> ?潦?????
** HTITM-PR-REF  : Y> ?潦摮???
** HTITM-PE-REF  : Y> ?潦?曇?????
** HTITM-IRPT-SW : Y> ???思誘?單??勗?, MOVE 'Y' TO PRS-IRPT-RMK
** HTITM-RP-RKAT : Y> 蝝圈??芸??勗?
** HTITM-IP-RKAT : Y> 蝝圈??思誘?芸??酉
** HTITM-OK-RKAT : Y> 蝝圈?撖拇?芸??酉
** HTITM-SCRP-SW : Y> ????株身摰?
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
** IF HTITM-DPT-CD = SPACES     HTITM-ITM-NO = 銝?蝘恕瑼ａ?瑼Ｘ?隞??.
** IF HTITM-GRP-SW = "Y" OR "R" MOVE   SPACE TO HTITM-DATA-NGROUP.
** IF HTCLS-RP-CS  = "B"        MOVE   SPACE TO HTITM-RP-SW.
** IF HTCLS-IP-RP  = "B"        ACCEPT HTITM-PST-NO
**    ELSE                      ACCEPT HTITM-SEQ-CD.
** HTITM-PPAT-SW : Y> ?思誘?桀偏??鞈?
** HTITM-DRS-SW  : F> 蝪賣???恣?嗉??? MUST HTCLS-DRS-SW = 'F' OR 'T'
**                 J> ?勗????恣?嗉??? MUST HTCLS-DRS-SW = 'J' OR 'T'

** HTITM-ANN-CD  : A>?賊-->?剝  B>?賊 C>?寥 D>?? E>銝???
**                 ?曇??嘹C?⊿?閬隞支??單?雿輻嚗誑??之憿?
**                 ?辣?神 ?賊 嚗?雿?血之摰嗉死敺?????? ???其遢嚗?
**                 瘝??剝?身摰??隞?A ?寧 ?剝
** -YAC- 2009.01.22 (???恍?拍)
** ?其??航撓?丕~T
*>?文??括(?賊)?(?賊)?(?刻???(?刻?璊??(銝??? 憭?
*>??航身摰?F(?剝)?嚗+?賂??嚗璊??嚗璊??嚗璊???
*>K嚗璊??嚗偏璊??嚗??寥嚗嚗??寥嚗嚗爸??嚗?
*>P嚗??ｇ??嚗??ｇ??嚗頨恬??嚗????嚗隞???

** HTITM-DNG-SW  : A>??銝?? B>??雿??望??恣) C>??雿??望??Ｘ?)

** HTITM-HDG-YN  : Y>擃◢?芣炎?仿??? 蝛箇>??憸券瑼Ｘ?
*COPY    "HT_REF.MST".
*************
* C-PY FILE : HT_REF.MST    84/04/24    雿?雓?鞎?
* HT_MREF LENGTH 200 BYTES  86/02/28    瑼ａ?瑼Ｘ蝝圈??潭?
*************
 FD HTREF-MST IS EXTERNAL.
 01 HTREF-REC.
*$XFD USE GROUP, VAR-LENGTH
   02 HTREF-KEY.
      03 HTREF-ITM-NO                   PIC X(9).
**       瑼ａ?瑼Ｘ蝝圈?隞??
      03 HTREF-SEX-CD                   PIC X(1).
**       ?批隞??
      03 HTREF-SPL-CD                   PIC X(1).
**       瑼ａ?隞??
      03 HTREF-PER-ST                   PIC X(1).
**       ?瑞??瘜?
      03 HTREF-PRE-H                    PIC 9(2).
**       ?瑕??望銝?
      03 HTREF-AGE-H                    PIC 9(3).
**       撟湧翩銝?
      03 HTREF-TME-H                    PIC 9(7).
**       瑼ａ?摮??銝? (蝘?
      03 HTREF-TY-ID                    PIC X(1).

**       隞?Ⅳ????誨蝣?
      03 HTREF-FILLER1                  PIC X(15).
**       蝛箇??
*$XFD USE GROUP, VAR-LENGTH
   02 HTREF-DATA.
      03 HTREF-PRE-L                    PIC 9(2).
**       ?瑕??望銝?
      03 HTREF-AGE-L                    PIC 9(3).
**       撟湧翩銝?
      03 HTREF-TME-L                    PIC 9(7).
**       瑼ａ?摮??銝? (蝘?
      03 HTREF-DATA1.
**       ?詨澆?鞈?
         04 HTREF-REF-VLL               PIC S9(7)V9(3).
**          ?潔???
         04 HTREF-REF-VLH               PIC S9(7)V9(3).
**          ?潔???
         04 HTREF-DNG-VLL               PIC S9(7)V9(3).
**          ?梢?潔???
         04 HTREF-DNG-VLH               PIC S9(7)V9(3).
**          ?梢?潔???
      03 HTREF-DATA2 REDEFINES  HTREF-DATA1.
**       隞?Ⅳ??????
         04 HTREF-TXT-SW                PIC X(1).
**          甇?撣貉??亦Ⅳ -- N> 甇?虜, A> ?啣虜
         04 HTREF-CDE-RF.
**          隞?Ⅳ????
            05 HTREF-TXT-RF             PIC X(10).
**             ??????
            05 HTREF-TXT-SP             PIC X(29).
**             蝛箇??
      03 HTREF-DATA3.
**       ?詨澆??酉鞈?
         04 HTREF-HP-RKNO               PIC X(10).
**          ???澆?閮餌?隤楊??
         04 HTREF-LP-RKNO               PIC X(10).
**          ???澆?閮餌?隤楊??
         04 HTREF-DP-RKNO               PIC X(10).
**          ?梢?澆?閮餌?隤楊??
      03 HTREF-DATA4 REDEFINES  HTREF-DATA3.
**       隞?Ⅳ????閮餉???
         04 HTREF-AP-RKNO               PIC X(10).
**          ?啣虜?酉??蝺刻?
         04 HTREF-NP-RKNO               PIC X(10).
**          甇?虜?酉??蝺刻?
         04 HTREF-SP-RKNO               PIC X(10).
**          蝛箇??
      03 HTREF-FILLER2                  PIC X(78).
**       蝛箇??

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
* C-PY FILE : HT_SPL.MST   84/03/23     雿?雓?鞎?
* HT_MSPL LENGTH 50 BYTES  85/03/04     瑼ａ?蝔桅?摰儔瑼?
*************
 FD HTSPL-MST IS EXTERNAL.
 01 HTSPL-REC.
   02 HTSPL-KEY.
      03 HTSPL-SPL-NO.
**        瑼ａ?隞??
          04 HTSPL-DPT-CD               PIC X(1).
**           瑼ａ?瑼Ｘ蝘恕蝪∠Ⅳ
          04 HTSPL-SPL-CD               PIC X(1).
**           瑼ａ?隞?Ⅳ
*$XFD USE GROUP, VAR-LENGTH
   02 HTSPL-DATA.
      03 HTSPL-SPL-NM                   PIC X(20).
**       瑼ａ??迂
      03 HTSPL-SPL-NN                   PIC X(6).
**       瑼ａ?蝪∠迂
      03 HTSPL-IP-RKAT                  PIC X(1).
**       瑼ａ??思誘?酉?芸?蝣?
      03 HTSPL-IP-RKNO                  PIC X(10).
**       瑼ａ??思誘?酉蝭?蝺刻?
      03 HTSPL-FILLER                   PIC X(11).
**       蝛箇??

** HTSPL-ALT-KEY = HTSPL-SPL-CD + HTSPL-DPT-CD

** HTSPL-IP-RKAT : Y> 瑼ａ??思誘?芸??酉
** HTSPL-IP-RKNO : MOVE "B1"          TO W-EDT-RPT-TY
**                 MOVE "1"           TO W-EDT-CPY-SW
**                 MOVE "C,M,D,I"     TO W-EDT-FUN-SW
**                 MOVE SPACES        TO W-EDT-USR-NO
**                 MOVE HTSPL-DPT-CD  TO W-EDT-CPY-KY
**                 MOVE HTSPL-IP-RKNO TO W-EDT-RPT-NO
**                 LINK HZ_EDT.LNK &  CALL "HZEDTCF" USING W-EDT-TABLE
** IF HTSPL-DPT-CD = SPACES     HTSPL-SPL-NO = 銝?蝘恕瑼ａ?隞??
*COPY    "HT_BTL.MST".
*************
* C-PY FILE : HT_BTL.MST   84/03/08     雿?雓?鞎?
* HT_MBTL LENGTH 50 BYTES  85/03/02     摰孵蝔桅?摰儔瑼?
*************
 FD HTBTL-MST IS EXTERNAL.
 01 HTBTL-REC.
   02 HTBTL-KEY.
      03 HTBTL-BTL-NO.
**       摰孵隞??
         04 HTBTL-DPT-CD                PIC X(1).
**          瑼ａ?瑼Ｘ蝘恕蝪∠Ⅳ
         04 HTBTL-BTL-CD                PIC X(1).
**          摰孵隞?Ⅳ

*$XFD USE GROUP, VAR-LENGTH
   02 HTBTL-DATA.
      03 HTBTL-BTL-NM                   PIC X(20).
**       摰孵?迂
      03 HTBTL-BTL-NN                   PIC X(6).
**       摰孵蝪∠迂
      03 HTBTL-FILLER                   PIC X(22).
**       蝛箇??

** HTBTL-ALT-KEY = HTBTL-BTL-CD + HTBTL-DPT-CD

** IF HTBTL-DPT-CD = SPACES     HTBTL-BTL-NO = 銝?蝘恕摰孵隞??
*
*COPY "HT_V03.MST".
*************
* C-PY FILE : HT_V03.MST   88/07/15     雿??喳?敶?
* HT_MV03 LENGTH  80 BYTES 88/07/15     蝝啗?摰?-> ?勗??膩憿?摰儔瑼?
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

** HTV04-V04-CD1 : A>No growth  B>Blood culture  C>銝?祆??交扯岫撽?
**                 D>蝝啗??  E>蝯?? F>暺渲??  G>暺渲??寥?
**                 Y>瑼ａ?  0>?酉

*COPY "HT_V02.MST".
*************
* C-PY FILE : HT_V02.MST   88/07/20     雿??喳?敶?
* HT_MV02 LENGTH 120 BYTES 88/07/20     蝝啗?摰?-> ?勗??膩閮剖?瑼?
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
** ?恍?賊?摨?                         -- ALT-KEY1
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

** HTV02-V02-CD1 : A>No growth  B>Blood culture  C>銝?祆??交扯岫撽?
**                 D>蝝啗??  E>蝯?? F>暺渲??  G>暺渲??寥?  Y>瑼ａ?  0>?酉

** HTV02-SHOW-HEAD : SHOW 璅??

*COPY "HT_V05.MST".
*************
* C-PY FILE : HT_V05.MST   88/08/19     雿??喳?敶?
* HT_MV05 LENGTH 100 BYTES 88/08/19     蝝啗?摰?-> ??蝝??貉身摰?璆?
*************
 FD HTV05-MST IS EXTERNAL.
 01 HTV05-REC.
   02 HTV05-KEY.
      03 HTV05-ANT-NO                   PIC X(5).
   02 HTV05-SEQ-NM                      PIC 9(2).
** ?恍?賊?摨?                         -- ALT-KEY1
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
* C-PY FILE : HT_VNO.MST   88/07/22     雿??喳?敶?
* HT_MVNO LENGTH 200 BYTES 88/07/25     蝝啗?摰文?瑼Ｘ炎擃楊??
*************
 FD HTVNO-MST IS EXTERNAL.
 01 HTVNO-REC.
   02 HTVNO-KEY.
*$XFD USE GROUP
      03 HTVNO-VNO-ID                   PIC X(1).
**       瑼ａ?蝺刻?閬?
      03 HTVNO-VNO-NO                   PIC X(15).
**       ?炎瑼ａ?蝺刻?
      03 HTVNO-VNO-NO1 REDEFINES HTVNO-VNO-NO.
         04 HTVNO-V01-CD1               PIC X(1).
**          瑼ａ?蝺刻?蝺函Ⅳ??
         04 HTVNO-YEAR-CD1              PIC X(2).
**          镼踹?蝝撟游??拍Ⅳ
         04 HTVNO-SEQ-NO1               PIC 9(5).
**          ?炎瑼ａ?瘚偌??
         04 HTVNO-NO-FIL1               PIC X(7).
**          蝛箇??

      03 HTVNO-VNO-NO2 REDEFINES HTVNO-VNO-NO.
         04 HTVNO-V01-CD2               PIC X(1).
**          瑼ａ?蝺刻?蝺函Ⅳ??
         04 HTVNO-MON-CD2               PIC X(4).
**          ??撟湔?
         04 HTVNO-SEQ-NO2               PIC 9(4).
**          ?炎瑼ａ?瘚偌??
         04 HTVNO-NO-FIL2               PIC X(6).
**          蝛箇??
      03 HTVNO-VNO-NO3 REDEFINES HTVNO-VNO-NO.
         04 HTVNO-V01-CD3               PIC X(1).
**          瑼ａ?蝺刻?蝺函Ⅳ??
         04 HTVNO-DAT-CD3               PIC X(6).
**          ??撟湔???
         04 HTVNO-SEQ-NO3               PIC 9(3).
**          ?炎瑼ａ?瘚偌??
         04 HTVNO-NO-FIL3               PIC X(5).
**          蝛箇??
   02 HTVNO-DATA.
*$XFD USE GROUP
      03 HTVNO-VNO-ON                   PIC X(15).
**       ?炎瑼ａ?撠?蝺刻?
      03 HTVNO-VNO-ON1 REDEFINES HTVNO-VNO-ON.
         04 HTVNO-VON-V01-CD1           PIC X(1).
**          瑼ａ?蝺刻?蝺函Ⅳ??
         04 HTVNO-VON-YEAR-CD1          PIC X(2).
**          镼踹?蝝撟游??拍Ⅳ
         04 HTVNO-VON-SEQ-NO1           PIC 9(5).
**          ?炎瑼ａ?撠?瘚偌??= 100000 - HTVNO-SEQ-NO1
         04 HTVNO-VON-NO-FIL1           PIC X(7).
**          蝛箇??
      03 HTVNO-VNO-ON2 REDEFINES HTVNO-VNO-ON.
         04 HTVNO-VON-V01-CD2           PIC X(1).
**          瑼ａ?蝺刻?蝺函Ⅳ??
         04 HTVNO-VON-MON-CD2           PIC X(4).
**          ??撟湔?
         04 HTVNO-VON-SEQ-NO2           PIC 9(4).
**          ?炎瑼ａ?撠?瘚偌??= 10000  - HTVNO-SEQ-NO2
         04 HTVNO-VON-NO-FIL2           PIC X(6).
**          蝛箇??
      03 HTVNO-VNO-ON3 REDEFINES HTVNO-VNO-ON.
         04 HTVNO-VON-V01-CD3           PIC X(1).
**          瑼ａ?蝺刻?蝺函Ⅳ??
         04 HTVNO-VON-DAT-CD3           PIC X(6).
**          ??撟湔???
         04 HTVNO-VON-SEQ-NO3           PIC 9(3).
**          ?炎瑼ａ?撠?瘚偌??= 1000   - HTVNO-SEQ-NO3
         04 HTVNO-VON-NO-FIL3           PIC X(5).
**          蝛箇??
      03 HTVNO-VPL-CD                   PIC X(1).
**       瑼ａ?隞?Ⅳ
*$XFD USE GROUP
   02 HTVNO-CHK-TABLE.
      03 HTVNO-CHK-REC OCCURS 9 TIMES.
         04 HTVNO-CHK-NO                PIC X(8).
         04 HTVNO-IP-DATE               PIC 9(7).
**       ?思誘?交?

   02 HTVNO-AC-DATE                     PIC 9(7).
**    ?嗡辣?交?
   02 HTVNO-FILLER                      PIC X(26).
**    蝛箇??


** HTVNO-ALT-KEY1 = HTVNO-VNO-ID  HTVNO-VNO-ON
** HTVNO-ALT-KEY2 = HTVNO-VNO-ID  HTVNO-AC-DATE  HTVNO-VNO-NO

** HTVNO-VNO-ID  : 1> 撟? 2> 撟湔?  3> 撟湔???


*
*COPY "HT_VVV.MST".
*************
* C-PY FILE : HT_VVV.MST   88/11/04     雿??喳?敶?
* HT_MVVV LENGTH 302 BYTES 88/11/04     蝝啗?摰?-> 蝟餌絞?閮剖?瑼?
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

** HTVVV-DPT-CD1 : T> 瑼ａ?蝘?
** HTVVV-DPT-CD2 : V> 蝝啗?摰?


*COPY "HT_VK1.MST".
*************
* C-PY FILE : HT_VK1.MST   88/07/25     雿??喳?敶?
* HT_MVK1 LENGTH 300 BYTES 89/03/28     蝝啗?摰斗炎撽??蜓瑼?
*************
 FD HTVK1-MST IS EXTERNAL.
 01 HTVK1-REC.
   02 HTVK1-KEY.
      03 HTVK1-CHK-NO.
         04 HTVK1-CLS-NO                PIC X(3).
         04 HTVK1-PR-SEQ                PIC 9(5).
      03 HTVK1-IP-DATE                  PIC 9(7).
**       ?思誘?交?
   02 HTVK1-IP-DATE1                    PIC 9(7).
**    ?思誘?交? 9999999 - HTVK1-IP-DATE
*$XFD USE GROUP
   02 HTVK1-PT-NO                       PIC 9(8).
**    ?風?Ⅳ
   02 HTVK1-IP-DATA.
**    ?思誘鞈?
*$XFD USE GROUP, VAR-LENGTH
      03 HTVK1-IP-NO                    PIC X(22).
**       ?思誘摨?
      03 HTVK1-IP-NO1 REDEFINES HTVK1-IP-NO.
**       ?閮粹隞文???

         04 HTVK1-RO-NO                 PIC 9(11).
**          ?閮箏???
         04 HTVK1-OR-NO                 PIC 9(2).
**          ?摨?
         04 HTVK1-RO-FL                 PIC X(9).
**          蝛箇??
      03 HTVK1-IP-NO2 REDEFINES HTVK1-IP-NO.
**       雿?思誘摨?
         04 HTVK1-PD-NO                 PIC 9(11).
**          雿摨?
         04 HTVK1-OD-NO                 PIC 9(11).
**          ?摨?
      03 HTVK1-DATA-IP.
         04 HTVK1-PT-SEX                PIC X(1).
**          ?批
         04 HTVK1-PT-ID                 PIC X(10).
**          頨思遢霅?
         04 HTVK1-PT-NAME               PIC X(12).
**          憪?
         04 HTVK1-IP-BED                PIC X(6).
**          ??摨?
         04 HTVK1-IP-CLSW               PIC X(1).
**          ?思誘靘?蝣?
         04 HTVK1-PT-IDNT               PIC X(4).
**          ?頨思遢
   02 HTVK1-VPL-DATA.
**    瑼ａ?鞈?
*$XFD USE GROUP
      03 HTVK1-VNO-NO                   PIC X(15).
**       ?炎瑼ａ?蝺刻?
      03 HTVK1-VNO-NO1 REDEFINES HTVK1-VNO-NO.
         04 HTVK1-V01-CD1               PIC X(1).
**          瑼ａ?蝺刻?蝺函Ⅳ??
         04 HTVK1-YEAR-CD1              PIC X(2).
**          镼踹?蝝撟游??拍Ⅳ
         04 HTVK1-SEQ-NO1               PIC 9(5).
**          ?炎瑼ａ?瘚偌??
         04 HTVK1-NO-FIL1               PIC X(7).
**          蝛箇??
      03 HTVK1-VNO-NO2 REDEFINES HTVK1-VNO-NO.
         04 HTVK1-V01-CD2               PIC X(1).
**          瑼ａ?蝺刻?蝺函Ⅳ??
         04 HTVK1-MON-CD2               PIC X(4).
**          ??撟湔?
         04 HTVK1-SEQ-NO2               PIC 9(4).
**          ?炎瑼ａ?瘚偌??
         04 HTVK1-NO-FIL2               PIC X(6).
**          蝛箇??
      03 HTVK1-VNO-NO3 REDEFINES HTVK1-VNO-NO.
         04 HTVK1-V01-CD3               PIC X(1).
**          瑼ａ?蝺刻?蝺函Ⅳ??
         04 HTVK1-DAT-CD3               PIC X(6).
**          ??撟湔???
         04 HTVK1-SEQ-NO3               PIC 9(3).
**          ?炎瑼ａ?瘚偌??
         04 HTVK1-NO-FIL3               PIC X(5).
**          蝛箇??

      03 HTVK1-VPL-CD                   PIC X(1).
**       瑼ａ?隞?Ⅳ
      03 HTVK1-VPL-NM                   PIC X(40).
**       瑼ａ?靘?
   02 HTVK1-AC-DATE                     PIC 9(7).
**    蝪賣?交?
   02 HTVK1-RP-DATE                     PIC 9(7).
**    ?勗??交?
   02 HTVK1-OK-DATE                     PIC 9(7).
**    撖拇?交?
*$XFD USE GROUP
   02 HTVK1-VR-DATA.
      03 HTVK1-VR-CD                    PIC X(1).
**       ?勗?摨膩憿?
      03 HTVK1-BC-SW                    PIC X(1).
**       ?臬??BLOOD CULTURE
      03 HTVK1-WK-SW                    PIC X(1).
**       雿平?挾
      03 HTVK1-VRNO                     PIC 9(1).
**       ?
      03 HTVK1-VR-DATE                  PIC 9(7).
**       瑼ａ??交?
      03 HTVK1-AC-TIME                  PIC 9(6).
**       蝪賣??
      03 HTVK1-AC-MAN                   PIC X(5).
**       蝪賣鈭箏
      03 HTVK1-RP-TIME                  PIC 9(6).
**       ?勗???
      03 HTVK1-RP-MAN                   PIC X(5).
**       ?勗?鈭箏
      03 HTVK1-OK-TIME                  PIC 9(6).
**       撖拇??
      03 HTVK1-OK-MAN                   PIC X(5).
**       撖拇鈭箏
      03 HTVK1-FIRST-YN                 PIC X(1).
**       ?活?勗?
      03 HTVK1-FINAL-YN                 PIC X(1).
**       鈭活?勗?
      03 HTVK1-APL-YN                   PIC X(1).
**       ?臬?喳
      03 HTVK1-APL-DATE                 PIC 9(7).
**       ?喳?交?
*$XFD USE GROUP, VAR-LENGTH
   02 HTVK1-FILL                        PIC X(83).
**    蝛箇??

** HTVK1-ALT-KEY1  = HTVK1-IP-DATE  + HTVK1-CHK-NO
** HTVK1-ALT-KEY2  = HTVK1-AC-DATE  + HTVK1-KEY
** HTVK1-ALT-KEY3  = HTVK1-RP-DATE  + HTVK1-KEY
** HTVK1-ALT-KEY4  = HTVK1-OK-DATE  + HTVK1-KEY
** HTVK1-ALT-KEY5  = HTVK1-VNO-NO   + HTVK1-KEY
** HTVK1-ALT-KEY6  = HTVK1-IP-NO    + HTVK1-VPL-CD   + HTVK1-VNO-NO +
**                   HTVK1-KEY
** HTVK1-ALT-KEY7  = HTVK1-PT-NO    + HTVK1-IP-DATE1 + HTVK1-KEY

** HTVK1-IP-CLSW : A> ?孵蝟餌絞, B> ?思誘蝟餌絞, C> 雿蝟餌絞, D> ?犖?交炎,
**                 E> ???交炎, F> ?思誘鋆, G> ?桃??唾撓, H> 銝鋆?


** HTVK1-WK-SW   : A> ?思誘??雿平, E> ?思誘蝪賣雿平, H> ?活?勗?雿平,
**                 J> 蝯??勗?雿平,
**                    IF HTCHK-RP-ST = "Y" MOVE "甇?虜?勗?" TO ?思誘瘚?
**                    IF HTCHK-RP-ST = "N" MOVE "?啣虜?勗?" TO ?思誘瘚?
**                 K> ?勗?撖拇雿平,
**                    IF HTCHK-OK-ST = "Y" MOVE "撖拇??" TO ?思誘瘚?
**                    IF HTCHK-OK-ST = "N" MOVE "撖拇?寥" TO ?思誘瘚?

** HTVK1-FINAL-YN: Y> ?蝯??

** HTVK1-APL-YN  : Y> 撌脩?? N> ?芰??

** HTVK1-APL-DATE: ?喳?交?

*COPY "HT_VK2.MST".
*************
* C-PY FILE : HT_VK2.MST   88/10/22     雿??喳?敶?
* HT_MVK2 LENGTH 180 BYTES 88/10/22     蝝啗?摰斗炎撽???蝝唳?(?拍 ????扯岫撽?
*************
 FD HTVK2-MST IS EXTERNAL.
 01 HTVK2-REC.
   02 HTVK2-KEY.
*$XFD USE GROUP
      03 HTVK2-CHK-NO.
**       瑼ａ??株?
         04 HTVK2-DPT-CD                PIC X(1).
         04 HTVK2-CLS-CD                PIC X(2).
         04 HTVK2-PR-SEQ                PIC 9(5).
      03 HTVK2-IP-DATE                  PIC 9(7).
**       ?思誘?交?
      03 HTVK2-VR-NUM                   PIC 9(1).
**       ?蝺刻?
   02 HTVK2-VR-VIRNO                    PIC X(7).
**    ???誨??
*$XFD USE GROUP, VAR-LENGTH
   02 HTVK2-VR-DATA.
      03 HTVK2-ANT-YN                   PIC X(1).
**       ?臬雿??扯岫撽?
      03 HTVK2-VR-ATE                   PIC X(1).
**       ??蝝??誨??
      03 HTVK2-VR-WAY                   PIC X(1).
**       ??閰阡??寞?
      03 HTVK2-VR-LEVEL                 PIC X(1).
**       蝔漲蝣?
      03 HTVK2-VR-COUNT.
**       ?賊??桐?
         04 HTVK2-VR-COUNT1             PIC X(1).
**          ( > < = ??)
         04 HTVK2-VR-COUNT2             PIC 9(6).
**          ?賊??桐?
      03 HTVK2-VR-FILLER                PIC X(10).
**       蝛箇??
*$XFD USE GROUP, VAR-LENGTH
   02 HTVK2-RP-DATA.
**    ?勗?鞈?
      03 HTVK2-RP-DOC                   PIC X(60).

**       ??批??餈?
      03 HTVK2-RP-FILLER                PIC X(10).
**       蝛箇??
   02 HTVK2-AC-DATE                     PIC 9(7).
**    蝪賣?交?
   02 HTVK2-IP-BED.
**    ?摨?
      03 HTVK2-BED-ROOM                 PIC X(04).
**       ?
      03 HTVK2-BED-NO                   PIC X(02).
**       摨?
   02 HTVK2-VPL-CD                      PIC X(01).
**    瑼ａ?隞??
*$XFD USE GROUP, VAR-LENGTH
   02 HTVK2-FILLER.
**       ?嗡?鞈?
      03 HTVK2-IP-CLSW                  PIC X(1).
**       ?思誘靘?蝣?
      03 HTVK2-PT-IDNT                  PIC X(4).
**       ?頨思遢
      03 HTVK2-FILLER1                  PIC X(54).
**       蝛箇??


** HTVK2-ALT-KEY1 = HTVK2-VR-VIRNO + HTVK2-AC-DATE  + HTVK2-CHK-NO   +
**                  HTVK2-IP-DATE  + HTVK2-VR-NUM

** HTVK2-ALT-KEY2 = HTVK2-BED-ROOM + HTVK2-VR-VIRNO + HTVK2-AC-DATE  +
**                  HTVK2-CHK-NO   + HTVK2-IP-DATE  + HTVK2-VR-NUM

** HTVK2-ALT-KEY3 = HTVK2-VPL-CD   + HTVK2-VR-VIRNO + HTVK2-AC-DATE  +
**                  HTVK2-CHK-NO   + HTVK2-IP-DATE  + HTVK2-VR-NUM

** HTVK2-ALT-KEY4 = HTVK2-AC-DATE  + HTVK2-CHK-NO   + HTVK2-IP-DATE  +
**                  HTVK2-VR-VIRNO + HTVK2-VR-NUM

** HTVK2-VR-WAY    : 1> DDM 瘜?2> MIC 瘜?
** HTVK2-VR-LEVEL  : 1> 甇?虜 2> 撠?3> 銝?4> 憭?
** HTVK2-VR-COUNT1 : 1> ??  2> >  3> <
** HTVK2-IP-CLSW : A> ?孵蝟餌絞, B> ?思誘蝟餌絞, C> 雿蝟餌絞, D> ?犖?交炎,
**                 E> ???交炎, F> ?思誘鋆, G> ?桃??唾撓, H> 銝鋆?

*COPY "HT_VK3.MST".
*************
* C-PY FILE : HT_VK3.MST   88/10/22     雿??喳?敶?
* HT_MVK3 LENGTH 100 BYTES 88/10/22     蝝啗?摰斗炎撽???蝝唳?(?拍 ????扯岫撽?
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

**          ?思誘?交?
      03 HTVK3-VR-NUM                   PIC 9(1).
*        >?蝺刻?
      03 HTVK3-VR-ANTNUM                PIC 9(2).
*        >??閰阡?蝺刻?
   02 HTVK3-VR-VIRNO                    PIC X(7).
*     >??
   02 HTVK3-VR-DATA1.
      03 HTVK3-VR-ANTNO                 PIC X(5).
*        >??蝝誨??
*$XFD USE GROUP, VAR-LENGTH
   02 HTVK3-VR-DATA2.
      03 HTVK3-VR-MIC.
*        >MIC 蝔?摨?
         04 HTVK3-VR-MIC1               PIC X.
         04 HTVK3-VR-MIC2               PIC 9(2).
*        >MIC ??蝝?摨?
         04 HTVK3-VR-MIC3               PIC X(6).
      03 HTVK3-VR-DDM                   PIC X(2).
*        >DDM?∟??賢?
      03 HTVK3-SUSNO                    PIC X.
*        >??隞??
      03 HTVK3-VR-FILLER                PIC X(6).
**       蝛箇??
   02 HTVK3-AC-DATE                     PIC 9(7).
**    蝪賣?交?
*$XFD USE GROUP, VAR-LENGTH
   02 HTVK3-FILLER.
**       ?嗡?鞈?
      03 HTVK3-IP-CLSW                  PIC X(1).
**       ?思誘靘?蝣?
      03 HTVK3-PT-IDNT                  PIC X(4).
**       ?頨思遢
      03 HTVK3-FILLER1                  PIC X(40).
**       蝛箇??

** HTVK3-ALT-KEY1  = HTVK3-VR-VIRNO + HTVK3-VR-ANTNO + HTVK3-AC-DATE  +
**                   HTVK3-CHK-KEY  + HTVK3-VR-NUM   + HTVK3-VR-ANTNUM

** HTVK3-VR-MIC1  : 1> ??  2> >  3> <
** HTVK3-SUSNO    : S> Susceptible  M> Moderately  I> Intermediate  R> Risistant


*COPY "HT_VK4.MST".
*************
* C-PY FILE : HT_VK4.MST   88/07/25     雿??喳?敶?
* HT_MVK4 LENGTH 805 BYTES 89/04/11     蝝啗?摰斗炎撽???蝝唳?(?拍 ????岫撽?
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

**       ?思誘?交?
*$XFD USE GROUP
      03 HTVK4-RP-CD.
         04 HTVK4-V03-CD                PIC X(2).
**          ?勗?憿?
      03 HTVK4-SEQ-NM                   PIC 9(1).
**       ?酉摨?
   02 HTVK4-AC-DATE                     PIC 9(7).
**    蝪賣?交?
   02 HTVK4-RESULT                      PIC X(1).
**    瑼ａ?蝯?
   02 HTVK4-RP-DATA.
**    ?勗?鞈?
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
**       ?嗡?鞈?
      03 HTVK4-IP-CLSW                  PIC X(1).
**       ?思誘靘?蝣?
      03 HTVK4-PT-IDNT                  PIC X(4).
**       ?頨思遢
      03 HTVK4-FIRST-YN                 PIC X(1).
**       銵瘨脣擗?甈∪??
      03 HTVK4-FILLER1                  PIC X(53).
**       蝛箇??

** HTVK4-ALT-KEY1 = HTVK4-RP-CD    HTVK4-AC-DATE
**                  HTVK4-CHK-NO   HTVK4-IP-DATE.

** HTVK4-RESULT嚗> ?賣批??? N> ?唳批???


*
*COPY "HM_SIDX.MST" REPLACING ==HMSID-MST.== BY ==HMSID-MST IS EXTERNAL.==.
*<< BOF OF HM_SIDX.MST >>*******************************************************
*------------------------------------------------------------------------------*
*   瑼?: 蝟餌絞蝞∠??摰儔瑼?                                                  *
*   ?: SYBASE                                                               *

*   撱箸??? 1996/11/01   靽格?? 1996/11/01      ?瑕漲: 212      雿? ?喃???  *
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
*       蝟餌絞隞?? (ex. "HM":?怠飛?弦蝯梯?, "TV": 'T'瑼ａ?蝘? 'V'敺桃??拙恕)
        03  HMSID-SYS-CODE.
*           >??撅
            04  HMSID-SYS-CODE1                       PIC X.
*           >隤??
            04  HMSID-SYS-CODE2                       PIC X.
    02  HMSID-DATA.
*       >蝟餌絞?迂 (ex. ?怠飛?弦瑼?蝭拚蝞∠?蝟餌絞)
        03  HMSID-SYS-NAME                            PIC X(40).
*       >蝟餌絞蝞∠??誨??
        03  HMSID-USER-NO                             PIC X(10).
*       >蝟餌絞蝞∠???蝣?
        03  HMSID-USER-PASS                           PIC X(10).
*((XFD USE GROUP, VAR-LENGTH))
        03  HMSID-REMARK.
*       >鞈??批捆 (?澆??蝔?銝剝??啣?摰儔)
            04  HMSID-REMARK1                         PIC X(60).
            04  HMSID-REMARK2                         PIC X(60).
            04  HMSID-REMARK3                         PIC X(60).
*<< BOF OF HM_SIDX.MST >>*******************************************************






*
*COPY "HT_VHK.MST" REPLACING ==HTVHK-MST.== BY ==HTVHK-MST IS EXTERNAL.==.
******************
* 敺桃??拙?蜓瑼?*
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
*       瑼ａ??交?
        03  HTVHK-CK-DATE                         PIC 9(07).
*((XFD USE GROUP))
*       ?格??Ⅳ
        03  HTVHK-NO.
            04  HTVHK-NO1                         PIC X(03).
            04  HTVHK-NO2                         PIC 9(05).
    02  HTVHK-DATA.
*       鞈?靘? (I:雿, O:?閮? W:?交炎)
        03  HTVHK-KEY-SW                          PIC X.
*       (雿|?閮??交?
        03  HTVHK-ADATE                           PIC 9(07).
*       (雿|?閮?摨?
        03  HTVHK-SEQ                             PIC 9(04).
*       ?摨?
        03  HTVHK-SEQNO                           PIC 9(11).
*       ?風?Ⅳ
        03  HTVHK-PATNO                           PIC 9(08).
*       ??桐? (霅瑞?蝡?
        03  HTVHK-BEDUNIT                         PIC X(05).
*       瑼ａ?摰?蝣?
        03  HTVHK-CCODE                           PIC X(1).
*       撌脣??? (Y:撌脣???
        03  HTVHK-NOPRINT                         PIC X(1).
*((XFD USE GROUP, VAR-LENGTH))
    02  HTVHK-MEMO.
*       ?膩?辣?批捆
        03  HTVHK-MEMO1                           PIC X(76).
        03  HTVHK-MEMO2                           PIC X(76).
        03  HTVHK-MEMO3                           PIC X(76).

*------------------------------------------------------------------------------*
* P.S.  1> EVALUATE HTVHK-KEY-SW                                               *
*                   WHEN 'I'                                                   *
*                        ICB-IPD-NO  (雿摨?) = HTVHK-ADATE + HTVHK-SEQ      *
*                        ICB-ODR-NO  (?摨?) = HTVHK-SEQNO                  *
*                   WHEN 'O'                                                   *
*                        ODR-NO      (?閮箏??? = HTVHK-ADATE + HTVHK-SEQ      *
*                        ODR-ODR-SEQ (?摨?) = HTVHK-SEQNO = "01"           *
*          END-EVALUATE.                                                       *
*------------------------------------------------------------------------------*

*COPY "HT_VHR.MST" REPLACING ==HTVHR-MST.== BY ==HTVHR-MST IS EXTERNAL.==.
**************************************
* 敺桃??拙???摨?/瑼ａ?蝺刻?閮?瑼?*
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
*           鞈?靘? (I:雿, O:?閮? W:?交炎)

            04  HTVHR-KEY-SW                      PIC X.
*           (雿|?閮??交?
            04  HTVHR-ADATE                       PIC 9(07).
*           (雿|?閮?摨?
            04  HTVHR-SEQ                         PIC 9(04).
*           ?摨?
            04  HTVHR-SEQNO                       PIC 9(11).
*       瑼ａ?蝺刻?(??券????
        03  HTVHR-SPN-KEY                         PIC X(15).
    02  HTVHR-DATA.
*((XFD USE GROUP))
        03  HTVHR-VHK-KEY.
*           瑼ａ??交?
            04  HTVHR-CK-DATE                     PIC 9(07).
*           ?格??Ⅳ
            04  HTVHR-NO.
                05  HTVHR-NO1                     PIC X(03).
                05  HTVHR-NO2                     PIC 9(05).
*((XFD USE GROUP, VAR-LENGTH))
*   ??蝛箇??
    02 HTVHR-FILLER                               PIC X(100).

*COPY "HT_VH1.MST" REPLACING ==HTVH1-MST.== BY ==HTVH1-MST IS EXTERNAL.==.
********************************************************************************
* 敺桃??拙??撅祆? -- KEY?????孵???HT_MVHK ?詨?                            *
*   ?格??Ⅳ = HTVH1-NO2 = 99999 - HTVHK-NO2                                   *
*------------------------------------------------------------------------------*
* RECORD KEY IS HTVH1-KEY (?冽?Ｙ??啣?? ?格瑼ａ??梯”)                       *
* ALTERNATE KEY IS HTVH1-KEY-ALT1 = HTVH1-IDNO  HTVH1-NO                       *
*                                               HTVH1-CK-DATE (?冽?交炎)       *
* ALTERNATE KEY IS HTVH1-KEY-ALT2 = HTVH1-IDNO  HTVH1-KEY     (?冽?交炎)       *
********************************************************************************
*   >?冽 HTRE10KF, HTRE11KF
 FD  HTVH1-MST.
 01  HTVH1-REC.
    02  HTVH1-KEY.
*       >瑼ａ??交?
        03  HTVH1-CK-DATE                         PIC 9(07).
*((XFD USE GROUP))
*       >?格??Ⅳ => HTVH1-NO2 = 99999 - HTVHK-NO2
        03  HTVH1-NO.
            04  HTVH1-NO1                         PIC X(03).
            04  HTVH1-NO2                         PIC 9(05).
    02  HTVH1-DATA1.
*       >?頨思遢摮?/憭?Ｚ?蝣?
        03  HTVH1-IDNO                            PIC X(10).
    02  HTVH1-DATA2.
*       >瑼ａ???
        03  HTVH1-CK-TIME                         PIC 9(06).
*       >瑼ａ?隞?Ⅳ
        03  HTVH1-VPL-CD                          PIC X.
*       >瑼ａ?鈭箏
        03  HTVH1-CK-MAN                          PIC X(05).


*COPY "HT_VPL.MST" REPLACING ==HTVPL-MST.== BY ==HTVPL-MST IS EXTERNAL.==.
*------------------------------------------------------------------------------*

*   瑼?: 敺桃??拙恕瑼ａ?瑼ａ?瑼?                                                  *
*   ?: SYBASE                                                               *
*   撱箸???              靽格??                 ?瑕漲: 22       雿? ?喃???  *
*------------------------------------------------------------------------------*
*   RECORD KEY   IS HTVPL-KEY                                                  *
*   FILE STATUS  IS W-FS-HTVPL                                                 *
*------------------------------------------------------------------------------*
*   蝟餌絞: 敺桃??拙恕蝞∠?雿平                                                     *
*   蝔?: HTRE10KF                                                             *
*------------------------------------------------------------------------------*
 FD  HTVPL-MST.
 01  HTVPL-REC.
    02  HTVPL-KEY.
*((XFD USE GROUP))
*       >瑼ａ?隞??
        03  HTVPL-NO.
*          >瑼ａ?瑼Ｘ蝘恕蝪∠Ⅳ
           04  HTVPL-DPT                PIC X(1).
*          >瑼ａ?隞?Ⅳ
           04  HTVPL-CD                 PIC X(1).
    02  HTVPL-DATA.
*       >瑼ａ??迂
        03  HTVPL-NAME                  PIC X(20).









*COPY "HT_ANT.MST".
*******************
*敺桃??拙恕??蝝? *
*******************
*-->?冽HTBAFKF3, HTBAFKF4, HTBAFKF5,
 FD  HTANT-MST IS EXTERNAL.
 01  HTANT-REC.
    02  HTANT-KEY.
*           ??蝝誨??
        03  ANT-ANTNO            PIC X(5).
*((XFD USE GROUP, VAR-LENGTH))
    02  HTANT-DATA.
*           ?亙?隞??
        03  ANT-DRUGNO           PIC X(6).
*           ??蝝?蝔?
        03  ANT-DRUGNAME         PIC X(40).
*COPY "HT_ATE.MST".
*------------------------------------------------------------------------------*
*   瑼?: 敺桃??拙恕??蝝見?踵?                                                 *
*   ?: SYBASE                                                               *
*   撱箸???              靽格??                 ?瑕漲: 51       雿? ?喃???  *
*------------------------------------------------------------------------------*
*   RECORD KEY   IS HTATE-KEY                                                  *
*   FILE STATUS  IS W-FS-HTATE                                                 *
*------------------------------------------------------------------------------*

*   蝟餌絞: 敺桃??拙恕蝞∠?雿平                                                     *
*   蝔?: HTBA40KF, HTRE10KF                                                   *
*------------------------------------------------------------------------------*
 FD  HTATE-MST IS EXTERNAL.
 01  HTATE-REC.
    02  HTATE-KEY.
*       蝯?隞??
        03  ATE-TENO             PIC X(1).
*((VAR-LENGTH))
    02  HTATE-DATA.
*       蝯??迂
        03  ATE-NAME             PIC X(20).

*COPY "HT_ATC.MST".
*------------------------------------------------------------------------------*
*   瑼?: 敺桃??拙恕??蝝見?輻???                                             *
*   ?: SYBASE                                                               *
*   撱箸???              靽格??                 ?瑕漲: 8        雿? ?喃???  *
*------------------------------------------------------------------------------*
*   RECORD KEY   IS HTATC-KEY                                                  *
*   FILE STATUS  IS W-FS-HTATC                                                 *
*------------------------------------------------------------------------------*
*   蝟餌絞: 敺桃??拙恕蝞∠?雿平                                                     *
*   蝔?: HTBA40KF, HTRE10KF                                                   *
*------------------------------------------------------------------------------*
 FD  HTATC-MST IS EXTERNAL.
 01  HTATC-REC.
    02  HTATC-KEY.
*       蝯?隞??
        03  ATC-TENO             PIC X(1).
*       ??蝝楊??瘚偌??
        03  ATC-NO               PIC 9(2).
    02  HTATC-DATA.
*       ??蝝誨??
        03  ATC-ANTNO            PIC X(5).

*COPY "HT_VIR.MST".
*------------------------------------------------------------------------------*
*   敺桃??拙恕????                                                           *
*   撱箸??? 1995/09/01           靽格?? 1996/10/07                            *
*------------------------------------------------------------------------------*
*   蝟餌絞: 敺桃??? ?Ｗ??                                                     *
*   蝔?: HTBA20KF, HTBA20IF, HTBA50KF, HTRE20KF, HTIP10KF                     *
*------------------------------------------------------------------------------*
*   RECORD    KEY IS HTVIR-KEY                                                 *
*   ALTERNATE KEY IS HTVIR-KEY-ALT1 = VIR-CODE VIR-VIRNO                       *
*   ALTERNATE KEY IS HTVIR-KEY-ALT2 = VIR-GP VIR-GENUS VIR-SPECIES VIR-VIRNO   *
*   FILE STATUS   IS W-FS-HTVIR                                                *
*------------------------------------------------------------------------------*
 FD  HTVIR-MST IS EXTERNAL.
 01  HTVIR-REC.
    02  HTVIR-KEY.
*       ?車隞??
        03  VIR-VIRNO            PIC X(7).
    02  HTVIR-DATA.
*       ?車蝪∠Ⅳ
        03  VIR-CODE             PIC X(4).

*       ?車撅砍?
        03  VIR-GENUS            PIC X(20).
*       ?車蝔株???
        03  VIR-SPECIES          PIC X(20).
*       ?車蝪∠迂
        03  VIR-NAME             PIC X(30).
*       ?車憿
        03  VIR-GP               PIC X(3).

*COPY "HT_MIC.MST".
***********************
*敺桃??拙恕MIC蝔?瑼?
***********************
*-->?冽HTBAFKF6,
 FD  HTMIC-MST IS EXTERNAL.
 01  HTMIC-REC.
    02  HTMIC-KEY.
*       蝔????
        03  MIC-NO               PIC 9(2).
    02  HTMIC-DATA.
*       蝔???
        03  MIC-TIMES            PIC 999V99.
*COPY "HT_DDM.MST".
*------------------------------------------------------------------------------*
*   瑼?: DDM??隞??撠瑼?                                                   *
*   ?: SYBASE                                                               *
*   撱箸???              靽格??                 ?瑕漲: 24       雿? ?喃???  *
*------------------------------------------------------------------------------*
*   RECORD KEY   IS HTDDM-KEY                                                  *
*   FILE STATUS  IS W-FS-HTDDM                                                 *
*------------------------------------------------------------------------------*
*   蝟餌絞: 敺桃??拙恕蝞∠?雿平                                                     *
*   蝔?: HTBA50KF, HTRE10KF                                                   *
*------------------------------------------------------------------------------*
 FD  HTDDM-MST IS EXTERNAL.
 01  HTDDM-REC.
*((XFD USE GROUP))
    02  HTDDM-KEY.
*       ??蝝誨??
        03  DDM-ANTNO            PIC X(5).
*       ???誨??
        03  DDM-VIRNO            PIC X(7).
        03  DDM-VGP REDEFINES DDM-VIRNO.
            04  DDM-VGP-NO       PIC X(3).
            04  DDM-VGP-FILL     PIC X(4).
*       ?∟??賜敺?嚚?
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

*   瑼?: 敺桃??拙恕瑼ａ?蝯?銝餅?                                                 *
*   ?: SYBASE                                                               *
*   撱箸???              靽格??                 ?瑕漲: 40       雿? ?喃???  *
*------------------------------------------------------------------------------*
*   RECORD KEY   IS HTVRT-KEY                                                  *
*   FILE STATUS  IS W-FS-HTVRT                                                 *
*------------------------------------------------------------------------------*
*   蝟餌絞: 敺桃??拙恕蝞∠?雿平                                                     *
*   蝔?: HTRE10KF                                                             *
*------------------------------------------------------------------------------*
 FD  HTVRT-MST IS EXTERNAL.
 01  HTVRT-REC.
    02  HTVRT-KEY.
*       瑼ａ??交?
        03  VRT-CK-DATE          PIC 9(7).
*((XFD USE GROUP))
*       瑼ａ??株?
        03  VRT-NO.
            04  VRT-NO1          PIC X(3).
            04  VRT-NO2          PIC 9(5).
*       ?蝺刻?
        03  VRT-VNO              PIC 9.
    02  HTVRT-DATA.
*       ?勗??交?
        03  VRT-TDATE            PIC 9(7).
*((XFD USE GROUP))
    02  HTVRT-DATA1.
*       ??蝝??誨??
        03  VRT-ANTTE            PIC X(1).
*       ??閰阡??寞?
        03  VRT-TMETHOD          PIC X(1).
*       ???誨??
        03  VRT-VIRNO            PIC X(7).
*       蝔漲蝣?
        03  VRT-LEVEL            PIC X(1).
*       ?賊??桐?
        03  VRT-COUNT.
            04  VRT-COUNT1       PIC X(1).
            04  VRT-COUNT2       PIC 9(6).


*COPY "HT_VR1.MST".
*------------------------------------------------------------------------------*
*   瑼?: 敺桃??拙恕??蝝??岫撽?                                             *
*   ?: SYBASE                                                               *
*   撱箸???              靽格??                 ?瑕漲: 30       雿? ?喃???  *
*------------------------------------------------------------------------------*
*   RECORD KEY   IS HTVR1-KEY                                                  *
*   FILE STATUS  IS W-FS-HTVR1                                                 *
*------------------------------------------------------------------------------*
*   蝟餌絞: 敺桃??拙恕蝞∠?雿平                                                     *
*   蝔?: HTRE10KF                                                             *
*------------------------------------------------------------------------------*
 FD  HTVR1-MST EXTERNAL.
 01  HTVR1-REC.
*((XFD USE GROUP))
    02  HTVR1-KEY.

*       >瑼ａ??交?
        03  VR1-CK-DATE                             PIC 9(7).
*       >瑼ａ??株?
        03  VR1-NO.
            04  VR1-NO1                             PIC X(3).
            04  VR1-NO2                             PIC 9(5).
*       >?蝺刻?
        03  VR1-VNO                                 PIC 9.
*       >??閰阡?蝺刻?
        03  VR1-TNO                                 PIC 99.
    02  HTVR1-DATA.
*       >??蝝誨??
        03  VR1-ANTNO                               PIC X(5).
*       >MIC蝔?摨?
        03  VR1-MICT                                PIC X99.
        03  VR1-ZONES REDEFINES VR1-MICT.
*           >DDM?∟??賢?
            04  VR1-ZONE                            PIC X(2).
*           >蝛箇?? 銝
            04  VR1-ZONE-FIL                        PIC X(1).
*       >??隞??
        03  VR1-SUSNO                               PIC X.


*COPY "HT_WRK.MST".
*************
* C-PY FILE : HT_WRK.MST 871202-871207  雿?雓?鞎?
* HT_MWRK LENGTH 100 BYTES -- RDB       ?券?撌乩?摨?瑼?FOR ?◣?砍)
*************
 FD HTWRK-MST IS EXTERNAL.
 01 HTWRK-REC.
   02 HTWRK-KEY.
      03 HTWRK-WRK-NO.
**       ?券?撌乩?摨?
         04 HTWRK-DPT-NO                PIC X(2).
**          ?炎?券?隞??
         04 HTWRK-CRE-DATE              PIC 9(8).
**          ?Ｙ??交?(镼踵?)
         04 HTWRK-CRE-SEQ               PIC 9(4).
**          撌乩?摨?瘚偌??
   02 HTWRK-DATA.
*$XFD USE GROUP
      03 HTWRK-DATA-SPN.
**       ??唳炎擃楊????
         04 HTWRK-SPN-NO                PIC X(15).
**          ?炎瑼ａ?蝺刻?
         04 HTWRK-SPN-DATE              PIC 9(7).
**          蝺刻??詨??Ｙ??交? = 10000000 - 蝺刻?撖阡??Ｙ??交?
*$XFD USE GROUP, VAR-LENGTH
      03 HTWRK-DATA-OTH.
         04 HTWRK-CRE-TIME              PIC 9(6).
**          ?Ｙ???
         04 HTWRK-OBSERVE1              PIC X(10).
**          閫皜祆?敶Ｖ?
         04 HTWRK-OBSERVE2              PIC X(10).
**          閫皜祆?敶Ｖ?
         04 HTWRK-OBSERVE3              PIC X(10).

**          閫皜祆?敶Ｖ?
         04 HTWRK-FILLER                PIC X(28).

** HTWRK-ALT-KEY1 = HTWRK-DATA-SPN + HTWRK-DPT-NO
*COPY "HT_CSP.MST".
*************
* C-PY FILE : HT_CSP.MST   84/04/18     雿?雓?鞎?
* HT_MCSP LENGTH 100 BYTES 86/10/10     ?思誘?格炎擃?
*************
 FD HTCSP-MST IS EXTERNAL.
 01 HTCSP-REC.
*$XFD USE GROUP
   02 HTCSP-KEY.
      03 HTCSP-CHK-NO.
**       ?思誘?株?
         04 HTCSP-CLS-NO.
**          瑼ａ?瑼Ｘ憿隞??
            05 HTCSP-DPT-CD             PIC X(1).
**             瑼ａ?瑼Ｘ蝘恕蝪∠Ⅳ
            05 HTCSP-CLS-CD             PIC X(2).
**             瑼ａ?瑼Ｘ憿蝣?
         04 HTCSP-PR-SEQ                PIC 9(5).
**          ?瘚偌蝣?
      03 HTCSP-IP-DATE                  PIC 9(7).
**       ?思誘?交?
      03 HTCSP-SPB-CD.
         04 HTCSP-SPL-CD                PIC X(1).
**          瑼ａ?隞?Ⅳ
         04 HTCSP-BTL-CD                PIC X(1).
**          摰孵隞?Ⅳ
   02 HTCSP-DATA.
**    ?格?鞈?
      03 HTCSP-DATA-IP.
**       ?思誘鞈?
*$XFD USE GROUP, VAR-LENGTH
         04 HTCSP-IP-PT.
**          ?鞈?                    -- ALT-KEY
            05 HTCSP-SPN-SW             PIC X(1).
**             瑼ａ???Ⅳ
            05 HTCSP-PT-ID              PIC X(10).
**             頨思遢摮?
            05 HTCSP-PT-ND REDEFINES HTCSP-PT-ID.
               06 HTCSP-PT-NO           PIC 9(8).
**                ?風?Ⅳ
               06 HTCSP-PT-SP           PIC X(2).
**                蝛箇??
*$XFD USE GROUP, VAR-LENGTH
         04 HTCSP-IP-DATA.
            05 HTCSP-TP-DATE            PIC 9(7).
**             ??瑼ａ??交?
            05 HTCSP-RP-DATE            PIC 9(7).
**             ???炎?交?
            05 HTCSP-IP-RKNO            PIC X(10).
**             瑼ａ??思誘?酉蝺刻?
*$XFD USE GROUP
      03 HTCSP-DATA-SPN.
**       ??唳炎擃楊????

         04 HTCSP-SPN-NO                PIC X(15).
**          ?炎瑼ａ?蝺刻?
         04 HTCSP-SPN-DATE              PIC 9(7).
**          蝺刻??詨??Ｙ??交? = 10000000 - 蝺刻?撖阡??Ｙ??交?
*$XFD USE GROUP, VAR-LENGTH
      03 HTCSP-DATA-OTH.
         04 HTCSP-REJ-SW                PIC X(1).
**          瑼ａ???Ⅳ
         04 HTCSP-DATA-AC.
**          蝪賣鞈?                    -- 86/03/27
            05 HTCSP-AC-DATE            PIC 9(7).
**             蝪賣?交?
            05 HTCSP-AC-TIME            PIC 9(6).
**             蝪賣??
            05 HTCSP-AC-MAN             PIC X(5).
**             蝪賣鈭箏
         04 HTCSP-AC-DATA REDEFINES  HTCSP-DATA-AC.
            05 HTCSP-AC-FILL            PIC X(1).
**             蝛箇??
            05 HTCSP-REJ-DATE           PIC 9(7).
**             ????                -- 86/10/10
            05 HTCSP-AC-RKNO            PIC X(10).
**             瑼ａ????閮餌?隤楊??
         04 HTCSP-SRC-SW                PIC X(1).
**          瑼ａ?蝺刻?靘?蝣?
         04 HTCSP-FILLER                PIC X(8).

** HTCSP-ALT-KEY  = HTCSP-IP-PT    + HTCSP-KEY
** HTCSP-ALT-KEY1 = HTCSP-DATA-SPN + HTCSP-KEY

** HTCSP-SPN-SW  : Y> 瑼ａ?撌脫?蝷箏?璅?
** HTCSP-REJ-SW  : Y> 瑼ａ???? INITIALIZE HTCSP-SPN-SW & HTCSP-DATA-AC
** HTCSP-IP-RKNO : MOVE "B1"          TO W-EDT-RPT-TY
**                 MOVE "1"           TO W-EDT-CPY-SW
**                 MOVE "C,M,D,I"     TO W-EDT-FUN-SW
**                 MOVE HTCSP-IP-MAN  TO W-EDT-USR-NO
**                 MOVE HTCSP-DPT-CD  TO W-EDT-CPY-KY
**                 MOVE HTCSP-IP-RKNO TO W-EDT-RPT-NO
**                 LINK HT_EDT.LNK &  CALL "HTEDTCF" USING W-EDT-TABLE

** 雿平隤芣?嚗?
**              =============== ================ =====================
**               鞈???????    雿?璆???畾?     鞈???靘?皞?
**              =============== ================ =====================
**               HTCSP-DATA-IP   ?交炎,?思誘,?孵   ?交炎,?思誘,?孵蝟餌絞
**               HTCSP-RP-DATE   ?交炎,?思誘,?孵   HTCSP-TP-DATE
**               HTCSP-DATA-SPN  瑼ａ??見?內     霅瑞?蝡?瑼ａ?蝟餌絞
**               HTCSP-RP-DATE   瑼ａ??見蝯?     霅瑞?蝡頂蝯?

*> ???賊?瑼?
*COPY    "HX_SRM.MST".
*************
* C-PY FILE : HX_SRM.MST    90/10/10    雿?雓?鞎?
* HX_MSRM LENGTH 250 BYTES  90/11/01    瑼Ｘ摰支誨??蝢拇?
*************
 FD HXSRM-MST IS EXTERNAL.
 01 HXSRM-REC.

*$XFD USE GROUP
   02 HXSRM-ROM-NO.
**    瑼Ｘ摰支誨??
      03 HXSRM-DPT-CD                   PIC X(1).
**       瑼Ｘ蝘恕蝪∠Ⅳ
      03 HXSRM-ROM-CD                   PIC X(2).
**       瑼Ｘ摰斤陛蝣?
   02 HXSRM-DATA.
      03 HXSRM-SRL-NO                   PIC X(4).
**       瑼Ｘ摰支?蝵桐誨??                -- HXSRL-SRL-NO
*$XFD USE GROUP, VAR-LENGTH
      03 HXSRM-DATA-OTH.
         04 HXSRM-ROM-NM                PIC X(20).
**          瑼Ｘ摰斤陛蝔?
         04 HXSRM-SMH-NO                PIC X(8).
**          雿輻??其誨??               -- HXSMH-SMH-NO (90/11/01)
         04 HXSRM-FILLER                PIC X(215).
**          蝛箇??

** HXSRM-ALT-KEY = HXSRM-SRL-NO + HXSRM-ROM-NO
*COPY    "HX_SCT.MST".
*************
* C-PY FILE : HX_SCT.MST    90/10/10    雿?雓?鞎?
* HX_MSCT LENGTH 250 BYTES  90/10/31    瑼Ｘ?璅?撌交?閮剖?瑼?
*************
 FD HXSCT-MST IS EXTERNAL.
 01 HXSCT-REC.
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCT-KEY.
      03 HXSCT-ITM-NO.
**       瑼Ｘ蝝圈????誨??
         04 HXSCT-CLS-NO                PIC X(3).
**          瑼Ｘ憿隞??
         04 HXSCT-ITM-GRP               PIC X(6).
**          瑼Ｘ?隞?Ⅳ
      03 HXSCT-SMH-NO                   PIC X(8).
**       ??其誨??
      03 HXSCT-DCT-NO                   PIC X(5).
**       瑼Ｘ?怠葦?∪極隞?Ⅳ
      03 HXSCT-KEY-FIL                  PIC X(17).
**       蝛箇??
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCT-DATA.
      04 HXSCT-STD-TIM                  PIC 9(3).
**       璅?撌交?(??
      04 HXSCT-FILLER                   PIC X(208).
**       蝛箇??

** HXSCT-ITM-GRP REFER TO HTCLS-MCW-TY (a,d) OF HT_CLS.MST
** HXSCT-SMH-NO  REFER TO HTCLS-MCW-TY (b)   OF HT_CLS.MST
** HXSCT-DCT-NO  REFER TO HTCLS-MCW-TY (c)   OF HT_CLS.MST
*COPY    "HX_SCD.MST".
*************
* C-PY FILE : HX_SCD.MST    90/11/01    雿?雓?鞎?
* HX_MSCD LENGTH 250 BYTES  90/11/01    瑼Ｘ憿瑼Ｘ?怠葦?交??剜?
*************
 FD HXSCD-MST IS EXTERNAL.

 01 HXSCD-REC.
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCD-KEY.
      03 HXSCD-CLS-NO                   PIC X(3).
**       瑼Ｘ憿隞??                   -- HTCLS-CLS-NO
      03 HXSCD-SCH-DATE                 PIC 9(7).
**       ?炎?交?                       -- HXSCW-WEEK-CD
      03 HXSCD-TURN-CD                  PIC X(1).
**       ?隞?Ⅳ                       -- HXSCW-TURN-CD
      03 HXSCD-SRM-CD                   PIC X(2).
**       瑼Ｘ摰斤陛蝣?                    -- HXSCW-SRM-CD
      03 HXSCD-SRM-SEQ                  PIC 9(1).
**       瑼Ｘ摰文?函Ⅳ                   -- HXSCW-SRM-SEQ
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCD-KEY3.
      03 HXSCD-SCH-DATE1                PIC 9(7).
**       ?炎?交?
      03 HXSCD-TURN-CD1                 PIC X(1).
**       ?隞?Ⅳ                       -- NID-CODE (NID-ID = '0506')
      03 HXSCW-KEY3-FILLER              PIC X(22).
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCD-KEYA.
      03 HXSCW-KEYA-FILLER              PIC X(30).

   02 HXSCD-DATA.
      03 HXSCD-DCT-NCD                  PIC X(5).
**       瑼Ｘ?怠葦?∪極隞?Ⅳ               -- HXSCW-DCT-CD1 OR HXSCW-DCT-CD2
      03 HXSCD-DCT-OCD                  PIC X(5).
**       ??瑼ａ撣怠撌乩誨蝣?            -- HXSCD-DCT-NCD
*$XFD USE GROUP, VAR-LENGTH
      03 HXSCD-DATA-OTH.
         04 HXSCD-BGN-TIM               PIC 9(4).
**          瑼Ｘ????                -- HXSCW-BGN-TIM1 OR HXSCW-BGN-TIM2
         04 HXSCD-END-TIM               PIC 9(4).
**          瑼Ｘ蝯???                -- HXSCW-END-TIM1 OR HXSCW-END-TIM2
         04 HXSCD-MAX-QTY               PIC 9(3).
**          瑼Ｘ?憭折?                  -- HXSCW-MAX-QTY1 OR HXSCW-MAX-QTY2
         04 HXSCD-SMH-NO                PIC X(8).
**          雿輻??其誨??               -- HXSRM-SMH-NO
         04 HXSCD-CNT-QTY               PIC 9(3).
**          瑼Ｘ撌脫???
         04 HXSCD-FILLER                PIC X(204).
**          蝛箇??

** HXSCD-ALT-KEY1 = HXSCD-DCT-NCD + HXSCD-KEY
** HXSCD-ALT-KEY2 = HXSCD-DCT-OCD + HXSCD-KEY
** HXSCD-ALT-KEY3 = HXSCD-KEY3    + HXSCD-KEY
** HXSCD-ALT-KEYA = HXSCD-KEYA    + HXSCD-KEY


*COPY    "HX_SCC.MST".
*************
* C-PY FILE : HX_SCC.MST    90/11/02    雿?雓?鞎?
* HX_MSCC LENGTH 73 BYTES   90/11/02    瑼Ｘ?怠葦頝券??交?瑼?
*************
 FD HXSCC-MST IS EXTERNAL.
 01 HXSCC-REC.

*$XFD USE GROUP
   02 HXSCC-KEY.
      03 HXSCC-DCT-NCD                  PIC X(5).
**       瑼Ｘ?怠葦?∪極隞?Ⅳ               -- HXSCD-DCT-NCD
      03 HXSCC-SCH-DATE                 PIC 9(7).
**       ?炎?交?                       -- HXSCD-SCH-DATE
      03 HXSCC-TURN-CD                  PIC X(1).
**       ?隞?Ⅳ                       -- HXSCD-TURN-CD
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCC-DATA.
      03 HXSCC-DATA-CLS OCCURS 10 TIMES.
         04 HXSCC-CLS-NO                PIC X(3).
**          瑼Ｘ憿隞??                -- HTCLS-CLS-NO
         04 HXSCC-SRM-CD                PIC X(2).
**          瑼Ｘ摰斤陛蝣?                 -- HXSCD-SRM-CD
         04 HXSCC-SRM-SEQ               PIC 9(1).
**          瑼Ｘ摰文?函Ⅳ                -- HXSCD-SRM-SEQ
*COPY    "HX_SCM.MST".
*************
* C-PY FILE : HX_SCM.MST    90/11/01    雿?雓?鞎?
* HX_MSCM LENGTH 26 BYTES   90/11/02    ??交?瑼Ｘ??啁????
*************
 FD HXSCM-MST IS EXTERNAL.
 01 HXSCM-REC.
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCM-KEY.
      03 HXSCM-SCC-SW                   PIC X(1).
**       瑼Ｘ?怠葦頝券??交?蝣?Y/N)
      03 HXSCM-SCC-KEY.
         04 HXSCM-SCC-DATE              PIC 9(7).
**          ?炎?交?                    -- HXSCC-SCM-DATE
         04 HXSCM-SCC-TURN              PIC X(1).
**          ?隞?Ⅳ                    -- HXSCC-TURN-CD
         04 HXSCM-SCC-DCT               PIC X(5).
**          瑼Ｘ?怠葦?∪極隞?Ⅳ            -- HXSCC-DCT-NCD
      03 HXSCM-SCD-KEY REDEFINES HXSCM-SCC-KEY.
         04 HXSCM-SCD-DATE              PIC 9(7).
**          ?炎?交?                    -- HXSCD-SCM-DATE
         04 HXSCM-SCD-TURN              PIC X(1).
**          ?隞?Ⅳ                    -- HXSCD-TURN-CD
         04 HXSCM-SCD-SRM               PIC X(2).
**          瑼Ｘ摰斤陛蝣?                 -- HXSCD-SRM-CD
         04 HXSCM-SCD-CLS               PIC X(3).
**          瑼Ｘ憿隞??                -- HTSCD-CLS-NO

*$XFD USE GROUP, VAR-LENGTH
   02 HXSCM-KEY1.
      03 HXSCM-KEY1-FILLER              PIC X(20).

*$XFD USE GROUP, VAR-LENGTH
   02 HXSCM-DATA.
      03 HXSCM-CRE-DATE                 PIC 9(7).
**       ?啣??交?
      03 HXSCM-CRE-TIME                 PIC 9(6).
**       ?啣???
      03 HXSCM-CRE-FILLER               PIC X(60).


** HXSCM-ALT-KEY1 = HXSCM-KEY1  + HXSCM-KEY
*COPY    "HX_SCH.MST".
*************
* C-PY FILE : HX_SCH.MST    90/11/01    雿?雓?鞎?
* HX_MSCH LENGTH 360 BYTES  90/11/13    瑼Ｘ憿??交?瑼Ｘ?
*************
 FD HXSCH-MST IS EXTERNAL.
 01 HXSCH-REC.
   02 HXSCH-KEY.
      03 HXSCH-CLS-NO                   PIC X(3).
**       瑼Ｘ憿隞??                   -- HTCLS-CLS-NO
      03 HXSCH-SCH-DATE                 PIC 9(7).
**       ?炎?交?                       -- HXSCD-SCH-DATE
*$XFD USE GROUP, VAR-LENGTH
      03 HXSCH-KEY-SRM.
         04 HXSCH-TURN-CD               PIC X(1).
**          ?隞?Ⅳ                    -- HXSCD-TURN-CD
         04 HXSCH-SRM-CD                PIC X(2).
**          瑼Ｘ摰斤陛蝣?                 -- HXSCD-SRM-CD
*$XFD USE GROUP, VAR-LENGTH
      03 HXSCH-KEY-TIM.
         04 HXSCH-SCH-TIM1              PIC 9(4).
**          瑼Ｘ??????
         04 HXSCH-SCH-INT               PIC X(1).
**          ???蝣?
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCH-KEYA.
         04 HXSCH-KEY-A-FILLER          PIC X(25).
*$XFD USE GROUP, VAR-LENGTH
   02 HXSCH-KEYB.
         04 HXSCH-KEY-B-FILLER          PIC X(30).
   02 HXSCH-DATA.
      03 HXSCH-PT-NO                    PIC 9(8).
**       ?風?Ⅳ
      03 HXSCH-PT-ID                    PIC X(10).
**       頨思遢摮?
      03 HXSCH-IP-DR-CD                 PIC X(5).
**       ??怠葦?∪極隞?Ⅳ
      03 HXSCH-DCT-CD                   PIC X(5).
**       瑼Ｘ?怠葦?∪極隞?Ⅳ               -- HXSCD-DCT-NCD OR HXSCD-DCT-OCD
      03 HXSCH-IP-NO                    PIC X(22).
**       ?思誘摨?
      03 HXSCH-IP-NO1 REDEFINES HXSCH-IP-NO.
**       ?閮粹隞文???
         04 HXSCH-RO-NO                 PIC 9(11).
**          ?閮箏???
         04 HXSCH-OR-NO                 PIC 9(2).
**          ?摨?
         04 HXSCH-RO-FL                 PIC X(9).
**          蝛箇??
      03 HXSCH-IP-NO2 REDEFINES HXSCH-IP-NO.
**       雿?思誘摨?
         04 HXSCH-PD-NO                 PIC 9(11).
**          雿摨?
         04 HXSCH-OD-NO                 PIC 9(11).
**          ?摨?
      03 HXSCH-CRE-SEQ                  PIC 9(4).

**       ?蔭撱箸???雿銝?)           -- ICB-FEE-SEQ OR ODR1-CRE-NO
*$XFD USE GROUP, VAR-LENGTH
      03 HXSCH-DATA-OTH.
         04 HXSCH-SCH-TIM2              PIC 9(4).
**          瑼Ｘ??蝯???
         04 HXSCH-STD-TIM               PIC 9(4).
**          瑼Ｘ璅?撌交?(??            -- W-SCT-STD-TIM OF HX_SCT.LNK
         04 HXSCH-CHK-TIM1              PIC 9(4).
**          瑼Ｘ撖阡?????
         04 HXSCH-CHK-TIM2              PIC 9(4).
**          瑼Ｘ撖阡?蝯???
         04 HXSCH-CHK-TIM               PIC 9(4).
**          瑼Ｘ撖阡?撌交?(??            -- (HXSCH-CHK-TIM2 - HXSCH-CHK-TIM1) OR ACCEPT
         04 HXSCH-SRM-SEQ               PIC 9(1).
**          瑼Ｘ摰文?函Ⅳ                -- HXSCD-SRM-SEQ
         04 HXSCH-ITM-CD OCCURS 9 TIMES PIC X(6).
**          瑼Ｘ?                    -- HTITM-ITM-CD
         04 HXSCH-FILLER                PIC X(170).
**          蝛箇??





**      HXSCH-ALT-KEY1 = HXSCH-IP-NO    HXSCH-KEY
*       (?思誘雿輻)       ?摨?
**      HXSCH-ALT-KEY2 = HXSCH-PT-NO    HXSCH-SCH-DATE  HXSCH-KEY-TIM   HXSCH-KEY-SRM   HXSCH-CLS-NO
*       ?亥岷?撌脫?     ?風??        ???交?        ????        ??炎?亙恕    瑼Ｘ憿(?)
**      HXSCH-ALT-KEY3 = HXSCH-PT-ID    HXSCH-SCH-DATE  HXSCH-KEY-TIM   HXSCH-KEY-SRM   HXSCH-CLS-NO
*       ?亥岷?撌脫?     ?澈隞質???    ???交?        ????        ??炎?亙恕    瑼Ｘ憿(?)
**      HXSCH-ALT-KEY4 = HXSCH-DCT-CD   HXSCH-SCH-DATE  HXSCH-KEY-TIM   HXSCH-KEY-SRM   HXSCH-CLS-NO
*       ?亥岷瑼Ｘ?怠葦撌脫? ?澈隞質???    ???交?        ????        ??炎?亙恕    瑼Ｘ憿(?)
**      HXSCH-ALT-KEY5 = HXSCH-SCH-DATE HXSCH-KEY-SRM   HXSCH-KEY-TIM   HXSCH-CLS-NO
*       ??嗆??鞈? ???交?       ??炎?亙恕    ????        瑼Ｘ憿(?)
**      HXSCH-ALT-KEY6 = HXSCH-KEY-SRM  HXSCH-SCH-DATE  HXSCH-KEY-TIM   HXSCH-CLS-NO
*       撠瑼Ｘ摰文歇?? ??炎?亙恕   ???交?        ????        瑼Ｘ憿(?)
**      HXSCH-ALT-KEY7 = HXSCH-SCH-DATE HXSCH-CLS-NO    HXSCH-KEY-SRM   HXSCH-KEY-TIM
*       憭??交?蝔???  ???交?       瑼Ｘ憿(?)  ??炎?亙恕    ????
**      HXSCH-ALT-KEYA = HXSCH-KEYA     HXSCH-KEY
**      HXSCH-ALT-KEYB = HXSCH-KEYB     HXSCH-KEY
*>
*COPY    "HX_ANN.MST".
*************
* C-PY FILE : HX_ANN.MST    89/06/09    雿?雓?鞎?
* HX_MANN LENGTH 250 BYTES  89/09/20    ???思誘皞??
*************
 FD HXANN-MST IS EXTERNAL.
 01 HXANN-REC.
   02 HXANN-KEY.
      03 HXANN-IP-NO                    PIC X(22).
**       ?思誘摨?
      03 HXANN-IP-NO1 REDEFINES HXANN-IP-NO.
**       ?閮粹隞文???
         04 HXANN-RO-NO                 PIC 9(11).
**          ?閮箏???                   -- ODR-RO-NO
         04 HXANN-OR-NO                 PIC 9(2).
**          ?摨?                    -- ODR-ODR-SEQ

         04 HXANN-RO-FL                 PIC X(9).
**          蝛箇??
      03 HXANN-IP-NO2 REDEFINES HXANN-IP-NO.
**       雿?思誘摨?
         04 HXANN-OD-NO                 PIC 9(11).
**          ?摨?                    -- ICB-ODR-NO
         04 HXANN-PD-NO                 PIC 9(11).
**          雿摨?                    -- ICB-IPD-NO
      03 HXANN-IP-SEQ                   PIC 9(3).
**       ?思誘?蔭摨?                   -- ODR-ANN-SEQ OR ICB-ANN-SEQ
   02 HXANN-DATA.
      03 HXANN-TRN-SW                   PIC X(1).
**       ?啣?霅蝣?
      03 HXANN-CHK-DATE                 PIC 9(7).
**       瑼Ｘ?交?
      03 HXANN-ANN-DATE                 PIC 9(7).
**       ?勗??交?
      03 HXANN-DEL-DATE                 PIC 9(7).
**       ?芷?交?
*$XFD USE GROUP
      03 HXANN-REV-KEY.
         04 HXANN-PRS-NO                PIC X(9).
**          ?孵?蔭隞?Ⅳ                -- ODR-FEE-PRS OR ICB-FEE-KEY
         04 HXANN-REV-SEQ               PIC 9(3).
**          ?思誘?蔭????= 999 - HXANN-IP-SEQ
*$XFD USE GROUP
      03 HXANN-CTM-KEY.
         04 HXANN-CHK-NO                PIC X(8).
**          ?思誘?株?                    -- ODR-CHK-NO  OR ICB-CHK-NO
         04 HXANN-IP-DATE               PIC 9(7).
**          ?思誘?交?                    -- ODR-RO-DATE OR ICB-INS-DATE
         04 HXANN-ITM-CD                PIC X(6).
**          瑼Ｘ隞?Ⅳ                    -- ODR-ITM-CD  OR ICB-ITM-CD
*$XFD USE GROUP
      03 HXANN-EXE-KEY.
**       ?勗?撖行鞈?
         04 HXANN-PAT-ID                PIC X(10).
**          ?頨思遢摮?
         04 HXANN-EXE-DATE              PIC 9(7).
**          撖行?交?
         04 HXANN-INS-ID                PIC X(12).
**          ?乩?隞?Ⅳ
         04 HXANN-DCT-ID                PIC X(10).
**          ?怠葦頨思遢摮?
*$XFD USE GROUP, VAR-LENGTH
      03 HXANN-DATA-ANN.
         04 HXANN-CHK-DATA.
            05 HXANN-CHK-TIME           PIC 9(6).
**             瑼Ｘ??
            05 HXANN-CHK-MAN            PIC X(5).
**             瑼Ｘ鈭箏
         04 HXANN-ANN-DATA.
            05 HXANN-ANN-TIME           PIC 9(6).
**             ?勗???
            05 HXANN-ANN-MAN            PIC X(5).
**             ?勗?鈭箏
         04 HXANN-DEL-DATA.

            05 HXANN-DEL-TIME           PIC 9(6).
**             ?芷??
            05 HXANN-DEL-MAN            PIC X(5).
**             ?芷鈭箏
            05 HXANN-DEL-SW             PIC X(1).
**             ?芷霅蝣?
         04 HXANN-ACC-NO                PIC X(13).
**          ?詨??Ⅳ
*$XFD USE GROUP, VAR-LENGTH
      03 HXANN-DATA-OTH.
         04 HXANN-ANF-DATA.
            05 HXANN-ANF-DATE           PIC 9(7).
**             擐活?勗??交?
            05 HXANN-ANF-TIME           PIC 9(6).
**             擐活?勗???
            05 HXANN-ANF-MAN            PIC X(5).
**             擐活?勗?鈭箏
         04 HXANN-CHG-ID                PIC X(1).
**          ?嗉祥???                 -- ODR-CHG-ID OR ICB-ASU-PAY
         04 HXANN-CHF-DATA.
            05 HXANN-CHF-DATE           PIC 9(7).
**             擐活?勗???瑼Ｘ?交?
            05 HXANN-CHF-TIME           PIC 9(6).
**             擐活?勗???瑼Ｘ??
            05 HXANN-CHF-MAN            PIC X(5).
**             擐活?勗???瑼Ｘ鈭箏
         04 HXANN-OTM-SW                PIC X(2).
**          ?暹??勗???隞?Ⅳ            -- 890920
         04 HXANN-FILLER                PIC X(195).
**          蝛箇??

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
** HXANN-TRN-SW : A> ??, create HXANN-PAT-ID,   HXANN-CTM-KEY,  HXANN-PRS-NO
**                B> 瑼Ｘ, create HXANN-CHK-DATE, HXANN-CHK-DATA
**                C> ?勗?, create HXANN-ANN-DATE, HXANN-ANN-DATA, HXANN-EXE-KEY,
**                                HXANN-ANF-DATA, HXANN-CHF-DATA, HXANN-CHG-ID
**                D> ?詨?, create HXANN-ACC-NO
**                E> ?芷, create HXANN-DEL-DATE, HXANN-DEL-DATA
** HXANN-CHG-ID : 1> ?乩??  2> ?芾祥?
** HXANN-DEL-SW : A> ?孵?芷, B> 鈭箏極?芷
**                ?嗅?瘨?斗??脰?銝膩 PROCEDURE :
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
**                    --> '?閮?
**               ELSE
**                    --> '雿'
**               END-IF
*> 97.7.23 ????
*COPY    "HI_ENB.MST".
*********************************
*>雿蝯董撱嗡撓瑼? RECORD LENGTH = 267 BYTES
*********************************
 FD      ENB-MST         EXTERNAL.
 01      ENB-MST-REC.
*$XFD USE GROUP
        10 ENB-KEY.
*雿摨?
           20 ENB-IPD-NO.
*雿?交?
              30 ENB-IPD-DATE                   PIC 9(7).
*雿瘚偌??
              30 ENB-IPD-SEQ                    PIC 9(4).
*蝯董瘚偌??
           20 ENB-SEG-SEQ                       PIC 9(3).
*璅?鞎餌??
           20 ENB-STD-FNO                       PIC X(3).
*$XFD USE GROUP,VAR-LENGTH
        10 ENB-GROUP-DATA1.
*>???                                              (1, 9)
                20 ENB-3NO-AMT                          PIC S9(7)V99.
*>?芸???(瑼ａ??芸?)                                    (10, 9)
                20 ENB-3DI-AMT                          PIC S9(7)V99.
*>?其遢鞎???                                          (19, 9)
                20 ENB-PART-AMT                         PIC S9(7)V99.
*>撖行??銝?祇?憿?                                     (28, 9)
                20 ENB-3R-AMT1                          PIC S9(7)V99.
*>撖行??隞???                                      (37, 9)
                20 ENB-3R-AMT2                          PIC S9(7)V99.

*>撖行???寧??憿?                                   (46, 9)
                20 ENB-3R-AMT3                          PIC S9(7)V99.
*>?芯???                                              (55, 9)
                20 ENB-3SP-AMT                          PIC S9(7)V99.
*>?喳??                                              (64, 9)
                20 ENB-3AP-AMT                          PIC S9(7)V99.
*>甈∟?頨思遢?喳??                                      (73, 9)
                20 ENB-3RE-AMT                          PIC S9(7)V99.
*>撌脫??                                              (82, 9)
                20 ENB-3RCV-AMT                         PIC S9(7)V99.
*>??仿??( UPDATE 84.10.22 ) ...
*>??交??園?憿?                                         (91, 9)
                20 ENB-RTB-3NO-AMT                      PIC S9(7)V99.
*>??亙??憿?                                         (100, 9)
                20 ENB-RTB-3DI-AMT                      PIC S9(7)V99.
*>??仿隞質???憿?                                     (109, 9)
                20 ENB-RTB-PART-AMT                     PIC S9(7)V99.
*>??亙祕?園?憿??祇?憿?                                 (118, 9)
                20 ENB-RTB-3R-AMT1                      PIC S9(7)V99.
*>??亙祕?園?憿誨?園?憿?                                 (127, 9)
                20 ENB-RTB-3R-AMT2                      PIC S9(7)V99.
*>??亙祕?園?憿蝝??仿?                                        (136, 9)
                20 ENB-RTB-3R-AMT3                      PIC S9(7)V99.
*>??亥隞?憿?                                         (145, 9)
                20 ENB-RTB-3SP-AMT                      PIC S9(7)V99.
*>??亦?梢?憿?                                         (154, 9)
                20 ENB-RTB-3AP-AMT                      PIC S9(7)V99.
*>??交活閬澈隞賜?梢?憿?                                 (163, 9)
                20 ENB-RTB-3RE-AMT                      PIC S9(7)V99.
                20 ENB-FILLER                           PIC X(79).
                20 ENB-REF-DATA         REDEFINES ENB-FILLER.
*>?臬?箏????(85.5.10)                              (172, 1)
                      30 ENB-LB-YN                    PIC X.
*>?芸?蝮賡?憿?85.5.10)                                   (173, 9)
                      30 ENB-LB-APP-AMT               PIC S9(7)V99.
*>?芸????喳撌桅? -->? ?芸??? (85.5.10)           (182, 9)
                      30 ENB-DEF-LB-APP-AMT           PIC S9(7)V99.
*>                                                      (191, 9)
                      30 ENB-LB-PART-AMT              PIC S9(7)V99.
*>                                                      (200, 9)
                      30 ENB-DEF-LB-PART-AMT          PIC S9(7)V99.
*> 頞 15000 銋?憿?..                                 (209, 9)
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
*>雿輻?澈隞賜???????Y , ENB-3RE-AMT -->????隞?憿? (243, 1)
                      30 ENB-REF-RANG                 PIC X.
*>                                                              (244, 7)
                      30 ENB-FILLER1                  PIC X(7).
*> **************************************************************************

*>      END     OF      FILE
*> **************************************************************************
*COPY    "HI_KEY.TMP".
*********************************************************************************
*       ?萄潭炎?交?                                                              *
*       憭瑼?  HI_KEY.TMP  -->  瑼?  HI_TKEY                                *
*       銝?IKEY-TMP-KEY                                                         *
* 920812  ??GUI?寧????冽??HI_PKEY-->HI_TKEY      (JAY)                   *
*> 97/04/29 Frank-?啣之???瘙?憓?霅B?                                     *
*********************************************************************************
*>      雿?怠?鞈?
 FD      IKEY-TMP         EXTERNAL.
 01      IKEY-TMP-REC.
*$XFD USE GROUP
        02      IKEY-TMP-KEY.
*>              霅(A.雿?風?怠? B.?????亥?瘚偌??C.?????亥????
                10  IKEY-TMP-ID                         PIC X(01).
                10  IKEY-TMP-DATA1                      PIC X(50).
                10  IKEY-ENA-DATA1      REDEFINES       IKEY-TMP-DATA1.
*>                      ?風??
                        20  IKEY-ENA-PAT-NO             PIC 9(8).
                        20  IKEY-ENA-FILLER             PIC X(42).

        02      IKEY-TMP-DATA2                          PIC X(250).
*>              A.雿?風?怠?
        02      IKEY-ENA-DATA2  REDEFINES       IKEY-TMP-DATA2.
*>              蝺楝蝺刻?
                10  IKEY-SLNO                           PIC 9(4).
*>              雿輻??
                10  IKEY-USER                           PIC X(5).
*>              ?瑁?雿平
                10  IKEY-JOB                            PIC X(8).
*>              摮??交?
                10  IKEY-DATE                           PIC 9(8).
*>              摮???
                10  IKEY-TIME                           PIC 9(6).
*>              ??
                10  IKEY-FILLER                         PIC X(219).
***********************************************************************************
*COPY    "HI_ICC.MST".
****************************
*雿?撱嗡撓瑼?撠撘菔??寡祥?冽飛憿?Ｗ璅?鞎餌??
*               RECORD LENGTH = 179 BYTES
****************************
 FD      ICC-MST         EXTERNAL.
 01      ICC-MST-REC.
*$XFD USE GROUP
        10 ICC-KEY.
*雿摨?
           20 ICC-IPD-NO.
              30 ICC-IPD-DATE           PIC 9(7).
              30 ICC-IPD-SEQ            PIC 9(4).
*?摨?
           20 ICC-ODR-NO.
*??交?
              30 ICC-INS-DATE           PIC 9(7).
*?瘚偌??

              30 ICC-ODR-SEQ            PIC 9(4).
*璅?鞎餌??
           20 ICC-STD-FNO               PIC X(3).
*$XFD USE GROUP,VAR-LENGTH
        10 ICC-GROUP-DATA1.
*蝯董摨?(甇斤???飛憿???蝑?撣喳???
                20 ICC-SEG-SEQ                  PIC 9(3).
*???
                20 ICC-3NO-AMT                  PIC S9(7)V99.
*?芸???
                20 ICC-3DI-AMT                  PIC S9(7)V99.
*?其遢鞎???
                20 ICC-PART-AMT                 PIC S9(7)V99.
*撖行??銝?祇?憿?
                20 ICC-3R-AMT1                  PIC S9(7)V99.
*撖行??隞???
                20 ICC-3R-AMT2                  PIC S9(7)V99.
*撖行???寧??憿?
                20 ICC-3R-AMT3                  PIC S9(7)V99.
*?芯?憿?
                20 ICC-3SP-AMT                  PIC S9(7)V99.
*?喳憿?
                20 ICC-3AP-AMT                  PIC S9(7)V99.
*?澈隞賜?梢?
                20 ICC-3RE-AMT                  PIC S9(7)V99.
*撌脫憿?
                20 ICC-3RCV-AMT                 PIC S9(7)V99.
*[T] ?董鞈? [D] ?芷?酉
                20 ICC-DEL-MARK                 PIC X.
*
                20 ICC-FILLER                   PIC X(60).
                20 ICC-REF-DATA         REDEFINES ICC-FILLER.
*?臬?箏????(85.5.10)
                        30 ICC-LB-YN                    PIC X.
*?芸?蝮賡?憿?(85.5.10)
                        30 ICC-LB-APP-AMT               PIC S9(7)V99.
*?芸????喳撌桅? ---> ? ?芸??? (85.5.10)
                        30 ICC-DEF-LB-APP-AMT           PIC S9(7)V99.
*
                        30 ICC-LB-PART-AMT              PIC S9(7)V99.
*
                        30 ICC-DEF-LB-PART-AMT          PIC S9(7)V99.
                        30 ICC-FILLER1                  PIC X(23).
*COPY    "HI_ENA.MST".
****************************
*雿蝯董瑼?RECORD LENGTH = 264 BYTES
****************************
 FD      ENA-MST         EXTERNAL.
 01      ENA-MST-REC.
* KEY ??= 雿摨? + 蝯董瘚偌??
*$XFD USE GROUP
        10 ENA-KEY.
*雿摨?
           20 ENA-IPD-NO.
*雿?交?
              30 ENA-IPD-DATE           PIC 9(7).
*雿瘚偌??

              30 ENA-IPD-SEQ            PIC 9(4).
*蝯董瘚偌??
           20 ENA-SEG-SEQ               PIC 9(3).
*$XFD USE GROUP,VAR-LENGTH
        10 ENA-GROUP-DATA1.
*>蝯董?交?      (1,7)
                20 ENA-SEG-DATE                 PIC 9(7).
*>?蝮賡?      (8, 9)
                20 ENA-NOM-AMT                  PIC S9(7)V99.
*>?芸???(瑼ａ??芸?)    (17, 9)
                20 ENA-DIS-AMT                  PIC S9(7)V99.
*>?其遢鞎???  (26, 9)
                20 ENA-PART-AMT                 PIC S9(7)V99.
*>?芯???      (35, 9)
                20 ENA-SP-AMT                   PIC S9(7)V99.
*>?喳??      (44, 9)
                20 ENA-APP-AMT                  PIC S9(7)V99.
*>甈∟?頨思遢?喳??      (53, 9)
                20 ENA-REF-AMT                  PIC S9(7)V99.
*>撌脫??              (62, 9)
                20 ENA-RCV-AMT                  PIC S9(7)V99.
*>甈狡?? (UPDATE 84.09.21 )   (71, 9)
                20 ENA-URCV-AMT                 PIC S9(7)V99.
*>?箏?鞎餌?摨?              (80, 11)
                20 ENA-ODR-NO.
*>?箏?鞎餌??交?
                        30 ENA-ODR-DATE         PIC 9(7).
*>?箏?鞎餌?瘚偌??UPDATE 84.09.21 .. 9(3) => 9(4) )
                        30 ENA-ODR-SEQ          PIC 9(4).
*>?嗆??Ⅳ                      (91, 8)
                20 ENA-ACC-NO                   PIC 9(8).
*>頞 ?擃???銋?憿?15000 (84.09.14) (99, 1)
                20 ENA-OVER-15000               PIC X.
*>?芸?蝮賡?甈?84.09.29)                  (100, 3)
                20 ENA-LB-CNT                   PIC 9(3).
*>?芸?蝮賡?甈??喳蝮賡? (84.09.29)                (103, 9)
                20 ENA-LB-APP-AMT               PIC S9(7)V9(2).
*>?臬?芸?(84.10.01)                    (112, 1)
                20 ENA-LB-YN                    PIC X.
*>?芸????喳撌桅?(84.10.01) --> ? ?芸?????.      (113, 9)
                20 ENA-DEF-LB-APP-AMT           PIC S9(7)V9(2).
** UPDATE 84.10.22
*>??仿??MARK                                         (122, 1)
                20 ENA-RTA-MARK                 PIC X.
*>??仿???寧???...                                  (123, 3)
                20 ENA-RTA-NUMS                 PIC 9(3).
*>??交??嗥蜇憿?                                         (126, 9)
                20 ENA-RTA-NOM-AMT              PIC S9(7)V99.
*>??亙??憿?                                         (135, 9)
                20 ENA-RTA-DIS-AMT              PIC S9(7)V99.
*>??仿隞質???憿?                                     (144, 9)
                20 ENA-RTA-PART-AMT             PIC S9(7)V99.
*>??亥隞?憿?                                         (153, 9)
                20 ENA-RTA-SP-AMT               PIC S9(7)V99.
*>??亦?梢?憿?                                         (162, 9)
                20 ENA-RTA-APP-AMT              PIC S9(7)V99.
*>甈∟?頨思遢?喳??                                      (171, 9)

                20 ENA-RTA-REF-AMT              PIC S9(7)V99.
                20 ENA-FILLER                   PIC X(71).
                20 ENA-REF-DATA         REDEFINES ENA-FILLER.
*>?炎撽???其遢鞎???                              (180, 9)
                   30 ENA-LB-PART-AMT           PIC S9(7)V99.
*>                                                      (189, 9)
                   30 ENA-DEF-LB-PART-AMT       PIC S9(7)V9(2).
*>閮駁甈狡蝣?                                           (198, 1)
                   30 ENA-RCV-AMT-MARK          PIC X.
*>頞 15000 銋?憿?                                    (199, 9)
                   30 ENA-D1-AMT                PIC S9(7)V9(2).
*>雿蝯董 Y                                            (208, 1)
                   30 ENA-SEG-MARK              PIC X.
*>雿蝯董?交?                                          (209, 7)
                   30 ENA-SEG-UPDDT             PIC 9(7).
*>雿蝯董??                                          (216, 6)
                   30 ENA-SEG-UPDTI             PIC 9(6).
*>雿蝯董??                                           (222, 5)
                   30 ENA-SEG-USER              PIC X(5).
*>?Ｘ折隞質???                                         (227, 8)
                   30 ENA-SLOW-PART-DEF         PIC X(8).
                   30 ENA-SLOW-PART REDEFINES ENA-SLOW-PART-DEF PIC S9(6)V99.
*>?交折隞質???                                         (235, 8)
                   30 ENA-QUICK-PART-DEF        PIC X(8).
                   30 ENA-QUICK-PART REDEFINES ENA-QUICK-PART-DEF PIC S9(6)V99.
*>P:?嗆狡憿?? Y:??甈?                                       (243, 1)
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
*> 雿蝯董撱嗡撓瑼?RECORD LENGTH = 381 BYTES
*> 銝?ENC-KEY
*> ?粹蝯董?亥岷雿輻
*> ENC-ALT-KEY1 =  ENC-IPD-NO  ENC-SEG-SEQ-V
*> 瘥??隢狡???湔蝯董雿輻
*> ENC-ALT-KEY2 =  ENC-END-DT  ENC-IPD-NO  ENC-SEG-SEQ
*> 97/10/07 Frank-憓???/瑼ａ?瑼Ｘ?嚗靽?蝯虫?憿?銵炎撽炎?交?????嗡???(?芾祥)
*****************************************************************************
 FD      ENC-MST         EXTERNAL.
 01      ENC-MST-REC.
*> 銝膊EY ??= 雿摨? + 蝯董瘚偌??
        10 ENC-KEY.
*$XFD USE GROUP
*> 雿摨?
                20 ENC-IPD-NO.
*>              雿?交?
                        30 ENC-IPD-DATE         PIC 9(7).
*>              雿瘚偌??
                        30 ENC-IPD-SEQ          PIC 9(4).

*> 蝯董瘚偌??
                20 ENC-SEG-SEQ                  PIC 9(3).
*>
        10 ENC-DATA1.
*> 蝯董?芣迫????蝣潸”蝷箇?撣喳僑??
                20 ENC-END-DT                   PIC 9(7).
*> 蝯董?芣迫??9999999 - ENC-END-DT)
                20 ENC-END-DT-V                 PIC 9(7).
*> 蝯董瘚偌???EY: 999 - ENC-SEG-SEQ)
                20 ENC-SEG-SEQ-V                PIC 9(3).
*>
*$XFD USE GROUP,VAR-LENGTH
        10 ENC-GROUP-DATA1.
*> 蝯董韏瑕???                                          (1,7)
                20 ENC-BEG-DT                   PIC 9(7).
*> ?啣??交?                                             (8,7)
                20 ENC-UPD-DT                   PIC 9(7).
*> ?啣???                                              (15,5)
                20 ENC-UPD-USER                 PIC X(5).
*>96.11.15 ?啁?雿?嗆??啣?甈?
*>(?交?雿?典?鞎?  1~30??10%)                       (20,9)
                20 ENC-QUICK-PART10-AMT         PIC S9(7)V99.
*>(?交?雿?典?鞎? 31~60??20%)                       (29,9)
                20 ENC-QUICK-PART20-AMT         PIC S9(7)V99.
*>(?交?雿?典?鞎? 61?乩誑銝?30%)                      (38,9)
                20 ENC-QUICK-PART30-AMT         PIC S9(7)V99.
*>(?Ｘ?雿?典?鞎? 30?乩誑銝?5%)                       (47,9)
                20 ENC-SLOW-PART5-AMT           PIC S9(7)V99.
*>(?Ｘ?雿?典?鞎? 31~90??10%)                       (56,9)
                20 ENC-SLOW-PART10-AMT          PIC S9(7)V99.
*>(?Ｘ?雿?典?鞎? 91~180??20%)                      (65,9)
                20 ENC-SLOW-PART20-AMT          PIC S9(7)V99.
*>(?Ｘ?雿?典?鞎? 181?乩誑銝?30%)                     (74,9)
                20 ENC-SLOW-PART30-AMT          PIC S9(7)V99.
*>(?交???仿隞質???憿? 1~30??10%)                   (83,9)
                20 ENC-RTA-QUICK-PART10-AMT     PIC S9(7)V99.
*>(?交???仿隞質???憿?31~60??20%)                   (92,9)
                20 ENC-RTA-QUICK-PART20-AMT     PIC S9(7)V99.
*>(?交???仿隞質???憿?61?乩誑銝?30%)                  (101,9)
                20 ENC-RTA-QUICK-PART30-AMT     PIC S9(7)V99.
*>(?Ｘ???仿隞質???憿?30?乩誑銝?5%)                   (110,9)
                20 ENC-RTA-SLOW-PART5-AMT       PIC S9(7)V99.
*>(?Ｘ???仿隞質???憿?31~90??10%)                   (119,9)
                20 ENC-RTA-SLOW-PART10-AMT      PIC S9(7)V99.
*>(?Ｘ???仿隞質???憿?91~180??20%)                  (128,9)
                20 ENC-RTA-SLOW-PART20-AMT      PIC S9(7)V99.
*>(?Ｘ???仿隞質???憿?181?乩誑銝?30%)                 (137,9)
                20 ENC-RTA-SLOW-PART30-AMT      PIC S9(7)V99.
*> 97.10.07 ??/瑼ａ?瑼Ｘ?嚗靽?蝯虫?憿??乩?)       (146,9)
                20 ENC-NHI-DIS-AMT              PIC S9(7)V9(2).
*> 97.10.07 ??/瑼ａ?瑼Ｘ?嚗隞?憿??芾祥)           (155,9)
                20 ENC-SP-DIS-AMT               PIC S9(7)V9(2).
*> ??
                20 ENC-FILLER                   PIC X(87).
*$XFD USE GROUP,VAR-LENGTH
        10 ENC-GROUP-DATA2                      PIC X(100).
******************************************************************************

*>      END     OF      FILE
******************************************************************************
*COPY    "HI_END.MST".
*********************************
*>96.11.15 ?啁?雿?嗆??啣?甇九NB撱嗡撓瑼?->END
*>雿蝯董撱嗡撓瑼? RECORD LENGTH = 417 BYTES
*> 97/10/07 Frank-憓???/瑼ａ?瑼Ｘ?嚗靽?蝯虫?憿?銵炎撽炎?交?????嗡???(?芾祥)
*********************************
 FD      HIEND-MST         EXTERNAL.
 01      HIEND-MST-REC.
*$XFD USE GROUP
        10 HIEND-KEY.
*雿摨?
           20 HIEND-IPD-NO.
*雿?交?
              30 HIEND-IPD-DATE                   PIC 9(7).
*雿瘚偌??
              30 HIEND-IPD-SEQ                    PIC 9(4).
*蝯董瘚偌??
           20 HIEND-SEG-SEQ                       PIC 9(3).
*璅?鞎餌??
           20 HIEND-STD-FNO                       PIC X(3).
*$XFD USE GROUP,VAR-LENGTH
        10 HIEND-GROUP-DATA1.
*>(?交?雿?典?鞎?  1~30??10%)                       (1,9)
                20 HIEND-QUICK-PART10-AMT         PIC S9(7)V99.
*>(?交?雿?典?鞎? 31~60??20%)                       (10,9)
                20 HIEND-QUICK-PART20-AMT         PIC S9(7)V99.
*>(?交?雿?典?鞎? 61?乩誑銝?30%)                      (19,9)
                20 HIEND-QUICK-PART30-AMT         PIC S9(7)V99.
*>(?Ｘ?雿?典?鞎? 30?乩誑銝?5%)                       (28,9)
                20 HIEND-SLOW-PART5-AMT           PIC S9(7)V99.
*>(?Ｘ?雿?典?鞎? 31~90??10%)                       (37,9)
                20 HIEND-SLOW-PART10-AMT          PIC S9(7)V99.
*>(?Ｘ?雿?典?鞎? 91~180??20%)                      (46,9)
                20 HIEND-SLOW-PART20-AMT          PIC S9(7)V99.
*>(?Ｘ?雿?典?鞎? 181?乩誑銝?30%)                     (55,9)
                20 HIEND-SLOW-PART30-AMT          PIC S9(7)V99.
*>(?交???仿隞質???憿? 1~30??10%)                   (64,9)
                20 HIEND-RTA-QUICK-PART10-AMT     PIC S9(7)V99.
*>(?交???仿隞質???憿?31~60??20%)                   (73,9)
                20 HIEND-RTA-QUICK-PART20-AMT     PIC S9(7)V99.
*>(?交???仿隞質???憿?61?乩誑銝?30%)                  (82,9)
                20 HIEND-RTA-QUICK-PART30-AMT     PIC S9(7)V99.
*>(?Ｘ???仿隞質???憿?30?乩誑銝?5%)                   (91,9)
                20 HIEND-RTA-SLOW-PART5-AMT       PIC S9(7)V99.
*>(?Ｘ???仿隞質???憿?31~90??10%)                   (100,9)
                20 HIEND-RTA-SLOW-PART10-AMT      PIC S9(7)V99.
*>(?Ｘ???仿隞質???憿?91~180??20%)                  (109,9)
                20 HIEND-RTA-SLOW-PART20-AMT      PIC S9(7)V99.
*>(?Ｘ???仿隞質???憿?181?乩誑銝?30%)                 (118,9)
                20 HIEND-RTA-SLOW-PART30-AMT      PIC S9(7)V99.
*>雿?憭拇                                          (127,4)
                20 HIEND-ROOM-DAYS                PIC 9(4).
*> 97.10.07 ??/瑼ａ?瑼Ｘ?嚗靽?蝯虫?憿??乩?)       (131,9)
                20 HIEND-NHI-DIS-AMT            PIC S9(7)V9(2).
*> 97.10.07 ??/瑼ａ?瑼Ｘ?嚗隞?憿??芾祥)           (140,9)

                20 HIEND-SP-DIS-AMT             PIC S9(7)V9(2).
*> ??
                20 HIEND-FILLER                 PIC X(102).
*$XFD USE GROUP,VAR-LENGTH
        10 HIEND-GROUP-DATA2                    PIC X(150).
*> **************************************************************************
*>      END     OF      FILE
*> **************************************************************************
*> 103.06.27 (?訾撰) 靽格撖阡???仿?甈?霈??皞??寡?RTA?TB??
*COPY    "HI_RTA.MST".
**************************
*??交??瑼? RECORD LENGTH = 179 BYTES
*> 901114 insert: RTA-BATCH-YN : Y 銵函內?梢?亦Ⅱ隤??
**************************
 FD      RTA-MST         EXTERNAL.
 01      RTA-MST-REC.
* KEY ??= 雿摨? + UD 韏瑕??交? + UD 瘚偌??
*$XFD USE GROUP
        10 RTA-KEY.
*雿摨?
           20 RTA-IPD-NO.
*雿?交?
              30 RTA-IPD-DATE           PIC 9(7).
*雿瘚偌??
              30 RTA-IPD-SEQ            PIC 9(4).
           20 RTA-ODR-NO.
*??亥??寞??
              30 RTA-INS-DATE           PIC 9(7).
*??亥??寞?瘞渲?
              30 RTA-ODR-SEQ            PIC 9(3).
*$XFD USE GROUP,VAR-LENGTH
        10 RTA-GROUP-DATA1.
*蝯董摨?(甇斤???飛憿???蝑?撣喳???                       (1, 3)
                20 RTA-SEG-SEQ                  PIC 9(3).
*???蝘隞?Ⅳ                                                  (4, 4)
                20 RTA-DEPT-NO                  PIC X(4).
*????怠葦隞?Ⅳ                                                  (8, 4)
                20 RTA-DR-NO                    PIC X(4).
*???頨思遢隞?Ⅳ                                                  (12, 4)
                20 RTA-IDNT-NO                  PIC X(4).
*????摨?                                                  (16, 6)
                20 RTA-WARD.
                        30 RTA-BED-ROOM         PIC X(4).
                        30 RTA-BED-NO                   PIC X(2).
*??亥??寧??....UPDATE 84.10.31                             (22, 5)
                20 RTA-USR-ID                   PIC X(5).
*?蝮賡?                                                       (27, 9)
                20 RTA-NOM-AMT                  PIC S9(7)V9(2).
*?芸???                                                       (36, 9)
                20 RTA-DIS-AMT                  PIC S9(7)V9(2).
*?其遢鞎???                                                   (45, 9)
                20 RTA-PART-AMT                 PIC S9(7)V9(2).
*?芯???                                                       (54, 9)
                20 RTA-SP-AMT                   PIC S9(7)V9(2).
*?喳??                                                       (63, 9)
                20 RTA-APP-AMT                  PIC S9(7)V9(2).
*?澈隞賜?梢?憿?                                              (72, 9)

                20 RTA-REF-AMT                  PIC S9(7)V9(2).
*撌脫??                                                       (81, 9)
                20 RTA-RCV-AMT                  PIC S9(7)V9(2).
*?憿(Y-?交抒??? N-?Ｘ抒??? UPDATE 84.10.16               (90, 1)
                20 RTA-BED-ID                   PIC X.
*鞎??曉?瘥?(84.10.16)                                          (91, 3)
                20 RTA-COM-RATE                 PIC 9(3).
*?其遢鞎?隞?Ⅳ(000:?隞質???001,002,003,004,005:?隞質???111:?芾祥)?(94, 3)
                20 RTA-IPD-PART                 PIC X(3).
*鞎?%(?雿?臭?畾萄????航????閬隞質?????????其遢鞎?)
*        ( 0:?隞質??? 1:?交抒??輸隞質???10%, 2:?交抒???20%, 3:?交?
*            ? 30%, 4:?Ｘ抒???5%, 5:?Ｘ抒???10%, 6:?Ｘ抒???20%,
*          7:?Ｘ抒???30%  A:?芾祥 100%                                  (97, 1)
                20 RTA-RESPOND                  PIC X.
*[T] ?董鞈? [D] ?芷?酉 84.10.16                                     (98, 1)
                20 RTA-DEL-MARK                 PIC X.
*>                                                                      (99, 8)
                20 RTA-SLOW-PART-DEF            PIC X(8).
                20 RTA-SLOW-PART  REDEFINES RTA-SLOW-PART-DEF  PIC S9(6)V99.
*>                                                                      (107, 8)
                20 RTA-QUICK-PART-DEF           PIC X(8).
                20 RTA-QUICK-PART REDEFINES RTA-QUICK-PART-DEF PIC S9(6)V99.
*>                                                                      (115, 3)
                20 RTA-COM-DAYS                 PIC 9(3).
*蝺?Y->?鋡? 87/08/20憓?                                           (118, 1)
                20 RTA-EMG-CD                   PIC X(1).
*?亥??Ⅳ       87/08/24憓?                                            (119, 4)
                20 RTA-PILL-NO                  PIC 9(4).
*??乩耨?寡?                                                            (123, 5)
                20 RTA-UPD-USR                  PIC X(5).
*?撱箸???                                                            (128, 7)
                20 RTA-CRE-DT                   PIC 9(7).
*Y ->?粹?亦Ⅱ隤?璆??Ｙ?
                20 RTA-BATCH-YN                 PIC X(1).
                20 RTA-FILLER                   PIC X(23).
**************************
*>      END     OF      FILE
**************************
*COPY    "HI_RTB.MST".
****************************
*??亥??寞?蝝唳? RECORD LENGTH = 225 BYTES
*> 900216 INSERT :RTB-ECB-FILE-NO
*> 900301 INSERT :RTB-STK-CNT
****************************
 FD      RTB-MST         EXTERNAL.
 01      RTB-MST-REC.
* KEY ??= 雿摨? + UD 韏瑕??交? + UD 瘚偌??+ ?蔭瘚偌??
*$XFD USE GROUP
        10 RTB-KEY.
*雿摨?
           20 RTB-IPD-NO.
*雿?交?
              30 RTB-IPD-DATE           PIC 9(7).
*雿瘚偌??
              30 RTB-IPD-SEQ            PIC 9(4).
           20 RTB-ODR-NO.
*?????交?

              30 RTB-INS-DATE           PIC 9(7).
*???瘚偌??
              30 RTB-ODR-SEQ            PIC 9(3).
*?蔭瘚偌??
           20 RTB-FEE-SEQ               PIC 9(3).
*$XFD USE GROUP,VAR-LENGTH
        10 RTB-GROUP-DATA1.
*?蔭隞?Ⅳ(敹?亙?????                               (1,9)
                20 RTB-FEE-KEY                  PIC X(9).
*璅?鞎餌??                                            (10,3)
                20 RTB-STD-FNO                  PIC X(3).
*鞎餌甇詨惇蝘(?銝剖?)                                 (13,5)
                20 RTB-FEE-DEPT                 PIC X(5).
*摨怠                                                   (18,4)
                20 RTB-STO-DEPT                 PIC X(4).
*??亥澈隞?                                              (22,4)
                20 RTB-IDNT-NO                  PIC X(4).
*?亥那??                                               (26,1)
                20 RTB-EXTRA                    PIC X.
*??亦???                                              (27,1)
                20 RTB-RESN                     PIC X.
*??亦車憿?                                              (28,1)
                20 RTB-KIND                     PIC X.
*???蝮賡?
                20 RTB-RX-QTY.
*??亦蜇??摮?                                          (29,4)
                        30 RTB-RX-QTY1          PIC 9(4).
*???蝮賡???                                          (33,2)
                        30 RTB-RX-QTY2          PIC 9(2).
*?桀                                                   (35,8)
                20 RTB-PRICE                    PIC 9(6)V9(2).
*???                                               (43,9)
                20 RTB-NOM-AMT                  PIC S9(7)V9(2).
*?芸???                                               (52,9)
                20 RTB-DIS-AMT                  PIC S9(7)V9(2).
*?其遢鞎???                                           (61,9)
                20 RTB-PART-AMT                 PIC S9(7)V9(2).
*撖行??銝?祇?憿?                                      (70,9)
                20 RTB-RE-AMT1                  PIC S9(7)V9(2).
*撖行??隞???                                       (79,9)
                20 RTB-RE-AMT2                  PIC S9(7)V9(2).
*撖行???寧??憿?                                    (88,9)
                20 RTB-RE-AMT3                  PIC S9(7)V9(2).
*?芯?憿?                                                (97,9)
                20 RTB-SP-AMT                   PIC S9(7)V9(2).
*?喳憿?                                                (106,9)
                20 RTB-APP-AMT                  PIC S9(7)V9(2).
*甈∟?頨思遢?喳憿?                                        (115,9)
                20 RTB-REF-AMT                  PIC S9(7)V9(2).
*?啣?鈭箔誨蝣?                                            (124,4)
                20 RTB-UPD-UID                  PIC X(4).
*?啣??交?                                               (128,7)
                20 RTB-UPD-DATE                 PIC 9(7).
*?啣???                                               (135,6)
                20 RTB-UPD-TIME                 PIC 9(6).
*?啣?蝣?                                                (141,1)
                20 RTB-UPD-MARK                 PIC X.

                20 RTB-FILLER                   PIC X(60).
                20 RTB-REF-DATA         REDEFINES RTB-FILLER.
*>                                                      (142,3)
                        30 RTB-DG-FLAG          PIC X(3).
*> ??亙???嫣??摨?                               (145,11)
                        30 RTB-ICB-ODR          PIC X(11).
*> ??亙???嫣??蔭摨?                               (156,3)
                        30 RTB-ICB-ODR-SEQ      PIC 9(3).
                        30 RTB-ICB-ODR-MRK      PIC X.
*隞祥??
                        30 RTB-CHG-FLAG         PIC X(1).
*?芾祥??(?急??芰 880830 ??
                        30 RTB-ASU-PAY          PIC X(1).
                        30 RTB-APY-TYPE         PIC X.
                        30 RTB-APY-QTY          PIC 9(5)V9.
*> Y->閰脰?蝵桃?????
                        30 RTB-APT-YN           PIC X.
*> 900216 INSERT:
*> ??亙???嫣?瑼?摨?(ECB-FILE-NO)
                        30 RTB-ECB-FILE-NOX     PIC X(3).
                        30 RTB-ECB-FILE-NO REDEFINES RTB-ECB-FILE-NOX   PIC 9(3).
*> 900301 INSERT: 摨怠?撠蝣?
                        30 RTB-STK-CNT          PIC X(13).
*> 鈭?撖拇?(940105)
                        30 RTB-PRD-YN           PIC X(1).
                        30 RTB-FILLER1          PIC X(15).
*> ****************************************************************************
*>      END     OF      FILE
*> ****************************************************************************
*> 103.06.27 END
*>2019/12/24 ??IS
*>?芷??撖信R_UDL3
*COPY    "HR_UDL3.MST".
*>--------------------------------------------------------------------------------------*
*>              雿?思誘[瑼ａ?瑼Ｘ?曉?]?啣?閮?瑼?HR_UDL3.MST           瑼?嚗R_UDL3   *
*>--------------------------------------------------------------------------------------*
*>              銝鳴?HRUDL3-MST-KEY                                                      *
*>              ?荔?HRUDL3-ALT-KEY1 = HRUDL3-UPD-DTI HRUDL3-MST-KEY                     *
*>              ?荔?HRUDL3-ALT-KEY2 = HRUDL3-STATUS HRUDL3-MST-KEY                      *
*>--------------------------------------------------------------------------------------*
 FD      HRUDL3-MST         EXTERNAL.
 01      HRUDL3-MST-REC.
*$XFD USE GROUP
*57
        02      HRUDL3-MST-KEY.
*>              ?啣??交?(1:8)
                03      HRUDL3-C-DATE                           PIC X(08).
*>              ?啣???(9:6)
                03      HRUDL3-C-TIME                           PIC X(06).
*>              雿摨?(15:20)
                03      HRUDL3-PATIENT-SEQ                      PIC X(20).
*>              瘚偌摨?35:3)
                03      HRUDL3-ORDER-SEQ                        PIC 9(03).
*>              KEY-FILLER(38:20)
                03      HRUDL3-KEY-FILLER                       PIC X(20).
*24
*$XFD USE GROUP

*>      ?啣??交?
        02      HRUDL3-UPD-DTI.
*>              ?啣??交?(1:7)
                03      HRUDL3-UPD-DT                           PIC 9(07).
*>              ?啣???(8:8)
                03      HRUDL3-UPD-TIME                         PIC 9(08).
*>              ?湔???蝛箇?:?芣?唳??芣???Y:?湔????(16:1)
        02      HRUDL3-STATUS                                   PIC X(01).
*>      ?風??
        02      HRUDL3-PAT-NO                                   PIC 9(08).
*250
*$XFD USE GROUP , VAR-LENGTH
    02  HRUDL3-DATA-1.
*>              瑼?摨?(1:10)
                03      HRUDL3-FILE-NO                          PIC 9(10).
*>              ?????11:1)
                03      HRUDL3-STATUS-FLAG                      PIC X(01).
*>              ?蔭隞?Ⅳ(12:12)
                03      HRUDL3-ODR-CODE                         PIC X(12).
*>              甈∪?????(24:7)
                03      HRUDL3-DOSE-MOLE                        PIC 9(05)V9(02).
*>              甈∪?????(31:5)
                03      HRUDL3-DOSE-DENO                        PIC 9(05).
*>              ??(36:10)
                03      HRUDL3-METHOD-CODE                      PIC X(10).
*>              ??憭拇(46:4)
                03      HRUDL3-DAYS                             PIC 9(04).
*>              ????50:8)
                03      HRUDL3-B-DATE                           PIC X(08).
*>              ????(58:4)
                03      HRUDL3-B-TIME                           PIC X(04).
*>              蝯???62:8)
                03      HRUDL3-E-DATE                           PIC X(08).
*>              蝯???(70:4)
                03      HRUDL3-E-TIME                           PIC X(04).
*>              蝮賡?-??(74:7)
                03      HRUDL3-NUM-MOLE                         PIC 9(05)V9(02).
*>              蝮賡?-??(81:5)
                03      HRUDL3-NUM-DENO                         PIC 9(05).
*>              ?乩?閮餉?(86:1)
                03      HRUDL3-ER-FLAG                          PIC X(01).
*>              ?芾祥霅(87:1)
                03      HRUDL3-OWN-FLAG                         PIC X(01).
*>              閮?孵?(88:1)
                03      HRUDL3-VAL-SWITCH                       PIC X(01).
*>              ?阡??(89:1)
                03      HRUDL3-BRAIN-FLAG                       PIC X(01).
*>              ?其?(90:1)
                03      HRUDL3-POSITION-FLAG                    PIC X(01).
*>              ???怠葦(91:10)
                03      HRUDL3-DR-CODE                          PIC X(10).
*>              撖虫??怠葦銝(101:10)
                03      HRUDL3-CARRY1-CODE                      PIC X(10).
*>              撖虫??怠葦鈭?111:10)
                03      HRUDL3-CARRY2-CODE                      PIC X(10).
*>              ?勗??怠葦(121:10)
                03      HRUDL3-REPORT-DR-CODE                   PIC X(10).

*>              ??葆??(?園?)(131:1)
                03      HRUDL3-LNK-POINT-HEAD                   PIC X(01).
*>              ??葆??(摮?)(132:9)
                03      HRUDL3-LNK-POINT                        PIC X(09).
*>              ??葆????(141:6)
                03      HRUDL3-LNK-TIME                         PIC X(06).
*>              蝘恕隞?Ⅳ(147:1)
                03      HRUDL3-DPT-CODE                         PIC X(01).
*>              憿隞?Ⅳ(148:2)
                03      HRUDL3-CLS-CODE                         PIC X(02).
*>              瘚偌摨?150:6)
                03      HRUDL3-SERIAL-NO                        PIC X(06).
*>              ?思誘?隞?Ⅳ(156:6)
                03      HRUDL3-ITM-CODE                         PIC X(06).
*>              ?Ｗ鞎餌?隞?Ⅳ(162:4)
                03      HRUDL3-STD-CODE                         PIC X(04).
*>              摨怠?隞?Ⅳ(166:10)
                03      HRUDL3-STORE-CODE                       PIC X(10).
*>              2019/12/24 ?摨?(176:6)
                03      HRUDL3-CHG-BED                          PIC X(06).
*>              2019/12/24 ?桀?雿摨?(182:11)
                03      HRUDL3-NOW-IPD-NO.
                        04      HRUDL3-NOW-IPD-DATE             PIC 9(07).
                        04      HRUDL3-NOW-IPD-SEQ              PIC 9(04).
*>              2020/08/07 ?渡???曉?閮箇??銋?其?蝣?194:2)
                03      HRUDL3-NEW-POSITION-FLAG        PIC X(02).
*>              ??(196:56)
                03      HRUDL3-FILLER                           PIC X(56).
*$XFD USE GROUP , VAR-LENGTH
        02      HRUDL3-DATA-2.
*>              ?酉(1:80)
                03      HRUDL3-ODR-NOTE                         PIC X(80).
*>              ??(81:170)
                03      HRUDL3-DATA-2-FILLER                    PIC X(170).
*>閮?ICA撖急??航炊蝣墩7]
*COPY    "HR_LOG2.MST".
*-------------------------------------------------------------------------*
* ?亥那??啣?閮?瑼?HR_LOG2.MST                     瑼?嚗R_MLOG2      *
*-------------------------------------------------------------------------*
* 銝鳴?LOG2-MST-KEY = LOG2-RO-KEY LOG2-CRE-DATE LOG2-UPD-MRK LOG2-FEE-NO   *
* ?荔?LOG2-ALT-KEY1 = LOG2-RO-KEY LOG2-UPD-CNT LOG2-CRE-DATE LOG2-UPD-MRK *
*                     LOG2-FEE-NO                                         *
* ?荔?LOG2-ALT-KEY2 = LOG2-RO-KEY LOG2-DCRE-DATE LOG2-UPD-MRK LOG2-FEE-NO *
*-------------------------------------------------------------------------*
 FD      LOG2-MST                EXTERNAL.
 01      LOG2-MST-REC.
*> ?摨?
*$XFD USE GROUP, VAR-LENGTH
        02      LOG2-RO-KEY.
                03      LOG2-RO-NO.
                        04      LOG2-RO-DATE    PIC 9(07).
                        04      LOG2-RO-SEQ     PIC 9(04).
                03      LOG2-ODR-SEQ            PIC 9(02).
        02      LOG2-ID-KEY REDEFINES LOG2-RO-KEY.
*> 閮?雿?思誘?賊??航炊?[A]ICA撖急?銝???[B]瑼ａ??唾撓閮?
                03      LOG2-ID                 PIC X(01).
                03      LOG2-ID-SEQ             PIC 9(02).

                03      LOG2-ID-FILLER          PIC X(10).
*> ?啣??乓??? (甇??)
*$XFD USE GROUP, VAR-LENGTH
        02      LOG2-CRE-DATE.
                03      LOG2-CRE-DT             PIC 9(07).
                03      LOG2-CRE-TI.
                        04      LOG2-CRE-HH     PIC 9(02).
                        04      LOG2-CRE-MM     PIC 9(02).
                        04      LOG2-CRE-SS     PIC 9(02).
*> ?啣??乓??? (??)
*$XFD USE GROUP, VAR-LENGTH
        02      LOG2-DCRE-DATE.
                03      LOG2-DCRE-DT            PIC 9(07).
                03      LOG2-DCRE-TI.
                        04      LOG2-DCRE-HH    PIC 9(02).
                        04      LOG2-DCRE-MM    PIC 9(02).
                        04      LOG2-DCRE-SS    PIC 9(02).
*> ?啣?甈⊥
        02      LOG2-UPD-CNT                    PIC 9(04).
*> ?啣?蝣?(C:?啣?)
        02      LOG2-UPD-MRK                    PIC X(01).
*> 摨?
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
 77 蝝唳?擃?2
           USAGE IS HANDLE OF FONT.
 77 蝝唳?擃?1
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
*>---98.02.02憓?霈?文?臭蜓蝔???臭蜓撘?
*------>?交???
*COPY    "ZD_DTI.WRK".
*
* ZD_DTI.WRK ... ?交??? ...
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
*  ZS_DFF.WRK --- ??萄潸身摰?---
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
* ALT-FUN-KEY --- ?思??雿輻 ...
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
*------>?交?瑼Ｘ
*COPY    "ZD_CHK.WRK".
*
* ZD_CHK.WRK ... CALL "ZDCHKCF" USING W-DTCHK-TBL.  --- 16 BYTES ---
*            --- ?交?瑼Ｘ ...
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
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `A' 銵函內撟游?閮梁  01 --嚚?撟?
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = ` ' 銵函內撟游??賜  69 --嚚?撟?
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `C' 銵函內撟游??賜 隞僑--嚚?撟?
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `S' 銵函內?交?? 隞予--嚚?撟?
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `M' 銵函內?交?? ?祆?--嚚?撟?
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `L' 銵函內?交?? 銝?--嚚?撟?
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `R' 銵函內?交?? ?餃僑--嚚?撟?
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `D' 銵函內?交??  01 --嚚?憭?
*
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `1' 銵函內撟游?閮梁  01 --??撟?
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `2' 銵函內撟游??賜  69 --??撟?
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `3' 銵函內撟游??賜 隞僑--??撟?
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `4' 銵函內?交?? 隞予--??撟?
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `5' 銵函內?交?? ?祆?--??撟?
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `6' 銵函內?交?? 銝?--??撟?
* ??CALL "ZDCHKCF" ??閮剖? W-YYALL-SW = `7' 銵函內?交?? ?餃僑--??撟?
*
******-------------------------------------????撟?銵函內隞僑韏瑚?憭批?撟?
*
* YYSW      : 雿輻撟湔?閮剖?     -- 4:雿輻?Ⅳ镼踹?撟?2:鈭Ⅳ镼踹?撟? 蝛箇銵其蝙?典?撟?
* YYDEF     : 撟游漲????    -- 镼踹?撟湔?蝞蝙?典?撟游???靘?1911, 0 閬?1911)
* YYCOM     : 撟游漲閮??孵?     -- 镼踹?撟渲?蝞蝙?典?撟湔撘?靘?+,-, 蝛箇閬? - )
*
* ???交?撖拇敺?W-DTCHK-SW = `Y' 銵?蝷???????甇?蝣??? ??????隤?
*
*COPY    "ZD_YMD.WRK".
*
* ZD_YMD.WRK ...
*
* YYSW   : 雿輻撟湔?閮剖?     -- 4:雿輻?Ⅳ镼踹?撟?2:鈭Ⅳ镼踹?撟? 0:銵其蝙?函?啣?撟?
* YYDEF  : 撟游漲????    -- 镼踹?撟湔?蝞蝙?典?撟游???靘?1911, 0 閬?1911)
* YYCOM  : 撟游漲閮??孵?     -- 镼踹?撟渲?蝞蝙?典?撟湔撘?靘?+,-, 蝛箇閬? - )
* YDFSW  : 霈??..
*
* YYB    : 撟游漲 (頧???
* DATE1  : ?交? (頧???6 蝣?
* YYS    : - 銵刻???撟游漲?箄???
* DATE   : ?交? (頧?敺?8 蝣?
* TIME   : ?? ( 6 蝣?
* TIME8  : ?? ( 8 蝣?
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
*** ZP_RUNS.LNK ... ?瑕漲:6000 --- ( ZP_RUNSL.LNK LINK 雿輻 ) ...
*               --- TAMIS 蝟餌絞?銵?...
*
* -PSD-------------------------------------------------------
* USER  : 雿輻?誨蝣?
* CFID  : 摰Ｘ瑼?霅  --- ?批捆?摭ATUNG?”閬??亙?PSD-CFID (ZPSEMSF)
* USID  : 雿輻?撌亦楊??
* PID   : 頨思遢閮澆???
*
* PASS  : 雿輻??蝣?
* FLP   : ??(撖Ⅳ)
* PSPM  : 撖Ⅳ瑼Ｘ蝣?
* RMK1  : 鞈?瑼Ｘ?批捆
*           PES   : 蝟餌絞隞?Ⅳ  (PES)
*           PDATE : 撣唾?雿輻?唳???
*           UDATE : ?餈蝙?冽??
*           CDATE : ?餈?啣?蝣潭??
*           IMP   : 銝剜?頛詨瘜?-- ?舐 1,2,3,4,5,6,8,9,0
*           FGP   : SMT ?瑼Ｘ蝢斤?, ?桀? SYSTEM-TREE ?恍????E & U,
*                       TA 銵函頂蝯梁恣?, ??SMT-SID = E,U, ?券
*                       TS 銵函摰蝙?刻? E & U ),
*                       TU 銵其??砌蝙?刻? E & U ),
*           FL1   : ??
*           DPT   : ???撅砍雿?
*           FL2   : ??
*           CHG   : N-->?桐?蝪賢撖Ⅳ霈銝?甇交?唳迨撣唾?銋?蝣?
*           LOGCT : ?餃甈⊥
* RMK2  : 鞈?瑼Ｘ?批捆
*           PNAME :?∪極憪?
*           RMK21 :??
*           PTEL  :?餉店
*           PTSN  :??
*
* -PSP-------------------------------------------------------

* PAR1      : 鞈?瑼Ｘ?批捆
* PAR2      : 鞈?瑼Ｘ?批捆
*
* -SEM-TMS---------------------------------------------------
* TAMIS : 霅蝣?      --- TAMIS (?箏?雿輻)
*
* -SEM-CID---------------------------------------------------
* CHKSW     : 瑼Ｘ蝣?                 -- TATUNG OK
* MASTER    : 摰Ｘ銝餃霅            -- 蝛箇 ??M 銵函蜇?? S 銵典???
* SYSID1    : 嚗湛慼嚗哨憬嚗喟頂蝯梯???1    -- TAMIS
* SYSID2    : 嚗湛慼嚗哨憬嚗喟頂蝯梯???2    -- T A M I S
* FAMILY    : 蝟餌絞銝餅?霅            -- D.G. AV/3750
* VERSION   : 蝟餌絞嚗荔撲?            -- AViiON UX 5.4 ??
* COPYRIGHT : 蝟餌絞?????           -- 嚗湛慼嚗哨憬嚗單???
*             ??C)Copyright Tatung Co., All rights reserved. On 1-APR-84'
* SYSNM1    : 蝟餌絞璅?                -- 蝬? ?? 鞈? 閮? ?? ?? 蝟? 蝯?
* FL-CID    : 蝟餌絞閮剖???
*
* -SEM-MIS---------------------------------------------------
* CFNO-S    : 摰Ｘ瑼?蝺刻?     --- 蝯曹?閮餃?蝺刻?, ??銝征?? ?寞??瘜?雿輻
*             HOSP1 : 摰Ｘ霅,  靘? ?怎? -- 01:銵?蝵?10嚗?摰?07嚗?摰?..
*             HOSP2 : 霅??,  靘? ?怎? -- 01:蝚砌?摰? 02嚗洵鈭振, ....
* COPD      : 雿輻霅,     靘? ?怎? -- C 銵冽?恍?葉?恍?閮?
* DBID      : 鞈?摨怨???      -- S:SYB, O:ORA, I:INF, V:VISION,
* CHRID     : 頛撌脤?敶?    -- C:銵刻??瑁?頛雿平
* LOGID     : 蝟餌絞蝪賢閮?,    -- N:銵其?閮?,擗”閬???
* BMPID     : ??撅內         -- 蝛箇銵刻??瑁???撅內, N:銵其?撅內
* HIDID     : 瑼???霅     -- 鞈???霅 -- TP,TC, ,...
* FL-SR     : ??
* ACUGT     : RUNTIME ?霅 -- Y 銵其蝙??ACUGT ??RUNTIME
* NEWET     : PRINT ?啗”霅   -- W 銵其蝙??winprint ?啗”
* ACULK     : ACULOCK ?霅 -- Y 銵其蝙???啁? ACULOCK
* LNOSW     : ?瑁?蝺楝瑼Ｘ     -- Y 銵刻??瑁?蝟餌絞蝺楝閮剖?瑼Ｘ
* PEPSW     : 雿輻?餃??風?亥岷 -- Y 銵冽?雿輻?犖?餃??風?亥岷蝟餌絞
* VERSW     : 蝟餌絞?         -- 蝛箇銵券?憎?? Y 銵剁憮?? L 銵冽?擗函?
* VERID     : 蝟餌絞?活         -- 蝛箇銵其蝙?其??祉???, ?嗡??”?孵???
* APLSW     : 雿輻?喳銝餅?     -- Y 銵冽?雿輻?喳銝餅?蝟餌絞
* RPASW     : 銝??亙?撖Ⅳ瑼Ｘ -- N 銵券?桀?蝣潸身摰?R ?????蝣潭炎????)
* PSDID     : 撖Ⅳ瑼Ｘ憿舐內?孵? -- D:銵券＊蝷箏?蝣? 擗?(SECURE)銝＊蝷箏?蝣?
* PDAY      : 撖Ⅳ霈???交   (?敺?甈∟??渲????? ??瘙??游?蝣?
* VBMSW     : 蝟餌絞?嗆?閮剖?     -- C 銵其蝙?每lient-server
*                                 V 銵其蝙?汽hin-client
*                                 B 銵其蝙?汽hin-client ??Client-server 瘛瑞
*                                 M 銵其蝙?沈ost-terminal
* LCESW     : 蝟餌絞隤??     -- C 銵其葉??, E 銵刻??
* YYSW      : 雿輻撟湔?閮剖?     -- 4:?Ⅳ镼踹?撟?2:鈭Ⅳ镼踹?撟? 0 銵其蝙?函?啣?撟?
* YYDEF     : 撟游漲????    -- 镼踹?撟湔?蝞蝙?典?撟游???靘?1911, 0 閬?1911)
* YYCOM     : 撟游漲閮??孵?     -- 镼踹?撟渲?蝞蝙?典?撟湔撘?靘?+,-, 蝛箇閬? - )
* SMTSW     : 蝟餌絞霅憿舐內?孵? -- A 銵典?券＊蝷? 擗?憿舐內 USER ?詨?銋???
* SBRSW     : 蝟餌絞?詨憿舐內?孵? -- A 銵典?券＊蝷? 擗?憿舐內 USER ?詨?銋???
* TCVER     : Thin-client ? -- A 銵其蝙?杗CU?? C 銵其蝙?每ITIRX?? 蝛箇銵典隞?
* INOLH     : 頨思遢閮澆??摨?  -- 0 銵其蝙??10 蝣? 擗?閮剖?
* TELLH     : ?餉店?Ⅳ?瑕漲     -- 0 銵其蝙??10 蝣? 擗?閮剖?
* TSNLH     : ?餉店???瑕漲     -- 0 銵其蝙?? 4 蝣? 擗?閮剖?
* VNOLH     : 撱?蝯梁Ⅳ?瑕漲     -- 0 銵其蝙?? 8 蝣? 擗?閮剖?
* HSTID     : 銝餅?霅         -- XXXX 靘?S1
* HSTIP     : 銝餅?雿?         -- XXX.XXX.XX.XXX 靘?139.XXX.XX.XXX

* HSTOS     : 銝餅?雿平蝟餌絞     -- D:MS-DOS, W:WINDOWS, N:WIN/NT, U:Unix,
*                                 A:AOS/VS, O:OS/2, V:VAX/VMS, S:AMOS, M:MPE/iX,
* LDAY      : 撖Ⅳ蝳???交 (?敺?甈∠偷?亥????? ??甇Ｗ?雿輻)
* SMHID     : Y 銵函頂蝯望?憭?閮剖?
* THID      : A--Z 銵函蜇?銋??霅
* UWDLH     : 撖Ⅳ???撠??瑕漲 --- 靘?6 銵冽?撠?6 雿, 0 銵其???
* UWDSW     : 撖Ⅳ?批捆?? --- N:?詨?, A:??, X:?摮? 擗???
* SCLNO     : 蝟餌絞閮剖?蝺楝?Ⅳ -- VBMSW ??V ??B ??閬身摰?
* EMISW     : 鞈???憿舐內霅 -- E 銵刻?憿舐內?餃???,  M 銵刻?憿舐內?餃??萎辣,
*                                 I 銵典憿舐內?砍??,  擗”閬迤撣賊＊蝷?
*                                 W 銵沌OP-UP閬?
* FBSW      : Y 銵冽?雿輻敺?寞活雿平蝟餌絞
* WEBSW     : Y 銵典??典?刻?閮雯?桐?蝪賢?
* USERSW    : Y 銵典銝蝪賢?舫HIS雿輻?董??
* FUNSW     : Y 銵冽???賡?閮剔甈?
* ACULOCKSW : Y 銵函摰蝙?刻?券閫?????賡?閮剔甈?
* OFFCHK    : Y 銵券撣思??炎??
* SUPDRCHK  : Y 銵冽?湧撣急炎??
* FL-MIS    : 蝟餌絞閮剖???
*
* -SEM-UNM-----------------------------------------------------
* UNAME1    : 摰Ｘ?迂1  (蝪∠迂)
* UNAME2    : 摰Ｘ?迂2
* UNAME3    : 摰Ｘ?迂3
* UNAME4    : 摰Ｘ?迂4  (?函迂)
*
* -SEM-UID-----------------------------------------------------
* BOSS      : 摰Ｘ鞎痊鈭?
* ITNM      : 鞈?鞎痊鈭?
* VNO       : 摰Ｘ蝯梁楊
* FL-UID    : 蝟餌絞閮剖???
* TEL1      : ?餉店-1
* TSN1      : ??-1
* TEL2      : ?餉店-2
* TSN2      : ??-2
* FAX       : ?喟?-1
* FSN       : ??-1
* MAIL      : e-mail
* ADR       : ?啣?
*
* -SEM-RDV-----------------------------------------------------
* RCO       : 蝟餌絞??砍
* RDPT      : 蝟餌絞??券?
* RPM       : 蝟餌絞鞎痊鈭?
* RVNO      : ??砍蝯梁楊
* RFL-RDV   : 蝟餌絞閮剖???
* RTEL1     : ?餉店-1
* RTSN1     : ??-1
* RTEL2     : ?餉店-2
* RTSN2     : ??-2
* RFAX      : ?喟?-1
* RFSN      : ??-1
* RMAIL     : e-mail
* RADR      : ?啣?
*
* -SMT-------------------------------------------------------
* SID       : 蝟餌絞?霅     --- E 銵典銵???   U 銵刻閮剔?撘銵?

*                                  G 銵冽風?脰???1, H 銵冽風?脰???2
*                                  S 銵函頂蝯梁恣??
* GNO1      : 蝟餌絞蝢斤?蝚砌???  --- 靘?23??蝟餌絞
* GNO2      : 蝢斤??活蝚砌???  --- 靘?00??蝟餌絞 , 01鞎⊥?, 02?箇?, 03??
* GNO3      : 蝢斤??活蝚砌???  --- ??
* SEQ1      : 蝟餌絞蝢斤?蝚砌???摨?
* SEQ2      : 蝢斤??活蝚砌???摨?
* SEQ3      : 蝢斤??活蝚砌???摨?- ??
* PCTL-S    : 蝔??瑁??批蝣?  --- 蝛箇,P,L,C,S,W,H,T,,,
* DES-S     : 蝟餌絞隤芣??膩
* PRG-S     : ??銋?撘??誘??
* SPRG-S    : ???澆銋蝔?
* USE-S     : 蝔?銋?USING ?批捆
* SBUD-S    : ?詨雿輻霅     --- U 銵其蝙?刻閮剔頂蝯? 蝛箇銵?TAMIS 蝟餌絞摰儔
* SBGP-S    : ?詨蝢斤?
* SBRT-S    : ?詨擐?
* LNKC-S    : CALL ????撘?蝔?
* SETP-S    : 閮剖????澆銋蝔?
* PSPP-S    : 蝟餌絞?閮剖????澆銋蝔?
* SCESW-S   : 蝟餌絞隤??     --- C 銵其葉??, E 銵刻??
* FBSW-S    : Y 銵刻????圈??
*           : B 銵刻????啁憓??詨銝?)
*           : 蝛箇銵其??憓身摰?
* SMT-S     : ??
*
* -SMU-------------------------------------------------------
* GID       : 雿輻?黎蝯誨蝣?
* FL-SMU    : ??
*
* -SBR-------------------------------------------------------
* CFNO      : 摰Ｘ瑼?蝺刻?     --- 蝯曹?閮餃?蝺刻?
* SBUD      : ?詨雿輻霅     --- U 銵其蝙?刻閮剔頂蝯? 蝛箇銵?TAMIS 蝟餌絞摰儔
* SBGP      : ?詨蝢斤?         --- HAA01.....
* PSID      : 雿平蝺函Ⅳ蝟餌絞??  --- 靘楊蝣潸??身摰?靘?HAC
* PSNO      : 雿平蝺函Ⅳ霅     --- 靘楊蝣潸??身摰?靘?HGNIDKF-2399
* BNO1      : ?詨蝢斤?蝚砌???  --- 01        蝯?: 010000
* BNO2      : ?詨蝢斤?蝚砌???  --- 01                010100
* BNO3      : ?詨蝢斤?蝚砌???  --- 01                010200 -> 010201
* BNO4      : ?詨蝢斤?蝚砍???  --- ??                        010202
* BNO5      : ?詨蝢斤?蝚砌???  --- ??              010300
* PCTL-B    : 蝔??瑁??批蝣?  --- 蝛箇,P,L,C,S,W,H,T,,,
* DES-B     : 蝟餌絞隤芣??膩
* PRG-B     : ??銋?撘??誘??
* SPRG-B    : ?舐?撘?
* USE-B     : 蝔?銋?USING ?批捆
* SLSW-B    : ?霅         --- | 銵券?銝蝺? X 銵冽?蝷粹?, * 銵求ISABLE?賊?,
*                                                - 銵冽?蝷粹?銝?銝蝺?
* BCESW-B   : 蝟餌絞隤??     --- C 銵其葉??, E 銵刻??
* SBR-B     : ??
*
* -SBF-------------------------------------------------------
* RIGHT     : 雿平甈?         --- 蝛箇:?臭蝙?? *:銝雿輻
* SUPDR     : Y銵刻身摰?舀?怠葦
* FL-SBG    : ??
*
* -EXE-------------------------------------------------------
* CTL       : 蝔??瑁??批蝣?  --- 蝛箇,P,L,C,S,W,H,T,,,

* DES       : 蝟餌絞隤芣??膩
* PRG       : ??銋?撘??誘??
* SPRG      : ???澆銋蝔?
* PARA      : ?瑁???瑼? USING ?批捆?喲?
*             ??批捆?勗銵??? MNU-USE ??
* LNK       : CALL ????撘?蝔?
* FILLX     : ??
*
* -UGH-------------------------------------------------------
* ENDP      : E 銵典?怠蝔?敺??啣虜蝯迫敺銝銵Ⅳ
* GHSW      : 蝚砌?(G), 鈭?H)甇瑕鞈?閮剖?, 蝛箇銵冽迤撘局(F)
* HYYY      : 蝚砌?甇瑕鞈??亥岷銋僑摨?憭扳 0 銵冽?閮剖?甇瑕撟游漲)
* HPTH      : H PORT 銋?PATH --- @av37:\history2\092.dir\
* ENVF      : ENV ?批捆摮銋??? --- ZS_ENV撟湔??交???敺桃?.蝺楝USER-ID
*                                      (ZS_ENV92042819302010.V0136..........)
* SEMF      : SEM ?批捆摮銋??? --- ZS_SEM撟湔??交???敺桃?.蝺楝摰ＸUSER
*                                      (ZS_SEM92042819302010.V0136..........)
* RUNF      : RUN ?批捆摮銋??? --- ZS_RUN撟湔??交???敺桃?.蝺楝摰ＸUSER
*                                      (ZS_RUN92042819302010.V0136..........)
* MCNT      : SMT 蝮賜???
* MOCC      : SMT 雿輻蝯
* SMTF      : SMT ?批捆摮銋??? --- ZS_SMT撟湔??交???敺桃?.蝺楝摰ＸUSER
*                                      (ZS_SMT92042819302010.V0136..........)
* BCNT      : SBR 蝮賜???
* BOCC      : SBR 雿輻蝯
* SBRF      : SBR ?批捆摮銋??? --- ZS_SBR撟湔??交???敺桃?.蝺楝摰ＸUSER
*                                      (ZS_SBR92042819302010.V0136..........)
* CCNT      : SBC 蝮賜???
* COCC      : SBC 雿輻蝯
* SBCF      : SBC ?批捆摮銋??? --- ZS_SBC撟湔??交???敺桃?.蝺楝摰ＸUSER
*                                      (ZS_SBC92042819302010.V0136..........)
* FILLU     : ??
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
* FILLR     : ??
*
* -STM-------------------------------------------------------
* OS        : OS ID. --- DOS--\, UNIX--/, AOS--:
* OSNM      : OPERATING-SYSTEM
* WINSW     : W:OS-IS-WIN-FAMILY --- WINDOWS & WIN/NT
* OSID      : D:MS-DOS, W:WINDOWS, N:WIN/NT,  U:Unix,
*             A:AOS/VS, O:OS/2     V:VAX/VMS, S:AMOS, M:MPE/iX,
* USERID    : USER-ID
* STATID    : STATION-ID
* VERSION   : RUNTIME-VERSION ?
* PLUGIN    : Y:IS-PLUGIN
* SERNO     : SERIAL-NUMBER
* 98XP      : 9:銵?8?餉, 2:銵?000?餉, X:銵汴P?餉. 7:WINDOWS7, 8:WINDOWS8,

*             V:VISTA   , 3:Windows Server 2003
* PC-BIT    : WINDOSW 7 ??8,1:32 bits ??64 bits
* PC-IP     : ?餉IP
* PC-NAME   : ?餉?迂
* PC-MAC    : ?餉MAC
* FILLS     : ??
*
* -ENV-------------------------------------------------------
* DBC       : CODE-SYSTEM
* TYPE      : TYPE ?誘     ( WIN/DOS/AOS:TYPE, UNIT:cat )
* COMD      : COMMAND ?誘  ( NT:CMD, WIN:COMMAND.COM /C, DOS:COMMAND.COM )
* MHIDO     : ???霅 --- ???閮剖??蝙??
* MHIDN     : ?啣??霅 --- ???閮剖??蝙??
* MHDNM     : 憭?霅?迂
* FILLE     : ??
* VMSW      : 蝺楝霅 -- V 銵刻??砌蜓璈?頝荔?M 銵其蜓璈?頝? C 銵函雯頝舐?頝?
* SLNO      : 蝟餌絞蝺楝?Ⅳ 靘?0096
* SLNO1     : 蝟餌絞蝺楝?Ⅳ 靘?96
* SLBF      : 璅惜雿蔭
* FILLV     : ??
*
* -CBL-------------------------------------------------------
* CPREFIX   : CODE-PREFIX              --- m:\lsy.dir;m:\ler1.dir;...
* FPREFIX   : FILE-PREFIX              --- n:\lmisa
* XFDDIR    : XFD-DIRECTORY            --- m:\lfd.dir
* CODESTM   : CODE-SYSTEM              --- BIG5
* FILLB     : ??
* WINTITLE  : WINDOW-TITLE             --- LMIS(M)
* DEFHOST   : DEFAULT-HOST             --- SYBASE
* DATABASE  : A-SYB-DATABASE           --- lmisa1
* DEFCONT   : A-SYB-DEFAULT-CONNECTION --- SYB_LMIS
* LOCKDB    : A-SYB-LOCK-DB            --- lmisa1
* LOGIN     : A-SYB-LOGIN              --- .....
* PASSWD    : A-SYB-PASSWD             --- .......
* FILLC     : ??
* MPTH      : ZS_MPTH                  --- ZS_MPTHL
* SZMS      : ZS_SZMS                  --- c:\lmisa\
* SCMS      : ZS_SCMS                  --- c:\lmisa\
* SFMS      : ZS_SFMS                  --- n:\lmisa\
* SWIN      : ZS_SWIN                  --- c:\lwin\
* FILLL     : ??
* SCID      : ZS_SCID                  --- ?Ｙ?蝟餌絞銋恥?嗆?獢???
* SVER      : ZS_SVER                  --- 蝟餌絞?         --> VERSW
* SVBM      : ZS_SVBM                  --- 蝟餌絞?嗆?閮剖?     --> VBMSW
* SLCE      : ZS_SLCE                  --- 蝟餌絞隤??     --> LCESW
* SYYW      : ZS_SYYW                  --- 雿輻撟湔?閮剖?     --> YYSW
* SYDF      : ZS_SYDF                  --- 撟游漲????    --> YYDEF
* SYCM      : ZS_SYCM                  --- 撟游漲閮??孵?     --> YYCOM
* SHID      : ZS_SHID                  --- 銝餅?霅         --> HSTID
* SHIP      : ZS_SHIP                  --- 銝餅?雿?         --> HSTIP
* SHOS      : ZS_SHOS                  --- 銝餅?雿平蝟餌絞     --> HSTOS
* STCV      : ZS_STCV                  --- Thin-client ? --> TCVER
* STMS      : ZS_STMS                  --- T-c 銋?client 頝臬? --- c$:\lmisa\
* SOFF      : ZS_SOFF                  --- OF 銵券蝺?璆剔頂蝯?
* SLLC      : ZS_SLLC                  --- 蝺楝蝪賢瑼Ｘ蝣? 靘? o,q,m,x,r,w,..
* SEPG      : ZS_SEPG                  --- /progs/
* SVSN      : ZS_SVSN                  --- /vision

* SVSF      : ZS_SVSF                  --- /vision/lmisa/
*
* -PTH-------------------------------------------------------
* SCNT      : ??PATH鞈?蝑
* SOCC      : ??唬?甈∩??詨?蝯
* HLOC      : H PORT 銋yy.dir銋?蝵?
* FILLH     : ??
* 1:Z, 2:C, 3:A, 4:B, 5:E, 6:F, 7:G, 8:H, 9:I, 10:J, 11:S, 12: ,... 16: ,..
* 1:z, 2:c, 3:a, 4:b, 5:e, 6:f, 7:g, 8:h, 9:i, 10:j, 11:s, 12: ,... 16: ,..
* PORT      : ? 蝣?     --- F 憭批神
* PORTL     : ? 蝣?     --- f 撠神
* PSLH      : ? 蝭暺?   --- DOS--\, UNIX--/, AOS--:
* PTH1      : ? 頝臬?-1  --- n:\
* PTH2      : ? 頝臬?-2  --- n:\hmisa\
*
* -DHS-------------------------------------------------------
* LDATE     : ??袂OGIN?交?
* LTIME     : ??袂OGIN??
* DATE      : ??啁頂蝯望??
* TIME      : ??啁頂蝯望???
* NDATE     : 蝬脰楝??啣???蝟餌絞?交?
* NTIME     : 蝬脰楝??啣???蝟餌絞??
*
* -WEK-------------------------------------------------------
* MONNM1    : ?之撖?       --- JANUARY -- DECEMBER
* MONNM2    : ??撖?       --- January -- December
* MONNM3    : ?陛撖?       --- JAN     -- DEC
* MONDAY    : ???       --- 31      -- 31
* MONFSP    : ??蝛箇??
* WKNM1     : ?勗??       --- Monday  -- Sunday
* WKNM2     : ?梁陛撖?       --- mon     -- SUN
* WKNM3     : ?曹葉??       --- 銝      -- ??
* WKNM4     : ?望??      --- 1       -- 7
* HOLIDAYS  : 蝟餌絞?      --- ?湔鈭箏?箏?? 蝛箇?典予?箏,
*                               * 銵典憭拇?? # 銵典?憭拙?? @ 銵券??勗隡?
* HOLIDAYD  : 蝯梯??
* HOLIDAYU  : 雿輻????
*             UDAY1(01)     --- 銵鈭箏?箏??
* WKFILLW   : ??
* DAYS-CNT  : 撟游漲?交      --- 365
* WKM-CNT   : ?勗
* WKY-CNT   : 撟湧勗
* WKFILLK   : ??
* WKFS      : Y 銵冽??????
*
* -PGB-------------------------------------------------------
* PRGUSE    : 蝔?LINK鞈??怠??
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
* ZP_RUNSE.LNK ...  --- TAMIS 蝟餌絞?銵?...
*
* W-RUNE-DATA : ??ZP_RUNS.LNK 銋?W-RUN-CHK(1:4500) 銋摰?
* W-RUNE-OK   : Y 銵函頂蝯梢脣?歇撠?W-RUN-CHK(1:4500) 摮 W-RUNE-DATA
*               擗?銝行摮??敺蝙??
*               ?孵瘜冽?: CALL PROGRAM "...." ??EXTERNAL ?舐??.
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
*******************************************************************************嚗?
*>      C-PY FILE : HI_ELC.WRK          ?餃??風/?喳銝餅? ?梁WORK
*>      ALSO USED BY 瑼ａ?瑼Ｘ?桀撐???
*>      900915 INSERT: W-USE-APY-YN
*******************************************************************************嚗?
 01      ELC-TRN-STATUS          PIC X(2)        EXTERNAL.
*> Y-> 銵函內?餃??風???
 01      W-ELC-YN                PIC X(1)                VALUE SPACE.
 01      W-ELC-MARK              PIC X(1)                VALUE SPACE.
*> Y-> 銵函內雿輻?喳銝餅?
 01      W-USE-APY-YN            PIC X(1)                VALUE SPACE.
*> ?澆HIELCCF ?喲?銋???
*COPY    "HI_ELCCF.LNK".
*-----------------------------------------------------------------------------*
*>      ?餃??風?亦?銋NK (靽格隢??)                                    *
*>      CALLED BY 1.雿?唾?雿平 2.雿?孵雿平 3.雿??乩?璆?4.雿?喳雿平 *
*-----------------------------------------------------------------------------*
 01      W-LNK-ELCCF.
*>      ?霅嚗?1.霈?頂蝯勗??賂??斗閰脤?臬銝??餃??風??曹蜓璈?
*>                02.??
*>                03.??
*>                11.雿?箸鞈?
*>                21.?孵
*>                31.???
*>                41.?喳銝餅??孵
*>                51.?喳銝餅????
        02 W-ELCCF-ID                                   PIC X(02).
*>      ?喳??臬銝??餃??風(Y/N)
        02 W-ELCCF-YN                                   PIC X(01).
        02 W-ELCCF-KEY                                  PIC X(30).
*>      雿摨?
        02 W-ELCCF-IPD-NO.
                03 W-ELCCF-IPD-DT                       PIC 9(07).
                03 W-ELCCF-IPD-SEQ                      PIC 9(04).
        02 W-ELCCF-NO                                   PIC X(11).
*>      ?摨?        (W-ELCCF-ID = "21")
        02 W-ELCCF-ODR-NO REDEFINES W-ELCCF-NO.
                03      W-ELCCF-INS-DATE                PIC 9(07).
                03      W-ELCCF-ODR-SEQ                 PIC 9(04).
*>      ??亥??孵???   (W-ELCCF-ID = "31")
        02 W-ELCCF-RTA-NO1 REDEFINES W-ELCCF-NO.
                03      W-ELCCF-RTA-NO.
                        05      W-ELCCF-RTA-DATE        PIC 9(07).
                        05      W-ELCCF-RTA-SEQ         PIC 9(03).
                03      W-ELCCF-RTA-FILLER              PIC X(01).
*>      ???瘜?C.?啣? M.靽格 D.?芷)
        02 W-ELCCF-MARK                                 PIC X(01).
*>      ?喳??航炊閮?瘜?Y/N)
        02 W-ELCCF-ERR                                  PIC X(01).

*>      ?喳??航炊閮
        02 W-ELCCF-NOTE                                 PIC X(60).
*>      ?喳??臬銝??喳銝餅?(Y/N)
        02 W-ELCCF-APY-YN                               PIC X.
*>      ??甈?
        02 W-ELCCF-FILLER                               PIC X(29).
*--------------------------------------------------------------------------
*>      嚗伐戮嚗扎嚗荔憐?嚗?摩嚗堆撕?嚗佗憬嚗穿憧?
*--------------------------------------------------------------------------
*******************************************************************************嚗?
*       END     OF      FILE
*******************************************************************************嚗?
*COPY    "HI_DTE.WRK".
*******************************************************************************
*>      C-PY FILE :     HI_DTE.WRK      ?喳???遢?梁WORK
*>      PROGRAM USED: HIOD1KF, HIOD2MF, HIOD3DF, HIRTNKF ,?思誘?賊?雿平
*>      890511 憓?: W-CHK-DTE-YMD
*>      901026 ??梢?瑼?瑟?勗蝔?(HILOCKCF)?斗嚗?撠????碉ARK (JAY)
*******************************************************************************
*78      W-MAX-DTE                               VALUE 40.
*01      W-DTE-TABLE.
*        03      W-DTE-CNT                       PIC 9(02).
*        03      W-DTE-TAB       OCCURS  W-MAX-DTE TIMES
*                                INDEXED BY W-DTE-INDEX.
*>              ?喳撟湔?
*                05      W-DTE-YM                PIC 9(05).
*>              Y->??
*                05      W-DTE-LOCK              PIC X(01).
*01      W-CHK-DTE-YM                            PIC 9(05).
*>      ??交?
 01      W-CHK-DTE-YMD                           PIC 9(07).
*>      ?臬瑼Ｘ?游董??(NID-1029)
 01      W-CHK-1029-YN                           PIC X.
*>      ?斗?游董???舐?撘?LNK(CALL FROM HILOCKCF)
 01      W-LNK-LOCKCF.
*>              ?霅嚗?1.霈?ID-1000?臬?斗?游董???
*>                        02.?文?游董????梢?瑼
*>                        03.?芸?亦?梢?瑼
        02      W-LOCKCF-ID             PIC X(2).
*>              ??交?
        02      W-LOCKCF-DT             PIC 9(7).
*>              NID-1000?臬?斗?游董???(W-LOCKCF-ID = "01")
        02      W-LOCKCF-CHK-YN         PIC X.
*>              ?臬??('Y'??)
        02      W-LOCKCF-YN             PIC X.
*>              ?喳?閮(W-LOCKCF-YN = "Y")
        02      W-LOCKCF-NOTE           PIC X(60).
*>              ??
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
*> KEY ??= 雿摨?+?摨?
        10 W-ICA-TMP-KEY.
*> 雿摨?(?曹??Ｙ隢?璆剔???箇?鈭箔??Ｗ銝摨?)
*$XFD USE GROUP
           20 W-ICA-TMP-IPD-NO.
              30 W-ICA-TMP-IPD-DATE           PIC 9(7).
              30 W-ICA-TMP-IPD-SEQ            PIC 9(4).
*> ?摨?(??交?+?瘚偌??
*$XFD USE GROUP
           20 W-ICA-TMP-ODR-NO.
*> ??交?(銝??嫣??交?,DEFAULT ?箇頂蝯望,?箏靽格銋?雿?>??航鋆?)
              30 W-ICA-TMP-INS-DATE           PIC 9(7).
*> ?瘚偌???箇洵撟曉撐銋???
              30 W-ICA-TMP-ODR-SEQ            PIC 9(4).
*$XFD USE GROUP,VAR-LENGTH
        10 W-ICA-TMP-GROUP-DATA1.
*> 蝯董摨?(甇斤???飛憿???蝑?撣喳???             (1, 3)
                20 W-ICA-TMP-SEG-SEQ                  PIC 9(3).
*> ?蝘隞?Ⅳ                                         (4, 4)
                20 W-ICA-TMP-DEPT-NO                  PIC X(4).
*> ??怠葦隞?Ⅳ                                         (8, 4)
                20 W-ICA-TMP-DR-NO                    PIC X(4).
*> ?頨思遢隞?Ⅳ                                         (12, 4)
                20 W-ICA-TMP-IDNT-NO                  PIC X(4).
*> ??澈隞?                                        (16, 4)
                20 W-ICA-TMP-IDNT-REF                 PIC X(4).
*> ?摨?                                             (20, 6)
                20 W-ICA-TMP-WARD.
                        30 W-ICA-TMP-BED-ROOM         PIC X(4).
                        30 W-ICA-TMP-BED-NO           PIC X(2).
*> ??蝔桅?                                             (26, 1)
                20 W-ICA-TMP-SERG-KND                 PIC X.
*> ??隞?Ⅳ(??銝)                                   (27, 7)
                20 W-ICA-TMP-SERG-NO                  PIC X(7).
*> 891009 SMSTL UPDATE :
                20 W-ICA-TMP-SERG-NO1 REDEFINES W-ICA-TMP-SERG-NO.
*> ???(雿?思誘雿輻)                               (27, 4)
                        30 W-ICA-TMP-ODR-TIME         PIC 9(4).
*> ??                                                 (31, 3)
                        30 W-ICA-TMP-SERG-FILLER      PIC X(3).
*> ??銝                                               (34, 4)
                20 W-ICA-TMP-OP1                      PIC X(4).
*> ??鈭?                                              (38, 4)
                20 W-ICA-TMP-OP2                      PIC X(4).
*> ??銝?                                              (42, 4)
                20 W-ICA-TMP-OP3                      PIC X(4).
*> ?憭抒?亙予??                                        (46, 3)
                20 W-ICA-TMP-RX-DAYS                  PIC 9(3).
*> ?憭批????) ==> ?亙??其遢 ...                      (49, 3)
                20 W-ICA-TMP-MAX-SEQ                  PIC 9(3).
*> ?亥??Ⅳ                                             (52, 4)
                20 W-ICA-TMP-PILL-NO                  PIC 9(4).
*> ?蝮賡?                                             (56, 9)
                20 W-ICA-TMP-NOM-AMT                  PIC S9(7)V9(2).
*> ?芸???                                             (65, 9)

                20 W-ICA-TMP-DIS-AMT                  PIC S9(7)V9(2).
*> ?其遢鞎???                                         (74, 9)
                20 W-ICA-TMP-PART-AMT                 PIC S9(7)V9(2).
*> ?芯???                                             (83, 9)
                20 W-ICA-TMP-SP-AMT                   PIC S9(7)V9(2).
*> ?喳??                                             (92, 9)
                20 W-ICA-TMP-APP-AMT                  PIC S9(7)V9(2).
*> ?澈隞賜?梢?憿?                                    (101, 9)
                20 W-ICA-TMP-REF-AMT                  PIC S9(7)V9(2).
*> 撌脫??                                             (110, 9)
                20 W-ICA-TMP-RCV-AMT                  PIC S9(7)V9(2).
*> ??駁??誨?? X(4) ==> X(5)                        (119, 5)
                20 W-ICA-TMP-USR-ID                   PIC X(5).
*> ???                                             (124, 4)
                20 W-ICA-TMP-INS-TIME                 PIC 9(4).
                20 W-ICA-TMP-UDP-DATA.
*> ??啣?鈭箔誨?? X(4) ==> X(5)                        (128, 5)
                        30 W-ICA-TMP-UPD-USR-ID       PIC X(5).
*> ??啣??交?                                         (133, 7)
                        30 W-ICA-TMP-UPD-DATE         PIC 9(7).
*> ??啣???                                         (140, 4)
                        30 W-ICA-TMP-UPD-TIME         PIC 9(4).
*> ??啣?蝣?                                          (144, 1)
                        30 W-ICA-TMP-UPD-MARK         PIC X.
*> ?潸?桐?                                             (145, 4)
                20 W-ICA-TMP-PILL-DEPT                PIC X(4).
*> 摨?蝑?                                             (149, 2)
                20 W-ICA-TMP-CLASS                    PIC X(2).
*> ?閮餉?       A, a->?箏?鞎餌, B->擐?? C->蝺交炎撽? F->隡?, G->?瑟??扯風,
*>                O->?閮箄?雿, U->UD, H->?澆?扯風     (151, 1)
                20 W-ICA-TMP-UD-MARK                  PIC X.
*> 頞??( Y - 頞?隞祥 )                             (152, 1)
*               20 W-ICA-TMP-EXT-SERV                 PIC X.
*> 890828 ??W-ICA-TMP-EXT-SERV, ?寧??衣鋆??雿?思誘雿輻)
                20 W-ICA-TMP-RMK-YN                   PIC X.
*> ?憿(Y-?交抒??? N-?Ｘ抒???                     (153, 1)
                20 W-ICA-TMP-BED-ID                   PIC X.
*> 蝝舐?憭拇(84.09.20)                                   (154, 3)
                20 W-ICA-TMP-COM-DAYS                 PIC 9(3).
*> ?其遢鞎?隞?Ⅳ(000:?隞質???001,002,003,004,005:?隞質???111:?芾祥)
*>             B01:?嗡?璈? ...                         (157, 3)
                20 W-ICA-TMP-IPD-PART                 PIC X(3).
*> 鞎?%(?雿?臭?畾萄????航????閬隞質?????????其遢鞎?)
*>        ( 0:?隞質??? 1:?交抒??輸隞質???10%, 2:?交抒???20%, 3:?交?
*>            ? 30%, 4:?Ｘ抒???5%, 5:?Ｘ抒???10%, 6:?Ｘ抒???20%,
*>          7:?Ｘ抒???30%  A:?芾祥 100%  B:?嗡?璈? 100%        (160, 1)
                20 W-ICA-TMP-RESPOND                  PIC X.
*> 蝺亥??? Y - On line ?,N - Batch ? S:撘瑕雿)        (161, 1)
                20 W-ICA-TMP-EMG-CD                   PIC X.
*> ?芸??活(?桐??蝞葉?望?撟暸???芸???銋炎撽?甈?           (162, 3)
                20 W-ICA-TMP-LB-CNT                   PIC 9(3).
*> ?芸??活?喳??( UPDATE 84.09.29)                           (165, 9)
                20 W-ICA-TMP-LB-APP-AMT               PIC 9(7)V9(2).
*> [T] ?董鞈? [D] ?芷?酉                                    (174, 1)
                20 W-ICA-TMP-DEL-MARK                 PIC X.
*> 靽?甈?
                20 W-ICA-TMP-FILLER                   PIC X(76).

                20 W-ICA-TMP-REF-DATA         REDEFINES W-ICA-TMP-FILLER.
*>                                                              (175, 9)
                   30 W-ICA-TMP-LB-PART-AMT           PIC S9(7)V9(2).
*> Y-> ??ICU ??                                              (184, 1)
                   30 W-ICA-TMP-BED-ICU               PIC X.
*> ?酉 [ ]銝?祉??[1]撣嗉 [2]???[3]撣貉??刻                 (185, 1)
                   30 W-ICA-TMP-PR-MRK                PIC X.
*> 頧炎 MARK ....                                               (186, 1)
                   30 W-ICA-TMP-CD00-MARK             PIC X.
*> ?Ｘ折隞質???憿?                                            (187, 8)
                   30 W-ICA-TMP-SLOW-PART-DEF         PIC X(8).
                   30 W-ICA-TMP-SLOW-PART REDEFINES  W-ICA-TMP-SLOW-PART-DEF  PIC S9(6)V99.
*> ?交折隞質???憿?                                            (195, 8)
                   30 W-ICA-TMP-QUICK-PART-DEF        PIC X(8).
                   30 W-ICA-TMP-QUICK-PART REDEFINES W-ICA-TMP-QUICK-PART-DEF PIC S9(6)V99.
*>                                                              (203, 3)
                   30 W-ICA-TMP-QUICK-DAYS-DEF        PIC X(3).
                   30 W-ICA-TMP-QUICK-DAYS REDEFINES W-ICA-TMP-QUICK-DAYS-DEF PIC 9(3).
*>                                                              (206, 3)
                   30 W-ICA-TMP-SLOW-DAYS-DEF         PIC X(3).
                   30 W-ICA-TMP-SLOW-DAYS REDEFINES W-ICA-TMP-SLOW-DAYS-DEF   PIC 9(3).
*> 蝯董?啣??交?                                                 (209, 7)
                   30 W-ICA-TMP-SEG-DATE              PIC 9(7).
*> 蝯董?啣???                                                 (216, 4)
                   30 W-ICA-TMP-SEG-TIME              PIC 9(4).
*> 摰?蝯董蝺刻?                                                 (220, 3)
                   30 W-ICA-TMP-SEG-NO                PIC 9(3).
*> ?撱箸???                                                  (223, 7)
                   30 W-ICA-TMP-CRE-DT                PIC 9(7).
*> ?粹?孵?喳靽格??                                          (230, 5)
                   30 W-ICA-TMP-APY-USR               PIC X(5).
*> ?思誘霅 Y->?思誘蝟餌絞?Ｙ?銋???                              (235, 1)
                   30 W-ICA-TMP-DR-YN                 PIC X(01).
*> Y->??敦?怠???閬隞?890630 憓?                    (236, 1)
                   30 W-ICA-TMP-ANN-YN                PIC X(01).
*> 嚗?摨急?仿?閮剖?撣園?閮箏澈?? 嚗?摨急?仿?閮剖?撣園?閮箏澈??        (237, 1)
                   30 W-ICA-TMP-OPD-YN                PIC X(01).
*> Y->銵函內?撅?撠??(霈ICR-SON)                             (238, 1)
                   30 W-ICA-TMP-EXP-YN                PIC X(01).
*> ???亥?                                                     (239, 4)
*> 甈脖蝙?冽迨甈??? 隢??文?臬?摸UMERIC, ?血???NON-NUMERIC 銋?憿?
                   30 W-ICA-TMP-OLD-PILL-NO             PIC 9(04).
                   30 W-ICA-TMP-FILLER1               PIC X(08).

*> ***************************************************************************
*>      END     OF      FILE
*> ***************************************************************************
*COPY    "HI_ICB.WRK".
*******************************************************************************
*       C-PY FILE :     HI_ICB.WRK      USED BY : HIOD1KF, HIOD2MF, HIOD3DF
*  870707  憓? W-OWN-DATE, W-OWN-OLD-UPC
*  890317  憓?INDEX BY W-ICB-INDEX.
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
* 880626 憓?
           06 WS-NEW-UQTY1 REDEFINES WS-UNIT    PIC 9(6).
           06 WS-RX-UNIT                        PIC X(6).
* 880626 憓?
           06 WS-NEW-UQTY2 REDEFINES WS-RX-UNIT PIC 9(6).
*>         ?寞?撠??拇挾??( A: < 2 甇?30%,B: 2-6 甇?20%, N 銝???(930701??)
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
**?蔭憿(PRS-FEE-KND)=C.瑼ａ? D.瑼Ｘ E.嚗詨?
                        10 WS-PAS-DATA.
                           15   WS-PAS-FRONT.
**瑼ａ?瑼Ｘ蝘恕(PRS-PAS-DPT)
                                20 WS-PAS-DPT  PIC X(1).
**?格?憿(PRS-PAS-TAB)
                                20 WS-PAS-TAB  PIC X(2).
**?喲?鞊?PRS-PAS-RCV),A>瑼ａ?瑼Ｘ,B>?其?瑼Ｘ,C>蝝啗?瑼ａ?,D>銵摨急炎撽?
                                20 WS-PAS-RCV  PIC X(1).
**瑼ａ?瑼Ｘ蝝圈?隞?Ⅳ(PRS-PAS-ITM)
                                20 WS-PAS-ITM  PIC X(6).
**?蔭蝝圈?撠??活(PRS-PAS-SEQ)
                                20 WS-PAS-SEQ  PIC 9(1).
                           15   WS-PAS-BACK.
**瑼ａ?瑼Ｘ?株?(HTCHK-CHK-NO)
                                20 WS-CHK-NO.
**瑼ａ?瑼Ｘ憿隞??(HTCHK-CLS-NO)
                                   25 WS-CLS-NO PIC X(3).
**?瘚偌蝣?HTCHK-PR-SEQ)
                                   25 WS-PR-SEQ PIC 9(5).
**瑼ａ?瑼Ｘ?隞?Ⅳ(HTCHK-ITM-CD)
                                20 WS-ITM-CD   PIC X(6).
                        10 WS-PER-RATE         PIC X(3).
* ?桐???? [???包
                        10 WS-UD-BDT           PIC 9(07).
* ?桐???? [???包
                        10 WS-UD-BMTH          PIC X(01).
* ?桐???? [蝯??包
                        10 WS-UD-EDT           PIC 9(07).
* ?桐???? [蝯??包
                        10 WS-UD-EMTH          PIC X(01).
                        10 WS-TST-SMP          PIC X(01).
                        10 WS-PAS-WAY          PIC X(01).
                        10 WS-RTB-ODR          PIC 9(10).
                        10 WS-RTB-SEQ          PIC 9(3).
                        10 WS-RTB-MRK          PIC X(01).
* 摰孵
                        10 WS-PAS-BTL          PIC X(1).
**瑼ａ?瑼Ｘ蝯?/?酉? Y:?澆 HTODRICF
                        10 WS-PAS-RMK          PIC X(1).
*87/07/28憓?:

*韏瑁??交?&??銝?雿?鞎餌皜)
                        10 WS-SEP-ID           PIC X(1).
                        10 WS-SP-YN            PIC X(1).
*撘瑕?芾祥(Y)
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
*>      ?寞?撠??拇挾??( A: < 2 甇?30%,B: 2-6 甇?20%, N 銝???(930701??)
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
*>      ?????
        10 W-II-OP-COUNTER              PIC 9(2).
        10 W-INS-CHG                    PIC 9(6)V99.
        10 W-PRS-ADD                    PIC X.
        10 W-FILLER                     PIC X(71).
        10 W-ANT-DATA  REDEFINES W-FILLER.
                        20 W-ANT-YN           PIC X.
                        20 W-STL-YN           PIC X.
**?蔭憿(PRS-FEE-KND)=C.瑼ａ? D.瑼Ｘ E.嚗詨?
                        20 W-PAS-DATA.
                           25   W-PAS-FRONT.
**瑼ａ?瑼Ｘ蝘恕(PRS-PAS-DPT)
                                30 W-PAS-DPT    PIC X(1).
**?格?憿(PRS-PAS-TAB)
                                30 W-PAS-TAB    PIC X(2).
**?喲?鞊?PRS-PAS-RCV),A>瑼ａ?瑼Ｘ,B>?其?瑼Ｘ,C>蝝啗?瑼ａ?,D>銵摨急炎撽?
                                30 W-PAS-RCV    PIC X(1).
**瑼ａ?瑼Ｘ蝝圈?隞?Ⅳ(PRS-PAS-ITM)
                                30 W-PAS-ITM    PIC X(6).
**?蔭蝝圈?撠??活(PRS-PAS-SEQ)
                                30 W-PAS-SEQ    PIC 9(1).
                           25   W-PAS-BACK.
**瑼ａ?瑼Ｘ?株?(HTCHK-CHK-NO)
                                30 W-CHK-NO.
**瑼ａ?瑼Ｘ憿隞??(HTCHK-CLS-NO)
                                   35 W-CLS-NO PIC X(3).
**?瘚偌蝣?HTCHK-PR-SEQ)
                                   35 W-PR-SEQ PIC 9(5).
**瑼ａ?瑼Ｘ?隞?Ⅳ(HTCHK-ITM-CD)
                                30 W-ITM-CD     PIC X(6).
                        20 W-PER-RATE           PIC X(3).
* ?桐???? [???包
                        20 W-UD-BDT             PIC 9(07).
* ?桐???? [???包
                        20 W-UD-BMTH            PIC X(01).
* ?桐???? [蝯??包
                        20 W-UD-EDT             PIC 9(07).
* ?桐???? [蝯??包
                        20 W-UD-EMTH            PIC X(01).
                        20 W-TST-SMP            PIC X(01).
                        20 W-PAS-WAY            PIC X(01).
                        20 W-RTB-ODR            PIC 9(10).
                        20 W-RTB-SEQ            PIC 9(3).

                        20 W-RTB-MRK            PIC X(01).
* 摰孵
                        20 W-PAS-BTL            PIC X(1).
**瑼ａ?瑼Ｘ蝯?/?酉? Y:?澆 HTODRICF
                        20 W-PAS-RMK            PIC X(1).
*87/07/28憓?:
*韏瑁??交?&??銝?雿?鞎餌皜)
                        20 W-SEP-ID             PIC X(1).
*撘瑕?芾祥(Y)
                        20 W-SP-YN              PIC X(1).
                        20 W-FILLER1            PIC X(5).
*-------------------------------------------------------------------------------
*>      ?芾祥?桀????870706)
 01      W-OWN-DATE                              PIC 9(07).
*>      ?芾祥???
 01      W-OWN-OLD-UPC                           PIC 9(06)V9(2).
*>      ?乩?撌桅?????890712)
 01      W-DIF-DATE                              PIC 9(07).
*>      ?乩??榆憿?
 01      W-DIF-OLD-UPC                           PIC 9(06)V9(2).
*******************************************************************************
*       END     OF      FILE
*******************************************************************************
*COPY    "HI_ECB.WRK".
*******************************************************************************
*>      C-PY FILE :     HI_ECB.WRK
*>      USED BY : 雿?嗉祥-
*>                雿?思誘(GUI)-HRCAECF/HRCFMKF/HRMETCF/HRODAKF/HRODC2KF/HRCAEBF
*>      890524 憓? ?阡??暻駁???
*>      890622 憓????思誘?勗?
*>      900219 憓??那蝘
*>      900604 憓???撟湧翩??
*>      900721 憓?撖虫?瘝餌?撣思誨蝣?ECB-THE-NO)
*>      900927 憓?WS-UDL-FEE-SEQ
*>      910131 憓??寥?閮箇?曹?閮餉?(STL)
*>      910312 憓?蝯西擗(擐?ㄗ蝎???(?思誘)       (JAY)
*>      910312 憓?暻駁?蝝圈?(銝?啣?霅蝣?             (JAY)
*>      940412 憓??喳鋆霅                         (TCC)
*>      950918 憓?靘?蝵株身摰撓?仿雿?雿?              (TCC)
*> 2006/10/31 憓?UDL韏瑁???(UD?迤??銝擐????,?粹??隞???唳撘?
*> 97/04/25 Frank-?啣之?脫?-憓??????酉隤芣?(ECB-CANCER-REMARK)
*> 97/05/07 Frank-憓??寞???
*> 97/10/10 Frank-?芸?摰儔?啣?甈?
*> 98/07/09 Frank-憓??蹂誨?蔭
*> 98/07/29 Frank-憓??怨?蝔桅?????
*> 98/07/29 Frank-憓??思誘???蔭
*> 98/09/22 Frank-憓??唬葉RFID?????刻韏瑁??交?
*> 98/12/19 Frank-憓??啣之?脫?瑼ａ??見閮餉?
*> 98/12/24 Frank-憓??怨?銝閮餉?
*> 99/07/13 Frank-憓??乩??寞??蝯
*> 2011/2/8  憓??乩????- ?旨
*> 2011/2/19 憓???葆??血??仙PF閮?
*> 2011/3/18 (J1100431)4甇? 蝘?? - ?旨
*> 2011/4/8  獢摨扯??? 憓?撅祆CHEMO?刻甈? - ?旨
*> 2011/6/21 憓?CHEMO?賊?甈? - ?旨
*> 2012/3/19 (J1200483)慦??寧?, 憓??瑁?鈭箏. 敶勗?靘?甈? - ?旨
*> 2012/6/13 (J1201066)?啣??臬?箸?瘛冽?銵?(銝???蝝隞?- ?勗?

*> 2012/6/25 (J1201098)?啣??瑁??交????銵犖?∪神?亥???- ?勗?
*> 2012/8/24 (J1201217)?啣?20蝣潛???- ?勗?
*> 2013/1/10 (J1201966)?芾祥?寞??蹂誨蝢斤? - ?勗?
*> 2013/8/30 (J1301047)?啣?20蝣潛?車憿?- ?勗?
*> 2014/4/18 (J1400397)?啣????刻??交???摰銵?? - ??
*> 2015/11/14 (J1500842)?冽撟喳?霅瑞?瘥???.5% - 瘛?
*> 2015/11/30 ??嚗憓活?? - 瘛?
*> 2017/01/09 ?怎恣???芸???- ?
*> 2017/11/06 ?怎恣??C??仿?蝡祟??- ?
*> 2019/01/22 憓?隞?炎?思?璈?隞?Ⅳ - ?
*> 2021/12/27 撟湧翩閮??喳僑?
*******************************************************************************
 01      W-WS-ECB-REC.
   02   WS-ECB-REC      OCCURS 97  TIMES.
* KEY ??= 雿摨?+?摨?+?蔭瘚偌??
        10      WS-ECB-KEY.
* 雿摨?
*$XFD USE GROUP
           20   WS-ECB-IPD-NO.
                30      WS-ECB-IPD-DATE                 PIC 9(7).
                30      WS-ECB-IPD-SEQ                  PIC 9(4).
* ?摨?
*$XFD USE GROUP
           20   WS-ECB-ODR-NO.
* ??交?
                30      WS-ECB-INS-DATE                 PIC 9(7).
* ?瘚偌??
                30      WS-ECB-ODR-SEQ                  PIC 9(4).
* ?蔭瘚偌??
           20   WS-ECB-FEE-SEQ                          PIC 9(3).
*>
* ?芷MARK
        10      WS-ECB-DEL-MARK                         PIC X(1).
* ?蔭隞?Ⅳ
        10      WS-ECB-FEE-KEY                          PIC X(9).
* 瑼?摨?
        10      WS-ECB-FILE-NO                          PIC 9(3).
* 憿 1:?亙?,  2:瑼ａ?瑼Ｘ?曉?蝺?3:F ?蔭憿?890525 憓?)
        10      WS-ECB-TYPE                             PIC X(1).
* ?摨???
*$XFD USE GROUP
        10      WS-ECB-ODR-NO-V.
                30      WS-ECB-INS-DATE-V               PIC 9(7).
                30      WS-ECB-ODR-SEQ-V                PIC 9(4).
*> ?key 1
        10      WS-ECB-ALT1                             PIC X(50).
*> ?key 2
        10      WS-ECB-ALT2                             PIC X(50).
*>
*$XFD USE GROUP
        10      WS-ECB-GROUP-DATA1                      PIC X(250).
        10      WS-ECB-GROUP-DATA11 REDEFINES WS-ECB-GROUP-DATA1.
*> ?酉
                30      WS-ECB-REMARK                   PIC X(50).
*> Y-> ?阡暻駁???
                30      WS-ECB-BRAIN-YN                 PIC X(01).
*> ?阡??銋獄????

                30      WS-ECB-BRAIN-RATE               PIC 9(03).
*> ??葆???園?(*)
                30      WS-ECB-LNK-POINT-HEAD           PIC X(01).
*> ??葆???活
                30      WS-ECB-LNK-POINT                PIC X(09).
*> ??葆??撅???
                30      WS-ECB-LNK-TIME.
                        40      WS-ECB-LNK-HH           PIC 9(02).
                        40      WS-ECB-LNK-MM           PIC 9(02).
                        40      WS-ECB-LNK-SS           PIC 9(02).
*> Y-> ???思誘?勗?     890622 INSERT
                30      WS-ECB-ANN-YN                   PIC X(01).
*> 摨急撠蝣?          890629 INSERT
                30      WS-ECB-STK-CNT                  PIC X(13).
*> ??怠葦
                30      WS-ECB-APY-DR                   PIC X(04).
*> 撖虫??怠葦嚗?
                30      WS-ECB-OPR-DR1                  PIC X(04).
*> 撖虫??怠葦嚗?
                30      WS-ECB-OPR-DR2                  PIC X(04).
*> ?勗??怠葦
                30      WS-ECB-RPT-DR                   PIC X(04).
*> ?那蝘
                30      WS-ECB-DEPT-NO                  PIC X(04).
*> ??撟湧翩??('1'->0-0.5, 'A'->0.5-2, 'B'->2-6)
*> ?寞?撠?銝挾??('1'->0-0.5, 'A'->0.5-2, 'B'->2-6)(930701??)
                30      WS-ECB-OPP-RANK                 PIC X(01).
*> ??撟湧翩???曉?瘥?
*> ?寞?撠?銝挾???曉?瘥?930701??)
                30      WS-ECB-OPP-RATE                 PIC 9(03).
*> 撖虫?瘝餌?撣?               900721 INSERT
                30      WS-ECB-THE-NO                   PIC X(05).
*> UDL ?蔭摨?
                30      WS-ECB-UDL-FEE-SEQ              PIC 9(03).
*> 瑼ａ????芸銵?'Y'?芸銵??瑁?)(901007)
                30      WS-ECB-HT-UNDO                  PIC X(01).
*> Y-> ?寧?閮箇??910131)
                30      WS-ECB-OPD-APY                  PIC X(01).
*> 蝯西擗(擐?ㄗ蝎???(?思誘)(910312)
                30      WS-ECB-MED-PACKET               PIC 9(04).
*> 暻駁?蝝圈?(銝?啣?霅蝣?(910312)
                30      WS-ECB-LNK-SON                  PIC X(01).
*> 瘞??0-6??(930210)
                30      WS-ECB-PANT-YN                  PIC X(01).
*> 鞎砌遙??(930617)
                30      WS-ECB-DUTY-YN                  PIC X(01).
*> ?亥那憭????(930617)
                30      WS-ECB-NIGHT-YN                 PIC X(01).
*> ?蔭?寞?霅(瘥??蔭隞?Ⅳ)(D.摮悅??(930820)
                30      WS-ECB-SPEC-MARK                PIC X(01).
*> 鈭?撖拇?(940105)
                30      WS-ECB-PRD-YN                   PIC X(01).
*> 憓??喳鋆霅
                30      WS-ECB-APY-MARK                 PIC X(01).
*> ?憿?
                30      WS-ECB-NOM-AMT                  PIC S9(7)V9(2).
*> ?芸?憿?

                30      WS-ECB-DIS-AMT                  PIC S9(7)V9(2).
*> ?芯?憿?
                30      WS-ECB-SP-AMT                   PIC S9(7)V9(2).
*> ?其遢鞎?憿?
                30      WS-ECB-PART-AMT                 PIC S9(7)V9(2).
*> ?喳憿?
                30      WS-ECB-APP-AMT                  PIC S9(7)V9(2).
*> 0-4甇脣?蝡仿蔡朣???941114)
                30      WS-ECB-TEETH-YN                 PIC X(01).
*> 950918  憓?靘?蝵株身摰撓?仿雿?雿?
                30      WS-ECB-LRB-FIELD                PIC X(01).
**> 2006/10/31 憓?UDL韏瑁???(UD?迤??銝擐????,?粹??隞???唳撘?
                30      WS-ECB-UDL-BDT                  PIC 9(7).
                30      WS-ECB-UDL-BTI                  PIC 9(2).
                30      WS-ECB-UDL-EDT                  PIC 9(7).
                30      WS-ECB-UDL-ETI                  PIC 9(2).
*> 970430 ?啣之??-憓??思誘??UDL撖阡???
                30      WS-ECB-HRUDL-BTI                PIC 9(2).
                30      WS-ECB-HRUDL-ETI                PIC 9(2).
*> 97.10.07 ???嚗靽?蝯虫?憿??乩?)
                30      WS-ECB-NHI-DIS-AMT              PIC S9(7)V9(2).
*> 97.10.07 ???嚗隞?憿??芾祥)
                30      WS-ECB-SP-DIS-AMT               PIC S9(7)V9(2).
*> 98/07/09 ?蹂誨?蔭 (憒?蔭?嚗?B?蔭嚗迨甈?摮?蔭隞?Ⅳ)
                30      WS-ECB-REPLACE-FEE-KEY          PIC X(9).
*> 98/07/29 ??亦車-?怨?蝔桅?
                30      WS-ECB-INJ-KIND                 PIC X(6).
*> 98/07/29 ??亦車-?怨??寡?
                30      WS-ECB-INJ-BATCH-NO             PIC X(12).
*> 98/07/29 ?思誘???蔭 (Y:???蔭)
                30      WS-ECB-HRPRN-YN                 PIC X(1).
*> 98/09/22 ?唬葉RFID?芸??亥???(K嚗?)
                30      WS-ECB-SELF-DRUG                PIC X(1).
*> 98/12/19 ?啣之?脫?瑼ａ??見閮餉? (Y嚗歇?見)
                30      WS-ECB-HT-SAMPLE                PIC X(1).
*> 98/12/24 ??亦車-?怨?銝閮餉? (Y嚗歇銝)
                30      WS-ECB-INJ-ICS-YN               PIC X(1).
*> 99/07/13 ?乩??寞??蝯 (NID-062A)
                30      WS-ECB-SPC-DIS-GRP              PIC X(2).
*> 2011/4/8 霅撅祆CHEMO?刻 (C/T?刻霅) (Y: 閰脤?撅祆C/T?刻)
                30      WS-ECB-CHEMO-CT                 PIC X(1).
*$XFD USE GROUP
        10      WS-ECB-GROUP-DATA2                      PIC X(250).
        10      WS-ECB-GROUP-DATA21 REDEFINES WS-ECB-GROUP-DATA2.
*> ???酉(97/04/25)
                30      WS-ECB-CANCER-REMARK            PIC X(80).
*> ?寞???(97/05/07)
                30      WS-ECB-SPC-RATE                 PIC 9(3).
*> 98/09/22 ?唬葉RFID?????刻韏瑕??交? (雿撖怠)
                30      WS-ECB-HRUDL-BDT                PIC 9(7).
*> 98/09/22 ?唬葉RFID?????刻蝯??交? (雿撖怠)
                30      WS-ECB-HRUDL-EDT                PIC 9(7).
*> 98/09/22 ?唬葉RFID?????? (雿撖怠)
                30      WS-ECB-HRUDL-RX-QTY             PIC 9(6)V9(2).
*> 99/07/26 ?乩??寞????
                30      WS-ECB-SPC-DIS-RATE             PIC 9(1)V9(2).
*> 2011/2/8 ?乩????

                30      WS-ECB-NHI-DIS-RATE             PIC 9(3)V9(2).
*> 2011/2/19 ??葆??血??仙PF閮?
                30      WS-ECB-PPF-YN                   PIC X(1).
*> 2011/3/18 4甇脣?蝡仿?閮箄那撖祥??
                30      WS-ECB-DIAG-RANK                PIC X(1).
                30      WS-ECB-DIAG-RATE                PIC 9(3).
*> 2011/3/18 蝘?閮箄那撖祥??
                30      WS-ECB-DPT-RANK                 PIC X(1).
                30      WS-ECB-DPT-RATE                 PIC 9(3).
*> 2011/6/21 CHEMO瘚偌??
                30      WS-ECB-HYGUDL-SN-NO             PIC 9(4).
*> 2011/6/21 CHEMO霅 (C:?HEMO, U:?D, S:?風??)
                30      WS-ECB-HYGUDL-CHEMO-ID          PIC X(1).
*> 2011/6/21 CHEMO摨?
                30      WS-ECB-HYGUDL-SEQ-NO            PIC 9(2).
*> 2012/3/19 ?瑁?鈭箏
                30      WS-ECB-EXECUTE-USR              PIC X(5).
*> 2012/3/19 敶勗?靘?
                30      WS-ECB-IMAGE-SW                 PIC X(1).
*> 2012/6/13 ?臬?箸?瘛冽?銵?(銝???蝝隞?Y:??, 蝛箇:??
                30      WS-ECB-CLEAN-OPP-ANT-YN         PIC X(1).
*> 2012/6/25 ?瑁??交????銵犖?∪神?亥???
*>           (1.?孵  2.鋆  3.瑼ａ?  4.??  5.頧?)
                30      WS-ECB-OP-DATE-USR-ID           PIC X(1).
*> 2012/8/24 20蝣潛???
                30      WS-ECB-NEW-INJ-BATCH-NO         PIC X(20).
*> 2013/1/10 ?芾祥?寞??蹂誨蝢斤?
                30      WS-ECB-REPLACE-GROUP            PIC X(03).
*> 2013/8/30 20蝣潛?車憿?
                30      WS-ECB-NEW-INJ-KIND             PIC X(20).
*> 2014/4/18 ???刻??交?(銵摨?
                30      WS-BLOOD-DATE                   PIC 9(07).
*> 2014/4/18 ???刻???(銵摨?
                30      WS-BLOOD-TIME                   PIC 9(04).
*> 2015/11/14 ?冽撟喳?霅瑞?瘥???.5%
                30      WS-ECB-PER-RATE                 PIC 9(05).
*> 2015/11/30 ??-?啣?甈∪???
                30      WS-ECB-RX-N-UQTY.
                        40      WS-ECB-RX-N-UQTY1       PIC 9(05).
                        40      WS-ECB-RX-N-UQTY2       PIC 9(05).
*> 2017/01/09 ?怎恣???芸???
*>              ?芸??酉閮?
                30      WS-ECB-NLI-MARK                 PIC X(01).
*>              ?芸??靽誨蝣?
                30      WS-ECB-NLI-INS-ID               PIC X(16).
*>              ?芸??靽誨蝣潭?瘞渲?
                30      WS-ECB-NSI-INS-ID-SEQ           PIC 9(02).
*> 2017/11/06 ?怎恣??C??仿?蝡祟??
*>              C??亦隢??
                30      WS-ECB-CHE-STR-DATE             PIC 9(07).
*> 2017/11/09 ????蝣潭6蝣?
*>              ?啣??
                30      WS-ECB-PER-RATE-NEW             PIC 9(05).
*> 2019/01/22 憓?隞?炎?思?璈?隞?Ⅳ
                30      WS-ECB-INSPECT-HOSP-ID          PIC X(10).
*>      2020/07/24 ?乩?閬??蝺???曉?閮箇?????那???其??????
                30      WS-ECB-LRB-FIELD-NEW    PIC X(02).

                30      WS-ECB-FILLER2                  PIC X(01).

*> END
*> ---------------------------------------------------------------------------
*
 01      W-ECB-REC.
* KEY ??= 雿摨?+?摨?+?蔭瘚偌??
        10      W-ECB-KEY.
* 雿摨?
*$XFD USE GROUP
           20   W-ECB-IPD-NO.
                30      W-ECB-IPD-DATE                  PIC 9(7).
                30      W-ECB-IPD-SEQ                   PIC 9(4).
* ?摨?
*$XFD USE GROUP
           20   W-ECB-ODR-NO.
* ??交?
                30      W-ECB-INS-DATE                  PIC 9(7).
* ?瘚偌??
                30      W-ECB-ODR-SEQ                   PIC 9(4).
* ?蔭瘚偌??
           20   W-ECB-FEE-SEQ                           PIC 9(3).
*>
* ?芷MARK
        10      W-ECB-DEL-MARK                          PIC X(1).
* ?蔭隞?Ⅳ
        10      W-ECB-FEE-KEY                           PIC X(9).
* 瑼?摨?
        10      W-ECB-FILE-NO                           PIC 9(3).
* 憿 1:?亙?,  2:瑼ａ?瑼Ｘ?曉?蝺?
        10      W-ECB-TYPE                              PIC X(1).
* ?摨???
*$XFD USE GROUP
        10      W-ECB-ODR-NO-V.
                30      W-ECB-INS-DATE-V                PIC 9(7).
                30      W-ECB-ODR-SEQ-V                 PIC 9(4).
*> ?key 1
        10      W-ECB-ALT1                              PIC X(50).
*> ?key 2
        10      W-ECB-ALT2                              PIC X(50).
*>
*$XFD USE GROUP
        10      W-ECB-GROUP-DATA1                       PIC X(250).
        10      W-ECB-GROUP-DATA11 REDEFINES W-ECB-GROUP-DATA1.
*> ?酉
                30      W-ECB-REMARK                    PIC X(50).
*> Y-> ?阡暻駁???
                30      W-ECB-BRAIN-YN                  PIC X(01).
*> ?阡??銋獄????
                30      W-ECB-BRAIN-RATE                PIC 9(03).
*> ??葆???園?(*)
                30      W-ECB-LNK-POINT-HEAD            PIC X(01).
*> ??葆???活
                30      W-ECB-LNK-POINT                 PIC X(09).
*> ??葆??撅???
                30      W-ECB-LNK-TIME.
                        40      W-ECB-LNK-HH            PIC 9(02).

                        40      W-ECB-LNK-MM            PIC 9(02).
                        40      W-ECB-LNK-SS            PIC 9(02).
*> Y-> ???思誘?勗?     890622 INSERT
                30      W-ECB-ANN-YN                    PIC X(01).
*> 摨急撠蝣?          890629 INSERT
                30      W-ECB-STK-CNT                   PIC X(13).
*> ??怠葦
                30      W-ECB-APY-DR                    PIC X(04).
*> 撖虫??怠葦嚗?
                30      W-ECB-OPR-DR1                   PIC X(04).
*> 撖虫??怠葦嚗?
                30      W-ECB-OPR-DR2                   PIC X(04).
*> ?勗??怠葦
                30      W-ECB-RPT-DR                    PIC X(04).
*> ?那蝘
                30      W-ECB-DEPT-NO                   PIC X(04).
*> ??撟湧翩??('1'->0-0.5, 'A'->0.5-2, 'B'->2-6)
*> ?寞?撠?銝挾??('1'->0-0.5, 'A'->0.5-2, 'B'->2-6)(930701??)
                30      W-ECB-OPP-RANK                  PIC X(01).
*> ??撟湧翩???曉?瘥?
*> ?寞?撠?銝挾???曉?瘥?930701??)
                30      W-ECB-OPP-RATE                  PIC 9(03).
*> 撖虫?瘝餌?撣?               900721 INSERT
                30      W-ECB-THE-NO                    PIC X(05).
*> UDL ?蔭摨?
                30      W-ECB-UDL-FEE-SEQ               PIC 9(03).
*> 瑼ａ????芸銵?'Y'?芸銵??瑁?)(901007)
                30      W-ECB-HT-UNDO                   PIC X(01).
*> Y-> ?寧?閮箇??910131)
                30      W-ECB-OPD-APY                   PIC X(01).
*> 蝯西擗(擐?ㄗ蝎???(?思誘)(910312)
                30      W-ECB-MED-PACKET                PIC 9(04).
*> 暻駁?蝝圈?(銝?啣?霅蝣?(910312)
                30      W-ECB-LNK-SON                   PIC X(01).
*> 瘞??0-6??(930210)
                30      W-ECB-PANT-YN                   PIC X(01).
*> 鞎砌遙??(930617)
                30      W-ECB-DUTY-YN                   PIC X(01).
*> ?亥那憭????(930617)
                30      W-ECB-NIGHT-YN                  PIC X(01).
*> ?蔭?寞?霅(瘥??蔭隞?Ⅳ)(D.摮悅??(930820)
                30      W-ECB-SPEC-MARK                 PIC X(01).
*> 鈭?撖拇?(940105)
                30      W-ECB-PRD-YN                    PIC X(01).
*> 94/04/12 SMTCC ?啣??喳鋆銋??亥酉閮?
                30      W-ECB-APY-MARK                  PIC X(01).
*> ?憿?
                30      W-ECB-NOM-AMT                  PIC S9(7)V9(2).
*> ?芸?憿?
                30      W-ECB-DIS-AMT                  PIC S9(7)V9(2).
*> ?芯?憿?
                30      W-ECB-SP-AMT                   PIC S9(7)V9(2).
*> ?其遢鞎?憿?
                30      W-ECB-PART-AMT                 PIC S9(7)V9(2).
*> ?喳憿?
                30      W-ECB-APP-AMT                  PIC S9(7)V9(2).
*> 0-4甇脣?蝡仿蔡朣???

                30      W-ECB-TEETH-YN                  PIC X(01).
*> 950918  憓?靘?蝵株身摰撓?仿雿?雿?
                30      W-ECB-LRB-FIELD                 PIC X(01).
**> 2006/10/31 憓?UDL韏瑁???(UD?迤??銝擐????,?粹??隞???唳撘?
                30      W-ECB-UDL-BDT                   PIC 9(7).
                30      W-ECB-UDL-BTI                   PIC 9(2).
                30      W-ECB-UDL-EDT                   PIC 9(7).
                30      W-ECB-UDL-ETI                   PIC 9(2).
*> 970430 ?啣之??-憓??思誘??UDL撖阡???
                30      W-ECB-HRUDL-BTI                 PIC 9(2).
                30      W-ECB-HRUDL-ETI                 PIC 9(2).
*> 97.10.07 ???嚗靽?蝯虫?憿??乩?)
                30      W-ECB-NHI-DIS-AMT               PIC S9(7)V9(2).
*> 97.10.07 ???嚗隞?憿??芾祥)
                30      W-ECB-SP-DIS-AMT                PIC S9(7)V9(2).
*> 98/07/09 ?蹂誨?蔭 (憒?蔭?嚗?B?蔭嚗迨甈?摮?蔭隞?Ⅳ)
                30      W-ECB-REPLACE-FEE-KEY           PIC X(9).
*> 98/07/29 ??亦車-?怨?蝔桅?
                30      W-ECB-INJ-KIND                  PIC X(6).
*> 98/07/29 ??亦車-?怨??寡?
                30      W-ECB-INJ-BATCH-NO              PIC X(12).
*> 98/07/29 ?思誘???蔭 (Y:???蔭)
                30      W-ECB-HRPRN-YN                  PIC X(1).
*> 98/09/22 ?唬葉RFID?芸??亥???(K嚗?)
                30      W-ECB-SELF-DRUG                 PIC X(1).
*> 98/12/19 ?啣之?脫?瑼ａ??見閮餉? (Y嚗歇?見)
                30      W-ECB-HT-SAMPLE                 PIC X(1).
*> 98/12/24 ??亦車-?怨?銝閮餉? (Y嚗歇銝)
                30      W-ECB-INJ-ICS-YN                PIC X(1).
*> 99/07/13 ?乩??寞??蝯 (NID-062A)
                30      W-ECB-SPC-DIS-GRP               PIC X(2).
*> 2011/4/8 霅撅祆CHEMO?刻 (C/T?刻霅) (Y: 閰脤?撅祆C/T?刻)
                30      W-ECB-CHEMO-CT                  PIC X(1).
*$XFD USE GROUP
        10      W-ECB-GROUP-DATA2                       PIC X(250).
        10      W-ECB-GROUP-DATA21 REDEFINES W-ECB-GROUP-DATA2.
*> ???酉(97/04/25)
                30      W-ECB-CANCER-REMARK             PIC X(80).
*> ?寞???(97/05/07)
                30      W-ECB-SPC-RATE                  PIC 9(3).
*> 98/09/22 ?唬葉RFID?????刻韏瑕??交? (雿撖怠)
                30      W-ECB-HRUDL-BDT                 PIC 9(7).
*> 98/09/22 ?唬葉RFID?????刻蝯??交? (雿撖怠)
                30      W-ECB-HRUDL-EDT                 PIC 9(7).
*> 98/09/22 ?唬葉RFID?????? (雿撖怠)
                30      W-ECB-HRUDL-RX-QTY              PIC 9(6)V9(2).
*> 99/07/26 ?乩??寞????
                30      W-ECB-SPC-DIS-RATE              PIC 9(1)V9(2).
*> 2011/2/8 ?乩????
                30      W-ECB-NHI-DIS-RATE              PIC 9(3)V9(2).
*> 2011/2/19 ??葆??血??仙PF閮?
                30      W-ECB-PPF-YN                    PIC X(1).
*> 2011/3/18 4甇脣?蝡仿?閮箄那撖祥??
                30      W-ECB-DIAG-RANK                 PIC X(1).
                30      W-ECB-DIAG-RATE                 PIC 9(3).
*> 2011/3/18 蝘?閮箄那撖祥??
                30      W-ECB-DPT-RANK                  PIC X(1).

                30      W-ECB-DPT-RATE                  PIC 9(3).
*> 2011/6/21 CHEMO瘚偌??
                30      W-ECB-HYGUDL-SN-NO              PIC 9(4).
*> 2011/6/21 CHEMO霅 (C:?HEMO, U:?D, S:?風??)
                30      W-ECB-HYGUDL-CHEMO-ID           PIC X(1).
*> 2011/6/21 CHEMO摨?
                30      W-ECB-HYGUDL-SEQ-NO             PIC 9(2).
*> 2012/3/19 ?瑁?鈭箏
                30      W-ECB-EXECUTE-USR               PIC X(5).
*> 2012/3/19 敶勗?靘?
                30      W-ECB-IMAGE-SW                  PIC X(1).
*> 2012/6/13 ?臬?箸?瘛冽?銵?(銝???蝝隞?Y:??, 蝛箇:??
                30      W-ECB-CLEAN-OPP-ANT-YN          PIC X(1).
*> 2012/6/25 ?瑁??交????銵犖?∪神?亥???
*>           (1.?孵  2.鋆  3.瑼ａ?  4.??  5.頧?)
                30      W-ECB-OP-DATE-USR-ID            PIC X(1).
*> 2012/8/24 20蝣潛???
                30      W-ECB-NEW-INJ-BATCH-NO          PIC X(20).
*> 2013/1/10 ?芾祥?寞??蹂誨蝢斤?
                30      W-ECB-REPLACE-GROUP             PIC X(03).
*> 2013/8/30 20蝣潛?車憿?
                30      W-ECB-NEW-INJ-KIND              PIC X(20).
*> 2014/4/18 ???刻??交?(銵摨?
                30      W-BLOOD-DATE                    PIC 9(07).
*> 2014/4/18 ???刻???(銵摨?
                30      W-BLOOD-TIME                    PIC 9(04).
*> 2015/11/14 ?冽撟喳?霅瑞?瘥???.5%
                30      W-ECB-PER-RATE                  PIC 9(05).
*> 2015/11/30 ??-?啣?甈∪???
                30      W-ECB-RX-N-UQTY.
                        40      W-ECB-RX-N-UQTY1        PIC 9(05).
                        40      W-ECB-RX-N-UQTY2        PIC 9(05).
*> 2017/01/09 ?怎恣???芸???
*>              ?芸??酉閮?
                30      W-ECB-NLI-MARK                  PIC X(01).
*>              ?芸??靽誨蝣?
                30      W-ECB-NLI-INS-ID                PIC X(16).
*>              ?芸??靽誨蝣潭?瘞渲?
                30      W-ECB-NSI-INS-ID-SEQ            PIC 9(02).
*> 2017/11/06 ?怎恣??C??仿?蝡祟??
*>              C??亦隢??
                30      W-ECB-CHE-STR-DATE              PIC 9(07).
*> 2017/11/09 ????蝣潭6蝣?
*>              ?啣??
                30      W-ECB-PER-RATE-NEW              PIC 9(05).
*> 2019/01/22 憓?隞?炎?思?璈?隞?Ⅳ
                30      W-ECB-INSPECT-HOSP-ID           PIC X(10).
*>      2020/07/24 ?乩?閬??蝺???曉?閮箇?????那???其??????
                30      W-ECB-LRB-FIELD-NEW             PIC X(02).
                30      W-ECB-FILLER2                   PIC X(01).

*> -----------------------------------------------------------------------
*> ?敺?獢???
 01      W-LAST-FILE-NO                                  PIC 9(03) VALUE ZERO.
*> M -> 靽格
 01      W-SAVE-MODE                                     PIC X(01) VALUE SPACE.
*>      ?思誘?交?

 01      W-IP-DATE                                       PIC 9(07) VALUE ZERO.

*> 941114 SMTCC 憓?0-4甇脣?蝡仿蔡朣???
 01      W-PAT-BIRTH-MONTHS      PIC 9(3).
*> 2021/12/27 撟湧翩閮??喳僑?
 01      W-PAT-BIRTH-DAYS        PIC 9(3).
*> END
*******************************************************************************
*       END     OF      FILE
*******************************************************************************
*COPY    "HI_GCA.WRK".
*********************************************************************************
*       C-PY    FILE : HI_GCA.WRK       USED BY : HIOD1KF, HIOD2MF, HIOD3DF     *
* 901123  CREATE BY JAY                                                         *
* 910306  憓?W-GCA-APY-ID?梁?梁頂蝯梁????JAY)                               *
*********************************************************************************
 01      HIGCA-MST-STATUS        PIC XX  EXTERNAL.
 01      HIGCB-MST-STATUS        PIC XX  EXTERNAL.
*>      Y->?Ｙ???啣?閮?
 01      W-WRITE-GCA-YN          PIC X.
*>      ?啣????I.?啣? MD.靽格??MI.靽格敺?D.?芷
 01      W-UPD-ID                PIC X(2).
*>      ?喳蝟餌絞霅蝣?Y)(910306)
 01      W-GCA-APY-ID            PIC X   VALUE   SPACE.
*>      ?啣??交?
 01      W-GCA-DATE              PIC 9(7).
*>      ?啣???
 01      W-GCA-TIME              PIC 9(6).
*COPY    "HG_NIDIF.LNK".
**********************************************************************************
*>      930920 ????隞?Ⅳ摮???亙???? 憓??澆HGNIDIF 銋洵銝?LINK (SMSTL)
*>      憒??文閰脖誨蝣潔???交???? ????喲?銝??
*>      EX. CALL "HGNIDIF" USING W-NIDIF-LNK W-COLOR-LNK W-EXTIF-LNK    END-CALL.
**********************************************************************************
*> 甇斤 ?澆 HGNIDIF ??喲?銋洵銝蝯???
 01      W-NIDIF-LNK.
*       ?亥岷閮剖?嚗?.銵典?蝑閰Ｗ?敺??閰Ｗ??賡??蝒?
*                 2.銵典?蝑閰Ｗ????亥岷??豢?閬?
*                 3.銵典?雿?蝑閰ｇ?銝??亥岷??豢?閬?
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
*       ?思??箸?摰??航?蝒?蝵桐???
        02  W-NIDIF-SCROLL                      PIC 9(02).
*       ?喳:銵冽炎??NID-MST-REC(W-NIDIF-CA:W-NIDIF-CS)
*            E: 銵冽炎??NID-MST-REC(W-NIDIF-CA:W-NIDIF-CS) =  ?喳??
*               ?血?蝯??亥岷(KEY)

*            ---------------------------------------------------------
*            F: 銵冽炎??NID-MST-REC(W-NIDIF-CA:W-NIDIF-CS) =  ?喳??
*               IF W-NIDIF-CN > 0 憭?CHECK
*                      NID-MST-REC(W-NIDIF-CM:W-NIDIF-CN) =  ?喳??
*               END-IF
*               ?血? NEXT RECORD
*            ---------------------------------------------------------
*            >: 銵冽炎??NID-MST-REC(W-NIDIF-CA:W-NIDIF-CS) >  ?喳??
*            <: 銵冽炎??NID-MST-REC(W-NIDIF-CA:W-NIDIF-CS) <  ?喳??
*            X: 銵冽炎??NID-MST-REC(W-NIDIF-CA:W-NIDIF-CS) <> ?喳??
*               IF W-NIDIF-CN > 0 憭?CHECK
*                      NID-MST-REC(W-NIDIF-CM:W-NIDIF-CN) <> ?喳??
*               END-IF
*               ?血? NEXT RECORD
*       ?喳?:"Y" 銵典??潘?"N" 銵冽?潘?"0" 銵冽迨隞???∟???
        02  W-NIDIF-YN                          PIC X(01).
        02  W-NIDIF-REC                         PIC X(300).
*       " " 銵券?瑼?"N" 銵其???
        02  W-NIDIF-OPEN                        PIC X(01).
*> 隞乩??箏? HG_NIDIF.LNK 銋摰?930920 MEMO 隤芣?

*> 甇斤 ?澆 HGNIDIF ??喲?銋洵鈭??
 01      W-COLOR-LNK                             PIC 9(05)       COMP-1.

*> 甇斤 ?澆 HGNIDIF ??喲?銋洵銝??(?亥岷??交????
 01      W-EXTIF-LNK.
*>      Y->?亙?? 銝炎?亙??冽???冽(銝?W-EXTIF-CHK-DT)
        02 W-EXTIF-ALL-YN                       PIC X(01).
*>      隞?Ⅳ瑼Ｘ?交?(憒?單?? ?GNIDIF 隞亦頂蝯望瘥???交????
        02 W-EXTIF-CHK-DT                       PIC 9(07).
*>      ?喳? HGEXT-MST-REC ?渡?RECORD銋摰?W-NIDIF-YN = "Y"??
        02 W-EXTIF-EXT-REC                      PIC X(231).
*>      ??
        02 W-EXTIF-FILLER                       PIC X(50).
**********************************************************************************
*>      END     OF      FILE
**********************************************************************************

*COPY    "HO_GCK.WRK".
*
 01      W-1799-REC      PIC X(300) IS EXTERNAL.
*
*------>??瑼?
*COPY    "HR_WAIT.WRK".
*
*       ??銝剖????航?蝒?
*       "HR_WAIT.WRK".
*
*77      S-LOAD-FORM-Handle HANDLE OF WINDOW.

 01      W-LA-NAME                       PIC X(40).
 01      W-FONT-TITLE                    PIC X(40).
 01      W-PERCENT                       PIC 9(03).
 01      W-PERCENT-FMT.
        03      W-PERCENT-FMT1          PIC  ZZ9.
        03      FILLER                  PIC  XX VALUE IS "嚗?.
 01      W-OPEN-MESG-TYPE                PIC X(01).

*> ?曉?瘥?甈∪????詨?(銝摰???00????
 01      W-PERCENT-ADD                   PIC 9(02).
*COPY    "HR_LOA.WRK".

*------->?怠??怠葦隞?Ⅳ銵?..
 01      HR-TMP-DR                       PIC X(4).
 01      HR-TMP-DR-NAME                  PIC X(12).
 01      HR-DR-II                        PIC 9(4) IS EXTERNAL.
 01      HR-DR-II1                       PIC 9(4).
 01      HR-DR-TAB                                IS EXTERNAL.
        02      W-DR-TAB1 OCCURS 1 TO 5000 TIMES
                DEPENDING ON HR-DR-II INDEXED BY HR-DR-JJ.
                03      HR-DR-TAB1-NO    PIC X(4).
                03      HR-DR-TAB1-NAME  PIC X(12).

*------->?怠?蝘隞?Ⅳ銵?..
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
*HR_IPDIF.LNK        HRIPDIF霅瑞?蝡???訾?璆凋蝙??
*> ?澆?孵???CALL "HRIPDIF" USING L-IPDIF-LNK L-IPDIF-LNK1 ON EXCEPTION CONTINUE
***********************************************************************
 01      L-IPDIF-LNK.
*------->       雿摨?
        02      L-LNK-IPD-NO.
                03      L-LNK-IPD-DT    PIC 9(07).
                03      L-LNK-IPD-SEQ   PIC 9(04).

*------->       ?臬???[Y]-??
        02      L-LNK-YN                PIC X(01).

*------->       ?桀?撌脤??訾?摨?
        02      L-LNK-II                PIC 9(02).

*------->       ?桀?銋蜓瘝駁撣思誨??
        02      L-LNK-MJ-DR             PIC X(04).

*------->       摨????
        02      L-LNK-SBED              PIC X(06).
        02      L-LNK-EBED              PIC X(06).

*------->       雿輻銋閰Ｘ撘?[ ]靘風???貊?鈭?[A]靘蜓瘝駁撣恍?犖
*                           [B]?芾?頛詨摨????[C]靘??仿?犖
*                           [D]?芸?靘蜓瘝駁撣恍??鈭?
        02      L-LNK-INQ-TYPE          PIC X(01).
 01      L-IPDIF-LNK1.
*------->94.2.18 雿霅 (A.?? " ??雿 B.霅瑞?銋振 C.?仿??扯風 X.銝雿輻)
        02      L-LNK-IPD-LIVE-ID       PIC X(01).
*------->95.8.16 ?航撓?交??閮蒜Y]

        02      L-LNK-IPD-PAT-NOTE      PIC X(01).
*------->95.11.28 ?斗VIP????航???[N]
        02      L-LNK-IPD-ACCESS-YN     PIC X(01).
*------->95.12.27 撖Ⅳ雿輻???怠葦隞?Ⅳ
        02      L-LNK-IPD-RUN-DR        PIC X(04).
*--------108.03.28 ???怠?
        02      L-LNK-HRNPTCF-YN        PIC X(01).
*>
        02      L-LNK-FILLER            PIC X(03).
***********************************************************************
*COPY    "HR_MESCF.LNK".
***********************************************************************
*> HR_MESCF.LNK
*> CALL "HRMESCF" 蝔?雿輻  憿舐內MESSAGE BOX
***********************************************************************
 01      W-HRMESCF-DATA.
*> 閮蝚西? 1.[?] 2.[i] 3.[!] 4.[X]
        02      W-HRMESCF-PIC-TYPE      PIC X(01).
*> ??蝔桅?     1.??????
*>              2.蝣箏? ??
*>              3.蝣箏?
*>              4.????
*>              5.????霈雿輻??[?思誘撠]
*>              6.摮? ?暹? ?耨??
*>              7.摮? ?暹? 摮?銝血???
*>              8.1.頧?閫 2.閮箇?銝?3.MBD 4.頧???5.頧 6.AAD 7.DOA 8.甇颱滿 9.銝??
*>              A.?芾?璅∪?(鈭???
*>              B.?芾?璅∪?(銝???
*>              C.?芾?璅∪?(????
*>              D.?芾?璅∪?(銝????
*>              E.?芾?璅∪?(鈭??? 雿輻甇斗芋撘???閬 W-HRMESCF-DATA3 ??
        02      W-HRMESCF-BUT-TYPE      PIC X(01).
*> ?喳???Y-??摮?) N-???暹?) O-蝣箏? C-?? P-霈雿輻??摮?銝血??? M-?耨??
        02      W-HRMESCF-RETURN        PIC X(01).
*> ?望迨??50?瑞?FILLER
*> ?臬閬?霅衣內??Y-??
        02      W-HRMESCF-BELL          PIC X(01).
*> ?身ID?潛雿?Y-??摮?) N-???暹?) O-蝣箏? C-?? P-霈雿輻??摮?銝血??? M-?耨??
*>              ?亦?芾???? 1-蝚砌???2-蝚砌???3-蝚砌???4-蝚砍???
        02      W-HRMESCF-CONTROL-ID    PIC X(01).
*> ?芾????批捆 (1-4)
        02      W-HRMESCF-BUT-SET.
                03      W-HRMESCF-BUT-SET1 OCCURS 4 TIMES.
                04      W-HRMESCF-BUT-VALUE     PIC X(01).
                04      W-HRMESCF-BUT-NAME      PIC X(10).
*> 銝＊蝷箸????寧雿輻 ENTRY
        02      W-HRMESCF-ENTRY-OPEN    PIC X(01).
*> ??
        02      W-HRMESCF-FILLER        PIC X(03).
*> 閮摮葡 (瘥?60摮??勗?銵?
 01      W-HRMESCF-DATA2.
        02      W-HRMESCF-NOTE OCCURS 10 TIMES PIC X(60).
 01      W-HRMESCF-DATA3.
*> WINDOW TITLE
        02      W-HRMESCF-TITLE         PIC X(60).
*> ?芾????批捆 (5)
        02      W-HRMESCF-BUT-SETA.

                04      W-HRMESCF-BUT-VALUEA    PIC X(01).
                04      W-HRMESCF-BUT-NAMEA     PIC X(10).
*> ?乩蝙?汞NTRY頛詨嚗?潭迨隤芣?
        02      W-HRMESCF-ENTRY-TITLE   PIC X(56).
*> ?臬?舀?ESC?ａ?
        02      W-HRMESCF-ESC-OK        PIC X(01).
        02      W-HRMESCF-DATA3-FILLER  PIC X(132).
***********************************************************************
*COPY    "HR_DOSE.LNK".
*********************************************************************************
*> C-PY FROM "MR_DOSE.LNK".
*********************************************************************************
*------>"1"儭啣?頛詨??W-LNK-DOSE-SUR)蝝??駁???
*>              頛詨-->W-LNK-DOSE-SUR
*>              頛詨--> W-LNK-DOSE-NUM W-LNK-DOSE-DEN
*------>"2"儭啣?頛詨??W-LNK-DOSE-NUM W-LNK-DOSE-DEN) 蝝??箸?蝪∪???
*>              頛詨-->??(W-LNK-DOSE-NUM)??(W-LNK-DOSE-DEN)
*>              頛詨-->W-LNK-DOSE-SUR
*------>"3"儭啣?頛詨??W-LNK-DOSE-NUM W-LNK-DOSE-DEN) 頧??箏??豢芋撘?
*>              頛詨-->??(W-LNK-DOSE-NUM)??(W-LNK-DOSE-DEN)
*>              頛詨-->W-LNK-DOSE-SUR
*------>"4"儭啣?頛詨??W-LNK-DOSE-SUR)頧??箸????
*>              頛詨-->W-LNK-DOSE-SUR
*>              頛詨--> W-LNK-DOSE-NUM (?交?)
*>                      W-LNK-DOSE-YY W-LNK-DOSE-MM W-LNK-DOSE-DD (撟湔???
*------>"5"儭啣?頛詨??W-LNK-DOSE-SUR)頧??箸?????
*>              頛詨-->W-LNK-DOSE-SUR
*>              頛詨--> W-LNK-DOSE-HH (?? W-LNK-DOSE-MT (??
*------>"6"儭啣?頛詨??W-LNK-DOSE-SUR)頧??箇?雿?
*>              頛詨-->W-LNK-DOSE-SUR
*>              頛詨--> W-LNK-DOSE-TTH(N) ?曹?蝯?
*------>"7"儭啣?頛詨??W-LNK-DOSE-SUR)頧??箏?雿?
*>              頛詨-->W-LNK-DOSE-SUR
*>              頛詨--> W-LNK-DOSE-BED
*------>"8"儭啣?頛詨??W-LNK-DOSE-SUR)頧??亦?????
*>              頛詨-->W-LNK-DOSE-SUR
*>              頛詨--> W-LNK-DOSE-HH (??) W-LNK-DOSE-MT (??)
*>              頛詨--> W-LNK-DOSE-HH2 (??) W-LNK-DOSE-MT2 (??)
*********************************************************************************
 01      W-LNK-DOSE-DATA.
*-------> ??璅∪?
        05      W-LNK-DOSE-ID                   PIC X(1).
                88      W-LNK-DOSE-ID-OK        VALUE "1","2","3","4","5","6","7","8".
*-------> 頛詨/頛詨?
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
*------>??W-LNK-DOSE-ID = "1" ???喳? "." 銵?USER 頛詨撠
*------>                              "/" 銵?USER 頛詨?
        05      W-LNK-DOSE-SEP                  PIC X(1).
*------>頛詨?航炊?文蝣?
*------>"1"儭啣?摮?撠銋?賊隞賢云?瑟?瘝撓?乩??撓??." OR "/"
*------>"2"儭啣?瘥?撠憭芷??頛詨雿?頛詨"." OR "/"
*------>"Y"儭啣隞隤?
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
*>  撟湧翩閮?  HRAGECF ....(隢?撠AT-MST霈憟??ALL甇文蝔?)
*> ============================================================
*>
*>>>>>> INPUT ... 閮????(EX.?閮箸)
 01      L-DT                            PIC 9(07).
*>>>>>> OUTPUT .. 撖行革 (YY甇清M??DD憭?
*>>>>>> ??L-ID ?箇征?賣?, ???迨OUTPUT??
 01      L-AGE.
        02      L-AGE-YY                PIC 9(3).
        02      L-AGE-MM                PIC S9(2).
        02      L-AGE-DD                PIC S9(2).
*>>>>>> OUTPUT .. 撖行革?憭批雿?
*>>>>>> 銝恣 L-ID ?箏?撠? 甇力UTPUT?潔?摰???
*>>>>>> 皛蹂?甇脩YY, 銝遛銝甇脫遛銝???撤M, 銝遛銝???慣D
 01      L-AGE-2                         PIC S9(03).
*>>>>>> OUTPUT .. ???潔??桐? (YY??=> A , MM??=> M , DD??=> D)
 01      L-AGE-UNIT                      PIC X(01).
*> 92.01.28 (?啣?)
*>>>>>> INPUT ... [ ]閮?撖行革 [Y]隞亙僑摨衣?
 01      L-ID                            PIC X(01).
*
*COPY    "HR_IBGCF.LNK".

***********************************************************************
*>102.09.06 (FISH) ?D14?亥????航炊?扳??格???嚗???啣?甈?嚗誑?喲?鞈?

 01      W-IBGCF-LNK.
*>   ??交?
        02      W-IBGCF-DATE                    PIC 9(07).
*>   ?霅瑞?蝡?銵典靘?)
        02      W-IBGCF-UNIT                    PIC X(05).
*>   銵典蝔桅?
*>      [A]嚗蛛慾??                     [B]?冽??,?粹撣嗉,擐??    [C]?那??
*>      [D]霅瑞?瘝餌???                 [E]瑼ａ??曉?蝺?霅?              [F]瑼ａ??曉???
*>      [G]?????(?恍??祥??     [H]X?????                 [I]?粹撣嗉??(??)
*>      [J]????                      [K]??亦隢                   [L]?????
*>      [M]?單?瑼ａ??勗?                 [N]?粹???                  [O]??????
*>      [P]蝞∪??蝝??寧?             [Q]???蝞?                  [R]??交?霅?
*>      [S]?芾祥????                  [T]?寞??亙?雿輻?唾???          [U]????
*>      [V]?恣?亙??唾???              [W]瘝餌??蔭??敺拙)             [X]頧?敺拙???
*>      [Y]敺拙瘝餌???????           [Z]銝剝雿霅瑞?蝡??
*>      [a]???”??                  [b]CHEMO 璅惜                   [c]CHEMO 璅惜(蝺亥???
*>      [d]?怠???DC)                   [e]?怠???                      [f]瑼ａ??曉?????)
*>      [g]??批??                 [h]銵摨恍隞嗅
*>      [m]瑼ａ??隞園??              [n]?恣?亙?撖拇??
*>      [q]???蝞?瑼ａ?)             [o]???????啁?)             [v]?恣?嗆扳?蝞∟?隢
*>      [1]?孵??(?芷)               [2]?凋??撐嚗斗?霅?              [3]???亙?????
*>      [4]霅瑞???亦隢               [5]RFID?扳???                  [6]?寞??刻?扳???
*>      [7]?亥????航炊?扳???          [9]?瑟??怠???璅寞?隞?)         [9]?冽??怠???璅寞?隞?)
        02      W-IBGCF-PAPER-ID                PIC X(01).
*>   ?喲?霈(?箔?閬?箏?蝔株”??雿輻甇斗?雿摮EY??
        02      W-IBGCF-PRINT-DATA              PIC X(50).
        02      W-IBGCF-SP-PAPER                PIC X(01).
*>   ??銵典?寞?霅 [ ]銝?砌??Ｚ???  [1]擐????      [2]?粹撣嗉? (雿?蝞?
*>   ??銵典?寞?霅 [1]?那???    [2]?那????                      (?那??
*>   ??銵典?寞?霅 [1]?????   [2]??敺拙瘝餌?                     (???蝞?
*>   ??銵典?寞?霅 [1]??蝝祟?賊? [2]??蝝祟?訾???                 (??蝝??寧?)
*>   ??銵典?寞?霅 [A]?閮箄撅雿輻   [B]雿?亙?雿輻                     (???蝞?
        02      W-IBGCF-PAPER-ID2               PIC X(01).
*>   ?急炎?仿?霅[Y]
        02      W-IBGCF-HAS-D                   PIC X(01).
*>   ?臬??芾???霅瑞?蝡誨??
*>   [ ]-銵其?? HRIBGCF ?芾???瑼??芸??W-IBGCF-UNIT ?喳銋風??隞?Ⅳ?Ｙ??格?
*>   [Y]-銵券???HRIBGCF ?芾???瑼HI_MBED.HR_MRNU.HR_MIBG]嚗??拍 W-IBGCF-IPD-BED ?喳銋?????霅瑞?蝡誨蝣潛???
*>   [A]-銵其?? HRIBGCF ?芾???瑼??拍 W-IBGCF-IPD-BED ?喳銋?????霅瑞?蝡誨蝣潛???
*>   [B]-銵券???HRIBGCF ?芾???瑼HR_MRNU.HR_MIBG]嚗??拍 EXTERNAL 銋?BED-UNIT 銋風??隞?Ⅳ?Ｙ??格?
*>   [C]-銵券???HRIBGCF ?芾???瑼HR_MRNU.HR_MIBG]嚗??拍 W-IBGCF-IPD-BED ?喳銋?????霅瑞?蝡誨蝣潛???
*>   [D]-銵券???HRIBGCF ?芾???瑼HR_MRNU.HR_MIBG]嚗??拍 W-IBGCF-UNIT ?喳銋風??隞?Ⅳ?Ｙ??格?
        02      W-IBGCF-GET-UNIT                PIC X(01).
*>   摨?(W-IBGCF-GET-UNIT = "Y" OR "A" OR "C")????
        02      W-IBGCF-IPD-BED                 PIC X(06).
*>   靘?蝔?
        02      W-IBGCF-CALL-FROM               PIC X(11).
*>   ?急祥??霅[Y]
        02      W-IBGCF-HAS-F                   PIC X(01).
*>   霅??仿??血?瑕????思誘憭抒暺輕?箇征?賭?????
        02      W-IBGCF-RDC-YN                  PIC X(01).
*>   ?臬?葉?亥???
        02      W-IBGCF-CHMED-YN                PIC X(01).
*>   ?臬?箸?隞文神??Y:銵函內?啁??思誘撖怠)

        02      W-IBGCF-NEW-PRINT               PIC X(01).
*>
        02      W-IBGCF-FILLER                  PIC X(26).


*>102.09.06 (FISH) ?D14暾餌?-?亥????航炊?扳??格?隤歹????啣?甈?嚗誑?喲?鞈?
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
* C-PY FILE : HT_W01.LNK   84/08/03     雿?雓?鞎?
* LENGTH 20 BYTES          85/03/26     ?澆閬??瑼?
*************
 01 W01-TABLE.
** ?澆閬??鞈?
   02 W01-M.
**    銝餌?撘???
      03 W01-SYS-NO                     PIC X(2).
**       蝟餌絞隞??                       -- HTPWD-SYS-NO
      03 W01-USR-NO                     PIC X(5).
**       雿輻?誨??                    -- HTPWD-USR-NO
      03 W01-DPT-NO                     PIC X(1).
**       瑼ａ?瑼Ｘ蝘恕蝪∠Ⅳ               -- HTPWD-DPT
      03 W01-DPT-NO1                    PIC X(5).
**       雿輻蝘恕?桐?隞??               -- HG_NID.MST
      03 W01-CLS-TBL.
         04 W01-CLS-CD  OCCURS 14 TIMES PIC X(2).
**          瑼ａ?瑼Ｘ憿蝣?             -- HTPWD-CLS
      03 W01-PWD.
**       撖Ⅳ甈?蝣?                    -- HTPWD-LVL
         04 W01-PWD-C                   PIC X(1).
**          ?啣?甈?蝣?: Y> ?啣?
         04 W01-PWD-M                   PIC X(1).
**          靽格甈?蝣?: Y> 靽格
         04 W01-PWD-D                   PIC X(1).
**          ?芷甈?蝣?: Y> ?芷
         04 W01-PWD-I                   PIC X(1).
**          ?亥岷甈?蝣?: Y> ?亥岷
         04 W01-PWD-P                   PIC X(1).
**          ?甈?蝣?: Y> ?

** IF W01-DPT-NO = SPACES               銝?蝘恕
*COPY    "HT_PATR.LNK".
*************
* C-PY FILE : HT_PATR.LNK  88/09/22     雿?雓?鞎?
* LENGTH 55 BYTES          88/09/22     ?勗??璇辣????瑼?
* CALL "HTPATRPF" USING W01-TABLE, W-PATR-TABLE
*************
 01 W-PATR-TABLE.
** ?勗???鞈?
   02 W-PATR-PT-NO                      PIC 9(8).

**    韏瑕??風?Ⅳ
   02 W-PATR-IP-DATE1                   PIC 9(7).
**    ?思誘(???韏瑕??交?
   02 W-PATR-IP-DATE2                   PIC 9(7).
**    ?思誘(???蝯迫?交?
   02 W-PATR-CLS-CD1                    PIC X(2).
**    瑼ａ?瑼Ｘ韏瑕?憿蝣?
   02 W-PATR-CLS-CD2                    PIC X(2).
**    瑼ａ?瑼Ｘ蝯迫憿蝣?
   02 W-PATR-CHO                        PIC X(1).
**    ??豢? ( 1>靘隞斗??2>靘???) --> 2001/09/26 ADD BY LCH
*COPY    "HT_W01.WRK".
*************
* C-PY FILE : HT_W01.WRK
* LENGTH XXX BYTES
*************
 01 W-LNK-TABLE.
** ?澆閬??鞈?
**    銝餌?撘???
      03 W-SYS-NO                        PIC X(2).
**       蝟餌絞隞??      -- W-PWD-SYS-NO
      03 W-USE-NO                        PIC X(5).
**       雿輻?誨??   -- W-PWD-USR-NO
      03 W-DPT-NO                        PIC X(1).
**       蝘恕隞??      -- W-PWD-DPTC
      03 W-DPT-NO1                       PIC X(5).
**       蝘恕?桐?隞??  -- W-PWD-DPT
      03 W-CLS-TBL.
         04 W-CLS-CD  OCCURS 14 TIMES    PIC X(2).
**          瑼ａ?瑼Ｘ憿蝣?
      03 W-PWD.
**       撖Ⅳ甈?蝣?
         04 W-PWD-C                      PIC X(1).
**          ?啣?甈?蝣?: Y> ?啣?
         04 W-PWD-M                      PIC X(1).
**          靽格甈?蝣?: Y> 靽格
         04 W-PWD-D                      PIC X(1).
**          ?芷甈?蝣?: Y> ?芷
         04 W-PWD-I                      PIC X(1).
**          ?亥岷甈?蝣?: Y> ?亥岷
         04 W-PWD-P                      PIC X(1).
**          ?甈?蝣?: Y> ?
*COPY    "HI_FONCF.LNK".
*--------------------------------------------------------------------------
*>      ?閮箄?雿?祉蝔?                      HI_FONCF.LNK
*--------------------------------------------------------------------------
 01      W-FONCF-LNK.
*>      霅蝣?([01].?閮箄澈隞賭耨???神FON-MST銋ON-06-CHG-CLA> (HIFON1CF ??)
*>              [02].雿?唾?靽格??Ｙ?撣單?蝷箸?行?雿?閮箄?雿
*>              [03].?粹蝯董?內雿頨思遢??閮箄澈隞賭???
*>              [04].?亥岷?閮箏???撠?銋?頧????Ｗ???
*>              [05].?亥岷??亥那?銋?憿?
*>              [06].瘥?蝚血?雿?摨?銋?頧???閮箏???
*>              [07].?啣?閮?<OPEN I-O CHG-MST>
*>              [08].瑼Ｘ?閮箸?行??喳??<OPEN INPUT DTE-MST>)

        02 W-FONCF-ID                           PIC X(02).

*>      ?臬????
        02 W-FONCF-YN                           PIC X(01).
*>      ?航炊閮 (W-FONCF-YN = "N"  ??
        02 W-FONCF-NOTE                         PIC X(60).
*>      雿摨? (W-FONCF-ID = "02" , "06" , "07" ??)
        02 W-FONCF-IPD-NO                       PIC X(11).
*>      ?摨? (W-FONCF-ID = "06" ??)
        02 W-FONCF-ODR-NO                       PIC X(11).
*>      ?閮箏???(W-FONCF-ID = "01" , "06" ??)
        02 W-FONCF-RO-NO                        PIC X(11).
*>      ?啣?閮餉? (W-FONCF-ID =  "07" ??)
*>               (O.?粹蝯董 o.?董 I.?湔蝯董 i.雿蝯董
*>                P.?園?蝜喲? p.??像??R.?嗆狡 r.?甈?
        02 W-FONCF-CHG-ID                       PIC X(01).
*>      ?啣???
        02 W-FONCF-USER-ID                      PIC X(05).
*>      ????(W-FONCF-ID =  "07" ??)
        02 W-FONCF-BED                          PIC X(06).
*>      ?臬?G1-MST (W-FONCF-ID =  "05" ??)
        02 W-FONCF-OPEN-YN                      PIC X(01).
*>      ??
        02 W-FONCF-REC                          PIC X(87).

*--------------------------------------------------------------------------
*>      蝭?
*--------------------------------------------------------------------------
*>      [01].?閮箄澈隞賭耨??
*>      IF      (DG1-IPD-MARK = "I") AND (?澈隞?NOT = 靽格敺?頨思遢) THEN
*>              INITIALIZE      W-FONCF-LNK
*>              MOVE    "01"            TO      W-FONCF-ID
*>              MOVE    "?閮箏???      TO      W-FONCF-RO-NO
*>              CALL    "HIFONCF"       USING   W-FONCF-LNK
*>                                      ON      EXCEPTION CONTINUE END-CALL
*>              IF      W-FONCF-YN = "N"        THEN
*>                      MOVE    W-FONCF-NOTE    TO      W-NOTE
*>                      DISPLAY ?航炊閮
*>              END-IF
*>      END-IF
*>
*>
*>      [02].雿?唾?靽格?內?臬???閮箄?雿
*>      IF      [0709] NID-MST-REC(192:1) = "Y" THEN
*>              INITIALIZE      W-FONCF-LNK
*>              MOVE    "02"            TO      W-FONCF-ID
*>              MOVE    雿摨?        TO      W-FONCF-IPD-NO
*>              CALL    "HIFONCF"       USING   W-FONCF-LNK
*>                                      ON      EXCEPTION CONTINUE END-CALL
*>              IF      W-FONCF-YN = "N"        THEN
*>                      MOVE    W-FONCF-NOTE    TO      W-NOTE
*>                      DISPLAY ?航炊閮
*>              END-IF
*>
*>      [03].?粹蝯董?內雿頨思遢??閮箄澈隞賭???
*>      IF      [0709] NID-MST-REC(197:1) = "Y" THEN
*>              INITIALIZE      W-FONCF-LNK
*>              MOVE    "03"            TO      W-FONCF-ID
*>              MOVE    雿摨?        TO      W-FONCF-IPD-NO

*>              CALL    "HIFONCF"       USING   W-FONCF-LNK
*>                                      ON      EXCEPTION CONTINUE END-CALL
*>              IF      W-FONCF-YN = "N"        THEN
*>                      MOVE    W-FONCF-NOTE    TO      W-NOTE
*>                      DISPLAY ?航炊閮
*>              END-IF

*>      [05].?亥岷??亥那?銋?憿?
*>      IF      [0709] NID-MST-REC(226:1) = "Y" THEN
*>              INITIALIZE      W-FONCF-LNK
*>              MOVE    "05"            TO      W-FONCF-ID
*>              MOVE    雿摨?        TO      W-FONCF-IPD-NO
*>              ?交?O_MDG1 , W-FONCF-OPEN-YN = "Y"
*>              MOVE    "Y"             TO      W-FONCF-OPEN-YN
*>              CALL    "HIFONCF"       USING   W-FONCF-LNK
*>                                      ON      EXCEPTION CONTINUE END-CALL
*>              IF      W-FONCF-YN = "Y"        THEN
*>                      MOVE    W-FONCF-NOTE    TO      W-NOTE
*>                      DISPLAY ?甈暸?憿?
*>              END-IF

*>
*>      [07].?啣?閮?<OPEN I-O CHG-MST>
*>              INITIALIZE      W-FONCF-LNK
*>              MOVE    "07"            TO      W-FONCF-ID
*>              MOVE    雿摨?        TO      W-FONCF-IPD-NO
*>              MOVE    ?啣?閮餉?        TO      W-FONCF-CHG-ID
*>              MOVE    ?啣???         TO      W-FONCF-USER-ID
*>              MOVE    ????         TO      W-FONCF-BED
*>              CALL    "HIFONCF"       USING   W-FONCF-LNK
*>                                      ON      EXCEPTION CONTINUE END-CALL
*>              IF      W-FONCF-YN = "N"        THEN
*>                      MOVE    W-FONCF-NOTE    TO      W-NOTE
*>                      DISPLAY ?航炊閮
*>              END-IF
*>
*>
*>
*>
*>

*--------------------------------------------------------------------------
*>      嚗伐戮嚗扎嚗荔憐?嚗?摩嚗堆撕?嚗佗憬嚗穿憧?
*--------------------------------------------------------------------------
*COPY    "HT_VVV0.WRK".
*************
* C-PY FILE : HT_VVV.WRK 88/11/04       雿??喳?敶?
* LENGTH 302 BYTES       88/11/04       蝟餌絞?閮剖?瑼?
*************
 01 W-VVV-REC.
** 瑼?撠?RECORD?怠?霈 (??HTVVV-REC ??
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


** W-VVV-DPT-CD      : 蝟餌絞隞?? (ex. 'TV':敺桃??拙恕)
** W-VVV-DPT-CD1     : 蝘?
** W-VVV-DPT-CD2     : 摰?

** W-VVV-CLS-CD      : 蝝啗?摰斤?啁?瑼ａ?憿
** W-VVV-V99-CD      : 蝝啗?摰斤?啁?瑼ａ?憿(??扯岫撽?
** W-VVV-STN-CD      : 蝝啗?摰斤?啁?瑼ａ?憿(?閰阡?)

** W-VVV-TYP-MODE    : ?勗??駁?璅∪?( 1> ??璅∪? 2> 隞?Ⅳ璅∪? 3> 閬?璅∪? )
** W-VVV-TYP-CHK     : ?勗?撖拇璅∪?( Y> ?祟??N> 銝?撖拇 )
** W-VVV-PRT-TYP     : ?澆?撘? ( 1> ?? )
** W-VVV-RPT-TYP     : ?勗??啗”?澆?( 1> ?典撐  2> ?撐  3> 8 ?勗?  4> 9 ?勗? 5> 8.5 ?勗? )

** W-VVV-V99-MODE    : ?喳璅∪?    ( 1> ??   2> ?芸? )

** W-VVV-BAR-TYP     : 璅惜?澆?    ( 1> ?啁姘?恍 2> ?唬葉?恍 )
** W-VVV-BAR-PRT     : 瑼ａ??駁??唳?蝐?

** W-VVV-ORSA-VIRNO  : ORSA ?
** W-VVV-ORSA-DRUG   : ORSA ?亙?

** W-VVV-MIC-YN      : ?臬??MIC 瘜?
** W-VVV-ICD-YN      : ?勗??臬?啗那??

** W-VVV-FIRST-YN    : 銵瘨脣擗?行??活?勗?

** W-VVV-VPL-TYP     : 瑼ａ?蝺函Ⅳ閬?( 1> 撟? 2> 撟湔?  3> 撟湔???)


** W-VVV-WRK-1       : 靘炎撽??亙??啣極雿???   ( Y> ?? N> ??)
** W-VVV-WRK-2       : 撌乩?皜?唳???隞?Ⅳ      ( Y> ?? N> ??)
** W-VVV-WRK-3       : 瘥瑼ａ??餉?蝪踹??蝝誨蝣? Y> ?? N> ??)
** W-VVV-WRK-4       : 撌乩?皜???亦閮倏?啁陛銵? Y> ?? N> ??)
** W-VVV-SAV-PRT     : 摮?摰???               ( Y> ?? N> ??)

** W-VVV-RPT-END-1   : ?勗?銵典偏?酉銝
** W-VVV-RPT-END-2   : ?勗?銵典偏?酉鈭?

*COPY    "HM_SID0.WRK".
*   瑼?撠?RECORD?怠?霈 (??HMSID-REC ??
 01  W-SID-REC.
    02  W-SID-KEY.
*       >蝟餌絞隞?? (ex. 'HM':?怠飛?弦, 'HT':瑼ａ?摰? 'TV':敺桃??拙恕)
        03  W-SID-SYS-CODE.
*           ??撅
            04  W-SID-SYS-CODE1                     PIC X.
*           隤??
            04  W-SID-SYS-CODE2                     PIC X.
    02  W-SID-DATA.
*       >蝟餌絞?迂
        03  W-SID-SYS-NAME                          PIC X(40).
*       >蝟餌絞蝞∠??誨??
        03  W-SID-USER-NO                           PIC X(10).
*       >蝟餌絞蝞∠???蝣?
        03  W-SID-USER-PASS                         PIC X(10).
*       >鞈??批捆 (?澆???蝔?銝剝??啣?蝢?
        03  W-SID-REMARK.
            04  W-SID-REMARK1                       PIC X(60).
            04  W-SID-REMARK1-REDEF REDEFINES W-SID-REMARK1.
*               >蝘恕蝪∠Ⅳ(T)
                05  W-SID-DPTC                      PIC X.
*               >雿平憿隞??(13)
                05  W-SID-CLS                       PIC X(02).
*               >?桐?隞??
                05  W-SID-DPT-NO                    PIC X(05).
*               >嚗荔撞嚗喉慼??STAAUR0)
                05  W-SID-ORSA-VIR                  PIC X(07).
*               >嚗荔撞嚗喉慼??OX)
                05  W-SID-ORSA-ANT                  PIC X(05).
*               >瑼ａ??餉?蝪?Y/N)
                05  W-SID-REC-BOOK                  PIC X(01).
*               >??券??(Y/N)
                05  W-SID-EQU-NET                   PIC X(01).
*               >撌脣??????;?格瑼ａ??寞活??????箄府?株?
                05  W-SID-PRT-OVER                  PIC X(01).
*               >瑼ａ??餉?蝪蹂?瑼ａ??交???(Y??N銝?) -- DEAFULT = Y
                05  W-SID-REC-PAGE                  PIC X(01).
*               >撌乩?皜
                05  W-SID-WRK-LIST                  PIC X(01).
*               >?炎敺
                05  W-SID-PRE-TEST                  PIC X(01).
*               >?炎撽頂蝯梢??
                05  W-SID-HT-LINK                   PIC X(01).
*               >雿輻?????扼??交抒絞閮”
                05  W-SID-OLD-RS-RPT                PIC X(01).

*               >??蝯梯?銵函敦??
                05  W-SID-NEW-VR-RPT                PIC X(01).
*               >敺桃??拇炎撽?撘?
                05  W-SID-RPT-TYP                   PIC X(01).
*               >蝛箇??
                05  W-SID-FILLER                    PIC X(30).
            04  W-SID-REMARK2                       PIC X(60).
            04  W-SID-REMARK2-REDEF REDEFINES W-SID-REMARK2.
                05  W-SID-ANTNO1 OCCURS 12 TIMES    PIC X(05).
            04  W-SID-REMARK3                       PIC X(60).
            04  W-SID-REMARK3-REDEF REDEFINES W-SID-REMARK3.
                05  W-SID-ANTNO2 OCCURS 12 TIMES    PIC X(05).




*COPY    "HM_SYS0.WRK".
*<< BOF OF HM_SYS0.WRK >>*******************************************************
*   瑼?撠?RECORD?怠?霈 (??HMSYS-REC ??
 01  W-SYS-REC.
    02  W-SYS-KEY.
*       蝟餌絞隞?? (ex. HT:瑼ａ?)
        03  W-SYS-SYS-CODE.
*           ??撅
            04  W-SYS-SYS-CODE1                PIC X.
*           隤??
            04  W-SYS-SYS-CODE2                PIC X.
*       雿輻?誨??(?∪極隞??)
        03  W-SYS-USER-NO                      PIC X(10).
*   雿輻??蝣?
    02  W-SYS-USER-PASS                        PIC X(10).
*   撅祆扳見?蹂誨??(?T_ATTX?賊???
    02  W-SYS-ATT-CODE                         PIC X(2).
*   蝟餌絞撖Ⅳ??交?
    02  W-SYS-DATE-FROM.
        03  W-SYS-DATEF-YYY                    PIC 9(3).
        03  W-SYS-DATEF-MM                     PIC 9(2).
        03  W-SYS-DATEF-DD                     PIC 9(2).
*   蝟餌絞撖Ⅳ??交?
    02  W-SYS-DATE-TO.
        03  W-SYS-DATET-YYY                    PIC 9(3).
        03  W-SYS-DATET-MM                     PIC 9(2).
        03  W-SYS-DATET-DD                     PIC 9(2).
*   ??蝟餌絞銝蝙?刻???
    02  W-SYS-PWD-RIGHT                        PIC X(60).
*   ??蝟餌絞銝岷??蝣澆
    02  W-SYS-PWD-ASK                          PIC X(60).
*   蝟餌絞?酉
    02  W-SYS-PWD-REMARK                       PIC X(60).
 01  W-SYS-REF.
*   蝟餌絞蝞∠???
    02  W-SYS-SYS-OWNER                        PIC X(10).
*   蝟餌絞?迂
    02  W-SYS-SYS-NAME                         PIC X(40).
*   璅??迂
    02  W-SYS-ATT-NAME                         PIC X(40).
*<< EOF OF HM_SYS0.WRK >>*******************************************************




*97.07.08(MONIYA)?風鈭?閫??
*COPY    "HH_PTDEC.LNK".
**************************************************************************
*>      ?風鞈?撖急??瑼圾撖?HH_PTDEC.LNK <<HHPTDECF.CBL>>           *
*>      CALL "HHPTDECF" USING W-PTDECF-LNK ON EXCEPTION CONTINUE END-CALL*
**************************************************************************
*?風鈭??圾撖?甈?                                                  *
*??嚗at_birth_dt?a2_birth_dt                                    *
*?憪?嚗at_name?a2_name                                            *
*頨思遢霅?嚗at_idno?a2_idno                                            *
*?雿?嚗at_addr?a2_addr?a2_addr1                                 *
*?砍?餉店嚗at_tel1                                                      *
*撅振?餉店嚗at_tel2?a2_tel3                                            *
*E-MAIL  嚗a2_email                                                     *
**************************************************************************
 01      W-PTDECF-LNK.
*>      ??霅嚗>?啣?WRITE(靘??詨?撖ncryption)?>靽格REWRITE(靘??詨?撖ncryption)
*>                D>?芷(Delete) -> ?芷?其遢?芾???HH_MTEL?H_MPAT?H_MAP2?H_MPA3?H_MPAL嚗擗?獢??頂蝯梯銵???
*>                O>閫??(Decryption)
*>                A>?桐?頨思遢霅?撖?Encryption)
*>                B>?桐??風?圾撖?Decryption)
*>                Z>?斗撖急??AT-MST-STATUS???暨99]??甇斤??神?亦?甇瑞????
               02      W-PTDECF-IO-SW                          PIC X(01).
*>      ??瑼?HH_MPAT
               02      W-PTDECF-IO-HHPAT-YN                    PIC X(01).
*>      ??瑼?HH_MPA2
               02      W-PTDECF-IO-HHPA2-YN                    PIC X(01).
*>      ??瑼?HH_MPA3
               02      W-PTDECF-IO-HHPA3-YN                    PIC X(01).
*>      ?風?Ⅳ
               02      W-PTDECF-PAT-NO                         PIC 9(08).
*>      ??嚗>???>憭望?
               02      W-PTDECF-IO-YN                          PIC X(01).
*>      ??憭望?閮
               02      W-PTDECF-IO-ERR-MSG                     PIC X(80).
*>      ?餃鞈?
               02      W-PTDECF-LOGIN-DATA.
*>              蝔??迂嚗?嚗HPATKF...蝑?
                       03      W-PTDECF-PROG-ID                PIC X(10).
*>              C-PY FILE嚗?嚗T_PAT0.PRC...蝑?
                       03      W-PTDECF-COPY-FILE              PIC X(20).
*>              蝔?畾萄?(憒?F-HH-FPAT-REA...)
                       03      W-PTDECF-PROG-PARA              PIC X(30).
*>              蝔?銝剜?隤芣?(憒??風蝬剛風雿平-TEXT???Ｙ隢?GUI...)
                       03      W-PTDECF-PROG-NM                PIC X(20).
*>              ??賊?(憒?[1 ]?F1]...蝑?璆剖??踝???頂蝯梯銵楊?暑??
                       03      W-PTDECF-FUN-SEL                PIC X(02).
*>              ?啣?鈭箔誨蝣??∪極蝺刻?)
                       03      W-PTDECF-UPD-UID                PIC X(05).
*>      ?風銝餅? (PAT-MST-REC ??[520] ??
               02      W-PTDECF-PAT-MST-REC                    PIC X(520).
*>      ?風銝餅?(鈭? (PA2-MST-REC ??[386] ??
               02      W-PTDECF-PA2-MST-REC                    PIC X(386).
*>      ?風銝餅?(銝? (HHPA3-MST-REC ??[508] ??

               02      W-PTDECF-HHPA3-MST-REC                  PIC X(508).
*>      ??
               02      W-PTDECF-FILLER.
*>              HHPAT-MST 撖急?瑼????
                       03      W-PTDECF-IO-HHPAT-STATUS        PIC X(02).
*>              HHPA2-MST 撖急?瑼????
                       03      W-PTDECF-IO-HHPA2-STATUS        PIC X(02).
*>              HHPA3-MST 撖急?瑼????
                       03      W-PTDECF-IO-HHPA3-STATUS        PIC X(02).
*>              ?桐?頨思遢霅?撖撓?交?隞?
                       03      W-PTDECF-INPUT-PAT-IDNO-DATA.
                               04 W-PTDECF-INPUT-PAT-IDNO      PIC X(10).
                               04 W-PTDECF-INPUT-PAT-BIRTH-DT  PIC S9(7).
*>              ?桐?頨思遢霅?撖撓?箸?隞?
                       03      W-PTDECF-OUTPUT-PAT-IDNO-DATA.
                               04 W-PTDECF-OUTPUT-PAT-IDNO     PIC X(10).
*>              E-TABLE ?風鈭閰Ｖ?璆剖??
                       03      W-PTDECF-E-PROG-CALL-YN         PIC X(01).
*>              ?臬閬脰? HHPAL 撖急?嚗銝?舫?閮剛?撖急?嚗 N ?臭?撖怠 HHPAL
                       03      W-PTDECF-HHPAL-WRT-YN           PIC X(01).
*>              ?桐??箇??亙?撖撓?箸?隞?
                       03      W-PTDECF-OUTPUT-PAT-BIRTH-DT-DATA.
                               04 W-PTDECF-OUTPUT-PAT-BIRTH-DT PIC S9(7).
*>              ?桐??風?圾撖撓?交?隞?
                       03      W-PTDECF-INPUT-PAT-NO           PIC X(8).
*>              ?桐??風?圾撖撓?箸?隞?
                       03      W-PTDECF-OUTPUT-PAT-NO          PIC X(8).
*>              ??甈?
                       03      W-PTDECF-FILLER-1               PIC X(192).
*>106.09.04(??)
 01      W-PTDECF2-LNK.
*>      ??瑼?HH_MPA7
               02      W-PTDECF-IO-HHPA7-YN                    PIC X(01).
*>      HHPA7-MST 撖急?瑼????
               02      W-PTDECF-IO-HHPA7-STATUS                PIC X(02).
*>      ?風銝餅?(銝? (HHPA7-MST-REC ??[508] ??
               02      W-PTDECF-HHPA7-MST-REC                  PIC X(508).
*>      ??
               02      W-PTDECF2-FILLER.
*>              ??甈?
                       03      W-PTDECF2-FILLER-1               PIC X(1521).

*>106.06.07 獢-瑼ａ??曉?蝺閰Ｖ?璆剖?斗炎撽????????
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
*> 97.7.23 ????
 01      ENB-MST-STATUS                  PIC XX IS EXTERNAL.
 01      IKEY-TMP-STATUS                 PIC XX IS EXTERNAL.
 01      ICC-MST-STATUS                  PIC XX IS EXTERNAL.
 01      ENA-MST-STATUS                  PIC XX IS EXTERNAL.
 01      ENC-MST-STATUS                  PIC XX IS EXTERNAL.
 01      HIEND-MST-STATUS                PIC XX IS EXTERNAL.
*> 103.06.27 (?訾撰) 靽格撖阡???仿?甈?霈??皞??寡?RTA?TB??
 01      RTA-MST-STATUS                  PIC XX IS EXTERNAL.
 01      RTB-MST-STATUS                  PIC XX IS EXTERNAL.
*> 103.06.27 END
*>2019/12/24 ??IS
*>?芷??撖信R_UDL3
 01      HRUDL3-MST-STATUS               PIC X(02) IS EXTERNAL.
*>閮?ICA撖急??航炊蝣墩7]
 01      LOG2-MST-STATUS                 PIC X(02) IS EXTERNAL.
*------->瑼??賊?霈...
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
*--->閮?甈∪????賊?
        02      W-QTY1          PIC 9(07).
        02      W-QTY2          PIC 9(04).
        02      W-DIS-QTY       PIC X(12).
        02      W-CHK-EXIT      PIC X(01).
*-->?斗?臬閬閰Ｗ?方???D"
        02      W-TYPE1         PIC X(01).
        02      W-GRID-Y        PIC 9(03).
        02      W-GRID-Y1       PIC 9(03).
*--->??RRCB123IF
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
*------->?臬??澆???Y/N).........
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
*> 撠RID?????汾-DIS-TABLE
***********************************************************************
 78      W-MENU-ITEMS                    VALUE 16.
 01      W-MENU-SEL                      PIC 9(2) VALUE 1.
        88 W-EXIT-SEL                   VALUE 99.
*>
 01      W-KEY-TABLE.
        02 W-KEY-TBL1 OCCURS 100 TIMES.
                03 W-KEY1               PIC X(300).
*>START                 (AICE) 106.11.09 憓?憿舐內撌脣?支?瑼ａ??
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
*>START                 (AICE) 106.11.09 憓?憿舐內撌脣?支?瑼ａ??
                        04      W-HRDTB-REC     PIC X(207).
*>END 106.11.09
                        04      W-DIS-CLS-CD    PIC X(02).
                        04      W-DIS-DPT-NO    PIC X(01).
                        04      W-DIS-CHK-NO    PIC X(08).
                        04      W-DIS-ITM-CD    PIC X(06).
                        04      W-DIS-NAME      PIC X(40).
*> 蝪賣??
                        04      W-DIS-AC-MAN    PIC X(05).
                        04      W-DIS-AC-DATE   PIC 9(07).
                        04      W-DIS-AC-TIME.
                                05      W-DIS-AC-HH     PIC 9(02).
                                05      W-DIS-AC-MM     PIC 9(02).
                                05      W-DIS-AC-SS     PIC 9(02).
*> ?勗???
                        04      W-DIS-RP-F-MAN  PIC X(05).
                        04      W-DIS-RP-L-MAN  PIC X(05).
                        04      W-DIS-RP-DATE   PIC 9(07).

                        04      W-DIS-RP-TIME.
                                05      W-DIS-RP-HH     PIC 9(02).
                                05      W-DIS-RP-MM     PIC 9(02).
                                05      W-DIS-RP-SS     PIC 9(02).
*> ??迂
                        04      W-DIS-ITM-NM    PIC X(40).
*> 瑼ａ?
                        04      W-DIS-SPL-NM    PIC X(20).
*> 摰孵
                        04      W-DIS-BTL-NM    PIC X(20).
*> ?寥?閮箇??
                        04      W-DIS-OPD-APY   PIC X(01).
                        04      W-HTCHK-IP-DATE PIC 9(07).

*>---?怠?瑼?---
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
* C-PY FILE : MT_ODRW.LNK 890424-890510 雿?雓?鞎?
* CALL "HTODRWCF" USING W-ODRW-TABLE    瑼ａ?瑼Ｘ?脣漲?亥岷?瑼?
*************
 01 W-ODRW-TABLE.
** ?脣漲?亥岷?唾撓鞈?
   02 W-ODRW-IP-NO                       PIC X(22).
**    ?思誘摨?
   02 W-ODRW-IP-NO1 REDEFINES W-ODRW-IP-NO.
**    ?閮粹隞文???
      03 W-ODRW-RO-NO                   PIC 9(11).
**       ?閮箏???                      -- ODR-RO-NO
      03 W-ODRW-RO-SEQ                  PIC 9(2).
**       ?摨?                       -- ODR-ODR-SEQ
      03 W-ODRW-RO-FL                   PIC X(9).
**       蝛箇??
   02 W-ODRW-IP-NO2 REDEFINES W-ODRW-IP-NO.
**    雿?思誘摨?
      03 W-ODRW-PD-NO                   PIC 9(11).
**       雿摨?                       -- ICB-IPD-NO
      03 W-ODRW-PD-SEQ                  PIC 9(11).
**       ?摨?                       -- ICB-ODR-NO
   02 W-ODRW-PRS.
**    ?蔭?亥岷鞈?
      03 W-ODRW-PRS-SEQ                 PIC 9(3).
**       ?蔭摨?                       -- ICB-FEE-SEQ OR ODR-FEE-NO
      03 W-ODRW-CHK-NO                  PIC X(8).
**       瑼ａ?瑼Ｘ?株?                   -- ICB-CHK-NO  OR ODR-CHK-NO
      03 W-ODRW-ITM-CD                  PIC X(6).

**       瑼ａ?瑼Ｘ?隞?Ⅳ               -- ICB-ITM-CD  OR ODR-ITM-CD
      03 W-ODRW-TRN-SW                  PIC X(1).
**       ?舐?Ⅳ                       -- Y > ?舐???桀????芷?蔭
      03 W-ODRW-WK-SW                   PIC X(1).
**       雿平瘚?蝣?: A> ?思誘??, B> 瑼ａ??內, C> 瑼ａ??見, D> 瑼ａ??炎,
**                    E> ?思誘?炎, F> ?思誘蝪賣, G> ?思誘憭? H> ?思誘瑼Ｘ,
**                    I> ?思誘??, J> 蝯??勗?, K> ?勗?撖拇
      03 W-ODRW-WK-NAME                 PIC X(8).
**       雿平瘚??迂
   02 W-ODRW-DEL-SW                     PIC X(1).
**    ?舐?Ⅳ                          -- Y > ?臬?斗撘菔?蝵??勗?日脣)
*COPY    "HX_GSCH.LNK".
* ==SCL== 2003.01.23 START ----- 憓?雿?思誘霅瑞?蝡???? ---------- *
*************
* C-PY FILE : HX_GSCH.LNK 901106-910318  雿?雓?鞎?
* CALL "HXSCHCF" USING LX-SCH-TABLE     瑼Ｘ憿??交?瑼ａ??瑼?
*************
 01 LX-SCH-TABLE.
   02 LX-SCH-FUN-SW                     PIC X(1).
**    ?炎???賡蝣?Y/N)               -- 91/03/18
   02 LX-SCH-PT-NO                      PIC 9(8).
**    ?風?Ⅳ
   02 LX-SCH-PT-ID                      PIC X(10).
**    頨思遢摮?
   02 LX-SCH-PT-NAME                    PIC X(12).
**    憪?
   02 LX-SCH-PT-DATE                    PIC S9(7).
**    ?箇???
   02 LX-SCH-PT-SEX                     PIC X(1).
**    ?批
   02 LX-SCH-PT-BED.
**    摨?
      04 LX-SCH-PT-BED-ROOM             PIC X(04).
      04 LX-SCH-PT-BED-NO               PIC X(02).
   02 LX-SCH-IP-NO                      PIC X(22).
**    ?思誘摨?
   02 LX-SCH-IP-NO1 REDEFINES LX-SCH-IP-NO.
**    ?閮粹隞文???
      03 LX-SCH-RO-NO                   PIC 9(11).
**       ?閮箏???
      03 LX-SCH-OR-NO                   PIC 9(2).
**       ?摨?
      03 LX-SCH-RO-FL                   PIC X(9).
**       蝛箇??
   02 LX-SCH-IP-NO2 REDEFINES LX-SCH-IP-NO.
**    雿?思誘摨?
      03 LX-SCH-PD-NO                   PIC 9(11).
**       雿摨?
      03 LX-SCH-OD-NO                   PIC 9(11).
**       ?摨?
* ==SCL== 2003.01.23 START ----- 憓?雿?思誘霅瑞?蝡???? ---------- *
   02 LX-SCH-SCP-PRINT-SW               PIC X(01).
**    ???桃畾銵冽撘?
   02 LX-SCH-QUE-UNIT                   PIC X(05).
**    霅瑞?蝡誨蝣?
* ==SCL== 2003.01.23 END   ----- 憓?雿?思誘霅瑞?蝡???? ---------- *
   02 LX-SCH-FILLER                     PIC X(54).

**    靽?
   02 LX-SCH-DATA-PRS OCCURS 98 TIMES.
      03 LX-SCH-CMD-ISW                 PIC X(1).
**       ?垢憓耨?芸??賜Ⅳ (C:?啣??蔭, D:?芷?蔭, M:靽格?蔭?炎?挾)
      03 LX-SCH-CMD-OSW                 PIC X(1).
**       敺垢憓耨?芸??賜Ⅳ (C:?啣??蔭, D:?芷?蔭, M:靽格?蔭?炎?挾)
      03 LX-SCH-PRS-NO                  PIC X(9).
**       ?蔭隞?Ⅳ                       -- PRS-MST-ID (IF PEF-MST-REC(436:1) = 'Y')
      03 LX-SCH-PRS-DPT                 PIC X(1).
**       瑼Ｘ蝘恕蝪∠Ⅳ                   -- PRS-PAS-DPT
      03 LX-SCH-PRS-CLS                 PIC X(2).
**       瑼Ｘ?格?憿隞?Ⅳ               -- PRS-PAS-TAB
      03 LX-SCH-PRS-ITM                 PIC X(6).
**       瑼Ｘ蝝圈?隞?Ⅳ                   -- PRS-PAS-ITM
      03 LX-SCH-NEW-DATE                PIC 9(7).
**       閮粹??唳?瑼Ｘ??                -- ICB-PAS-DAT OR ODR-PAS-DAT
      03 LX-SCH-NEW-TIME                PIC 9(4).
**       閮粹??唳?瑼Ｘ???                -- ICB-PAS-TIM OR ODR-PAS-TIM
      03 LX-SCH-OLD-DATE                PIC 9(7).
**       閮粹???瑼Ｘ??                -- ICB-PAS-DAT OR ODR-PAS-DAT
      03 LX-SCH-OLD-TIME                PIC 9(4).
**       閮粹???瑼Ｘ???                -- ICB-PAS-TIM OR ODR-PAS-TIM
      03 LX-SCH-PRS-SEQ                 PIC 9(3).
**       ?蔭摨?                       -- ICB-FEE-SEQ OR ODR-FEE-NO
      03 LX-SCH-CRE-SEQ                 PIC 9(4).
**       ?蔭撱箸???雿銝?)           -- ICB-FEE-SEQ OR ODR1-CRE-NO
      03 LX-SCH-FILLER1                 PIC X(30).

**    PEF-MST-REC(436:1) = 'Y'   閮粹???瑼Ｘ?

**WX-SCH-SCP-PRINT-SW嚗?蝛箇 & Y >LOACL ?
*                       N        >銝???
*                       1        >QUE   ? (雿?思誘???梯風???啣) 嚗??WX-SCH-QUE-UNIT
*                       2        >QUE   ? & LOACL ?               嚗??WX-SCH-QUE-UNIT
*COPY    "HT_OLGP.WRK".
*霅瑞?蝡??啁???
 01  W-ODR-LGP    PIC X IS EXTERNAL.
*?梯”?蝯?(N:銵典仃??
 01  W-ODR-PRN    PIC X IS EXTERNAL.
 01      W-DIS-CHK-DATA.
               02      W-DIS-AC-NAME   PIC X(12).
               02      W-DIS-RP-F-NAME PIC X(12).
               02      W-DIS-RP-L-NAME PIC X(12).
 01      W-EXT-HEIGHT                    PIC X(05) IS EXTERNAL.
*>01    ECB-OPD-APY                     PIC X(01).

*> ?瑼ａ??曉???鈭斤?摰?
 01      W-ODRPF-PASS-LNK.
*       ?思誘?株?
        02 W-ODRPF-CHK-NO-LNK.
                03 W-ODRPF-CHK-NO1-LNK       PIC X.
                03 W-ODRPF-CHK-NO2-LNK       PIC X(2).
                03 W-ODRPF-CHK-NO3-LNK       PIC 9(5).
*       ?思誘?交?
        02 W-ODRPF-IP-DATE-LNK          PIC 9(7).
*       ?恍?迂
        02 W-ODRPF-HOS-NAME-LNK         PIC X(18).

 01      W-ODRPF-PASS2-LNK.
        02 W-ODRPF-P2-LNK  OCCURS 99 TIMES.
                03 W-ODRPF-CTM-CD-LNK        PIC X(6).
 01      W-ODRPF-PASS3-LNK.
*       N:銝"?"?內
        02 W-ODRPF-REPRN-SW-LNK         PIC X.

*> 瑼ａ??桅??唳?蝷箄???
 01      W-REPRN-SW                      PIC X(01) IS EXTERNAL.
*> CALL HTRPTICF 撠
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
*>START 106.06.07  W-HTICB2BF-LNK 隞丘OPY FILE HT_ICB2BF.LNK?誨
*01     W-HTICB2BF-LNK.
**> 雿平霅 [1]?脣??單摮?  [2]蝯??寞活??
**> ??閮 [E]??憭望?
*       02      W-HTICB2BF-STATUS       PIC X(01).
**> 雿摨????孵???
*       02      W-HTICB2BF-IP-NO        PIC X(22).
**> ????
*       02      W-HTICB2BF-CR-MAN       PIC X(05).
**> ?桀???
*       02      W-HTICB2BF-CR-DATE      PIC 9(07).
*       02      W-HTICB2BF-CR-TIME      PIC 9(06).
**> ??DR
*       02      W-HTICB2BF-IP-MAN       PIC X(04).
**> ip-date
*       02      W-HTICB2BF-IP-DATE      PIC 9(07).
*>END 106.06.07
 01      W-GD-COLOR              PIC 9(05) COMP-1.
*> 瑼ａ??勗??亥岷雿輻 (敹膝)
 01      W-HT-GUI-SW                     PIC X(01) IS EXTERNAL.
*> 97.7.23 ????
 01      W-ODRW-CNT              PIC 9(2).
*COPY    "HI_ODRW.LNK".
*********************************************************************************
* 雿??啣?(?啣??耨?嫘???舐?撘????                                 *
* 940201 ?他NK蝮賡摨行????郊靽格迤蝔??劬-ODRICF-LNK?瑕漲                      *
*********************************************************************************
 01      W-ODRW-LNK.
*>      ?霅(I.?啣? M.靽格 D.?芷)
        02      W-ODRW-ID                               PIC X(1).
*>      ???撌乩誨??
        02      W-ODRW-USER                             PIC X(5).
*>      (HT.瑼ａ?蝪賣 HR.?思誘?? HB.銵摨怠?摨?
        02      W-ODRW-FROM                             PIC X(2).
*>      ????(Y.?? N.?隤?

        02      W-ODRW-OK                               PIC X(1).
*>      ???炊閮(W-ODRW-OK = "N")
        02      W-ODRW-NOTE                             PIC X(60).
*>      雿摨?
        02      W-ODRW-IPD-NO.
                03      W-ODRW-IPD-DATE                 PIC 9(7).
                03      W-ODRW-IPD-SEQ                  PIC 9(4).
*>      蝛箇.?勗蝔??KEY-TMP
*>      Y.銝?舐?撘?IKEY-TMP嚗?澆蝔??芾??KEY-TMP
        02      W-ODRW-NO-LOCK                          PIC X(1).
*>      ??摨?(I.?啣?雿輻)
        02      W-ODRW-ODR-NO                           PIC 9(11).
        02      FILLER                                  PIC X(188).

*>      ICA-MST鞈?
        02      W-ODRW-ICA-DATA                         PIC X(200).
*>      I.?啣?(ICA?喲??)
        02      WI-ODRW-ICA-DATA        REDEFINES       W-ODRW-ICA-DATA.
*>              ??交?(敹‵)
                03      WI-ICA-INS-DATE                 PIC 9(7).
*>              ?蝘(?臭?憛恬??身?澆葆雿蝘IPD-DPT)
                03      WI-ICA-DEPT-NO                  PIC X(4).
*>              ??怠葦(?臭?憛恬??身?澆葆銝餅祥?怠葦IPD-MJ-DR)
                03      WI-ICA-DR-NO                    PIC X(4).
*>              ?摨?(?臭?憛恬??身?澆葆BDL-BED)
                03      WI-ICA-WARD                     PIC X(6).
                03      FILLER                          PIC X(179).
*>      M.靽格(ICA?喲??)
        02      WM-ODRW-ICA-DATA        REDEFINES       W-ODRW-ICA-DATA.
*>              ?摨?
                03      WM-ICA-ODR-NO.
                        04      WM-ICA-INS-DATE         PIC 9(7).
                        04      WM-ICA-ODR-SEQ          PIC 9(4).
                03      FILLER                          PIC X(189).
*>      D.?芷(ICA?喲??)
        02      WD-ODRW-ICA-DATA        REDEFINES       W-ODRW-ICA-DATA.
*>              ?摨?
                03      WD-ICA-ODR-NO.
                        04      WD-ICA-INS-DATE         PIC 9(7).
                        04      WD-ICA-ODR-SEQ          PIC 9(4).
                03      FILLER                          PIC X(189).

*>      ICB/ECB?賊?鞈?
        02      W-ODRW-ICB-DATA                         PIC X(12901).
*>              I.?啣?
        02      WI-ODRW-ICB-DATA        REDEFINES       W-ODRW-ICB-DATA.
                03      WI-ICB-DATA     OCCURS 97  TIMES.
*>                      ?蔭隞?Ⅳ(敹‵)
                        04      WI-ICB-FEE-KEY          PIC X(9).
*>                      ?賊???(?臭?憛恬??身?潛1)
                        04      WI-ICB-RX-QTY1          PIC 9(4).
*>                      ?賊???(?臭?憛恬??身?潛1)
                        04      WI-ICB-RX-QTY2          PIC 9(2).
*>                      隞祥(閮)(Y/N)(?臭?憛恬??身?澆葆?蔭隞?Ⅳ閮剖?PRS-INS-PAY/PRS-OWN-PAY)
                        04      WI-ICB-CHG-FLAG         PIC X(1).
*>                      撘瑕?芾祥(Y/ )(?臭?憛恬??身?潛蝛箇)
                        04      WI-ICB-SP-YN            PIC X(1).

*>                      ?瑁??交?(韏?(?臭?憛恬??身?潛蝛箇)
                        04      WI-ICB-OP-BDATE         PIC 9(7).
*>                      ?瑁???(韏?(?臭?憛恬??身?潛蝛箇)
                        04      WI-ICB-OP-BTIME         PIC 9(4).
*>                      ?瑁??交?(餈?(?臭?憛恬??身?潛蝛箇)
                        04      WI-ICB-OP-EDATE         PIC 9(7).
*>                      ?瑁???(餈?(?臭?憛恬??身?潛蝛箇)
                        04      WI-ICB-OP-ETIME         PIC 9(4).
*>                      ??葆???園?(*-->??葆????-->暻駁??)(?臭?憛恬??身?潛蝛箇)
                        04      WI-ECB-LNK-POINT-HEAD   PIC X(01).
*>                      ??葆???活(??葆???獄????(?臭?憛恬??身?潛蝛箇)
                        04      WI-ECB-LNK-POINT        PIC X(09).
*>                      ??葆???獄???脣??????臭?憛恬??身?潛蝛箇)
                        04      WI-ECB-LNK-TIME.
                                05      WI-ECB-LNK-HH   PIC 9(02).
                                05      WI-ECB-LNK-MM   PIC 9(02).
                                05      WI-ECB-LNK-SS   PIC 9(02).
*>                      2017/12/28 ?啣?-銵?撖怠?孵
*>                      ICB撖怠憭望?
                        04      WI-ICB-WRITE-YN         PIC X(01).
*>                      2019/04/02 ?唬葉-?瑁?鈭箏
                        04      WI-ECB-EXECUTE-USR      PIC X(05).
*>                      ??
                        04      FILLER                  PIC X(72).
*>              M.靽格(ICB?CB?喲??)
        02      WM-ODRW-ICB-DATA        REDEFINES       W-ODRW-ICB-DATA.
                03      WM-ICB-DATA     OCCURS 97  TIMES.
*>                      雿(I.?啣??蔭 M.?蹂誨??瘚偌??蝵?D.?芷??瘚偌??蝵?
                        04      WM-ICB-ID               PIC X(1).
*>                      ?蔭瘚偌??WM-ICB-ID = "M" OR "D"??敹???摰?
                        04      WM-ICB-FEE-SEQ          PIC 9(3).
*>                      ?蔭隞?Ⅳ
                        04      WM-ICB-FEE-KEY          PIC X(9).
*>                      ?賊???
                        04      WM-ICB-RX-QTY1          PIC 9(4).
*>                      ?賊???
                        04      WM-ICB-RX-QTY2          PIC 9(2).
*>                      瑼ａ?瑼Ｘ?株?(HTCHK-CHK-NO)
                        04      WM-ICB-CHK-NO.
*>                              瑼ａ?瑼Ｘ憿隞??(HTCHK-CLS-NO)
                                05      WM-ICB-CLS-NO   PIC X(3).
*>                              ?瘚偌蝣?HTCHK-PR-SEQ)
                                05      WM-ICB-PR-SEQ   PIC 9(5).
*>                              瑼ａ?瑼Ｘ?隞?Ⅳ(HTCHK-ITM-CD)
                                05      WM-ICB-ITM-CD   PIC X(6).
*>                      隞祥(閮)(Y/N)
                        04      WM-ICB-CHG-FLAG         PIC X(1).
*> 2005/6/10
*>                      ??葆???園?(*-->??葆????-->暻駁??)(?臭?憛恬??身?潛蝛箇)
                        04      WM-ECB-LNK-POINT-HEAD   PIC X(01).
*>                      ??葆???活(??葆???獄????(?臭?憛恬??身?潛蝛箇)
                        04      WM-ECB-LNK-POINT        PIC X(09).
*>                      ??葆???獄???脣??????臭?憛恬??身?潛蝛箇)
                        04      WM-ECB-LNK-TIME.
                                05      WM-ECB-LNK-HH   PIC 9(02).
                                05      WM-ECB-LNK-MM   PIC 9(02).
                                05      WM-ECB-LNK-SS   PIC 9(02).

*
                        04      FILLER                  PIC X(83).
*97.10.15(MONIYA)?啣?瑼Ｘ??瑁???西?芷?匱蝥?銝銵?
 01      W-DELETE-YN             PIC X(01).
*> IKEY-TMP ??雿平
*COPY    "HI_KMPCF.LNK".
******************************************************************************
*       C-PY FILE : HI_KMPCF.LNK        ?澆    HIKMPCF ?喲?銋???
*>      2012/9/17 ?啣?雿摨????孵???- ?勗?
******************************************************************************
 01      W-LNK-KMPCF.
*>      ?風?Ⅳ
        03      W-KMPCF-PAT-NO          PIC 9(08).
*>      ?霅(W->WRITE, D->DELETE)
        03      W-KMPCF-FUN-ID          PIC X(01).
*>      銝???銋銵活??
        03      W-KMPCF-CNT             PIC 9(03).
*>      ?臬??-->Y
        03      W-KMPCF-OK              PIC X(01).
*>      ?瑁?雿平
        03      W-KMPCF-JOB             PIC X(08).
*>      ?航炊閮
        03      W-KMPCF-NOTE            PIC X(60).
*>      雿輻??
        03      W-KMPCF-USER            PIC X(05).
*>      2012/9/17 雿摨?
        03      W-KMPCF-IPD-NO.
                05 W-KMPCF-IPD-DATE     PIC 9(07).
                05 W-KMPCF-IPD-SEQ      PIC 9(04).
*>      2012/9/17 ?摨?
        03      W-KMPCF-ODR-NO.
                05 W-KMPCF-INS-DATE     PIC 9(07).
                05 W-KMPCF-ODR-SEQ      PIC 9(04).
*>      ??
*>      2012/9/17 ?啣?雿摨????孵???X(95)-->X(73).
        03      W-KMPCF-DATA            PIC X(73).
******************************************************************************
*       END     OF      FILE
******************************************************************************
*>---98.02.02---
*>      ---M嚗蜓蝔??嚗蝔??嚗蝔?(??NET?澆)
 01      W-SOU                   PIC X(01).
 01      W-HTCGUICF-EXT-PT-NO    PIC 9(08) IS EXTERNAL.
*>---(AICE) 98.05.15 ?餃??風?亙蝝??---
*COPY    "HZ_RCD.LNK".
***********************
*-> ?餃??風?啣?蝝?INK
***********************


 01      L-HZRCDCF-LNK.
*>      霅 (M-蝬剛風 I-?亥岷 R-?啗”  )
        02 L-RCD-ID             PIC X(01).
*>      雿平鈭箏 ?∪極蝺刻?
        02 L-RCD-USER           PIC X(05).
*>      蝟餌絞
        02 L-RCD-SYS            PIC X(04).

*>      蝔??迂
        02 L-RCD-PROG           PIC X(15).
*>      ?風??
        02 L-RCD-PAT-NO         PIC 9(08).
*>      ?頨怠?霅?
        02 L-RCD-PAT-ID         PIC X(10).
*>      ?怠葦隞?Ⅳ
        02 L-RCD-DC-ID          PIC X(05).
*>      閮??孵? (1-xml 2-?? 3-web form)
        02 L-RCD-REC-WAY        PIC X(01).
*>      ?斗?臬?脰?憯葬
        02 L-RCD-ARCH-YN        PIC X(01).
*>      ?斗?臬??
        02 L-RCD-OPEN-YN        PIC X(01).
*>      ???誑銝??梯”閬???
        02 L-RCD-TWOUP-YN       PIC X(01).
*>      ?梯”頝臬?
        02 L-RCD-RPT-PTH        PIC X(40).
*>      ?梯”瑼?
        02 L-RCD-RPT-NAME       PIC X(20).
*>      ?酉
        02 L-RCD-MEMO           PIC X(100).
*>      PVS?
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

*>      ?詨蝢斤?
        02 L-RCD-RUN-SBGP                       PIC X(10).
*>      蝟餌絞?膩

        02 L-RCD-RUN-DES-B                      PIC X(40).
*>      ?啣?蝝????撌脫???
        02 L-RCD-OTH                            PIC X(05).
*>      I???1.蝛箇:??瘜????亙),2.憭批神'Y':PDF+蝪賜?,3.P:PDF雿?蝪賜? 4.憭批神N:銝?
        02 L-RCD-LOGSG-SW-I                     PIC X(01).
*>      M???1.蝛箇:??瘜????亙),2.憭批神'Y':PDF+蝪賜?,3.P:PDF雿?蝪賜? 4.憭批神N:銝?
        02 L-RCD-LOGSG-SW-M                     PIC X(01).
*>      R???1.蝛箇:??瘜????亙),2.憭批神'Y':PDF+蝪賜?,3.P:PDF雿?蝪賜? 4.憭批神N:銝?
        02 L-RCD-LOGSG-SW-R                     PIC X(01).
*>      ?斗???亥岷璇辣銝????詨銵冽?隞嗡蒂?銴?梯”??撘??
        02 L-RCD-IMG-RUNNING-YN                 PIC X(01).
*>      ??
        02 L-RCD-FILLER                         PIC X(241).
        02 L-RCD-DATA1  REDEFINES L-RCD-FILLER.
*2010/8/18 MARS 憓??HZRCD?EY??
                03      L-RCD-KEY               PIC X(37).
*2010/8/19 MARS 憓??梯”頧DF????
                03      L-RCD-TXT-TO-PDF        PIC X(60).
*>              2010/9/2 MARS 憓??餃??風摰??蝢斤?
                03      L-RCD-GROUP             PIC X(2).
*>              2010/9/2 MARS 憓??餃??風?怠?(N)?迤撘?R)????
                03      L-RCD-CHK-ID            PIC X(1).
*>              2010/9/2 MARS 憓?銵典蝺刻?
                03      L-RCD-SN                PIC X(5).
*??
                03      L-RCD-FILLER1           PIC X(136).

*COPY    "HZ_PAM.LNK".
**************************
*?餃??風?啣?蝝???訾蜓瑼?
**************************

 01      L-PAM-LNK.
*>      霅 (M-蝬剛風 I-?亥岷 R-?啗”)
        02 L-PAM-ID             PIC X(01).
*>      ?亙蝝???嗆?血???
*>      2010/3/30 ?寧 FOR ?亥岷-蝝???嗆?血???
        02 L-PAM-LOG-YN         PIC X(01).
*>      ?餃?蝪賜?璈?臬??
*>      2010/3/30 ?寧 FOR ?亥岷-?餃?蝪賜?璈?臬??
        02 L-PAM-PKI-YN         PIC X(01).
*>      ??憯葬璈?臬??
        02 L-PAM-ARCH-YN        PIC X(01).
*>      蝝?????予??
        02 L-PAM-LOGDAY         PIC 9(04).
*>      蝟餌絞
        02 L-PAM-SYS            PIC X(04).
*>      蝔??迂(EX.HPXXXIF)
        02 L-PAM-PROG           PIC X(15).
*>      ?啗”-蝝???嗆?血???
        02 L-PAM-LOG-R-YN       PIC X(01).
*>      ?啗”-?餃?蝪賜?璈?臬??
        02 L-PAM-PKI-R-YN       PIC X(01).
*>      蝬剛風-?啣?蝝??血???
        02 L-PAM-LOG-M-YN       PIC X(01).
*>      蝬剛風-蝝???嗆?血??KI
        02 L-PAM-PKI-M-YN       PIC X(01).

*>      I???1.蝛箇:??瘜????亙), 2.憭批神'Y':PDF+蝪賜?, 3.P:PDF雿?蝪賜?, 4.憭批神N:銝?
        02 L-PAM-LOGSG-SW-I     PIC X(01).
*>      R???1.蝛箇:??瘜????亙), 2.憭批神'Y':PDF+蝪賜?, 3.P:PDF雿?蝪賜?, 4.憭批神N:銝?
        02 L-PAM-LOGSG-SW-R     PIC X(01).
*>      PIN-CDOE
        02 L-PAM-PIN-CODE       PIC X(10).

*>      蝪賡?璅∪?(1?湔,2??,3?芷?頨怠?)
        02 L-PAM-SIGN-MODE      PIC X(01).
*>      頨怠?撽??臬??(Y敺銝?,N隢?雿平暺??撘?
        02 L-PAM-GO-YN          PIC X(01).
*>      XML?祉?頝臬?
        02 L-PAM-XML-PTH        PIC X(50).
*>      雿平暺?西?閰Ｗ?摰???
        02 L-PAM-ASK-YN         PIC X(01).
*>      ??1
        02 L-PAM-FILLER-1       PIC X(31).


*COPY    "HZ_PAM.WRK".
*2010/6/3 MARS ?餃??風?亙?梁EXTERNAL
 01 W-TMP-HZPAM  IS EXTERNAL.
*>      霅 (M-蝬剛風 I-?亥岷 R-?啗”)
        03 W-PAM-ID             PIC X(01).
*>      蝝???嗆?血???
        03 W-PAM-LOG-YN         PIC X(01).
*>      ?餃?蝪賜?璈?臬??
        03 W-PAM-PKI-YN         PIC X(01).
*>      ??憯葬璈?臬??
        03 W-PAM-ARCH-YN        PIC X(01).
*>      蝝?????予??
        03 W-PAM-LOGDAY         PIC 9(04).
*>      蝟餌絞
        03 W-PAM-SYS            PIC X(04).
*>      蝔??迂(EX.HPXXXIF)
        03 W-PAM-PROG           PIC X(15).
*>      ?啗”-蝝???嗆?血???
        03 W-HZPAM-LOG-R-YN     PIC X(01).
*>      ?啗”-?餃?蝪賜?璈?臬??
        03 W-HZPAM-PKI-R-YN     PIC X(01).
*>      蝬剛風-?啣?蝝??血???
        03 W-HZPAM-LOG-M-YN     PIC X(01).
*>      蝬剛風-蝝???嗆?血??KI
        03 W-HZPAM-PKI-M-YN     PIC X(01).
*>      I???1.蝛箇:??瘜????亙), 2.憭批神'Y':PDF+蝪賜?, 3.P:PDF雿?蝪賜?, 4.憭批神N:銝?
        03 W-HZPAM-LOGSG-SW-I   PIC X(01).
*>      R???1.蝛箇:??瘜????亙), 2.憭批神'Y':PDF+蝪賜?, 3.P:PDF雿?蝪賜?, 4.憭批神N:銝?
        03 W-HZPAM-LOGSG-SW-R   PIC X(01).
*>      PIN-CDOE
        03 W-HZPAM-PIN-CODE     PIC X(10).
*>      蝪賡?璅∪?(1?湔,2??,3?芷?頨怠?)
        03 W-HZPAM-SIGN-MODE    PIC X(01).
*>      頨怠?撽??臬??(Y敺銝?,N隢?雿平暺??撘?
        03 W-HZPAM-GO-YN        PIC X(01).
*>      XML?祉?頝臬?
        03 W-HZPAM-XML-PTH      PIC X(50).
*>      ??1

        03 W-HZPAM-FILLER-1     PIC X(32).
*>-----------------------------------------
 01 W-TMP-PACK-YN                PIC X(01).

*>103.06.27 (?訾撰) 靽格撖阡???仿?甈?霈??皞??寡?RTA?TB??
 77      A4GL-WHERE-CONSTRAINT           PIC X(300) IS EXTERNAL.
*> 閮???亦蜇????HI_RTB)
 01      W-RTB-QTY.
        02      W-RTB-QTY1              PIC 9(07).
        02      W-RTB-QTY2              PIC 9(04).
*> ????霈
 01      W-TMP-QTY.
        02      W-TMP-QTY1              PIC 9(08).
        02      W-TMP-QTY2              PIC 9(04).
*> 蝝???霈
 01      W-GCD-VAR.
        02      W-IN-SON                PIC 9(10).
        02      W-IN-MOTHER             PIC 9(10).
        02      W-OUT-SON               PIC 9(10).
        02      W-OUT-MOTHER            PIC 9(10).
        02      W-GG                    PIC 9(05).
        02      W-RR                    PIC 9(05).
*>103.06.27 END
*>2019/12/24 閮?ICA撖急??航炊蝑COUNT
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
* ZP_RUNSL.LNK ...  --- TAMIS 蝟餌絞?銵?...
*
 01      W-RUNL-CHK.
        02      FILLER          PIC X(6000).
*
 01 W-LNK2           PIC  X(01).
*{Bench}end

 SCREEN SECTION.
*{Bench}copy-screen
*COPY "HRRCB1IF.scr".
*HRRCB1IF.scr
*HRRCB1IF.scr is generated from C:\HMIS1.DIR\VN\HR\nicol\if\HRG.DIR\HRRCB1IF.Psf
*This is a generated file. DO NOT modify this file directly.

01 S-RCB1,

   EXCEPTION PROCEDURE S-RCB1-Exception-Proc.
   03 S-RCB1-Fr-1, Frame,
*      COL 1.00, LINE 1.00, LINES 9.00 CELLS, SIZE 80.00 CELLS,
*      ENGRAVED, COLOR IS 3, FONT IS 蝝唳?擃?2, FULL-HEIGHT,
*      ID IS 2, HEAVY, TITLE W-FORM-TITLE, TITLE-POSITION 2,
*      BACKGROUND-LOW.
   03 S-RCB1-La-1, Label,
*      COL 2.20, LINE 3.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 3, LABEL-OFFSET 0,
*      TITLE "?????".
   03 S-RCB1-La-1a, Label,
*      COL 2.20, LINE 5.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 4, LABEL-OFFSET 0,
*      TITLE "霅???蝡?".
   03 S-RCB1-La-1b, Label,
*      COL 2.20, LINE 7.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 5, LABEL-OFFSET 0,
*      TITLE "雿蝘嚗?.
   03 S-RCB1-La-1c, Label,
*      COL 34.40, LINE 5.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 6, LABEL-OFFSET 0,
*      TITLE "摨?   ??".
   03 S-RCB1-La-1d, Label,
*      COL 34.40, LINE 3.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 7, LABEL-OFFSET 0,
*      TITLE "??甇???".
   03 S-RCB1-La-1e, Label,
*      COL 34.40, LINE 7.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 8, LABEL-OFFSET 0,
*      TITLE "銝餅祥?怠葦嚗?.
   03 S-RCB1-La-1f, Label,
*      COL 56.50, LINE 5.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 9, LABEL-OFFSET 0,
*      TITLE "雿?交?嚗?.
   03 S-RCB1-La-1g, Label,
*      COL 56.50, LINE 7.60, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 10, LABEL-OFFSET 0,
*      TITLE "雿?怠葦嚗?.
   03 S-PAT-NAME, Label,
*      COL 11.40, LINE 3.60, LINES 2.00 CELLS, SIZE 9.60 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 11, LABEL-OFFSET 0,
*      TITLE W-PAT-NAME.
   03 S-SEX, Label,
*      COL 23.30, LINE 3.60, LINES 2.00 CELLS, SIZE 2.00 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 12, LABEL-OFFSET 0,
*      TITLE W-SEX.
   03 S-RCB1-La-1h, Label,
*      COL 22.20, LINE 3.60, LINES 2.00 CELLS, SIZE 1.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 13, LABEL-OFFSET 0,
*      TITLE "(".
   03 S-RCB1-La-1ha, Label,
*      COL 25.50, LINE 3.60, LINES 2.00 CELLS, SIZE 1.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 14, LABEL-OFFSET 0,
*      TITLE ")".
   03 S-AGE, Label,
*      COL 27.10, LINE 3.60, LINES 2.00 CELLS, SIZE 2.40 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, PIC Z(3), ID IS 15,

*      LABEL-OFFSET 0, FROM W-AGE.
   03 S-AGE-UNIT, Label,
*      COL 30.70, LINE 3.60, LINES 2.00 CELLS, SIZE 2.40 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 16, LABEL-OFFSET 0,
*      TITLE W-AGE-UNIT.
   03 S-IPD-UNIT-NAME, Label,
*      COL 11.40, LINE 5.60, LINES 2.00 CELLS, SIZE 20.40 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 17, LABEL-OFFSET 0,
*      TITLE W-IPD-UNIT-NAME.
   03 S-DPT-NAME, Label,
*      COL 11.40, LINE 7.60, LINES 2.00 CELLS, SIZE 20.40 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 18, LABEL-OFFSET 0,
*      TITLE W-DPT-NAME.
   03 S-PAT-NO, Label,
*      COL 43.40, LINE 3.60, LINES 2.00 CELLS, SIZE 7.20 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, PIC Z(8), ID IS 19,
*      LABEL-OFFSET 0, FROM W-PAT-NO.
   03 S-BED, Label,
*      COL 43.40, LINE 5.60, LINES 2.00 CELLS, SIZE 6.00 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 20, LABEL-OFFSET 0,
*      TITLE W-BED.
   03 S-IPD-MJ-DR, Label,
*      COL 43.40, LINE 7.60, LINES 2.00 CELLS, SIZE 9.60 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 21, LABEL-OFFSET 0,
*      TITLE W-IPD-MJ-DR.
   03 S-IPD-MARK, Label,
*      COL 56.50, LINE 3.60, LINES 2.00 CELLS, SIZE 21.90 CELLS,
*      COLOR IS 13, FONT IS 蝝唳?擃?2, ID IS 30, LABEL-OFFSET 0,
*      TITLE W-IPD-MARK.
   03 S-IPD-SEQ, Label,
*      COL 74.50, LINE 5.60, LINES 2.00 CELLS, SIZE 3.60 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 25, LABEL-OFFSET 0,
*      TITLE W-IPD-SEQ1.
   03 S-RCB1-La-1haa, Label,
*      COL 72.40, LINE 5.60, LINES 2.00 CELLS, SIZE 1.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 24, LABEL-OFFSET 0,
*      TITLE "/".
   03 S-IPD-DT, Label,
*      COL 65.50, LINE 5.60, LINES 2.00 CELLS, SIZE 6.00 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, PIC Z(7), ID IS 23,
*      LABEL-OFFSET 0, FROM W-IPD-DT.
   03 S-IPD-RD-DR, Label,
*      COL 65.50, LINE 7.60, LINES 2.00 CELLS, SIZE 9.60 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 22, LABEL-OFFSET 0,
*      TITLE W-IPD-RD-DR.
   03 S-RCB1-Fr-2, Frame,
*      COL 1.00, LINE 10.00, LINES 39.00 CELLS,
*      SIZE 80.00 CELLS,
*      ENGRAVED, FONT IS 蝝唳?擃?2, FULL-HEIGHT, ID IS 27, HEAVY,
*      BACKGROUND-LOW.
   03 S-RCB1-Gd-1, Grid,
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
*      FONT IS 蝝唳?擃?1, HEADING-COLOR 144,
*      HEADING-DIVIDER-COLOR 1, HEADING-FONT IS 蝝唳?擃?2,
*      HSCROLL, ID IS 26, NUM-ROWS 16, PAGED,
*      RECORD-DATA W-GD-REC, TILED-HEADINGS, VPADDING 20,
*      VIRTUAL-WIDTH 123, VSCROLL,
*      EVENT PROCEDURE S-RCB1-Gd-1-Event-Proc.
*01 S-HT-DATA,
   EXCEPTION PROCEDURE S-HT-DATA-Exception-Proc.
   03 S-HT-DATA-FR, Frame,
*      COL 1.00, LINE 1.00, LINES 15.00 CELLS, SIZE 56.00 CELLS,
*      ENGRAVED, COLOR IS 3, FONT IS 蝝唳?擃?2, ID IS 1,
*      TITLE W-HT-DATA-TITLE, TITLE-POSITION 2, BACKGROUND-LOW.
   03 S-HT-DATA-La-1, Label,
*      COL 2.00, LINE 3.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 2, LABEL-OFFSET 0,
*      TITLE "蝪賣鈭箏嚗?.
   03 S-HT-DATA-La-1a, Label,
*      COL 2.00, LINE 5.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 3, LABEL-OFFSET 0,
*      TITLE "蝪賣?交?嚗?.
   03 S-HT-DATA-La-1aa, Label,
*      COL 2.00, LINE 7.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 4, LABEL-OFFSET 0,
*      TITLE "蝪賣??嚗?.
   03 S-HT-DATA-La-1ab, Label,
*      COL 2.00, LINE 9.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 5, LABEL-OFFSET 0,
*      TITLE "??迂嚗?.
   03 S-HT-DATA-La-1ac, Label,
*      COL 2.00, LINE 11.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 6, LABEL-OFFSET 0,
*      TITLE "瑼ａ??迂嚗?.
   03 S-HT-DATA-La-1ad, Label,
*      COL 2.00, LINE 13.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 7, LABEL-OFFSET 0,
*      TITLE "摰孵?迂嚗?.
   03 S-HT-DATA-La-1ae, Label,
*      COL 25.80, LINE 3.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 8, LABEL-OFFSET 0,
*      TITLE "?勗?鈭箏嚗?.
   03 S-HT-DATA-La-1aea, Label,
*      COL 25.80, LINE 5.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 9, LABEL-OFFSET 0,
*      TITLE "?勗??交?嚗?.
   03 S-HT-DATA-La-1aeb, Label,
*      COL 25.80, LINE 7.20, LINES 2.00 CELLS, SIZE 8.00 CELLS,
*      FONT IS 蝝唳?擃?2, ID IS 10, LABEL-OFFSET 0,
*      TITLE "?勗???嚗?.
   03 S-DIS-AC-NAME, Label,
*      COL 11.20, LINE 3.20, LINES 2.00 CELLS, SIZE 13.20 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 11, LABEL-OFFSET 0,

*      TITLE W-AC-NAME.
   03 S-DIS-AC-DATE, Label,
*      COL 11.20, LINE 5.20, LINES 2.00 CELLS, SIZE 13.20 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, PIC Z(7), ID IS 12,
*      LABEL-OFFSET 0, FROM W-AC-DATE.
   03 S-DIS-AC-TIME, Label,
*      COL 11.20, LINE 7.20, LINES 2.00 CELLS, SIZE 13.20 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 13, LABEL-OFFSET 0,
*      TITLE W-AC-TIME.
   03 S-DIS-ITM-NM, Label,
*      COL 11.20, LINE 9.20, LINES 2.00 CELLS, SIZE 30.00 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 14, LABEL-OFFSET 0,
*      TITLE W-ITM-NM.
   03 S-DIS-SPL-NM, Label,
*      COL 11.20, LINE 11.20, LINES 2.00 CELLS,
*      SIZE 16.80 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 15, LABEL-OFFSET 0,
*      TITLE W-SPL-NM.
   03 S-DIS-BTL-NM, Label,
*      COL 11.20, LINE 13.20, LINES 2.00 CELLS,
*      SIZE 16.80 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 16, LABEL-OFFSET 0,
*      TITLE W-BTL-NM.
   03 S-DIS-RP-F-NAME, Label,
*      COL 35.10, LINE 3.20, LINES 2.00 CELLS, SIZE 9.60 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 17, LABEL-OFFSET 0,
*      TITLE W-RP-F-NAME.
   03 S-DIS-RP-DATE, Label,
*      COL 35.10, LINE 5.20, LINES 2.00 CELLS, SIZE 13.20 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, PIC Z(7), ID IS 18,
*      LABEL-OFFSET 0, FROM W-RP-DATE.
   03 S-DIS-RP-TIME, Label,
*      COL 35.10, LINE 7.20, LINES 2.00 CELLS, SIZE 13.20 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 19, LABEL-OFFSET 0,
*      TITLE W-RP-TIME.
   03 S-DIS-RP-L-NAME, Label,
*      COL 46.30, LINE 3.20, LINES 2.00 CELLS, SIZE 9.60 CELLS,
*      COLOR IS 2, FONT IS 蝝唳?擃?2, ID IS 20, LABEL-OFFSET 0,
*      TITLE W-RP-L-NAME.
   03 S-HT-DATA-Pb-1, Push-Button,
*      COL 48.20, LINE 12.70, LINES 2.50 CELLS, SIZE 8.00 CELLS,
      EXCEPTION-VALUE W-EXIT2, FONT IS 蝝唳?擃?2, ID IS 21,
*      TITLE "?ａ?".
*{Bench}end
*{TAMIS}copy-screen
*------>??瑼?
*COPY    "HR_WAT.SCR".
***********************************************************************
*> HR_WAT.SCR
***********************************************************************
*01      S-LOAD-FORM.
       03      S-FR-LOAD-BAR, Frame,
*               COL 3.50, LINE 3.65, LINES 1.00 CELLS, SIZE 35.00 CELLS,
*               LOWERED, ALTERNATE, COLOR IS 521, FILL-COLOR 2, FILL-PERCENT 90,
*               FILL-COLOR2 16, FONT IS Fixed-Font, FULL-HEIGHT, ID IS 1,
*               LOW-COLOR 16, VERY-HEAVY, TITLE-POSITION 7, BACKGROUND-LOW.
       03      S-LOAD-FOR-La-1, Label,

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
    INITIALIZE WFONT-DATA 蝝唳?擃?2
    MOVE 12 TO WFONT-SIZE
    MOVE "蝝唳?擃? TO WFONT-NAME
    SET WFCHARSET-DONT-CARE TO TRUE
    SET WFONT-BOLD TO FALSE
    SET WFONT-ITALIC TO FALSE
    SET WFONT-UNDERLINE TO FALSE

    SET WFONT-STRIKEOUT TO FALSE
    SET WFFAMILY-DONT-CARE TO TRUE
    SET WFONT-FIXED-PITCH TO FALSE
    CALL "W$FONT" USING WFONT-GET-FONT, 蝝唳?擃?2, WFONT-DATA
    INITIALIZE WFONT-DATA 蝝唳?擃?1
    MOVE 11 TO WFONT-SIZE
    MOVE "蝝唳?擃? TO WFONT-NAME
    SET WFCHARSET-DONT-CARE TO TRUE
    SET WFONT-BOLD TO FALSE
    SET WFONT-ITALIC TO FALSE
    SET WFONT-UNDERLINE TO FALSE
    SET WFONT-STRIKEOUT TO FALSE
    SET WFFAMILY-DONT-CARE TO TRUE
    SET WFONT-FIXED-PITCH TO FALSE
    CALL "W$FONT" USING WFONT-GET-FONT, 蝝唳?擃?1, WFONT-DATA
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
          CELL WIDTH 10, COLOR IS 65793, CONTROL FONT 蝝唳?擃?2,
          LABEL-OFFSET 0, LINK TO THREAD, NO SCROLL,
          TITLE "瑼ａ??曉?蝺????, TITLE-BAR, NO WRAP,
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

    MODIFY S-RCB1-Gd-1, X = 1, Y = 1, CELL-DATA = "摨?,
    MODIFY S-RCB1-Gd-1, X = 2, Y = 1, CELL-DATA = "?蔭?迂",
    MODIFY S-RCB1-Gd-1, X = 6, Y = 1, CELL-DATA = "?賊?",
    MODIFY S-RCB1-Gd-1, X = 7, Y = 1, CELL-DATA = "?????",
    MODIFY S-RCB1-Gd-1, X = 10, Y = 1, CELL-DATA =
       "?瑁?????",
 Columns' Setting
    MODIFY S-RCB1-Gd-1, X = 1, COLUMN-FONT = 蝝唳?擃?1
    MODIFY S-RCB1-Gd-1, X = 2, COLUMN-FONT = 蝝唳?擃?1
    MODIFY S-RCB1-Gd-1, X = 3, COLUMN-FONT = 蝝唳?擃?1
    MODIFY S-RCB1-Gd-1, X = 4, COLUMN-FONT = 蝝唳?擃?1
    MODIFY S-RCB1-Gd-1, X = 5, COLUMN-FONT = 蝝唳?擃?1
    MODIFY S-RCB1-Gd-1, X = 6, COLUMN-FONT = 蝝唳?擃?1
    MODIFY S-RCB1-Gd-1, X = 7, COLUMN-FONT = 蝝唳?擃?1
    MODIFY S-RCB1-Gd-1, X = 8, COLUMN-FONT = 蝝唳?擃?1
    MODIFY S-RCB1-Gd-1, X = 9, COLUMN-FONT = 蝝唳?擃?1
    MODIFY S-RCB1-Gd-1, X = 10, COLUMN-FONT = 蝝唳?擃?1
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
       "&1. 雿平", 1000, Sub-Handle-1
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&1. 雿???刻?敦?亥岷", W-RCB1
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&2. 雿??瑼ａ??曉?蝺閰?, W-RCB2
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&3. 雿??瘝餌??蔭?亥岷", W-RCB3
    CALL "W$MENU" USING Wmenu-New GIVING Sub-Handle-1
    IF Sub-Handle-1 = ZERO
       MOVE ZERO TO Menu-Handle
       GO TO Acu-S-RCB1-Mn-1-EXIT
    END-IF
    CALL "W$MENU" USING WMENU-ADD, Menu-Handle, 0, 0,
       "&2. ?亥岷", 1004, Sub-Handle-1
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&1. ?亥岷甇瑟活雿閮?", W-SEARCH
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&2. ?亥岷撌脣?方??, W-DEL
    CALL "W$MENU" USING Wmenu-New GIVING Sub-Handle-1
    IF Sub-Handle-1 = ZERO
       MOVE ZERO TO Menu-Handle
       GO TO Acu-S-RCB1-Mn-1-EXIT
    END-IF
    CALL "W$MENU" USING WMENU-ADD, Menu-Handle, 0, 0,
       "&3. 瑼ａ?", 1007, Sub-Handle-1
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&1. ?亥岷瑼ａ??勗?", W-REPORT
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&2. ?亥岷蝪賣?賊?鞈?", W-DATA
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&3. ?芷", W-DELETE
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&4. ?瑼ａ???鈭斤?摰?", W-PRINT
    CALL "W$MENU" USING Wmenu-New GIVING Sub-Handle-1
    IF Sub-Handle-1 = ZERO
       MOVE ZERO TO Menu-Handle
       GO TO Acu-S-RCB1-Mn-1-EXIT
    END-IF

    CALL "W$MENU" USING WMENU-ADD, Menu-Handle, 0, 0,
       "&4. ?ａ?", 1012, Sub-Handle-1
    CALL "W$MENU" USING WMENU-ADD, Sub-Handle-1, 0, 0,
       "&1. ?ａ?", W-EXIT
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
*> 98.02.02憓?霈?文?臭蜓蝔???臭蜓撘?
*> 98.03.19 (AICE) ?寂CB??
*> 98.05.15 (AICE) ?餃??風?亙蝝??
*> 99.05.20 (AICE) ?餃??風?亙蝝???摮偷蝡?DM1001-J1001461)
*> 99.07.19 (AICE) MEMORY ACCESS ?ITH CONVERT DM1001-J1002025
*> 99.11.17 (AICE) 撠隤芾?撠CB-ODR-SEQ(2:3)?寧ICB-FEE-SEQ(DM1001-J1003068)
*>100.02.21 (AICE) ???雿＊蝷粹隤歹??澆??INITIALIZE (DM1101-J1100473)
*>101.08.31 (AICE) DM1201-J1201492 MAV
*>102.03.15 (FISH) MAV-憒?ICA-ODR-TIME?箸摮??????嚗M1301-J1300326
*>103.06.27 (?訾撰) 靽格撖阡???仿?甈?霈??皞??寡?RTA?TB??
*>104.03.19 (?訾撰) ?PD???航鋡怎???寧???怠??ED?喲風??銵典?雿平??
*>106.06.07 (敶弧) 獢-瑼ａ??曉?蝺閰Ｖ?璆剖?斗炎撽????????DM1701-J1700049)
*>106.07.06 (敶弧) 蝳桐葉???芷??閬??唾??寞
*>106.11.09 (AICE) 憓?憿舐內撌脣?支?瑼ａ??(DM1701-J1700569)(璆?105121502)
*>2023/01/30 獢? - ?瑼ａ?瑼Ｘ??敺炎撽??停瘨仃鈭瘜?敺敦??蝔?- ?
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
*>START (AICE) 98.05.15 ?餃??風?亙蝝??
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
* ZD_DTI.PRC ... ??ZD_YMD.PRC ...  ?????...
*
        MOVE W-RUN-YYSW  TO W-YMD-YYSW.
        MOVE W-RUN-YYDEF TO W-YMD-YYDEF.
        MOVE W-RUN-YYCOM TO W-YMD-YYCOM.
*
* ?交? ...
        ACCEPT W-YMD-DATE FROM CENTURY-DATE.
        MOVE W-YMD-YY TO W-YMD-YYB.
        MOVE W-YMD-YY TO W-YMD-YY1.
        MOVE W-YMD-MM TO W-YMD-MM1.
        MOVE W-YMD-DD TO W-YMD-DD1.
*
* YYSW   : 雿輻撟湔?閮剖?     -- 4:雿輻?Ⅳ镼踹?撟?2:鈭Ⅳ镼踹?撟? 0:銵其蝙?函?啣?撟?
* YYDEF  : 撟游漲????    -- 镼踹?撟湔?蝞蝙?典?撟游???靘?1911, 0 閬?1911)
* YYCOM  : 撟游漲閮??孵?     -- 镼踹?撟渲?蝞蝙?典?撟湔撘?靘?+,-, 蝛箇閬? - )
* YDFSW  : 霈??..
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
* YYS : - 銵刻???撟游漲?箄???
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
* ?? ...
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
*>      ?亦銝餌?撘??舫????
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
*>      0941206 ??摨?摮絲靘?
        MOVE IPD-BED    TO W-TMP-IBGCF-IPD-BED.
*>
        PERFORM F-BLANK.
*>      瑼ａ?瑼Ｘ??
*>START (敶弧)106.06.07 W-HTICB2BF-LNK -> L-HTICB2BF-LNK
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
*>                      ---(AICE) 98.05.15 ?餃??風?亙蝝??--
*>                      ?ａ???????
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
*>              ?交風甈?
                WHEN W-SEARCH
                        PERFORM F-SEARCH-IPLIF-RTN
*>              ?亙??
                WHEN W-DEL
                        PERFORM F-DEL-RTN
*>              ?
                WHEN W-PRINT
                        MODIFY S-RCB1-GD-1, Y = W-GRID-Y
                        INQUIRE S-RCB1-GD-1, RECORD-DATA = W-GD-REC
                        IF W-GD-REC NOT = SPACE THEN
                                PERFORM F-F5-PRINT-RTN
                        END-IF
*>              ?芷
                WHEN W-DELETE
                        IF W-RUN-SID = "G" OR "H" THEN
                                INITIALIZE W-NOTE
                                MOVE "甇瑕??芸雿輻?亥岷?嚗?"       TO W-NOTE
                                PERFORM F-ERR-NOTE
                        ELSE
                                MODIFY S-RCB1-GD-1, Y = W-GRID-Y
                                INQUIRE S-RCB1-GD-1, RECORD-DATA = W-GD-REC
                                IF W-GD-REC NOT = SPACE THEN
                                        PERFORM F-DELETE-RTN

                                END-IF
                        END-IF
*>              ???
                WHEN W-REPORT
                        MODIFY S-RCB1-GD-1, Y = W-GRID-Y
                        INQUIRE S-RCB1-GD-1, RECORD-DATA = W-GD-REC
                        PERFORM F-REPORT-RTN
*>              ?賊??勗?
                WHEN W-DATA
                        MODIFY S-RCB1-GD-1, Y = W-GRID-Y
                        INQUIRE S-RCB1-GD-1, RECORD-DATA = W-GD-REC
                        IF W-INQ-RX-WAY NOT = SPACE THEN
                                PERFORM Acu-S-HT-DATA-Routine
                        END-IF
*>              雿平(?刻,瑼ａ?,瘝餌?)
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
*>      銵典?迂
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
*> ?ａ???
***********************************************************************
 F-STOP-RTN.
*>      0941206 憓??Ｙ?瑼ａ??芷????Ｙ?QUE銵刻???
        IF W-HRDTA-COUNT > 0 THEN

                PERFORM F-HRIBGCF-MOVE-QQ
        END-IF.
*>START (敶弧)106.06.07 W-HTICB2BF-LNK -> L-HTICB2BF-LNK
*>      瑼ａ?瑼Ｘ??
        INITIALIZE L-HTICB2BF-LNK.
        MOVE "2"        TO L-HTICB2BF-STATUS.
*>      ---(AICE) 98.04.17 瑼ａ?瑼Ｘ???憭望????箄???---
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
*>      0931207 憓?DESTROY FONT
        DESTROY 蝝唳?擃?2, 蝝唳?擃?1, Fixed-Font.
        DESTROY S-RCB1-Mn-1-Handle.
        GOBACK.
***********************************************************************
*> 雿?思誘銵典?批瑼?(?風??閬??啁?銵典瑼?嚗?瘨??寧?(瑼ａ??芷)
 F-HRIBGCF-MOVE-QQ.
        INITIALIZE W-IBGCF-LNK.
        MOVE W-DATE                     TO W-IBGCF-DATE.
        MOVE "A"                        TO W-IBGCF-GET-UNIT.
        MOVE W-TMP-IBGCF-IPD-BED        TO W-IBGCF-IPD-BED.
        MOVE "q"                        TO W-IBGCF-PAPER-ID.
        MOVE HRDTA-IPD-NO               TO W-IBGCF-PRINT-DATA(1:11).
        MOVE HRDTA-ODR-NO               TO W-IBGCF-PRINT-DATA(12:13).

*>START (?訾撰) 104.03.19 ?PD???航鋡怎???寧???怠??ED?喲風??銵典?雿平
*>      ---(AICE) 98.06.24 憓??喳?雿? ---
*>      MOVE IPD-BED                    TO W-IBGCF-IPD-BED.
*>      104.03.19 END

        CALL "HRIBGCF" USING W-IBGCF-LNK ON EXCEPTION CONTINUE.
***********************************************************************
 F-RCB1-Gd-1-Ev-Msg-Begin-Entry.
        SET EVENT-ACTION TO EVENT-ACTION-FAIL.
        PERFORM F-RCB1-GD-1-EV-MSG-GOTO-CELL.
*>      暺?銝???
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
                        MOVE "雿???刻?敦?亥岷"     TO W-TOP-TITLE(1:50)
                WHEN "B"
                        MOVE "雿??瑼ａ??曉?蝺閰?   TO W-TOP-TITLE(1:50)
                WHEN "C"
                        MOVE "雿??瘝餌??蔭?亥岷"     TO W-TOP-TITLE(1:50)
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
        MOVE '雿???刻?敦?亥岷' TO W-PTDECF-PROG-NM.
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
                        DISPLAY MESSAGE "?風?? " PAT-NO "?風瑼?閫??憭望?!!"
        END-EVALUATE.
        IF PAT-MST-STATUS NOT = "00"
                DISPLAY MESSAGE "?⊥迨?風?Ⅳ嚗?瑼Ｘ嚗?
        ELSE
                INITIALIZE IPX-MST-REC
                MOVE "A"        TO IPX-LIVE-ID
                MOVE PAT-NO     TO IPX-PAT-NO
                START IPX-MST KEY IS >= IPX-ALT-KEY3
                READ IPX-MST NEXT RECORD
                IF IPX-MST-STATUS NOT = "00" OR IPX-LIVE-ID NOT = "A" OR
                   IPX-PAT-NO NOT = PAT-NO THEN
                        DISPLAY MESSAGE "?亦蝚血?銋??Ｗ辣隡貉???隢炎?伐?"
                ELSE
                        INITIALIZE IPD-MST-REC
                        MOVE IPX-NO     TO IPD-NO
                        READ IPD-MST KEY IS IPD-MST-KEY
*
                        IF IPD-MST-STATUS NOT = "00" OR
                           IPD-PAT-NO NOT = W-HTCGUICF-EXT-PT-NO THEN
                                DISPLAY MESSAGE "?亦蝚血?銋??Ｗ辣隡貉???隢炎?伐?"
                        ELSE
                                IF (IPD-OUT-DT NOT = 0 AND IPD-OUT-DT < W-DATE) THEN
                                        DISPLAY MESSAGE "隢釣??甇斤???歇颲衣??粹嚗?"
                                END-IF
                        END-IF
                END-IF
        END-IF.
 F-IPDNO-END.
        EXIT.

*>---(AICE) 98.04.17 瑼ａ????憭望? ---
 F-HTICB2BF-NOTE-RTN.
        INITIALIZE W-HRMESCF-DATA W-HRMESCF-DATA2.
        MOVE "瑼ａ??曉?蝺????憭望?嚗?"       TO W-HRMESCF-NOTE(1).
        MOVE "隢釣???祆活瑼ａ??銝衣????單炎撽頂蝯梧?" TO W-HRMESCF-NOTE(3).
        MOVE "????憒??芷瑼ａ??嚗?隢??窗鞈?摰支犖?? TO W-HRMESCF-NOTE(5).
*>      MOVE "?????亙歇?豢?摮???隢??芷撌脩???隞亙???閮嚗?       TO W-HRMESCF-NOTE(7).
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
*> 閬?鈭?
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
        MODIFY S-RCB1-GD-1, X = 3, Y = 1, CELL-DATA = "甈∪???.

        MODIFY S-RCB1-GD-1, X = 4, Y = 1, CELL-DATA = "??".
        MODIFY S-RCB1-GD-1, X = 5, Y = 1, CELL-DATA = "憭?.
        MODIFY S-RCB1-GD-1, X = 8, Y = 1, CELL-DATA = "憿".
        MODIFY S-RCB1-GD-1, X = 9, Y = 1, CELL-DATA = "?".
*>      ---(AICE) 98.10.22 憓?撖阡???仿?---
        MODIFY S-RCB1-GD-1, X = 11, Y = 1, CELL-DATA = "撖阡???仿?".
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
        MODIFY S-RCB1-GD-1, X = 4, Y = 1, CELL-DATA = "?瘜?.
        MODIFY S-RCB1-GD-1, X = 8, Y = 1, CELL-DATA = "?啣虜".
        MODIFY S-RCB1-GD-1, X = 9, Y = 1, CELL-DATA = "??.
*>START (AICE) 106.11.09 憓?憿舐內撌脣?支?瑼ａ??
        IF W-RUN-CFNO-S = "1205" THEN
                MODIFY S-RCB1-GD-1, X = 12, Y = 1, CELL-DATA = "??????"
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
        MODIFY S-RCB1-GD-1, X = 5, Y = 1, CELL-DATA = "憭?.
        MODIFY S-RCB1-GD-1, X = 8, Y = 1, CELL-DATA = "憿".
        MODIFY S-RCB1-GD-1, X = 9, Y = 1, CELL-DATA = "?".
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
*>START                 (AICE) 106.11.09 憓?憿舐內撌脣?支?瑼ａ??
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
*>START                         (AICE) 106.11.09 憓?憿舐內撌脣?支?瑼ａ??
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
                MOVE "??迨甈∩??Ｘ??蒂?∪?斗撘菔??對?"       TO W-NOTE
                PERFORM F-ERR-NOTE
                INITIALIZE W-TYPE1
        ELSE
                MOVE "??迨甈∩??Ｘ??蒂?⊿?蝡??"   TO W-NOTE
                PERFORM F-ERR-NOTE
        END-IF.

 F-MESG2-RTN.
        INITIALIZE W-NOTE.
        MOVE "??迨甈∩??Ｘ??蒂?⊿?蝡炎撽撠?嚗? TO W-NOTE.
        PERFORM F-ERR-NOTE.
 F-MESG3-RTN.
        INITIALIZE W-NOTE.
        IF W-TYPE1 = "D" THEN
                MOVE "??迨甈∩??Ｘ??蒂?∪?斗撘菔??對?" TO W-NOTE
                PERFORM F-ERR-NOTE
                INITIALIZE W-TYPE1
        ELSE
                MOVE "??迨甈∩??Ｘ??蒂?∠Ⅱ隤祥??蝵殷?" TO W-NOTE
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
*>      ---(AICE) 98.05.15 ?餃??風?亙蝝??--
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
*>      ????蝘餃蝚砌?蝑???
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
*>2022/08/22 憓?WITH CONVERT
                        MOVE ICB-RX-UQTY(1:2)   TO W-QTY1 WITH CONVERT
                        MOVE ICB-RX-UQTY(3:2)   TO W-QTY2 WITH CONVERT
                        PERFORM F-QTY-RTN
                        MOVE W-DIS-QTY          TO W-INQ-RX-UQTY
                ELSE
                        MOVE SPACE              TO W-INQ-RX-UQTY
                END-IF
        END-IF.
        IF ICB-RX-QTY1 > 0 AND ICB-RX-QTY2 > 0 THEN
*>2022/08/22 憓?WITH CONVERT
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
                                        MOVE "?瑟?"     TO W-INQ-TYPE
                                WHEN "O"
                                        MOVE " 頧?"     TO W-INQ-TYPE
                                WHEN "B"
                                        MOVE "擐"     TO W-INQ-TYPE
                                WHEN "J"
                                        MOVE "?喲?     TO W-INQ-TYPE
                                WHEN OTHER
                                        EVALUATE TRUE
                                                WHEN ICA-EMG-CD = "1"
                                                        MOVE "?粹"     TO W-INQ-TYPE
                                                WHEN ICA-DR-YN = "X"
                                                        MOVE "?冽?"     TO W-INQ-TYPE
                                                WHEN ICA-EMG-CD = "Y"
*>                                                      ---(AICE) 98.11.17 憓??芸??仿＊蝷?--
                                                        IF ECB-SELF-DRUG = "K" THEN
                                                                MOVE "?芸?"     TO W-INQ-TYPE
                                                        ELSE
                                                                MOVE "蝺?     TO W-INQ-TYPE
                                                        END-IF
                                                WHEN ICA-DR-YN = "T"
                                                        MOVE "瑼ａ?"     TO W-INQ-TYPE
                                                WHEN ICA-DR-YN = "C"
                                                        MOVE "瘝餌?"     TO W-INQ-TYPE
                                                WHEN ICA-DR-YN = " "

                                                        MOVE "?孵"     TO W-INQ-TYPE
                                                WHEN OTHER
                                                        INITIALIZE W-INQ-TYPE
                                        END-EVALUATE
                        END-EVALUATE
                WHEN OTHER
                        INITIALIZE W-INQ-TYPE
        END-EVALUATE.
*>      ??
        MOVE ICB-RX-WAY1        TO W-INQ-RX-WAY(1:5).
        MOVE ICB-RX-WAY2        TO W-INQ-RX-WAY(6:5).
        MOVE ICB-RX-DAYS        TO W-INQ-RX-DAYS.
        MOVE ICA-INS-DATE       TO W-INQ-INS-DATE(1:7) .
        MOVE "-"                TO W-INQ-INS-DATE(8:1).
*>START (FISH) 102.03.15 MAV-憒?ICA-ODR-TIME?箸摮??????嚗M1301-J1300326嚗?
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
                MOVE "隞?Ⅳ撌脖?摮"     TO W-INQ-PRS-NAME
        END-IF.

*>      103.06.27 (?訾撰)靽格撖阡???仿?甈?霈??皞??寡?RTA?TB??
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
*>              霈RTA鞈?嚗撌脖??芷閮餉?嚗?霈銝?蝑?
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
*>              閮?撌脤蝮賡?
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
*>*>            ---(AICE) 98.10.22 憓?憿舐內??仿?---
*>              MOVE ICB-RTN-QTY1       TO W-QTY1
*>              MOVE ICB-RTN-QTY2       TO W-QTY2
*>              PERFORM F-QTY-RTN
*>              MOVE W-DIS-QTY          TO W-INQ-RTB-RX-QTY
*>      ELSE
*>              MOVE SPACE      TO W-INQ-MARK
*>              INITIALIZE W-INQ-RTB-RX-QTY
*>      END-IF.
*----->?亦雿??瑼ａ??曉?蝺閰?
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
*>      0940828 憓?憿舐內?瑁????
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
*>      ?閮箄?雿???寞????
        IF ICA-UD-MARK = "O" THEN
*>              0930219靽格 ??頧?鞈?蝑銝?敺銝??

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
                IF W-HR-ODRW-WK-NAME(1:4) = "?啣虜" OR "?梢" THEN
                               MOVE "??       TO W-INQ-TYPE
                END-IF
*>96.7.30??芸??啣虜甈??餅蝛箇
*               EVALUATE HTCHK-WK-SW
*                       WHEN " "
*                               MOVE "?∠???   TO W-INQ-RX-WAY
*                       WHEN "A" THRU "D"
*                               MOVE "?芸銵?   TO W-INQ-RX-WAY
*                       WHEN "E" THRU "I"
*                               MOVE "?瑁?銝?   TO W-INQ-RX-WAY
*                       WHEN OTHER
*                               MOVE "撌脣???   TO W-INQ-RX-WAY
*                                IF HTCHK-RP-ST = "N" THEN
*                                        MOVE "??       TO W-INQ-TYPE
*                                END-IF
*                END-EVALUATE
*>              ?祉宏瑼ａ???賊?鞈?
                PERFORM F-MOVE-CHK-DATA
        ELSE
                IF ICB-CHK-NO = SPACE OR "   00000" THEN
                        INITIALIZE W-INQ-RX-UQTY
                ELSE
                        MOVE "銝???   TO W-INQ-RX-UQTY
                END-IF
        END-IF.
*>      --- (AICE) HTCHK-CLS-CD蝑??航?ALL "HTODRWCF"銋???蝘颱? ---

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
*>      蝪賣??
        MOVE HTCHK-AC-MAN       TO W-DIS-AC-MAN(W-II).
        MOVE HTCHK-AC-DATE      TO W-DIS-AC-DATE(W-II).
        MOVE HTCHK-AC-TIME      TO W-DIS-AC-TIME(W-II).
*>      ?勗???
        MOVE HTCHK-RP-F-MAN     TO W-DIS-RP-F-MAN(W-II).
        MOVE HTCHK-RP-L-MAN     TO W-DIS-RP-L-MAN(W-II).
        MOVE HTCHK-RP-DATE      TO W-DIS-RP-DATE(W-II).
        MOVE HTCHK-RP-TIME      TO W-DIS-RP-TIME(W-II).
*>      憓?憿舐內瑼ａ???迂?炎擃捆?函?鞈?
        INITIALIZE HTCTM-REC.
        MOVE HTCHK-CHK-NO    TO HTCTM-CHK-NO.
        MOVE HTCHK-IP-DATE   TO HTCTM-IP-DATE.
        MOVE ICB-ITM-CD      TO HTCTM-ITM-CD.
        READ HTCTM-MST KEY IS HTCTM-KEY.

        IF HTCTM-MST-STATUS = "00" AND HTCTM-CHK-NO = HTCHK-CHK-NO AND
           HTCTM-IP-DATE = HTCHK-IP-DATE AND HTCTM-ITM-CD = ICB-ITM-CD THEN
*               ITM ??迂
                INITIALIZE HTITM-REC
                MOVE HTCTM-CLS-NO TO HTITM-CLS-NO
                MOVE HTCTM-ITM-CD TO HTITM-ITM-CD
                READ HTITM-MST KEY IS HTITM-KEY
                IF HTITM-MST-STATUS = "00" AND HTITM-CLS-NO = HTCTM-CLS-NO AND
                   HTITM-ITM-CD = HTCTM-ITM-CD THEN
                        MOVE HTITM-ITM-NM TO W-DIS-ITM-NM(W-II)
                END-IF
*               SPL 瑼ａ?
                INITIALIZE HTSPL-REC
                MOVE HTCTM-DPT-CD TO HTSPL-DPT-CD
                MOVE HTCTM-SPL-CD TO HTSPL-SPL-CD
                READ HTSPL-MST KEY IS HTSPL-KEY
                IF HTSPL-MST-STATUS = "00" AND HTSPL-DPT-CD = HTCTM-DPT-CD AND
                   HTSPL-SPL-CD = HTCTM-SPL-CD THEN
                        MOVE HTSPL-SPL-NM TO W-DIS-SPL-NM(W-II)

                END-IF
*               BTL 摰孵
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
*------->憿舐內?雿鞈?
*************************************************************************************
 F-MOVE-INQ-TITLE.
        MOVE PAT-NAME           TO W-PAT-NAME.
        IF PAT-SEX = "1" THEN
                MOVE "??       TO W-SEX
        ELSE
                IF PAT-SEX = "2" THEN
                        MOVE "憟?       TO W-SEX
                ELSE
                        INITIALIZE W-SEX
                END-IF
        END-IF.
*       COPY "ZD_DTI.PRC".
*
* ZD_DTI.PRC ... ??ZD_YMD.PRC ...  ?????...
*
        MOVE W-RUN-YYSW  TO W-YMD-YYSW.
        MOVE W-RUN-YYDEF TO W-YMD-YYDEF.
        MOVE W-RUN-YYCOM TO W-YMD-YYCOM.
*
* ?交? ...
        ACCEPT W-YMD-DATE FROM CENTURY-DATE.
        MOVE W-YMD-YY TO W-YMD-YYB.
        MOVE W-YMD-YY TO W-YMD-YY1.
        MOVE W-YMD-MM TO W-YMD-MM1.
        MOVE W-YMD-DD TO W-YMD-DD1.
*
* YYSW   : 雿輻撟湔?閮剖?     -- 4:雿輻?Ⅳ镼踹?撟?2:鈭Ⅳ镼踹?撟? 0:銵其蝙?函?啣?撟?
* YYDEF  : 撟游漲????    -- 镼踹?撟湔?蝞蝙?典?撟游???靘?1911, 0 閬?1911)
* YYCOM  : 撟游漲閮??孵?     -- 镼踹?撟渲?蝞蝙?典?撟湔撘?靘?+,-, 蝛箇閬? - )
* YDFSW  : 霈??..
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
* YYS : - 銵刻???撟游漲?箄???
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
* ?? ...
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
                        MOVE "甇?       TO W-AGE-UNIT
                ELSE
                        IF L-AGE-UNIT = "M" THEN
                                MOVE "??       TO W-AGE-UNIT
                        ELSE
                                MOVE "憭?       TO W-AGE-UNIT
                        END-IF
                END-IF
        END-IF.
        MOVE PAT-NO             TO W-PAT-NO.
        IF IPD-OUT-DT NOT = 0 THEN
                STRING "?甈∟???" IPD-OUT-DT "?亙?? DELIMITED BY SIZE
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
*>      ?亙?蝣潮脣??怠葦???園撣思誨蝣??仿??怠葦?銝餅祥?怠葦
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
        CALL "W$MENU" USING WMENU-CHANGE,S-RCB1-Mn-1-Handle,W-DEL,0,"&2. ?亥岷撌脣?方??, W-DEL.
        CALL "W$MENU" USING WMENU-SHOW,S-RCB1-Mn-1-Handle.
        INITIALIZE W-TYPE1.
***********************************************************************
*> 閮?甈∪????賊?
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

*>103.06.27 (?訾撰)靽格撖阡???仿?甈?霈??皞??寡?RTA?TB??
 F-ADD-RTB-QTY.
        INITIALIZE W-GCD-VAR W-TMP-QTY.
        IF W-RTB-QTY1 = 0 OR W-RTB-QTY2 = 0 THEN
                MOVE RTB-RX-QTY1        TO W-RTB-QTY1
                MOVE RTB-RX-QTY2        TO W-RTB-QTY2
        ELSE
*>              ??
                COMPUTE W-TMP-QTY1 = RTB-RX-QTY1 * W-RTB-QTY2 +
                                     RTB-RX-QTY2 * W-RTB-QTY1
                COMPUTE W-TMP-QTY2 = RTB-RX-QTY2 * W-RTB-QTY2
*>              蝝?
                MOVE W-TMP-QTY1         TO W-OUT-SON
                MOVE W-TMP-QTY2         TO W-OUT-MOTHER
                PERFORM F-DIVI-RTN
                MOVE W-OUT-MOTHER       TO W-RTB-QTY2
                MOVE W-OUT-SON          TO W-RTB-QTY1
        END-IF.

*> ?賊??湔????...
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
*> ?乩???
***********************************************************************
 F-SCREEN-DOWN.
        IF W-PAGE = 100 THEN
                PERFORM F-END-MESG
        ELSE
                IF NOT W-FS-EOF THEN
*>START                 (AICE) 106.11.09 憓?憿舐內撌脣?支?瑼ａ??
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
*>START                 (AICE) 106.11.09 憓?憿舐內撌脣?支?瑼ａ??
                        IF W-RUN-CFNO-S = "1205" AND
                           W-TMP-PARA = "B" THEN
                                MOVE W-HRDTB-REC(W-MENU-ITEMS)  TO HRDTB-MST-REC
                                PERFORM F-START-HRDTB-RTN THRU F-START-HRDTB-EXIT
                        END-IF
*>END 106.11.09
                        IF W-FS = 00 THEN
                                ADD 1   TO W-PAGE
                                MOVE ECB-MST-REC        TO W-KEY1(W-PAGE)
*>START                         (AICE) 106.11.09 憓?憿舐內撌脣?支?瑼ａ??
*>                              PERFORM F-999-RTN
                                IF W-RUN-CFNO-S = "1205" AND
                                   W-TMP-PARA = "B" THEN
                                        MOVE HRDTB-MST-REC      TO W-KEY2(W-PAGE)
                                        PERFORM F-READ-TEST-RTN THRU F-READ-TEST-EXIT
                                ELSE
                                        PERFORM F-999-RTN
                                END-IF
*>END 106.11.09
*>                              ---(AICE) 98.05.15 ?餃??風?亙蝝??--
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
*> ?乩???
***********************************************************************
 F-SCREEN-UP.
        IF W-PAGE > 1 THEN
                SUBTRACT 1 FROM W-PAGE
                MOVE W-KEY1(W-PAGE)     TO ECB-MST-REC
                PERFORM F-STARTS-RTN
                PERFORM F-READN-RTN THRU F-READN-EXIT
*>START         (AICE) 106.11.09 憓?憿舐內撌脣?支?瑼ａ??
                IF W-RUN-CFNO-S = "1205" AND
                   W-TMP-PARA = "B" THEN
                        MOVE W-KEY2(W-PAGE)     TO HRDTB-MST-REC
                        PERFORM F-START-HRDTB-RTN THRU F-START-HRDTB-EXIT
                END-IF

*>END 106.11.09
                IF W-FS = 00 THEN
*>                      蝞甇?Ⅱ????蝧駁???
                        MODIFY S-RCB1-GD-1, X = 1, Y = 2
                        INQUIRE S-RCB1-GD-1, CELL-DATA IN W-NO
                        COMPUTE W-NO = W-NO - 15
*>START                 (AICE) 106.11.09 憓?憿舐內撌脣?支?瑼ａ??
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
                MOVE "?祇??箏?亥岷鞈?蝚砌???" TO W-NOTE
                PERFORM F-WAR-NOTE
        END-IF.
***********************************************************************
*> ?交風甈?
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
*> ?亙?閮
 F-SEARCH-1-RTN.
        IF W-FS = 10 THEN
                MOVE "N"        TO W-LNK-IPL-YN
                INITIALIZE W-NOTE
                IF W-TYPE1 = "D" THEN
                        MOVE "??迨甈∩??Ｘ??蒂?∪?斗撘菔??對?"       TO W-NOTE
                ELSE
                        MOVE "??迨甈∩??Ｘ??蒂?⊿?蝡??"           TO W-NOTE
                END-IF
                PERFORM F-ERR-NOTE
        ELSE
                PERFORM F-MOVE-INQ-TITLE
                PERFORM F-RCB-RTN

        END-IF.
*> 瑼ａ??曉?蝺???
 F-SEARCH-2-RTN.
        IF W-FS = 10 THEN
                MOVE "N"        TO W-LNK-IPL-YN
                INITIALIZE W-NOTE
                MOVE "??迨甈∩??Ｘ??蒂?⊿?蝡炎撽撠?嚗?     TO W-NOTE
                PERFORM F-ERR-NOTE
        ELSE
                PERFORM F-MOVE-INQ-TITLE
                MOVE 1           TO W-PAGE W-NO
                MOVE ECB-MST-REC TO W-PICB W-KEY1(W-PAGE)
                PERFORM F-999-RTN
        END-IF.
*> 瘝餌??蔭閮
 F-SEARCH-3-RTN.
        IF W-FS = 10 THEN
                MOVE "N"        TO W-LNK-IPL-YN
                INITIALIZE W-NOTE
                IF W-TYPE1 = "D" THEN
                        MOVE "??迨甈∩??Ｘ??蒂?∪?斗撘菔??對?"       TO W-NOTE
                ELSE
                        MOVE "??迨甈∩??Ｘ??蒂?∠Ⅱ隤祥??蝵殷?"       TO W-NOTE
                END-IF
                PERFORM F-ERR-NOTE
        ELSE
                PERFORM F-MOVE-INQ-TITLE
                PERFORM F-RCB-RTN
        END-IF.
***********************************************************************
*> ?亙??
***********************************************************************
 F-DEL-RTN.
        IF W-TYPE1 = "D" THEN
                INITIALIZE W-TYPE1
                CALL "W$MENU" USING WMENU-CHANGE,S-RCB1-Mn-1-Handle,W-DEL,0,"&2. ?亥岷撌脣?方??, W-DEL
        ELSE
                MOVE "D"        TO W-TYPE1
                CALL "W$MENU" USING WMENU-CHANGE,S-RCB1-Mn-1-Handle,W-DEL,0,"&2. ???芾?亥岷", W-DEL
        END-IF.
        CALL "W$MENU" USING WMENU-SHOW,S-RCB1-Mn-1-Handle.
        PERFORM F-RCB-RTN.
***********************************************************************
*> ??恍?閮
***********************************************************************
 F-END-MESG.
        INITIALIZE W-NOTE.
        MOVE "?祇??箄???亥岷??恍?嚗? TO W-NOTE.
        PERFORM F-WAR-NOTE.
***********************************************************************
*> 瑼ａ??曉?蝺??)
***********************************************************************
 F-F5-PRINT-RTN.
        IF W-DIS-DATA(W-GRID-Y)(65:6) = SPACE THEN
                INITIALIZE W-NOTE
                MOVE "甇日??炎撽???嚗瘜??唳炎撽嚗?     TO W-NOTE
                PERFORM F-ERR-NOTE

        ELSE
                PERFORM F-PRINT-RTN
        END-IF.
*> ?瑼ａ?瑼Ｘ??鈭斤?摰?
 F-PRINT-RTN.
        INITIALIZE W-REPRN-SW W-ODRPF-REPRN-SW-LNK.
        INITIALIZE HTCHK-REC.
*>      ?株?
        MOVE W-DIS-CHK-NO(W-GRID-Y)             TO HTCHK-CHK-NO.
        MOVE W-HTCHK-IP-DATE(W-GRID-Y)  TO HTCHK-IP-DATE.
        READ HTCHK-MST KEY IS HTCHK-KEY.
        IF HTCHK-MST-STATUS = "00" AND HTCHK-CHK-NO = W-DIS-CHK-NO(W-GRID-Y)
           AND HTCHK-IP-DATE = W-HTCHK-IP-DATE(W-GRID-Y) THEN
                INITIALIZE W-ODRPF-PASS-LNK W-ODRPF-PASS2-LNK
                MOVE HTCHK-CHK-NO       TO W-ODRPF-CHK-NO-LNK
                MOVE HTCHK-IP-DATE      TO W-ODRPF-IP-DATE-LNK
*>              0901108憓??瑼ａ?瑼Ｘ?格?瑼Ｘ?臬?啗”??HT_OLGP.WRK
                INITIALIZE W-ODR-LGP W-ODR-PRN
                MOVE "Y"        TO W-ODR-LGP
                CALL "HTODRPF" USING W-ODRPF-PASS-LNK W-ODRPF-PASS2-LNK
                        W-ODRPF-PASS3-LNK ON EXCEPTION CONTINUE
                END-CALL
                INITIALIZE W-ODR-LGP W-ODR-PRN
        END-IF.
***********************************************************************
*> 瑼ａ??曉?蝺????
***********************************************************************
 F-REPORT-RTN.
*       IF W-INQ-RX-WAY = "撌脣??? THEN
*>              910718 靽格????
*               MOVE "940"      TO W-EXT-HEIGHT
*                PERFORM F-CALL-HTPATRPF
*                INITIALIZE W-EXT-HEIGHT
*        ELSE
*               INITIALIZE W-NOTE
*               MOVE "甇日??蔭?∪?靘閰ｇ?" TO W-NOTE
*               PERFORM F-ERR-NOTE
*       END-IF.
        IF W-INQ-RX-WAY = SPACES THEN
                INITIALIZE W-NOTE
                MOVE "甇日??蔭?∪?靘閰ｇ?" TO W-NOTE
                PERFORM F-ERR-NOTE
        ELSE
*>              910718 靽格????
                MOVE "940"      TO W-EXT-HEIGHT
                PERFORM F-CALL-HTPATRPF
                INITIALIZE W-EXT-HEIGHT
        END-IF.

*> ?澆瑼ａ??亦?瑼ａ??勗?
 F-CALL-HTPATRPF.
*>      瑼ａ??勗??亥岷雿輻 (敹膝)
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
*>      瑼ａ??勗??亥岷雿輻 (敹膝)
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
*> 瑼ａ??曉?蝺??賊?鞈?)
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
*> 瑼ａ??曉?蝺??芷)

***********************************************************************
 F-DELETE-RTN.
*>      0910221 靽格銝?瑁??芷?W-NID-1198(255:1) = "Y"
        IF W-NID-1198(255:1) = "Y" THEN
                INITIALIZE W-NOTE
                MOVE "撠?韏瘀??函甈蝙?冽迨?嚗???桃雿銝剖??芷嚗?       TO W-NOTE
                PERFORM F-ERR-NOTE
        ELSE
                IF W-IPD-MARK = SPACE THEN
                        IF W-RUN-GNO1 = "11" AND W-RUN-PAR1(6:1) = "A" THEN
                                PERFORM F-HT-DELETE-RTN THRU F-HT-DELETE-EXIT
                                PERFORM F-CHK-ECB2-RTN
*>START                         (AICE) 106.11.09 憓?憿舐內撌脣?支?瑼ａ??
                                IF W-RUN-CFNO-S = "1205" THEN
                                        INITIALIZE HRDTB-MST-REC
                                        MOVE IPD-NO     TO HRDTB-IPD-NO
                                        PERFORM F-START-HRDTB-RTN THRU F-START-HRDTB-EXIT
                                END-IF
*>END 106.11.09
                                IF W-FS = 10 THEN
                                        INITIALIZE W-DIS-TABLE
                                        MOVE "N"        TO W-LNK-IPL-YN
*97.12.25(MONIYA)?粹????牧?敺???
*                                       INITIALIZE W-NOTE
*                                       MOVE "??迨甈∩??Ｘ??蒂?⊿?蝡炎撽撠?嚗?     TO W-NOTE
*                                       PERFORM F-ERR-NOTE
*97.09.02(MONIYA)皜祈岫靽格?粹??芷?湔?恍鞈?
                                        PERFORM F-FUN-RTN THRU F-FUN-EXIT
                                ELSE
*>START                                 (AICE) 106.11.09 憓?憿舐內撌脣?支?瑼ａ??
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
                                MOVE "撠?韏瘀??芷????怠葦雿輻嚗?   TO W-NOTE
                                PERFORM F-ERR-NOTE
                        END-IF
                END-IF
        END-IF.
*> ?芷瑼ａ?雿平
 F-HT-DELETE-RTN.

*>      901030??瑟撣喲?瑼?
        MOVE W-DIS-REC(W-GRID-Y)(12:7)  TO W-CHK-DTE-YMD WITH CONVERT.
        PERFORM F-CHK-LOCK-RTN THRU F-CHK-LOCK-EXIT.
        IF W-LOCKCF-YN = "Y" THEN
                INITIALIZE W-NOTE
                MOVE W-LOCKCF-NOTE TO W-NOTE

                PERFORM F-ERR-NOTE
                GO TO F-HT-DELETE-EXIT
        END-IF.
*>      ???銝隞亙??....
        IF W-DIS-OPD-APY(W-GRID-Y) = "Y" THEN
                STRING "甇日??蔭撌脰??梢?閮箇?梧??⊥??芷嚗?"
                        DELIMITED BY SIZE INTO W-NOTE
                END-STRING
                PERFORM F-ERR-NOTE
                GO TO F-HT-DELETE-EXIT
        END-IF.
*>      瑼ａ??株?
        IF W-DIS-CHK-NO(W-GRID-Y) NOT = SPACE AND
           W-DIS-CHK-NO(W-GRID-Y) NOT = "   00000" THEN
*>      0930826 敹膝隤???閬祟
*>         AND W-DIS-ITM-CD(W-GRID-Y) NOT = SPACE THEN
                INITIALIZE W-ODRW-TABLE
*>              雿摨?
                MOVE W-DIS-REC(W-GRID-Y)(1:11)          TO W-ODRW-PD-NO
*>              ?摨?
                MOVE W-DIS-REC(W-GRID-Y)(12:11)         TO W-ODRW-PD-SEQ
*>              ?蔭摨?
                MOVE W-DIS-REC(W-GRID-Y)(23:3)          TO W-ODRW-PRS-SEQ WITH CONVERT
*>              瑼ａ??株?
                MOVE W-DIS-CHK-NO(W-GRID-Y)             TO W-ODRW-CHK-NO
*>              ?隞?Ⅳ
                MOVE W-DIS-ITM-CD(W-GRID-Y)             TO W-ODRW-ITM-CD
*>
                CALL "HTODRWCF" USING W-ODRW-TABLE ON EXCEPTION CONTINUE
                END-CALL

*>              銵函內銝??
                IF W-ODRW-TRN-SW NOT = "Y"
                        INITIALIZE W-NOTE
*>                      雿平瘚??迂
                        STRING "甇日??蔭撌脰" W-ODRW-WK-NAME "?挾嚗瘜??
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
        MOVE "?臬蝣箏?閬???" TO W-HRMESCF-NOTE(1).
        CALL "HRMESCF" USING W-HRMESCF-DATA W-HRMESCF-DATA2 ON EXCEPTION CONTINUE

        END-CALL.
        IF W-HRMESCF-RETURN = "Y" THEN
*97.10.15(MONIYA)?啣?瑼Ｘ??瑁???西?芷?匱蝥?銝銵?
                INITIALIZE W-DELETE-YN
                PERFORM F-CHK-DEL-RTN THRU F-CHK-DEL-EXIT
                IF W-DELETE-YN = "Y" THEN
*>              蝣箏?閬?斗??亦?????閬?CALL "HTICB2BF"
                    IF (W-DIS-CHK-NO(W-GRID-Y) NOT = SPACE AND "   00000") THEN
*>              0930826 敹膝隤???閬祟
*>                 AND W-DIS-ITM-CD(W-GRID-Y) NOT = SPACE THEN
*>START                 (敶弧) 106.06.07 獢-瑼ａ??曉?蝺閰Ｖ?璆剖?斗炎撽????????? W-HTICB2BF-LNK2???單炎撽??
*>                              W-HTICB2BF-LNK -> L-HTICB2BF-LNK
                        INITIALIZE L-HTICB2BF-LNK  L-HTICB2BF-LNK2
                        MOVE "1"                        TO L-HTICB2BF-STATUS
                        MOVE W-DIS-REC(W-GRID-Y)(1:22)  TO L-HTICB2BF-IP-NO
                        MOVE W-RUN-USER                 TO L-HTICB2BF-CR-MAN
                        MOVE W-DATE                     TO L-HTICB2BF-CR-DATE
*>START                 (AICE) 99.07.19 DM1001-J1002025 MEMORY ACCESS ?ITH CONVERT
                        MOVE W-TIME                     TO L-HTICB2BF-CR-TIME WITH CONVERT

                        MOVE W-DIS-REC(W-GRID-Y)        TO ECB-MST-REC
                        MOVE ECB-APY-DR                 TO L-HTICB2BF-IP-MAN
*>START 106.07.06       (敶弧) 蝳桐葉???芷??閬??唾??寞
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
                                STRING "瑼ａ?瑼Ｘ?曉?蝺頂蝯梯??仃??隢??啣銵迨?嚗?
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

*97.10.15(MONIYA)?啣?瑼Ｘ??瑁???血?芷?匱蝥?銝銵?
 F-CHK-DEL-RTN.
        INITIALIZE IPD-MST-REC.
        MOVE W-DIS-REC(W-GRID-Y)(1:11)  TO IPD-NO.
        READ IPD-MST KEY IS IPD-MST-KEY.
        IF IPD-MST-STATUS = "00" THEN
*> IKEY-TMP ??雿平
                INITIALIZE IKEY-TMP-REC

                MOVE "A"        TO IKEY-TMP-ID
                MOVE IPD-PAT-NO TO IKEY-ENA-PAT-NO
                READ IKEY-TMP KEY IS IKEY-TMP-KEY
                IF IKEY-TMP-STATUS = "00" THEN
                        DISPLAY MESSAGE "??蝙?其葉嚗蝙?刻 " IKEY-USER " ]嚗?璆?[ " IKEY-JOB " ]"
                        MOVE "N"        TO W-DELETE-YN
                        GO TO F-CHK-DEL-EXIT
                END-IF
                EVALUATE        TRUE
                        WHEN    IPD-MST-STATUS NOT = "00"
                                STRING  "["IPD-MST-STATUS"]雿摨?瑼Ｘ憭望?嚗?瑼Ｘ嚗?
                                        DELIMITED  BY   SIZE    INTO    W-NOTE
                                END-STRING
                                DISPLAY MESSAGE W-NOTE
                                MOVE "N"        TO W-DELETE-YN
                                GO TO F-CHK-DEL-EXIT
*>              頨怠?隞?Ⅳ
                        WHEN    IPD-A-CLA = SPACE
                                MOVE    "頨怠?隞?Ⅳ蝛箇嚗?瑼Ｘ嚗?        TO      W-NOTE
                                DISPLAY MESSAGE W-NOTE
                                MOVE "N"        TO W-DELETE-YN
                                GO TO F-CHK-DEL-EXIT
                        WHEN    IPD-OC-END-YN   = "Y"
                                MOVE    "?犖撌脤?撣喉?"  TO      W-NOTE
                                DISPLAY MESSAGE W-NOTE
                                MOVE "N"        TO W-DELETE-YN
                                GO TO F-CHK-DEL-EXIT
                END-EVALUATE

*>      3.頨怠?閮霅
                INITIALIZE      NID-MST-REC
                MOVE    "0106"          TO      NID-ID
                MOVE    IPD-A-CLA       TO      NID-CODE
                READ    NID-MST   KEY   IS      NID-MST-KEY
                IF      NID-MST-STATUS = "00"
                        IF NID-MST-REC(93:1) NOT = "1" AND "2" AND "3" THEN
                                MOVE    "頨怠?隞?Ⅳ閮霅?航炊嚗?瑼Ｘ嚗?        TO      W-NOTE
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
*>      ?芷???賊?鞈?
        PERFORM F-DEL-SCH-RTN.
*>      ?湔IPD-AMV-YN = "Y"???蝜潛?
        INITIALIZE IPD-MST-REC.
        MOVE W-DIS-REC(W-GRID-Y)(1:11)  TO IPD-NO.
        READ IPD-MST KEY IS IPD-MST-KEY.
        IF IPD-MST-STATUS = "00" AND IPD-NO = W-DIS-REC(W-GRID-Y)(1:11) THEN
*               MOVE "Y"                TO IPD-AMV-YN
                REWRITE IPD-MST-REC

                IF IPD-MST-STATUS = "00" THEN
*>                      靽格ICA
                        INITIALIZE ICA-MST-REC
                        MOVE W-DIS-REC(W-GRID-Y)(1:11)          TO ICA-IPD-NO
                        MOVE W-DIS-REC(W-GRID-Y)(12:11)         TO ICA-ODR-NO
                        READ ICA-MST KEY IS ICA-KEY
                        IF ICA-MST-STATUS = "00" AND
                           ICA-IPD-NO = W-DIS-REC(W-GRID-Y)(1:11) AND
                           ICA-ODR-NO = W-DIS-REC(W-GRID-Y)(12:11) THEN
*> 97.7.23(????)
                                INITIALIZE W-ODRW-LNK W-ODRW-CNT
                                ADD   1                        TO W-ODRW-CNT
*>靽格?
                                MOVE "HR"                      TO W-ODRW-FROM
                                MOVE "M"                       TO W-ODRW-ID
                                MOVE ICA-ODR-NO                TO WM-ICA-ODR-NO
*>?芷?蔭
                                MOVE "D"                       TO WM-ICB-ID(W-ODRW-CNT)
                                MOVE W-RUN-USID(1:5)           TO W-ODRW-USER
                                MOVE W-DIS-REC(W-GRID-Y)(1:11) TO W-ODRW-IPD-NO
*                               MOVE "D" TO WM-ICB-ID(1)
*                               MOVE W-DIS-REC(W-GRID-Y)(23:3) TO WM-ICB-FEE-SEQ(1)
                                MOVE W-DIS-REC(W-GRID-Y)(23:3) TO WM-ICB-FEE-SEQ(W-ODRW-CNT)
*                               CALL "HIODRWCF" USING W-RUN-CHK W-ODRW-LNK ON EXCEPTION CONTINUE
*                               END-CALL
*>end

*>                              ???桀?ICA?CB銋??摮WRK銝?
*                               MOVE ICA-MST-REC        TO W-ICA-TMP-MST-REC
*>                              ??啣?鈭箔誨?? X(4) ==> X(5)
*                               MOVE W-RUN-USID         TO ICA-UPD-USR-ID
*>                              ??啣??交?
*                                MOVE W-DATE             TO ICA-UPD-DATE
*>                              ??啣???
*                                MOVE W-TIME             TO ICA-UPD-TIME
*                                REWRITE ICA-MST-REC
*>                              891121 INSERT : ?餃??風?啣?瑼神瑼?  <HI_ELC.PRC>
                                MOVE "M"        TO W-ELC-MARK
                                PERFORM F-WRITE-ELC-TRN-21
*                                IF ICA-MST-STATUS = "00" THEN
*>                                      ?啣???
*                                       MOVE "MD"       TO W-UPD-ID
*                                        PERFORM F-WRITE-GCA-OLD-RTN THRU F-WRITE-GCA-OLD-EXIT
*                                        PERFORM F-WRITE-GCB-MI-RTN
*>                                      0900620憓??交迨??粹?葆瘥?????文???敺?撠????
                                        INITIALIZE ECB-MST-REC
                                        MOVE W-DIS-REC(W-GRID-Y)(1:25)  TO ECB-KEY
                                        READ ECB-MST KEY IS ECB-KEY
                                        IF ECB-LNK-POINT-HEAD = "*" THEN
                                                MOVE ECB-LNK-POINT      TO W-TMP-LNK-POINT
                                                MOVE ECB-LNK-TIME       TO W-TMP-LNK-TIME
                                                PERFORM F-DEL-LNK-RTN
                                        END-IF
*>                                      2019/12/24 ??IS
*>                                      ?芷??撖信R_UDL3
                                        INITIALIZE ICB-MST-REC ECB-MST-REC
                                        MOVE W-DIS-REC(W-GRID-Y)(1:25)  TO ICB-KEY ECB-KEY

                                        READ ICB-MST KEY IS ICB-KEY
                                        READ ECB-MST KEY IS ECB-KEY
                                        PERFORM F-DEL-TO-WRITE-HRUDL3-RTN
*>                                      2019/12/24 END
*>                                      ?芷ICB?CB
                                        INITIALIZE ICB-MST-REC ECB-MST-REC
                                        MOVE W-DIS-REC(W-GRID-Y)(1:25)  TO ICB-KEY ECB-KEY
                                        READ ICB-MST KEY IS ICB-KEY
                                        READ ECB-MST KEY IS ECB-KEY
*>                                      ??ANN??雿平
                                        IF ECB-ANN-YN = "Y" THEN
                                                PERFORM F-DEL-ANN-MST
                                        END-IF
*>                                      930820 憓?摮悅?豢??蝵桀祟?豢??芷 PEF-MST-REC(462:1) = "D"
                                        IF W-1799-REC(69:1) = "Y" THEN
                                                PERFORM F-DELETE-FNS-RTN
                                        END-IF
*>                                      0941206 憓?撖怠瑼ａ??芷?瑼?
                                        PERFORM F-WRITE-HRDTB-RTN
*                                       DELETE ICB-MST
*                                        DELETE ECB-MST
*>                                      ?啣?敺?
                                        PERFORM F-ADD-MT-RTN THRU F-ADD-MT-EXIT
*                                        MOVE "MI"       TO W-UPD-ID
*                                        MOVE ICA-MST-REC        TO W-ICA-TMP-MST-REC
*                                        PERFORM F-WRITE-GCA-OLD-RTN THRU F-WRITE-GCA-OLD-EXIT
*                                        PERFORM F-WRITE-GCB-MI-RTN
*>                                      瑼Ｘ??臬撌脩?批捆?亦?ICA-DEL-MARK銝?方酉閮?
*                                       PERFORM F-REWRITE-ICA-RTN
*                               ELSE
*>                                      ?銝餅??啣?憭望?
*                                       INITIALIZE W-NOTE
*                                       STRING "?銝餅??啣?憭望?嚗?瘜?"
*                                             ICA-MST-STATUS " 隢??啣銵迨?......"
*                                               DELIMITED BY SIZE INTO W-NOTE
*                                       END-STRING
*                                       PERFORM F-ERR-NOTE
*                               END-IF
                                CALL "HIODRWCF" USING W-RUN-CHK W-ODRW-LNK ON EXCEPTION CONTINUE
                                END-CALL
*97.09.17(MONIYA)憿舐內?航炊閮
                                IF W-ODRW-OK = "N" THEN
                                        INITIALIZE W-NOTE
                                        MOVE W-ODRW-NOTE TO W-NOTE
                                        PERFORM F-ERR-NOTE
*>                                      2019/12/24 閮?ICA撖急??航炊蝣墩7]
                                        INITIALIZE  W-LOG2-CON
                                        MOVE "W"        TO W-UPD-MRK
                                        MOVE "A"        TO W-TMP-ID
                                        PERFORM F-WRT-LOG2-RTN THRU F-WRT-LOG2-EXIT
                                END-IF
                        ELSE
*>                              ?銝餅?霈?仃??
*                               INITIALIZE W-NOTE
*                               STRING "?銝餅?霈?仃???瘜?"
*                                       ICA-MST-STATUS " 隢閰Ｘ迨??臬摮...."
*                                       DELIMITED BY SIZE INTO W-NOTE

*                               END-STRING
*                               PERFORM F-ERR-NOTE
*>                              2019/12/24 閮?ICA撖急??航炊蝣墩7]
                                INITIALIZE  W-LOG2-CON
                                MOVE "R"        TO W-UPD-MRK
                                MOVE "A"        TO W-TMP-ID
                                PERFORM F-WRT-LOG2-RTN THRU F-WRT-LOG2-EXIT
*                       END-IF
*>                      0910501 靘??貉身摰??瘨??寧?
                ELSE
*>                      雿銝餅??湔憭望?
                        INITIALIZE W-NOTE
                        STRING "雿銝餅??湔憭望?嚗?瘜?" IPD-MST-STATUS
                                " 隢??啣銵迨?......"
                                DELIMITED BY SIZE INTO W-NOTE
                        END-STRING
                        PERFORM F-ERR-NOTE
                END-IF
        ELSE
*>              雿銝餅?霈?仃??
                INITIALIZE W-NOTE
                STRING "雿銝餅?霈?仃???瘜?" IPD-MST-STATUS
                        " 隢閰Ｘ迨雿鞈??臬摮...."
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
*>              ?曉閬?斤?摮????銝撌脩偷?嗡??臬??
                INITIALIZE ICB-MST-REC
                MOVE ECB-KEY    TO ICB-KEY
                READ ICB-MST KEY IS ICB-KEY
                IF (ICB-DG-FLAG(1:1) = "C" OR "D" OR "E") AND
                   ICB-CLS-NO NOT = SPACE THEN
                        INITIALIZE W-ODRW-TABLE
*>                      雿摨?
                        MOVE ICB-IPD-NO         TO W-ODRW-PD-NO
*>                      ?摨?
                        MOVE ICB-ODR-NO         TO W-ODRW-PD-SEQ
*>                      ?蔭摨?
                        MOVE ICB-FEE-SEQ        TO W-ODRW-PRS-SEQ
*>                      瑼ａ??株?
                        MOVE ICB-CHK-NO         TO W-ODRW-CHK-NO
*>                      ?隞?Ⅳ
                        MOVE ICB-ITM-CD         TO W-ODRW-ITM-CD
                        CALL "HTODRWCF" USING W-ODRW-TABLE ON EXCEPTION CONTINUE

                        END-CALL
*>                      銵函內?臬
                        IF W-ODRW-TRN-SW = "Y" THEN
                                ADD 1 TO W-ODRW-CNT
*>                              ?芷?蔭
                                MOVE "D"          TO WM-ICB-ID(W-ODRW-CNT)
*>                              ?蔭瘚偌??
                                MOVE ICB-FEE-SEQ  TO WM-ICB-FEE-SEQ(W-ODRW-CNT)
*                               DELETE ICB-MST
*                               DELETE ECB-MST
                        END-IF
                ELSE
                        ADD 1 TO W-ODRW-CNT
*>                      ?芷?蔭
                        MOVE "D"          TO WM-ICB-ID(W-ODRW-CNT)
*>                      ?蔭瘚偌??
                        MOVE ICB-FEE-SEQ  TO WM-ICB-FEE-SEQ(W-ODRW-CNT)
*                       DELETE ICB-MST
*                       DELETE ECB-MST
                END-IF
        END-IF.
        READ ECB-MST NEXT RECORD.
*> ?芷???賊?鞈?
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
*>                      ?脣??桀??????
                        PERFORM F-BEFORE-RTN
                        CALL "HXGSCHKF" USING W-LNK-TABLE LX-SCH-TABLE ON EXCEPTION CONTINUE
                        END-CALL
                        CANCEL "HXGSCHKF"
*>                      ???????
                        PERFORM F-AFTER-RTN
                END-IF
        END-IF.
*> ?脣?ICB銋??GCB
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
*> 瑼Ｘ??臬撌脩?批捆?亦?ICA-DEL-MARK銝?方酉閮?
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
*> 930820 憓?摮悅?豢??蝵桀祟?豢??芷 PEF-MST-REC(462:1) = "D"
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
                                STRING "摮悅?豢?????芷憭望?嚗?瘜?" FNS-MST-STATUS
                                        DELIMITED BY SIZE INTO W-NOTE
                                END-STRING
                                PERFORM F-ERR-NOTE
                        END-IF
                END-IF
        END-IF.
***********************************************************************
*> 憓?撖怠瑼ａ??芷?瑼?
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
* ZD_DTI.PRC ... ??ZD_YMD.PRC ...  ?????...
*
        MOVE W-RUN-YYSW  TO W-YMD-YYSW.
        MOVE W-RUN-YYDEF TO W-YMD-YYDEF.
        MOVE W-RUN-YYCOM TO W-YMD-YYCOM.
*
* ?交? ...
        ACCEPT W-YMD-DATE FROM CENTURY-DATE.
        MOVE W-YMD-YY TO W-YMD-YYB.
        MOVE W-YMD-YY TO W-YMD-YY1.
        MOVE W-YMD-MM TO W-YMD-MM1.
        MOVE W-YMD-DD TO W-YMD-DD1.
*
* YYSW   : 雿輻撟湔?閮剖?     -- 4:雿輻?Ⅳ镼踹?撟?2:鈭Ⅳ镼踹?撟? 0:銵其蝙?函?啣?撟?
* YYDEF  : 撟游漲????    -- 镼踹?撟湔?蝞蝙?典?撟游???靘?1911, 0 閬?1911)
* YYCOM  : 撟游漲閮??孵?     -- 镼踹?撟渲?蝞蝙?典?撟湔撘?靘?+,-, 蝛箇閬? - )
* YDFSW  : 霈??..
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
* YYS : - 銵刻???撟游漲?箄???
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
* ?? ...
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
*97.07.08(MONIYA)?風鈭?閫??
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
                        DISPLAY MESSAGE "?風?? " PAT-NO "?風瑼?閫??憭望?!!"
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
*> ?勗?瑼瑼?-- ?湔?芷?交?蝑?雿?
***********************************************************************
 F-DEL-ANN-MST.
        PERFORM F-READ-ANN-MST.
        IF HXANN-MST-STATUS NOT = "00"
                EXIT    PARAGRAPH
        END-IF.
*>      ?芷
        MOVE    "E"                     TO      HXANN-TRN-SW.
*>      ?芷?交?
        MOVE    ICA-UPD-DATE            TO      HXANN-DEL-DATE.
*>      ?芷??
        MOVE    ICA-UPD-TIME            TO      HXANN-DEL-TIME(01:04).
*>      ?芷鈭箏
        MOVE    ICA-UPD-USR-ID          TO      HXANN-DEL-MAN.
*>      ?芷霅蝣? A->?孵?芷
        MOVE    "A"                     TO      HXANN-DEL-SW.
        REWRITE         HXANN-REC.
*> 霈???
 F-READ-ANN-MST.
        INITIALIZE                      HXANN-REC.
*>      ?摨?
        MOVE    ICA-ODR-NO              TO      HXANN-OD-NO.
*>      雿摨?
        MOVE    ICA-IPD-NO              TO      HXANN-PD-NO.
*>      瑼?摨?
        MOVE    ECB-FILE-NO             TO      HXANN-IP-SEQ.
        READ    HXANN-MST       KEY IS  HXANN-KEY.
***********************************************************************
*> ??
***********************************************************************
 F-OPEN-RTN.
        PERFORM F-OPEN-MESG.
        PERFORM F-WIN-CLOCK.

        INITIALIZE W-LA-NAME.
        MOVE "NID-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT NID-MST.

        INITIALIZE W-LA-NAME.
        MOVE "PAT-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT PAT-MST.

        INITIALIZE W-LA-NAME.
        MOVE "IPD-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        OPEN    I-O IPD-MST.
        IF      IPD-MST-STATUS = "35" THEN
                OPEN    OUTPUT IPD-MST

                CLOSE   IPD-MST
                OPEN    I-O IPD-MST
        END-IF.
        INITIALIZE IPD-MST-REC.

        INITIALIZE W-LA-NAME.
        MOVE "IPX-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT IPX-MST.

        INITIALIZE W-LA-NAME.
        MOVE "ICA-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        PERFORM F-OICA-RTN THRU F-OICA-EXIT.

        INITIALIZE W-LA-NAME.
        MOVE "ICB-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        PERFORM F-OICB-RTN THRU F-OICB-EXIT.

        INITIALIZE W-LA-NAME.
        MOVE "HIGCA-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN    I-O HIGCA-MST.
        IF      HIGCA-MST-STATUS = "35" THEN
                OPEN    OUTPUT HIGCA-MST
                CLOSE   HIGCA-MST
                OPEN    I-O HIGCA-MST
        END-IF.

        INITIALIZE W-LA-NAME.
        MOVE "HIGCB-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN    I-O HIGCB-MST.
        IF      HIGCB-MST-STATUS = "35" THEN
                OPEN    OUTPUT HIGCB-MST
                CLOSE   HIGCB-MST
                OPEN    I-O HIGCB-MST
        END-IF.

        INITIALIZE W-LA-NAME.
        MOVE "FON-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT FON-MST.

        INITIALIZE W-LA-NAME.
        MOVE "BED-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT BED-MST.

        INITIALIZE W-LA-NAME.
        MOVE "DTE-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT DTE-MST.

        INITIALIZE W-LA-NAME.
        MOVE "PRS-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT PRS-MST.

        INITIALIZE W-LA-NAME.
        MOVE "PEF-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT PEF-MST.

        INITIALIZE W-LA-NAME.
        MOVE "ECB-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.

        OPEN    I-O ECB-MST.
        IF      ECB-MST-STATUS = "35" THEN
                OPEN    OUTPUT ECB-MST
                CLOSE   ECB-MST
                OPEN    I-O ECB-MST
        END-IF.
        INITIALIZE ECB-MST-REC.

        INITIALIZE W-LA-NAME.
        MOVE "ELC-TRN ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        OPEN    I-O ELC-TRN.
        IF      ELC-TRN-STATUS = "35" THEN
                OPEN    OUTPUT ELC-TRN
                CLOSE   ELC-TRN
                OPEN    I-O ELC-TRN
        END-IF.
        INITIALIZE ELC-TRN-REC.

        INITIALIZE W-LA-NAME.
        MOVE "IBG-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        OPEN    I-O IBG-MST.
        IF      IBG-MST-STATUS = "35" THEN
                OPEN    OUTPUT IBG-MST
                CLOSE   IBG-MST
                OPEN    I-O IBG-MST
        END-IF.
        INITIALIZE IBG-MST-REC.

        INITIALIZE W-LA-NAME.
        MOVE "RNU-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        OPEN    I-O RNU-MST.
        IF      RNU-MST-STATUS = "35" THEN
                OPEN    OUTPUT RNU-MST
                CLOSE   RNU-MST
                OPEN    I-O RNU-MST
        END-IF.
        INITIALIZE RNU-MST-REC.

        INITIALIZE W-LA-NAME.
        MOVE "FNS-MST ??瑼?銝?....隢?蝔???...."       TO W-LA-NAME.
        OPEN    I-O FNS-MST.
        IF      FNS-MST-STATUS = "35" THEN
                OPEN    OUTPUT FNS-MST
                CLOSE   FNS-MST
                OPEN    I-O FNS-MST
        END-IF.
        INITIALIZE FNS-MST-REC.

        INITIALIZE W-LA-NAME.
        MOVE "HRDTA-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        OPEN    I-O HRDTA-MST.
        IF      HRDTA-MST-STATUS = "35" THEN
                OPEN    OUTPUT HRDTA-MST
                CLOSE   HRDTA-MST
                OPEN    I-O HRDTA-MST
        END-IF.
        INITIALIZE HRDTA-MST-REC.


        INITIALIZE W-LA-NAME.
        MOVE "HRDTB-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        OPEN    I-O HRDTB-MST.
        IF      HRDTB-MST-STATUS = "35" THEN
                OPEN    OUTPUT HRDTB-MST
                CLOSE   HRDTB-MST
                OPEN    I-O HRDTB-MST
        END-IF.
        INITIALIZE HRDTB-MST-REC.

        INITIALIZE W-LA-NAME.
        MOVE "HTSYS-SON ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTSYS-SON.

        INITIALIZE W-LA-NAME.
        MOVE "HTDPT-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTDPT-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTCHK-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTCHK-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTRPT-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTRPT-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTCLS-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTCLS-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTCTM-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTCTM-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTCTR-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTCTR-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTITM-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTITM-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTREF-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTREF-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTSPL-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT HTSPL-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTBTL-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT HTBTL-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTWRK-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.

        PERFORM F-CLOCK.                OPEN INPUT HTWRK-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HTCSP-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HTCSP-MST.
*>      ???賊?瑼?
        INITIALIZE W-LA-NAME.
        MOVE "HXSRM-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT HXSRM-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HXSCT-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN INPUT HXSCT-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HXSCD-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HXSCD-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HXSCC-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HXSCC-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HXSCM-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HXSCM-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HXSCH-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HXSCH-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HXANN-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HXANN-MST.
*> 97.7.23 ????
        INITIALIZE W-LA-NAME.
        MOVE "ENB-MST ??瑼?銝?....隢?蝔???...." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O ENB-MST.

        INITIALIZE W-LA-NAME.
        MOVE "IKEY-TMP ??瑼?銝?....隢?蝔???...." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O IKEY-TMP.

        INITIALIZE W-LA-NAME.
        MOVE "ICC-MST ??瑼?銝?....隢?蝔???...." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O ICC-MST.

        INITIALIZE W-LA-NAME.
        MOVE "ENA-MST ??瑼?銝?....隢?蝔???...." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O ENA-MST.

        INITIALIZE W-LA-NAME.
        MOVE "ENC-MST ??瑼?銝?....隢?蝔???...." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O ENC-MST.

        INITIALIZE W-LA-NAME.
        MOVE "HIEND-MST ??瑼?銝?....隢?蝔???...." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HIEND-MST.


*>      103.06.27 (?訾撰)靽格撖阡???仿?甈?霈??皞??寡?RTA?TB??
        INITIALIZE W-LA-NAME.
        MOVE "RTA-MST ??瑼?銝?....隢?蝔???...." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O RTA-MST.

        INITIALIZE W-LA-NAME.
        MOVE "RTB-MST ??瑼?銝?....隢?蝔???...." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O RTB-MST.
*>      103.06.27 END
*>      2019/12/24 ??IS
*>      ?芷??撖信R_UDL3
        INITIALIZE W-LA-NAME.
        MOVE "HRUDL3-MST ??瑼?銝?....隢?蝔???...." TO W-LA-NAME.
        PERFORM F-CLOCK.                OPEN I-O HRUDL3-MST.

        PERFORM F-CLOCK.
*------->銝??怎?隞?Ⅳ銵典?蝘隞?Ⅳ銵?..
        PERFORM F-DEP-RTN.
        PERFORM F-DR-RTN.
*------->銝?雿?閮剖?
        PERFORM F-NID-1000.
        PERFORM F-NID-1099.
        MOVE W-NID-1099(111:1)  TO W-CHK-1029-YN.
        PERFORM F-NID-1198.
        PERFORM F-NID-1799.

        PERFORM F-CLOSE-WIN-CLOCK.
 F-OPEN-EXIT.
        EXIT.

*>瑼ａ???
 F-HT-OPEN.
        PERFORM F-OPEN-MESG.
        PERFORM F-WIN-CLOCK.

        INITIALIZE W-LA-NAME.
        MOVE "HMSID-MST ??瑼?銝?....隢?蝔???...."     TO W-LA-NAME.
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
*>??
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
*>      ?炎?賊?
        PERFORM F-BIRD.         CLOSE HXSRM-MST.
        PERFORM F-BIRD.         CLOSE HXSCT-MST.
        PERFORM F-BIRD.         CLOSE HXSCD-MST.
        PERFORM F-BIRD.         CLOSE HXSCC-MST.
        PERFORM F-BIRD.         CLOSE HXSCM-MST.
        PERFORM F-BIRD.         CLOSE HXSCH-MST.
        PERFORM F-BIRD.         CLOSE HXANN-MST.
*> 97.7.23 ????
        PERFORM F-BIRD.         CLOSE ENB-MST.
        PERFORM F-BIRD.         CLOSE IKEY-TMP.
        PERFORM F-BIRD.         CLOSE ICC-MST.
        PERFORM F-BIRD.         CLOSE ENA-MST.
        PERFORM F-BIRD.         CLOSE ENC-MST.
        PERFORM F-BIRD.         CLOSE HIEND-MST.
*>      103.06.27 (?訾撰) 靽格撖阡???仿?甈?霈??皞??寡?RTA?TB??
        PERFORM F-BIRD.         CLOSE RTA-MST.
        PERFORM F-BIRD.         CLOSE RTB-MST.
*>      103.06.27 END
*>      2019/12/24 ??IS
*>      ?芷??撖信R_UDL3
        PERFORM F-BIRD.         CLOSE HRUDL3-MST.
        PERFORM F-CLOSE-WIN-CLOCK.
 F-CLOSE-EXIT.
        EXIT.
*>
*>瑼ａ???
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
                        MOVE "雿???刻?亥岷"         TO W-FORM-TITLE
                WHEN "B"
                        MOVE "雿??瑼ａ??曉?蝺閰?   TO W-FORM-TITLE
                WHEN "C"
                        MOVE "雿??瘝餌??蔭?亥岷"     TO W-FORM-TITLE
        END-EVALUATE.
        DISPLAY S-RCB1-Fr-1.
***********************************************************************
* 雿蝟餌絞?閮剖?瑼?
***********************************************************************
 F-NID-1000.
        INITIALIZE NID-MST-REC.
        MOVE "1000"     TO NID-ID.
        MOVE "AV"        TO NID-CODE.
        READ NID-MST KEY IS NID-MST-KEY.
        IF NID-MST-STATUS NOT = "00" THEN
                INITIALIZE W-NOTE
                MOVE "雿?閮剖?瑼??芸遣瑼?隢?窗鞈?摰支犖?∴?"       TO W-NOTE
                PERFORM F-ERR-NOTE

        ELSE
                MOVE NID-MST-REC TO W-NID-1000
        END-IF.
*> 雿撱嗡撓?閮剖?
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
*> 摮悅?豢炎?亙???
 F-NID-1799.
        INITIALIZE NID-MST-REC W-1799-REC.
        MOVE "1799"     TO NID-ID.
        MOVE "0"        TO NID-CODE.
        READ NID-MST KEY IS NID-MST-KEY.
        IF NID-MST-STATUS = "00" THEN
                MOVE NID-MST-REC TO W-1799-REC
        END-IF.
***********************************************************************
*>START (AICE) 98.05.15 ?餃??風?亙蝝??
***********************************************************************
 F-CHK-LOG-RTN.
*>?斗??臬?閬?蝮?
        INITIALIZE      L-PAM-LNK.
*>      霅 (M-蝬剛風 I-?亥岷 R-?啗”)
        MOVE    "I"             TO L-PAM-ID.
*>      蝔??迂
        MOVE    "HRRCB1IF"      TO L-PAM-PROG.
*>      ?舐?撘鼠敹?意ID-9400鋆∠??,?嗅????
        CALL "HZPAMCF"  USING W-RUNL-CHK, L-PAM-LNK ON EXCEPTION CONTINUE
        END-CALL.
*>START (AICE) 99.05.20 DM1001-J1001461?餃??風?亙蝝???餃?蝪賜?
        IF L-PAM-GO-YN = "N" THEN
                IF W-SOU = "M" OR "O" THEN
                        PERFORM F-CLOSE-RTN THRU F-CLOSE-EXIT
                END-IF
                GOBACK
        END-IF.
*>END DM1001-J1001461

 F-CHK-LOG-EXIT.
        EXIT.

*>?瑕??恍鞈?
 F-CATCH-SEL-RTN.
*>      ?勗??詨?瑟?西?閮?
        IF      L-PAM-LOG-YN    = "Y"   THEN
                INITIALIZE L-HZRCDCF-LNK
*>              霅 (M-蝬剛風 I-?亥岷 R-?啗”)
                MOVE    "I"                     TO L-RCD-ID
*>              雿平鈭箏 ?∪極蝺刻?
                MOVE    W-RUN-USID              TO L-RCD-USER
*>              蝟餌絞??
                MOVE    L-PAM-SYS               TO L-RCD-SYS
*>              蝔??迂
                MOVE    L-PAM-PROG              TO L-RCD-PROG
*>              ?恍?頛詨銋?甇瑁?
                MOVE    W-PAT-NO                TO L-RCD-PAT-NO
*>              閮??孵? (1-xml 2-?? 3-web form)
                MOVE    "2"                     TO L-RCD-REC-WAY
*>              ?亥岷?酉
                MOVE    "?思誘??蝞∠?雿平-雿???刻?敦?亥岷" TO L-RCD-MEMO
*>              NID9400?斗?臬閬?蝮?
                MOVE    L-PAM-ARCH-YN           TO L-RCD-ARCH-YN
*>START         (AICE) 99.05.20
                MOVE    L-PAM-LOGSG-SW-I        TO L-RCD-LOGSG-SW-I
*>END DM1001-J1001461
*>              ?啣?蝝??瑼??舐?撘?
                CALL "HZRCDCF"  USING W-RUNL-CHK, L-HZRCDCF-LNK ON    EXCEPTION CONTINUE
                END-CALL
        END-IF.

*>憯葬??
 F-PACK-RTN.
        IF      L-PAM-LOG-YN    = "Y"   THEN
                INITIALIZE L-HZRCDCF-LNK
*>              霅
                MOVE "I"                        TO L-RCD-ID
*>              蝟餌絞??
                MOVE    L-PAM-SYS               TO L-RCD-SYS
*>              蝔??迂
                MOVE    L-PAM-PROG              TO L-RCD-PROG
*>              ?亥岷璇辣??甇瑁?(?恍頛詨璇辣)
                MOVE W-PAT-NO                   TO L-RCD-PAT-NO
*>              閮??孵?(1-xml 2-?? 3-web form)
                MOVE "2"                        TO L-RCD-REC-WAY
*>              雿輻?楊??
                MOVE W-RUN-USID                 TO L-RCD-USER
*>              ??舐?撘??ａ?雿平
                MOVE "C"                        TO L-RCD-OPEN-YN
*>              ?亥岷?酉
                MOVE    "?思誘??蝞∠?雿平-雿???刻?敦?亥岷" TO L-RCD-MEMO
*>              NID9400?斗?臬閬?蝮?
                MOVE    L-PAM-ARCH-YN           TO L-RCD-ARCH-YN
*>START         (AICE) 99.05.20
                MOVE    L-PAM-LOGSG-SW-I        TO L-RCD-LOGSG-SW-I
*>END DM1001-J1001461

*>              ?啣?蝝??瑼??舐?撘?
                CALL "HZRCDCF"  USING W-RUNL-CHK, L-HZRCDCF-LNK ON EXCEPTION CONTINUE
                END-CALL
        END-IF.
*>START (AICE) 100.02.21 (DM1101-J1100473)
 F-MOVE-WK-NAME-RTN.
        MOVE "?澆憭望?" TO W-HR-ODRW-WK-NAME.
 F-MOVE-WK-NAME-EXIT.
        EXIT.
***********************************************************************
* ?ａ??岷?Ⅱ摰?
***********************************************************************
 F-EXIT-RTN.
        INITIALIZE W-HRMESCF-DATA W-HRMESCF-DATA2.
        MOVE "2"        TO W-HRMESCF-PIC-TYPE.
        MOVE "4"        TO W-HRMESCF-BUT-TYPE.
        MOVE "Y"        TO W-HRMESCF-CONTROL-ID.
        MOVE "?臬蝣箏??ａ???" TO W-HRMESCF-NOTE(1).
        CALL "HRMESCF" USING W-HRMESCF-DATA W-HRMESCF-DATA2 ON EXCEPTION CONTINUE
        END-CALL.
        IF W-HRMESCF-RETURN = "Y" THEN
                MOVE 27 TO KEY-STATUS
        ELSE
                INITIALIZE KEY-STATUS
        END-IF.
*>START (AICE) 106.11.09 憓?憿舐內撌脣?支?瑼ａ??
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
*>      ????蝘餃蝚砌?蝑???
        MODIFY S-RCB1-GD-1,START-X = 1,X = 99,START-Y = 2 ,Y = 2,REGION-COLOR = W-GD-COLOR.
        MOVE 2  TO W-GRID-Y W-GRID-Y1.
 F-READ-HIECB-EXIT.
        EXIT.
 F-MOVE-GRID-RTN.
        INITIALIZE W-GD-REC.
*>      MOVE ECB-MST-REC        TO W-DIS-REC(W-II).
*>      摨?
        MOVE W-NO               TO W-INQ-SEQ.

*>      ?蔭?迂
        INITIALIZE PRS-MST-REC.
        MOVE HRDTB-FEE-KEY      TO PRS-MST-ID.
        READ PRS-MST KEY IS PRS-MST-KEY.
        IF PRS-MST-STATUS = "00" THEN
                MOVE PRS-ID-NAME        TO W-INQ-PRS-NAME
        ELSE
                MOVE "隞?Ⅳ撌脖?摮"     TO W-INQ-PRS-NAME
        END-IF.

*>      2023/01/30 獢? - ?瑼ａ?瑼Ｘ??敺炎撽??停瘨仃鈭瘜?敺敦??蝔?
        IF W-NID-6101(80:1) = "Y" THEN
*>              ??蝝圈??迂
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

*>      ?瘜?

        MOVE "??"             TO W-INQ-RX-WAY(1:8).

*>      ?賊?
        IF HRDTB-RX-QTY1 > 0 AND HRDTB-RX-QTY2 > 0 THEN
                MOVE HRDTB-RX-QTY1      TO W-QTY1
                MOVE HRDTB-RX-QTY2      TO W-QTY2
                PERFORM F-QTY-RTN
                MOVE W-DIS-QTY          TO W-INQ-RX-QTY
        ELSE
                MOVE HRDTB-RX-QTY1      TO W-INQ-RX-QTY(1:4)
                MOVE HRDTB-RX-QTY2      TO W-INQ-RX-QTY(6:2)
        END-IF.
*>      ?????
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

*>      ??????
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

*>2019/12/24 ??IS
*>?芷??撖信R_UDL3
 F-DEL-TO-WRITE-HRUDL3-RTN.
        INITIALIZE HRUDL3-MST-REC.
*       COPY "ZD_DTI.PRC".

*
* ZD_DTI.PRC ... ??ZD_YMD.PRC ...  ?????...
*
        MOVE W-RUN-YYSW  TO W-YMD-YYSW.
        MOVE W-RUN-YYDEF TO W-YMD-YYDEF.
        MOVE W-RUN-YYCOM TO W-YMD-YYCOM.
*
* ?交? ...
        ACCEPT W-YMD-DATE FROM CENTURY-DATE.
        MOVE W-YMD-YY TO W-YMD-YYB.
        MOVE W-YMD-YY TO W-YMD-YY1.
        MOVE W-YMD-MM TO W-YMD-MM1.
        MOVE W-YMD-DD TO W-YMD-DD1.
*
* YYSW   : 雿輻撟湔?閮剖?     -- 4:雿輻?Ⅳ镼踹?撟?2:鈭Ⅳ镼踹?撟? 0:銵其蝙?函?啣?撟?
* YYDEF  : 撟游漲????    -- 镼踹?撟湔?蝞蝙?典?撟游???靘?1911, 0 閬?1911)
* YYCOM  : 撟游漲閮??孵?     -- 镼踹?撟渲?蝞蝙?典?撟湔撘?靘?+,-, 蝛箇閬? - )
* YDFSW  : 霈??..
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
* YYS : - 銵刻???撟游漲?箄???
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
* ?? ...
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
*>      ?啣??交?
        MOVE W-DATE             TO HRUDL3-C-DATE HRUDL3-UPD-DT.
*>      ?啣???
        MOVE W-TIME             TO HRUDL3-C-TIME.
*>      ?啣???
        MOVE W-TIME             TO HRUDL3-UPD-TIME.
*>      ?風??
        MOVE PAT-NO             TO HRUDL3-PAT-NO.
*>      雿摨?
        MOVE ICB-IPD-NO         TO HRUDL3-PATIENT-SEQ.
*>      瘚偌摨?
        MOVE ECB-FEE-SEQ        TO HRUDL3-ORDER-SEQ.
*>      瑼?摨?
        MOVE ECB-FILE-NO        TO HRUDL3-FILE-NO.
*>      ?????D"
        MOVE "D"                TO HRUDL3-STATUS-FLAG.
*>      ?蔭隞?Ⅳ
        MOVE ICB-FEE-KEY        TO HRUDL3-ODR-CODE.
*>      甈∪?????
        MOVE ICB-RX-UQTY1       TO HRUDL3-DOSE-MOLE.
*>      甈∪?????
        MOVE ICB-RX-UQTY2       TO HRUDL3-DOSE-DENO.
*>      ??
        MOVE ICB-RX-WAY2        TO HRUDL3-METHOD-CODE.
*>      ??憭拇
        MOVE ICB-RX-DAYS        TO HRUDL3-DAYS.
*>      ????
        MOVE ICB-OP-BDATE       TO HRUDL3-B-DATE.
*>      ????
        MOVE ICB-OP-BTIME       TO HRUDL3-B-TIME.
*>      蝯???
        MOVE ICB-OP-EDATE       TO HRUDL3-E-DATE.
*>      蝯???
        MOVE ICB-OP-ETIME       TO HRUDL3-E-TIME.
*>      蝮賡?-??
        MOVE ICB-RX-QTY1        TO HRUDL3-NUM-MOLE.
*>      蝮賡?-??
        MOVE ICB-RX-QTY2        TO HRUDL3-NUM-DENO.
*>      ?乩?閮餉?

        MOVE ICB-PAY-RANK       TO HRUDL3-ER-FLAG.
*>      ?芾祥霅
        MOVE ICB-ASU-PAY        TO HRUDL3-VAL-SWITCH.
*>      閮?孵?
        MOVE ICB-CHG-FLAG       TO HRUDL3-OWN-FLAG.
*>      ?阡??
        MOVE ECB-BRAIN-YN       TO HRUDL3-BRAIN-FLAG.
*>      ?其?
        MOVE ECB-LRB-FIELD      TO HRUDL3-POSITION-FLAG.
*>      ???怠葦
        MOVE ECB-APY-DR         TO HRUDL3-DR-CODE.
*>      撖虫??怠葦銝
        MOVE ECB-OPR-DR1        TO HRUDL3-CARRY1-CODE.
*>      撖虫??怠葦鈭?
        MOVE ECB-OPR-DR2        TO HRUDL3-CARRY2-CODE.
*>      ?勗??怠葦
        MOVE ECB-RPT-DR         TO HRUDL3-REPORT-DR-CODE.
*>      ??葆??(?園?)
        MOVE ECB-LNK-POINT-HEAD TO HRUDL3-LNK-POINT-HEAD.
*>      ??葆??(摮?)
        MOVE ECB-LNK-POINT      TO HRUDL3-LNK-POINT.
*>      ??葆????
        MOVE ECB-LNK-TIME       TO HRUDL3-LNK-TIME.
*>      蝘恕隞?Ⅳ
        MOVE ICB-PAS-DPT        TO HRUDL3-DPT-CODE.
*>      憿隞?Ⅳ
        MOVE ICB-CLS-NO         TO HRUDL3-CLS-CODE.
*>      瘚偌摨?
        MOVE ICB-FEE-SEQ        TO HRUDL3-SERIAL-NO.
*>      ?思誘?隞?Ⅳ
        MOVE ICB-PAS-ITM        TO HRUDL3-ITM-CODE.
*>      ?Ｗ鞎餌?隞?Ⅳ??皞祥?典嚗?
        MOVE ICB-STD-FNO        TO HRUDL3-STD-CODE.
*>      摨怠?隞?Ⅳ?澈?伐?
        MOVE ICB-STO-DEPT       TO HRUDL3-STORE-CODE.
*>      ?酉
        MOVE ECB-REMARK         TO HRUDL3-ODR-NOTE.

        WRITE HRUDL3-MST-REC.
        IF HRUDL3-MST-STATUS NOT = "00" THEN
                MOVE "B"        TO W-TMP-ID
                MOVE "W"        TO W-UPD-MRK
                PERFORM F-WRT-LOG2-RTN THRU F-WRT-LOG2-EXIT
        END-IF.

*>閮?ICA撖急??航炊蝣墩7]
 F-WRT-LOG2-RTN.
*       COPY "ZD_DTI.PRC".
*
* ZD_DTI.PRC ... ??ZD_YMD.PRC ...  ?????...
*
        MOVE W-RUN-YYSW  TO W-YMD-YYSW.
        MOVE W-RUN-YYDEF TO W-YMD-YYDEF.
        MOVE W-RUN-YYCOM TO W-YMD-YYCOM.
*
* ?交? ...
        ACCEPT W-YMD-DATE FROM CENTURY-DATE.

        MOVE W-YMD-YY TO W-YMD-YYB.
        MOVE W-YMD-YY TO W-YMD-YY1.
        MOVE W-YMD-MM TO W-YMD-MM1.
        MOVE W-YMD-DD TO W-YMD-DD1.
*
* YYSW   : 雿輻撟湔?閮剖?     -- 4:雿輻?Ⅳ镼踹?撟?2:鈭Ⅳ镼踹?撟? 0:銵其蝙?函?啣?撟?
* YYDEF  : 撟游漲????    -- 镼踹?撟湔?蝞蝙?典?撟游???靘?1911, 0 閬?1911)
* YYCOM  : 撟游漲閮??孵?     -- 镼踹?撟渲?蝞蝙?典?撟湔撘?靘?+,-, 蝛箇閬? - )
* YDFSW  : 霈??..
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
* YYS : - 銵刻???撟游漲?箄???
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
* ?? ...
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
                STRING  "?-" ICA-KEY " 撖急?銝????瘜?" ICA-MST-STATUS " 嚗?
                        " ?交?-" W-DATE " ??-" W-TIME  DELIMITED BY SIZE INTO LOG2-DATA
                END-STRING
        ELSE
                STRING  "雿?思誘[瑼ａ?瑼Ｘ?曉?]?啣?閮?瑼神瑼???嚗?瘜?" HRUDL3-MST-STATUS " 嚗?
                        " ?交?-" W-DATE " ??-" W-TIME  DELIMITED BY SIZE INTO LOG2-DATA
                END-STRING
        END-IF.
        WRITE LOG2-MST-REC.

 F-WRT-LOG2-EXIT.
        EXIT.
*>2019/12/24 END
***********************************************************************
*COPY    "HI_DTE.PRC".
*> ****************************************************************************
*> C-PY FILE : HI_DTE.PRC  CHECK ?喳撖拇??嚗撣喲?瑼?HIOD1KF ?思誘?賊?雿平
*>      W-IPD-LOCK = "Y" ?粹                           HIOD2MF
*>      W-IPD-LOCK = "X" 雿                           HIOD3DF
*>      890511 靽格雿銝剔?梢?瑼??                  HIRTNKF
*>      901023 憓??斗?游董??(CALL HILOCKCF)  (JAY)   HIDENKF
*> ****************************************************************************
*F-CHK-DTE-DATA.
*        INITIALIZE              W-IPD-LOCK      W-DTE-TABLE.
*>      雿銝? 隞付PD-MST 銋?梯絲餈??批?臬?喳
*        IF IPD-OUT-DT   = 0
*                PERFORM F-CHK-APYI-LOCK
*        ELSE
*                PERFORM F-DTE-READ
*                IF DTE-VRY-LOCK = "Y"
*                        MOVE "Y"          TO W-IPD-LOCK
*                        PERFORM F-DIS-IPD-LOCK
*                END-IF
*        END-IF.
*> 雿銝? ?喳??撖拇
*F-CHK-APYI-LOCK.
*        IF      IPD-APY-STRDT-R = SPACE OR IPD-APY-ENDDT-R = SPACE

*                EXIT    PARAGRAPH
*        END-IF.
*        IF      (IPD-APY-STRDT-R IS NUMERIC AND IPD-APY-STRDT = ZERO)
*        OR      (IPD-APY-ENDDT-R IS NUMERIC AND IPD-APY-ENDDT = ZERO)
*                EXIT    PARAGRAPH
*        END-IF.
*>      撖阡?雿??
*        IF IPD-REAL-YN = "Y" AND IPD-UD-DT NOT = ZERO
*                MOVE    IPD-UD-DT(1:5)  TO      W-CHK-DTE-YM    WITH CONVERT
*        ELSE
*                MOVE    IPD-DT(1:5)     TO      W-CHK-DTE-YM    WITH CONVERT
*        END-IF.
*>      敺??Ｘ銋僑?撠???瑼?撟湔?
*        INITIALIZE                      DTE-MST-REC.
*        MOVE    W-CHK-DTE-YM            TO      DTE-VRY-YM.
*        START   DTE-MST KEY IS  >=      DTE-MST-KEY.
*        IF      DTE-MST-STATUS  = "00"
*                READ    DTE-MST NEXT RECORD
*        END-IF.
*>      銝??芯??Ｘ隞亙??????銋僑??
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
*> 靘??孵僑??亥府?遢?臬撌脤?瑼?
*F-SEARCH-DTE-LOCK.
*        INITIALIZE      W-IPD-LOCK.
*        IF      IPD-APY-STRDT-R = SPACE OR IPD-APY-ENDDT-R = SPACE
*                EXIT    PARAGRAPH
*        END-IF.
*        IF      (IPD-APY-STRDT-R IS NUMERIC AND IPD-APY-STRDT = ZERO)
*        OR      (IPD-APY-ENDDT-R IS NUMERIC AND IPD-APY-ENDDT = ZERO)
*                EXIT    PARAGRAPH
*        END-IF.
*>      ?文??乒???交?臬?賢?祆活?喳??, 憒惇?潭甈∠?勗???
*>      ?誑?喳餈銋僑???嗆???銋僑??? ?血?隞亥??寞??交銋僑??
*>      靘???撟湔?銋??     890511 UPDATE.
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
*> CHECK 閰脫?隞賣?血歇?喳??
*F-DTE-READ.
*        INITIALIZE              DTE-MST-REC.
*        IF      IPD-LIVE-ID     = "B" OR "C" OR "X"
*                EXIT    PARAGRAPH
*        END-IF.
*        MOVE IPD-OUT-DT(1:5)    TO DTE-VRY-YM   WITH CONVERT.
*        READ DTE-MST  KEY IS    DTE-MST-KEY.
*> ?喳??閮
*F-DIS-IPD-LOCK.
*        MOVE " 甇斤???歇?喳??,隢??!!"  TO W-NOTE.
*        PERFORM F-NOTE-RTN.
*---------------------*
* 901023 ?斗?游董撟湔? *
*---------------------*
 F-CHK-LOCK-RTN.
        INITIALIZE      W-LNK-LOCKCF.
        IF      W-CHK-1029-YN = "Y"
*>              ?舐?撘??質???
                MOVE    "02"    TO      W-LOCKCF-ID
        ELSE
                MOVE    "03"    TO      W-LOCKCF-ID
        END-IF.
*>      ??交?
        MOVE    W-CHK-DTE-YMD   TO      W-LOCKCF-DT.
        CALL    "HILOCKCF"      USING   W-LNK-LOCKCF
                ON      EXCEPTION       CONTINUE
        END-CALL.
 F-CHK-LOCK-EXIT.
        EXIT.
*> ******************************************************
*>      END     OF      FILE
*> ******************************************************
*------> ?餃??風?賊??梁畾?
*COPY    "HI_ELC.PRC".
**************************************************************
*> C-PY FILE : HI_ELC.PRC       HR_ELC.TRN 撖急??梁畾?
*>                              EMBEDED IN HI_ODWI.PRC, HI_ICBV.PRC
*>                              USED BY HIOD2MF
*>      雿蝞∠?, 雿?嗉祥, 雿?思誘?梁
*>      900915 憓??喳銝餅??賊?靽格
**************************************************************
*> 霈???貉身摰?CHECK ?餃??風?????
 F-READ-ELC-SETTING.
        INITIALIZE              W-LNK-ELCCF.
        MOVE    "01"            TO      W-ELCCF-ID.
        CALL    "HIELCCF"       USING   W-LNK-ELCCF     ON EXCEPTION CONTINUE.
        MOVE    W-ELCCF-YN      TO      W-ELC-YN.
*>      900915 SMSTL UPDATE:
        MOVE    W-ELCCF-APY-YN  TO      W-USE-APY-YN.
*> ?餃??風??(???嗅?蝟餌絞蝔?雿輻)
 F-OPEN-ELC-TRN.

        INITIALIZE              W-LNK-ELCCF.
*>      ?芯蝙?券摮?甇瑕??喳銝餅??? ????, ?園?銝??蝡閬?瑼?900915 UPDATE
        IF      (W-ELC-YN       NOT = "Y")
        AND     (W-USE-APY-YN   NOT = "Y")
                EXIT    PARAGRAPH
        END-IF.
        MOVE    "02"            TO      W-ELCCF-ID.
        CALL    "HIELCCF"       USING   W-LNK-ELCCF     ON EXCEPTION CONTINUE.
*>      IF W-ELCCF-ERR  = "Y"
*>              銝?閮勗?銝銵?撘?
*>      END-IF.
*> ?餃??風??(???嗅?蝟餌絞蝔?雿輻)
 F-CLOSE-ELC-TRN.
        INITIALIZE              W-LNK-ELCCF.
        IF      (W-ELC-YN       NOT = "Y")
        AND     (W-USE-APY-YN   NOT = "Y")
                EXIT    PARAGRAPH
        END-IF.
        MOVE    "03"            TO      W-ELCCF-ID.
        CALL    "HIELCCF"       USING   W-LNK-ELCCF     ON EXCEPTION CONTINUE.
*> ?餃??風雿?箸鞈??啣?瑼神瑼?
 F-WRITE-ELC-TRN-11.
*>      ?餃??風?芷????銝???
        IF      W-ELC-YN        NOT = "Y"
                EXIT    PARAGRAPH
        END-IF.
        INITIALIZE                      W-LNK-ELCCF.
*>      雿?箸鞈??啣?
        MOVE    "11"                    TO      W-ELCCF-ID.
        MOVE    IPD-NO                  TO      W-ELCCF-IPD-NO.
        MOVE    W-ELC-MARK              TO      W-ELCCF-MARK.
        CALL    "HIELCCF"       USING   W-LNK-ELCCF     ON EXCEPTION CONTINUE.
*> ?餃??風/?喳銝餅???啣?瑼神瑼?
 F-WRITE-ELC-TRN-21.
*>      ?餃??風??啣?
        PERFORM F-WRITE-ELC-TRN-211.
*>      ?喳銝餅???啣?
        PERFORM F-WRITE-ELC-TRN-41.
*> ?餃??風??啣?
 F-WRITE-ELC-TRN-211.
*>      ?餃??風?芷????銝???
        IF      W-ELC-YN        NOT = "Y"
                EXIT    PARAGRAPH
        END-IF.
        INITIALIZE                      W-LNK-ELCCF.
*>      ?孵鞈??啣?C/靽格M/?芷D
        MOVE    "21"                    TO      W-ELCCF-ID.
        MOVE    ICA-IPD-NO              TO      W-ELCCF-IPD-NO.
        MOVE    ICA-ODR-NO              TO      W-ELCCF-ODR-NO.
        MOVE    W-ELC-MARK              TO      W-ELCCF-MARK.
        CALL    "HIELCCF"       USING   W-LNK-ELCCF     ON EXCEPTION CONTINUE.
*> ?喳銝餅???啣?撖急?
 F-WRITE-ELC-TRN-41.
*>      ?餃??風?芷????銝???
        IF      W-USE-APY-YN            NOT = "Y"
                EXIT    PARAGRAPH
        END-IF.

        INITIALIZE                      W-LNK-ELCCF.
*>      ?孵鞈??啣?C/靽格M/?芷D
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
*       C-PY    FILE : HI_GCA2.PRC      USED BY : HIOD2MF?隞斤頂蝯?摰?)       *
* 901122  CREATE BY JAY                                                         *
* 910301  ??W-ICA-TMP-UPD-USR-ID?臬??乩耨?孵??耨?孵?銋?? (JAY)           *
* 910306  ?喳蝟餌絞?啣?霅蝣澆神瑼?JAY)                                           *
*********************************************************************************
*------------------------*
* 撖怠靽格???寧????*
*------------------------*
 F-WRITE-GCA-OLD-RTN.
        INITIALIZE      HIGCA-MST-REC.
        MOVE    W-ICA-TMP-KEY           TO      HIGCA-KEY.
        MOVE    W-DATE                  TO      HIGCA-DATE.
        MOVE    W-TIME                  TO      HIGCA-TIME.
        MOVE    W-UPD-ID                TO      HIGCA-UPD-ID.
*>      ?啣???910301)
        MOVE    W-ICA-TMP-UPD-USR-ID    TO      HIGCA-UPD-USR.
*       MOVE    W-RK-DUTY-ID1           TO      HIGCA-UPD-USR.
*>      ?喳蝟餌絞?啣?霅(910306)
        MOVE    W-GCA-APY-ID            TO      HIGCA-APY-ID.
        MOVE    W-ICA-TMP-GROUP-DATA1   TO      HIGCA-DATA1.
        WRITE   HIGCA-MST-REC.
 F-WRITE-GCA-OLD-EXIT.
        EXIT.
*------------------*
* 撖怠??啣?閮? *
*------------------*
 F-WRITE-GCA-NEW-RTN.
        INITIALIZE      HIGCA-MST-REC.
*>      雿摨?
        MOVE    ICA-IPD-NO      TO      HIGCA-IPD-NO.
*>      ?摨?
        MOVE    ICA-ODR-NO      TO      HIGCA-ODR-NO.
*>      ?啣??交?
        MOVE    W-DATE          TO      HIGCA-DATE.
*>      ?啣???
        MOVE    W-TIME          TO      HIGCA-TIME.
*>      ?啣????
        MOVE    W-UPD-ID        TO      HIGCA-UPD-ID.
*>      ?啣???
        MOVE    W-RK-DUTY-ID1   TO      HIGCA-UPD-USR.
*>      ?喳蝟餌絞?啣?霅(910306)
        MOVE    W-GCA-APY-ID            TO      HIGCA-APY-ID.
        MOVE    ICA-GROUP-DATA1 TO      HIGCA-DATA1.
        WRITE   HIGCA-MST-REC.
 F-WRITE-GCA-NEW-EXIT.

        EXIT.
*----------------------*
* 撖怠??敦?啣?閮? *
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
* 蝟餌絞TIME 銋??? + 1 , ?靽格???啣???銋榆頝?*
*--------------------------------------------------*
 F-ADD-MT-RTN.
        ADD     1       TO      W-MT.
 F-ADD-MT-EXIT.
        EXIT.
*------>???怠葦蝘
*COPY    "HR_LOA1.PRC".
************************************************************************
*> HR_LOA1.PRC
************************************************************************
*??
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
*>102.12.02 (FISH) 靽格迤?怠葦隞?Ⅳ頛??????DM1301-J1301394)
*>103.04.08 (?訾撰)
************************************************************************
*銝?
 F-DEP-RTN.
*>      INITIALIZE W-PERCENT.
*>      INITIALIZE W-LA-NAME.
*>      MOVE "蝟餌絞蝘隞?Ⅳ銝?銝?隢???..."    TO W-LA-NAME.
*>      PERFORM F-LOAD-BAR.
        INITIALIZE W-LA-NAME.
        MOVE "蝟餌絞蝘隞?Ⅳ銝?銝?隢???..."    TO W-LA-NAME.
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
*>      MOVE "蝟餌絞?怠葦隞?Ⅳ銝?銝?隢???..."    TO W-LA-NAME.
*>      PERFORM F-LOAD-BAR.
        INITIALIZE W-LA-NAME.
        MOVE "蝟餌絞?怠葦隞?Ⅳ銝?銝?隢???..."    TO W-LA-NAME.

*>START (?訾撰) 103.04.08
*>START (FISH) 102.12.02 靽格迤?怠葦隞?Ⅳ頛??????
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
*------>??瑼?
*COPY    "HR_WAT.PRC".
***********************************************************************
*> ??瑼?沌RC
***********************************************************************
 F-OPEN-MESG.
        INITIALIZE W-LA-NAME.
        MOVE "蝔?撘???瑼?銝?....隢?蝔???...." TO W-LA-NAME.
        MOVE "蝔?撘???瑼?銝?....隢?蝔???...." TO W-FONT-TITLE.
        INITIALIZE W-PERCENT.
        MOVE "O"        TO W-OPEN-MESG-TYPE.

 F-CLOSE-MESG.
        INITIALIZE W-LA-NAME.
        MOVE "蝔?撘???瑼?銝?....隢?蝔???...." TO W-LA-NAME.
        MOVE "蝔?撘???瑼?銝?....隢?蝔???...." TO W-FONT-TITLE.
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

*>      ?梯?皜豢? 嚗?撐嚗莎撲嚗荔撞?嚗荔戮嚗摩嚗佗憐
        SET ENVIRONMENT "CURSOR-MODE"   TO 2.
*>      ACCEPT KEY-STATUS LINE 10 COL 100 BEFORE TIME 10 ON EXCEPTION CONTINUE.
        CALL 'C$SLEEP' USING "0.1".
*>      皜豢??儔
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

*> 閮??曉?瘥?
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
*------>?航炊閮STATUS BAR
*COPY    "HR_NOT.PRC".
***********************************************************************
*> ?思誘蝟餌絞?祉霅血?閮
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
*> STATUS-BAR閮
***********************************************************************
 F-OK-NOTE.
        PERFORM F-CLEAR-HRSTATUS-RTN.
        MOVE "??閮" TO W-HRSTATUS-P1.
        MOVE W-NOTE     TO W-HRSTATUS-P2.
        PERFORM F-DISPLAY-HRSTATUS-RTN.
        CALL "C$SLEEP" USING 1.
        PERFORM F-CLEAR-HRSTATUS-RTN.
 F-WAR-NOTE.
        PERFORM F-CLEAR-HRSTATUS-RTN.
        MOVE "??閮" TO W-HRSTATUS-P1.
        MOVE W-NOTE     TO W-HRSTATUS-P2.

        PERFORM F-DISPLAY-HRSTATUS-RTN.
 F-BLANK.
        PERFORM F-CLEAR-HRSTATUS-RTN.

 F-DIS-DEL-MSG.
        INITIALIZE W-NOTE.
        MOVE "鞈??芷銝?...隢?葉?琿..." TO W-NOTE.
        PERFORM F-WAR-NOTE.
 F-DIS-WRT-MSG.
        INITIALIZE W-NOTE.
        MOVE "鞈?摮?銝?...隢?葉?琿..." TO W-NOTE.
        PERFORM F-WAR-NOTE.
***********************************************************************
*> STATUS-BAR
***********************************************************************
 F-CREATE-HRSTATUS-RTN.
        DISPLAY STATUS-BAR
                PANEL-WIDTHS (80),
                PANEL-STYLE (1),
                PANEL-TEXT (W-HRSTATUS-P2),
                GRIP, FONT IS 蝝唳?擃?1,
                HANDLE IS S-HRSTATUS-1-Handle.

 F-DISPLAY-HRSTATUS-RTN.
        MODIFY S-HRSTATUS-1-Handle
                PANEL-WIDTHS (80),
                PANEL-STYLE (1),
                PANEL-TEXT (W-HRSTATUS-P2),
                GRIP, FONT IS 蝝唳?擃?1.

 F-CLEAR-HRSTATUS-RTN.
        INITIALIZE W-HRSTATUS-P1 W-HRSTATUS-P2 W-HRSTATUS-P3 W-HRSTATUS-P4.
        INITIALIZE W-HRSTATUS-P5 W-HRSTATUS-P6 W-HRSTATUS-P7.
        MOVE "??閮" TO W-HRSTATUS-P1.
        PERFORM F-DISPLAY-HRSTATUS-RTN.
***********************************************************************
***********************************************************************
*> END OF "HR_RCB1IF.PRC".
***********************************************************************
*{TAMIS}end



