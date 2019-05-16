<?php

namespace sistemaLaravel;

use Illuminate\Database\Eloquent\Model;

class DetalheVenda extends Model
{ 
	protected $table = 'detalhe_venda';
    protected $primaryKey = 'iddetalhe_venda';

    public $timestamps = false;
    protected $fillable = [

    'idvenda',
    'idproduto',
    'quantidade',
    'preco_venda',
    'desconto'
    

    ];

    protected $guarded = [];
}
