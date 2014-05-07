// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require jquery-1.11.1
//= require_tree .

function buscacep(){
	if($.trim($("#cep").val()) != ""){
		$("#lcep").html("Pesquisando...") //mostra na viw do from uma menssagem
		$.getScript("http://cep.republicavirtual.com.br/web_cep.php?formato=javascript&cep="+ $("#cep").val(),function(){
			if(resultadoCEP["resultado"] == "1"){
				$("#endereco").val(unescape(resultadoCEP["tipo_logradouro"]) + "," + unescape(resultadoCEP["logradouro"]));
				$("#bairro").val(unescape(resultadoCEP["bairro"]));
				$("#cidade").val(unescape(resultadoCEP["cidade"]));
				$("#estado").val(unescape(resultadoCEP["uf"]));;

				$("#numero").focus();
			}
			else{
				$("#lcep").html("Cep não encotrado.");
				$("#cep").focus();
			}	
			$("#lcep").html(" ")	});	
		}	
	else{			
    $("#lcep").html("CEP foi encontrado ");	
	}
}

function limpacampos(){
	$("#endereco").val("");
	$("#bairro").val("");
	$("#cidade").val("");
	$("#estado").val("");
}

function pessoaf(value) {
  $("#pf").show();
  $("#pf_dados").show();
  $("#pj").hide();
  $("#pj_dados").hide();
}

function pessoaj () {
  $("#pj").show();
  $("#pj_dados").show();
  $("#pf").hide();
  $("#pf_dados").hide();
}
