@extends('layouts.admin')
@section('conteudo')
<div class="row">
	<div class="col-lg-8 col-md-8 col-sm-8 col-xs-12">
		<h3>Lista de Vendas <a href="venda/create"><button class="btn btn-success">Novo</button></a></h3>
		@include('venda.venda.search')
	</div>
</div>

<div class="row">
	<div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
		<div class="table-responsive">
			<table class="table table-striped table-bordered table-condensed table-hover">
				<thead>
					<th>Data</th>
					<th>Cliente</th>
					<th>Tipo Comprovante</th>
					
					<th>Taxa</th>
					<th>Total</th>
					<th>Estado</th>
					<th>Opções</th>
				</thead>
               @foreach ($vendas as $ent)
				<tr>
					<td>{{$ent->data_hora}}</td>
					<td>{{$ent->nome}}</td>
					<td>{{$ent->tipo_comprovante. ' - ' .$ent->serie_comprovante. ' - ' .$ent->num_comprovante}}</td>
										
					<td>{{$ent->taxa}}</td>
					<td>{{$ent->total_venda}}</td>
					<td>{{$ent->estado}}</td>
										
					<td>
						<a href="{{URL::action('VendaController@show',$ent->idvenda)}}"><button class="btn btn-info">Detalhes</button></a>
                         <a href="" data-target="#modal-delete-{{$ent->idvenda}}" data-toggle="modal"><button class="btn btn-danger">Anular</button></a>
					</td>
				</tr>
				@include('venda.venda.modal')
				@endforeach
			</table>
		</div>
		{{$vendas->render()}}
	</div>
</div>
@stop