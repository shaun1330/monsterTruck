import reportlab
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4
import os


w, h = A4


class InvoiceGenerator:
    def __init__(self, pdf_name, invoice_total, dueDate):
        self.font = "Times-Roman"
        self.c = canvas.Canvas(pdf_name, A4)
        self.text(0.05, 0.94, "Greater Western 4x4 Club Inc.", 15, self.font)
        self.text(0.05, 0.925, "PO BOX 904", 10, self.font)
        self.text(0.05, 0.91, "Gisborne VIC 3437", 10, self.font)
        self.text(0.62, 0.93, "TAX INVOICE", 30, self.font)
        boxWidth = 210
        boxHeight = 20
        self.c.setFillColorRGB(211 / 255, 211 / 255, 211 / 255)
        self.c.rect(0.6 * w, 0.87 * h, boxWidth, boxHeight, fill=True)
        self.c.rect(0.6 * w, 0.87 * h - boxHeight, boxWidth, boxHeight)
        self.c.rect(0.6 * w, 0.79 * h, boxWidth, boxHeight, fill=True)
        self.c.rect(0.6 * w, 0.79 * h - 50, boxWidth, 50)
        self.c.setFillColorRGB(0, 0, 0)
        self. c.line(0.6 * w + boxWidth / 2, 0.87 * h - boxHeight, 0.6 * w + boxWidth / 2, 0.87 * h + boxHeight)
        self.text(0.65, 0.88, "INVOICE #", 10, self.font)
        self.text(0.84, 0.88, "DATE", 10, self.font)
        self.text(0.65, 0.80, "Invoice Total", 10, self.font)
        self.text(0.63, 0.75, "$"+str(invoice_total), 20, self.font)
        self.text(0.80, 0.75, dueDate, 20, self.font)
        self.c.line(0.6*w + (boxWidth/2), 0.79*h + 20, 0.6*w + (boxWidth/2), 0.79*h - 50)
        self.text(0.83, 0.80, 'Due Date', 10, self.font)

        # self.text(0.65, 0.855, "[12345]", 12)
        # self.text(0.81, 0.855, "[dd/mm/yyyy]", 12)
        self.c.setFillColorRGB(211 / 255, 211 / 255, 211 / 255)
        self.c.rect(0.05 * w, 0.8 * h, boxWidth, boxHeight, fill=True)
        self.c.setFillColorRGB(0, 0, 0)
        self.text(0.07, 0.81, "BILL TO", 10, self.font)

        # self.text(0.05, 0.785, "[member name]", 12)

        self.c.rect(0.05 * w, 0.3 * h, w - (0.1 * w), 330, fill=0)  # main table
        self.c.setFillColorRGB(211 / 255, 211 / 255, 211 / 255)
        self.c.rect(0.05 * w, 0.3 * h + 330, w - (0.1 * w), 20, fill=True)  # column header top row of main table
        self.c.setFillColorRGB(0, 0, 0)
        self.text(0.065, 0.7, "ITEM CODE", 10, self.font)
        self.c.line(0.17 * w, 0.3 * h, 0.17 * w, 0.3 * h + 330 + 20)  # line between item code and description
        self.text(0.185, 0.7, "DESCRIPTION", 10, self.font)
        self.c.line(0.55 * w, 0.3 * h, 0.55 * w, 0.3 * h + 330 + 20)  # line between description and unit price
        self.text(0.565, 0.7, "UNIT PRICE", 10, self.font)
        self.c.line(0.67 * w, 0.3 * h, 0.67 * w, 0.3 * h + 330 + 20)  # line between unit price and quantity
        self.text(0.685, 0.7, "QTY", 10, self.font)
        self.c.line(0.74 * w, 0.3 * h, 0.74 * w, 0.3 * h + 330 + 20)  # line between quantity and total
        self.text(0.755, 0.7, "SUBTOTAL (INC GST)", 10, self.font)

        self.c.rect(0.74 * w, 0.3 * h - 20, w - 0.74 * w - 0.05 * w, 20)
        self.text(0.40, 0.280, "TOTAL INCLUDING GST:", 15, self.font)
        self.text(0.76, 0.285, f"${invoice_total}", 10, self.font)

        self.text(0.05, 0.2, "PAYMENT OPTIONS:", 15, self.font)
        self.text(0.1, 0.175, "1. Bank Transfer to:", 15, self.font)
        self.text(0.17, 0.155, "Bank:", 15, self.font)
        self.text(0.17, 0.135, "Customer Name:", 15, self.font)
        self.text(0.17, 0.115, "BSB:", 15, self.font)
        self.text(0.1, 0.08, "2. Cash in person to one of the committee members.", 15, self.font)
        self.text(0.4, 0.115, "Acc No:", 15, self.font)

        self.font = "Times-Bold"

        self.text(0.37, 0.135, "Greater Western 4x4 Club", 15, self.font)

        self.c.drawImage('./config/GreaterWesternSmallBlackAndWhite.jpg', 0.75 * w, 0.08 * h, 0.19 * w, 0.16 * h)


    def invoice_line(self, item_codes, item_descs, item_prices, qtys, subtotals):
        c = 0
        for i in item_codes:
            self.text(0.065, 0.67-0.03*c, str(i), 10, self.font)
            c += 1

        c = 0
        for i in item_descs:
            self.text(0.185, 0.67-0.03*c, str(i), 10, self.font)
            c += 1

        c = 0
        for i in item_prices:
            self.text(0.565, 0.67-0.03*c, str(i), 10, self.font)
            c += 1

        c = 0
        for i in qtys:
            self.text(0.685, 0.67 - 0.03 * c, str(i), 10, self.font)
            c += 1

        c = 0
        for i in subtotals:
            self.text(0.755, 0.67 - 0.03 * c, str(i), 10, self.font)
            c += 1


    def text(self, x, y, string, size, font):
        self.c.setFont(font, size)
        self.c.drawString(x * w, y * h, string)

    def invoiceNo(self, invoice_no):
        self.text(0.65, 0.855, str(invoice_no), 12, self.font)

    def invoiceDate(self, date):
        self.text(0.83, 0.855, date, 12, self.font)

    def memberName(self, name):
        self.text(0.05, 0.785, name, 12, self.font)

    def streetAdress(self, address):
        self.text(0.05, 0.77, str(address), 12, self.font)

    def cityStatePostCode(self, city, state, postCode):
        self.text(0.05, 0.755, f"{city}, {state}, {postCode}", 12, self.font)

    def BankDetails(self, bank, bsb, accountNo):
        self.text(0.27, 0.155, str(bank), 15, self.font)
        self.text(0.27, 0.115, str(bsb), 15, self.font)
        self.text(0.5, 0.115, str(accountNo), 15, self.font)

    def save(self, path):
        origPath = os.getcwd()
        os.chdir(path)
        self.c.showPage()
        self.c.save()
        # self.c
        os.chdir(origPath)




#
# invoice = InvoiceGenerator("invoice_class_test2.pdf", "200.00", "12/12/19")
# invoice.invoiceNo(95643)
# invoice.invoiceDate("12/12/12")
# invoice.memberName("Shaun Simons")
# invoice.invoice_line(item_codes=[1234, 5422, 7645, 8743])
#
# invoice.save('.')

