from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import A4

import os


w, h = A4



class CommiteeReportGenerator:
    def __init__(self, pdf_name, report_date, report_period):
        self.y = 0.73
        self.income_total = 0
        self.expense_total = 0
        self.font = "Times-Roman"
        self.font_bold = "Times-Bold"
        self.c = canvas.Canvas(pdf_name, A4)
        self.text(0.08, 0.9, 'GREATER WESTERN 4X4 CLUB COMMITTEE REPORT', 20, self.font_bold)
        self.text(0.1, 0.85, f'Report Date: {report_date}', 12, self.font_bold)
        self.text(0.1, 0.83, f'Report Period: {report_period}', 12, self.font_bold)

        self.text(0.1, 0.78, 'REVENUE SUMMARY', 15, self.font_bold)
        self.text(0.1, 0.75, 'Item Description', 15, self.font_bold)
        self.text(0.8, 0.75, 'Amount ($)', 15, self.font_bold)


    def text(self, x, y, string, size, font):
        self.c.setFont(font, size)
        self.c.drawString(x * w, y * h, string)

    def right_text(self, x, y, string, size, font):
        self.c.setFont(font, size)
        self.c.drawRightString(x * w, y * h, string)

    def incomes_list(self, incomes):

        for i in incomes:
            self.text(0.1, self.y, i[0], 12, self.font)
            self.right_text(0.9, self.y, str(i[1]), 12, self.font)
            self.income_total += i[1]
            self.y -= 0.017
            if self.y < 0.1:
                self.c.showPage()
                self.y = 0.9
        self.y -= 0.017
        self.text(0.1, self.y, 'TOTAL INCOME', 12, self.font_bold)
        self.right_text(0.9, self.y, str(self.income_total), 12, self.font_bold)
        self.section_break(line=True)

    def expenses_list(self, expenses):
        self.text(0.1, self.y, 'EXPENDITURE SUMMARY', 15, self.font_bold)
        self.y -= 0.03
        self.text(0.1, self.y, 'Item Description', 15, self.font_bold)
        self.text(0.8, self.y, 'Amount ($)', 15, self.font_bold)
        self.y -= 0.017

        for i in expenses:
            self.text(0.1, self.y, i[0], 12, self.font)
            self.right_text(0.9, self.y, str(i[1]), 12, self.font)
            self.expense_total += i[1]
            self.y -= 0.017
            if self.y < 0.1:
                self.c.showPage()
                self.y = 0.9
        self.y -= 0.017
        self.text(0.1, self.y, 'TOTAL EXPENDITURE', 12, self.font_bold)
        self.right_text(0.9, self.y, str(self.expense_total), 12, self.font_bold)
        self.section_break(line=True)
        self.net_profit()

    def year_to_date_summary(self, incomes, expenses):
        self.text(0.1, self.y, 'YEAR-TO-DATE REVENUE SUMMARY', 15, self.font_bold)
        self.y -= 0.03

        self.text(0.1, self.y, 'Item Description', 15, self.font_bold)
        self.text(0.8, self.y, 'Amount ($)', 15, self.font_bold)
        self.y -= 0.017
        self.income_total = 0
        for i in incomes:
            self.text(0.1, self.y, i[0], 12, self.font)
            self.right_text(0.9, self.y, str(i[1]), 12, self.font)
            self.income_total += i[1]
            self.y -= 0.017
            if self.y < 0.1:
                self.c.showPage()
                self.y = 0.9
        self.y -= 0.017
        self.text(0.1, self.y, 'TOTAL INCOME YEAR-TO-DATE', 12, self.font_bold)
        self.right_text(0.9, self.y, str(self.income_total), 12, self.font_bold)
        self.section_break(line=True)

        self.text(0.1, self.y, 'YEAR-TO-DATE EXPENDITURE SUMMARY', 15, self.font_bold)
        self.y -= 0.03

        self.text(0.1, self.y, 'Item Description', 15, self.font_bold)
        self.text(0.8, self.y, 'Amount ($)', 15, self.font_bold)
        self.y -= 0.017
        self.expense_total = 0
        for i in expenses:
            self.text(0.1, self.y, i[0], 12, self.font)
            self.right_text(0.9, self.y, str(i[1]), 12, self.font)
            self.expense_total += i[1]
            self.y -= 0.017
            if self.y < 0.1:
                self.c.showPage()
                self.y = 0.9
        self.y -= 0.017
        self.text(0.1, self.y, 'TOTAL EXPENDITURE YEAR-TO-DATE', 12, self.font_bold)
        self.right_text(0.9, self.y, str(self.expense_total), 12, self.font_bold)
        self.section_break(line=True)

        self.net_profit()


    def net_profit(self):
        self.text(0.1, self.y, 'NET PROFIT', 12, self.font_bold)
        self.right_text(0.9, self.y, str(self.income_total-self.expense_total), 12, self.font_bold)
        self.section_break(line=True)

    def section_break(self, line=False):
        if self.y - 0.03 < 0.1:
            self.c.showPage()
            self.y = 0.9
        else:
            self.y -= 0.03
            if line:
                self.c.line(0.1 * w, self.y * h, 0.9 * w, self.y * h)
            self.y -= 0.03

    def unpaid_invoices(self, unpaid_list):
        self.text(0.1, self.y, 'UNPAID INVOICES', 15, self.font_bold)
        self.y -= 0.03
        self.text(0.1, self.y, 'Invoice No', 15, self.font_bold)
        self.text(0.3, self.y, 'Member Name', 15, self.font_bold)
        self.text(0.6, self.y, 'Due Date', 15, self.font_bold)
        self.text(0.8, self.y, 'Total Due', 15, self.font_bold)
        self.y -= 0.017

        for i in unpaid_list:
            self.text(0.1, self.y, str(i[0]), 12, self.font)
            self.text(0.3, self.y, str(i[1]), 12, self.font)
            self.text(0.6, self.y, str(i[2]), 12, self.font)
            self.right_text(0.9, self.y, str(i[3]), 12, self.font)
            self.y -= 0.017
            if self.y < 0.1:
                self.c.showPage()
                self.y = 0.9
        self.section_break(line=True)

    def current_balances(self, balances):
        self.text(0.1, self.y, 'CURRENT BALANCES', 15, self.font_bold)
        self.y -= 0.03
        self.text(0.1, self.y, 'Cash Balance:', 12, self.font_bold)
        self.right_text(0.9, self.y, str(balances[0]), 12, self.font)
        self.y -= 0.017
        self.text(0.1, self.y, 'Bank Balance:', 12, self.font_bold)
        self.right_text(0.9, self.y, str(balances[1]), 12, self.font)
        self.section_break(line=True)

    def draw_image(self):
        self.y -= 0.015
        self.text(0.1, self.y, 'Closing Balances for Last 6 Months', 15, self.font_bold)
        self.y -= 0.015
        a = 0.7
        b = a/2.3
        if self.y - b < 0.05:
            self.c.showPage()
            self.y = 0.9
            self.c.drawImage('bar_closing.png', 0.05 * w, (self.y * h) - (b * h), 0.75 * w, b * h)
        else:
            self.c.drawImage('bar_closing.png', 0.05 * w, (self.y * h) - (b * h), 0.75 * w, b * h)

    def save(self, path):
        origPath = os.getcwd()
        os.chdir(path)
        self.c.showPage()
        self.c.save()
        os.chdir(origPath)


# report = CommiteeReportGenerator('commitee_test.pdf', '17-12-19', '01-11-19 to 31-11-19')
# report.save('.')
