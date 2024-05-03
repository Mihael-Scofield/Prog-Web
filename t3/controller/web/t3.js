let canvas;
let ctx; // Contexto do Canvas
let vertices = [{ ini_x: 350, ini_y: 375, fim_x: 650, fim_y: 375, cor: "#ca161f" }]; // Linha inicial da primeira especificacao

/*
=============================== 
Variaveis de controle globais
===============================
*/

let verticeAtual = null;
let interacao = null;
let ehPlotavel = false;
let indexCor = 4;

/* Responsavel por carregar a tela em seu momento de carregamento */
window.onload = function () {
    canvas = document.getElementById('idCanvas');
    ctx = canvas.getContext('2d');
    criaLinha();
    
    canvas.addEventListener('contextmenu', function (e) {
        e.preventDefault();
    }, false);
}

/* Função intermediária que faz a verificação de onde foi clicado */
function verificarPonto(ponto, ini, fim) {
    const menor = Math.min(ini, fim);
    const maior = Math.max(ini, fim);
    return (ponto >= menor && ponto <= maior + 10);
}

/* Checa o ponto da linha onde foi clicado */
function verifcaLinha(x, y) {
    // Verificacao do ponto inicial
    vertices.forEach ((reta, index) => {
        if (((x >= reta.ini_x) && (x <= reta.ini_x + 40)) && (((y >= reta.ini_y) && (y <= reta.ini_y + 40)) || ((y <= reta.ini_y) && (y >= reta.ini_y - 40)))) {
            interacao = 0;
            verticeAtual = index;
            return;
        }
        
        // Verificacao do ponto final
        if (((x <= reta.fim_x) && (x >= reta.fim_x - 40)) && (((y >= reta.fim_y) && (y <= reta.fim_y + 40)) || ((y <= reta.fim_y) && (y >= reta.fim_y - 40)))) {
            interacao = 1;
            verticeAtual = index;
            return;
        }
       
        // Verificacao do ponto mediano
        const meio_x = (reta.ini_x + reta.fim_x) / 2;
        const meio_y = (reta.ini_y + reta.fim_y) / 2;
        if (((x >= meio_x) && (x <= meio_x + 20) || (x <= meio_x) && (x >= meio_x - 20)) && (((y >= meio_y) && (y <= meio_y + 40)) || ((y <= meio_y) && (y >= meio_y - 40)))) {
            interacao = 2;
            verticeAtual = index;
            return;
        }
    })

    return null;
}

/*
Verifica a natureza do clique do usuario
0 === Botao esquerdo
2 === Botao direito
*/
function clicando(event) {
    // Apenas registra as coordenadas
    const mouseX = event.clientX - canvas.offsetLeft;
    const mouseY = event.clientY - canvas.offsetTop;
    if(event.button === 0) {   
        verifcaLinha(mouseX, mouseY);
        if (interacao !== null) {
            ehPlotavel = true;
        }
    }
    else if (event.button === 2) {
        separarVetor(mouseX, mouseY);
    }
}

/* Ira interagir no momento que o usuario soltar o botao do mouse */
function soltando() {
    interacao = null;
    ehPlotavel = false;
    verticeAtual = null;
}

/* Funcao que ira interagir enquanto o usuario estiver movendo o mouse, independente do clique ou nao */
function movendo(event) {
    if (ehPlotavel) {
        const mouseX = event.clientX - canvas.offsetLeft;
        const mouseY = event.clientY - canvas.offsetTop;
        
        if (interacao === 0) { // Apenas inicio
            vertices[verticeAtual].ini_x = mouseX;
            vertices[verticeAtual].ini_y = mouseY;
        } else if (interacao === 1) { // Apenas fim
            vertices[verticeAtual].fim_x = mouseX;
            vertices[verticeAtual].fim_y = mouseY;
        } else if (interacao === 2) { // Linha inteira
            const meio_x = (vertices[verticeAtual].ini_x + vertices[verticeAtual].fim_x) / 2;
            const meio_y = (vertices[verticeAtual].ini_y + vertices[verticeAtual].fim_y) / 2;
            const deltaX = mouseX - meio_x;
            const deltaY = mouseY - meio_y;
            vertices[verticeAtual].ini_x += deltaX;
            vertices[verticeAtual].ini_y += deltaY;
            vertices[verticeAtual].fim_x += deltaX;
            vertices[verticeAtual].fim_y += deltaY;
        }
        
        // Plotagem
        criaLinha();
    }
}

/* Divide um vetor em 2 */
function separarVetor(x, y) {
    vertices.forEach((reta, index) => {
        // Verificacao se eh ponto mediano
        if (verificarPonto(x, reta.ini_x, reta.fim_x) && verificarPonto(y, reta.ini_y, reta.fim_y)) {
            vertices.push({ ini_x: x , ini_y: y , fim_x: vertices[index].fim_x, fim_y: vertices[index].fim_y, cor: setaCor() });
            
            vertices[index].fim_x = x;
            vertices[index].fim_y = y;
            
            criaLinha();
            soltando();
        }
    });
}

/* Funcao intermediaria que faz a verificacao de onde foi clicado */
function criaLinha() {
    ctx.clearRect(0, 0, canvas.width, canvas.height);
    
    // Desenha uma linha para cada reta cadastrado no vetor de vertices
    vertices.forEach(reta => {
        ctx.beginPath();
        ctx.moveTo(reta.ini_x, reta.ini_y);
        ctx.lineTo(reta.fim_x, reta.fim_y);
        ctx.lineWidth = 10;
        ctx.lineCap = "round";
        ctx.strokeStyle = reta.cor;
        ctx.stroke();
    });
}

/* Seleciona, ciclicamente, qual cor sera utilizada */
function setaCor() {
    const cores = ["#ca161f", "#92278e", "#3ab54a", "#ffcc01", "#00adef", "#ee2b79", "#662e91", "#f7951d"];
    return cores[indexCor++ % cores.length];
}

/* Interage com o usuario sobre qual poligono sera criado */
function poligono() {
    const lados = parseInt(window.prompt("Quantos lados? (entre 3 e 8)"));
    if (!isNaN(lados) && lados >= 3 && lados <= 8
) {
        geraPoligono(lados);
        criaLinha();
    } else {
        window.alert("Número inválido");
    }
}

/* Cria o poligono em si */
function geraPoligono(lados) {
    const tamanhoLado = 195; // Aumentei o tamanho do lado do polígono inicial
    const pontoSuperior = { x: 450, y: 300 };
    const vetorVertices = [];

    for (let i = 0; i < lados; i++) {
        const angulo = 2 * Math.PI * i / lados;
        const x = pontoSuperior.x + tamanhoLado * Math.sin(angulo);
        const y = pontoSuperior.y + tamanhoLado * (1 - Math.cos(angulo));
        vetorVertices.push({ x, y });
    }

    for (let i = 0; i < lados; i++) {
        const ini = vetorVertices[i];
        const fim = vetorVertices[(i + 1) % lados];
        vertices.push({ ini_x: ini.x, ini_y: ini.y, fim_x: fim.x, fim_y: fim.y, cor: setaCor() });
    }
}

/* Limpa os vetores, isto eh, limpa a tela */
function reiniciarQuadro() {
    interacao = null;
    ehPlotavel = false;
    verticeAtual = null;
    vertices = [];
    ctx.clearRect(0, 0, canvas.width, canvas.height);
}
