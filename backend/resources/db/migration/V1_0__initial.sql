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


INSERT INTO categories (name) VALUES ('Wraps & Tacos');

INSERT INTO recipes (name) VALUES ('Chicken roll');
INSERT INTO ingredients (recipe_id, description) VALUES (1, 'chicken');
INSERT INTO ingredients (recipe_id, description) VALUES (1, '1 onion');
INSERT INTO steps (recipe_id, description) VALUES (1, '1. Prepare ingredients');
INSERT INTO steps (recipe_id, description) VALUES (1, '2. Enjoy!');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (1, 1);

INSERT INTO recipes (name) VALUES ('Tuna roll');
INSERT INTO ingredients (recipe_id, description) VALUES (2, 'tuna');
INSERT INTO ingredients (recipe_id, description) VALUES (2, '1 onion');
INSERT INTO steps (recipe_id, description) VALUES (2, '1. Prepare ingredients');
INSERT INTO steps (recipe_id, description) VALUES (2, '2. Enjoy!');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (2, 1);

INSERT INTO recipes (name) VALUES ('Salmon roll __ 50% discount!');
INSERT INTO ingredients (recipe_id, description) VALUES (3, 'salmon');
INSERT INTO ingredients (recipe_id, description) VALUES (3, '1 onion');
INSERT INTO steps (recipe_id, description) VALUES (3, '1. Prepare ingredients');
INSERT INTO steps (recipe_id, description) VALUES (3, '2. Enjoy!');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (3, 1);


INSERT INTO categories (name) VALUES ('Burgers');

INSERT INTO recipes (name) VALUES ('Chicken burger');
INSERT INTO ingredients (recipe_id, description) VALUES (4, 'chicken fillet');
INSERT INTO ingredients (recipe_id, description) VALUES (4, '1 red onion');
INSERT INTO steps (recipe_id, description) VALUES (4, '1. Prepare ingredients');
INSERT INTO steps (recipe_id, description) VALUES (4, '2. Enjoy!');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (4, 2);

INSERT INTO recipes (name) VALUES ('Beef burger');
INSERT INTO ingredients (recipe_id, description) VALUES (5, 'beef fillet');
INSERT INTO ingredients (recipe_id, description) VALUES (5, '1 red onion');
INSERT INTO steps (recipe_id, description) VALUES (5, '1. Prepare ingredients');
INSERT INTO steps (recipe_id, description) VALUES (5, '2. Enjoy!');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (5, 2);


INSERT INTO categories (name) VALUES ('Pastas');

INSERT INTO recipes (name) VALUES ('Avocado pasta');
INSERT INTO ingredients (recipe_id, description) VALUES (6, '1 avocado');
INSERT INTO ingredients (recipe_id, description) VALUES (6, '300 g pasta');
INSERT INTO steps (recipe_id, description) VALUES (6, '1. Prepare ingredients');
INSERT INTO steps (recipe_id, description) VALUES (6, '2. Enjoy!');
INSERT INTO category_recipes (recipe_id, category_id) VALUES (6, 3);


INSERT INTO categories (name) VALUES ('Other');
