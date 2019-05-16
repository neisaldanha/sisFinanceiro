<?php

namespace sistemaLaravel;

use Illuminate\Database\Eloquent\Model;

class Entrada extends Model
{
   protected $table = 'entrada';
    protected $primaryKey = 'identrada';

    public $timestamps = false;
    protected $fillable = [

    'idfornecedor',
    'tipo_comprovante',
    'serie_comprovante',
    'num_comprovante',
    'data_hora',
    'taxa',
    'estado'

    ];

    protected $guarded = [];
}