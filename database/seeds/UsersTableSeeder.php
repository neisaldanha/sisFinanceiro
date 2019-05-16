<?php

use Illuminate\Database\Seeder;
use sistemaLaravel\User;

class UsersTableSeeder extends Seeder
{
    /**
     * Run the database seeds.
     *
     * @return void
     */
    public function run()
    {
        User::create([
          'name'     => 'Usuario visitante',
          'email'    => 'visitante@visitante.com',
          'password' => bcrypt('123456'),
        ]);
    }
}
