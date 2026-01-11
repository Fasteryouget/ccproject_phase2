PakaaiShuru() {
    PuraHissa gosht = 2;
    PuraHissa rice = 5;
    ChotaHissa namak = 0.5;
    Nishaan dishName = "Biryani";
    Tay ready = GhalatHai;

    DawatPesh("Cooking started...");

    AgarHalat(gosht > 0) {
        DawatPesh("Add spices!");
        gosht = gosht - 1;
    } 
    Warna {
        DawatPesh("No gosht left!");
    }

    JabTakGhoom(rice > 0) {
        DawatPesh("Mixing...");
        rice = rice - 1;
    }

    lohissalao >> servings;
    ready = SahiHai;
    DawatPesh("Dish Ready!");

    
    @ingredient = 10;
    #cake_price = 1;
    WapasiDe 0;
    
   

}
