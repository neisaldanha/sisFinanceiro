<?php

namespace sistemaLaravel;

use Illuminate\Database\Eloquent\Model;

class DetalheEntrada extends Model
{
    protected $table = 'detalhe_entrada';
    protected $primaryKey = 'iddetalhe_entrada';

    public $timestamps = false;
    protected $fillable = [

    'identrada',
    'idproduto',
    'quantidade',
    'preco_compra',
    'preco_venda'
    

    ];

    protected $guarded = [];
}
