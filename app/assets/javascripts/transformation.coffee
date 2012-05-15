#COPY = []
#
#log = (text) ->
#  console.log text
#
#$ ->
#  log "Starting...."
#  for irow, i in W
#    log "\tStarting irow " + i
#    jtmp = []
#    for jrow, j in irow
#      log "\t\tStarting jrow " + j
#      ktmp = []
#      for krow, k in jrow
#        log "\t\t\tStarting krow " + k
#        ltmp = []
#        for lvalue, l in krow
#          ltmp.push(Math.round(lvalue * 1000) / 10)
##          ltmp.push(lvalue)
#        log "\t\t\tDone with ltmp. : " + l
#        ktmp.push(ltmp)
#      log "\t\tDone with ktmp.. : " + k
#      jtmp.push(ktmp)
#    log "\tDone with jtmp... : " + j
#    COPY.push(jtmp)
#  log "Done with itmp.... : " + i
#
#  alert "Printing..."
#  area = $('#area')
#  a = (text) ->
#    area.append(text)
#
#
#  printarea = ->
#    area = $('#area')
##    a = (text) ->
##      area.append(text)
#    a = "["
#    for irow, i in COPY
#      a += ("\n\t[")
#      for jrow, j in irow
#        a += ("\n\t\t[")
#        for krow, k in jrow[0..5]
#          a += ("\n\t\t\t[")
#          for lrow, l in krow
#            a += (lrow + (if l == krow.length - 1 then "" else ", "))
#          a += ("]" + (if k == jrow.length - 1 then "\n" else ", "))
#        a += ("\t\t]" + (if j == irow.length - 1 then "\n" else ", "))
#      a += ("\t]" + (if i == COPY.length - 1 then "\n" else ", "))
#    a += ("\n]")
#    area.append(a)
#
#  printarea()

#  worker = new Worker 'assets/javascripts/worker.js'
#  # listen for messages from the worker
#  worker.onmessage = (event) =>
#    # event.data holds the data passed FROM the worker
#    alert event.data
#    return
#  worker.postMessage "Some data? "

#  new Worker(printarea())



