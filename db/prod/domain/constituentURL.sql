UPDATE REPORTFIELD set URL="\"http://localhost:8080/orangeleap/constituent.htm?constituentId=\" + $F{CONSTITUENT_CONSTITUENT_ID}",TOOLTIP="\"Show Constiuent in Orange Leap\"" where PRIMARY_KEYS="CONSTITUENT_CONSTITUENT_ID";