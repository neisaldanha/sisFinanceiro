<?php

namespace sistemaLaravel\Http\Controllers;

use Illuminate\Http\Request;
use sistemaLaravel\User;

use Illuminate\Support\Facades\Redirect;
use sistemaLaravel\Http\Requests\UsuarioFormRequest;
use DB;

class usuarioController extends Controller
{
    public function __construct(){
    	$this->middleware('auth');
    }

    public function index(Request $request){

    	if($request){
    		$query=trim($request->get('searchText'));
    		$usuarios=DB::table('users')
    		->where('name', 'LIKE', '%'.$query.'%')
    		
    		->orderBy('id', 'desc')
    		->paginate(7);
    		return view('seguranca.usuario.index', [
    			"usuarios"=>$usuarios, "searchText"=>$query
    			]);
    	}
    }


    public function create(){
    	return view("seguranca.usuario.create");
    }
 
    public function store(UsuarioFormRequest $request){
    	$usuario = new User;
    	$usuario->name=$request->get('name');
    	$usuario->email=$request->get('email');
    	$usuario->password=bcrypt($request->get('password'));
    	
    	$usuario->save();
    	return Redirect::to('seguranca/usuario');
    }

   
      public function edit($id){
    	return view("seguranca.usuario.edit", 
    		["usuario"=>User::findOrFail($id)]);
    }

    public function update(UsuarioFormRequest $request, $id){
    	$usuario=User::findOrFail($id);
    	$usuario->name=$request->get('name');
    	$usuario->email=$request->get('email');
    	$usuario->password=bcrypt($request->get('password'));
    	$usuario->update();
    	return Redirect::to('seguranca/usuario');
    }

    public function destroy($id){
    	$usuario=User::findOrFail($id);
    	$usuario = DB::table('users')->where('id', '=', $id)->delete();
    	return Redirect::to('seguranca/usuario');
    }


}
