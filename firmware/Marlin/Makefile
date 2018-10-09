BAUDRATE = 9600 
DEVICE   = /dev/ttyACM0
PACKAGE  = arduino
ARCH     = avr
BOARD    = mega
SKETCH   = Marlin.ino

VERIFY = --board $(PACKAGE):$(ARCH):$(BOARD) \
	     --port $(DEVICE)                    \
		 --verify $(SKETCH)

UPLOAD = --board $(PACKAGE):$(ARCH):$(BOARD) \
		 --port $(DEVICE)                    \
		 --upload $(SKETCH)


upload: 
	@arduino $(UPLOAD)

verify: 
	@arduino $(VERIFY)
