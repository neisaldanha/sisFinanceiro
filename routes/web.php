<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| This file is where you may define all of the routes that are handled
| by your application. Just tell Laravel the URIs it should respond
| to using a Closure or controller method. Build something great!
|
*/

Route::get('/', function () {
    return view('auth/login');
});

Route::resource('estoque/categoria', 'CategoriaController');
Route::resource('estoque/produto', 'ProdutoController');
Route::resource('venda/cliente', 'ClienteController');
Route::resource('compra/fornecedor', 'FornecedorController');
Route::resource('compra/entrada', 'EntradaController');
Route::resource('venda/venda', 'VendaController');
Route::resource('seguranca/usuario', 'usuarioController');

Route::auth();
Auth::routes();

Route::get('/home', 'HomeController@index');

Route::get('/logout', 'Auth\LoginController@logout');
Route::get('/{slug?}', 'HomeController@index' );
