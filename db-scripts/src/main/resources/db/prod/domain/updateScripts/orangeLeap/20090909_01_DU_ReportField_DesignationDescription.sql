UPDATE REPORTFIELD SET COLUMN_NAME = 'GETPICKLISTLONGDESCRIPTION(''projectCode'', DISTRO_LINE_PROJECT_CODE)' WHERE COLUMN_NAME = 'GETPICKLISTDISPLAYVALUE(''projectCode'', DISTRO_LINE_PROJECT_CODE)' AND DISPLAY_NAME = 'Designation Description';