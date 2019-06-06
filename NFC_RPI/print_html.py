#!/usr/bin/python
# -*- coding: utf-8 -*-
# print_html.py
f = open('web/index.html','w')
message = """<html>
<head>
<meta charset="utf-8">
<meta http-equiv='cache-control' content='no-cache'>
<meta http-equiv='expires' content='0'>
<meta http-equiv='pragma' content='no-cache'>
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>
<meta http-equiv="content-type" content="text/html; charset=utf-8"/>
<meta name="apple-mobile-web-app-capable" content="yes"/>



        <link href="css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
        <script src="css/bootstrap.min.js"></script>
        <script src="css/jquery-1.11.1.min.js"></script>
        <link rel="stylesheet" href="css/styles.css">
        <!------ Include the above in your HEAD tag ---------->
</head>
<body>

<!-- sidebar -->

	<nav class="navbar navbar-default sidebar" role="navigation">
	    <div class="container-fluid">
	    <div class="navbar-header">
	      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-sidebar-navbar-collapse-1">
		<span class="sr-only">Toggle navigation</span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
		<span class="icon-bar"></span>
	      </button>      
	    </div>
	    <div class="collapse navbar-collapse" id="bs-sidebar-navbar-collapse-1">
	      <ul class="nav navbar-nav">
		<li class="active"><a href="/">Início<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-home"></span></a></li>
		<li><a href="cadastro.html">Cadastro<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-user"></span></a>
		</li>          
		<li ><a href="#">Libros<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-th-list"></span></a></li>        
		<li ><a href="status.html">Status<span style="font-size:16px;" class="pull-right hidden-xs showopacity glyphicon glyphicon-tags"></span></a></li>
	      </ul>
	    </div>
	  </div>
	</nav>

<!-- sidebar -->

	<div class="container">
		<div class="row">

			<section class="content">
				<h1>Controle de Acesso com Rpi</h1>
				<div class="col-md-8 col-md-offset-2">
					<div class="panel panel-default">
						<div class="panel-body">
							<div class="pull-right">
								<div class="btn-group">
									<button type="button" class="btn btn-success btn-filter" data-target="ALUNOS">ALUNOS</button>
									<button type="button" class="btn btn-warning btn-filter" data-target="FUNCIONARIOS">FUNCIONARIOS</button>
									<button type="button" class="btn btn-danger btn-filter" data-target="OUTROS">OUTROS</button>
									<button type="button" class="btn btn-default btn-filter" data-target="all">TODOS</button>
								</div>

							</div>
							<div class="table-container">
								<table class="table table-filter">
									<tbody id=content_div_id>
									</tbody>
								</table>
							</div>
						</div>
					</div>
					<div class="content-footer">
						<p>Fatec Sao Caetano do Sul - Antonio Russo
							 <br>
							 <a href="#" target="_blank">Projeto de Graduação - 2019</a>
							 <br>
							 <a href="#" target="_blank">Orientador Prof: <b>Ismael Parede</b></a>
						</p>
					</div>
				</div>
			</section>
			
		</div>
	</div>



</body>

<script type="text/javascript">
function cache_clear() {
  window.location.reload(true);
  // window.location.reload(); use this if you do not remove cache
}

$(document).ready(function () {

  setInterval(function() {
    cache_clear()
  }, 10000);
  
$.get('temp.tmp', function(data) {
        $('#content_div_id').html(data);    
    });

	$('.star').on('click', function () {
      $(this).toggleClass('star-checked');
    });

    $('.ckbox label').on('click', function () {
      $(this).parents('tr').toggleClass('selected');
    });

    $('.btn-filter').on('click', function () {
      var $target = $(this).data('target');
      if ($target != 'all') {
        $('.table tr').css('display', 'none');
        $('.table tr[data-status="' + $target + '"]').fadeIn('slow');
      } else {
        $('.table tr').css('display', 'none').fadeIn('slow');
      }
    });

 });
</script>

</html>"""

f.write(message)
f.close()

