let dadosAlunos = [];
const alunosXml = "https://www.inf.ufpr.br/msa18/materials/web/alunos.xml";
let grrAtual = null;

window.onload = function () {
    const tabela = document.getElementById('tblGrade');
    tabela.addEventListener('contextmenu', e => e.preventDefault(), false);
    carregaDadosAlunos();
};

function carregaDadosAlunos() {
    const xhr = new XMLHttpRequest();
    xhr.open("GET", alunosXml, true);
    xhr.onreadystatechange = function () {
        if (xhr.readyState === 4 && xhr.status === 200) {
            const xmlData = xhr.responseXML;
            const alunos = xmlData.getElementsByTagName("ALUNO");

            for (let aluno of alunos) {
                const grr = aluno.getElementsByTagName("MATR_ALUNO")[0].textContent;
                let index = dadosAlunos.findIndex(a => a[0] === grr);

                if (index < 0) {
                    dadosAlunos.push([grr]);
                    index = dadosAlunos.length - 1;
                }

                dadosAlunos[index].push({
                    COD_ATIV_CURRIC: aluno.getElementsByTagName("COD_ATIV_CURRIC")[0].textContent,
                    SIGLA: aluno.getElementsByTagName("SIGLA")[0].textContent,
                    ANO: aluno.getElementsByTagName("ANO")[0].textContent,
                    PERIODO: aluno.getElementsByTagName("PERIODO")[0].textContent,
                    NOME_ATIV_CURRIC: aluno.getElementsByTagName("NOME_ATIV_CURRIC")[0].textContent,
                    MEDIA_FINAL: aluno.getElementsByTagName("MEDIA_FINAL")[0].textContent,
                    FREQUENCIA: aluno.getElementsByTagName("FREQUENCIA")[0].textContent,
                });
            }
        }
    };
    xhr.send();
}

function carregaAluno() {
    grrAtual = document.getElementById("barraPesquisa").value;
    const index = dadosAlunos.findIndex(a => a[0] === grrAtual);

    reiniciaTabela();

    if (index >= 0) {
        for (let dado of dadosAlunos[index]) {
            const coluna = document.getElementById(dado.COD_ATIV_CURRIC);
            if (coluna) {
                coluna.classList = "";
                switch (dado.SIGLA[0]) {
                    case 'A':
                        coluna.classList.add("aprovado");
                        break;
                    case 'R':
                        coluna.classList.add("reprovado");
                        break;
                    case 'E':
                        coluna.classList.add("equivalencia");
                        break;
                    case 'M':
                        coluna.classList.add("matriculado");
                        break;
                }
            }
        }
    }
}

function reiniciaTabela() {
    const tabela = document.getElementById("tblGrade");
    const colunas = tabela.getElementsByTagName("td");

    for (let coluna of colunas) {
        coluna.classList = "";
    }
}

function carregaMateria(event) {
    if (!grrAtual) return;

    let dados;
    if (event.button === 0) {
        dados = ultimaTentativa(event.target.id);
    } else if (event.button === 2) {
        dados = todasTentativas(event.target.id);
    }

    const popup = document.getElementById("popup");
    popup.classList = "";
    popup.innerHTML = `${dados}<div id='fechaPopup'>x</div>`;

    document.getElementById("fechaPopup").addEventListener("click", esconder);
}

function esconder() {
    document.getElementById("popup").classList.add("hidden");
}

function ultimaTentativa(codigo) {
    const index = dadosAlunos.findIndex(a => a[0] === grrAtual);
    const dados = dadosAlunos[index].filter(d => d.COD_ATIV_CURRIC === codigo);

    if (dados.length === 0) return "Disciplina ainda não cursada";

    let ultimo = dados.reduce((prev, curr) => {
        if (curr.ANO > prev.ANO || (curr.ANO === prev.ANO && curr.PERIODO === "2o. Semestre" && prev.PERIODO === "1o. Semestre")) {
            return curr;
        }
        return prev;
    }, dados[0]);

    return `${ultimo.COD_ATIV_CURRIC}/${ultimo.NOME_ATIV_CURRIC}<br><br>${ultimo.ANO}/${ultimo.PERIODO}<br>${ultimo.MEDIA_FINAL}/${ultimo.FREQUENCIA}`;
}

function todasTentativas(codigo) {
    const index = dadosAlunos.findIndex(a => a[0] === grrAtual);
    const dados = dadosAlunos[index].filter(d => d.COD_ATIV_CURRIC === codigo);

    if (dados.length === 0) return "Disciplina ainda não cursada";

    let retorno = `${codigo}/${dados[0].NOME_ATIV_CURRIC}`;
    for (let dado of dados) {
        retorno += `<br><br>${dado.ANO}/${dado.PERIODO}<br>${dado.MEDIA_FINAL}/${dado.FREQUENCIA}`;
    }
    return retorno;
}
