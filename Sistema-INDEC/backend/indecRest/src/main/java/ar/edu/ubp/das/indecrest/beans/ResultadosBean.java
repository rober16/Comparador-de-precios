package ar.edu.ubp.das.indecrest.beans;

public class ResultadosBean {
    private String nomSupermercado;
    private String nomProducto;
    private String imagen;
    private Float precio;
    private String codBarra;
    private Integer esMejorPrecio;
    private Float totalXSupermercado;
    private Float superGanador;
    private Float esDesactualizado;

    public String getNomSupermercado() {
        return nomSupermercado;
    }

    public void setNomSupermercado(String nomSupermercado) {
        this.nomSupermercado = nomSupermercado;
    }

    public String getNomProducto() {
        return nomProducto;
    }

    public void setNomProducto(String nomProducto) {
        this.nomProducto = nomProducto;
    }

    public String getImagen() {
        return imagen;
    }

    public void setImagen(String imagen) {
        this.imagen = imagen;
    }

    public Float getPrecio() {
        return precio;
    }

    public void setPrecio(Float precio) {
        this.precio = precio;
    }

    public String getCodBarra() {
        return codBarra;
    }

    public void setCodBarra(String codBarra) {
        this.codBarra = codBarra;
    }

    public Integer getEsMejorPrecio() {
        return esMejorPrecio;
    }

    public void setEsMejorPrecio(Integer esMejorPrecio) {
        this.esMejorPrecio = esMejorPrecio;
    }

    public Float getTotalXSupermercado() {
        return totalXSupermercado;
    }

    public void setTotalXSupermercado(Float totalXSupermercado) {
        this.totalXSupermercado = totalXSupermercado;
    }

    public Float getSuperGanador() {
        return superGanador;
    }

    public void setSuperGanador(Float superGanador) {
        this.superGanador = superGanador;
    }

    public Float getEsDesactualizado() {
        return esDesactualizado;
    }

    public void setEsDesactualizado(Float esDesactualizado) {
        this.esDesactualizado = esDesactualizado;
    }
}
