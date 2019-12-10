let but;
let end = 100, st = 0;
let order, Tab = '';
let defTR;
let Search_T = '';
let fsearch;
let searchF = ' ';


function NPage()
{
  st+=100; end+=100;
  get_tab();
}

function PrPage()
{
  if(end>100 || st>0)
    {st-=100; end-=100;}
  get_tab();
}

let OrderCLK = 0;
function TagOrder(elem)
{
  OrderCLK++;
  if(OrderCLK == 2 && order != elem.id)
  {
      end = 100, st = 0;
      OrderCLK = 1;
  }
  order=elem.id;
  if(OrderCLK == 2)
  {
    OrderCLK = 0;
    order=order+'D';
  }
  console.log(order);
  get_tab();
}

function STagTab(elem)
{
  bd_butt.innerHTML = '';
  document.getElementById('out_pulp').innerHTML='';
  defTR='';
  end = 100, st = 0;
  Tab = elem.id;
  let container = document.getElementById('Search');
  container.innerHTML = '';
  searchF = document.createElement('div');
  searchF.innerHTML = `<input class="TSearch" type="text" id="input" onkeyup="TSearch()" class="IcoSearch">`;
  container.append(searchF);
}

function TSearch()
{
  Search_T = document.getElementById('input').value;
  if (Search_T == '')
  {
    let container = document.getElementById('out_pulp');
    container.innerHTML = '';
    fsearch = document.createElement('div');
    fsearch.innerHTML = `<span> Empty search field. Please, input something </span>`;
    container.append(fsearch, document.createElement('br'));
  }
  else if(/[^[0-9]/.test(Search_T))
  {
    let container = document.getElementById('out_pulp');
    container.innerHTML = '';
    let load = document.createElement('div');
    load.innerHTML = `<span> Not valid data </span>`;
    container.append(load, document.createElement('br'));
  }
  else
  {
    switch (Tab)
    {
      case 'FindProd':
        defTR = `<tr>
        <td>BarCode</td>
        <td>Name</td>
        <td>Type</td>
        <td>Department</td>
        <td>Purchase Price</td>
        <td>Sell Price</td>
        <td>Weight</td>
        <td>Volume</td>
        </tr>`;
        order = Search_T;
      break;
      case 'OutBasket':
        defTR = `<tr>
        <td>BarCode</td>
        <td>Count</td>
        <td>Name</td>
        <td>Type</td>
        <td>Department</td>
        <td>Purchase Price</td>
        <td>Sell Price</td>
        <td>Weight</td>
        <td>Volume</td>
        </tr>`;
        order = Search_T;
        Create_S_Butt();
      break;
    }
    get_tab();
  }
}

let bd_butt = document.getElementById('db_b');
function Create_S_Butt()
{
  bd_butt.innerHTML =
      `
      <img title="Add" id="Add"  onclick="Control_DB(this)" src="http://localhost:3000/ResHandler/add/png" class="IcoDB">
      <img title="Delete" id="Del" onclick="Control_DB(this)" src="http://localhost:3000/ResHandler/del/png" class="IcoDB">
      `;
}

function Create_T_Butt()
{
  bd_butt.innerHTML =
      `
      <img title="Add" id="Add"  onclick="Control_DB(this)" src="http://localhost:3000/ResHandler/add/png" class="IcoDB">
      <img title="Delete" id="Del" onclick="Control_DB(this)" src="http://localhost:3000/ResHandler/del/png" class="IcoDB">
      <img title="Update" id="Update" onclick="Control_DB(this)" src="http://localhost:3000/ResHandler/update/png" class="IcoDB">
      `;
}

function TagTab(elem)
{
  Create_T_Butt();
  document.getElementById('out_pulp').innerHTML='';
  defTR='';
  end = 100, st = 0;
  Tab = elem.id;
  switch (Tab)
  {
    case 'SProdOrder':
      defTR = `<tr>
                  <td id="byBar" onClick="TagOrder(this)">BarCode</td>
                  <td id="byNam" onClick="TagOrder(this)">Name</td>
                  <td id="byTyp" onClick="TagOrder(this)">Type</td>
                  <td id="byDep" onClick="TagOrder(this)">Department</td>
                  <td id="byPrP" onClick="TagOrder(this)">Purchase Price</td>
                  <td id="byPrS" onClick="TagOrder(this)">Sell Price</td>
                  <td id="byWei" onClick="TagOrder(this)">Weight</td>
                  <td id="byVol" onClick="TagOrder(this)">Volume</td>
              </tr>`;
        order = 'byNam';
      break;
      case 'SStore':
          defTR = `<tr>
                    <td>Id</td>
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
      case 'SEmpl':
        defTR = `<tr>
                  <td>Id</td>
                  <td>First Name</td>
                  <td>Second Name</td>
                  <td>Father Name</td>
                  <td>Post</td>
                  <td>Sex</td>
                  <td>Age</td>
                  <td>Experience</td>
                  <td>Store</td>
                  <td>Country</td>
                  <td>Department</td>
                 </tr>`;
        order = 'no';
      break;
      case 'SUser':
        defTR = `<tr>
                  <td>Id</td>
                  <td>First Name</td>
                  <td>Second Name</td>
                  <td>Father Name</td>
                  <td>Sex</td>
                  <td>Age</td>
                  <td>Type</td>
                  <td>Sale</td>
                 </tr>`;
        order = 'no';
      break;
  }
  get_tab();
  searchF.remove();
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
        case 'OutBasket': pulp.innerHTML = `<td>${row.Prod_Id}</td><td>${row.Count}</td><td>${row.Prod_Name}</td><td>${row.Prod_Type}</td><td>${row.Depart}</td><td>${row.Price_Purchase}</td><td>${row.Price_Sell}</td><td>${row.Weight}</td><td>${row.Volume}</td>`;
            break;
        case 'SStore': pulp.innerHTML = `<td>${row.Id_Store}</td><td>${row.Name_Store}</td><td>${row.County}</td><td>${row.Town}</td><td>${row.Adress}</td><td>${row.Size}</td><td>${row.Type}</td><td>${row.Workers}</td>`;
            break;
        case 'FindProd': pulp.innerHTML = `<td>${row.Prod_Id}</td><td>${row.Prod_Name}</td><td>${row.Prod_Type}</td><td>${row.Depart}</td><td>${row.Price_Purchase}</td><td>${row.Price_Sell}</td><td>${row.Weight}</td><td>${row.Volume}</td>`;
            break;
        case 'SUser': pulp.innerHTML = `<td>${row.Id_User}</td><td>${row.Name_First}</td><td>${row.Name_Sec}</td><td>${row.Name_Father}</td><td>${row.Sex}</td><td>${row.Age}</td><td>${row.Type_User}</td><td>${row.Sale_Size}</td>`;
            break;
        case 'SEmpl': pulp.innerHTML = `<td>${row.Id_Empl}</td><td>${row.Name_First}</td><td>${row.Name_Sec}</td><td>${row.Name_Father}</td><td>${row.Post}</td><td>${row.Sex}</td><td>${row.Age}</td><td>${row.Exp}</td>`+
                      `<td>${row.Name_Store}</td><td>${row.County}</td><td>${row.Depart}</td>`;
            break;
      }
      table.append(pulp);
    });
    container.append(table);
    but = document.createElement('div');
    but.innerHTML = `<button onclick="PrPage()">Previos</button><button onclick="NPage()">Next</button>`;
    container.append(but, document.createElement('br'));
  });
  sender.remove();
}


const exportLINK = 'http://localhost:3000/export';
function Export(elem)
{
  let LINK = `${exportLINK}/${elem.id}`;
  fetch(LINK).then(res => {checkErrors(res);});
}


/*let xmlclick = 0;
let file;
const importLINK = 'http://localhost:3000/import';
function Import(elem)
{
  if(elem.id=='ImXml')
  {
    let input = document.getElementById('XmlUp')
    xmlclick++;
    if(xmlclick == 1)
    {
      file = '';
      input.click();
      file = input.files[0];
    }
    if(xmlclick == 2) alert(file);
    console.log(file);

    xmlclick = (xmlclick==2) ? 0 : xmlclick;
  }

  //let LINK = `${importLINK}/${elem.id}`;
  //fetch(LINK);
}
*/

const controlLINK = 'http://localhost:3000/control';
let sender = ' ';
function Control_DB(elem)
{
    fun = elem.id;
    let db_c = document.getElementById('db_c');
    sender = document.createElement('center');
    db_c.innerHTML = '';
    let LINK = `${controlLINK}/${fun}/${Tab}`;
    let formPt = `<form onsubmit="submitHandler(this); return false;" action="${LINK}" method="post">`;
    if(Tab == 'SProdOrder')
    {
        if(fun == 'Add' || fun == 'Update')
        {
          sender.innerHTML =
          `${formPt}
              <input class="TSearch" type="text" name="BarCode" placeholder="BarCode" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Name" placeholder="Name" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Type" placeholder="Type" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Depart" placeholder="Department" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Purch" placeholder="Purchase Price" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Sell" placeholder="Sell Price" class="IcoSearch" required>
              <input class="TSearch" type="number" min="1" name="Weight" placeholder="Weight" class="IcoSearch" required>
              <input class="TSearch" type="number" min="1" placeholder="Volume" class="IcoSearch" required>
              <input type="submit" value="Input" />
           </form>`;
        }
        else if(fun == 'Del')
        {
          sender.innerHTML =
          `${formPt}
              <input class="TSearch" type="text" name="BarCode" placeholder="BarCode"class="IcoSearch" required>
              <input type="submit" value="Delete" />
           </form>`;
        }
      }
    if(Tab == 'SEmpl')
    {
        if(fun == 'Add')
        {
          sender.innerHTML =
          `${formPt}
              <input class="TSearch" type="text" name="F_Name" placeholder="First Name" class="IcoSearch" required>
              <input class="TSearch" type="text" name="S_Name" placeholder="Second Name" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Fa_Name" placeholder="Father Name" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Post" placeholder="Post" class="IcoSearch" required>
              <select class="TSearch" name="Sex">
                  <option value="F">Female</option>
                  <option value="M">Male</option>
              </select>
              <input class="TSearch" type="number" name="Age" max="100" min="16" placeholder="Age" class="IcoSearch" required>
              <input class="TSearch" type="number" name="Exp" max="84" min="0" placeholder="Experience" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Store" placeholder="Store" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Country" placeholder="Country" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Depart" placeholder="Department" class="IcoSearch" required>
              <input type="submit" value="Input" />
          </form>`;
      }
      if(fun == 'Update')
      {
        sender.innerHTML =
        `${formPt}
            <input class="TSearch" type="number" min="1" name="ID" placeholder="ID" class="IcoSearch" required>
            <input class="TSearch" type="text" name="F_Name" placeholder="First Name" class="IcoSearch" required>
            <input class="TSearch" type="text" name="S_Name" placeholder="Second Name" class="IcoSearch" required>
            <input class="TSearch" type="text" name="Fa_Name" placeholder="Father Name" class="IcoSearch" required>
            <input class="TSearch" type="text" name="Post" placeholder="Post" class="IcoSearch" required>
            <select class="TSearch" name="Sex">
                <option value="F">Female</option>
                <option value="M">Male</option>
            </select>
            <input class="TSearch" type="number" name="Age" max="100" min="16" placeholder="Age" class="IcoSearch" required>
            <input class="TSearch" type="number" name="Exp" max="84" min="0" placeholder="Experience" class="IcoSearch" required>
            <input class="TSearch" type="text" name="Store" placeholder="Store" class="IcoSearch" required>
            <input class="TSearch" type="text" name="Country" placeholder="Country" class="IcoSearch" required>
            <input class="TSearch" type="text" name="Depart" placeholder="Department" class="IcoSearch" required>
            <input type="submit" value="Input" />
        </form>`;
    }
      else if(fun == 'Del')
      {
          sender.innerHTML =
          `${formPt}
              <input class="TSearch" type="number" min="1" name="Id_Empl" placeholder="Employee ID" class="IcoSearch" required>
              <input type="submit" value="Delete" />
           </form>`;
      }
    }
    if(Tab == 'SStore')
    {
        if(fun == 'Add')
        {
          sender.innerHTML =
          `${formPt}
              <input class="TSearch" type="text" name="Store" placeholder="Store" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Country" placeholder="Country" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Town" placeholder="Town" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Addr" placeholder="Address" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Type" placeholder="Type" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Size" placeholder="Size" class="IcoSearch" required>
              <input type="submit" value="Input" />
          </form>`;
        }
        else if(fun == 'Del')
        {
            sender.innerHTML =
            `${formPt}
            <input class="TSearch" type="text" name="Id_Store" placeholder="ID Store" class="IcoSearch" required>
                <input type="submit" value="Delete" />
             </form>`;
         }
         if(fun == 'Update')
         {
            sender.innerHTML =
            `${formPt}
                <input class="TSearch" type="text" name="Id_Store" placeholder="ID Store" class="IcoSearch" required>
                <input class="TSearch" type="text" name="Store" placeholder="Store" class="IcoSearch" required>
                <input class="TSearch" type="text" name="Country" placeholder="Country" class="IcoSearch" required>
                <input class="TSearch" type="text" name="Town" placeholder="Town" class="IcoSearch" required>
                <input class="TSearch" type="text" name="Addr" placeholder="Address" class="IcoSearch" required>
                <input class="TSearch" type="text" name="Type" placeholder="Type" class="IcoSearch" required>
                <input class="TSearch" type="text" name="Size" placeholder="Size" class="IcoSearch" required>
                <input type="submit" value="Input" />
            </form>`;
         }
    }
    else if(Tab == 'OutBasket')
    {
        if(fun == 'Add')
        {
          sender.innerHTML =
          `${formPt}
              <input class="TSearch" type="number" min="1" name="Id_User" placeholder="Buyer ID" class="IcoSearch" required>
              <input class="TSearch" type="text" name="BarCode" placeholder="BarCode" class="IcoSearch" required>
              <input type="submit" value="Input" />
           </form>`;
           document.getElementsByName('Id_User').value = Search_T;
        }
        else if(fun == 'Del')
        {
          sender.innerHTML =
          `${formPt}
              <input class="TSearch" type="number" min="1" name="Id_User" placeholder="Buyer ID" class="IcoSearch" required>
              <input class="TSearch" type="text" name="BarCode" placeholder="BarCode" class="IcoSearch" required>
              <input type="submit" value="Delete" />
           </form>`;
        }
    }
    else if(Tab == 'SUser')
    {
        if(fun == 'Add')
        {
          sender.innerHTML =
          `${formPt}
              <input class="TSearch" type="text" name="F_Name" placeholder="First Name" class="IcoSearch" required>
              <input class="TSearch" type="text" name="S_Name" placeholder="Second Name" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Fa_Name" placeholder="Father Name" class="IcoSearch" required>
              <select class="TSearch" name="Sex">
                  <option value="F">Female</option>
                  <option value="M">Male</option>
              </select>
              <input class="TSearch" type="number" name="Age" max="100" min="0" placeholder="Age" class="IcoSearch" required>
              <input class="TSearch" type="text" name="User_Type" placeholder="Type" class="IcoSearch" required>
              <input type="submit" value="Input" />
           </form>`;
        }
        else if(fun == 'Del')
        {
          sender.innerHTML =
          `${formPt}
              <input class="TSearch" type="number" min="1" name="Id_User" placeholder="Buyer ID" class="IcoSearch" required>
              <input type="submit" value="Delete" />
           </form>`;
        }
        if(fun == 'Update')
        {
          sender.innerHTML =
          `${formPt}
              <input class="TSearch" type="number" min="1" name="Id_User" placeholder="Buyer ID" class="IcoSearch" required>
              <input class="TSearch" type="text" name="F_Name" placeholder="First Name" class="IcoSearch" required>
              <input class="TSearch" type="text" name="S_Name" placeholder="Second Name" class="IcoSearch" required>
              <input class="TSearch" type="text" name="Fa_Name" placeholder="Father Name" class="IcoSearch" required>
              <select class="TSearch" name="Sex">
                  <option value="F">Female</option>
                  <option value="M">Male</option>
              </select>
              <input class="TSearch" type="number" name="Age" max="100" min="0" placeholder="Age" class="IcoSearch" required>
              <input class="TSearch" type="text" name="User_Type" placeholder="Type" class="IcoSearch" required>
              <input type="submit" value="Input" />
           </form>`;
        }
    }
     db_c.append(sender);
}

function submitHandler(form)
{
    form.submit().then(res => {checkErrors(res);});
  //form.submit().then(res => {checkErrors(res);}); //Problem With Error Catching, not output error in index
}

let SelOpt = '';
const OptLINK = 'http://localhost:3000/api/opt';
function SelOptions(select, sh)//Not working
{
    let opts = '';
    if(sh == ' ')
      sh = 'no';
    let LINK = `${OptLINK}/${select}/${sh}`;
    fetch(LINK).then(res => res.json()).then(res =>
    {
      checkErrors(res);

      res.forEach(row =>
      {
        let rowN;
        for (key in row)
            rowN=(row[key]);
        opts+= `<option value="${rowN}">${rowN}</option>`;
      })
      SelOpt = opts;
      GetOpt(opts);
      return opts;

    });
    return opts;
}

function GetOpt(mess)
{
  console.log('Get: ',mess);
  SelOpt = mess;
}

const importLINK = 'http://localhost:3000/import';
function Import(elem)
{
  let LINK = `${importLINK}/${elem.id}`;
  fetch(LINK).then(res => {checkErrors(res);});
}

function LogOut()
{
    console.log('User LogOut');
    let LINK = 'http://localhost:3000/LogOut';
    fetch(LINK).then(res => {checkErrors(res);});
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
