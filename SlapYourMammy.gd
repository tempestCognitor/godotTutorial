extends Area2D

signal bumpats

export var speed = 400
var screen_size


func start(pos):
    position = pos
    show()
    $CollisionShape2D.disabled = false


# Called when the node enters the scene tree for the first time.
func _ready():
    screen_size = get_viewport_rect().size
    hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    var velocity = Vector2()  # The player's movement vector.'
    velocity.x = int(Input.is_action_pressed("ui_right")) - int(Input.is_action_pressed("ui_left"))
    velocity.y = int(Input.is_action_pressed("ui_down")) - int(Input.is_action_pressed("ui_up")) 
    
    if velocity.length_squared() > 0:
        if velocity.x != 0:
            $AnimatedSprite.play("slappin")
        elif velocity.y != 0:
            $AnimatedSprite.play("mammin")

        if velocity.y != 0:
            $AnimatedSprite.flip_v = velocity.y > 0

        $AnimatedSprite.flip_h = velocity.x < 0
        velocity = velocity.normalized() * speed
    else:
        $AnimatedSprite.stop()

    position += velocity * delta
    position.x = clamp(position.x, 0, screen_size.x)
    position.y = clamp(position.y, 0, screen_size.y)

func _on_SlapYourMammy_body_entered(_body):
    hide()
    emit_signal("bumpats")
    $CollisionShape2D.set_deferred("disabled", true)

