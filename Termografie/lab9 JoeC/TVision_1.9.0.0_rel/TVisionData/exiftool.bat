exiftool.exe -flir:all "IR_0074IR.tiff"
exiftool.exe -flir:all "IR_0019IR.png"
pause
exiftool.exe -b -EmbeddedImage "FLIRE4.jpg" -w "VIS.png"
pause
exiftool.exe -b -rawthermalimage "FLIRE4.jpg" -w "IR.png"
pause