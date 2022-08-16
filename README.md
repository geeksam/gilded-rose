# The Gilded Rose <s>Code Kata</s> Refactoring Exercise

This is a Ruby version of the Gilded Rose refactoring exercise, found
[here](http://iamnotmyself.com/2011/02/13/refactor-this-the-gilded-rose-kata/).

[Jim Weirich](https://en.wikipedia.org/wiki/Jim_Weirich) (RIP) was an excellent
programmer and teacher, and from what I've heard, he was a pretty great human
being while he was with us.

One of Jim's gifts to the world was a [Ruby version of the Gilded Rose
exercise](https://github.com/jimweirich/gilded_rose_kata), but it's been
unmaintained since his death.  I've used Jim's code as a starting point,
rewritten the tests, and added this README in an attempt to make it as easy as
possible to download the code and start refactoring.



## Getting Started

This is a refactoring exercise, so you will be starting with a legacy code
base.  If you haven't done this exercise before, see the original description
below for the "rules".

First, you'll need a reasonably recent version of Ruby.  (As of August 2022,
this code runs just fine on 2.7.4.)  Probably the easiest way to get this on
MacOS or Linux is to use a Ruby version manager.  I like
[rbenv](https://github.com/rbenv/rbenv), but
[chruby](https://github.com/postmodern/chruby) and [RVM](https://rvm.io/) also
work, and I hear there's even an [asdf Ruby
plugin](https://github.com/asdf-vm/asdf-ruby).

Assuming that's in place...

1) Start by cloning this git repository and `cd`ing into its directory.
2) If you don't already have Bundler installed, run `gem install bundler`.
3) Run `bundle install`.
4) Run `./run_tests.sh`.
   - You should see output indicating that some specs are marked as "pending",
     and all others are passing.
   - (If you're an experienced RSpec user, note that you can add whatever CLI
     flags you like here, and they'll be passed along to the `rspec`
     executable.  I particularly like `--fail-fast`.)
5) Open `./gilded_rose.rb` and go to town!



## Original Description of the Gilded Rose

> Hi and welcome to team Gilded Rose. As you know, we are a small inn with a
> prime location in a prominent city run by a friendly innkeeper named Allison.
> We also buy and sell only the finest goods. Unfortunately, our goods are
> constantly degrading in quality as they approach their sell by date. We have
> a system in place that updates our inventory for us. It was developed by a
> no-nonsense type named Leeroy, who has moved on to new adventures. Your task
> is to add the new feature to our system so that we can begin selling a new
> category of items. First an introduction to our system:
>
> - All items have a SellIn value which denotes the number of days we have to
>   sell the item
> - All items have a Quality value which denotes how valuable the item is
> - At the end of each day our system lowers both values for every item
>
> Pretty simple, right? Well this is where it gets interesting:
>
> - Once the sell by date has passed, Quality degrades twice as fast
> - The Quality of an item is never negative
> - "Aged Brie" actually increases in Quality the older it gets
> - The Quality of an item is never more than 50
> - "Sulfuras", being a legendary item, never has to be sold or decreases in
>   Quality
> - "Backstage passes", like aged brie, increases in Quality as its SellIn
>   value approaches; Quality increases by 2 when there are 10 days or less and
>   by 3 when there are 5 days or less but Quality drops to 0 after the concert
>
> We have recently signed a supplier of conjured items. This requires an update
> to our system:
>
> - "Conjured" items degrade in Quality twice as fast as normal items
>
> Feel free to make any changes to the UpdateQuality method and add any new
> code as long as everything still works correctly. However, do not alter the
> Item class or Items property as those belong to the goblin in the corner who
> will insta-rage and one-shot you as he doesn't believe in shared code
> ownership (you can make the UpdateQuality method and Items property static if
> you like, we'll cover for you). Your work needs to be completed by Friday,
> February 18, 2011 08:00:00 AM PST.
>
> Just for clarification, an item can never have its Quality increase above 50,
> however "Sulfuras" is a legendary item and as such its Quality is 80 and it
> never alters.



## A Note About Naming Things (AKA "Why is 'code kata' in strikeout?")

I see two reasons that the word "kata" should not be used for this exercise.

The first is that it's technically inaccurate.

From Wikipedia:  "Kata is a Japanese word (型 or 形) meaning 'form'. It refers
to a detailed choreographed pattern of martial arts movements made to be
practised alone."

Because there is no prescribed, choreographed series of steps for you to follow
when solving this problem, <strong>this is not a kata (code or
otherwise).</strong>  If I had to choose a metaphor from martial arts,
"sparring" seems closest -- though that doesn't work particularly well either
unless you're using the "hostile pair partner" constraint from Code Retreat.

But... this is programming.  Why use a martial arts metaphor at all?

Which leads to my second (and, IMO, more important) reason:  the phrase "code
kata" is cultural appropriation.  As of this writing, the original [Twitter
thread](https://twitter.com/jtu/status/1040271741929566209) that brought this
to my attention is unavailable because the account is locked, but there's some
good discussion about it in the comments on this [blog
post](https://dev.to/thejessleigh/getting-started-with-code-katas-1g80).

**TL;DR:**  This is an exercise designed to let you practice refactoring
skills.  Solve it however you like.



