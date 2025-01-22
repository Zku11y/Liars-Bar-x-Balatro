1. Idle:
	the cards are in the displayed deck waiting to be picked up or reshuffled into the rest of the deck.
	in this state the cards do a wobble animation (up and down) and the tilt angel of the cards is increased based on the side that they are on (left or right or middle) the closer to the edge of the deck the more the angle increases
	if hovered over the card, a small pop up animation will play, if the mouse is on the card the card tilts based on the mouse position on the card (top bottom left right).
2. Pop-up:
	when the card is clicked, it pops up a small distance and stays still.
3. Drag:
	when the player is holding the mouse by hold clicking, it follows the mouse's movement direction and velocity, such as if the mouse's velocity goes to a direction (left or right) it tilts slightly to that direction based on said velocity.
	if the card is let go in an area where the card does go, it will go back to the last area it was in and retrigger the idle state, else if the card is in a valid area, it will clamp to it then play the idle animation.