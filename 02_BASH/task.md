# Create a backup script

1. skrypt instalacyjny powinien być zapisany jako funkcja
2. wykonac backup poleceniem `redis-cli save`
3. Backup zapisać w katalogu `/backup` - plik powinien się nazywać `RRRR_MM_DD_redis.backup`. Backup domyślnie znajduje się w katalogu `/var/lib/redis`
4. Wszystko powinno być logowane i błędy powinny być przechwytywane

## Zadanie z gwiazdką :)
1. zrobić backup jako funkcje
2. zrobić rollback (przywrocenie jako funkcje)
3. usunac zawartość redisa `redis-cli DEL counter`
4. aby rollback zadziałał należy zatrzymać redisa `service redis-server stop` i przywrócić backup do pliku `/var/lib/redis/dump.rdb`
6. wystartować redis `service redis-server start`
7. stary rollback powinien być kasowany
8. to czy będzie robiony backup czy rollback będzie decydowal parametr przekazywany podaczas uruchamiania skryptu - instrukcja (case)