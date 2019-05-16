<?php

namespace sistemaLaravel\Http\Controllers;

use Illuminate\Http\Request;
use sistemaLaravel\Venda;
use sistemaLaravel\DetalheVenda;
use Illuminate\Support\Facades\Redirect;
use sistemaLaravel\Http\Requests\VendaFormRequest;
use DB;

use Carbon\Carbon;
use Response;
use Illuminate\Support\Collection;


class VendaController extends Controller
{
    public function __construct(){
    	$this->middleware('auth');
    }

    public function index(Request $request){

    	if($request){
    		$query=trim($request->get('searchText'));
    		$vendas = DB::table('venda as v')
    		->join('pessoa as p', 'v.idcliente', '=', 'p.idpessoas')
    		->join('detalhe_venda as dv', 'v.idvenda', '=', 'dv.idvenda')
    		->select('v.idvenda', 'v.data_hora', 'p.nome', 'v.tipo_comprovante', 'v.serie_comprovante', 'v.num_comprovante', 'v.taxa', 'v.estado', 'v.total_venda')
            ->where('estado', '=', 'A')
    		->where('v.num_comprovante', 'LIKE', '%'.$query.'%')
    		
    		->orderBy('v.idvenda', 'desc')
    		
    		->paginate(7);

    		return view('venda.venda.index', [
    			"vendas"=>$vendas, "searchText"=>$query
    			]);
    	}
    }

    public function create(){
    	$pessoas=DB::table('pessoa')
    	->where('tipo_pessoa', '=', 'Cliente')->get();
    	$produtos=DB::table('produto as pro')
    	->join('detalhe_entrada as de', 'pro.idproduto', '=', 'de.idproduto')
    	->select(DB::raw('CONCAT(pro.nome, "   -   ", pro.codigo) As produto'), 'pro.idproduto', 'pro.estoque', 
    		DB::raw('avg(de.preco_venda) as preco_medio'))
    	->where('pro.estado', '=', 'Ativo')
    	->where('pro.estoque', '>', '0')
    	->groupBy('produto', 'pro.idproduto', 'pro.estoque')
    	->get();
    	return view("venda.venda.create", ["pessoas"=>$pessoas, "produtos"=>$produtos]);
    }
 
    public function store(VendaFormRequest $request){

    	try{
    		DB::beginTransaction();
	    	$venda = new Venda;
	    	$venda->idcliente=$request->get('idcliente');
	    	$venda->tipo_comprovante=$request->get('tipo_comprovante');
	    	$venda->serie_comprovante=$request->get('serie_comprovante');
	    	$venda->num_comprovante=$request->get('num_comprovante');
	    	$mytime = Carbon::now('America/Sao_Paulo');
	    	$venda->data_hora=$mytime->toDateTimeString();
	    	$venda->total_venda=$request->get('total_venda');
	    	$venda->taxa='0';
	    	$venda->estado='A';
	    	$venda->save();
    	
	    	$idproduto=$request->get('idproduto');
	    	$quantidade=$request->get('quantidade');
	    	$desconto=$request->get('desconto');
	    	$preco_venda=$request->get('preco_venda');

	    	$cont = 0;
	    	while($cont < count($idproduto)){
	    		$detalhe = new DetalheVenda();
	    		$detalhe->idvenda=$venda->idvenda;
	    		$detalhe->idproduto=$idproduto[$cont];
	    		$detalhe->quantidade=$quantidade[$cont];
	    		$detalhe->desconto=$desconto[$cont];
	    		$detalhe->preco_venda=$preco_venda[$cont];
	    		$detalhe->save();
	    		$cont=$cont+1;
	    	}

	    	DB::commit();

    	

    		

    	}catch(\Exception $e){
    		DB::rollback();
    	}

    	return Redirect::to('venda/venda');

    }

    public function show($id){

    	$venda=DB::table('venda as v')
    		->join('pessoa as p', 'v.idcliente', '=', 'p.idpessoas')
    		->join('detalhe_venda as dv', 'v.idvenda', '=', 'dv.idvenda')
    		->select('v.idvenda', 'v.data_hora', 'p.nome', 'v.tipo_comprovante', 'v.serie_comprovante', 'v.num_comprovante', 'v.taxa', 'v.estado', 'v.total_venda')
    		->where('v.idvenda', '=', $id)
            
            ->first();


    		$detalhes=DB::table('detalhe_venda as d')
    		->join('produto as p', 'd.idproduto', '=', 'p.idproduto' )
    		->select('p.nome as produto', 'd.quantidade', 'd.desconto', 'd.preco_venda')
    		->where('d.idvenda', '=', $id)
    		->get();


    	return view("venda.venda.show", 
          		["venda"=>$venda, "detalhes"=>$detalhes]);
    }

    

    public function destroy($id){
    	$venda=Venda::findOrFail($id);
    	$venda->estado='C';
    	$venda->update();
    	return Redirect::to('venda/venda');
    }
}
