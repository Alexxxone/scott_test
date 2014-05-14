$(document).ready ->
  if $('#cac').length
    customers_count = gon.customers_count
    total_amount = gon.total_amount
    charges_count = gon.charges_count
    charges = gon.charges
    total_user = gon.total_user
    months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ]
    i = 0
    cac_data = []
    max = 0
    now = -15
    while (i < 30)
      d = new Date();
      d.setDate(now);
      cac_data.push {date: d.getFullYear()+'-'+d.getMonth()+ '-'+ d.getDate(), amount: 0}
      now++;
      i++;
    cac_data.forEach (one_date,index)->
      charges.data.forEach (entry) ->
        date = new Date(entry.created*1000)
        if one_date.date is date.getFullYear()+'-'+date.getMonth()+ '-'+ date.getDate()
          max += entry.amount/100.00
          one_date['amount'] += entry.amount/100.00
          cac_data[index+1]['amount'] = one_date['amount'] if index isnt 29
    new Morris.Line
      element: 'cac'
      preUnits: '$'
      data: cac_data
      xkey: 'date'
      ykeys: ['amount']
      labels: ['Amount']
      smooth: false
      hideHover: true
      ymax: max+20
      xLabelFormat: (date)->
        y = Date.parse(date)
        new_date = new Date(y)
        months[new_date.getMonth()]+' '+new_date.getDate()
    $('.total_revenue').text('$ '+max)


    Customer_Churn = charges_count/total_user

    Customer_lifetime = 1/Customer_Churn







#    new Morris.Line
#      element: 'cac'
#      data: [
#        { year: '2008', value: 20 }
#        { year: '2009', value: 10 }
#        { year: '2010', value: 5 }
#        { year: '2011', value: 5 }
#        { year: '2012', value: 20 }
#      ]
#      xkey: 'year'
#      ykeys: ['value']
#      labels: ['Value']
