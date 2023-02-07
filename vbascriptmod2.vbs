Attribute VB_Name = "Module1"
Sub AlphabeticalTestingLoop():

' Create a script that loops through all the stocks for one year and outputs the following:
        
            ' Ticker
            ' Yearly change
            ' Percent change
            ' Total stock volume
            
Dim ws As Worksheet
For Each ws In ThisWorkbook.Worksheets
    
    ' Set initial variable for holding the ticker symbol
        Dim tickerSymbol As String
    
    ' Set an initial variable for holding the total stock volume
        Dim totalStockVolume As Double
        totalStockVolume = 0
        
    ' Set an initial variable for holding the yearly change
        Dim yearlyChange As Double
        yearlyChange = 0
        
    ' Set an initial variable for holding the percent change
        Dim percentChange As Double
        percentChange = 0
        
    ' Keep track of the location for each output in the summary table
        Dim SummaryTableRow As Integer
        SummaryTableRow = 2
        
    ' Loop through all stocks, 2 to last row
      LastRow = Cells(Rows.Count, 1).End(xlUp).Row
      For i = 2 To LastRow
    
        'Check if we are still in the same stock range, if not...
        If Cells(i + 1, 1).Value <> Cells(i, 1).Value Then
            
           ' Set ticker symbol
           tickerSymbol = Cells(i, 1).Value
           
           ' Compute the total stock volume
           totalStockVolume = totalStockVolume + Cells(i, 7).Value
           
           ' Compute the yearly change
           closePrice = Cells(i, 6).Value
           yearlyChange = closePrice - openPrice
           
            ' Compute the percent change ((closePrice - openPrice) / openPrice)
            percentChange = ((Cells(i, 6).Value) - (Cells(i, 3).Value)) / (Cells(i, 3).Value)
            
               ' Print the ticker symbol in the summary table
             Range("I" & SummaryTableRow).Value = tickerSymbol
               
               ' Print the total stock volume to the summary table
             Range("L" & SummaryTableRow).Value = totalStockVolume
               
               ' Print the yearly change to the summary table
             Range("J" & SummaryTableRow).Value = yearlyChange
               
               ' Print the percent change in the summary table
             Range("K" & SummaryTableRow).Value = percentChange
                Range("K:K").NumberFormat = "0.00%"
        
           ' Add one to the summary table row
           SummaryTableRow = SummaryTableRow + 1
          
           
           ' Reset the total stock volume
           totalStockVolume = 0

           
           Else
                
                ' Define open price
                openPrice = Cells(i, 3).Value
                
                ' Add to the total stock volume
                totalStockVolume = totalStockVolume + Cells(i, 7).Value
                
            End If
            
        Next i
        
 End Sub
 
 Sub functionality()
 
  ' Determine the following...
        
              ' Greatest percent increase
              ' Greatest percent decrease
              ' Greatest total volume
        
        ' Set an initial variable for holding the greatest percent increase (or max)
        Dim greatestPercentIncrease As Double
        greatestPercentIncrease = WorksheetFunction.Max(Range("K:K"))
        
            ' Print the greatest percent increase value in designated area
         Range("Q2").Value = greatestPercentIncrease
            Range("Q2").NumberFormat = "0.00%"
                
                    ' Match value to ticker symbol
                    Dim increaseMatch As String
                    increaseMatch = Application.Match(Range("Q2").Value, Range("K:K"), 0)
                    Range("P2").Value = Range("I" & increaseMatch)
                    
        ' Set an initial variable for holding the greatest percent decrease (or min)
    Dim greatestPercentDecrease As Double
    greatestPercentDecrease = WorksheetFunction.Min(Range("K:K"))

           ' Print the greatest percent decrease value in designated area
        Range("Q3").Value = greatestPercentDecrease
           Range("Q3").NumberFormat = "0.00%"
           
                   ' Match value to ticker symbol
                   Dim decreaseMatch As String
                   decreaseMatch = Application.Match(Range("Q3").Value, Range("K:K"), 0)
                   Range("P3").Value = Range("I" & decreaseMatch)
                    
          ' Set an initial variable for holding the greatest total volume (or max)
        Dim greatestTotalVolume As Double
        greatestTotalVolume = WorksheetFunction.Max(Range("L:L"))
        
            ' Print the greatest total volume value in designated area
          Range("Q4").Value = greatestTotalVolume
          
                ' Match value to ticker symbol
                    Dim volumeMatch As String
                    volumeMatch = Application.Match(Range("Q4").Value, Range("L:L"), 0)
                    Range("P4").Value = Range("I" & volumeMatch)
                    
                    
End Sub


Sub conditionalFormatting()

    LastRow = Cells(Rows.Count, 1).End(xlUp).Row
      For i = 2 To LastRow
      
      closePrice = Cells(i, 6).Value
      
   ' Change the color of the backgroud of negative values in the Yearly Change column to red. Change the positive values to green.
   If Range("closePrice").Value > 0 Then
        'change the background of that value to green
        Range("closePrice").Interior.ColorIndex = 4
        
    ElseIf Range("J:J").Value <= 0 Then
        'change the background of that value to red
        Range("J:J").Interior.ColorIndex = 3
        
    End If
    
   Next i
End Sub

