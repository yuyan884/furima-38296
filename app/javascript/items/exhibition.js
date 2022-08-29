TAX = 0.1; // 消費税(10%)

function main () {
  charge_calc();
};

function charge_calc (){
  const priceForm = document.getElementById("item-price");
  priceForm.oninput = function () {
    let addTaxPrice = document.getElementById("add-tax-price");
    let profit      = document.getElementById("profit");
    
    addTaxPrice.innerHTML = Math.floor(priceForm.value * TAX);
    profit.innerHTML      = priceForm.value - addTaxPrice.innerHTML;
  };
};

window.addEventListener('load', main);