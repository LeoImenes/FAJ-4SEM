class Partida{
    constructor(jogadorA, jogadorB, resultado){
        this.jogadorA ;
        this.jogadorB ;
        this.resultado = "";
    }

    iniciar(){
        this.jogadorA.jogar()
        this.jogadorB.jogar()
        console.log("Partida iniciada")
    }
    finalizar(pontosA, pontosB){
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
class Tenista{
    constructor(nome, rank){
        this.nome = nome;
        this.rank = rank;
    }
    nome = '';
    rank = 1000;
    
    jogar(){
        if(this.rank>1){
            this.rank --
        };
    };
    subir(){
        if(this.rank>100){
            this.rank = this.rank - 100;
        };
    };
    perder = function(){
        this.rank + 50;
    };

}

class PartidaDupla extends Partida{
    constructor(jogadorC, jogadorD){
        this.jogadorC = jogadorC;
        this.jogadorD = jogadorD;
    }
    iniciarjogoDupla(a,b,c,d){
    }
}

let bia = new Tenista("Bia",500);


 let logitech = new Tenista( "Logitech",1);

let partida = new Partida(bia,logitech,1);



function init(){
}

function fimPartida(){
    partida.iniciar();
    partida.finalizar(6,5);
}