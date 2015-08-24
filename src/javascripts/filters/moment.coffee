angular.module("app-filters")
  .filter "moment", ->
    (date, format) ->
      moment(date).format()
  .filter "recordDayOfMonth", ->
    (date) ->
      moment(date).format("DD")
  .filter "recordDayOfWeek", ->
    (date) ->
      moment(date).format("dd")
  .filter "recordStartOfMonth", ->
    (date) ->
      dateOfMonth = moment(date).format("DD")
      if dateOfMonth == "01"
        moment(date).format("MMM")
