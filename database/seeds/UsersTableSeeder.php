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
          'name'     => 'Elcinei Saldanha',
          'email'    => 'neiac21@gmail.com',
          'password' => bcrypt('123456'),
        ]);
    }
}
