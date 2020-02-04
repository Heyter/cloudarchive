:: ClearLogs. Версия 1 Alpha
@ECHO OFF

:: Надеюсь, сохранить файл в кодировке dos-866 не забыли
CHCP 866

:: Зеленый на черном - интригующе... опять же, хакеры и все такое
COLOR A

CLS

:: Проверка на наличие прав администратора
FOR /F "tokens=1,2*" %%V IN ('bcdedit') DO SET adminTest=%%V
IF (%adminTest%)==(Отказано) GOTO errNoAdmin
IF (%adminTest%)==(Access) GOTO errNoAdmin

:: Shell 
ECHO.
ECHO ОЧИСТКА КЕША Shell (реестр)
REG DELETE "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\Shell\BagMRU\1\3\5" /f
ECHO.

ECHO.
ECHO ОЧИСТКА КЕША Prefetch (файловая система)
DEL /f /q %systemroot%Prefetch*.pf
DEL /f /q %systemroot%Prefetch*.db
DEL /f /q %systemroot%PrefetchReadyBoot*.fx
ECHO Выполнено
ECHO.

ECHO.
ECHO ОЧИСТКА КЕША Minidump (файловая система)
DEL /f /q %systemroot%Minidump*.*
ECHO Выполнено
ECHO.

ECHO.
ECHO ОЧИСТКА КЕША Recent (файловая система)
DEL /f /q %APPDATA%MicrosoftWindowsRecent*.*
DEL /f /q %APPDATA%MicrosoftWindowsRecentCustomDestinations*.*
DEL /f /q %APPDATA%MicrosoftWindowsRecentAutomaticDestinations*.*
ECHO Выполнено
ECHO.

:errNoAdmin
COLOR 4
ECHO Необходимо запустить этот скрипт от имени администратора
ECHO.
PAUSE

:: https://www.pvsm.ru/informatsionnaya-bezopasnost/292743
