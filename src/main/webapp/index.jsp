<%--
  Created by IntelliJ IDEA.
  User: yarra
  Date: 20/11/13
  Time: 21:07
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>Sentiment Analysis Application</title>

	<link href='http://fonts.googleapis.com/css?family=Open+Sans:400italic,600italic,700italic,400,700,600' rel='stylesheet'
		  type='text/css'>
	<link href="css/ui-lightness/jquery-ui-1.10.3.custom.css" rel="stylesheet">
	<link href="css/style.css" rel="stylesheet">
	<script src="js/jquery-1.9.0.js"></script>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.2/jquery.min.js"></script>
	<script src="//ajax.googleapis.com/ajax/libs/jqueryui/1.10.3/jquery-ui.min.js"></script>
	<script src="js/jquery-ui-1.10.0.custom.js"></script>

	<script type="text/javascript" src="js/plugins/jqplot.canvasTextRenderer.min.js"></script>
	<script type="text/javascript" src="js/plugins/jqplot.canvasAxisLabelRenderer.min.js"></script>
	<link class="include" rel="stylesheet" type="text/css" href="js/jquery.jqplot.min.css"/>
	<script class="include" type="text/javascript" src="js/jquery.jqplot.min.js"></script>

	<script type="text/javascript">


		$(document).ready(function () {
			$(".datepicker").datepicker({ dateFormat: 'yy-mm-dd' });
		});

		$(document).ready(function() {
			$('#start_analysis').click(function(event) {
				start_analysis(function (rowCount) {

					var searchText = document.getElementById("company_name").value;
					var start = $("#begin").datepicker('getDate');
					var end = $("#end").datepicker('getDate');

					$.get('startSentimentAnalysis',{searchText:searchText, end:end, start:start},function(responseText) {

						var table = document.getElementById("result_table");

						console.log(parseInt(table.rows[1].cells[0].innerHTML));

						for (var i = 0, row; row = table.rows[i]; i++) {
							if (parseInt(table.rows[i].cells[0].innerHTML) == rowCount) {
								table.rows[i].cells[4].innerHTML = responseText;
							}
						}

						console.log(responseText);
					});
				});

			});
		});

		function start_analysis(callback) {
			var table = document.getElementById("result_table");
			var name = document.getElementById("company_name").value;
			var begin = document.getElementById("begin").value;
			var end = document.getElementById("end").value;

			if (name == null || name == "" || begin == null || begin == "" || end == null || end == "") {
				alert("Please fill out all input fields!");
				return false;
			}

			var rowCount = table.rows.length;
			var row = table.insertRow(rowCount);

			var cell0 = row.insertCell(0);
			cell0.innerHTML = rowCount;

			var cell1 = row.insertCell(1);
			cell1.innerHTML = name;

			var cell2 = row.insertCell(2);
			cell2.innerHTML = begin;

			var cell3 = row.insertCell(3);
			cell3.innerHTML = end;

			var cell4 = row.insertCell(4);
			cell4.innerHTML = "pending...";

			callback(rowCount);
		}
	</script>

</head>

<body>


<div id="container">
	<div id="container_inner">

		<div id="header">
			<div id="logo">
				<img src="img/twit.png" width="64" height="64" alt=""/>
			</div>
			<div id="heading">
				<h1>Twitter Sentiment Analysis</h1>
			</div>
			<div class="clear"></div>
		</div>

		<div id="content_upper">


			<div id="analysis_information_wrapper">
				<h2>Enter Information for Analysis:</h2>

					<table id="analysis_information">
						<tr>
							<td><label>Company name:</label></td>
							<td><input type="text" id="company_name" value=""/></td>
						</tr>
						<tr>
							<td><label>Begin: </label></td>
							<td><input type="text" id="begin" name="begin" class="datepicker" value=""/></td>
						</tr>
						<tr>
							<td><label>End: </label></td>
							<td><input type="text" id="end" name="end" class="datepicker" value=""/></td>
						</tr>
					</table>
					<div><input id="start_analysis" class="nice_but" value="Post Greeting" /></div>


			</div>
			<div class="clear"></div>
		</div>
		<!-- content upper div -->


		<div id="results_wrapper">
			<h2>Results:</h2>

			<div id="result_table_wrapper">
				<table id="result_table" border="1">
					<tr>
						<th>ID</th>
						<th>Company Name</th>
						<th>Start Date</th>
						<th>End Date</th>
						<th>Analysis Result</th>
					</tr>
				</table>


			</div>


			<div id="chart_wrapper">
				<div id="chart1" class="plot" style="width:470px;height:470px;">
				</div>
			</div>
			<!-- chart_wrapper div -->

			<div class="clear"></div>
		</div>
		<!-- results_wrapper div -->
	</div>
</div>

</body>
</html>