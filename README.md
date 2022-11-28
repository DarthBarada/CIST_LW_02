# Лабораторная работа № 2
```
Тема:		"Фиксация и контроль целостности информации"
Группа:		ИУ8-93
Студент:	Митрофанов Д.А.
```
---
## Цель
Изучить принципы использования программы ФИКС Unix 1.0 для снятия контрольных сумм.
## Задание
1. С помощью утилиты ФИКС-Unix 1.0 снять контрольную сумму по уровню 3 произвольной директории; 
2. По результатам работы программы отослать `HTML` отчёт.
## Ход работы
### 1 Инициализация
Воспользуемся результатами лабораторной работы № 1.
```bash
git clone https://github.com/DarthBarada/CIST_LW_01.git ./CIST_LW_02
cd CIST_LW_02/
git remote remove origin
tar -xzf ./output.tar.gz ./output
git remote add origin https://github.com/DarthBarada/CIST_LW_02.git
``` 
### 2 Снятие контрльных сумм
Используем `ufix` для того, чтобы вывести рекурсивно все пути файлов директории `./output` в файл `filelist.out`.
```bash
ufix -jR output/ > filelist.out
```
Фрагмент файла [filelist.out](filelist.out) представлен ниже:
```
./output/f1/cmdline
./output/f1/fuzzer_setup
./output/f1/fuzzer_stats
./output/f1/fuzz_bitmap
./output/f1/plot_data
./output/f1/crashes/id:000000,sig:11,sync:f4,src:000405
./output/f1/crashes/id:000001,sig:11,src:000386+000037,time:4180231,execs:1043654,op:splice,rep:8
./output/f1/crashes/id:000002,sig:11,src:000401+000454,time:4188704,execs:1044691,op:splice,rep:2
./output/f1/crashes/id:000003,sig:06,src:000430+000360,time:4206401,execs:1045928,op:splice,rep:8
./output/f1/crashes/id:000004,sig:11,src:000486+000369,time:4281925,execs:1053196,op:splice,rep:2
...
```
Для каждого файла указанного в `filelist.out` производим расчёт контрольных сумм, используя флаг `-e` программы `ufix`, по результатам расчёта создаётся файл проекта `LW02.prj`.
```bash
ufix -e filelist.out LW02.prj
```
Для вывода информации из файла проекта используеся флаг `-v` программы `ufix`.
```bash
ufix -v LW02.prj
```
Фрагмент информации, содержащейся в файле проекта:
```
Directory: ./output/f1
 C5C8C19D cmdline        27572FC0 fuzzer_setup   224839DD plot_data
 62E1F311 fuzz_bitmap    B5D91452 fuzzer_stats

Directory: ./output/f1/crashes
 2379B6A5 README.txt
 6419D0E2 id:000000,sig:11,sync:f4,src:000405
 95EDF29B id:000001,sig:11,src:000386+000037,time:4180231,execs:1043654,op:splice,rep:8
 91BF5EF9 id:000002,sig:11,src:000401+000454,time:4188704,execs:1044691,op:splice,rep:2
 E0CFBE7E id:000003,sig:06,src:000430+000360,time:4206401,execs:1045928,op:splice,rep:8
 04C758E6 id:000004,sig:11,src:000486+000369,time:4281925,execs:1053196,op:splice,rep:2
 58E3BB08 id:000005,sig:11,src:000488+000397,time:4284955,execs:1054925,op:splice,rep:4
 5E66ED34 id:000006,sig:11,src:000488+000397,time:4284979,execs:1054946,op:splice,rep:8
 ...
```
Как можно заметить, сначала указывается директория, после чего указываются пары контрольная сумма в 16-ричной системе счисления - файл директории, разделённые пробелом. Так как не был указан флаг `-1`, то при выводе информации директории `./output/f1` пары контрольная сумма - файл располагаются в табличном формате, пример того же вывода при использовании флага `-1` (одна строка - один файл) представлен ниже:
```   
Directory: ./output/f1
 C5C8C19D cmdline
 62E1F311 fuzz_bitmap
 27572FC0 fuzzer_setup
 B5D91452 fuzzer_stats
 224839DD plot_data
```
Для файла проекта `LW02.prj` используем флаг `-h` программы `ufix` для составления отчёта в формате `HTML`.
```bash
ufix -h LW02.prj LW02_Report.html
```
Отчёт, конвертированный в формате `PDF` можно предсмотреть по ссылке [LW02_Report](LW02_Report.pdf).