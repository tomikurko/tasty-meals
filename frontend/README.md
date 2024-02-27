# Device-Agnostic Design Course Project II - cdac0702-f71c-4cfc-a96a-61b2f9462d2e

## Tasty Meals

Tasty Meals is a cross-platform responsive recipe application. It has been
designed to work well with different screen sizes and has a different UI layout
in mobile and desktop use. The mobile layout is used with narrow screen sizes.
The desktop layout is also responsive and the top bar contents changes depending
on the screen width.

Recipes have a name, a list of ingredients, and a list of steps to prepare the
meal. They also have a placeholder for an image, but actual images are not
currently implemented. Recipes can belong to one or more categories, which have
a name and a placeholder for an image. This application does not currently
implement adding, editing, or removing recipes or categories. That is, the
example data is created with database administration tools and cannot be changed
from the UI.


## Implementation

The frontend application is implemented using Dart and Flutter and is served as
a static website from Amazon S3. The application is built to use CanvasKit renderer
for both mobile and desktop browsers.

The backend application is implemented using Clojure and PostgreSQL and it has
an HTTP server with a REST API. The backend services are deployed to a Linux
virtual machine running in the Azure cloud.


## Backend data model

The data is stored in a relational model in an SQL database. The SQL schema is
shown below:

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

The recipe data is stored in three different tables: `recipes`, `ingredients`,
and `steps`. In a document database like the one provided by Firebase this would
rather be modelled so that the ingredients and steps data would be part of the
recipe document.

The categories data is stored in the `categories` table. Each of these tables
has an `id` field as the primary key, and `ingredients` and `steps` have a
reference to the id of `recipes`.

In order to have the links between recipes and categories, i.e. which categories
each recipe belongs to, there is a table called `category_recipes` which
contains the ids of both a recipe and a category which are linked. According to
the specification, each recipe can belong to multiple categories and this data
model supports it. This was not essentially required in the basic requirements,
but it was included in the "passing with merits" set of requirements.

## Backend REST API

The backend serves a REST API which provides access to the recipes stored in the
database. The API is described below:

    - Get a list of all recipe categories

      GET /api/v1/categories

      Returns: a list of JSON objects with fields `id` and `name`

    - Get top three categories with most recipes

      GET /api/v1/top-categories

      Returns: a list of JSON objects with fields `id`, `name`, and `recipe_count`

    - Get a recipe category

      GET /api/v1/category/{id}

      Returns: a JSON object with fields `id` and `name`

    - Get all recipes

      GET /api/v1/recipes

      Returns: a list of Recipe objects, see "Get a recipe"

    - Search recipes based on category

      GET /api/v1/recipes?category={id}

      Returns: a list of Recipe objects, see "Get a recipe"

    - Search recipes based on name

      GET /api/v1/recipes?nameContains={searchString}

      Returns: a list of Recipe objects, see "Get a recipe"

    - Get a recipe

      GET /api/v1/recipe/{id}

      Returns: a JSON object with fields `id`, `name`, `ingredients`, and `steps`.
               Both `ingredients` and `steps` have fields `id` and `description`.

    - Get the latest added recipe

      GET /api/v1/latest-recipe

      Returns: a Recipe object, see "Get a recipe"

    - Get a randomly selected recipe

      GET /api/v1/random-recipe

      Returns: a Recipe object, see "Get a recipe"


## Key challenges

### Navigation and routing

Initially I was wondering how to implement routing and navigation between
different pages because surely there are many possible ways to do it. Especially
the categories page is intriguing because the responsiveness requires a different
kind of UI layout for mobile and desktop. In mobile layout only categories or
recipes are shown at a time whereas in desktop layout both are visible
simultaneously.  I was wondering if it makes sense to change the route when a
category is selected and this turned out to be working quite nicely.

I was also wondering where the Scaffold should be implemented and if there could
be possible performance or other issues if Scaffold is built for each page. (I'm
not yet familiar how Flutter actually optimizes the UI rendering so what happens
if there are no changes in some portions of the view. I wonder if there are
similar mechanisms to how Jetpack Compose optimizes rendering in native Android
development.) It turned out that Scaffold can be built for each page separately,
but the transition animation had to be disabled because the bottom navigation
bar is intended to stay still without any animations when moving between pages.

### GridView behaviour

I had some challenges coming up with a reasonable behaviour for the grid view.
On the other hand, it is nice that the grid elements' size can vary a little
depending on the screen size, but it turns out the variation can be quite big if
you want to make the contents span the whole width of available space. There
are also other interesting phenomena like an element getting smaller when more
elements could fit the row even if there aren't any more elements to be
displayed.

I think another approach could be to keep the elements constant size, but accept
that they don't span the whole width. Then one would have to think what to do
with the extra space, whether to have it at the end of the row or spread it
evenly between the elements.

I was able to come up with a fairly well working configuration, but I'm not
completely happy with it yet. I might improve it if I end up developing this
project further in the future.

### Renderer issue

There was a surprising issue with the html renderer which came to my attention
only after I had implemented the whole application and was trying out the
generation to a static website for the first time. In mobile browser the pages
were flickering when scrolled and in all browsers the shader implemented in
categories and search pages didn't seem to work and the content in that area
became invisible.

Debugging this issue might have been difficult, but luckily I found out soon
that with the CanvasKit renderer the site works perfectly, just the way it
worked when launched from Visual Studio Code during the development. What
remains unclear to me is why this issue exists with the html renderer and if it
is a sign of a performance issue in my code or if it's nothing related to my
code.


## Key learning moments

### Future providers and construction of Widget objects

One thing that I learned by accident is how the Widget objects are constructed
and built when the UI is rendered. It turned out, for example, that when the
browser window is resized, the screen widgets (the ones given for GoRoute) are
rebuilt but not destroyed. However, the widgets inside the screen widgets are
reconstructed. The screen widgets are reconstructed when navigating from screen
to another.

Having future providers constructed in child widgets caused an issue that the
data was re-fetched continuously when the window was resized. This issue was
resolved by moving the future providers to the screen widgets so that the data
gets re-fetched only when navigating between pages.

### Issues with unbounded constraints

I had some struggles with mixing Columns, ListViews, and a
SingleChildScrollView.  This issue with unbounded constraints was luckily dealt
with in the course materials and after a little bit of trial and error I was
able to come up with solutions that work. I think though that it would make
sense to spend some more time studying the Flutter's model of handling widget
sizes and constraints carefully so that I would understand it thoroughly.

### Responsivity

I think it was very nice to learn some methods how to make a UI responsive and I
was positively surprised how easy it can be to implement such solutions.  The
use of ResponsiveWidget as a helper widget is very simple solution and also the
media query can be used quite nicely.


## Dependencies

    dependencies:
      flutter:
        sdk: flutter

      collection: ^1.18.0
      flutter_riverpod: ^2.4.10
      go_router: ^13.2.0
      google_fonts: ^6.1.0
      http: ^1.2.0
