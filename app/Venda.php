<?php

namespace sistemaLaravel;

use Illuminate\Database\Eloquent\Model;

class Venda extends Model
{
    protected $table = 'venda';
    protected $primaryKey = 'idvenda';

    public $timestamps = false;
    protected $fillable = [

    'idcliente',
    'tipo_comprovante',
    'serie_comprovante',
    'num_comprovante',
    'data_hora',
    'taxa',
    'total_venda',
    'estado'

    ];

    protected $guarded = [];
}