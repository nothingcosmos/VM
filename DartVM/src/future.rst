Future
###############################################################################

Future and completer
*******************************************************************************

callcahin ::

  Future.complete
    _Future<T>
      _asyncComplete(value)
        _markPendingCompletion();
        _zone.scheduleMicrotask(() {
          _complete(value);
        });
            _propagateToListeners()
              zone.run()


scheduleMicrotask()

class _ZoneSpecification implements ZoneSpecification {
  final scheduleMicrotask
}


zone

rootfork

forEach


zone
===============================================================================

ZoneCallback()
ZoneUnaryCallback()
ZoneBinaryCallback()


===============================================================================
===============================================================================
===============================================================================


===============================================================================

