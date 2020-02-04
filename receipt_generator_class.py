import reportlab
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4
import os


w, h = A4


class ReceiptGenerator:
    def __init__(self, pdf_name, invoice_total, cash_paid, transfer_paid,  amount_paid):
        # if len(str(invoice_total).split('.')[1]) == 1:
        #     invoice_total = str(invoice_total) + '0'
        # if len(str(cash_paid).split('.')[1]) == 1:
        #     cash_paid = str(cash_paid) + '0'
        # if len(str(transfer_paid).split('.')[1]) == 1:
        #     transfer_paid = str(transfer_paid) + '0'
        # if len(str(amount_paid).split('.')[1]) == 1:
        #     amount_paid = str(amount_paid) + '0'

        self.font = "Times-Roman"
        self.c = canvas.Canvas(pdf_name, A4)
        self.text(0.05, 0.94, "Greater Western 4x4 Club Inc.", 15, self.font)
        self.text(0.05, 0.925, "PO BOX 904", 10, self.font)
        self.text(0.05, 0.91, "Gisborne VIC 3437", 10, self.font)
        self.text(0.62, 0.93, "TAX RECEIPT", 30, self.font)
        boxWidth = 210
        boxHeight = 20
        self.c.setFillColorRGB(211 / 255, 211 / 255, 211 / 255)
        self.c.rect(0.6 * w, 0.87 * h, boxWidth, boxHeight, fill=True)
        self.c.rect(0.6 * w, 0.87 * h - boxHeight, boxWidth, boxHeight)
        self.c.rect(0.6 * w, 0.79 * h, boxWidth, boxHeight, fill=True)
        self.c.rect(0.6 * w, 0.79 * h - 50, boxWidth, 50)
        self.c.setFillColorRGB(0, 0, 0)
        self. c.line(0.6 * w + boxWidth / 2, 0.87 * h - boxHeight, 0.6 * w + boxWidth / 2, 0.87 * h + boxHeight)
        self.text(0.65, 0.88, "RECEIPT #", 10, self.font)
        self.text(0.84, 0.88, "DATE", 10, self.font)
        self.text(0.65, 0.80, "Receipt Total", 10, self.font)
        self.right_text(0.74, 0.75, "$"+str(invoice_total), 20, self.font)
        self.right_text(0.91, 0.75, "$0.00", 20, self.font)
        self.c.line(0.6*w + (boxWidth/2), 0.79*h + 20, 0.6*w + (boxWidth/2), 0.79*h - 50)
        self.text(0.83, 0.80, 'Balance Due', 10, self.font)

        # self.text(0.65, 0.855, "[12345]", 12)
        # self.text(0.81, 0.855, "[dd/mm/yyyy]", 12)
        self.c.setFillColorRGB(211 / 255, 211 / 255, 211 / 255)
        self.c.rect(0.05 * w, 0.8 * h, boxWidth, boxHeight, fill=True)
        self.c.setFillColorRGB(0, 0, 0)
        self.text(0.07, 0.81, "RECEIPT TO", 10, self.font)

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
        #
        # self.c.rect(0.74 * w, 0.3 * h - 20, w - 0.74 * w - 0.05 * w, 20)
        self.right_text(0.74, 0.280, "Total Including GST:", 12, self.font)
        # self.right_text(0.74, 0.280, ':', 12, self.font)
        self.right_text(0.9, 0.280, f"${invoice_total}", 12, self.font)

        self.right_text(0.74, 0.261, "Cash Amount Paid:", 12, self.font)
        # self.right_text(0.74, 0.261, ':', 12, self.font)
        self.right_text(0.9, 0.261, f"${cash_paid}", 12, self.font)

        self.right_text(0.74, 0.242, "Transfer Amount Paid:", 12, self.font)
        # self.right_text(0.74, 0.242, ':', 12, self.font)
        self.right_text(0.9, 0.242, f"${transfer_paid}", 12, self.font)

        self.right_text(0.74, 0.223, "Total Amount Paid:", 12, self.font)
        # self.right_text(0.74, 0.223, ':', 12, self.font)
        self.right_text(0.9, 0.223, f"${amount_paid}", 12, self.font)

        self.right_text(0.74, 0.204, "Balance Due:", 12, self.font)
        # self.right_text(0.74, 0.204, ':', 12, self.font)
        self.right_text(0.9, 0.204, "$0.00", 12, self.font)



        self.font = "Times-Bold"

        self.c.drawImage('./config/GreaterWesternSmallBlackAndWhite.jpg', 0.12 * w, 0.001 * h, 0.29 * w, 0.26 * h)

# item_codes, desc, prices, qtys, subtotals
    def invoice_line(self, item_codes, item_descs, item_prices, qtys, subtotals):
        c = 0
        for i in item_codes:
            self.text(0.065, 0.67-0.03*c, str(i), 12, self.font)
            c += 1

        c = 0
        for i in item_descs:
            self.text(0.185, 0.67-0.03*c, str(i), 12, self.font)
            c += 1

        c = 0
        for i in item_prices:
            # if len(str(i).split('.')[1]) == 1:
            #     i = str(i) + '0'
            self.right_text(0.66, 0.67-0.03*c, str(i), 12, self.font)
            c += 1

        c = 0
        for i in qtys:
            self.text(0.685, 0.67 - 0.03 * c, str(i), 12, self.font)
            c += 1

        c = 0
        for i in subtotals:
            # if len(str(i).split('.')[1]) == 1:
            #     i = str(i) + '0'
            self.right_text(0.9, 0.67 - 0.03 * c, str(i), 12, self.font)
            c += 1


    def text(self, x, y, string, size, font):
        self.c.setFont(font, size)
        self.c.drawString(x * w, y * h, string)

    def right_text(self, x, y, string, size, font):
        self.c.setFont(font, size)
        self.c.drawRightString(x * w, y * h, string)

    def receiptNo(self, invoice_no):
        self.text(0.65, 0.855, str(invoice_no), 12, self.font)

    def receiptDate(self, date):
        self.text(0.83, 0.855, date, 12, self.font)

    def memberName(self, name):
        self.text(0.05, 0.785, name, 12, self.font)

    def streetAdress(self, address):
        self.text(0.05, 0.77, str(address), 12, self.font)

    def cityStatePostCode(self, city, state, postCode):
        self.text(0.05, 0.755, f"{city}, {state}, {postCode}", 12, self.font)

    def save(self, path):
        origPath = os.getcwd()
        os.chdir(path)
        self.c.showPage()
        self.c.save()
        os.chdir(origPath)




#
# invoice = ReceiptGenerator("receipt_class_test4.pdf", 120.0, 70.0, 50.0, 120.0)
# invoice.receiptNo(95643)
# invoice.receiptDate("12/12/12")
# invoice.memberName("Shaun Simons")
# invoice.invoice_line([1, 2],['Membership', 'Fine'], [100.0, 20.0], [1, 1], [100.0, 20.0])
#
# invoice.save('.')
#
