###To capture a USB event trace
##Check https://docs.microsoft.com/en-us/windows-hardware/drivers/usbcon/how-to-capture-a-usb-event-trace an usage of logman an perfview

###Exemple
# logman create trace -n usbtrace -o %SystemRoot%\Tracing\usbtrace.etl -nb 128 640 -bs 128
# logman update trace -n usbtrace -p Microsoft-Windows-USB-USBXHCI (Rundown,Power)
# logman update trace -n usbtrace -p Microsoft-Windows-USB-UCX (Rundown,Power)
# logman update trace -n usbtrace -p Microsoft-Windows-USB-USBHUB3 (Rundown,Power)
# logman update trace -n usbtrace -p Microsoft-Windows-Kernel-IoTrace 0 2
# logman start -n usbtrace