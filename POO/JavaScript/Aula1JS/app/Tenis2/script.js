function Partida(){
    this.jogadorA ;
    this.jogadorB ;
    this.resultado = "";

    this.iniciar = function(){
        this.jogadorA.jogar()
        this.jogadorB.jogar()
        console.log("Partida iniciada")
    }
    this.finalizar = function(pontosA, pontosB){
        if(pontosA==pontosB){
            alert("Empate")
        }
        else if (pontosA>pontosB){
            this.jogadorA.subir();
            this.jogadorB.perder();
            alert(`O jogador ${this.jogadorA.nome} ganhou `)
        }
        else{
            this. jogadorB.subir();
            this.jogadorA.perder();
            alert(`O jogador ${this.jogadorB.nome} ganhou `)
        }
    }
}
function Tenista(){
    this.nome = '';
    this.rank = 1000;
    this.jogar= function(){
        if(this.rank>1){
            this.rank --
        };
    };
    this.subir = function(){
        if(this.rank>100){
            this.rank = this.rank - 100;
        };
    };
    this.perder = function(){
        this.rank + 50;
    };

}
let bia = new Tenista;
 bia.nome = "Bia";
 bia.rank = 500;

 let logitech = new Tenista();
 logitech.nome = "Logitech";
 logitech.rank = 1;

let partida = new Partida;
partida.jogadorA = bia;
partida.jogadorB = logitech;



function init(){
}

function fimPartida(){
    partida.iniciar();
    partida.finalizar(6,5);
}