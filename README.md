# GameBoyCode

## Getting started

1. Download and extract the [GBDK tools](https://github.com/gbdk-2020/gbdk-2020/releases) to the dependencies folder.
2. Download an [emulator](https://bgb.bircd.org/) to the dependencies folder, which can run .gb files
3. Build the files

```shell
make.bat
```

Run the files

```shell
run.bat
```

the final folder structure will be something like:

```
├── src
│   ├── ...
├── build
│   ├── CrownSimulator.gb
├── dependencies
│   ├── bgbw
│   │   ├── bgb64.exe
│   │   ├── ...
│   ├── gbdk
│   │   ├── bin
│   │   │   ├── lcc.exe
│   │   │   ├── ...
│   │   ├── ...
├── make.bat
├── run.bat
└── ...(whatever root level config)
```

## Build and run in one command

Most likely, you'll make a change and want to see that change in the next run. In this case, you can pass an argument to the run batch.

```shell
run.bat rebuild
```
