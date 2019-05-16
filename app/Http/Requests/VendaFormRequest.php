<?php

namespace sistemaLaravel\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;
use sistemaLaravel\Http\Requests\Request;

class VendaFormRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
           'idcliente'=>'required',
           'tipo_comprovante'=>'required|max:20',
           'serie_comprovante'=>'required|max:20',
           'num_comprovante'=>'required|max:20',
           'idproduto'=>'required',
           'quantidade'=>'required',
           'preco_venda'=>'required',
           'desconto'=>'required',
           'total_venda'=>'required',
        ];
    }
}
