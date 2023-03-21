local String = require('engine.util.String')

describe('engine.util.String', function ()
 
    it('Replace string in string', function ()

        assert.are.same('Hello Kitty', String.replace('Hello World', 'World', 'Kitty'))
        assert.are.same('local/assets', String.replace('../assets', '..', 'local'))

    end)

end)