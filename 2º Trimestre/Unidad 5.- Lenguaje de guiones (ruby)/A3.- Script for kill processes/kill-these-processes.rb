#!/usr/bin/ruby
#Encoding: utf-8

#Antonio Hernandez Dominguez-Script eliminar determinados procesos
#Script para OpenSUSE

system("clear")

#Especificamos que vamos a hacer uso de la gema "Rainbow"
require 'rainbow'

#Comprobamos usuario root
usuario=`whoami`
quiensoy=usuario.chop

if quiensoy=="root" then
	puts "EMPIEZA EL SCRIPT"
	puts "-"*50
else
	puts "PERMISO DENEGADO, NO ERES USUARIO ROOT"
	puts "TERMINA EL SCRIPT"
	exit
end

#Cargamos los nobmres de los procesos en el array
software=`cat processes-black-list.txt`
list=software.split("\n")

#Tenemos filas con 2 campos a separar, haremos uso de un bloque iterador
list.each do |processesname|
	fields = processesname.split(":")
	# Si se define en la lista negra que el proceso se debe eliminar
	if fields[1]=="remove" || fields[1]=="r"|| fields[1]=="kill"|| fields[1]=="k"
	
		#Comprobamos la situación del proceso, ¿está en ejecución?
		search=`ps -ef| grep #{fields[0]}| grep -v color`
	
		#Spliteamos el resultado para sacar cada fila
		searchpid=search.split("\n")
		
		#Definimos un nuevo iterador para que nos saque el número pid de cada proceso
		searchpid.each do |processespid|
			processespid=processespid.split(" ")
			
			puts "El proceso "+Rainbow("#{processespid[1]}").color(:green)+" está en ejecución, procedemos a eliminarlo"
			
			#Si el proceso en ejecución coincide con el que se pretende eliminar
			if fields[0] == processespid[7] then
				system("kill -9 PID #{processespid[1]}")
			end
			#Fin de la condición
		end
		#Fin del iterador
	end
	#Fin de la condición
	if fields[1]=="notify" || fields[1]=="n" then
		#Comprobamos la situación del proceso, ¿está en ejecución?
		search=`ps -ef| grep #{fields[0]}| grep -v color`
	
		#Spliteamos el resultado para sacar cada fila
		searchpid=search.split("\n")
		
		#Definimos un nuevo iterador para que nos saque el número pid de cada proceso
		searchpid.each do |processespid|
			processespid=processespid.split(" ")
			
			puts "El proceso "+Rainbow("#{processespid[1]}").color(:green)+" está en ejecución"
		end
	
	end
	#Fin de la condición
end
#Fin del iterador
puts "FIN DEL SCRIPT"


	#puts "El proceso "+{searchpid[1]}+" está en ejecución"
	
	#Si se especifica eliminarlo, comprobamops s primero si está en ejecución	
	#if fields[1]=="remove" || fields[1]=="r"|| fields[1]=="kill"|| fields[1]=="k"
	#	if search.count="" then
	#		puts "El proceso "+fields[0]+" no está en ejecución"			
	#	else
	#		puts "El proceso "+fields[0]+" está en ejecución, procedemos a eliminarlo"
	#		system("zypper --non-interactive rm #{fields[0]}")
	#	end
	
	#si se especifica notificar el estado, comprobamos que la situación del proceso
	#elsif fields[1]=="notify" || fields[1]=="n" then
	#	if search.count="" then
	#		puts "El proceso "+fields[0]+" está en ejecución"
	#		system("zypper --non-interactive in #{fields[0]}")
	#	else
	#		puts "El programa "+fields[0]+" no está en ejecución"
	#	end
	#end
#Fin del iterador
