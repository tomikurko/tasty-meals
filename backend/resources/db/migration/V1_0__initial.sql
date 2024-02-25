DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS recipes CASCADE;
DROP TABLE IF EXISTS ingredients CASCADE;
DROP TABLE IF EXISTS steps CASCADE;
DROP TABLE IF EXISTS category_recipes CASCADE;


CREATE TABLE recipes (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE ingredients (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    recipe_id INTEGER NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
    description TEXT NOT NULL
);

CREATE TABLE steps (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    recipe_id INTEGER NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
    description TEXT NOT NULL
);

CREATE TABLE categories (
    id INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name TEXT NOT NULL
);

CREATE TABLE category_recipes (
    recipe_id INTEGER NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
    category_id INTEGER NOT NULL REFERENCES categories(id) ON DELETE CASCADE
);


INSERT INTO categories (name) VALUES ('Pastas');

INSERT INTO recipes (name) VALUES ('Homemade pesto pasta');
INSERT INTO ingredients (recipe_id, description) VALUES (1, '500g    Tagliatelle pasta');
INSERT INTO ingredients (recipe_id, description) VALUES (1, '200g    Frozen peas');
INSERT INTO ingredients (recipe_id, description) VALUES (1, '3    Garlic clove');
INSERT INTO ingredients (recipe_id, description) VALUES (1, '15g    Fresh parsley');
INSERT INTO ingredients (recipe_id, description) VALUES (1, '15g    Fresh basil');
INSERT INTO ingredients (recipe_id, description) VALUES (1, '30g    Parmesan');
INSERT INTO ingredients (recipe_id, description) VALUES (1, '1    Lemon');
INSERT INTO ingredients (recipe_id, description) VALUES (1, '3 tbsp    Extra virgin olive oil');
INSERT INTO ingredients (recipe_id, description) VALUES (1, '1    Gem lettuce');
INSERT INTO steps (recipe_id, description) VALUES (1, '1. Cook the pasta to pack instructions, adding the peas for the last 3 mins. Drain, reserving a mugful of the cooking water.');
INSERT INTO steps (recipe_id, description) VALUES (1, '2. Meanwhile, put the chopped lettuce in a blender with the garlic, herbs, cheese and lemon juice. Blend until combined, then add the olive oil and blitz to a thick pesto. Season to taste.');
INSERT INTO steps (recipe_id, description) VALUES (1, '3. Roughly shred the remaining lettuce.');
INSERT INTO steps (recipe_id, description) VALUES (1, '4. Toss with the cooked pasta and peas, the pesto and a splash of the reserved cooking water to loosen.');
INSERT INTO steps (recipe_id, description) VALUES (1, '5. Serve with more black pepper, the lemon zest and extra cheese, if you like.');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (1, 1);

INSERT INTO recipes (name) VALUES ('Piri piri pasta');
INSERT INTO ingredients (recipe_id, description) VALUES (2, '400g    Rigatoni pasta');
INSERT INTO ingredients (recipe_id, description) VALUES (2, '1 tbsp    Olive oil');
INSERT INTO ingredients (recipe_id, description) VALUES (2, '3    Peppers');
INSERT INTO ingredients (recipe_id, description) VALUES (2, '100g    Piri piri sauce');
INSERT INTO ingredients (recipe_id, description) VALUES (2, '100g    Gouda cheese');
INSERT INTO ingredients (recipe_id, description) VALUES (2, '200g    Chicken breast');
INSERT INTO steps (recipe_id, description) VALUES (2, '1. Bring a large pan of water to the boil and cook the pasta according to packet instructions. Drain, reserving 75ml of the cooking water and return to the pan.');
INSERT INTO steps (recipe_id, description) VALUES (2, '2. Meanwhile, heat the oil in a large frying pan over a high heat.');
INSERT INTO steps (recipe_id, description) VALUES (2, '3. Add the peppers and fry for 5 mins, tossing occasionally, until lightly charred and starting to soften.');
INSERT INTO steps (recipe_id, description) VALUES (2, '4. Reduce the heat to medium and add the Piri Piri sauce, soft cheese, the chicken and pasta cooking water to the pan.');
INSERT INTO steps (recipe_id, description) VALUES (2, '5. Stir for 2-3 mins, allowing the soft cheese to melt, until you have a glossy sauce.');
INSERT INTO steps (recipe_id, description) VALUES (2, '6. Add the sauce to the drained pasta and vigorously mix until evenly coated. Season to taste with freshly ground black pepper and serve immediately.');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (2, 1);

INSERT INTO recipes (name) VALUES ('Tomato chili pasta with shrimp');
INSERT INTO ingredients (recipe_id, description) VALUES (3, '125g    Pasta (e.g. Spaghetti, Linguini)');
INSERT INTO ingredients (recipe_id, description) VALUES (3, '10    Cherry Tomatoes');
INSERT INTO ingredients (recipe_id, description) VALUES (3, '1/4    Medium-sized yellow onion');
INSERT INTO ingredients (recipe_id, description) VALUES (3, '1    Clove of garlic');
INSERT INTO ingredients (recipe_id, description) VALUES (3, '75ml    Cooking cream');
INSERT INTO ingredients (recipe_id, description) VALUES (3, '1    Chili');
INSERT INTO ingredients (recipe_id, description) VALUES (3, '75g    Shrimp');
INSERT INTO ingredients (recipe_id, description) VALUES (3, '1 Tbsp    Pesto Rosso');
INSERT INTO ingredients (recipe_id, description) VALUES (3, 'As much as you want    Parmeggiano or Grana Padano');
INSERT INTO ingredients (recipe_id, description) VALUES (3, '2 Tbsp    Olive Oil');
INSERT INTO ingredients (recipe_id, description) VALUES (3, 'Some    Salt');
INSERT INTO ingredients (recipe_id, description) VALUES (3, 'Some    Pepper');
INSERT INTO steps (recipe_id, description) VALUES (3, 'Above measures are for 1 serving. Simply multiply by the amount of hungry students you want to serve.');
INSERT INTO steps (recipe_id, description) VALUES (3, 'To prepare for a stress-free cooking: If you bought frozen shrimp, put them to thaw roughly an hour before you start cooking. I do this by putting the desired amount in a sieve or strainer and let it stand. If needed, cover it with a plate to protect the shrimp from being stolen by your cats. Finely dice the onion, finely slice the chili, prepare garlic according to personal preferences (I slice it thick and press it with a fork to get the juices out, but you do you), and cut the cherry tomatoes in half. If you bought frozen shrimp, panic now, because you should have put them to thaw an hour ago. In that case, do as instructed above and run some cold-ish water over them to speed up the thawing process.');
INSERT INTO steps (recipe_id, description) VALUES (3, 'In a large pot, bring water to a boil, add salt to taste, and add pasta. Check pasta package for ideal cooking time.');
INSERT INTO steps (recipe_id, description) VALUES (3, 'In the larger pan, heat olive oil and then add the onion followed a minute later by the chili. Reduce heat to medium to avoid burning the ingredients. Now add your cherry tomatoes and let everything simmer (if you have one, add a lid to the pan to steam a bit, but this is not required). Remember to stir every once in a while. When the tomatoes are soft, add the garlic. After a brief moment of frying, add the cream, some pasta water from the pot, and the pesto. Stir well together and let it simmer for whatever time the pasta still needs.');
INSERT INTO steps (recipe_id, description) VALUES (3, 'Heat more olive oil in your other pan or pot (careful: pots usually require less heat!) and briefly fry shrimp from both sides. Usually, frozen shrimp are pre-cooked but do check the package to make sure whether yours are. When they are white in color (which they might have already been) and look lightly fried from both sides, take them out of the pan/pot to avoid overcooking them.');
INSERT INTO steps (recipe_id, description) VALUES (3, 'Strain your pasta when it’s ready and add the strained pasta to your pan of tomato-chili-cream sauce. Stir well and season with salt and pepper to your liking. Serve to a plate and garnish with the shrimp. Add pre-grated cheese on top or freshly grate the cheese over the plate.');
INSERT INTO steps (recipe_id, description) VALUES (3, 'Enjoy!');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (3, 1);


INSERT INTO categories (name) VALUES ('Burritos & Rolls');

INSERT INTO recipes (name) VALUES ('Spicy bean burritos');
INSERT INTO ingredients (recipe_id, description) VALUES (4, '400g    Plum tomatoes');
INSERT INTO ingredients (recipe_id, description) VALUES (4, '400g    Mixed beans');
INSERT INTO ingredients (recipe_id, description) VALUES (4, '1    Avocado');
INSERT INTO ingredients (recipe_id, description) VALUES (4, '50g    Spring onions');
INSERT INTO ingredients (recipe_id, description) VALUES (4, '50g    Low fat youghurt');
INSERT INTO ingredients (recipe_id, description) VALUES (4, '15g    Fresh coriander');
INSERT INTO ingredients (recipe_id, description) VALUES (4, '250g    Rice');
INSERT INTO ingredients (recipe_id, description) VALUES (4, '50g    Cheddar cheese');
INSERT INTO ingredients (recipe_id, description) VALUES (4, '4    Tortillas');
INSERT INTO steps (recipe_id, description) VALUES (4, '1. Tip the plum tomatoes into a small saucepan and gently crush the tomatoes down to a pulp with a fork.');
INSERT INTO steps (recipe_id, description) VALUES (4, '2. Add the mixed beans and bring to a simmer over a low heat. Cook for 15 mins until thickened.');
INSERT INTO steps (recipe_id, description) VALUES (4, '3. Mix the avocado with half the spring onions, 50g yogurt and half the coriander; season.');
INSERT INTO steps (recipe_id, description) VALUES (4, '4. Heat the rice to pack instructions and divide between the wraps.');
INSERT INTO steps (recipe_id, description) VALUES (4, '5. Add the lettuce leaves and avocado mixture, then top with the beans.');
INSERT INTO steps (recipe_id, description) VALUES (4, '6. Spoon over the remaining yogurt and scatter over the cheese, remaining spring onions and coriander. Roll up tightly to serve.');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (4, 2);

INSERT INTO recipes (name) VALUES ('Late-night burritos');
INSERT INTO ingredients (recipe_id, description) VALUES (5, '400g    Ground beef');
INSERT INTO ingredients (recipe_id, description) VALUES (5, '4    Tortillas');
INSERT INTO ingredients (recipe_id, description) VALUES (5, '300g    Rice');
INSERT INTO ingredients (recipe_id, description) VALUES (5, '2    Tomatoes');
INSERT INTO ingredients (recipe_id, description) VALUES (5, '1    Avocado');
INSERT INTO ingredients (recipe_id, description) VALUES (5, '1    Cucumber');
INSERT INTO ingredients (recipe_id, description) VALUES (5, '1 jar    Salsa');
INSERT INTO steps (recipe_id, description) VALUES (5, '1. Start by making a homemade guacamole!');
INSERT INTO steps (recipe_id, description) VALUES (5, '2. Cut all the vegetables into as small pieces as you can');
INSERT INTO steps (recipe_id, description) VALUES (5, '3. Place them in the grounder and ground into a mush');
INSERT INTO steps (recipe_id, description) VALUES (5, '4. Cook the ground beef until completely brown, and spice with pepper and chili');
INSERT INTO steps (recipe_id, description) VALUES (5, '5. Cook the rice for 10 minutes');
INSERT INTO steps (recipe_id, description) VALUES (5, '6. Construct your tortillas by placing a nice amount of each ingredient inside :)');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (5, 2);

INSERT INTO recipes (name) VALUES ('Tuna roll');
INSERT INTO ingredients (recipe_id, description) VALUES (6, '2    Wholemeal roll');
INSERT INTO ingredients (recipe_id, description) VALUES (6, '50g    Tuna');
INSERT INTO ingredients (recipe_id, description) VALUES (6, '1 tbsp    Yoghurt');
INSERT INTO ingredients (recipe_id, description) VALUES (6, '1 tbsp    Mayonnaise');
INSERT INTO ingredients (recipe_id, description) VALUES (6, '1    Cucumber');
INSERT INTO ingredients (recipe_id, description) VALUES (6, '1    Tomato');
INSERT INTO steps (recipe_id, description) VALUES (6, '1. Cut the roll in half');
INSERT INTO steps (recipe_id, description) VALUES (6, '2. Drain the tuna and flake into a small bowl, then stir through the yoghurt, mayo and vegetables');
INSERT INTO steps (recipe_id, description) VALUES (6, '3. Spread the tuna mayo onto the roll');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (6, 2);


INSERT INTO categories (name) VALUES ('Noodles');

INSERT INTO recipes (name) VALUES ('Teryaki meatball noodles');
INSERT INTO ingredients (recipe_id, description) VALUES (7, '1 tbsp    Vegetable oil');
INSERT INTO ingredients (recipe_id, description) VALUES (7, '200g    Teriyakin sauce');
INSERT INTO ingredients (recipe_id, description) VALUES (7, '1    Cucumber');
INSERT INTO ingredients (recipe_id, description) VALUES (7, '1    Lime');
INSERT INTO ingredients (recipe_id, description) VALUES (7, '250g    Egg noodles');
INSERT INTO ingredients (recipe_id, description) VALUES (7, '250g    Frozen broad beans');
INSERT INTO ingredients (recipe_id, description) VALUES (7, '4    Spring onions');
INSERT INTO ingredients (recipe_id, description) VALUES (7, '25g    Cashews');
INSERT INTO steps (recipe_id, description) VALUES (7, '1. Heat the oil in a nonstick frying pan over a medium-high heat and fry the meatballs for 6-8 mins, turning regularly, until golden brown all over. Add the teriyaki sauce and bubble for 2-3 mins until the meatballs are coated and cooked through.');
INSERT INTO steps (recipe_id, description) VALUES (7, '2. Meanwhile, toss the cucumber ribbons in a bowl with the lime juice. Set aside to pickle.');
INSERT INTO steps (recipe_id, description) VALUES (7, '3. Boil the noodles and broad beans in a pan for 2-3 mins until the noodles are tender, then drain well.');
INSERT INTO steps (recipe_id, description) VALUES (7, '4. Divide the noodles and broad beans between 4 bowls. Top with the teriyaki meatballs and sauce, shredded cabbage and pickled cucumber. Scatter with the spring onions and cashews to serve.');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (7, 3);

INSERT INTO recipes (name) VALUES ('Miso noodle pot');
INSERT INTO ingredients (recipe_id, description) VALUES (8, '2    Ginger');
INSERT INTO ingredients (recipe_id, description) VALUES (8, '2 tbsp    Miso paste');
INSERT INTO ingredients (recipe_id, description) VALUES (8, '2 tbsp    Soy sauce');
INSERT INTO ingredients (recipe_id, description) VALUES (8, '200g    Noodles');
INSERT INTO ingredients (recipe_id, description) VALUES (8, '150g    Vegetable stir fry');
INSERT INTO ingredients (recipe_id, description) VALUES (8, '50g    King prawns');
INSERT INTO ingredients (recipe_id, description) VALUES (8, '2    Chili');
INSERT INTO steps (recipe_id, description) VALUES (8, '1. Mix 1 tsp finely grated ginger, 2 tsp miso paste, ½ tsp sesame oil and 1 tsp reduced-salt soy sauce in a large plate.');
INSERT INTO steps (recipe_id, description) VALUES (8, '2. Gently separate 200g straight-to-wok medium noodles with a fork and layer up in the jug with 150g vegetable stir-fry mix.');
INSERT INTO steps (recipe_id, description) VALUES (8, '3. When ready to serve, pour over 200ml boiling water so everything is just covered. Cover with clingfilm and leave for 2-3 mins to infuse.');
INSERT INTO steps (recipe_id, description) VALUES (8, '4. Add 50g cooked and peeled king prawns, if you like, and stir well. Finish with a squeeze of ½ lime and scatter with chopped coriander and red chili.');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (8, 3);

INSERT INTO recipes (name) VALUES ('Custom pot noodles');
INSERT INTO ingredients (recipe_id, description) VALUES (9, 'Noodles of your choice (mama brand is my favorite)');
INSERT INTO ingredients (recipe_id, description) VALUES (9, '1    Tuna can');
INSERT INTO ingredients (recipe_id, description) VALUES (9, '1    Spring onion');
INSERT INTO ingredients (recipe_id, description) VALUES (9, '1    Tomato');
INSERT INTO ingredients (recipe_id, description) VALUES (9, '1 oack    Frozen corn');
INSERT INTO steps (recipe_id, description) VALUES (9, 'This easy dish is super cheap and just right for you.');
INSERT INTO steps (recipe_id, description) VALUES (9, 'All you need to do is cut the vegetables and have them ready. Once the water has boiled put it inside the cup of noodles and wait for them to become soft. Then open the tuna can and put the insides in and same with the vegetables. Now you''re ready.');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (9, 3);


INSERT INTO categories (name) VALUES ('Burgers');

INSERT INTO recipes (name) VALUES ('Smash burgers');
INSERT INTO ingredients (recipe_id, description) VALUES (10, '200g    Minced meat');
INSERT INTO ingredients (recipe_id, description) VALUES (10, '4    Burger buns');
INSERT INTO ingredients (recipe_id, description) VALUES (10, '4 slices    Cheddar cheese');
INSERT INTO ingredients (recipe_id, description) VALUES (10, '1    Onion');
INSERT INTO ingredients (recipe_id, description) VALUES (10, '1    Gem lettuce');
INSERT INTO ingredients (recipe_id, description) VALUES (10, '2    Tomatoes');
INSERT INTO ingredients (recipe_id, description) VALUES (10, '50g    Hamburger sauce');
INSERT INTO ingredients (recipe_id, description) VALUES (10, '50g    Ketchup');
INSERT INTO steps (recipe_id, description) VALUES (10, '1. Place a large, heavy-based frying pan or skillet over a high heat, then cut 4 squares of baking paper to about 15 x 15cm. Next, use your hands to gently divide each of the burgers into two and, using a light touch, form the rough edges into a patty shape (they don’t need to be smooth), to make four burgers.');
INSERT INTO steps (recipe_id, description) VALUES (10, '2. Brush the frying pan with a little oil and, once smoking hot, add two of the burgers. Working quickly, sprinkle half the onion over the burgers, top each with a square of parchment and use a spatula to press down hard on each burger for 1 min, so that the burgers increase in diameter and form a deep, golden crust. Remove the paper and continue to cook for a further 2 mins.');
INSERT INTO steps (recipe_id, description) VALUES (10, '3. Using your spatula, carefully flip the burgers, ensuring that you scrape up the crust from the pan. Lay the cheese slices over the flipped patties and cook for a further 2 mins until just cooked through but still juicy. Remove the burgers from the pan and keep warm. Add the buns to the pan, cut side down, for the final min. Repeat with the remaining burgers and buns.');
INSERT INTO steps (recipe_id, description) VALUES (10, '4. To assemble, spread 1/4 of the burger sauce over the base of each bun. Top with a lettuce leaf, tomato, patty and gherkin before finishing with the bun lid.');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (10, 4);
