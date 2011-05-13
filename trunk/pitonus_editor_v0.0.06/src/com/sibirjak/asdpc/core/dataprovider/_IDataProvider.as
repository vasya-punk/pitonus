package com.sibirjak.asdpc.core.dataprovider {
  public interface IDataProvider {
    function getItemAt(index : uint) : *;
    function get numItems() : uint;
  }
}