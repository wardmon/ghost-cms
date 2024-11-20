import win32com.client
wpsApp=win32com.client.Dispatch("KET.Application")
wpsApp.Visible=1

xlBook = wpsApp.Workbooks.Add()

#选定工作簿中活动工作表的某个单元格
cell = xlBook.ActiveSheet.Cells(1,1)
#设置单元格的值
cell.Value='one'

xlBook.SaveAs(r"g:/HelloWorld.xls")
#xlBook.SaveAs("HelloWorld.xls")
xlBook.Close()
wpsApp.Quit()

del wpsApp