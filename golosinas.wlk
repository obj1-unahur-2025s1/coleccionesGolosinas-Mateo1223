import wollok.vm.*
class Bombon {
  const property precio = 5
  const property gusto = "frutilla"
  const property esLibreDeGluten = true
  var property peso = 15

  method recibirMordisco() {
    peso = ((peso * 0.8) - 1).max(0)
  }

}

class Alfajor {
  const property precio = 12
  const property gusto = "chocolate"
  const property esLibreDeGluten = false
  var property peso = 300

  method recibirMordisco() {
    peso = peso * 0.8
  }
}

class Caramelo {
  const property precio = 1
  const property gusto = "frutilla"
  const property esLibreDeGluten = true
  var property peso = 5

  method recibirMordisco() {
    peso = (peso - 1).max(0)
  }
}

class Chupetin {
  const property precio = 2
  const property gusto = "naranja"
  const property esLibreDeGluten = true
  var property peso = 7

  method recibirMordisco() {
    peso = if (peso > 2){peso - peso * 0.1}
  }
}

class Oblea {
  const property precio = 5
  const property gusto = "vainilla"
  const property esLibreDeGluten = false
  var property peso = 250

  method recibirMordisco() {
    peso = if (peso > 70){peso - peso * 0.5} else {peso - peso * 0.25}
  }
}

class Chocolatin {
  const property precio = 0.50 * pesoInicial
  const property gusto = "chocolate"
  const property esLibreDeGluten = false
  const pesoInicial
  var property peso = pesoInicial

  method recibirMordisco() {
    peso = (peso - 2).max(0)
  }
}

class GolosinaBañada {
  const golosinaBase
  var bañadoDeChocolate = 4


  const property peso = golosinaBase.peso() + bañadoDeChocolate
  const property precio = golosinaBase.precio() + 2
  const property gusto = golosinaBase.gusto()
  const property esLibreDeGluten = golosinaBase.esLibreDeGluten()

  method recibirMordisco() {
    golosinaBase.recibirMordisco()
    bañadoDeChocolate = (bañadoDeChocolate - 2).max(0)
  }
}

class PastillaTuttiFrutti {
  var property peso = 5
  const property esLibreDeGluten
  var property gusto = gustos.get(indice)
  const property precio = if(esLibreDeGluten){7}else {10}

  const gustos = ["frutilla", "chocolate", "naranja"]
  var indice = 0

  method recibirMordisco() {
    if(indice == 2) {indice = 0} else {indice += 1}
  }
}
object mariano {
  var property bolsaDeGolosinas = []

  const golosinasCompradas = []
  const golosinasDesechadas = []

  method cantidadDeGolosinas() = bolsaDeGolosinas.size()
  method tieneLaGolosina(unaGolosina) = bolsaDeGolosinas.any({g => g == unaGolosina})
  method hayGolosinaSinTacc() = bolsaDeGolosinas.any({g => g.esLibreDeGluten()})
  method preciosCuidados() = bolsaDeGolosinas.any({g => g.precio() <= 10})
  method golosinaDeSabor(unSabor) = bolsaDeGolosinas.find({g => g.gusto() == unSabor})
  method golosinasDeSabor(unSabor) = bolsaDeGolosinas.filter({g => g.gusto() == unSabor})
  method sabores() = bolsaDeGolosinas.map({g => g.gusto()}).asSet()
  method golosinaMasCara() = bolsaDeGolosinas.max({g => g.precio()})
  method pesoGolosinas() = bolsaDeGolosinas.sum({g => g.peso()})
  method golosinasFaltantes(golosinasDeseadas) = golosinasDeseadas.asSet().difference(bolsaDeGolosinas.asSet())
  method gustosFaltantes(gustosDeseados) = gustosDeseados.asSet().difference(self.sabores())

  // items desafio

  method gastoEnSabor(sabor) = self.golosinaDeSabor(sabor).sum({g => g.precio()})
  method saborMasPopular() = self.sabores().max({g => self.cantidadDeGolosinasDeSabor(g)})
  method saborMasPesado() = self.bolsaDeGolosinas().max({g => g.peso()}).gusto()
  method comproYDesecho(golosina) = golosinasCompradas.contains(golosina) and golosinasDesechadas.contains(golosina)

  method cantidadDeGolosinasDeSabor(unSabor) = bolsaDeGolosinas.count({g => g.gusto() == unSabor}) 
  

  method comprar(unaGolosina) {
    bolsaDeGolosinas.add(unaGolosina)
    golosinasCompradas.add(unaGolosina)
  }

  method desechar(unaGolosina) {
    bolsaDeGolosinas.remove(unaGolosina)
    golosinasDesechadas.add(unaGolosina)
  }

  method probarGolosinas() {
    bolsaDeGolosinas.forEach({g => g.recibirMordisco()})
  }

}