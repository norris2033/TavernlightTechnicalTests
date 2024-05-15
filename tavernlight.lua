Funcs = {}

jumpWindow = nil
--selectedSpell = nil
--spells = {}

function init()
  connect(g_game, { onOpenJumpWindow = Funcs.create,
                    onGameEnd = Funcs.destroy })
end

function terminate()
  disconnect(g_game, { onOpenJumpWindow = Funcs.create,
                       onGameEnd = Funcs.destroy })
  Funcs.destroy()
  
  Funcs = nil
end

function Funcs.create()
  Funcs.destroy()

  jumpWindow = g_ui.displayUI('tavernlight.otui')
end

function Funcs.destroy()
  if jumpWindow then
    jumpWindow:destroy()
    jumpWindow = nil
  end
end