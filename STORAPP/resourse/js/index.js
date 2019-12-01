let but;
let end = 100, st = 0;
let order, Tab = '';
let defTR;

function NPage()
{
  st+=100; end+=100;
  get_tab();
}

function PrPage(e)
{
  if((st-100)<0 || (end-100)<=0  || (end-100)<=st) //Problem in there
  {st=st; end=end;}
  else
    st-=100; end-=100;
  get_tab();
}

function TagOrder(elem)
{
  order=elem.id;
  get_tab();
}

function TagTab(elem)
{
  defTR='';
  end = 100, st = 0;
  Tab = elem.id;
  switch (Tab)
  {
    case 'SProdOrder':
      defTR = `<tr>
                  <td id="byBar" onClick="TagOrder(this)">BarCode</td>
                  <td id="byName" onClick="TagOrder(this)">Name</td>
                  <td id="byType" onClick="TagOrder(this)">Type</td>
                  <td id="byDepart" onClick="TagOrder(this)">Department</td>
                  <td id="byPr_P" onClick="TagOrder(this)">Purchase Price</td>
                  <td id="byPr_S" onClick="TagOrder(this)">Sell Price</td>
                  <td id="byWeight" onClick="TagOrder(this)">Weight</td>
                  <td id="byVolume" onClick="TagOrder(this)">Volume</td>
              </tr>`;
        order = 'byName';
      break;
      case 'OutBasket':
        break;
      case 'SStore':
          defTR = `<tr>
                    <td>Store</td>
                    <td>Country</td>
                    <td>Town</td>
                    <td>Address</td>
                    <td>Size</td>
                    <td>Type</td>
                    <td>Workers</td>
                   </tr>`;
          order = 'no';
          break;
      case 'SProd':
            break;
      case 'SEmpl':
        defTR = `<tr>
                  <td>First Name</td>
                  <td>Second Name</td>
                  <td>First Name</td>
                  <td>Post</td>
                  <td>Sex</td>
                  <td>Age</td>
                  <td>Experience</td>
                  <td>Store</td>
                  <td>Country</td>
                  <td>Town</td>
                  <td>Address</td>
                 </tr>`;
        order = 'no';
      break;
  }
  get_tab();
}

const prodLINK = 'http://localhost:3000/api';
async function get_tab()
{
  let container = document.getElementById('out_pulp');
  container.innerHTML = '';
  let load = document.createElement('div');
  load.innerHTML = `<span> LOADING... </span>`;
  container.append(load, document.createElement('br'));

  let LINK = `${prodLINK}/${Tab}/${end}/${st}/${order}`;

  fetch(LINK).then(res => res.json()).then(res =>
  {
    checkErrors(res);
    let container = document.getElementById('out_pulp');
    container.innerHTML = '';

    let table = document.createElement('table');
    table.setAttribute('border', 1);
    table.innerHTML = defTR;
    res.forEach(row =>
    {
      load.remove();
      let pulp = document.createElement('tr');
      switch (Tab)
      {
        case 'SProdOrder': pulp.innerHTML = `<td>${row.Prod_Id}</td><td>${row.Prod_Name}</td><td>${row.Prod_Type}</td><td>${row.Depart}</td><td>${row.Price_Purchase}</td><td>${row.Price_Sell}</td><td>${row.Weight}</td><td>${row.Volume}</td>`;
          break;
        case 'OutBasket':
          break;
        case 'SStore': pulp.innerHTML = `<td>${row.Name_Store}</td><td>${row.County}</td><td>${row.Town}</td><td>${row.Adress}</td><td>${row.Size}</td><td>${row.Type}</td><td>${row.Workers}</td>`;
            break;
        case 'SProd':
              break;
        case 'SEmpl': pulp.innerHTML = `<td>${row.Name_First}</td><td>${row.Name_Sec}</td><td>${row.Name_Father}</td><td>${row.Post}</td><td>${row.Sex}</td><td>${row.Age}</td><td>${row.Exp}</td>`+
                      `<td>${row.Name_Store}</td><td>${row.County}</td><td>${row.Town}</td><td>${row.Adress}</td>`;                  break;
      }
      table.append(pulp);
    });
    container.append(table);
    but = document.createElement('div');
    but.innerHTML = `<button onclick="PrPage()">Previos</button><button onclick="NPage()">Next</button>`;
    container.append(but, document.createElement('br'));
  });
  if(n>1)
    but.remove();
}


function checkErrors(res)
{
  if (res.error)
  {
    document.getElementById('errors').innerText = res.error;
    document.getElementById('close-error').style.display = 'block';
  }
}
function closeError()
{
  document.getElementById('errors').innerText = '';
  document.getElementById('close-error').style.display = 'none';
}
