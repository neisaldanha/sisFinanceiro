<?php

namespace sistemaLaravel;

use Illuminate\Database\Eloquent\Model;

class Produto extends Model
{
    protected $table = 'produto';
    protected $primaryKey = 'idproduto';

    public $timestamps = false;
    protected $fillable = [

    'idcategoria',
    'codigo',
    'nome',
    'estoque',
    'descricao',
    'imagem',
    'estado'

    ];

    protected $guarded = [];
}
