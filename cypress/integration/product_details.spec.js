describe('product details page', () => {

  it('can visit the homepage', () => {
    cy.visit('/')
  })

  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });
  it("Can click on a product", () => {
     cy.get(".products article").should("have.length", 2);
     cy.get('.products article img').first().click()
   });
});